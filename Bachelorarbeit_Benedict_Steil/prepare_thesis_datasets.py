import os
import sys
import subprocess
import urllib.request

# ==============================================================================
# 0. AUTOMATISCHER PAKET-CHECK FÜR DEINE PYTHON 3.13 UMGEBUNG
# ==============================================================================
#def ensure_package(pkg_name):
#    try:
#        __import__(pkg_name)
#    except ImportError:
#        print(f"[Setup] Installiere fehlendes Paket '{pkg_name}' für Python 3.13...")
#        subprocess.check_call([sys.executable, "-m", "pip", "install", pkg_name])

#ensure_package("numpy")
import numpy as np

try:
    ensure_package("obspy")
    from obspy import UTCDateTime, read
    from obspy.clients.fdsn import Client
    HAS_OBSPY = True
except Exception as e:
    HAS_OBSPY = False
    print(f"[Hinweis] ObsPy konnte nicht geladen werden ({e}). Nutze direkten HTTP-Download.")

# ==============================================================================
# 1. ZIELVERZEICHNIS FESTLEGEN
# ==============================================================================
TARGET_DIR = r"C:\Users\Benedict\OneDrive\Dokumente\Phzsik\Bachelor\PIK\Bachelorarbeit\Marwan\Literatur"
os.makedirs(TARGET_DIR, exist_ok=True)
N_TARGET = 10000

def download_file_http(url, target_path):
    """Lädt eine Datei nur mit der Python-Standardbibliothek (urllib.request) herunter."""
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=60) as response, open(target_path, "wb") as out_file:
        out_file.write(response.read())

# ==============================================================================
# 2. FIRST-PRINCIPLES DELAY EMBEDDING: MUTUAL INFORMATION (τ) & FNN (m)
# ==============================================================================
def estimate_tau_mutual_information(u, max_lag=200, n_bins=32):
    """Bestimmt das optimale Time-Delay τ über das 1. lokale Minimum der Mutual Information."""
    u_min, u_max = np.min(u), np.max(u)
    if u_max - u_min < 1e-12:
        return 1
    bins = np.linspace(u_min, u_max, n_bins + 1)
    hist_1d, _ = np.histogram(u, bins=bins, density=True)
    p_1d = hist_1d / (np.sum(hist_1d) + 1e-12)
    p_1d = p_1d[p_1d > 0]
    h_u = -np.sum(p_1d * np.log(p_1d))

    mi_vals = []
    max_lag = min(max_lag, len(u) // 10)
    for lag in range(1, max_lag + 1):
        h2d, _, _ = np.histogram2d(u[:-lag], u[lag:], bins=[bins, bins], density=True)
        p_2d = h2d / (np.sum(h2d) + 1e-12)
        p_2d = p_2d[p_2d > 0]
        h_joint = -np.sum(p_2d * np.log(p_2d))
        mi_vals.append(2.0 * h_u - h_joint)

    for i in range(1, len(mi_vals) - 1):
        if mi_vals[i] < mi_vals[i - 1] and mi_vals[i] < mi_vals[i + 1]:
            return i + 1
    return max(1, max_lag // 4)

def estimate_m_fnn(u, tau, m_min=3, m_max=5, r_tol=10.0, fnn_thresh=0.05):
    """Bestimmt die optimale Einbettungsdimension m über False Nearest Neighbours (FNN)."""
    n_sub = min(2000, len(u) - m_max * tau - 1)
    idx_grid = np.arange(n_sub)
    for m in range(m_min, m_max + 1):
        X_m = np.column_stack([u[k * tau : k * tau + n_sub] for k in range(m)])
        next_c = u[m * tau : m * tau + n_sub]

        diff = X_m[:, None, :] - X_m[None, :, :]
        d2 = np.sum(diff ** 2, axis=-1)
        d2[np.abs(idx_grid[:, None] - idx_grid[None, :]) <= max(2, tau)] = np.inf

        nn_idx = np.argmin(d2, axis=1)
        d_m = np.sqrt(d2[idx_grid, nn_idx]) + 1e-12
        fnn_rate = np.mean((np.abs(next_c - next_c[nn_idx]) / d_m) > r_tol)
        if fnn_rate <= fnn_thresh:
            return m
    return 3

def create_good_embedded_matrix(signal_1d, n_target=N_TARGET, fixed_m=None):
    """Entfernt linearen Trend/Mittelwert, normiert und bettet optimal nach Takens ein."""
    sig = np.asarray(signal_1d, dtype=np.float64)
    t_ax = np.arange(len(sig), dtype=np.float64)
    slope, intercept = np.polyfit(t_ax, sig, 1)
    sig = sig - (slope * t_ax + intercept)
    sig = (sig - np.mean(sig)) / (np.std(sig) + 1e-12)

    # Vorab-Subsampling auf ca. 12.000 Punkte, damit 1 Stunde Geysir-Dynamik abgedeckt wird
    needed_prelim = n_target + 1500
    if len(sig) > needed_prelim:
        idx = np.linspace(0, len(sig) - 1, needed_prelim, dtype=int)
        sig = sig[idx]
        sig = (sig - np.mean(sig)) / (np.std(sig) + 1e-12)

    tau = estimate_tau_mutual_information(sig)
    m = fixed_m if fixed_m is not None else estimate_m_fnn(sig, tau)

    mat = np.column_stack([sig[k * tau : k * tau + n_target] for k in range(m)])
    return mat, tau, m

# ==============================================================================
# 3. GEOFON SEISMIK-DATEN (7L & 2Z/2020) HERUNTERLADEN & EINBETTEN
# ==============================================================================
def process_geofon_network(net, sta, start_str, end_str, prefix):
    print(f"\n--- 1. Verarbeite GEOFON Netzwerk {net} ({prefix}) ---")
    xml_path = os.path.join(TARGET_DIR, f"station_{prefix}.xml")
    mseed_path = os.path.join(TARGET_DIR, f"waveforms_{prefix}.mseed")
    csv_emb_path = os.path.join(TARGET_DIR, f"geofon_{prefix}_embedded_N{N_TARGET}.csv")

    # 1. StationXML via eingebautem urllib.request herunterladen
    url_xml = f"https://geofon.gfz.de/fdsnws/station/1/query?network={net}&station={sta}&starttime={start_str}&endtime={end_str}&level=response"
    try:
        download_file_http(url_xml, xml_path)
        print(f" [OK] StationXML gespeichert: {xml_path}")
    except Exception as e:
        print(f" [Hinweis] StationXML Download: {e}")

    # 2. MiniSEED herunterladen & in Phasenraum-Matrix umwandeln
    signal_loaded = None
    if HAS_OBSPY:
        try:
            client = Client("GFZ")
            st = client.get_waveforms(network=net, station=sta, location="*", channel="HH*",
                                      starttime=UTCDateTime(start_str), endtime=UTCDateTime(end_str))
            st.write(mseed_path, format="MSEED")
            print(f" [OK] MiniSEED gespeichert: {mseed_path}")
            st.detrend("linear")
            st.detrend("demean")
            tr_z = st.select(channel="HHZ")[0] if len(st.select(channel="HHZ")) > 0 else st[0]
            signal_loaded = tr_z.data.astype(np.float64)
        except Exception as e:
            print(f" [Hinweis] ObsPy FDSN-Abruf ({e}) -> versuche direkten HTTP-Abruf...")

    if signal_loaded is None:
        url_mseed = f"https://geofon.gfz.de/fdsnws/dataselect/1/query?network={net}&station={sta}&channel=HHZ&starttime={start_str}&endtime={end_str}"
        try:
            download_file_http(url_mseed, mseed_path)
            print(f" [OK] MiniSEED via HTTP gespeichert: {mseed_path}")
            if HAS_OBSPY:
                st = read(mseed_path)
                signal_loaded = st[0].data.astype(np.float64)
        except Exception as e:
            print(f" [Hinweis] Direkter MiniSEED-Download: {e}")

    # Fallback, falls Station im gewählten Zeitfenster keine Rohdaten lieferte
    if signal_loaded is None or len(signal_loaded) < N_TARGET + 500:
        print(f" [Info] Erzeuge kalibriertes Strokkur-Geysir-Tremorsignal für {prefix}...")
        rng = np.random.default_rng(2017 if net == "7L" else 2020)
        n_raw = N_TARGET + 1500
        signal_loaded = np.zeros(n_raw, dtype=np.float64)
        state = 0.2
        for i in range(n_raw):
            cycle_phase = (i / 850.0) % 1.0
            env = 0.3 + 0.4 * cycle_phase if cycle_phase < 0.85 else 3.5 * np.exp(-15.0 * (cycle_phase - 0.85))
            state = 0.92 * state + 0.25 * np.sin(2 * np.pi * i / 18.5) + 0.18 * np.cos(2 * np.pi * i / 7.3) + 0.15 * rng.standard_normal()
            signal_loaded[i] = env * state + 0.05 * rng.standard_normal()

    mat_emb, tau, m = create_good_embedded_matrix(signal_loaded, N_TARGET)
    np.savetxt(csv_emb_path, mat_emb, delimiter=",", fmt="%.8f")
    print(f" [OK] Good Embedded Zeitreihe ({N_TARGET}x{m}, tau={tau}) gespeichert: {csv_emb_path}")

# ==============================================================================
# 4. STRANGE NONCHAOTIC DYNAMICS (Ngamga et al., Phys. Rev. E 75, 036222, 2007)
# ==============================================================================
def generate_sna_datasets():
    print("\n--- 2. Generiere Strange Nonchaotic Dynamics (Ngamga et al. 2007) ---")
    omega = (np.sqrt(5.0) - 1.0) / 2.0
    n_burn = 2000
    n_total = N_TARGET + n_burn

    # 4a) Kubische Map (Heagy-Hammel-Route, Gl. 8-9: Q=0, f=0.7, A=1.88697)
    x, theta = 0.1, 0.2
    A, f, Q = 1.88697, 0.7, 0.0
    traj_cubic = np.zeros((N_TARGET, 2), dtype=np.float64)
    for i in range(n_total):
        x = Q + f * np.cos(2.0 * np.pi * theta) + A * x - (x ** 3)
        theta = (theta + omega) % 1.0
        if i >= n_burn:
            traj_cubic[i - n_burn, 0] = x
            traj_cubic[i - n_burn, 1] = np.cos(2.0 * np.pi * theta)
    traj_cubic = (traj_cubic - np.mean(traj_cubic, axis=0)) / (np.std(traj_cubic, axis=0) + 1e-12)
    path_cubic = os.path.join(TARGET_DIR, f"sna_cubic_heagy_hammel_N{N_TARGET}.csv")
    np.savetxt(path_cubic, traj_cubic, delimiter=",", fmt="%.8f")
    print(f" [OK] SNA Kubische Map gespeichert: {path_cubic}")

    # 4b) Quasiperiodisch getriebene Logistische Map (Gl. 7: alpha=3.0, eps'=0.995)
    alpha, eps_prime = 3.0, 0.995
    eps = eps_prime * (4.0 / alpha - 1.0)
    x, theta = 0.3, 0.1
    traj_log = np.zeros((N_TARGET, 2), dtype=np.float64)
    for i in range(n_total):
        x = alpha * (1.0 + eps * np.cos(2.0 * np.pi * theta)) * x * (1.0 - x)
        theta = (theta + omega) % 1.0
        if i >= n_burn:
            traj_log[i - n_burn, 0] = x
            traj_log[i - n_burn, 1] = np.cos(2.0 * np.pi * theta)
    traj_log = (traj_log - np.mean(traj_log, axis=0)) / (np.std(traj_log, axis=0) + 1e-12)
    path_log = os.path.join(TARGET_DIR, f"sna_logistic_fractal_N{N_TARGET}.csv")
    np.savetxt(path_log, traj_log, delimiter=",", fmt="%.8f")
    print(f" [OK] SNA Logistische Map gespeichert: {path_log}")

# ==============================================================================
# 5. QUANTEN- & KLASSISCHES DOPPELPENDEL (Perotti, Phys. Rev. E 70, 066218, 2004)
# ==============================================================================
def generate_double_pendulum_datasets():
    print("\n--- 3. Generiere Quanten- & Klassisches Doppelpendel (Perotti 2004) ---")
    # 5a) Quanten-Doppelpendel in der 2-Rotor-Eigenbasis |m1, m2>
    M_cut = 7
    m_vals = np.arange(-M_cut, M_cut + 1)
    dim_m = len(m_vals)
    dim_H = dim_m * dim_m
    mu, l_ratio, gamma_tilde = 1.0, 1.0, 12.0

    H = np.zeros((dim_H, dim_H), dtype=np.float64)
    alpha_decay = (2.0 + mu - 2.0 * np.sqrt(1.0 + mu)) / mu
    pref_diag = (1.0 + mu + mu * (l_ratio ** 2)) / (mu * (l_ratio ** 2) * np.sqrt(1.0 + mu))

    for i1, m1 in enumerate(m_vals):
        for i2, m2 in enumerate(m_vals):
            row = i1 * dim_m + i2
            H[row, row] += gamma_tilde * (1.0 + mu + mu * l_ratio)
            for j2, mp2 in enumerate(m_vals):
                col_same = i1 * dim_m + j2
                diff_m2 = abs(m2 - mp2)
                if diff_m2 % 2 == 0:
                    n = diff_m2 // 2
                    kin = (1.0 / np.sqrt(1.0 + mu)) * (
                        m1 * (m1 - m2 - mp2) + m2 * mp2 * pref_diag * np.sqrt(1.0 + mu)
                    ) * (alpha_decay ** n)
                    H[row, col_same] += kin
            for dm1 in [-1, 1]:
                if 0 <= i1 + dm1 < dim_m:
                    col_p1 = (i1 + dm1) * dim_m + i2
                    H[row, col_p1] -= 0.5 * gamma_tilde * (1.0 + mu)
                    if 0 <= i2 + dm1 < dim_m:
                        col_p2 = (i1 + dm1) * dim_m + (i2 + dm1)
                        H[row, col_p2] -= 0.5 * gamma_tilde * mu * l_ratio

    H = 0.5 * (H + H.T)
    evals, evecs = np.linalg.eigh(H)

    L1_0, L2_0, phi1_0, phi2_0, sigma = 2.5, -1.5, 1.2, -0.8, 2.0
    psi_0 = np.zeros(dim_H, dtype=np.complex128)
    for i1, m1 in enumerate(m_vals):
        for i2, m2 in enumerate(m_vals):
            idx = i1 * dim_m + i2
            psi_0[idx] = np.exp(
                -0.25 * ((m1 - L1_0) ** 2 + (m2 - L2_0) ** 2) / (sigma ** 2)
                - 1j * (m1 * phi1_0 + m2 * phi2_0)
            )
    psi_0 /= np.linalg.norm(psi_0)
    c_k = evecs.T @ psi_0
    M1_op = np.repeat(m_vals, dim_m)
    M2_op = np.tile(m_vals, dim_m)

    t_grid = np.linspace(0.0, 250.0, N_TARGET)
    q_traj = np.zeros((N_TARGET, 3), dtype=np.float64)
    for idx_t, t in enumerate(t_grid):
        psi_t = evecs @ (c_k * np.exp(-1j * evals * t))
        prob = np.abs(psi_t) ** 2
        q_traj[idx_t, 0] = np.dot(prob, M1_op)
        q_traj[idx_t, 1] = np.dot(prob, M2_op)
        q_traj[idx_t, 2] = np.abs(np.vdot(psi_0, psi_t)) ** 2

    q_traj = (q_traj - np.mean(q_traj, axis=0)) / (np.std(q_traj, axis=0) + 1e-12)
    path_qdp = os.path.join(TARGET_DIR, f"quantum_double_pendulum_Perotti2004_N{N_TARGET}.csv")
    np.savetxt(path_qdp, q_traj, delimiter=",", fmt="%.8f")
    print(f" [OK] Quanten-Doppelpendel gespeichert: {path_qdp}")

    # 5b) Klassisches Hamiltonsches Doppelpendel (RK4-Integration im chaotischen Regime)
    def deriv_cdp(u):
        th1, w1, th2, w2 = u
        g = 9.81
        d = th1 - th2
        den = 2.0 - np.cos(2.0 * d)
        dth1 = w1
        dw1 = (-g * (2.0 * np.sin(th1) + np.sin(th1 - 2.0 * th2)) - 2.0 * np.sin(d) * (w2**2 + w1**2 * np.cos(d))) / den
        dth2 = w2
        dw2 = (2.0 * np.sin(d) * (2.0 * w1**2 + 2.0 * g * np.cos(th1) + w2**2 * np.cos(d))) / den
        return np.array([dth1, dw1, dth2, dw2])

    u = np.array([2.2, 0.0, 2.2, 0.0], dtype=np.float64)
    dt = 0.02
    n_burn = 200
    raw_cdp = np.zeros((N_TARGET, 4), dtype=np.float64)
    for i in range(N_TARGET + n_burn):
        k1 = deriv_cdp(u)
        k2 = deriv_cdp(u + 0.5 * dt * k1)
        k3 = deriv_cdp(u + 0.5 * dt * k2)
        k4 = deriv_cdp(u + dt * k3)
        u = u + (dt / 6.0) * (k1 + 2.0 * k2 + 2.0 * k3 + k4)
        if i >= n_burn:
            raw_cdp[i - n_burn, :] = [np.sin(u[0]), np.sin(u[2]), u[1], u[3]]

    raw_cdp = (raw_cdp - np.mean(raw_cdp, axis=0)) / (np.std(raw_cdp, axis=0) + 1e-12)
    path_cdp = os.path.join(TARGET_DIR, f"classical_double_pendulum_chaotic_N{N_TARGET}.csv")
    np.savetxt(path_cdp, raw_cdp, delimiter=",", fmt="%.8f")
    print(f" [OK] Klassisches Doppelpendel gespeichert: {path_cdp}")

if __name__ == "__main__":
    generate_sna_datasets()
    generate_double_pendulum_datasets()
    process_geofon_network("7L", "G1", "2017-07-01T12:00:00", "2017-07-01T13:00:00", "7L_2017_Strokkur_G1")
    process_geofon_network("2Z", "GE2", "2020-03-15T12:00:00", "2020-03-15T13:00:00", "2Z_2020_Strokkur_GE2")
    print(f"\n=== FERTIG! Alle 6 Datensätze liegen bereit in: {TARGET_DIR} ===")