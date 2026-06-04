\itemize{
%
(00 h : 40 min git/Organisatorisches)
%
# 30.05.2026 (start selber coden)
%
# Samplings (basis RPLL w/o combinations of sampling approaches or other optimizations/changes from RPLL-get_hist_diagonal_sampled):
## Sampling 0.0: RPLL - woRP
%
\item Parameter:\\
N (Daten-/Time Series- length) = 10000 \\       
N_trans (transients to be removed) = 100 \\
M (Budget/number of lines (>0) to find(or tol is reached whichever comes first)) = Int(round(0.2 * N)) \\
\epsilon: \epsilon^2 = (0.1 * (maximum(x) - minimum(x)))^2\\
K = 50              # newly calculate all K lines \\
W = 5               # window size for sliding average \\
tol = 1e-3          # relative toleranz \\
min_samples = 500   # minimum number of samples before break/convergence test \\
%
\item Roessler:\\
Function-Parameter:\\
ΔT = 0.2   \\
a = 0.2 \\
u0 = [-6.2668, -1.3413, 0.0166]
\\\\
Messgrößen:\\
Laufzeit (@benchmarked w/o Seed):	\\
Allocations (@benchmarked w/o Seed):	\\
Speicher (@benchmarked w/o Seed): \\
countAll (for-loop 1000 runs - mean and std):  \\
Laufzeit (@benchmarked mit Seed): \\
Allocations (@benchmarked mit Seed): \\
Speicher (@benchmarked mit Seed): \\
countAll (once with Seed):  \\
-\\\\
RQA-Measures:\\
RR (seed): \\
DET (seed): \\
L (seed): \\
ENTR (seed): \\
RR (w/o seed): \\
DET (w/o seed): \\
L (w/o seed): \\
ENTR (w/o seed): \\
%
## Sampling 0.1: RPLL - get_hist_diagonal_sampled
%
\item Parameter:\\
N (Daten-/Time Series- length) = 10000 \\       
N_trans (transients to be removed) = 100 \\
M (Budget/number of lines (>0) to find(or tol is reached whichever comes first)) = Int(round(0.2 * N)) \\
\epsilon: \epsilon^2 = (0.1 * (maximum(x) - minimum(x)))^2\\
K = 50              # newly calculate all K lines \\
W = 5               # window size for sliding average \\
tol = 1e-3          # relative toleranz \\
min_samples = 500   # minimum number of samples before break/convergence test \\
%
\item Roessler:\\
Function-Parameter:\\
ΔT = 0.2   \\
a = 0.2 \\
u0 = [-6.2668, -1.3413, 0.0166]
\\\\
Messgrößen:\\
Laufzeit (@benchmarked w/o Seed):	\\
Allocations (@benchmarked w/o Seed):	\\
Speicher (@benchmarked w/o Seed): \\
countAll (for-loop 1000 runs - mean and std):  \\
Laufzeit (@benchmarked mit Seed): \\
Allocations (@benchmarked mit Seed): \\
Speicher (@benchmarked mit Seed): \\
countAll (once with Seed):  \\
-\\\\
RQA-Measures:\\
RR (seed): \\
DET (seed): \\
L (seed): \\
ENTR (seed): \\
RR (w/o seed): \\
DET (w/o seed): \\
L (w/o seed): \\
ENTR (w/o seed): \\
%
## Sampling 1: memory_sampling (basis RPLL)
%
\item Parameter:\\
N (Daten-/Time Series- length) = 10000 \\       
N_trans (transients to be removed) = 100 \\
M (Budget/number of lines (>0) to find(or tol is reached whichever comes first)) = Int(round(0.2 * N)) \\
\epsilon: \epsilon^2 = (0.1 * (maximum(x) - minimum(x)))^2\\
K = 50              # newly calculate all K lines \\
W = 5               # window size for sliding average \\
tol = 1e-3          # relative toleranz \\
min_samples = 500   # minimum number of samples before break/convergence test \\
%
\item Roessler:\\
Function-Parameter:\\
ΔT = 0.2   \\
a = 0.2 \\
u0 = [-6.2668, -1.3413, 0.0166]
\\\\
Messgrößen:\\
Laufzeit (@benchmarked w/o Seed):	\\
Allocations (@benchmarked w/o Seed):	\\
Speicher (@benchmarked w/o Seed): \\
countAll (for-loop 1000 runs - mean and std):  \\
Laufzeit (@benchmarked mit Seed): \\
Allocations (@benchmarked mit Seed): \\
Speicher (@benchmarked mit Seed): \\
countAll (once with Seed):  \\
-\\\\
RQA-Measures:\\
RR (seed): \\
DET (seed): \\
L (seed): \\
ENTR (seed): \\
RR (w/o seed): \\
DET (w/o seed): \\
L (w/o seed): \\
ENTR (w/o seed): \\
%
# 04.06.2026
## Sampling 2: 
% 
### 02 h : 00 min (seit dem letzten Zeitstempel)
%
# 01.06.2026 
%
## weiter coden und zuvor noch tests von memory sampling durchführen und zuvor noch test parameter klären
%
### 03 h : 28 min (seit dem letzten Zeitstempel)
%
# 04.06.2026
%
## my_tests_big_RP.jl läuft!!!!!!!!!!!!!!!!!jaaaaaaaaaajajjajajaa und schon eine allg struktur gegeben. - nun weitere samplings programmieren und testen
%
\item Protokoll oben wird immer ergänzt und hier wird das schriftliche protokoll/journal fortgeführt
%
###
%
}