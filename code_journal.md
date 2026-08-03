\itemize{
%
(00 h : 40 min git/Organisatorisches)
%
# 30.05.2026 (start selber coden)
%
# Samplings (basis RPLL w/o combinations of sampling approaches or other optimizations/changes from RPLL-get_hist_diagonal_sampled):
## Sampling 0.0: RPLL - woRP
%
# Parameter:\\
N (Daten-/Time Series- length) = 10000 \\       
N_trans (transients to be removed) = 100 \\
M (Budget/number of lines (>0) to find(or tol is reached whichever comes first)) = Int(round(0.2 * N)) \\
\epsilon: \epsilon^2 = (0.1 * (maximum(x) - minimum(x)))^2\\
K = 50              # newly calculate all K lines \\
W = 5               # window size for sliding average \\
tol = 1e-3          # relative toleranz \\
min_samples = 500   # minimum number of samples before break/convergence test \\
%
# Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
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
\item Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
%
## Sampling 1: memory_sampling (basis RPLL - ohne combs)
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
\item Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
%
# 04.06.2026
# 05.06.2026
## Sampling 2: Stratified Sampling (basis RPLL - ohne combs)
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
\item Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
% 
## Sampling 2.1.0: stratified- + memory + importance sampling (RPLL(RPLineLengths) als Basis - 2 combinations in samplings) -  Line following: Only Starting Points (SP) and walking forward
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
\item Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
%
## Sampling 2.1.1: stratified- + memory + importance sampling (RPLL(RPLineLengths) als Basis - 2 combinations in samplings) -  Line following: Line following in both directions (LFboth)
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
\item Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
%
## Sampling 2.1.1: stratified- + memory + importance sampling (RPLL(RPLineLengths) als Basis - 2 combinations in samplings) -  Line following: Only Endpoints (EP) and walking backwards
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
\item Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
%
# 05.06.2026
## Sampling 3: qmc-sobol Sampling (basis RPLL - ohne combs)
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
\item Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
%
## Sampling 3.1: qmc-sobol (buffer) Sampling (basis RPLL - ohne combs)
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
\item Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
%
## Sampling 4: Importance (gewichtetes) Sampling (basis RPLL - ohne combs)
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
\item Function: Roessler\\
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
Differences from woRP:\\
\Delta RR (seed): \\
\Delta DET (seed): \\
\Delta L (seed): \\
\Delta ENTR (seed): \\
\Delta RR (w/o seed): \\
\Delta DET (w/o seed): \\
\Delta L (w/o seed): \\
\Delta ENTR (w/o seed): \\
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
## my_tests_big_RP.jl läuft!!!!!!!!!!!!!!!!!jaaaaaaaaaajajjajajaa und schon eine vorläufige allg struktur gegeben. - nun weitere samplings programmieren und testen
%
\item Protokoll oben wird immer ergänzt und hier wird das schriftliche protokoll/journal fortgeführt
%
\item stratified sampling fast fertig
%
### 03 h : 03 min (seit dem letzten Zeitstempel)
%
# 05.06.2026
%
## Stratified sampling weiter
%
\ stratified samp fertig, auch arschritze gegen norberts
%
### 00 h : 48 min (seit dem letzten Zeitstempel)
%
\ Sampling 3: QMC theorie und verstehen
%
# 08.06.2026
%
## nochmal zurück zu stratified:
%
\item mit seed doch chicken dinner gegen norberts sampling (in geschwindigkeit werte sind durchaus etwas schlechter immer eine kommastelle früher schon abweichung und L einfach etwas weiter weg noch), nur die box länge war asche. welche box länge optimal und dynamisch? (ohne seed wieder verloren auf ganzer linie) - box länge einfach konstant etwas höher gesetzt (3000)
%
\item natürlich nur für roessler system als klumpige diagonale linien mit großen lücken gut und vlt für nichts anderes - bzw für andere systeme völlig andere definitionen viel besser und auch wieder besser als norberts, aber das für roessler beste halt dann wieder gar nicht?!
%
\item RQA ist aber eig v.A. gedacht um genau die Information: Um welches System handelt es sich und um welche art von system durch charakteristische RQA-MEasures herauszufinden. 
Und gerade das soll/will ich am Effizientesten machen 
%
\item also stattdessen allg gut dynamisch machen, auch mit aktivem faktor: z.B. box_length_dyn = total_pairs / (M*k) und k ist als Argument in der Funktion definiert und wird demnach von der Asuführenden Instanz/dem Menschen aktiv gewählt und angepasst, wobei je nach vermutung/erwartung über/an das system (z.B.: erwarte ich schon, dass es ein chaotisches system ist/ist es mit hoher prob ein chaotisches system) ein statistisch geeigneter Wert definiert werden kann (von mir, im laufe der tests mit anderen systemen)
%
\item oder eben das ganze automatisieren mit einem kurzen "mini-sample und dann k in der selben weise wie eben beschrieben definieren nur den aktiven faktor wegnehmen
%
\item beide letzten punkte vereinen mit if k=1.0 = unangerührt von der ausführenden instanz && automatic_k = True then mini_sampling \Rightarrow sieht nach z.B.: periodischem system aus \Rightarrow k=x 
%
\item JA vereinen ist gut, aber nicht ganz so in der Modalität, also: k = nothing und auto_k = True/False und dann in k !== nothing hat der ausführer sleber definiert - oder elseif auto_k, dann ein mini sampling ohne linien verfolgen, aber nur schwarze und weiße punkte finden und dann nur RR berechnen (wegen minimalem aufwand) und dann daraus abschätzen, sofern die ausführende instanz eben nicht selber entscheiden will, und dann wird actual_k definiert - oder else, actual_k gleich 1.0
%
\item für estimate_RR(....num_samples=??)=??\\
pure MC/naives random sampling ohne linienverfolgung
%
\item optimale anzahl an samples für estimate_RR ?? momentan samples = min(2000, max(1, Int(floor(0.1 * total_pairs)))) \Rightarrow allocatiosn deutlich und speicher etwas besser als Norberts ohne seed und identsich mit - zeit bei beiden deutlich schlechter - werte schlechter mit seed - hält mit/bisschen schlechter ohne seed - countAll gewinnt mit seed etwas und verliert ganz knapp ohne seed
%
\ item jetze: Stratified Sampling war noch lange nicht fertig. ist halbwegs im selben bälleparadies wie Norberts, aber nun erst ein Mal keine Ideen mehr für verbesserungen ohne Kombinationen oder andere Aspekte des Codes anzugehen.
%
### 04 h : 01 min (seit dem letzten Zeitstempel)
%
# 09.06.2026
%
## Sampling 3: QMC verstehen
%
\item zunächst Sobol-Sequenz
%
\item noch nicht voll verstanden und bisher qmc-sobol sehr asche
%
### 01 h : 32 min (seit dem letzten Zeitstempel)
%
# 11.06.2026
%
## qmc optimieren
%
\item qmc-sobol ist für das Erste fertig (immer noch asche) und sobol-buffer ist ein reinfall
%
## Sampling 4: Importance (gewichtetes) Sampling
%
\item verstehen und dann schreiben
%
## gesprochen mit Norbert:
%
\item nicht so kleinschrittig - theoretische kriterien überlegen und anhand dieser welches sampling/samplingkombination überhaupt in frage kommt das absolute optimum zu sein und nur diese anwärter auf den Thron implementieren, nicht einfach alle die es gibt oder mir einfallen schreiben, das sit zeitverschwendung!!
%
## Sampling 2.1: Combined: importance stratified memory Sampling
%
\item  i.e.: stratified sampling starten udn zu beginn in jeder box mit wahrscheinlihckeit 1 sampling starten, ?!?das heißt es wird einfach in box eins begonnen udn jedes durchgegangen?!? und immer num_in_box_samplings = (dynamisch) oft pro box samplen, wobei, wenn in einer box kein einziger schwarzer punkt gefunden wurde (durch sampling ein startpunkt oder durch linienverfolgung einer oder mehrere punkte) wird das gespeichert und die boxen sind nummeriert und alle boxen mit einer nummer die einem ganzzahligen vielfachen der nummer der weißen box entspricht wird durch einen festen faktor u<1 niedriger gewichtet in den boxen, mit einer nummer aus der eben beschriebenen menge, gesampled. also nun nicht mehr mit wahrscheinlichkeit 1, aber mit u*1 und mit jedem mal, dass eine box mit einer nummer aus der reihe der ganzzahligen vielfachen der nummer gesampled wird und weiß bleibt, wird für alle boxen mit einer nummer aus dieser reihe die wahrscheinlichkeit, dass in ihnen gesampled wird durch u verringert, also u^(wie oft eine von denen weiß vorgefunden wurde) * 1 - und für jedes mal, dass ein schwarzer punkt auftaucht wird geteilt durch u \Rightarrow prob_for_sampling = u^(anzahl wie oft eine box dieser reihe weiß vorgefunden wurde durch sampling in ihr - anzahl wie oft mindestens ein schwarzer punkt in einer der boxen vorgefunden worden ist durch direktes sampling in ihr oder linienverfolgung)
%
### 03 h : 16 min (seit dem letzten zeitstempel)
%
# 29.06.2026
%
## NAch Gesprächen und viel Zeit erster wirklich ernstzunehmender Samplinganwärter:
%
\item Elemente des RP diagonal zählen - ein RR estimaten mit dynamischer samplinganzahl - demnach die boxgröße mit actual_s bestimmen (optimale werte für RR-estimate wertebereiche sidn ncoh zu bestimmne) - demnach num_of_boxes und demnach box_length= total_pairs/num_boxs - dann pilot sampling durch alle boxs und die boxnummern speichern, welche bei fester anzahl oder kleiner als diese anzahl an rand samplings in der jeweiligen box einen schwarzen punkt geben - dann das richtige sampling mit linienverfolgung nur in den gespeicherten boxs durchführen - welche linienverfolgung am besten?? zunächst nur startpunkte, norberts linienverfolgung (die wirklich im code steht, nicht die er behauptet, dass sie im code steht)
%
\item erste version fertig - performance: gut schneller als Norberts (welche rolle D2 und Dline = zero(T) statt 0.0 und @view bei det_history ??), aber werte auch gut schlechter - was kann ich verbessern noch, für nch schneller und werte die mind so gut sind wie norberts?? weshlab sind die so schelcht??
%
### 02 h : 28 min (seit dem letzten Zeitstempel)
%
# 29.07.2026
%
## Linienverfolgungen ausprobieren
%
\item ich passe view und 0.0 bie D2 und Dline wieder zurück an um alles zu ebnen und sowas alles eben wie von vornehrein gedacht später zu machen
%
\item linienverfolgung LFboth in beide richtungen schreiben: gewichtung der anzahl der linien von einer länge durch die länge um den längen bias rauszurechnen (L_local += 1/cnt), während die anzahl an gefundenen linien weiterhin voll gezählt wird (count += 1). 
%
\item nur endpunkte und dann rückwärts laufen
%
\item Erster Test mit dne beiden neuen linienverfolgungsmethoden und D2 und Dline wieder wie bei norbert (0.0 und ohne @view):  nevermind, mache ich nächstes mal, es ist ein error aufgetreten.
%
### 02 h : 06 min (seit dem letzten Zeitstempel)
%
# 03.08.2026
%
\item Test:
\\
=== PERFORMANCE W/O seed - memory sampling ===
runtime:    36.68 ms
allocations: 125
storage:    6265.43 KiB
countAll: 510747.99 ± 13247.96
RR: 0.08313738743079925 ± 0.0024307376048251328
DET: 0.9984398451550144 ± 0.00018958511521192825
L: 23.775913010562295 ± 0.5295367891269787
ENTR: 3.8370960462267143 ± 0.019449226556019796

=== PERFORMANCE W/O seed - norberts sampling ===
runtime:    17.79 ms
allocations: 93
storage:    161.06 KiB
countAll: 508981.19 ± 13624.45
RR: 0.08346170405788463 ± 0.002368065692188329
DET: 0.9984324316880969 ± 0.00019026251913581047
L: 23.79743510939891 ± 0.5095463725989777
ENTR: 3.8375708402701387 ± 0.01903112667070332

=== PERFORMANCE W/O seed - stratified sampling ===
runtime:    45.53 ms
allocations: 121
storage:    162.37 KiB
countAll: 508339.65 ± 14552.43
RR: 0.08352132938425395 ± 0.002374359282798332
DET: 0.9984360156005381 ± 0.00019311682795635854
L: 23.787896434712408 ± 0.5205739486485724
ENTR: 3.8376923240928553 ± 0.019718244155063812

=== PERFORMANCE W/O seed - sobol sampling ===
runtime:    83.73 ms
allocations: 132
storage:    162.87 KiB
countAll: 522382.0 ± 0.0
RR: 0.08209329040457226 ± 4.16541957306882e-17
DET: 0.9985338507977566 ± 1.1107785528183519e-15
L: 23.97101449275358 ± 4.620838779724344e-14
ENTR: 3.850714183433035 ± 1.777245684509363e-15

=== PERFORMANCE W/O seed - sobol buffer sampling ===
runtime:    60.95 ms
allocations: 135
storage:    4850.44 KiB
countAll: 522382.0 ± 0.0
RR: 0.08209329040457226 ± 4.16541957306882e-17
DET: 0.9985338507977566 ± 1.1107785528183519e-15
L: 23.97101449275358 ± 4.620838779724344e-14
ENTR: 3.850714183433035 ± 1.777245684509363e-15

=== PERFORMANCE W/O seed - importance stratified memory sampling ===
runtime:    26.68 ms
allocations: 110
storage:    178.04 KiB
countAll (korrigiert): 595881.95 ± 14778.87
RR: 0.07560430935144657 ± 0.002220840655397396
DET: 0.9985782246424857 ± 0.00017144185870485458
L: 25.001862027440023 ± 0.535396756461837
ENTR: 3.8550215284719087 ± 0.019847240849943878

=== PERFORMANCE W/O seed - importance stratified memory sampling EP ===
runtime:    26.38 ms
allocations: 130
storage:    178.95 KiB
countAll (korrigiert): 595770.36 ± 17401.49
RR: 0.07556420082517518 ± 0.002229666127932551
DET: 0.9985766732045939 ± 0.00017643632288500403
L: 25.001188768038997 ± 0.5382948083474337
ENTR: 3.8549768560722573 ± 0.019512104526573672

=== PERFORMANCE W/O seed - importance stratified memory sampling LFBOTH ===
runtime:    3.54 ms
allocations: 120
storage:    100.5 KiB
countAll (korrigiert): 24671.32 ± 516.26
RR: 1.2655527529430253 ± 22.742232447540594
DET: 0.9589945000000002 ± 0.00442326633100869
L: 19.838006906062407 ± 0.4381500876898707
ENTR: 2.546677789606862 ± 0.09257762479592957

=== PERFORMANCE WITH seed - memory sampling ===
runtime:    61.73 ms
allocations: 125
storage:    6265.41 KiB
countAll:    521396
RR: 0.08256026552902358
DET: 0.9984289249973098
L: 24.074727555786197
ENTR: 3.8639004844346436

=== PERFORMANCE WITH seed - norberts sampling ===
runtime:    37.88 ms
allocations: 121
storage:    162.36 KiB
countAll:    519978
RR: 0.08339741672718987
DET: 0.9984418356456777
L: 24.274519979242346
ENTR: 3.8683954386281174

=== PERFORMANCE WITH seed - stratified sampling ===
runtime:    39.32 ms
allocations: 121
storage:    162.36 KiB
countAll:    504752
RR: 0.08751040161170236
DET: 0.9989156500886247
L: 24.590862422997947
ENTR: 3.8509748299682673

=== PERFORMANCE WITH seed - importance stratified memory sampling ===
runtime:    25.98 ms
allocations: 130
storage:    178.95 KiB
countAll (korrigiert):    595449
RR: 0.07663604019236032
DET: 0.9987551782543926
L: 25.240845796802475
ENTR: 3.87017269561499

=== PERFORMANCE WITH seed - importance stratified memory sampling EP ===
runtime:    26.98 ms
allocations: 130
storage:    178.93 KiB
countAll (korrigiert):    622976
RR: 0.07297521851023114
DET: 0.9986025195750016
L: 25.150621118012424
ENTR: 3.8658099402424124

=== PERFORMANCE WITH seed - importance stratified memory sampling LFBOTH ===
runtime:    3.68 ms
allocations: 128
storage:    100.75 KiB
countAll (korrigiert):    25699
RR: -0.7751937984496122
DET: 0.9555
L: 20.07128088980896
ENTR: 2.4688132502401445

=== PERFORMANCE - woRP (BASELINE) ===
runtime:    638.22 ms
allocations: 3
storage:    78.19 KiB
countAll: -   
RR: 0.08277577808439872
DET: 0.9984392508670275
L: 23.776464002619335
ENTR: 3.864856330212997
\\
EP und SP nimmt sich nichts und was ist bie LFboth los, turbo schenll angeblihc, aber die werte sind quasi nonsens?!
%
\item LFboth evaluieren und korrigieren und optimieren:
\\
rqa ergänzt, weil RR angepasst werden musste ( 
    if eltype(P) <: AbstractFloat
    
        RR = sum((1:length(P)) .* P) / N
        
    else    
        # Recurrence Rate: ratio of recurrent points to total points
        # Numerator:   total number of points in all lines (length * count)
        # Denominator: total matrix points = N (isolated) + points in lines of length > 1
        RR = sum((1:length(P)) .* P) / (N + sum(idx .* (P[idx] .- 1)))
    end
    
 )
%
\item erneuter testlauf:
=== PERFORMANCE W/O seed - memory sampling ===
runtime:    31.49 ms
allocations: 73
storage:    6263.0 KiB
countAll: 510747.99 ± 13247.96
RR: 0.08313738743079925 ± 0.0024307376048251328
DET: 0.9984398451550144 ± 0.00018958511521192825
L: 23.775913010562295 ± 0.5295367891269787
ENTR: 3.8370960462267143 ± 0.019449226556019796

=== PERFORMANCE W/O seed - norberts sampling ===
runtime:    14.68 ms
allocations: 121
storage:    162.36 KiB
countAll: 508981.19 ± 13624.45
RR: 0.08346170405788463 ± 0.002368065692188329
DET: 0.9984324316880969 ± 0.00019026251913581047
L: 23.79743510939891 ± 0.5095463725989777
ENTR: 3.8375708402701387 ± 0.01903112667070332

=== PERFORMANCE W/O seed - stratified sampling ===
runtime:    16.4 ms
allocations: 61
storage:    159.62 KiB
countAll: 508339.65 ± 14552.43
RR: 0.08352132938425395 ± 0.002374359282798332
DET: 0.9984360156005381 ± 0.00019311682795635854
L: 23.787896434712408 ± 0.5205739486485724
ENTR: 3.8376923240928553 ± 0.019718244155063812

=== PERFORMANCE W/O seed - sobol sampling ===
runtime:    43.2 ms
allocations: 132
storage:    162.87 KiB
countAll: 522382.0 ± 0.0
RR: 0.08209329040457226 ± 4.16541957306882e-17
DET: 0.9985338507977566 ± 1.1107785528183519e-15
L: 23.97101449275358 ± 4.620838779724344e-14
ENTR: 3.850714183433035 ± 1.777245684509363e-15

=== PERFORMANCE W/O seed - sobol buffer sampling ===
runtime:    26.36 ms
allocations: 135
storage:    4850.46 KiB
countAll: 522382.0 ± 0.0
RR: 0.08209329040457226 ± 4.16541957306882e-17
DET: 0.9985338507977566 ± 1.1107785528183519e-15
L: 23.97101449275358 ± 4.620838779724344e-14
ENTR: 3.850714183433035 ± 1.777245684509363e-15

=== PERFORMANCE W/O seed - importance stratified memory sampling ===
runtime:    11.51 ms
allocations: 66
storage:    176.03 KiB
countAll (korrigiert): 595881.95 ± 14778.87
RR: 0.07560430935144657 ± 0.002220840655397396
DET: 0.9985782246424857 ± 0.00017144185870485458
L: 25.001862027440023 ± 0.535396756461837
ENTR: 3.8550215284719087 ± 0.019847240849943878

=== PERFORMANCE W/O seed - importance stratified memory sampling EP ===
runtime:    13.05 ms
allocations: 94
storage:    177.28 KiB
countAll (korrigiert): 595770.36 ± 17401.49
RR: 0.07556420082517518 ± 0.002229666127932551
DET: 0.9985766732045939 ± 0.00017643632288500403
L: 25.001188768038997 ± 0.5382948083474337
ENTR: 3.8549768560722573 ± 0.019512104526573672

=== PERFORMANCE W/O seed - importance stratified memory sampling LFBOTH ===
runtime:    1.5 ms
allocations: 116
storage:    100.22 KiB
countAll (korrigiert): 24671.32 ± 516.26
RR: 0.08110123885814167 ± 0.0016962696328666669
DET: 0.9589945000000002 ± 0.00442326633100869
L: 19.838006906062407 ± 0.4381500876898707
ENTR: 2.546677789606862 ± 0.09257762479592957

=== PERFORMANCE WITH seed - memory sampling ===
runtime:    30.15 ms
allocations: 125
storage:    6265.41 KiB
countAll:    521396
RR: 0.08256026552902358
DET: 0.9984289249973098
L: 24.074727555786197
ENTR: 3.8639004844346436

=== PERFORMANCE WITH seed - norberts sampling ===
runtime:    13.18 ms
allocations: 121
storage:    162.37 KiB
countAll:    519978
RR: 0.08339741672718987
DET: 0.9984418356456777
L: 24.274519979242346
ENTR: 3.8683954386281174

=== PERFORMANCE WITH seed - stratified sampling ===
runtime:    14.97 ms
allocations: 121
storage:    162.37 KiB
countAll:    504752
RR: 0.08751040161170236
DET: 0.9989156500886247
L: 24.590862422997947
ENTR: 3.8509748299682673

=== PERFORMANCE WITH seed - importance stratified memory sampling ===
runtime:    10.42 ms
allocations: 130
storage:    178.93 KiB
countAll (korrigiert):    595449
RR: 0.07663604019236032
DET: 0.9987551782543926
L: 25.240845796802475
ENTR: 3.87017269561499

=== PERFORMANCE WITH seed - importance stratified memory sampling EP ===
runtime:    10.53 ms
allocations: 130
storage:    178.93 KiB
countAll (korrigiert):    622976
RR: 0.07297521851023114
DET: 0.9986025195750016
L: 25.150621118012424
ENTR: 3.8658099402424124

=== PERFORMANCE WITH seed - importance stratified memory sampling LFBOTH ===
runtime:    1.38 ms
allocations: 128
storage:    100.75 KiB
countAll (korrigiert):    25699
RR: 0.07782403984590838
DET: 0.9555
L: 20.07128088980896
ENTR: 2.4688132502401445

=== PERFORMANCE - woRP (BASELINE) ===
runtime:    308.55 ms
allocations: 3
storage:    78.19 KiB
countAll: -   
RR: 0.08277577808439872
DET: 0.9984392508670275
L: 23.776464002619335
ENTR: 3.864856330212997
%
## noch ein anwärter?:
%
\item keine ahnung, erst ein mal nichts gefunden mit gemini
%
## optimieren und an anderen systemen als roessler testen
%
\item testlauf für roessler mit M = Int(round(0.5 * N))  # number of random subsamples:
\\
=== PERFORMANCE W/O seed - memory sampling ===
runtime:    51.54 ms
allocations: 65
storage:    6262.63 KiB
countAll: 1.19973938e6 ± 165972.34
RR: 0.0822798932723052 ± 0.001590745223017144
DET: 0.9984379566624692 ± 0.00012097893914704604
L: 23.773931791770302 ± 0.3415837430988134
ENTR: 3.8514648775662 ± 0.012653036822333385

=== PERFORMANCE W/O seed - norberts sampling ===
runtime:    26.22 ms
allocations: 143
storage:    165.65 KiB
countAll: 1.17315267e6 ± 178379.19
RR: 0.08314392728298393 ± 0.001608994996796279
DET: 0.9984362253041863 ± 0.00012650170208040044
L: 23.78093395948577 ± 0.34287061242688577
ENTR: 3.851156909903661 ± 0.013511066332699603

=== PERFORMANCE W/O seed - stratified sampling ===
runtime:    24.19 ms
allocations: 139
storage:    165.47 KiB
countAll: 1.17785571e6 ± 172544.28
RR: 0.0831424947310315 ± 0.0016113638382863433
DET: 0.9984410858352416 ± 0.0001268060985882064
L: 23.77421964995803 ± 0.3423070324777181
ENTR: 3.851210739804272 ± 0.013467731080494101

=== PERFORMANCE W/O seed - sobol sampling ===
runtime:    103.44 ms
allocations: 374
storage:    176.4 KiB
countAll: 1.30265e6 ± 0.0
RR: 0.08133558067971147 ± 9.719312337160578e-17
DET: 0.9984856001462176 ± 3.332335658455056e-16
L: 23.771860754247864 ± 3.9099405059205985e-14
ENTR: 3.8607835599898426 ± 1.777245684509363e-15

=== PERFORMANCE W/O seed - sobol buffer sampling ===
runtime:    121.84 ms
allocations: 377
storage:    4863.96 KiB
countAll: 1.30265e6 ± 0.0
RR: 0.08133558067971147 ± 9.719312337160578e-17
DET: 0.9984856001462176 ± 3.332335658455056e-16
L: 23.771860754247864 ± 3.9099405059205985e-14
ENTR: 3.8607835599898426 ± 1.777245684509363e-15

=== PERFORMANCE W/O seed - importance stratified memory sampling ===
runtime:    15.97 ms
allocations: 68
storage:    200.13 KiB
countAll (korrigiert): 1.36197166e6 ± 196912.23
RR: 0.0768510520250069 ± 0.001522908871578079
DET: 0.9986076207049568 ± 0.00011865449529271443
L: 25.214155778186278 ± 0.3703459871210175
ENTR: 3.873146514977893 ± 0.014252579410526925

=== PERFORMANCE W/O seed - importance stratified memory sampling EP ===
runtime:    15.75 ms
allocations: 166
storage:    206.89 KiB
countAll (korrigiert): 1.35045009e6 ± 211323.88
RR: 0.07688477306220177 ± 0.0015194408827975958
DET: 0.9986100324863278 ± 0.00011560117109621609
L: 25.216926838202962 ± 0.3656880131462599
ENTR: 3.8729143037828178 ± 0.014372822087183807

=== PERFORMANCE W/O seed - importance stratified memory sampling LFBOTH ===
runtime:    2.13 ms
allocations: 122
storage:    124.53 KiB
countAll (korrigiert): 57822.14 ± 5780.47
RR: 0.08279893893817165 ± 0.0010588513988241232
DET: 0.9594252377803338 ± 0.002737063557152113
L: 19.90218114935681 ± 0.28649493625934075
ENTR: 2.561521443577689 ± 0.05820324298871052

=== PERFORMANCE WITH seed - memory sampling ===
runtime:    44.58 ms
allocations: 291
storage:    6275.38 KiB
countAll:    1048933
RR: 0.08300419231739596
DET: 0.9984325686810277
L: 24.1604305484367
ENTR: 3.8673834229780755

=== PERFORMANCE WITH seed - norberts sampling ===
runtime:    23.06 ms
allocations: 363
storage:    175.9 KiB
countAll:    1274740
RR: 0.08469900577073164
DET: 0.998474206416857
L: 24.29724123625804
ENTR: 3.8784844361582222

=== PERFORMANCE WITH seed - stratified sampling ===
runtime:    27.7 ms
allocations: 363
storage:    175.9 KiB
countAll:    1281861
RR: 0.08339723499257255
DET: 0.9983368377511979
L: 24.10047846889952
ENTR: 3.854128101817346

=== PERFORMANCE WITH seed - importance stratified memory sampling ===
runtime:    25.06 ms
allocations: 374
storage:    216.58 KiB
countAll (korrigiert):    1454851
RR: 0.07854589296945222
DET: 0.998670870174813
L: 25.48076923076923
ENTR: 3.8687460182024296

=== PERFORMANCE WITH seed - importance stratified memory sampling EP ===
runtime:    24.57 ms
allocations: 374
storage:    216.58 KiB
countAll (korrigiert):    1486916
RR: 0.07690955458323645
DET: 0.9986464251845968
L: 25.49348230912477
ENTR: 3.8840130854414885

=== PERFORMANCE WITH seed - importance stratified memory sampling LFBOTH ===
runtime:    2.66 ms
allocations: 268
storage:    133.51 KiB
countAll (korrigiert):    44625
RR: 0.08291316526610641
DET: 0.9594594594594594
L: 20.50701948402416
ENTR: 2.5554746023506683

=== PERFORMANCE - woRP (BASELINE) ===
runtime:    306.7 ms
allocations: 3
storage:    78.19 KiB
countAll: -   
RR: 0.08277577808439872
DET: 0.9984392508670275
L: 23.776464002619335
ENTR: 3.864856330212997
%
\item LFboth optimieren: 
\\

}