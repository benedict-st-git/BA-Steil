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
WIE?? was ist falsch oder kannbesser gemahct werden??:
\\
%
### 02 h : 33 min (seit dem letzten Zeitstempel)
%
# 04.08.2026
%
\item LFboth optimieren: 
\\
WIE?? was ist falsch oder kannbesser gemahct werden??:
\\
die lineinverfolgungen in dei beiden richtungen müssen in getrennten for schleifen laufen und mit untershciedlichem offset und die estiamted tries per box wurden dynamishc an die estimated RR angepasst wie auch die box_länge schon daran angepasst ist über actual_s und box_length_dyn....
%
\item weshalb box_length_dyn = total_pairs/ (M*actual_s)? also wehslab das M darin??
\\
was ist mit ENTR (entropy) (gemini meinte irwas ist arsch bei LFboth, dass ENTR arsch wird)??
%
\item Testlauf nach genannten optimierungen:
\\
=== PERFORMANCE W/O seed - norberts sampling ===
runtime:    14.86 ms
allocations: 117
storage:    162.23 KiB
countAll: 508789.46 ± 14643.83
RR: 0.08345950156752302 ± 0.002470348240857121
DET: 0.998439484647239 ± 0.00019396944051074558
L: 23.791081219441814 ± 0.5330924303842874
ENTR: 3.837006987172724 ± 0.0199397466991992

=== PERFORMANCE W/O seed - importance stratified memory sampling ===
runtime:    17.28 ms
allocations: 102
storage:    177.67 KiB
countAll (korrigiert): 595450.75 ± 16822.41
RR: 0.07562804998852563 ± 0.0022028867416207065
DET: 0.9985841426170942 ± 0.0001678018088461515
L: 25.002871252274517 ± 0.5322139239191341
ENTR: 3.8562338874819684 ± 0.01902930483914499

=== PERFORMANCE W/O seed - importance stratified memory sampling EP ===
runtime:    11.44 ms
allocations: 70
storage:    176.21 KiB
countAll (korrigiert): 595156.52 ± 15850.59
RR: 0.07569874046837666 ± 0.0022633845983954506
DET: 0.998580136025936 ± 0.00017435171466362372
L: 25.010691926005563 ± 0.5403094949089446
ENTR: 3.8557301812276226 ± 0.019576919481718833

=== PERFORMANCE W/O seed - importance stratified memory sampling LFBOTH ===
runtime:    2.16 ms
allocations: 44
storage:    96.88 KiB
countAll (korrigiert): 22930.32 ± 456.66
RR: 0.08725085533483934 ± 0.0017372959546562258
DET: 0.9985759473684214 ± 0.0008434414794538696
L: 24.47986737113914 ± 0.613730870631658
ENTR: 3.847109940182904 ± 0.023023583594190385

=== PERFORMANCE WITH seed - norberts sampling ===
runtime:    17.48 ms
allocations: 121
storage:    162.37 KiB
countAll:    519978
RR: 0.08339741672718987
DET: 0.9984418356456777
L: 24.274519979242346
ENTR: 3.8683954386281174

=== PERFORMANCE WITH seed - importance stratified memory sampling ===
runtime:    12.48 ms
allocations: 130
storage:    178.93 KiB
countAll (korrigiert):    595449
RR: 0.07663604019236032
DET: 0.9987551782543926
L: 25.240845796802475
ENTR: 3.87017269561499

=== PERFORMANCE WITH seed - importance stratified memory sampling EP ===
runtime:    12.01 ms
allocations: 130
storage:    178.93 KiB
countAll (korrigiert):    622976
RR: 0.07297521851023114
DET: 0.9986025195750016
L: 25.150621118012424
ENTR: 3.8658099402424124

=== PERFORMANCE WITH seed - importance stratified memory sampling LFBOTH ===
runtime:    1.91 ms
allocations: 128
storage:    100.75 KiB
countAll (korrigiert):    22426
RR: 0.08918219923303311
DET: 0.9994999999999998
L: 23.838945931398303
ENTR: 3.8320473607612078
%
\item weshalb box_length_dyn = total_pairs/ (M*actual_s)? also wehslab das M darin??\\
Gemini:\\
Ergebnis und algorithmische Einschätzung: Das Binden der Box-Größe an $M$ erzwingt ein konstantes Speicher- und Laufzeitbudget; eine reine Koppelung an $RR$ führt bei extremen Matrixgrößen zu exponentiellem Overhead. Algorithmisch ist dein LFBOTH-Ansatz mit 1.91 ms (Faktor ~160 Speedup) das absolute Hardware-Limit für CPU-basiertes Sampling in Julia. Es gibt keinen etablierten Ansatz aus der Literatur, der diese Methode auf einer CPU signifikant schlägt, ohne die Topologie (und damit DET und ENTR) zu zerstören.1. Warum die Box-Anzahl an $M$ binden?Die Koppelung von $M$ und $s$ fungiert als dynamischer Skalierungsfaktor für die Rasterauflösung. Der Initialisierungsaufwand und die Speichernutzung sind bereits auf das theoretische Minimum reduziert.Die Konsequenz einer reinen $RR$-Bindung:Du entkoppelst das Suchnetz von deinem Arbeitsauftrag ($M$).Bei einer riesigen Matrix ($N = 20000$) würde ein reiner $RR$-Faktor zehntausende Boxen generieren. Die Speicherallokation explodiert und die Suchzeit nach "aktiven" Boxen dauert länger als das eigentliche Line-Tracing.Bei einem gigantischen $M$ und kleinem $RR$ hättest du zu wenige Boxen. Du übersampelst winzige Regionen massiv, das Stratified-Prinzip kollabiert und die Repräsentativität geht verloren.Das Produkt $M \times s$ garantiert hingegen eine $\mathcal{O}(M)$ Komplexität für den strukturellen Aufbau. Das Suchraster skaliert perfekt mit der Menge der gesuchten Informationen, nicht mit dem leeren Raum der Matrix.
\\
was ist mit ENTR (entropy) (gemini meinte irwas ist arsch bei LFboth, dass ENTR arsch wird)??
%
## doch noch ein anwärter?:
%
\item gibt noch einige ansätze die mir aber erst ein Mal zu crazy sind, also schriebe ich erstmal noch weitere systeme und optimire noch weiter an LFboth und teste:\\
## weitere systeme: 
%
\item Gemini:
\\
Das ist ein hervorragender und wissenschaftlich absolut sauberer Ansatz. In der Fachliteratur zur Recurrence Quantification Analysis (insbesondere bei Norbert Marwan oder Webber & Zbilut) werden Algorithmen exakt anhand von vier fundamentalen Topologien validiert, da diese das gesamte Spektrum dynamischen Verhaltens abdecken.Hier ist die wissenschaftlich optimale Auswahl an Testsystemen, die deinen Algorithmus an alle Grenzen bringen wird:1. Periodisches System: Der Harmonische Oszillator (Sinus)Ein reines Sinus-Signal erzeugt ein RP, das ausschließlich aus unendlich langen, ununterbrochenen parallelen Diagonalen besteht.Warum es den Algorithmus testet: Dies ist der Stresstest für die Metrik $L$ (durchschnittliche Linienlänge) und $DET$. Da theoretisch alle Punkte auf Diagonalen liegen, muss $DET \approx 1.0$ sein. Dein Line-Tracing darf hier nicht abbrechen, bevor der Rand der Matrix erreicht ist.Modell: $x(t) = \sin(\omega t)$2. Weiteres chaotisches System: Das Lorenz-SystemDas Lorenz-System ist der Standard in der Chaosforschung. Während das Rössler-System oft sehr feine, fast eindimensionale Bänder im RP erzeugt (dünnes RP), erzeugt das Lorenz-System durch seine zwei "Schmetterlingsflügel" sehr dichte, blockartige Strukturen mit vielen kurzen, abgehackten Diagonalen.Warum es den Algorithmus testet: Es zwingt dein Sampling dazu, zwischen dicht gedrängten, aber separaten Linien zu unterscheiden. Wenn dein Code hier Linien fälschlicherweise verschmilzt, bricht die Entropie ($ENTR$) zusammen.Gleichungen:$$\dot{x} = \sigma(y-x)$$$$\dot{y} = x(\rho-z)-y$$$$\dot{z} = xy-\beta z$$(Standardparameter: $\sigma = 10, \rho = 28, \beta = 8/3$)3. Homogenes RP: Gaußsches weißes Rauschen (White Noise)Weißes Rauschen besitzt keinerlei zeitliche Korrelation. Das RP sieht aus wie Fernsehkrisseln: Es gibt fast nur isolierte, einzelne Punkte und statistisch gesehen extrem wenige, extrem kurze Linien.Warum es den Algorithmus testet: Dies ist der Härtetest für das Stratified Sampling und die Hotspot-Exploration. Weil die Dichte ($RR$) hier sehr homogen, aber Linien extrem selten sind, muss der Algorithmus beweisen, dass er nicht ewig sucht oder in Endlosschleifen festhängt, um das geforderte $M$ an Linien zu finden.4. Drift im RP: Random Walk (Brownsche Bewegung)Bei einer Brownschen Bewegung wandert der Mittelwert der Daten über die Zeit unkontrolliert ab (Nicht-Stationarität). Das RP ist nur in der Nähe der Hauptdiagonale schwarz und "verblasst" zu den Ecken der Matrix hin komplett.Warum es den Algorithmus testet: Ein perfekter Test für die Repräsentativität deines Samplings. Wenn dein Algorithmus blind überall sucht, verschwendet er in den weißen Ecken massiv Zeit. Hier zeigt sich, ob die Box-Verteilung und das LFBOTH-Verfahren mit ungleichmäßiger räumlicher Dichte umgehen können.Modell: $x_{t} = x_{t-1} + \epsilon_t$ (wobei $\epsilon_t$ weißes Rauschen ist)Einschätzung zur Klausurrelevanz & ZeiteinteilungDamit du dich bei der Erstellung dieser Test-Suite nicht verzettelst, ist es wichtig, den Aufwand zu priorisieren und klar zu kennzeichnen, was von Relevanz für die kommende Klausur sein kann und wo du keine unnötige Zeit verschwenden solltest:Hochgradig klausurrelevant: Gaußsches Rauschen und der Random Walk (Brownsche Bewegung). Diese Konzepte (stochastische Prozesse, Fluktuations-Dissipations-Theorem, Diffusion) sind klassische Kernthemen in der statistischen Physik und Thermodynamik. Ein tiefes Verständnis der Eigenschaften dieser Systeme (z.B. Varianz, die linear mit der Zeit wächst) hilft dir nicht nur für dein RP-Benchmarking, sondern zahlt sich direkt für die Prüfung aus.Eher nicht klausurrelevant (Zeitfresser): Die manuelle Implementierung der numerischen Integration (z.B. Runge-Kutta-Verfahren) zur Erzeugung des Lorenz-Systems. Die numerische Mathematik dahinter ist zwar für die Datengenerierung nötig, aber für deinen eigentlichen Lernstoff meist irrelevant. Verschwende hier keine Zeit darauf, Solver selbst zu programmieren.Soll ich dir die kompakten Julia-Snippets generieren, mit denen du diese vier Test-Datensätze (z.B. über fertige Pakete wie DynamicalSystems.jl) in wenigen Zeilen Code erzeugen kannst, damit du sofort und ohne Zeitverlust mit dem Testen beginnen kannst?:
\\
using Random

Anzahl der Datenpunkte für alle Tests
N_points = 10000

==========================================
1. Periodisches System: Harmonischer Oszillator
==========================================
Ein einfacher Sinus. Erzeugt perfekte, ununterbrochene diagonale Linien.
t = range(0, step=0.1, length=N_points)
x_periodic = reshape(sin.(t), :, 1)


==========================================
2. Chaotisches System: Lorenz-Attraktor
==========================================
Kompakte Implementierung (Euler-Verfahren), um aufwendige Pakete zu vermeiden.
Erzeugt eine (N, 3)-Matrix mit dichten Blöcken und vielen kurzen Diagonalen.
function generate_lorenz(N; dt=0.01, σ=10.0, ρ=28.0, β=8/3)
    x = zeros(Float64, N, 3)
    x[1, :] .= [1.0, 1.0, 1.0] # Initiale Startwerte
    
    @inbounds for i in 1:(N-1)
        dx = σ * (x[i,2] - x[i,1])
        dy = x[i,1] * (ρ - x[i,3]) - x[i,2]
        dz = x[i,1] * x[i,2] - β * x[i,3]
        
        x[i+1, 1] = x[i,1] + dx * dt
        x[i+1, 2] = x[i,2] + dy * dt
        x[i+1, 3] = x[i,3] + dz * dt
    end
    return x
end

x_lorenz = generate_lorenz(N_points)


==========================================
3. Homogenes RP: Gaußsches weißes Rauschen
==========================================
randn() erzeugt standardnormalverteilte Zufallszahlen. 
Testet die Hotspot-Exploration, da es hier kaum Linien gibt.
x_noise = reshape(randn(N_points), :, 1)


==========================================
4. Drift im RP: Random Walk (Brownsche Bewegung)
==========================================
cumsum() summiert das Rauschen auf (Integration über die Zeit).
Testet die Repräsentativität des Samplings durch starke Nicht-Stationarität.
x_random_walk = reshape(cumsum(randn(N_points)), :, 1)
%
\item füge ich nun ein und schaue mal ob das so klappt, einfahc von gemini (siehe oben) übernommen
\\
ist das das was wir bei roessler auch haben, also daten mit beispiel parametern erstellen und dann in die form eines arrays bringen mit zeit in den zeilen und den phasenraum-dimensionen auf den spalten!?
\\
%
### 02 h : 05 min (seit dem lezten Zeitstempel) 
%
# 05.08.2026
%
\item ja, macht das selbe, also kann x einfach genauso verwenden wie bei roessler, wie genau das alles funktioniert und was das ist gilt es später noch zu verstehen, erstmal pragmatisch aufs hauptziel: dei testläufe und ergebnisse finden und vergleichen
%
\item fehler/abweichung zu woRP in den ergebnissen implizieren
%
\item testlauf 1 :
======================================================================
 SYSTEM: KLASSE 1: CHAOS (ROESSLER SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
RR:   0.08277577808439872
DET:  0.9984392508670275
L:    23.776464002619335
ENTR: 3.864856330212997

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     21.49 ms
allocations: 101
storage:     161.47 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     21.9 ms
allocations: 121
storage:     162.37 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 508789.46 ± 14643.83
  RR:       0.08345950156752302 ± 0.002470348240857121
    -> ΔwoRP: 0.0006837234831243016 ± 0.002470348240857121
  DET:      0.998439484647239 ± 0.00019396944051074558
    -> ΔwoRP: 2.337802115226495e-7 ± 0.00019396944051074558
  L:        23.791081219441814 ± 0.5330924303842874
    -> ΔwoRP: 0.014617216822479406 ± 0.5330924303842874
  ENTR:     3.837006987172724 ± 0.0199397466991992
    -> ΔwoRP: -0.027849343040272867 ± 0.0199397466991992

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 519978
  RR:       0.08339741672718987 (ΔwoRP: 0.0006216386427911474)
  DET:      0.9984418356456777 (ΔwoRP: 2.5847786502275483e-6)
  L:        24.274519979242346 (ΔwoRP: 0.4980559766230108)
  ENTR:     3.8683954386281174 (ΔwoRP: 0.0035391084151203955)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     15.77 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     16.9 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595450.75 ± 16822.41
  RR:       0.07562804998852563 ± 0.0022028867416207065
    -> ΔwoRP: -0.007147728095873093 ± 0.0022028867416207065
  DET:      0.9985841426170942 ± 0.0001678018088461515
    -> ΔwoRP: 0.0001448917500667113 ± 0.0001678018088461515
  L:        25.002871252274517 ± 0.5322139239191341
    -> ΔwoRP: 1.2264072496551819 ± 0.5322139239191341
  ENTR:     3.8562338874819684 ± 0.01902930483914499
    -> ΔwoRP: -0.008622442731028634 ± 0.01902930483914499

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 595449
  RR:       0.07663604019236032 (ΔwoRP: -0.006139737892038394)
  DET:      0.9987551782543926 (ΔwoRP: 0.0003159273873651891)
  L:        25.240845796802475 (ΔwoRP: 1.46438179418314)
  ENTR:     3.87017269561499 (ΔwoRP: 0.005316365401993206)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     16.1 ms
allocations: 82
storage:     176.76 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     16.4 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595156.52 ± 15850.59
  RR:       0.07569874046837666 ± 0.0022633845983954506
    -> ΔwoRP: -0.007077037616022061 ± 0.0022633845983954506
  DET:      0.998580136025936 ± 0.00017435171466362372
    -> ΔwoRP: 0.00014088515890853248 ± 0.00017435171466362372
  L:        25.010691926005563 ± 0.5403094949089446
    -> ΔwoRP: 1.2342279233862286 ± 0.5403094949089446
  ENTR:     3.8557301812276226 ± 0.019576919481718833
    -> ΔwoRP: -0.00912614898537445 ± 0.019576919481718833

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 622976
  RR:       0.07297521851023114 (ΔwoRP: -0.009800559574167575)
  DET:      0.9986025195750016 (ΔwoRP: 0.00016326870797411797)
  L:        25.150621118012424 (ΔwoRP: 1.3741571153930892)
  ENTR:     3.8658099402424124 (ΔwoRP: 0.0009536100294154082)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     2.88 ms
allocations: 72
storage:     98.19 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.85 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22930.32 ± 456.66
  RR:       0.08725085533483934 ± 0.0017372959546562258
    -> ΔwoRP: 0.0044750772504406205 ± 0.0017372959546562258
  DET:      0.9985759473684214 ± 0.0008434414794538696
    -> ΔwoRP: 0.0001366965013939181 ± 0.0008434414794538696
  L:        24.47986737113914 ± 0.613730870631658
    -> ΔwoRP: 0.7034033685198047 ± 0.613730870631658
  ENTR:     3.847109940182904 ± 0.023023583594190385
    -> ΔwoRP: -0.01774639003009293 ± 0.023023583594190385

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)


======================================================================
 SYSTEM: KLASSE 1: CHAOS (LORENZ SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
RR:   0.12050202018220797
DET:  0.9998998789325514
L:    40.53190731895452
ENTR: 4.524222130528146

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     26.62 ms
allocations: 109
storage:     161.84 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     26.88 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 590331.58 ± 13483.98
  RR:       0.12489209361657028 ± 0.004665652212241008
    -> ΔwoRP: 0.004390073434362304 ± 0.004665652212241008
  DET:      0.9998985509003859 ± 3.617778565093059e-5
    -> ΔwoRP: -1.328032165459625e-6 ± 3.617778565093059e-5
  L:        40.538369690178065 ± 1.2996653821136803
    -> ΔwoRP: 0.006462371223548757 ± 1.2996653821136803
  ENTR:     4.439192099603378 ± 0.027560128467866412
    -> ΔwoRP: -0.08503003092476735 ± 0.027560128467866412

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 617671
  RR:       0.11708743063717104 (ΔwoRP: -0.003414589545036928)
  DET:      0.9998602375960867 (ΔwoRP: -3.964133646472412e-5)
  L:        39.56460532931121 (ΔwoRP: -0.9673019896433033)
  ENTR:     4.415985716337583 (ΔwoRP: -0.10823641419056251)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     38.76 ms
allocations: 132
storage:     203.03 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     38.02 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 769957.33 ± 20008.1
  RR:       0.10090622796970083 ± 0.004014317424455455
    -> ΔwoRP: -0.019595792212507138 ± 0.004014317424455455
  DET:      0.9999079098622405 ± 3.262404683579192e-5
    -> ΔwoRP: 8.0309296891512e-6 ± 3.262404683579192e-5
  L:        41.93490451730213 ± 1.4051395033766412
    -> ΔwoRP: 1.402997198347613 ± 1.4051395033766412
  ENTR:     4.4713199355051225 ± 0.027020499228626926
    -> ΔwoRP: -0.05290219502302307 ± 0.027020499228626926

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 813909
  RR:       0.0970121861694318 (ΔwoRP: -0.02348983401277617)
  DET:      0.9999172342035566 (ΔwoRP: 1.7355271005214945e-5)
  L:        42.433015554440544 (ΔwoRP: 1.9011082354860278)
  ENTR:     4.493282877959766 (ΔwoRP: -0.030939252568379594)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     36.14 ms
allocations: 130
storage:     179.0 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     39.4 ms
allocations: 130
storage:     178.95 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 770330.29 ± 20591.41
  RR:       0.10082651683908612 ± 0.004015757706509789
    -> ΔwoRP: -0.019675503343121847 ± 0.004015757706509789
  DET:      0.9999081657351132 ± 3.357515939308157e-5
    -> ΔwoRP: 8.286802561818796e-6 ± 3.357515939308157e-5
  L:        41.919484104716126 ± 1.3584723123944054
    -> ΔwoRP: 1.3875767857616097 ± 1.3584723123944054
  ENTR:     4.471597349548967 ± 0.026918654249638
    -> ΔwoRP: -0.05262478097917889 ± 0.026918654249638

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 817442
  RR:       0.09489365494296578 (ΔwoRP: -0.02560836523924219)
  DET:      0.9999157205292751 (ΔwoRP: 1.5841596723742413e-5)
  L:        41.6708479678876 (ΔwoRP: 1.1389406489330867)
  ENTR:     4.442449861300334 (ΔwoRP: -0.08177226922781156)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     3.89 ms
allocations: 114
storage:     124.23 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     3.91 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 15303.69 ± 316.33
  RR:       0.1307432627881918 ± 0.002704994517198397
    -> ΔwoRP: 0.010241242605983816 ± 0.002704994517198397
  DET:      0.9999164999999998 ± 0.000203270925291992
    -> ΔwoRP: 1.662106744837466e-5 ± 0.000203270925291992
  L:        41.00224919224453 ± 1.1233465805126923
    -> ΔwoRP: 0.4703418732900104 ± 1.1233465805126923
  ENTR:     4.468104502804765 ± 0.030100255984276052
    -> ΔwoRP: -0.05611762772338036 ± 0.030100255984276052

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)


======================================================================
 SYSTEM: KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
RR:   0.16869916168804264
DET:  0.9998969369319293
L:    6.370145543977406
ENTR: 1.9267486031067216

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     2.4 ms
allocations: 57
storage:     159.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.9 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 67010.55 ± 1523.63
  RR:       0.16840977842427768 ± 0.07234340607507414
    -> ΔwoRP: -0.0002893832637649585 ± 0.07234340607507414
  DET:      0.9998862322015579 ± 0.00011201638013718396
    -> ΔwoRP: -1.0704730371347004e-5 ± 0.00011201638013718396
  L:        6.319665385342089 ± 2.7116530666130476
    -> ΔwoRP: -0.05048015863531674 ± 2.7116530666130476
  ENTR:     1.9146769391763983 ± 0.028745739483849363
    -> ΔwoRP: -0.012071663930323329 ± 0.028745739483849363

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 68745
  RR:       0.310202283300289 (ΔwoRP: 0.14150312161224635)
  DET:      0.9999164508313142 (ΔwoRP: 1.9513899384926425e-5)
  L:        11.97997997997998 (ΔwoRP: 5.609834436002574)
  ENTR:     1.9878967476966698 (ΔwoRP: 0.06114814458994822)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     3.73 ms
allocations: 88
storage:     177.68 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.18 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100644.79 ± 3131.68
  RR:       0.15157727771083854 ± 0.06122660972897417
    -> ΔwoRP: -0.0171218839772041 ± 0.06122660972897417
  DET:      0.9999012703201857 ± 9.084994554787152e-5
    -> ΔwoRP: 4.3333882564500215e-6 ± 9.084994554787152e-5
  L:        8.357105700375326 ± 3.3625171774489933
    -> ΔwoRP: 1.9869601563979202 ± 3.3625171774489933
  ENTR:     2.2046368860106216 ± 0.031138940391472532
    -> ΔwoRP: 0.2778882829039 ± 0.031138940391472532

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 96342
  RR:       0.1274874859776963 (ΔwoRP: -0.04121167571034634)
  DET:      0.9998521147589471 (ΔwoRP: -4.482217298218405e-5)
  L:        6.767767767767768 (ΔwoRP: 0.3976222237903615)
  ENTR:     2.2395955728017842 (ΔwoRP: 0.31284696969506265)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     4.82 ms
allocations: 90
storage:     177.14 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.42 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100505.22 ± 2924.42
  RR:       0.1529070363092565 ± 0.06190280202361041
    -> ΔwoRP: -0.01579212537878613 ± 0.06190280202361041
  DET:      0.9998994728458434 ± 9.671803533371416e-5
    -> ΔwoRP: 2.535913914081256e-6 ± 9.671803533371416e-5
  L:        8.425028998646573 ± 3.426328461179998
    -> ΔwoRP: 2.0548834546691666 ± 3.426328461179998
  ENTR:     2.2029755824825554 ± 0.03210496086781694
    -> ΔwoRP: 0.27622697937583385 ± 0.03210496086781694

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 99457
  RR:       0.1722890020889068 (ΔwoRP: 0.0035898404008641582)
  DET:      0.9998936453070991 (ΔwoRP: -3.291624830148443e-6)
  L:        9.41091091091091 (ΔwoRP: 3.0407653669335044)
  ENTR:     2.230790756844401 (ΔwoRP: 0.3040421537376796)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     22.7 ms
allocations: 122
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     21.04 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11058.18 ± 395.68
  RR:       0.180944543854544 ± 0.005872698171995446
    -> ΔwoRP: 0.012245382166501367 ± 0.005872698171995446
  DET:      0.999904620689655 ± 0.00021529430048496277
    -> ΔwoRP: 7.683757725751583e-6 ± 0.00021529430048496277
  L:        6.946205864320911 ± 0.36058605676337885
    -> ΔwoRP: 0.5760603203435046 ± 0.36058605676337885
  ENTR:     2.0277320074220393 ± 0.05776955471684883
    -> ΔwoRP: 0.10098340431531772 ± 0.05776955471684883

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)


======================================================================
 SYSTEM: KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
RR:   0.31000792896992163
DET:  0.6957785520242857
L:    2.8168341761073212
ENTR: 1.24791486522226

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     0.56 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.49 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8081.19 ± 159.41
  RR:       0.3113896183520658 ± 0.00549238603078651
    -> ΔwoRP: 0.001381689382144169 ± 0.00549238603078651
  DET:      0.6955319447131443 ± 0.009969420449804424
    -> ΔwoRP: -0.00024660731114145573 ± 0.009969420449804424
  L:        2.8177568976016105 ± 0.041379959860795276
    -> ΔwoRP: 0.0009227214942892914 ± 0.041379959860795276
  ENTR:     1.2450012477499168 ± 0.02210003240724941
    -> ΔwoRP: -0.0029136174723431996 ± 0.02210003240724941

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7741
  RR:       0.32202491386164855 (ΔwoRP: 0.012016984891726923)
  DET:      0.693278463648834 (ΔwoRP: -0.002500088375451681)
  L:        2.865079365079365 (ΔwoRP: 0.048245188972043884)
  ENTR:     1.2522346512278124 (ΔwoRP: 0.004319786005552384)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     0.83 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.66 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8096.94 ± 154.15
  RR:       0.31099675447083314 ± 0.005257045641016181
    -> ΔwoRP: 0.0009888255009115055 ± 0.005257045641016181
  DET:      0.6959467727625376 ± 0.010116161855785235
    -> ΔwoRP: 0.00016822073825184525 ± 0.010116161855785235
  L:        2.816001711554191 ± 0.04125752610689554
    -> ΔwoRP: -0.00083246455313013 ± 0.04125752610689554
  ENTR:     1.2453303871915216 ± 0.022077985460093062
    -> ΔwoRP: -0.0025844780307384685 ± 0.022077985460093062

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7978
  RR:       0.3114241001564945 (ΔwoRP: 0.0014161711865728899)
  DET:      0.6862088218872139 (ΔwoRP: -0.009569730137071852)
  L:        2.8059360730593608 (ΔwoRP: -0.010898103047960461)
  ENTR:     1.2252810802392875 (ΔwoRP: -0.022633784982972527)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     0.84 ms
allocations: 122
storage:     178.59 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.77 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8093.9 ± 156.07
  RR:       0.31095318705822955 ± 0.00521202383961691
    -> ΔwoRP: 0.0009452580883079209 ± 0.00521202383961691
  DET:      0.6954296961431241 ± 0.009946603063276238
    -> ΔwoRP: -0.0003488558811616249 ± 0.009946603063276238
  L:        2.8159643890591006 ± 0.04078303192989796
    -> ΔwoRP: -0.0008697870482206049 ± 0.04078303192989796
  ENTR:     1.244458359687937 ± 0.021544017472557523
    -> ΔwoRP: -0.0034565055343229734 ± 0.021544017472557523

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 8127
  RR:       0.30611192297773576 (ΔwoRP: -0.003896005992185869)
  DET:      0.6778994664420107 (ΔwoRP: -0.017879085582275023)
  L:        2.8300117233294255 (ΔwoRP: 0.013177547222104291)
  ENTR:     1.2183067996289512 (ΔwoRP: -0.029608065593308863)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     0.6 ms
allocations: 108
storage:     99.9 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.48 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4452.6 ± 75.21
  RR:       0.4493040849657106 ± 0.007583419157489129
    -> ΔwoRP: 0.13929615599578898 ± 0.007583419157489129
  DET:      0.6959239999999999 ± 0.010178768654966645
    -> ΔwoRP: 0.00014544797571414136 ± 0.010178768654966645
  L:        2.8180977179756637 ± 0.027148551941996134
    -> ΔwoRP: 0.0012635418683424327 ± 0.027148551941996134
  ENTR:     1.2474500189272653 ± 0.018285699181017436
    -> ΔwoRP: -0.0004648462949947696 ± 0.018285699181017436

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)


======================================================================
 SYSTEM: KLASSE 4: DRIFT (RANDOM WALK)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
RR:   0.21585802044425884
DET:  0.9889694676180966
L:    34.58999692843248
ENTR: 3.5367546661084104

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     8.79 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     8.1 ms
allocations: 121
storage:     162.37 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184513.39 ± 4320.19
  RR:       0.23831054157317494 ± 0.01408610311545192
    -> ΔwoRP: 0.022452521128916103 ± 0.01408610311545192
  DET:      0.9889473089342893 ± 0.0008236478194450315
    -> ΔwoRP: -2.215868380728292e-5 ± 0.0008236478194450315
  L:        34.64936288473758 ± 1.9996966989845875
    -> ΔwoRP: 0.05936595630510055 ± 1.9996966989845875
  ENTR:     3.4518343299117196 ± 0.04770648993635614
    -> ΔwoRP: -0.08492033619669082 ± 0.04770648993635614

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186476
  RR:       0.22912194478966594 (ΔwoRP: 0.013263924345407102)
  DET:      0.9887612746810216 (ΔwoRP: -0.0002081929370749691)
  L:        33.12044046799725 (ΔwoRP: -1.4695564604352285)
  ENTR:     3.4562719601227028 (ΔwoRP: -0.08048270598570761)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     10.53 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     12.32 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197106.0 ± 4418.72
  RR:       0.2281812694226437 ± 0.012947753426131577
    -> ΔwoRP: 0.012323248978384854 ± 0.012947753426131577
  DET:      0.9891703523105568 ± 0.0007713396770704523
    -> ΔwoRP: 0.00020088469246026808 ± 0.0007713396770704523
  L:        35.17119530809072 ± 1.9445575233881844
    -> ΔwoRP: 0.5811983796582396 ± 1.9445575233881844
  ENTR:     3.4675487770138007 ± 0.045917560617972475
    -> ΔwoRP: -0.06920588909460967 ± 0.045917560617972475

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 198407
  RR:       0.2258144267998181 (ΔwoRP: 0.009956406355559277)
  DET:      0.9889733914641538 (ΔwoRP: 3.923846057185543e-6)
  L:        35.226323119777156 (ΔwoRP: 0.6363261913446792)
  ENTR:     3.4236046505015083 (ΔwoRP: -0.11315001560690208)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     9.79 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     22.66 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197082.57 ± 5389.15
  RR:       0.2280745212549455 ± 0.013612260961232792
    -> ΔwoRP: 0.012216500810686676 ± 0.013612260961232792
  DET:      0.9891767007646907 ± 0.000796919565106968
    -> ΔwoRP: 0.00020723314659409908 ± 0.000796919565106968
  L:        35.13785006968775 ± 2.081246163310937
    -> ΔwoRP: 0.5478531412552741 ± 2.081246163310937
  ENTR:     3.4679539570372047 ± 0.04708289153687421
    -> ΔwoRP: -0.06880070907120572 ± 0.04708289153687421

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 199562
  RR:       0.2438211328833257 (ΔwoRP: 0.02796311243906685)
  DET:      0.9898579031304316 (ΔwoRP: 0.000888435512335084)
  L:        38.52231520223152 (ΔwoRP: 3.9323182737990408)
  ENTR:     3.506187118408789 (ΔwoRP: -0.030567547699621223)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     2.61 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.94 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 7550.85 ± 149.39
  RR:       0.2649745719840438 ± 0.0052521145491085134
    -> ΔwoRP: 0.04911655153978495 ± 0.0052521145491085134
  DET:      0.9893029999999998 ± 0.002390691616751608
    -> ΔwoRP: 0.0003335323819032565 ± 0.002390691616751608
  L:        35.220164226411974 ± 1.8167625914771757
    -> ΔwoRP: 0.6301672979794972 ± 1.8167625914771757
  ENTR:     3.5240788389473257 ± 0.14687788515898395
    -> ΔwoRP: -0.01267582716108473 ± 0.14687788515898395

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7382
  RR:       0.270929287455974 (ΔwoRP: 0.055071267011715164)
  DET:      0.9875 (ΔwoRP: -0.0014694676180965205)
  L:        38.527089283106655 (ΔwoRP: 3.937092354674178)
  ENTR:     3.44695434022687 (ΔwoRP: -0.0898003258815403)
%
\item offenkundig LFboth rasiert alles chaotische, periodisch und rauschen verliert komplett gegen norberts und drift halbwegs auf dem selben fußballplatz. => wie verbessere ich das? 
\\
was ist anders bei periodischem und rauschen und wie berücksichtige ich das und wie udn was passe ich dann an um die performance zu verbessern?
\\
effektiv muss ich sinnvoll abzuschätzende bedingungen für drift, periodishc und raushcen und eben chaotisch definieren um dann norberts zu nutzen oder LFboth ?! oder kann ich LFboth noch optimieren?
\\
zunächst bedingung/en finden die sich möglichst schnell/günstig abschätzen lässt/lassen:
chaos:

periodisch:

rauschen:

drift:
\\
unfug: bei periodisch verliert klar. 
bei rauschen nur in werten um einen faktor 10 bei RR, DET und ENTR und bei L um einen Faktor 10 in der Abweichung gewonnen und bei zeit/kosten knapp gewonnen, dass am ende verloren ist, weil zeit nicht aufwiegen kann was in qualität verloren geht.
bei drift fast halbe zeit gewonnen, aber in den werten selbe größenordnung für RR, um einen faktor 10 verloren in DET, selbe größenordnung (ganze zahl) aber +2 in L und selbe größenordnung in ENTR. so muss man evaluieren wie viel in dieser größenordnung (einer ms) die halbierung der zeit wert ist, im vergleich zu den genannten verlusten in der qualität der rqa werte.
\\
also zunächst was die bedingungen sind für periodisch, dass ich dort norberts algo aktiviere und was ich bei rauschen und drift noch optimieren kann bei LFboth (und was ich noch optimieren kann an norberts??) und dann testen und evaluieren ob norberts auch aktiviert werden muss bei drift und rauschen oder ob optimaler LFboth gewinnt, dann brauche ich auch nicht mehr die bedingungen für drift und rauschen, sondern nur noch für periodisch:
\\
schnell abschätzbare bedingung für stark periodische systeme, um diese als solche zu erkennen und dann norberts algo zu aktivieren (oder sogar woRP?? (für kleine RP)): xxxx
%
\item testlauf mit zeit von woRP um zu beantworten ob woRP irgendwo gegen LFboth UND norbert gewinnt (glaube nur für kleien RP):
\\
======================================================================
 SYSTEM: KLASSE 1: CHAOS (ROESSLER SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     271.04 ms
allocations: 3
storage:     78.19 KiB
RR:   0.08277577808439872
DET:  0.9984392508670275
L:    23.776464002619335
ENTR: 3.864856330212997

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     12.41 ms
allocations: 113
storage:     162.06 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     18.42 ms
allocations: 121
storage:     162.37 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 508789.46 ± 14643.83
  RR:       0.08345950156752302 ± 0.002470348240857121
    -> ΔwoRP: 0.0006837234831243016 ± 0.002470348240857121
  DET:      0.998439484647239 ± 0.00019396944051074558
    -> ΔwoRP: 2.337802115226495e-7 ± 0.00019396944051074558
  L:        23.791081219441814 ± 0.5330924303842874
    -> ΔwoRP: 0.014617216822479406 ± 0.5330924303842874
  ENTR:     3.837006987172724 ± 0.0199397466991992
    -> ΔwoRP: -0.027849343040272867 ± 0.0199397466991992

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 519978
  RR:       0.08339741672718987 (ΔwoRP: 0.0006216386427911474)
  DET:      0.9984418356456777 (ΔwoRP: 2.5847786502275483e-6)
  L:        24.274519979242346 (ΔwoRP: 0.4980559766230108)
  ENTR:     3.8683954386281174 (ΔwoRP: 0.0035391084151203955)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     9.91 ms
allocations: 36
storage:     174.11 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     12.38 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595450.75 ± 16822.41
  RR:       0.07562804998852563 ± 0.0022028867416207065
    -> ΔwoRP: -0.007147728095873093 ± 0.0022028867416207065
  DET:      0.9985841426170942 ± 0.0001678018088461515
    -> ΔwoRP: 0.0001448917500667113 ± 0.0001678018088461515
  L:        25.002871252274517 ± 0.5322139239191341
    -> ΔwoRP: 1.2264072496551819 ± 0.5322139239191341
  ENTR:     3.8562338874819684 ± 0.01902930483914499
    -> ΔwoRP: -0.008622442731028634 ± 0.01902930483914499

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 595449
  RR:       0.07663604019236032 (ΔwoRP: -0.006139737892038394)
  DET:      0.9987551782543926 (ΔwoRP: 0.0003159273873651891)
  L:        25.240845796802475 (ΔwoRP: 1.46438179418314)
  ENTR:     3.87017269561499 (ΔwoRP: 0.005316365401993206)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     9.15 ms
allocations: 46
storage:     175.03 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     33.79 ms
allocations: 130
storage:     178.96 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595156.52 ± 15850.59
  RR:       0.07569874046837666 ± 0.0022633845983954506
    -> ΔwoRP: -0.007077037616022061 ± 0.0022633845983954506
  DET:      0.998580136025936 ± 0.00017435171466362372
    -> ΔwoRP: 0.00014088515890853248 ± 0.00017435171466362372
  L:        25.010691926005563 ± 0.5403094949089446
    -> ΔwoRP: 1.2342279233862286 ± 0.5403094949089446
  ENTR:     3.8557301812276226 ± 0.019576919481718833
    -> ΔwoRP: -0.00912614898537445 ± 0.019576919481718833

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 622976
  RR:       0.07297521851023114 (ΔwoRP: -0.009800559574167575)
  DET:      0.9986025195750016 (ΔwoRP: 0.00016326870797411797)
  L:        25.150621118012424 (ΔwoRP: 1.3741571153930892)
  ENTR:     3.8658099402424124 (ΔwoRP: 0.0009536100294154082)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     2.06 ms
allocations: 124
storage:     100.63 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.14 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22930.32 ± 456.66
  RR:       0.08725085533483934 ± 0.0017372959546562258
    -> ΔwoRP: 0.0044750772504406205 ± 0.0017372959546562258
  DET:      0.9985759473684214 ± 0.0008434414794538696
    -> ΔwoRP: 0.0001366965013939181 ± 0.0008434414794538696
  L:        24.47986737113914 ± 0.613730870631658
    -> ΔwoRP: 0.7034033685198047 ± 0.613730870631658
  ENTR:     3.847109940182904 ± 0.023023583594190385
    -> ΔwoRP: -0.01774639003009293 ± 0.023023583594190385

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)


======================================================================
 SYSTEM: KLASSE 1: CHAOS (LORENZ SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     292.37 ms
allocations: 3
storage:     78.19 KiB
RR:   0.12050202018220797
DET:  0.9998998789325514
L:    40.53190731895452
ENTR: 4.524222130528146

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     19.89 ms
allocations: 89
storage:     160.87 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     17.67 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 590331.58 ± 13483.98
  RR:       0.12489209361657028 ± 0.004665652212241008
    -> ΔwoRP: 0.004390073434362304 ± 0.004665652212241008
  DET:      0.9998985509003859 ± 3.617778565093059e-5
    -> ΔwoRP: -1.328032165459625e-6 ± 3.617778565093059e-5
  L:        40.538369690178065 ± 1.2996653821136803
    -> ΔwoRP: 0.006462371223548757 ± 1.2996653821136803
  ENTR:     4.439192099603378 ± 0.027560128467866412
    -> ΔwoRP: -0.08503003092476735 ± 0.027560128467866412

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 617671
  RR:       0.11708743063717104 (ΔwoRP: -0.003414589545036928)
  DET:      0.9998602375960867 (ΔwoRP: -3.964133646472412e-5)
  L:        39.56460532931121 (ΔwoRP: -0.9673019896433033)
  ENTR:     4.415985716337583 (ΔwoRP: -0.10823641419056251)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     24.6 ms
allocations: 130
storage:     179.03 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     24.0 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 769957.33 ± 20008.1
  RR:       0.10090622796970083 ± 0.004014317424455455
    -> ΔwoRP: -0.019595792212507138 ± 0.004014317424455455
  DET:      0.9999079098622405 ± 3.262404683579192e-5
    -> ΔwoRP: 8.0309296891512e-6 ± 3.262404683579192e-5
  L:        41.93490451730213 ± 1.4051395033766412
    -> ΔwoRP: 1.402997198347613 ± 1.4051395033766412
  ENTR:     4.4713199355051225 ± 0.027020499228626926
    -> ΔwoRP: -0.05290219502302307 ± 0.027020499228626926

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 813909
  RR:       0.0970121861694318 (ΔwoRP: -0.02348983401277617)
  DET:      0.9999172342035566 (ΔwoRP: 1.7355271005214945e-5)
  L:        42.433015554440544 (ΔwoRP: 1.9011082354860278)
  ENTR:     4.493282877959766 (ΔwoRP: -0.030939252568379594)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     22.53 ms
allocations: 132
storage:     203.05 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     22.78 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 770330.29 ± 20591.41
  RR:       0.10082651683908612 ± 0.004015757706509789
    -> ΔwoRP: -0.019675503343121847 ± 0.004015757706509789
  DET:      0.9999081657351132 ± 3.357515939308157e-5
    -> ΔwoRP: 8.286802561818796e-6 ± 3.357515939308157e-5
  L:        41.919484104716126 ± 1.3584723123944054
    -> ΔwoRP: 1.3875767857616097 ± 1.3584723123944054
  ENTR:     4.471597349548967 ± 0.026918654249638
    -> ΔwoRP: -0.05262478097917889 ± 0.026918654249638

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 817442
  RR:       0.09489365494296578 (ΔwoRP: -0.02560836523924219)
  DET:      0.9999157205292751 (ΔwoRP: 1.5841596723742413e-5)
  L:        41.6708479678876 (ΔwoRP: 1.1389406489330867)
  ENTR:     4.442449861300334 (ΔwoRP: -0.08177226922781156)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     3.11 ms
allocations: 46
storage:     121.03 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.2 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 15303.69 ± 316.33
  RR:       0.1307432627881918 ± 0.002704994517198397
    -> ΔwoRP: 0.010241242605983816 ± 0.002704994517198397
  DET:      0.9999164999999998 ± 0.000203270925291992
    -> ΔwoRP: 1.662106744837466e-5 ± 0.000203270925291992
  L:        41.00224919224453 ± 1.1233465805126923
    -> ΔwoRP: 0.4703418732900104 ± 1.1233465805126923
  ENTR:     4.468104502804765 ± 0.030100255984276052
    -> ΔwoRP: -0.05611762772338036 ± 0.030100255984276052

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)


======================================================================
 SYSTEM: KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     358.03 ms
allocations: 3
storage:     78.19 KiB
RR:   0.16869916168804264
DET:  0.9998969369319293
L:    6.370145543977406
ENTR: 1.9267486031067216

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     2.02 ms
allocations: 57
storage:     159.4 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.44 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 67010.55 ± 1523.63
  RR:       0.16840977842427768 ± 0.07234340607507414
    -> ΔwoRP: -0.0002893832637649585 ± 0.07234340607507414
  DET:      0.9998862322015579 ± 0.00011201638013718396
    -> ΔwoRP: -1.0704730371347004e-5 ± 0.00011201638013718396
  L:        6.319665385342089 ± 2.7116530666130476
    -> ΔwoRP: -0.05048015863531674 ± 2.7116530666130476
  ENTR:     1.9146769391763983 ± 0.028745739483849363
    -> ΔwoRP: -0.012071663930323329 ± 0.028745739483849363

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 68745
  RR:       0.310202283300289 (ΔwoRP: 0.14150312161224635)
  DET:      0.9999164508313142 (ΔwoRP: 1.9513899384926425e-5)
  L:        11.97997997997998 (ΔwoRP: 5.609834436002574)
  ENTR:     1.9878967476966698 (ΔwoRP: 0.06114814458994822)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     4.41 ms
allocations: 56
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.02 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100644.79 ± 3131.68
  RR:       0.15157727771083854 ± 0.06122660972897417
    -> ΔwoRP: -0.0171218839772041 ± 0.06122660972897417
  DET:      0.9999012703201857 ± 9.084994554787152e-5
    -> ΔwoRP: 4.3333882564500215e-6 ± 9.084994554787152e-5
  L:        8.357105700375326 ± 3.3625171774489933
    -> ΔwoRP: 1.9869601563979202 ± 3.3625171774489933
  ENTR:     2.2046368860106216 ± 0.031138940391472532
    -> ΔwoRP: 0.2778882829039 ± 0.031138940391472532

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 96342
  RR:       0.1274874859776963 (ΔwoRP: -0.04121167571034634)
  DET:      0.9998521147589471 (ΔwoRP: -4.482217298218405e-5)
  L:        6.767767767767768 (ΔwoRP: 0.3976222237903615)
  ENTR:     2.2395955728017842 (ΔwoRP: 0.31284696969506265)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     4.09 ms
allocations: 90
storage:     177.07 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.33 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100505.22 ± 2924.42
  RR:       0.1529070363092565 ± 0.06190280202361041
    -> ΔwoRP: -0.01579212537878613 ± 0.06190280202361041
  DET:      0.9998994728458434 ± 9.671803533371416e-5
    -> ΔwoRP: 2.535913914081256e-6 ± 9.671803533371416e-5
  L:        8.425028998646573 ± 3.426328461179998
    -> ΔwoRP: 2.0548834546691666 ± 3.426328461179998
  ENTR:     2.2029755824825554 ± 0.03210496086781694
    -> ΔwoRP: 0.27622697937583385 ± 0.03210496086781694

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 99457
  RR:       0.1722890020889068 (ΔwoRP: 0.0035898404008641582)
  DET:      0.9998936453070991 (ΔwoRP: -3.291624830148443e-6)
  L:        9.41091091091091 (ΔwoRP: 3.0407653669335044)
  ENTR:     2.230790756844401 (ΔwoRP: 0.3040421537376796)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     25.49 ms
allocations: 128
storage:     100.77 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     38.77 ms
allocations: 130
storage:     124.89 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11058.18 ± 395.68
  RR:       0.180944543854544 ± 0.005872698171995446
    -> ΔwoRP: 0.012245382166501367 ± 0.005872698171995446
  DET:      0.999904620689655 ± 0.00021529430048496277
    -> ΔwoRP: 7.683757725751583e-6 ± 0.00021529430048496277
  L:        6.946205864320911 ± 0.36058605676337885
    -> ΔwoRP: 0.5760603203435046 ± 0.36058605676337885
  ENTR:     2.0277320074220393 ± 0.05776955471684883
    -> ΔwoRP: 0.10098340431531772 ± 0.05776955471684883

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)


======================================================================
 SYSTEM: KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     261.53 ms
allocations: 3
storage:     78.19 KiB
RR:   0.31000792896992163
DET:  0.6957785520242857
L:    2.8168341761073212
ENTR: 1.24791486522226

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     0.51 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.45 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8081.19 ± 159.41
  RR:       0.3113896183520658 ± 0.00549238603078651
    -> ΔwoRP: 0.001381689382144169 ± 0.00549238603078651
  DET:      0.6955319447131443 ± 0.009969420449804424
    -> ΔwoRP: -0.00024660731114145573 ± 0.009969420449804424
  L:        2.8177568976016105 ± 0.041379959860795276
    -> ΔwoRP: 0.0009227214942892914 ± 0.041379959860795276
  ENTR:     1.2450012477499168 ± 0.02210003240724941
    -> ΔwoRP: -0.0029136174723431996 ± 0.02210003240724941

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7741
  RR:       0.32202491386164855 (ΔwoRP: 0.012016984891726923)
  DET:      0.693278463648834 (ΔwoRP: -0.002500088375451681)
  L:        2.865079365079365 (ΔwoRP: 0.048245188972043884)
  ENTR:     1.2522346512278124 (ΔwoRP: 0.004319786005552384)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     0.91 ms
allocations: 130
storage:     178.92 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.84 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8096.94 ± 154.15
  RR:       0.31099675447083314 ± 0.005257045641016181
    -> ΔwoRP: 0.0009888255009115055 ± 0.005257045641016181
  DET:      0.6959467727625376 ± 0.010116161855785235
    -> ΔwoRP: 0.00016822073825184525 ± 0.010116161855785235
  L:        2.816001711554191 ± 0.04125752610689554
    -> ΔwoRP: -0.00083246455313013 ± 0.04125752610689554
  ENTR:     1.2453303871915216 ± 0.022077985460093062
    -> ΔwoRP: -0.0025844780307384685 ± 0.022077985460093062

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7978
  RR:       0.3114241001564945 (ΔwoRP: 0.0014161711865728899)
  DET:      0.6862088218872139 (ΔwoRP: -0.009569730137071852)
  L:        2.8059360730593608 (ΔwoRP: -0.010898103047960461)
  ENTR:     1.2252810802392875 (ΔwoRP: -0.022633784982972527)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     0.86 ms
allocations: 122
storage:     178.64 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.81 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8093.9 ± 156.07
  RR:       0.31095318705822955 ± 0.00521202383961691
    -> ΔwoRP: 0.0009452580883079209 ± 0.00521202383961691
  DET:      0.6954296961431241 ± 0.009946603063276238
    -> ΔwoRP: -0.0003488558811616249 ± 0.009946603063276238
  L:        2.8159643890591006 ± 0.04078303192989796
    -> ΔwoRP: -0.0008697870482206049 ± 0.04078303192989796
  ENTR:     1.244458359687937 ± 0.021544017472557523
    -> ΔwoRP: -0.0034565055343229734 ± 0.021544017472557523

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 8127
  RR:       0.30611192297773576 (ΔwoRP: -0.003896005992185869)
  DET:      0.6778994664420107 (ΔwoRP: -0.017879085582275023)
  L:        2.8300117233294255 (ΔwoRP: 0.013177547222104291)
  ENTR:     1.2183067996289512 (ΔwoRP: -0.029608065593308863)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     0.63 ms
allocations: 108
storage:     99.86 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.51 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4452.6 ± 75.21
  RR:       0.4493040849657106 ± 0.007583419157489129
    -> ΔwoRP: 0.13929615599578898 ± 0.007583419157489129
  DET:      0.6959239999999999 ± 0.010178768654966645
    -> ΔwoRP: 0.00014544797571414136 ± 0.010178768654966645
  L:        2.8180977179756637 ± 0.027148551941996134
    -> ΔwoRP: 0.0012635418683424327 ± 0.027148551941996134
  ENTR:     1.2474500189272653 ± 0.018285699181017436
    -> ΔwoRP: -0.0004648462949947696 ± 0.018285699181017436

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)


======================================================================
 SYSTEM: KLASSE 4: DRIFT (RANDOM WALK)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     256.63 ms
allocations: 3
storage:     78.19 KiB
RR:   0.21585802044425884
DET:  0.9889694676180966
L:    34.58999692843248
ENTR: 3.5367546661084104

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     6.96 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     6.44 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184513.39 ± 4320.19
  RR:       0.23831054157317494 ± 0.01408610311545192
    -> ΔwoRP: 0.022452521128916103 ± 0.01408610311545192
  DET:      0.9889473089342893 ± 0.0008236478194450315
    -> ΔwoRP: -2.215868380728292e-5 ± 0.0008236478194450315
  L:        34.64936288473758 ± 1.9996966989845875
    -> ΔwoRP: 0.05936595630510055 ± 1.9996966989845875
  ENTR:     3.4518343299117196 ± 0.04770648993635614
    -> ΔwoRP: -0.08492033619669082 ± 0.04770648993635614

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186476
  RR:       0.22912194478966594 (ΔwoRP: 0.013263924345407102)
  DET:      0.9887612746810216 (ΔwoRP: -0.0002081929370749691)
  L:        33.12044046799725 (ΔwoRP: -1.4695564604352285)
  ENTR:     3.4562719601227028 (ΔwoRP: -0.08048270598570761)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     7.08 ms
allocations: 118
storage:     178.4 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     7.52 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197106.0 ± 4418.72
  RR:       0.2281812694226437 ± 0.012947753426131577
    -> ΔwoRP: 0.012323248978384854 ± 0.012947753426131577
  DET:      0.9891703523105568 ± 0.0007713396770704523
    -> ΔwoRP: 0.00020088469246026808 ± 0.0007713396770704523
  L:        35.17119530809072 ± 1.9445575233881844
    -> ΔwoRP: 0.5811983796582396 ± 1.9445575233881844
  ENTR:     3.4675487770138007 ± 0.045917560617972475
    -> ΔwoRP: -0.06920588909460967 ± 0.045917560617972475

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 198407
  RR:       0.2258144267998181 (ΔwoRP: 0.009956406355559277)
  DET:      0.9889733914641538 (ΔwoRP: 3.923846057185543e-6)
  L:        35.226323119777156 (ΔwoRP: 0.6363261913446792)
  ENTR:     3.4236046505015083 (ΔwoRP: -0.11315001560690208)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     6.76 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     7.18 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197082.57 ± 5389.15
  RR:       0.2280745212549455 ± 0.013612260961232792
    -> ΔwoRP: 0.012216500810686676 ± 0.013612260961232792
  DET:      0.9891767007646907 ± 0.000796919565106968
    -> ΔwoRP: 0.00020723314659409908 ± 0.000796919565106968
  L:        35.13785006968775 ± 2.081246163310937
    -> ΔwoRP: 0.5478531412552741 ± 2.081246163310937
  ENTR:     3.4679539570372047 ± 0.04708289153687421
    -> ΔwoRP: -0.06880070907120572 ± 0.04708289153687421

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 199562
  RR:       0.2438211328833257 (ΔwoRP: 0.02796311243906685)
  DET:      0.9898579031304316 (ΔwoRP: 0.000888435512335084)
  L:        38.52231520223152 (ΔwoRP: 3.9323182737990408)
  ENTR:     3.506187118408789 (ΔwoRP: -0.030567547699621223)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     2.3 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.83 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 7550.85 ± 149.39
  RR:       0.2649745719840438 ± 0.0052521145491085134
    -> ΔwoRP: 0.04911655153978495 ± 0.0052521145491085134
  DET:      0.9893029999999998 ± 0.002390691616751608
    -> ΔwoRP: 0.0003335323819032565 ± 0.002390691616751608
  L:        35.220164226411974 ± 1.8167625914771757
    -> ΔwoRP: 0.6301672979794972 ± 1.8167625914771757
  ENTR:     3.5240788389473257 ± 0.14687788515898395
    -> ΔwoRP: -0.01267582716108473 ± 0.14687788515898395

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7382
  RR:       0.270929287455974 (ΔwoRP: 0.055071267011715164)
  DET:      0.9875 (ΔwoRP: -0.0014694676180965205)
  L:        38.527089283106655 (ΔwoRP: 3.937092354674178)
  ENTR:     3.44695434022687 (ΔwoRP: -0.0898003258815403)
\\
ja nur für kleine RP, wenn dann, wie man siht für N=10000 definitiv nirgenwo gewinner in zeit
%
### 02 h : 53 min (seit dem letzten Zeitstempel)
%
# 23.08.2026
%
## ultimative kombination und optimierung von smi_LFboth und norberts_rand für alle klassen (große RP/-systeme)
%
\item ich kombiniere norberts_rand und smi_LFboth und nutze zur abschätzung ob periodisch oder nciht die linienlänge von den linien gehörig zu x (x=??) random sampled schwarzen punkten
%
\item wie viele punkte: x=?? und wie lang müssen die linien sein/wie lange verfolgen wir? und weshalb? und wie implementiere ich den test/die abschätzung am besten?
%
\item gemini sagt 5 Punkte und 50 folgeschritte. zunächst nutze ich das. und implementieren muss extra am anfang sein, da alles wo ich das mit hinzufügen könnte im smi sampling ja unnötig durchzuführen ist, in dem Fall, dass es sich um ein ausreichend periodisches system handelt?! oder ist es vielleicht ebsser das in die estimation der aktiven und inaktiven boxen zu packen? weil es nur wenige periodische systeme gibt und ich packe eine variable dazu "check_periodic in {True, False}", dass der test durchgeführt wird, falls gewollt und sonst einfach normal smi_LFboth durchläuft?!
%
\item ich frage gemini: machen wa so
%
\item 2 h später alles fertig und optimiert in sachen hybridisierung
%
\item ergebnisse:
\\
======================================================================
 SYSTEM: KLASSE 1: CHAOS (ROESSLER SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     224.89 ms
allocations: 3
storage:     78.19 KiB
RR:   0.08277577808439872
DET:  0.9984392508670275
L:    23.776464002619335
ENTR: 3.864856330212997

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     13.38 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     11.92 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 508706.58 ± 14533.94
  RR:       0.08342405504864389 ± 0.002486033971164374
    -> ΔwoRP: 0.000648276964245173 ± 0.002486033971164374
  DET:      0.9984349491657691 ± 0.00018407709524725075
    -> ΔwoRP: -4.301701258313528e-6 ± 0.00018407709524725075
  L:        23.78325851146741 ± 0.520885500673424
    -> ΔwoRP: 0.006794508848074088 ± 0.520885500673424
  ENTR:     3.8376861127570514 ± 0.019166670961621602
    -> ΔwoRP: -0.02717021745594561 ± 0.019166670961621602

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 519978
  RR:       0.08339741672718987 (ΔwoRP: 0.0006216386427911474)
  DET:      0.9984418356456777 (ΔwoRP: 2.5847786502275483e-6)
  L:        24.274519979242346 (ΔwoRP: 0.4980559766230108)
  ENTR:     3.8683954386281174 (ΔwoRP: 0.0035391084151203955)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     9.53 ms
allocations: 94
storage:     177.34 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     8.56 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595272.41 ± 19629.13
  RR:       0.0755538907495389 ± 0.0022643864051339903
    -> ΔwoRP: -0.007221887334859817 ± 0.0022643864051339903
  DET:      0.9985806603373234 ± 0.00017743049757559714
    -> ΔwoRP: 0.00014140947029595008 ± 0.00017743049757559714
  L:        24.976788949688697 ± 0.5255741491486806
    -> ΔwoRP: 1.2003249470693618 ± 0.5255741491486806
  ENTR:     3.8545555137763166 ± 0.018813127367238232
    -> ΔwoRP: -0.01030081643668046 ± 0.018813127367238232

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 595449
  RR:       0.07663604019236032 (ΔwoRP: -0.006139737892038394)
  DET:      0.9987551782543926 (ΔwoRP: 0.0003159273873651891)
  L:        25.240845796802475 (ΔwoRP: 1.46438179418314)
  ENTR:     3.87017269561499 (ΔwoRP: 0.005316365401993206)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     9.21 ms
allocations: 50
storage:     175.34 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     10.62 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 594909.68 ± 17723.24
  RR:       0.07578905210228999 ± 0.0022601926408702703
    -> ΔwoRP: -0.006986725982108727 ± 0.0022601926408702703
  DET:      0.9985895196082092 ± 0.00017579344643213284
    -> ΔwoRP: 0.00015026874118173605 ± 0.00017579344643213284
  L:        25.03010789870467 ± 0.5144216498848114
    -> ΔwoRP: 1.253643896085336 ± 0.5144216498848114
  ENTR:     3.8564740722762263 ± 0.01917852657837239
    -> ΔwoRP: -0.00838225793677072 ± 0.01917852657837239

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 622976
  RR:       0.07297521851023114 (ΔwoRP: -0.009800559574167575)
  DET:      0.9986025195750016 (ΔwoRP: 0.00016326870797411797)
  L:        25.150621118012424 (ΔwoRP: 1.3741571153930892)
  ENTR:     3.8658099402424124 (ΔwoRP: 0.0009536100294154082)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     1.81 ms
allocations: 56
storage:     97.44 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.5 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22884.06 ± 519.14
  RR:       0.08738632929379112 ± 0.0017270321264622362
    -> ΔwoRP: 0.004610551209392397 ± 0.0017270321264622362
  DET:      0.9985337406277243 ± 0.0008703506273412146
    -> ΔwoRP: 9.448976069681425e-5 ± 0.0008703506273412146
  L:        24.4721334633202 ± 0.631363844704839
    -> ΔwoRP: 0.6956694607008664 ± 0.631363844704839
  ENTR:     3.846181452976948 ± 0.0232949323954127
    -> ΔwoRP: -0.018674877236048992 ± 0.0232949323954127

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     1.62 ms
allocations: 80
storage:     98.57 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.96 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22891.67 ± 519.62
  RR:       0.0873575022574735 ± 0.00173863386479554
    -> ΔwoRP: 0.004581724173074786 ± 0.00173863386479554
  DET:      0.998588244872662 ± 0.0008158519023330019
    -> ΔwoRP: 0.00014899400563450627 ± 0.0008158519023330019
  L:        24.511070464169137 ± 0.6507161162876998
    -> ΔwoRP: 0.7346064615498022 ± 0.6507161162876998
  ENTR:     3.848114752414725 ± 0.022978233597176878
    -> ΔwoRP: -0.01674157779827201 ± 0.022978233597176878

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     1.47 ms
allocations: 96
storage:     99.3 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.56 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22893.33 ± 526.51
  RR:       0.08735751552897733 ± 0.0017684257110305928
    -> ΔwoRP: 0.004581737444578612 ± 0.0017684257110305928
  DET:      0.9985501923076924 ± 0.0008642992817627216
    -> ΔwoRP: 0.0001109414406649245 ± 0.0008642992817627216
  L:        24.486012991923737 ± 0.6415868121315141
    -> ΔwoRP: 0.7095489893044018 ± 0.6415868121315141
  ENTR:     3.846439565512741 ± 0.023325796990014552
    -> ΔwoRP: -0.018416764700256216 ± 0.023325796990014552

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)


======================================================================
 SYSTEM: KLASSE 1: CHAOS (LORENZ SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     224.84 ms
allocations: 3
storage:     78.19 KiB
RR:   0.12050202018220797
DET:  0.9998998789325514
L:    40.53190731895452
ENTR: 4.524222130528146

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     14.33 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     15.12 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 590352.82 ± 12981.54
  RR:       0.12489789050211574 ± 0.004737220815129429
    -> ΔwoRP: 0.004395870319907763 ± 0.004737220815129429
  DET:      0.9998989991679541 ± 3.4734761339312825e-5
    -> ΔwoRP: -8.79764597283561e-7 ± 3.4734761339312825e-5
  L:        40.54502620811346 ± 1.3212179450452053
    -> ΔwoRP: 0.01311888915894599 ± 1.3212179450452053
  ENTR:     4.440411797287928 ± 0.027923547845286795
    -> ΔwoRP: -0.08381033324021736 ± 0.027923547845286795

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 617671
  RR:       0.11708743063717104 (ΔwoRP: -0.003414589545036928)
  DET:      0.9998602375960867 (ΔwoRP: -3.964133646472412e-5)
  L:        39.56460532931121 (ΔwoRP: -0.9673019896433033)
  ENTR:     4.415985716337583 (ΔwoRP: -0.10823641419056251)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     22.97 ms
allocations: 132
storage:     203.07 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     27.86 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 769677.21 ± 19152.47
  RR:       0.10081998606429315 ± 0.003739529848597669
    -> ΔwoRP: -0.019682034117914818 ± 0.003739529848597669
  DET:      0.9999086982324863 ± 3.397476471618782e-5
    -> ΔwoRP: 8.81929993490349e-6 ± 3.397476471618782e-5
  L:        41.87657019171826 ± 1.3185035330455632
    -> ΔwoRP: 1.3446628727637417 ± 1.3185035330455632
  ENTR:     4.470889522299418 ± 0.02830180059841259
    -> ΔwoRP: -0.053332608228727985 ± 0.02830180059841259

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 813909
  RR:       0.0970121861694318 (ΔwoRP: -0.02348983401277617)
  DET:      0.9999172342035566 (ΔwoRP: 1.7355271005214945e-5)
  L:        42.433015554440544 (ΔwoRP: 1.9011082354860278)
  ENTR:     4.493282877959766 (ΔwoRP: -0.030939252568379594)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     20.2 ms
allocations: 108
storage:     202.03 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     21.2 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 769547.16 ± 21428.4
  RR:       0.10087916217582436 ± 0.004041687997022384
    -> ΔwoRP: -0.01962285800638361 ± 0.004041687997022384
  DET:      0.9999090432723573 ± 3.291605662967053e-5
    -> ΔwoRP: 9.164339805911581e-6 ± 3.291605662967053e-5
  L:        41.90306958059415 ± 1.3907889585116637
    -> ΔwoRP: 1.3711622616396326 ± 1.3907889585116637
  ENTR:     4.470774722209031 ± 0.027826028388030808
    -> ΔwoRP: -0.053447408319114764 ± 0.027826028388030808

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 817442
  RR:       0.09489365494296578 (ΔwoRP: -0.02560836523924219)
  DET:      0.9999157205292751 (ΔwoRP: 1.5841596723742413e-5)
  L:        41.6708479678876 (ΔwoRP: 1.1389406489330867)
  ENTR:     4.442449861300334 (ΔwoRP: -0.08177226922781156)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     2.2 ms
allocations: 94
storage:     123.28 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.99 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 15287.76 ± 369.06
  RR:       0.13083772864588802 ± 0.00279567230751926
    -> ΔwoRP: 0.010335708463680052 ± 0.00279567230751926
  DET:      0.9998965 ± 0.00023041449789636438
    -> ΔwoRP: -3.378932551423297e-6 ± 0.00023041449789636438
  L:        41.00739101887751 ± 1.1190753606268191
    -> ΔwoRP: 0.47548369992299655 ± 1.1190753606268191
  ENTR:     4.468357042038608 ± 0.02998977366689324
    -> ΔwoRP: -0.05586508848953731 ± 0.02998977366689324

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     2.01 ms
allocations: 102
storage:     84.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.98 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 56848.04 ± 149285.97
  RR:       0.13111926210035219 ± 0.0032115091558319294
    -> ΔwoRP: 0.010617241918144213 ± 0.0032115091558319294
  DET:      0.9999026869999713 ± 0.00020200012903147006
    -> ΔwoRP: 2.8080674199237876e-6 ± 0.00020200012903147006
  L:        41.03119064146713 ± 1.203297335020805
    -> ΔwoRP: 0.49928332251261054 ± 1.203297335020805
  ENTR:     4.467962772527838 ± 0.032765605572643776
    -> ΔwoRP: -0.05625935800030746 ± 0.032765605572643776

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     2.54 ms
allocations: 90
storage:     84.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.13 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 51495.32 ± 139581.64
  RR:       0.13089218842540482 ± 0.0031307132365303875
    -> ΔwoRP: 0.010390168243196843 ± 0.0031307132365303875
  DET:      0.9999032996797206 ± 0.00020526536602318024
    -> ΔwoRP: 3.420747169191607e-6 ± 0.00020526536602318024
  L:        40.97330493754724 ± 1.2012150536802457
    -> ΔwoRP: 0.441397618592724 ± 1.2012150536802457
  ENTR:     4.466612396871079 ± 0.03205163314180888
    -> ΔwoRP: -0.0576097336570669 ± 0.03205163314180888

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)


======================================================================
 SYSTEM: KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     189.21 ms
allocations: 3
storage:     78.19 KiB
RR:   0.16869916168804264
DET:  0.9998969369319293
L:    6.370145543977406
ENTR: 1.9267486031067216

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     1.6 ms
allocations: 57
storage:     159.4 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.46 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 66976.2 ± 1849.39
  RR:       0.16978803766644698 ± 0.07576718835364198
    -> ΔwoRP: 0.0010888759784043467 ± 0.07576718835364198
  DET:      0.9998806025370148 ± 0.00011562702540932748
    -> ΔwoRP: -1.633439491444122e-5 ± 0.00011562702540932748
  L:        6.371839468026566 ± 2.832200544357119
    -> ΔwoRP: 0.0016939240491602447 ± 2.832200544357119
  ENTR:     1.9175289163818194 ± 0.029786932789831553
    -> ΔwoRP: -0.009219686724902143 ± 0.029786932789831553

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 68745
  RR:       0.310202283300289 (ΔwoRP: 0.14150312161224635)
  DET:      0.9999164508313142 (ΔwoRP: 1.9513899384926425e-5)
  L:        11.97997997997998 (ΔwoRP: 5.609834436002574)
  ENTR:     1.9878967476966698 (ΔwoRP: 0.06114814458994822)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     2.8 ms
allocations: 64
storage:     178.92 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.42 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100600.61 ± 3248.91
  RR:       0.14908415619234697 ± 0.06081870998356716
    -> ΔwoRP: -0.01961500549569567 ± 0.06081870998356716
  DET:      0.999896097874977 ± 0.00010361032685857367
    -> ΔwoRP: -8.390569522509495e-7 ± 0.00010361032685857367
  L:        8.220453049265364 ± 3.3504989102955305
    -> ΔwoRP: 1.850307505287958 ± 3.3504989102955305
  ENTR:     2.2051079344495816 ± 0.03214699882373011
    -> ΔwoRP: 0.27835933134286006 ± 0.03214699882373011

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 96342
  RR:       0.1274874859776963 (ΔwoRP: -0.04121167571034634)
  DET:      0.9998521147589471 (ΔwoRP: -4.482217298218405e-5)
  L:        6.767767767767768 (ΔwoRP: 0.3976222237903615)
  ENTR:     2.2395955728017842 (ΔwoRP: 0.31284696969506265)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     2.56 ms
allocations: 96
storage:     178.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.51 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100661.47 ± 3143.9
  RR:       0.15109806926579725 ± 0.06098444459660928
    -> ΔwoRP: -0.01760109242224539 ± 0.06098444459660928
  DET:      0.9998947489717905 ± 0.00010221070592481669
    -> ΔwoRP: -2.187960138733125e-6 ± 0.00010221070592481669
  L:        8.337727094646295 ± 3.3692814780127653
    -> ΔwoRP: 1.9675815506688892 ± 3.3692814780127653
  ENTR:     2.205611205676296 ± 0.030975425818456595
    -> ΔwoRP: 0.2788626025695746 ± 0.030975425818456595

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 99457
  RR:       0.1722890020889068 (ΔwoRP: 0.0035898404008641582)
  DET:      0.9998936453070991 (ΔwoRP: -3.291624830148443e-6)
  L:        9.41091091091091 (ΔwoRP: 3.0407653669335044)
  ENTR:     2.230790756844401 (ΔwoRP: 0.3040421537376796)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     14.95 ms
allocations: 84
storage:     98.74 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     14.19 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11062.95 ± 363.49
  RR:       0.18097150264133569 ± 0.00573060253923667
    -> ΔwoRP: 0.012272340953293048 ± 0.00573060253923667
  DET:      0.9998919999999998 ± 0.00023535375797167023
    -> ΔwoRP: -4.9369319294889635e-6 ± 0.00023535375797167023
  L:        6.953777203234047 ± 0.357943945433472
    -> ΔwoRP: 0.5836316592566408 ± 0.357943945433472
  ENTR:     2.029071404807512 ± 0.05820681253084431
    -> ΔwoRP: 0.10232280170079044 ± 0.05820681253084431

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     14.59 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     14.1 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11057.04 ± 381.37
  RR:       0.18100523235050964 ± 0.005738632706041343
    -> ΔwoRP: 0.012306070662467 ± 0.005738632706041343
  DET:      0.9999035 ± 0.00022910748621605056
    -> ΔwoRP: 6.563068070675193e-6 ± 0.00022910748621605056
  L:        6.952111211095281 ± 0.35500466969173883
    -> ΔwoRP: 0.581965667117875 ± 0.35500466969173883
  ENTR:     2.02850614847169 ± 0.0580737610974939
    -> ΔwoRP: 0.10175754536496862 ± 0.0580737610974939

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     14.33 ms
allocations: 82
storage:     98.8 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     14.27 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11073.11 ± 398.02
  RR:       0.18081115626881217 ± 0.006209327834236572
    -> ΔwoRP: 0.01211199458076953 ± 0.006209327834236572
  DET:      0.9998994999999998 ± 0.00022405345333189407
    -> ΔwoRP: 2.5630680705601705e-6 ± 0.00022405345333189407
  L:        6.966136719306557 ± 0.3734724980528796
    -> ΔwoRP: 0.5959911753291509 ± 0.3734724980528796
  ENTR:     2.030953133581799 ± 0.061211890638514656
    -> ΔwoRP: 0.1042045304750776 ± 0.061211890638514656

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)


======================================================================
 SYSTEM: KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     588.91 ms
allocations: 3
storage:     78.19 KiB
RR:   0.31000792896992163
DET:  0.6957785520242857
L:    2.8168341761073212
ENTR: 1.24791486522226

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     0.35 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.26 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8075.74 ± 154.13
  RR:       0.3115337307606195 ± 0.005408644511157735
    -> ΔwoRP: 0.0015258017906978893 ± 0.005408644511157735
  DET:      0.6955117667674653 ± 0.010329478379175108
    -> ΔwoRP: -0.0002667852568204454 ± 0.010329478379175108
  L:        2.8177875702338677 ± 0.04000232867228232
    -> ΔwoRP: 0.0009533941265464918 ± 0.04000232867228232
  ENTR:     1.2450782627868708 ± 0.022354847083860065
    -> ΔwoRP: -0.0028366024353891905 ± 0.022354847083860065

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7741
  RR:       0.32202491386164855 (ΔwoRP: 0.012016984891726923)
  DET:      0.693278463648834 (ΔwoRP: -0.002500088375451681)
  L:        2.865079365079365 (ΔwoRP: 0.048245188972043884)
  ENTR:     1.2522346512278124 (ΔwoRP: 0.004319786005552384)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     0.55 ms
allocations: 130
storage:     178.92 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.47 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8099.71 ± 155.06
  RR:       0.31090689206099326 ± 0.005290283031157501
    -> ΔwoRP: 0.0008989630910716251 ± 0.005290283031157501
  DET:      0.6958816701596297 ± 0.009655561667988527
    -> ΔwoRP: 0.0001031181353439159 ± 0.009655561667988527
  L:        2.815713041282345 ± 0.0408290192054024
    -> ΔwoRP: -0.0011211348249764441 ± 0.0408290192054024
  ENTR:     1.2451279719043753 ± 0.02125128751215009
    -> ΔwoRP: -0.002786893317884731 ± 0.02125128751215009

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7978
  RR:       0.3114241001564945 (ΔwoRP: 0.0014161711865728899)
  DET:      0.6862088218872139 (ΔwoRP: -0.009569730137071852)
  L:        2.8059360730593608 (ΔwoRP: -0.010898103047960461)
  ENTR:     1.2252810802392875 (ΔwoRP: -0.022633784982972527)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     0.57 ms
allocations: 130
storage:     178.92 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.47 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8093.7 ± 155.44
  RR:       0.31095111297944455 ± 0.00541010452157435
    -> ΔwoRP: 0.0009431840095229238 ± 0.00541010452157435
  DET:      0.6954464239613776 ± 0.010132213240336595
    -> ΔwoRP: -0.00033212806290816577 ± 0.010132213240336595
  L:        2.815934135272494 ± 0.0409654242091249
    -> ΔwoRP: -0.0009000408348271982 ± 0.0409654242091249
  ENTR:     1.2444443229989266 ± 0.02231312949835303
    -> ΔwoRP: -0.003470542223333428 ± 0.02231312949835303

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 8127
  RR:       0.30611192297773576 (ΔwoRP: -0.003896005992185869)
  DET:      0.6778994664420107 (ΔwoRP: -0.017879085582275023)
  L:        2.8300117233294255 (ΔwoRP: 0.013177547222104291)
  ENTR:     1.2183067996289512 (ΔwoRP: -0.029608065593308863)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     0.39 ms
allocations: 120
storage:     100.46 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.31 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4450.34 ± 72.06
  RR:       0.4495214712915063 ± 0.0072786672072006975
    -> ΔwoRP: 0.1395135423215847 ± 0.0072786672072006975
  DET:      0.6958644999999998 ± 0.010347364771172795
    -> ΔwoRP: 8.594797571404023e-5 ± 0.010347364771172795
  L:        2.8184931607607697 ± 0.02685924307594594
    -> ΔwoRP: 0.001658984653448492 ± 0.02685924307594594
  ENTR:     1.2474607872519783 ± 0.018972508931006243
    -> ΔwoRP: -0.000454077970281741 ± 0.018972508931006243

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     0.44 ms
allocations: 124
storage:     100.63 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.34 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4457.5 ± 73.5
  RR:       0.4488037837747431 ± 0.007407823228983937
    -> ΔwoRP: 0.13879585480482148 ± 0.007407823228983937
  DET:      0.6959364999999998 ± 0.010204918329320828
    -> ΔwoRP: 0.00015794797571411223 ± 0.010204918329320828
  L:        2.8182832555067603 ± 0.026697745378601142
    -> ΔwoRP: 0.0014490793994390572 ± 0.026697745378601142
  ENTR:     1.247520706187345 ± 0.018500156105590766
    -> ΔwoRP: -0.00039415903491502036 ± 0.018500156105590766

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     0.4 ms
allocations: 96
storage:     99.35 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.35 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4457.5 ± 75.45
  RR:       0.44881032129754383 ± 0.007603104347211809
    -> ΔwoRP: 0.1388023923276222 ± 0.007603104347211809
  DET:      0.6951805 ± 0.010338716497167767
    -> ΔwoRP: -0.0005980520242857557 ± 0.010338716497167767
  L:        2.817077245956509 ± 0.026599464097733803
    -> ΔwoRP: 0.00024306984918798236 ± 0.026599464097733803
  ENTR:     1.2459818269737284 ± 0.018885478735657695
    -> ΔwoRP: -0.0019330382485316377 ± 0.018885478735657695

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)


======================================================================
 SYSTEM: KLASSE 4: DRIFT (RANDOM WALK)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     164.55 ms
allocations: 3
storage:     78.19 KiB
RR:   0.21585802044425884
DET:  0.9889694676180966
L:    34.58999692843248
ENTR: 3.5367546661084104

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     5.1 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     5.08 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184667.79 ± 4067.79
  RR:       0.23764411872067426 ± 0.013735038330243435
    -> ΔwoRP: 0.021786098276415422 ± 0.013735038330243435
  DET:      0.9889236730712357 ± 0.0007932512955191145
    -> ΔwoRP: -4.5794546860822294e-5 ± 0.0007932512955191145
  L:        34.577083848649146 ± 1.9586247158914203
    -> ΔwoRP: -0.012913079783331227 ± 1.9586247158914203
  ENTR:     3.4513709722581307 ± 0.04505065302088549
    -> ΔwoRP: -0.08538369385027966 ± 0.04505065302088549

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186476
  RR:       0.22912194478966594 (ΔwoRP: 0.013263924345407102)
  DET:      0.9887612746810216 (ΔwoRP: -0.0002081929370749691)
  L:        33.12044046799725 (ΔwoRP: -1.4695564604352285)
  ENTR:     3.4562719601227028 (ΔwoRP: -0.08048270598570761)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     8.32 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     6.85 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 196990.67 ± 4533.69
  RR:       0.22880694993058598 ± 0.013653471377900597
    -> ΔwoRP: 0.012948929486327143 ± 0.013653471377900597
  DET:      0.9892136351141605 ± 0.0008061647144062608
    -> ΔwoRP: 0.0002441674960639295 ± 0.0008061647144062608
  L:        35.22838093579026 ± 2.081332688263939
    -> ΔwoRP: 0.6383840073577858 ± 2.081332688263939
  ENTR:     3.467990662554492 ± 0.04632508047377854
    -> ΔwoRP: -0.06876400355391832 ± 0.04632508047377854

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 198407
  RR:       0.2258144267998181 (ΔwoRP: 0.009956406355559277)
  DET:      0.9889733914641538 (ΔwoRP: 3.923846057185543e-6)
  L:        35.226323119777156 (ΔwoRP: 0.6363261913446792)
  ENTR:     3.4236046505015083 (ΔwoRP: -0.11315001560690208)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     6.81 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     6.38 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197243.12 ± 5394.47
  RR:       0.22760673054251193 ± 0.01328075062177165
    -> ΔwoRP: 0.011748710098253096 ± 0.01328075062177165
  DET:      0.9891533329043793 ± 0.0007679311185646214
    -> ΔwoRP: 0.00018386528628278054 ± 0.0007679311185646214
  L:        35.1158046096312 ± 1.9812709493904044
    -> ΔwoRP: 0.5258076811987209 ± 1.9812709493904044
  ENTR:     3.4676253198400233 ± 0.044778225135162913
    -> ΔwoRP: -0.06912934626838707 ± 0.044778225135162913

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 199562
  RR:       0.2438211328833257 (ΔwoRP: 0.02796311243906685)
  DET:      0.9898579031304316 (ΔwoRP: 0.000888435512335084)
  L:        38.52231520223152 (ΔwoRP: 3.9323182737990408)
  ENTR:     3.506187118408789 (ΔwoRP: -0.030567547699621223)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     1.63 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.47 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 7548.64 ± 143.23
  RR:       0.265043906715642 ± 0.005048220121087717
    -> ΔwoRP: 0.04918588627138315 ± 0.005048220121087717
  DET:      0.9890134999999995 ± 0.002415450714080534
    -> ΔwoRP: 4.4032381902980866e-5 ± 0.002415450714080534
  L:        35.0834651773022 ± 1.781160927604802
    -> ΔwoRP: 0.49346824886972485 ± 1.781160927604802
  ENTR:     3.506475240407896 ± 0.14488125492049653
    -> ΔwoRP: -0.03027942570051456 ± 0.14488125492049653

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7382
  RR:       0.270929287455974 (ΔwoRP: 0.055071267011715164)
  DET:      0.9875 (ΔwoRP: -0.0014694676180965205)
  L:        38.527089283106655 (ΔwoRP: 3.937092354674178)
  ENTR:     3.44695434022687 (ΔwoRP: -0.0898003258815403)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     4.78 ms
allocations: 94
storage:     83.05 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     7.6 ms
allocations: 122
storage:     84.37 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 125193.2 ± 83790.74
  RR:       0.2697293405836829 ± 0.013485651041751942
    -> ΔwoRP: 0.053871320139424084 ± 0.013485651041751942
  DET:      0.9890209103865348 ± 0.0014593416089152432
    -> ΔwoRP: 5.1442768438270114e-5 ± 0.0014593416089152432
  L:        34.689601896060054 ± 1.867128558027339
    -> ΔwoRP: 0.09960496762757742 ± 1.867128558027339
  ENTR:     3.4747993221382143 ± 0.09398710806707539
    -> ΔwoRP: -0.061955343970196086 ± 0.09398710806707539

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186706
  RR:       0.261282444056431 (ΔwoRP: 0.04542442361217214)
  DET:      0.9887255806325974 (ΔwoRP: -0.00024388698549915322)
  L:        33.26413793103448 (ΔwoRP: -1.3258589973979937)
  ENTR:     3.4532498097039555 (ΔwoRP: -0.08350485640445493)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     4.46 ms
allocations: 122
storage:     84.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.0 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 118422.7 ± 85794.17
  RR:       0.2709309168241466 ± 0.015223512035361923
    -> ΔwoRP: 0.05507289637988777 ± 0.015223512035361923
  DET:      0.9889800947785196 ± 0.0016192243642175117
    -> ΔwoRP: 1.0627160422993498e-5 ± 0.0016192243642175117
  L:        34.89391590998982 ± 2.0399936282752673
    -> ΔwoRP: 0.3039189815573451 ± 2.0399936282752673
  ENTR:     3.47218447939052 ± 0.09848040746104242
    -> ΔwoRP: -0.06457018671789028 ± 0.09848040746104242

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7382
  RR:       0.270929287455974 (ΔwoRP: 0.055071267011715164)
  DET:      0.9875 (ΔwoRP: -0.0014694676180965205)
  L:        38.527089283106655 (ΔwoRP: 3.937092354674178)
  ENTR:     3.44695434022687 (ΔwoRP: -0.0898003258815403)

%
\item interpretation:\\
arsch. vermutung: hat bei klasse 3 harmonsicher oszillator periodisch gar nciht geswitched und norberts genommen, so scheiße sind die werte (laufzeit). \\
\\\\
TODO:\\
print einbauen, wenn norberts benutzt wird und bedingung optimieren und vlt auch implementierung noch irwie?! \\
und dann noch die optimierung von smi_LFboth für Drift, noise und chaotic
\\
achso und die Entropy-werte sind wieder negativ. why??????????
%
### 02 h : 30 min (seit dem letzten Zeitstempel)
%
# 27.08.2026
%
\item anpassungen gestartet (dicke ränder) muss noch verstehen was das ist und weshalb und anpassungen ncoh fertig machen und optimieren und dann noch entropy stuff
%
### paar minuten (seit dem letzten Zeitstempel)
%
# 02.09.2026
%
## anpassung von hybrid und optimierung smi_LFboth
%
\item dicke ränder verstehen, die bei harmonischem osz auftreten und bei der bedingung "drei linien mit mindestens länge 50 finden und wenn eine untersuchte linie/punkt dem nicht entspricht wird suche sofort aufgegeben " dafür sorgt, dass Norberts algo nicht aktiviert wird
\\
\Rightarrow bedingung ändern auf drei linien a 50 bleibt, aber es wird erst die suche abgebrochen (check_periodicity = false), wenn 3 linien gefunden und damit is_periodic = true oder 10 mal versucht und keine 3 linien a mind 50 gefunden, also is_periodic = false bleibt
\\
klingt allg sinnvoll, aber was hat das mit den dicken Rändern zu tun?\\
ahh, das ist der bumms mit (2, 2+periodendauer) = black, aber da perfekt kontinuierlich/sys bewegt sich so langsam so wenig magnitude weit weg von dem Punkt (2, 2) = (2, 2+pd) im phasenraum, dass (2, 2+pd \pm 1) = black und womöglich noch weiter (2, 2+pd \pm 2) = black usw. und dadurch entsteht ein "fehler", also eine super dicke schwarze diagonale/super viele diagonale, welche effektiv in bedeutung nur einer diagonalen entspricht/entsprechen?! dieses phänomen tritt aber nicht notwendigerweise entlang der gesamten effektiven/echten diagonalen auf. z.b. bei dem pendel wird die diagonale "dick" an den wendepunkten, wo das pendel super langsam ist und im phasenraum (ort, impuls) sich auch kaum bewegt, also viele schwarze punkt in der waagrechten/senkrechten. und dann wenn quasi alles kinetische energie ist, am ?apex? der pendel bewegung, wird es wahrscheinlich gar keine senkrechten/waagerechten linien geben.\\
das ist äquivalent zu kurzen diagonalen linien parallel zur echten/effektiven diagonalen, welche natürlich die zählung allgemein und auch das einschätzen, nach dem längenkriterium ob is_periodic = true/false verfälschen!! \\
darum also mehr versuche um diese linien nicht fälschlicherweise als nachweis für ein nicht periodisches system zu nutzen.
\\
außerdem sollte ich dies allgemein in meinem sampling und bie norbert noch irwie berücksichtigen?? 
\\
ist es genug nur anzupassen, dass ich 10 versuche mache (generell eher dynamisch an die system größe oder zeitreihen größe anpassen, wie die geforderte linienlänge auch??), statt sofort abzubrechen, wenn eine linie nicht lang genug ist (v.A. in meinem diagonal durchlaufen, wo ich je nach boxlänge ja auch die selbe lange oder nicht so lange, aber über mehrere boxen gehende linie mehrfach entlang gehe und schaue ob die 50 lang ist)?? da gibt es irwie noch ein besseres kriterium bestimmt!?!
%
\item shannon entropie und weshalb sind die werte negativ?
\\
DUMM!! nur differenz ist negativ, werte sind pos (da hatte ich irwann mal was angepasst auch, was nochmal??)
\\
gemini meinte irwas von wegen die linien die an den rändern abgeschnitten werden, aber eigentlich noch wieter gehen führen zu problemen und man könne die einfach ignorieren und dadurch smi_LFboth für Drift und Noise optimieren. Erstmal das verstehen, bevor ich was mache.
\\
und davor ncoh kurz testen ob durch die kriterium anpassung nun überhaupt der switch zu norberts funktioniert, für periodisch (bisher nur harm osz)
%
### 01 h : 20 min (seit dem letzten Zeitstempel)
%
# 03.09.2026
%
## kriterium für periodität anpassen, bzw. im Zuge dessen vlt boxenlänge verbessern
%
## ne, nur kriterium anpassen
%
\item problem ist auch chaotische systeme können längere diagonale erzeugen im RP und demnach, kann es sein, dass sich eine diagonale durch die ersten drei boxen zieht und dadurch direkt drie mal gefunden wird und is_periodic = true erzeugt, obwohl nicht stimmt
\\
\Rightarrow nur jeden max(1, floor(int, N/10)) schwarzen punkt in beide richtungen entlang gehen und auf linienlänge prüfen??
\\
anscheinend unfug, gemini:\\
Die algorithmische Belastbarkeit dieses Sub-Samplings ist sehr gering.  Problem A (Verhungern): Wenn du ein extrem dünnes chaotisches System hast (z. B. Rössler mit einer Recurrence Rate von 1%), findest du in Phase 1 vielleicht insgesamt nur 200 schwarze Punkte. Wenn $N=10000$ ist, würdest du nur jeden 1000. Punkt prüfen. Dein Check würde niemals auslösen, die Heuristik wäre tot.Problem B (Der Zufall): Da du in Phase 1 zufällig (rand) in die Boxen greifst, könntest du selbst beim 1000. und 2000. Treffer durch reinen Zufall exakt dieselbe lange laminare Diagonale treffen, da diese sich bei Chaos oft durch die gesamte Matrix zieht. Das Kernproblem bleibt bestehen.
\\
?!? ist nochmal zu prüfen und zu verstehen, aber zunächst mal code einmal testen und dann verschönern und vlt eine versuchen mit wiedererkennen von schon geprüften diagonalen und die dann nciht nochmal prüfen und so die max 10 (dynamisch irwie besser?) prüfungen nicht zu vershwenden und die drei zu findenden nicht zu verfälschen.
%
\item einmal testlauf mit dem alten (ganz normal die boxen durchgehen und aktiveieren, wenn ein schwarzer gefunden und immer wenn ein schwarzer gefunden und noch keine zehn schwarze gefunden, wird geprüft auf linienlänge und falls drei ausreichend lange linien gefunden oder 10 schwarze punkte geprüft/gefunden, dann abbruch der linienlänge prüfungen und entweder weiter die boxen aktivieren oder nicht und dann smi_LFboth oder abbruch des ganzen boxen samplings und Norbert):
\\
======================================================================
 SYSTEM: KLASSE 1: CHAOS (ROESSLER SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     204.19 ms
allocations: 3
storage:     78.19 KiB
RR:   0.08277577808439872
DET:  0.9984392508670275
L:    23.776464002619335
ENTR: 3.864856330212997

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     10.69 ms
allocations: 105
storage:     161.65 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     9.63 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 508796.42 ± 13791.97
  RR:       0.08341238482715907 ± 0.0024326923225511483
    -> ΔwoRP: 0.0006366067427603511 ± 0.0024326923225511483
  DET:      0.9984317855313231 ± 0.0001934593108531062
    -> ΔwoRP: -7.465335704393006e-6 ± 0.0001934593108531062
  L:        23.768788558530716 ± 0.5281467026007468
    -> ΔwoRP: -0.007675444088619088 ± 0.5281467026007468
  ENTR:     3.836840382443788 ± 0.01885773383134411
    -> ΔwoRP: -0.028015947769209237 ± 0.01885773383134411

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 519978
  RR:       0.08339741672718987 (ΔwoRP: 0.0006216386427911474)
  DET:      0.9984418356456777 (ΔwoRP: 2.5847786502275483e-6)
  L:        24.274519979242346 (ΔwoRP: 0.4980559766230108)
  ENTR:     3.8683954386281174 (ΔwoRP: 0.0035391084151203955)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     7.64 ms
allocations: 70
storage:     176.21 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     7.67 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595892.92 ± 15205.62
  RR:       0.07565363892611977 ± 0.0022117836549409306
    -> ΔwoRP: -0.007122139158278945 ± 0.0022117836549409306
  DET:      0.9985829857580915 ± 0.00017830047503337797
    -> ΔwoRP: 0.00014373489106400683 ± 0.00017830047503337797
  L:        25.014304586871635 ± 0.527388510586746
    -> ΔwoRP: 1.2378405842523001 ± 0.527388510586746
  ENTR:     3.855549634510264 ± 0.019476619528486117
    -> ΔwoRP: -0.009306695702733236 ± 0.019476619528486117

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 595449
  RR:       0.07663604019236032 (ΔwoRP: -0.006139737892038394)
  DET:      0.9987551782543926 (ΔwoRP: 0.0003159273873651891)
  L:        25.240845796802475 (ΔwoRP: 1.46438179418314)
  ENTR:     3.87017269561499 (ΔwoRP: 0.005316365401993206)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     6.99 ms
allocations: 54
storage:     175.45 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     7.16 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595501.37 ± 16067.91
  RR:       0.0756172996846728 ± 0.002252189288301285
    -> ΔwoRP: -0.007158478399725915 ± 0.002252189288301285
  DET:      0.9985725994843807 ± 0.000179251286766336
    -> ΔwoRP: 0.0001333486173532572 ± 0.000179251286766336
  L:        24.995035062256658 ± 0.5179591708859628
    -> ΔwoRP: 1.2185710596373234 ± 0.5179591708859628
  ENTR:     3.854491083809051 ± 0.018983367971698868
    -> ΔwoRP: -0.010365246403945871 ± 0.018983367971698868

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 622976
  RR:       0.07297521851023114 (ΔwoRP: -0.009800559574167575)
  DET:      0.9986025195750016 (ΔwoRP: 0.00016326870797411797)
  L:        25.150621118012424 (ΔwoRP: 1.3741571153930892)
  ENTR:     3.8658099402424124 (ΔwoRP: 0.0009536100294154082)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     1.29 ms
allocations: 100
storage:     99.5 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.25 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22914.51 ± 470.06
  RR:       0.08731549799345602 ± 0.0017941330917050666
    -> ΔwoRP: 0.004539719909057299 ± 0.0017941330917050666
  DET:      0.9985129615384617 ± 0.0008715463676027417
    -> ΔwoRP: 7.371067143424614e-5 ± 0.0008715463676027417
  L:        24.486568708828695 ± 0.6415156497708749
    -> ΔwoRP: 0.7101047062093606 ± 0.6415156497708749
  ENTR:     3.8468166067416405 ± 0.022905174899093158
    -> ΔwoRP: -0.018039723471356517 ± 0.022905174899093158

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     1.34 ms
allocations: 96
storage:     99.29 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.38 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22916.32 ± 590.49
  RR:       0.08725092533615894 ± 0.001801987973065991
    -> ΔwoRP: 0.0044751472517602225 ± 0.001801987973065991
  DET:      0.9985646418318525 ± 0.000874662392680801
    -> ΔwoRP: 0.00012539096482500067 ± 0.000874662392680801
  L:        24.48889044101591 ± 0.6072319125723629
    -> ΔwoRP: 0.7124264383965766 ± 0.6072319125723629
  ENTR:     3.847312545150589 ± 0.023318272995400183
    -> ΔwoRP: -0.017543785062407835 ± 0.023318272995400183

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     9.8 ms
allocations: 85
storage:     82.6 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     11.41 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 508388.46 ± 14358.71
  RR:       0.09032184810355864 ± 0.002875639290471997
    -> ΔwoRP: 0.007546070019159926 ± 0.002875639290471997
  DET:      0.9984347668965419 ± 0.0001894325664973474
    -> ΔwoRP: -4.4839704855803575e-6 ± 0.0001894325664973474
  L:        23.78754689372264 ± 0.5187973286008108
    -> ΔwoRP: 0.011082891103306736 ± 0.5187973286008108
  ENTR:     3.8373354778854325 ± 0.019533359988064915
    -> ΔwoRP: -0.027520852327564516 ± 0.019533359988064915

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 518941
  RR:       0.09022412952532176 (ΔwoRP: 0.00744835144092304)
  DET:      0.9984622284872173 (ΔwoRP: 2.2977620189879033e-5)
  L:        24.24740663900415 (ΔwoRP: 0.4709426363848159)
  ENTR:     3.8681823092216776 (ΔwoRP: 0.0033259790086805907)


======================================================================
 SYSTEM: KLASSE 1: CHAOS (LORENZ SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     246.09 ms
allocations: 3
storage:     78.19 KiB
RR:   0.12050202018220797
DET:  0.9998998789325514
L:    40.53190731895452
ENTR: 4.524222130528146

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     13.54 ms
allocations: 121
storage:     162.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     12.16 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 590703.87 ± 13949.65
  RR:       0.12485473951680419 ± 0.004609005722581733
    -> ΔwoRP: 0.004352719334596217 ± 0.004609005722581733
  DET:      0.9998977909426016 ± 3.607516199868929e-5
    -> ΔwoRP: -2.087989949828284e-6 ± 3.607516199868929e-5
  L:        40.552484251591515 ± 1.2595417989330289
    -> ΔwoRP: 0.02057693263699889 ± 1.2595417989330289
  ENTR:     4.439938127489199 ± 0.0279211470521388
    -> ΔwoRP: -0.08428400303894623 ± 0.0279211470521388

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 617671
  RR:       0.11708743063717104 (ΔwoRP: -0.003414589545036928)
  DET:      0.9998602375960867 (ΔwoRP: -3.964133646472412e-5)
  L:        39.56460532931121 (ΔwoRP: -0.9673019896433033)
  ENTR:     4.415985716337583 (ΔwoRP: -0.10823641419056251)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     24.45 ms
allocations: 130
storage:     178.98 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     32.3 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 771096.31 ± 19578.69
  RR:       0.10064727987140125 ± 0.0040200323216375115
    -> ΔwoRP: -0.019854740310806723 ± 0.0040200323216375115
  DET:      0.9999083643996396 ± 3.268689944900892e-5
    -> ΔwoRP: 8.485467088203968e-6 ± 3.268689944900892e-5
  L:        41.87184578138103 ± 1.3776261324750625
    -> ΔwoRP: 1.3399384624265167 ± 1.3776261324750625
  ENTR:     4.470122253471346 ± 0.027061163906272428
    -> ΔwoRP: -0.05409987705679953 ± 0.027061163906272428

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 813909
  RR:       0.0970121861694318 (ΔwoRP: -0.02348983401277617)
  DET:      0.9999172342035566 (ΔwoRP: 1.7355271005214945e-5)
  L:        42.433015554440544 (ΔwoRP: 1.9011082354860278)
  ENTR:     4.493282877959766 (ΔwoRP: -0.030939252568379594)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     19.21 ms
allocations: 132
storage:     203.05 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     19.99 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 769711.5 ± 20385.55
  RR:       0.1007244875134904 ± 0.0038722411115461115
    -> ΔwoRP: -0.019777532668717568 ± 0.0038722411115461115
  DET:      0.9999083655483436 ± 3.269101963785556e-5
    -> ΔwoRP: 8.486615792224761e-6 ± 3.269101963785556e-5
  L:        41.8431258926652 ± 1.3612508272124038
    -> ΔwoRP: 1.3112185737106827 ± 1.3612508272124038
  ENTR:     4.4704131495091115 ± 0.027727357885459242
    -> ΔwoRP: -0.053808981019034086 ± 0.027727357885459242

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 817442
  RR:       0.09489365494296578 (ΔwoRP: -0.02560836523924219)
  DET:      0.9999157205292751 (ΔwoRP: 1.5841596723742413e-5)
  L:        41.6708479678876 (ΔwoRP: 1.1389406489330867)
  ENTR:     4.442449861300334 (ΔwoRP: -0.08177226922781156)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     1.59 ms
allocations: 106
storage:     123.79 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.94 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 15294.26 ± 355.14
  RR:       0.13077639678711708 ± 0.002639306055339231
    -> ΔwoRP: 0.01027437660490911 ± 0.002639306055339231
  DET:      0.9998959999999999 ± 0.00023715024823987206
    -> ΔwoRP: -3.878932551493186e-6 ± 0.00023715024823987206
  L:        41.016316216001606 ± 1.187288229725416
    -> ΔwoRP: 0.4844088970470892 ± 1.187288229725416
  ENTR:     4.468705265131683 ± 0.030806117572669697
    -> ΔwoRP: -0.05551686539646283 ± 0.030806117572669697

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     1.64 ms
allocations: 122
storage:     84.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.34 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 52119.48 ± 140954.63
  RR:       0.13108352160219405 ± 0.0031501409865957964
    -> ΔwoRP: 0.01058150141998608 ± 0.0031501409865957964
  DET:      0.9999053618389104 ± 0.00021100074609751564
    -> ΔwoRP: 5.4829063590444704e-6 ± 0.00021100074609751564
  L:        40.942936448850766 ± 1.185160383493983
    -> ΔwoRP: 0.4110291298962494 ± 1.185160383493983
  ENTR:     4.4664193223852005 ± 0.0302754169076665
    -> ΔwoRP: -0.05780280814294514 ± 0.0302754169076665

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     12.47 ms
allocations: 121
storage:     84.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     17.04 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 590017.81 ± 14119.78
  RR:       0.13683402444786624 ± 0.005106548842811021
    -> ΔwoRP: 0.01633200426565827 ± 0.005106548842811021
  DET:      0.9998972796455766 ± 3.62124524888076e-5
    -> ΔwoRP: -2.5992869747692993e-6 ± 3.62124524888076e-5
  L:        40.52602593730883 ± 1.2558665868847863
    -> ΔwoRP: -0.00588138164568619 ± 1.2558665868847863
  ENTR:     4.440261499362628 ± 0.026990617966480758
    -> ΔwoRP: -0.08396063116551744 ± 0.026990617966480758

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 619522
  RR:       0.1270285800988504 (ΔwoRP: 0.00652655991664243)
  DET:      0.9998602233884392 (ΔwoRP: -3.965554411222705e-5)
  L:        39.56058320764203 (ΔwoRP: -0.9713241113124838)
  ENTR:     4.415893919671122 (ΔwoRP: -0.1083282108570236)


======================================================================
 SYSTEM: KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     220.08 ms
allocations: 3
storage:     78.21 KiB
RR:   0.16869916168804264
DET:  0.9998969369319293
L:    6.370145543977406
ENTR: 1.9267486031067216

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     1.45 ms
allocations: 77
storage:     160.34 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.73 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 67005.41 ± 1584.33
  RR:       0.16992439406468057 ± 0.07207958702053446
    -> ΔwoRP: 0.0012252323766379358 ± 0.07207958702053446
  DET:      0.9998791589996212 ± 0.00011760634906685551
    -> ΔwoRP: -1.7777932308060684e-5 ± 0.00011760634906685551
  L:        6.38139279592423 ± 2.706299699209825
    -> ΔwoRP: 0.011247251946823411 ± 2.706299699209825
  ENTR:     1.915531111924503 ± 0.029750080340556023
    -> ΔwoRP: -0.011217491182218486 ± 0.029750080340556023

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 68745
  RR:       0.310202283300289 (ΔwoRP: 0.14150312161224635)
  DET:      0.9999164508313142 (ΔwoRP: 1.9513899384926425e-5)
  L:        11.97997997997998 (ΔwoRP: 5.609834436002574)
  ENTR:     1.9878967476966698 (ΔwoRP: 0.06114814458994822)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     4.42 ms
allocations: 72
storage:     176.56 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.78 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100536.97 ± 2984.58
  RR:       0.15047074895592819 ± 0.05942029851944109
    -> ΔwoRP: -0.018228412732114452 ± 0.05942029851944109
  DET:      0.9998994376657214 ± 9.685840915587968e-5
    -> ΔwoRP: 2.5007337921545414e-6 ± 9.685840915587968e-5
  L:        8.293424162587419 ± 3.288603508705048
    -> ΔwoRP: 1.9232786186100128 ± 3.288603508705048
  ENTR:     2.2050429941738856 ± 0.03164624724599013
    -> ΔwoRP: 0.278294391067164 ± 0.03164624724599013

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 96342
  RR:       0.1274874859776963 (ΔwoRP: -0.04121167571034634)
  DET:      0.9998521147589471 (ΔwoRP: -4.482217298218405e-5)
  L:        6.767767767767768 (ΔwoRP: 0.3976222237903615)
  ENTR:     2.2395955728017842 (ΔwoRP: 0.31284696969506265)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     3.36 ms
allocations: 90
storage:     177.12 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.54 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100422.29 ± 3366.82
  RR:       0.15069913029576312 ± 0.060120608794137415
    -> ΔwoRP: -0.018000031392279514 ± 0.060120608794137415
  DET:      0.9999024101830243 ± 9.453242320557365e-5
    -> ΔwoRP: 5.473251095011733e-6 ± 9.453242320557365e-5
  L:        8.29657446458795 ± 3.3010898842231753
    -> ΔwoRP: 1.9264289206105438 ± 3.3010898842231753
  ENTR:     2.204571345764162 ± 0.03200323047456009
    -> ΔwoRP: 0.2778227426574402 ± 0.03200323047456009

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 99457
  RR:       0.1722890020889068 (ΔwoRP: 0.0035898404008641582)
  DET:      0.9998936453070991 (ΔwoRP: -3.291624830148443e-6)
  L:        9.41091091091091 (ΔwoRP: 3.0407653669335044)
  ENTR:     2.230790756844401 (ΔwoRP: 0.3040421537376796)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     18.3 ms
allocations: 74
storage:     100.77 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     13.99 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11057.0 ± 353.54
  RR:       0.18101877848929998 ± 0.0055441962366670535
    -> ΔwoRP: 0.012319616801257344 ± 0.0055441962366670535
  DET:      0.9999014999999999 ± 0.00022382548525099472
    -> ΔwoRP: 4.563068070617682e-6 ± 0.00022382548525099472
  L:        6.929411539451517 ± 0.3339761395037169
    -> ΔwoRP: 0.559265995474111 ± 0.3339761395037169
  ENTR:     2.025444429419005 ± 0.05404706417637174
    -> ΔwoRP: 0.09869582631228346 ± 0.05404706417637174

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     33.35 ms
allocations: 128
storage:     100.77 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     13.5 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11054.56 ± 355.59
  RR:       0.18108695656666995 ± 0.00561564571427469
    -> ΔwoRP: 0.012387794878627317 ± 0.00561564571427469
  DET:      0.9998944999999999 ± 0.00022174065689203935
    -> ΔwoRP: -2.4369319293615632e-6 ± 0.00022174065689203935
  L:        6.941300686648794 ± 0.34534415493042825
    -> ΔwoRP: 0.5711551426713877 ± 0.34534415493042825
  ENTR:     2.0277204594956113 ± 0.05732759213189946
    -> ΔwoRP: 0.10097185638888972 ± 0.05732759213189946

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     1.7 ms
allocations: 45
storage:     80.73 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.69 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 66975.98 ± 1550.51
  RR:       0.18683193870405443 ± 0.07526905799810514
    -> ΔwoRP: 0.018132777016011792 ± 0.07526905799810514
  DET:      0.9998806678932115 ± 0.00012081723625221962
    -> ΔwoRP: -1.6269038717764417e-5 ± 0.00012081723625221962
  L:        6.25813417476832 ± 2.5177973786152363
    -> ΔwoRP: -0.11201136920908628 ± 2.5177973786152363
  ENTR:     1.9167266230445479 ± 0.030639842416151853
    -> ΔwoRP: -0.010021980062173697 ± 0.030639842416151853

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 68534
  RR:       0.3491259812647737 (ΔwoRP: 0.18042681957673104)
  DET:      0.9999164124211142 (ΔwoRP: 1.9475489184905825e-5)
  L:        11.974474474474475 (ΔwoRP: 5.6043289304970685)
  ENTR:     1.9888836441344289 (ΔwoRP: 0.06213504102770728)


======================================================================
 SYSTEM: KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     597.83 ms
allocations: 3
storage:     78.21 KiB
RR:   0.31000792896992163
DET:  0.6957785520242857
L:    2.8168341761073212
ENTR: 1.24791486522226

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     0.41 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.25 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8084.3 ± 157.17
  RR:       0.3112238749900871 ± 0.005386414123154796
    -> ΔwoRP: 0.0012159460201654482 ± 0.005386414123154796
  DET:      0.6955339195944114 ± 0.01023444284019832
    -> ΔwoRP: -0.0002446324298743807 ± 0.01023444284019832
  L:        2.8158876090768565 ± 0.04011718316399592
    -> ΔwoRP: -0.0009465670304646956 ± 0.04011718316399592
  ENTR:     1.2446294011336063 ± 0.022237466298409683
    -> ΔwoRP: -0.003285464088653711 ± 0.022237466298409683

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7741
  RR:       0.32202491386164855 (ΔwoRP: 0.012016984891726923)
  DET:      0.693278463648834 (ΔwoRP: -0.002500088375451681)
  L:        2.865079365079365 (ΔwoRP: 0.048245188972043884)
  ENTR:     1.2522346512278124 (ΔwoRP: 0.004319786005552384)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     0.5 ms
allocations: 106
storage:     177.92 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.46 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8093.79 ± 163.26
  RR:       0.3111948729097878 ± 0.005613895087184032
    -> ΔwoRP: 0.0011869439398661807 ± 0.005613895087184032
  DET:      0.6960548903781496 ± 0.01031729191579785
    -> ΔwoRP: 0.00027633835386386973 ± 0.01031729191579785
  L:        2.8181921200569002 ± 0.04127456342756719
    -> ΔwoRP: 0.0013579439495789991 ± 0.04127456342756719
  ENTR:     1.245996454206141 ± 0.02244933754749675
    -> ΔwoRP: -0.0019184110161190038 ± 0.02244933754749675

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7978
  RR:       0.3114241001564945 (ΔwoRP: 0.0014161711865728899)
  DET:      0.6862088218872139 (ΔwoRP: -0.009569730137071852)
  L:        2.8059360730593608 (ΔwoRP: -0.010898103047960461)
  ENTR:     1.2252810802392875 (ΔwoRP: -0.022633784982972527)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     0.51 ms
allocations: 130
storage:     178.92 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.46 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8098.55 ± 157.38
  RR:       0.31080156254775465 ± 0.0053640316130104245
    -> ΔwoRP: 0.0007936335778330195 ± 0.0053640316130104245
  DET:      0.6954839221403463 ± 0.009931187349261463
    -> ΔwoRP: -0.0002946298839394679 ± 0.009931187349261463
  L:        2.814547005049263 ± 0.04087727210090734
    -> ΔwoRP: -0.0022871710580583127 ± 0.04087727210090734
  ENTR:     1.2441290691416997 ± 0.021584189430869073
    -> ΔwoRP: -0.0037857960805602886 ± 0.021584189430869073

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 8127
  RR:       0.30611192297773576 (ΔwoRP: -0.003896005992185869)
  DET:      0.6778994664420107 (ΔwoRP: -0.017879085582275023)
  L:        2.8300117233294255 (ΔwoRP: 0.013177547222104291)
  ENTR:     1.2183067996289512 (ΔwoRP: -0.029608065593308863)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     0.37 ms
allocations: 72
storage:     98.19 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.37 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4454.53 ± 73.18
  RR:       0.44910203503667623 ± 0.007361083012751083
    -> ΔwoRP: 0.1390941060667546 ± 0.007361083012751083
  DET:      0.695807 ± 0.010064270492218532
    -> ΔwoRP: 2.8447975714218643e-5 ± 0.010064270492218532
  L:        2.8177436029396987 ± 0.02794694842190315
    -> ΔwoRP: 0.0009094268323774912 ± 0.02794694842190315
  ENTR:     1.2471655516542037 ± 0.018591037725251502
    -> ΔwoRP: -0.0007493135680562979 ± 0.018591037725251502

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     0.39 ms
allocations: 116
storage:     100.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.36 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4452.87 ± 73.3
  RR:       0.4492704301610097 ± 0.007402331735695718
    -> ΔwoRP: 0.13926250119108807 ± 0.007402331735695718
  DET:      0.6958734999999997 ± 0.01051271920175818
    -> ΔwoRP: 9.494797571396596e-5 ± 0.01051271920175818
  L:        2.8167709013652176 ± 0.027026966531513395
    -> ΔwoRP: -6.327474210365835e-5 ± 0.027026966531513395
  ENTR:     1.2470739357461238 ± 0.01901258481339625
    -> ΔwoRP: -0.0008409294761362318 ± 0.01901258481339625

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     0.36 ms
allocations: 113
storage:     83.94 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.34 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8081.47 ± 155.31
  RR:       0.449109181449263 ± 0.011024981524789736
    -> ΔwoRP: 0.13910125247934135 ± 0.011024981524789736
  DET:      0.6955733974661169 ± 0.010247401403853053
    -> ΔwoRP: -0.00020515455816882966 ± 0.010247401403853053
  L:        2.8170521196779084 ± 0.041228141410211014
    -> ΔwoRP: 0.00021794357058713132 ± 0.041228141410211014
  ENTR:     1.2448832763634419 ± 0.022261928969475535
    -> ΔwoRP: -0.003031588858818157 ± 0.022261928969475535

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7946
  RR:       0.4555751321419582 (ΔwoRP: 0.14556720317203659)
  DET:      0.6919889502762431 (ΔwoRP: -0.003789601748042659)
  L:        2.830508474576271 (ΔwoRP: 0.013674298468949964)
  ENTR:     1.2423458098930262 (ΔwoRP: -0.005569055329233796)


======================================================================
 SYSTEM: KLASSE 4: DRIFT (RANDOM WALK)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     577.16 ms
allocations: 3
storage:     78.21 KiB
RR:   0.21585802044425884
DET:  0.9889694676180966
L:    34.58999692843248
ENTR: 3.5367546661084104

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     4.97 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     5.09 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184690.38 ± 4474.9
  RR:       0.23774996697416861 ± 0.014475130400628687
    -> ΔwoRP: 0.021891946529909778 ± 0.014475130400628687
  DET:      0.988915607422362 ± 0.0008364712938300638
    -> ΔwoRP: -5.386019573461187e-5 ± 0.0008364712938300638
  L:        34.611868801778854 ± 1.999518793007423
    -> ΔwoRP: 0.021871873346377413 ± 1.999518793007423
  ENTR:     3.4511189688696993 ± 0.04719804516541486
    -> ΔwoRP: -0.08563569723871112 ± 0.04719804516541486

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186476
  RR:       0.22912194478966594 (ΔwoRP: 0.013263924345407102)
  DET:      0.9887612746810216 (ΔwoRP: -0.0002081929370749691)
  L:        33.12044046799725 (ΔwoRP: -1.4695564604352285)
  ENTR:     3.4562719601227028 (ΔwoRP: -0.08048270598570761)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     7.25 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     6.52 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197348.58 ± 4579.72
  RR:       0.22809047621963005 ± 0.013349688471804077
    -> ΔwoRP: 0.012232455775371215 ± 0.013349688471804077
  DET:      0.989197980905782 ± 0.0007792800751956065
    -> ΔwoRP: 0.0002285132876854723 ± 0.0007792800751956065
  L:        35.17570680568062 ± 2.0108694737877797
    -> ΔwoRP: 0.5857098772481422 ± 2.0108694737877797
  ENTR:     3.4678885464721056 ± 0.046681291656785105
    -> ΔwoRP: -0.06886611963630473 ± 0.046681291656785105

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 198407
  RR:       0.2258144267998181 (ΔwoRP: 0.009956406355559277)
  DET:      0.9889733914641538 (ΔwoRP: 3.923846057185543e-6)
  L:        35.226323119777156 (ΔwoRP: 0.6363261913446792)
  ENTR:     3.4236046505015083 (ΔwoRP: -0.11315001560690208)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     6.79 ms
allocations: 114
storage:     178.28 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     6.29 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197007.1 ± 4520.14
  RR:       0.22778084015284367 ± 0.013566347836997198
    -> ΔwoRP: 0.01192281970858483 ± 0.013566347836997198
  DET:      0.9891305984441254 ± 0.000817307915883603
    -> ΔwoRP: 0.00016113082602886575 ± 0.000817307915883603
  L:        35.1022358728183 ± 2.1361507856029576
    -> ΔwoRP: 0.5122389443858211 ± 2.1361507856029576
  ENTR:     3.464215526472721 ± 0.046823647419982385
    -> ΔwoRP: -0.07253913963568959 ± 0.046823647419982385

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 199562
  RR:       0.2438211328833257 (ΔwoRP: 0.02796311243906685)
  DET:      0.9898579031304316 (ΔwoRP: 0.000888435512335084)
  L:        38.52231520223152 (ΔwoRP: 3.9323182737990408)
  ENTR:     3.506187118408789 (ΔwoRP: -0.030567547699621223)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     1.74 ms
allocations: 116
storage:     100.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.57 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 7540.91 ± 140.89
  RR:       0.26531217734039303 ± 0.004948851325949966
    -> ΔwoRP: 0.049454156896134194 ± 0.004948851325949966
  DET:      0.9891259999999997 ± 0.00228688737235874
    -> ΔwoRP: 0.00015653238190316277 ± 0.00228688737235874
  L:        35.220983314478644 ± 1.8955446085888321
    -> ΔwoRP: 0.6309863860461675 ± 1.8955446085888321
  ENTR:     3.514542568765494 ± 0.14103102384777497
    -> ΔwoRP: -0.022212097342916515 ± 0.14103102384777497

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7382
  RR:       0.270929287455974 (ΔwoRP: 0.055071267011715164)
  DET:      0.9875 (ΔwoRP: -0.0014694676180965205)
  L:        38.527089283106655 (ΔwoRP: 3.937092354674178)
  ENTR:     3.44695434022687 (ΔwoRP: -0.0898003258815403)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     5.38 ms
allocations: 122
storage:     84.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     7.48 ms
allocations: 122
storage:     84.37 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 127499.74 ± 82776.82
  RR:       0.27038975518258995 ± 0.014715321572931563
    -> ΔwoRP: 0.05453173473833112 ± 0.014715321572931563
  DET:      0.9889820147857709 ± 0.001496209851813223
    -> ΔwoRP: 1.2547167674292758e-5 ± 0.001496209851813223
  L:        34.73640119408267 ± 1.9199019390512053
    -> ΔwoRP: 0.14640426565019027 ± 1.9199019390512053
  ENTR:     3.4719583613131997 ± 0.09660023539544677
    -> ΔwoRP: -0.0647963047952107 ± 0.09660023539544677

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186706
  RR:       0.261282444056431 (ΔwoRP: 0.04542442361217214)
  DET:      0.9887255806325974 (ΔwoRP: -0.00024388698549915322)
  L:        33.26413793103448 (ΔwoRP: -1.3258589973979937)
  ENTR:     3.4532498097039555 (ΔwoRP: -0.08350485640445493)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     5.18 ms
allocations: 121
storage:     84.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     5.84 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184629.42 ± 4136.65
  RR:       0.27355054349769764 ± 0.0165571676431435
    -> ΔwoRP: 0.057692523053438804 ± 0.0165571676431435
  DET:      0.9889295760094676 ± 0.0008247236997702094
    -> ΔwoRP: -3.9891608628939146e-5 ± 0.0008247236997702094
  L:        34.59198994016576 ± 1.8921412234666652
    -> ΔwoRP: 0.0019930117332833674 ± 1.8921412234666652
  ENTR:     3.4530943485901577 ± 0.046180770342510995
    -> ΔwoRP: -0.08366031751825265 ± 0.046180770342510995

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186710
  RR:       0.2612768464463607 (ΔwoRP: 0.04541882600210184)
  DET:      0.9887255806325974 (ΔwoRP: -0.00024388698549915322)
  L:        33.26413793103448 (ΔwoRP: -1.3258589973979937)
  ENTR:     3.4532498097039555 (ΔwoRP: -0.08350485640445493)
%
\item offenkundig wird long_lines überschätzt und Norberts wird auch bei Chaotisschen systemen angeworfen, also wie befürchtet
%
## also: schön machen und das mit dem diagonalen merken probieren
%
\item ok, also größere fehler als gedacht: ich habe long_lines mit jedem shcwarzen punkt in der prüfungsschleife +=1 gesetzt\\
also die groben fehler beheben, dann nochmal testen und dann das mit den diagonalen merken implementieren
\\
nächster fehler: ich mache jetzt ein für alle mal diese 0.0 zu zero(T) anpassung, weshalb genau muss ich noch verstehen, aber wird jetzt getan. ok, nur in hybrid erst ein Mal.
\\
ok erstmal so. Test:
======================================================================
 SYSTEM: KLASSE 1: CHAOS (ROESSLER SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     679.54 ms
allocations: 3
storage:     78.21 KiB
RR:   0.08277577808439872
DET:  0.9984392508670275
L:    23.776464002619335
ENTR: 3.864856330212997

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     32.62 ms
allocations: 109
storage:     161.84 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     31.69 ms
allocations: 121
storage:     162.37 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 508358.97 ± 13986.99
  RR:       0.08360305449561459 ± 0.002398786568178906
    -> ΔwoRP: 0.0008272764112158687 ± 0.002398786568178906
  DET:      0.9984418142169208 ± 0.0001856850883571583
    -> ΔwoRP: 2.5633498933474996e-6 ± 0.0001856850883571583
  L:        23.807151370151505 ± 0.5113457149506083
    -> ΔwoRP: 0.030687367532170384 ± 0.5113457149506083
  ENTR:     3.838520866983781 ± 0.019800664400432835
    -> ΔwoRP: -0.026335463229215872 ± 0.019800664400432835

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 519978
  RR:       0.08339741672718987 (ΔwoRP: 0.0006216386427911474)
  DET:      0.9984418356456777 (ΔwoRP: 2.5847786502275483e-6)
  L:        24.274519979242346 (ΔwoRP: 0.4980559766230108)
  ENTR:     3.8683954386281174 (ΔwoRP: 0.0035391084151203955)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     28.34 ms
allocations: 102
storage:     177.73 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     23.73 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595909.04 ± 15466.77
  RR:       0.07561177508219895 ± 0.002317869665187252
    -> ΔwoRP: -0.00716400300219977 ± 0.002317869665187252
  DET:      0.9985841165417856 ± 0.00017322586484345954
    -> ΔwoRP: 0.00014486567475813228 ± 0.00017322586484345954
  L:        24.9982962343379 ± 0.5474949532903846
    -> ΔwoRP: 1.2218322317185653 ± 0.5474949532903846
  ENTR:     3.8549741979415053 ± 0.019060564951880625
    -> ΔwoRP: -0.009882132271491706 ± 0.019060564951880625

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 595449
  RR:       0.07663604019236032 (ΔwoRP: -0.006139737892038394)
  DET:      0.9987551782543926 (ΔwoRP: 0.0003159273873651891)
  L:        25.240845796802475 (ΔwoRP: 1.46438179418314)
  ENTR:     3.87017269561499 (ΔwoRP: 0.005316365401993206)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     24.38 ms
allocations: 90
storage:     177.15 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     32.23 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595316.69 ± 16066.07
  RR:       0.07568605462867323 ± 0.0022495865070041757
    -> ΔwoRP: -0.007089723455725491 ± 0.0022495865070041757
  DET:      0.9985823680263258 ± 0.00017884401409938108
    -> ΔwoRP: 0.0001431171592983782 ± 0.00017884401409938108
  L:        25.009384425814567 ± 0.5412735837461685
    -> ΔwoRP: 1.2329204231952318 ± 0.5412735837461685
  ENTR:     3.8552050958256423 ± 0.019326757115713973
    -> ΔwoRP: -0.009651234387354712 ± 0.019326757115713973

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 622976
  RR:       0.07297521851023114 (ΔwoRP: -0.009800559574167575)
  DET:      0.9986025195750016 (ΔwoRP: 0.00016326870797411797)
  L:        25.150621118012424 (ΔwoRP: 1.3741571153930892)
  ENTR:     3.8658099402424124 (ΔwoRP: 0.0009536100294154082)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     4.71 ms
allocations: 26
storage:     95.5 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     7.94 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22926.25 ± 451.56
  RR:       0.08726292685103906 ± 0.001700814642956824
    -> ΔwoRP: 0.004487148766640345 ± 0.001700814642956824
  DET:      0.9985608783783785 ± 0.0008399488847506474
    -> ΔwoRP: 0.00012162751135103012 ± 0.0008399488847506474
  L:        24.496900229721074 ± 0.6234190667682418
    -> ΔwoRP: 0.7204362271017395 ± 0.6234190667682418
  ENTR:     3.846848520568941 ± 0.022717510066266346
    -> ΔwoRP: -0.018007809644056127 ± 0.022717510066266346

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     4.6 ms
allocations: 100
storage:     99.54 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     5.69 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22917.12 ± 447.87
  RR:       0.08729713565311935 ± 0.0016862918245739115
    -> ΔwoRP: 0.00452135756872063 ± 0.0016862918245739115
  DET:      0.9985535000000002 ± 0.0008382066215082845
    -> ΔwoRP: 0.00011424913297275463 ± 0.0008382066215082845
  L:        24.433356350490897 ± 0.6312896714486598
    -> ΔwoRP: 0.6568923478715618 ± 0.6312896714486598
  ENTR:     3.846150211423794 ± 0.02264395117276758
    -> ΔwoRP: -0.018706118789202808 ± 0.02264395117276758

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     4.33 ms
allocations: 108
storage:     84.38 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     5.67 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 30683.75 ± 60916.61
  RR:       0.08734329069227083 ± 0.0018339508230171932
    -> ΔwoRP: 0.0045675126078721096 ± 0.0018339508230171932
  DET:      0.9985695400893688 ± 0.0008554585734357577
    -> ΔwoRP: 0.0001302892223413732 ± 0.0008554585734357577
  L:        24.481550306810586 ± 0.6409443849978869
    -> ΔwoRP: 0.7050863041912514 ± 0.6409443849978869
  ENTR:     3.847254504268664 ± 0.023736032040132766
    -> ΔwoRP: -0.017601825944332905 ± 0.023736032040132766

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)


======================================================================
 SYSTEM: KLASSE 1: CHAOS (LORENZ SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     746.62 ms
allocations: 3
storage:     78.21 KiB
RR:   0.12050202018220797
DET:  0.9998998789325514
L:    40.53190731895452
ENTR: 4.524222130528146

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     48.78 ms
allocations: 121
storage:     162.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     53.84 ms
allocations: 121
storage:     162.37 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 590261.14 ± 13916.96
  RR:       0.12496691104966093 ± 0.004747359486716226
    -> ΔwoRP: 0.004464890867452956 ± 0.004747359486716226
  DET:      0.9998982189810259 ± 3.5934181991039784e-5
    -> ΔwoRP: -1.6599515254567265e-6 ± 3.5934181991039784e-5
  L:        40.568379458651314 ± 1.3269634002756605
    -> ΔwoRP: 0.03647213969679797 ± 1.3269634002756605
  ENTR:     4.439816322920286 ± 0.027487991167339958
    -> ΔwoRP: -0.08440580760785998 ± 0.027487991167339958

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 617671
  RR:       0.11708743063717104 (ΔwoRP: -0.003414589545036928)
  DET:      0.9998602375960867 (ΔwoRP: -3.964133646472412e-5)
  L:        39.56460532931121 (ΔwoRP: -0.9673019896433033)
  ENTR:     4.415985716337583 (ΔwoRP: -0.10823641419056251)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     72.16 ms
allocations: 132
storage:     203.05 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     72.18 ms
allocations: 130
storage:     178.95 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 768975.52 ± 19403.53
  RR:       0.10068498125741096 ± 0.0037188945683726384
    -> ΔwoRP: -0.019817038924797012 ± 0.0037188945683726384
  DET:      0.9999082631865555 ± 3.3967689920342626e-5
    -> ΔwoRP: 8.384254004067948e-6 ± 3.3967689920342626e-5
  L:        41.796684206096494 ± 1.3152469644954774
    -> ΔwoRP: 1.2647768871419771 ± 1.3152469644954774
  ENTR:     4.469206515926031 ± 0.027605508624060814
    -> ΔwoRP: -0.055015614602115015 ± 0.027605508624060814

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 813909
  RR:       0.0970121861694318 (ΔwoRP: -0.02348983401277617)
  DET:      0.9999172342035566 (ΔwoRP: 1.7355271005214945e-5)
  L:        42.433015554440544 (ΔwoRP: 1.9011082354860278)
  ENTR:     4.493282877959766 (ΔwoRP: -0.030939252568379594)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     67.05 ms
allocations: 130
storage:     179.01 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     67.77 ms
allocations: 130
storage:     178.95 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 769270.56 ± 26053.02
  RR:       0.10065088354088708 ± 0.0037174446943291114
    -> ΔwoRP: -0.01985113664132089 ± 0.0037174446943291114
  DET:      0.9999085506154246 ± 3.258909071198899e-5
    -> ΔwoRP: 8.671682873218067e-6 ± 3.258909071198899e-5
  L:        41.8242902453616 ± 1.3101150476654502
    -> ΔwoRP: 1.292382926407086 ± 1.3101150476654502
  ENTR:     4.4702892664920615 ± 0.027369340374356167
    -> ΔwoRP: -0.053932864036084105 ± 0.027369340374356167

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 817442
  RR:       0.09489365494296578 (ΔwoRP: -0.02560836523924219)
  DET:      0.9999157205292751 (ΔwoRP: 1.5841596723742413e-5)
  L:        41.6708479678876 (ΔwoRP: 1.1389406489330867)
  ENTR:     4.442449861300334 (ΔwoRP: -0.08177226922781156)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     7.12 ms
allocations: 130
storage:     124.87 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     7.33 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 15317.78 ± 319.05
  RR:       0.13060330428488512 ± 0.002698185933841559
    -> ΔwoRP: 0.010101284102677147 ± 0.002698185933841559
  DET:      0.999902 ± 0.00022901626241042633
    -> ΔwoRP: 2.1210674485683256e-6 ± 0.00022901626241042633
  L:        41.054659020693336 ± 1.1791847890017133
    -> ΔwoRP: 0.5227517017388195 ± 1.1791847890017133
  ENTR:     4.468860049605683 ± 0.029900164816564694
    -> ΔwoRP: -0.0553620809224622 ± 0.029900164816564694

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     7.64 ms
allocations: 122
storage:     84.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     7.67 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 55692.8 ± 147280.42
  RR:       0.1310377996874685 ± 0.003355271262892344
    -> ΔwoRP: 0.010535779505260537 ± 0.003355271262892344
  DET:      0.9999008094067903 ± 0.00020861948311683216
    -> ΔwoRP: 9.304742388804854e-7 ± 0.00020861948311683216
  L:        41.01030151823401 ± 1.1976380485929463
    -> ΔwoRP: 0.4783941992794922 ± 1.1976380485929463
  ENTR:     4.468307890895851 ± 0.03129951449520896
    -> ΔwoRP: -0.055914239632294915 ± 0.03129951449520896

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     50.6 ms
allocations: 121
storage:     84.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     55.13 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 578505.03 ± 83556.32
  RR:       0.13648960211845076 ± 0.005056606952682924
    -> ΔwoRP: 0.015987581936242792 ± 0.005056606952682924
  DET:      0.999897026532957 ± 4.739733151741992e-5
    -> ΔwoRP: -2.8523995944107483e-6 ± 4.739733151741992e-5
  L:        40.505834630389764 ± 1.1730446610237752
    -> ΔwoRP: -0.026072688564752866 ± 1.1730446610237752
  ENTR:     4.440116452934012 ± 0.027666191171521498
    -> ΔwoRP: -0.08410567759413379 ± 0.027666191171521498

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 619520
  RR:       0.1270289901859504 (ΔwoRP: 0.00652697000374243)
  DET:      0.9998602233884392 (ΔwoRP: -3.965554411222705e-5)
  L:        39.56058320764203 (ΔwoRP: -0.9713241113124838)
  ENTR:     4.415893919671122 (ΔwoRP: -0.1083282108570236)


======================================================================
 SYSTEM: KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     652.2 ms
allocations: 3
storage:     78.21 KiB
RR:   0.16869916168804264
DET:  0.9998969369319293
L:    6.370145543977406
ENTR: 1.9267486031067216

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     6.15 ms
allocations: 77
storage:     160.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     5.97 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 66909.47 ± 1677.45
  RR:       0.17210414197953955 ± 0.07749145067706718
    -> ΔwoRP: 0.003404980291496912 ± 0.07749145067706718
  DET:      0.9998857196596173 ± 0.0001093200774637351
    -> ΔwoRP: -1.1217272312014082e-5 ± 0.0001093200774637351
  L:        6.45346701265909 ± 2.9009589068142327
    -> ΔwoRP: 0.08332146868168344 ± 2.9009589068142327
  ENTR:     1.9175667868872375 ± 0.029801636501260446
    -> ΔwoRP: -0.009181816219484107 ± 0.029801636501260446

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 68745
  RR:       0.310202283300289 (ΔwoRP: 0.14150312161224635)
  DET:      0.9999164508313142 (ΔwoRP: 1.9513899384926425e-5)
  L:        11.97997997997998 (ΔwoRP: 5.609834436002574)
  ENTR:     1.9878967476966698 (ΔwoRP: 0.06114814458994822)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     10.57 ms
allocations: 118
storage:     178.42 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     10.5 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100509.8 ± 3219.93
  RR:       0.15223963909964527 ± 0.06369844438879887
    -> ΔwoRP: -0.016459522588397363 ± 0.06369844438879887
  DET:      0.9998990429883355 ± 9.696138057158256e-5
    -> ΔwoRP: 2.1060564062702625e-6 ± 9.696138057158256e-5
  L:        8.385834557375867 ± 3.5055477567239186
    -> ΔwoRP: 2.015689013398461 ± 3.5055477567239186
  ENTR:     2.204980936676252 ± 0.03078666326426938
    -> ΔwoRP: 0.2782323335695305 ± 0.03078666326426938

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 96342
  RR:       0.1274874859776963 (ΔwoRP: -0.04121167571034634)
  DET:      0.9998521147589471 (ΔwoRP: -4.482217298218405e-5)
  L:        6.767767767767768 (ΔwoRP: 0.3976222237903615)
  ENTR:     2.2395955728017842 (ΔwoRP: 0.31284696969506265)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     10.51 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     10.52 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100542.89 ± 3064.25
  RR:       0.15034679775286142 ± 0.061743849770437176
    -> ΔwoRP: -0.01835236393518122 ± 0.061743849770437176
  DET:      0.9998932014435818 ± 0.00010085739202875409
    -> ΔwoRP: -3.7354883474227663e-6 ± 0.00010085739202875409
  L:        8.287747072693545 ± 3.4106178650537036
    -> ΔwoRP: 1.9176015287161388 ± 3.4106178650537036
  ENTR:     2.20496886493823 ± 0.03152152906330275
    -> ΔwoRP: 0.2782202618315084 ± 0.03152152906330275

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 99457
  RR:       0.1722890020889068 (ΔwoRP: 0.0035898404008641582)
  DET:      0.9998936453070991 (ΔwoRP: -3.291624830148443e-6)
  L:        9.41091091091091 (ΔwoRP: 3.0407653669335044)
  ENTR:     2.230790756844401 (ΔwoRP: 0.3040421537376796)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     54.67 ms
allocations: 128
storage:     100.77 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     53.66 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11066.3 ± 378.45
  RR:       0.18089589315407606 ± 0.005904389249707363
    -> ΔwoRP: 0.012196731466033423 ± 0.005904389249707363
  DET:      0.9998899999999998 ± 0.00023227990432654732
    -> ΔwoRP: -6.9369319294354526e-6 ± 0.00023227990432654732
  L:        6.955350168660615 ± 0.3697999936898275
    -> ΔwoRP: 0.5852046246832092 ± 0.3697999936898275
  ENTR:     2.029602067768081 ± 0.060947833226260975
    -> ΔwoRP: 0.10285346466135947 ± 0.060947833226260975

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     55.14 ms
allocations: 128
storage:     100.77 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     54.28 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11071.12 ± 378.47
  RR:       0.18084803239296965 ± 0.0059308799178448696
    -> ΔwoRP: 0.012148870704927012 ± 0.0059308799178448696
  DET:      0.9998989999999999 ± 0.00022989530628494219
    -> ΔwoRP: 2.063068070601304e-6 ± 0.00022989530628494219
  L:        6.965026275767639 ± 0.36304440284953077
    -> ΔwoRP: 0.5948807317902327 ± 0.36304440284953077
  ENTR:     2.031051012625658 ± 0.05920699968621528
    -> ΔwoRP: 0.10430240951893643 ± 0.05920699968621528

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     52.7 ms
allocations: 84
storage:     98.72 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     53.45 ms
allocations: 130
storage:     124.89 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11397.47 ± 4334.28
  RR:       0.1808805355291052 ± 0.007773812486685447
    -> ΔwoRP: 0.012181373841062576 ± 0.007773812486685447
  DET:      0.9999014323758337 ± 0.00021796101545732256
    -> ΔwoRP: 4.495443904461993e-6 ± 0.00021796101545732256
  L:        6.951721921586947 ± 0.3991018836238856
    -> ΔwoRP: 0.5815763776095411 ± 0.3991018836238856
  ENTR:     2.0291914001810896 ± 0.05817202930430024
    -> ΔwoRP: 0.10244279707436799 ± 0.05817202930430024

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)


======================================================================
 SYSTEM: KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     1729.12 ms
allocations: 3
storage:     78.19 KiB
RR:   0.31000792896992163
DET:  0.6957785520242857
L:    2.8168341761073212
ENTR: 1.24791486522226

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     1.12 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.03 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8075.74 ± 154.13
  RR:       0.3115337307606195 ± 0.005408644511157735
    -> ΔwoRP: 0.0015258017906978893 ± 0.005408644511157735
  DET:      0.6955117667674653 ± 0.010329478379175108
    -> ΔwoRP: -0.0002667852568204454 ± 0.010329478379175108
  L:        2.8177875702338677 ± 0.04000232867228232
    -> ΔwoRP: 0.0009533941265464918 ± 0.04000232867228232
  ENTR:     1.2450782627868708 ± 0.022354847083860065
    -> ΔwoRP: -0.0028366024353891905 ± 0.022354847083860065

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7741
  RR:       0.32202491386164855 (ΔwoRP: 0.012016984891726923)
  DET:      0.693278463648834 (ΔwoRP: -0.002500088375451681)
  L:        2.865079365079365 (ΔwoRP: 0.048245188972043884)
  ENTR:     1.2522346512278124 (ΔwoRP: 0.004319786005552384)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     1.73 ms
allocations: 130
storage:     178.92 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.6 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8099.71 ± 155.06
  RR:       0.31090689206099326 ± 0.005290283031157501
    -> ΔwoRP: 0.0008989630910716251 ± 0.005290283031157501
  DET:      0.6958816701596297 ± 0.009655561667988527
    -> ΔwoRP: 0.0001031181353439159 ± 0.009655561667988527
  L:        2.815713041282345 ± 0.0408290192054024
    -> ΔwoRP: -0.0011211348249764441 ± 0.0408290192054024
  ENTR:     1.2451279719043753 ± 0.02125128751215009
    -> ΔwoRP: -0.002786893317884731 ± 0.02125128751215009

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7978
  RR:       0.3114241001564945 (ΔwoRP: 0.0014161711865728899)
  DET:      0.6862088218872139 (ΔwoRP: -0.009569730137071852)
  L:        2.8059360730593608 (ΔwoRP: -0.010898103047960461)
  ENTR:     1.2252810802392875 (ΔwoRP: -0.022633784982972527)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     2.03 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.72 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8093.7 ± 155.44
  RR:       0.31095111297944455 ± 0.00541010452157435
    -> ΔwoRP: 0.0009431840095229238 ± 0.00541010452157435
  DET:      0.6954464239613776 ± 0.010132213240336595
    -> ΔwoRP: -0.00033212806290816577 ± 0.010132213240336595
  L:        2.815934135272494 ± 0.0409654242091249
    -> ΔwoRP: -0.0009000408348271982 ± 0.0409654242091249
  ENTR:     1.2444443229989266 ± 0.02231312949835303
    -> ΔwoRP: -0.003470542223333428 ± 0.02231312949835303

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 8127
  RR:       0.30611192297773576 (ΔwoRP: -0.003896005992185869)
  DET:      0.6778994664420107 (ΔwoRP: -0.017879085582275023)
  L:        2.8300117233294255 (ΔwoRP: 0.013177547222104291)
  ENTR:     1.2183067996289512 (ΔwoRP: -0.029608065593308863)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     1.37 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.35 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4450.34 ± 72.06
  RR:       0.4495214712915063 ± 0.0072786672072006975
    -> ΔwoRP: 0.1395135423215847 ± 0.0072786672072006975
  DET:      0.6958644999999998 ± 0.010347364771172795
    -> ΔwoRP: 8.594797571404023e-5 ± 0.010347364771172795
  L:        2.8184931607607697 ± 0.02685924307594594
    -> ΔwoRP: 0.001658984653448492 ± 0.02685924307594594
  ENTR:     1.2474607872519783 ± 0.018972508931006243
    -> ΔwoRP: -0.000454077970281741 ± 0.018972508931006243

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     1.33 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.49 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4457.5 ± 73.5
  RR:       0.4488037837747431 ± 0.007407823228983937
    -> ΔwoRP: 0.13879585480482148 ± 0.007407823228983937
  DET:      0.6959364999999998 ± 0.010204918329320828
    -> ΔwoRP: 0.00015794797571411223 ± 0.010204918329320828
  L:        2.8182832555067603 ± 0.026697745378601142
    -> ΔwoRP: 0.0014490793994390572 ± 0.026697745378601142
  ENTR:     1.247520706187345 ± 0.018500156105590766
    -> ΔwoRP: -0.00039415903491502036 ± 0.018500156105590766

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     1.56 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.37 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4457.5 ± 75.45
  RR:       0.44881032129754383 ± 0.007603104347211809
    -> ΔwoRP: 0.1388023923276222 ± 0.007603104347211809
  DET:      0.6951805 ± 0.010338716497167767
    -> ΔwoRP: -0.0005980520242857557 ± 0.010338716497167767
  L:        2.817077245956509 ± 0.026599464097733803
    -> ΔwoRP: 0.00024306984918798236 ± 0.026599464097733803
  ENTR:     1.2459818269737284 ± 0.018885478735657695
    -> ΔwoRP: -0.0019330382485316377 ± 0.018885478735657695

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)


======================================================================
 SYSTEM: KLASSE 4: DRIFT (RANDOM WALK)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     431.33 ms
allocations: 3
storage:     78.19 KiB
RR:   0.21585802044425884
DET:  0.9889694676180966
L:    34.58999692843248
ENTR: 3.5367546661084104

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     12.73 ms
allocations: 105
storage:     161.64 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     12.78 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184893.36 ± 4200.41
  RR:       0.23806789412863485 ± 0.013585697229106797
    -> ΔwoRP: 0.02220987368437602 ± 0.013585697229106797
  DET:      0.9889639140272481 ± 0.0007805207197209134
    -> ΔwoRP: -5.5535908484172225e-6 ± 0.0007805207197209134
  L:        34.681212783294015 ± 1.9103909184365537
    -> ΔwoRP: 0.09121585486153805 ± 1.9103909184365537
  ENTR:     3.454115766309053 ± 0.0464239017485036
    -> ΔwoRP: -0.08263889979935746 ± 0.0464239017485036

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186476
  RR:       0.22912194478966594 (ΔwoRP: 0.013263924345407102)
  DET:      0.9887612746810216 (ΔwoRP: -0.0002081929370749691)
  L:        33.12044046799725 (ΔwoRP: -1.4695564604352285)
  ENTR:     3.4562719601227028 (ΔwoRP: -0.08048270598570761)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     17.13 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     16.99 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197057.42 ± 4493.28
  RR:       0.22833514002781877 ± 0.014030550856082964
    -> ΔwoRP: 0.012477119583559931 ± 0.014030550856082964
  DET:      0.9891920272615858 ± 0.0007944025276586931
    -> ΔwoRP: 0.00022255964348927293 ± 0.0007944025276586931
  L:        35.168801930769696 ± 2.096469346729883
    -> ΔwoRP: 0.5788050023372193 ± 2.096469346729883
  ENTR:     3.4692157372421804 ± 0.046502772785583714
    -> ΔwoRP: -0.06753892886623003 ± 0.046502772785583714

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 198407
  RR:       0.2258144267998181 (ΔwoRP: 0.009956406355559277)
  DET:      0.9889733914641538 (ΔwoRP: 3.923846057185543e-6)
  L:        35.226323119777156 (ΔwoRP: 0.6363261913446792)
  ENTR:     3.4236046505015083 (ΔwoRP: -0.11315001560690208)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     16.7 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     16.73 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 196984.25 ± 4487.48
  RR:       0.22865016024268486 ± 0.013558681424241523
    -> ΔwoRP: 0.012792139798426028 ± 0.013558681424241523
  DET:      0.9891841308240288 ± 0.0008184599113671933
    -> ΔwoRP: 0.00021466320593221955 ± 0.0008184599113671933
  L:        35.23853948504279 ± 2.029143963635991
    -> ΔwoRP: 0.648542556610316 ± 2.029143963635991
  ENTR:     3.4687657706950357 ± 0.047120663129727514
    -> ΔwoRP: -0.06798889541337472 ± 0.047120663129727514

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 199562
  RR:       0.2438211328833257 (ΔwoRP: 0.02796311243906685)
  DET:      0.9898579031304316 (ΔwoRP: 0.000888435512335084)
  L:        38.52231520223152 (ΔwoRP: 3.9323182737990408)
  ENTR:     3.506187118408789 (ΔwoRP: -0.030567547699621223)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     4.58 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.01 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 7546.89 ± 139.17
  RR:       0.26509991261916294 ± 0.004897562946684815
    -> ΔwoRP: 0.0492418921749041 ± 0.004897562946684815
  DET:      0.9892379999999997 ± 0.0022459742653023434
    -> ΔwoRP: 0.00026853238190316375 ± 0.0022459742653023434
  L:        35.20578948808209 ± 1.8176336488261535
    -> ΔwoRP: 0.6157925596496128 ± 1.8176336488261535
  ENTR:     3.5205012749860947 ± 0.1370552118105817
    -> ΔwoRP: -0.01625339112231572 ± 0.1370552118105817

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7382
  RR:       0.270929287455974 (ΔwoRP: 0.055071267011715164)
  DET:      0.9875 (ΔwoRP: -0.0014694676180965205)
  L:        38.527089283106655 (ΔwoRP: 3.937092354674178)
  ENTR:     3.44695434022687 (ΔwoRP: -0.0898003258815403)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     13.72 ms
allocations: 122
storage:     84.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     13.92 ms
allocations: 122
storage:     84.37 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 127237.38 ± 83152.22
  RR:       0.2699253218747269 ± 0.014890776437266716
    -> ΔwoRP: 0.05406730143046806 ± 0.014890776437266716
  DET:      0.9889468881984069 ± 0.0014625100087340204
    -> ΔwoRP: -2.2579419689638947e-5 ± 0.0014625100087340204
  L:        34.72300083802619 ± 1.9157677275648188
    -> ΔwoRP: 0.133003909593711 ± 1.9157677275648188
  ENTR:     3.4707825234676317 ± 0.0910448081668503
    -> ΔwoRP: -0.06597214264077866 ± 0.0910448081668503

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186706
  RR:       0.261282444056431 (ΔwoRP: 0.04542442361217214)
  DET:      0.9887255806325974 (ΔwoRP: -0.00024388698549915322)
  L:        33.26413793103448 (ΔwoRP: -1.3258589973979937)
  ENTR:     3.4532498097039555 (ΔwoRP: -0.08350485640445493)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     13.91 ms
allocations: 121
storage:     84.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     13.98 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184591.51 ± 3959.64
  RR:       0.2730645287846183 ± 0.01686875332051659
    -> ΔwoRP: 0.05720650834035945 ± 0.01686875332051659
  DET:      0.9888981809944815 ± 0.000819291349776291
    -> ΔwoRP: -7.128662361510774e-5 ± 0.000819291349776291
  L:        34.53680677751719 ± 1.9836074566709423
    -> ΔwoRP: -0.05319015091528456 ± 1.9836074566709423
  ENTR:     3.450516186923531 ± 0.045870973693195274
    -> ΔwoRP: -0.08623847918487959 ± 0.045870973693195274

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186708
  RR:       0.2612796452214153 (ΔwoRP: 0.045421624777156444)
  DET:      0.9887255806325974 (ΔwoRP: -0.00024388698549915322)
  L:        33.26413793103448 (ΔwoRP: -1.3258589973979937)
  ENTR:     3.4532498097039555 (ΔwoRP: -0.08350485640445493)

%
\item gemini hat so einen trick beschrieben "empty streak" dass man irwas an dem linienlänge sampling oder an smi LFboth optimieren kann explizit für drift. das sit später zu erforschen.
%
\item jetzt erst mal dieses schon gefundene 50er-diagonale merken:
\\
%
\item wtf ist mit dem hybrid ding. noch kurz checken was hier schief geht und dann das mit dem merken.
### 01 h : 36 min (seit dem letzten Zeitstempel)
%
# 05.09.2026
%
## wtf ist mit dem hybrid ding. noch kurz checken was hier schief geht und dann das mit dem merken.
%
\item anscheinend hat hybrid bei Lorenz NOrbert bei harm osc smi_LFboth und sonst smilfb genutzt
%
\item nochmal test bei hybrid_LFboth alles genauso wie bei hybrid fw:
\\

======================================================================
 SYSTEM: KLASSE 1: CHAOS (ROESSLER SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     618.54 ms
allocations: 3
storage:     78.21 KiB
RR:   0.08277577808439872
DET:  0.9984392508670275
L:    23.776464002619335
ENTR: 3.864856330212997

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     31.78 ms
allocations: 109
storage:     161.87 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     31.95 ms
allocations: 121
storage:     162.37 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 508757.94 ± 11277.53
  RR:       0.08348140712292594 ± 0.002426223654653342
    -> ΔwoRP: 0.0007056290385272224 ± 0.002426223654653342
  DET:      0.9984262069908892 ± 0.00018849082468689498
    -> ΔwoRP: -1.30438761382079e-5 ± 0.00018849082468689498
  L:        23.784357838714495 ± 0.5172878728314163
    -> ΔwoRP: 0.007893836095160367 ± 0.5172878728314163
  ENTR:     3.8374314629744393 ± 0.019841653917899073
    -> ΔwoRP: -0.02742486723855775 ± 0.019841653917899073

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 519978
  RR:       0.08339741672718987 (ΔwoRP: 0.0006216386427911474)
  DET:      0.9984418356456777 (ΔwoRP: 2.5847786502275483e-6)
  L:        24.274519979242346 (ΔwoRP: 0.4980559766230108)
  ENTR:     3.8683954386281174 (ΔwoRP: 0.0035391084151203955)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     23.87 ms
allocations: 102
storage:     177.65 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     23.7 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595433.01 ± 17398.28
  RR:       0.07557612487665222 ± 0.0022485434088829487
    -> ΔwoRP: -0.007199653207746501 ± 0.0022485434088829487
  DET:      0.9985652822269238 ± 0.00017913481646966145
    -> ΔwoRP: 0.00012603135989630587 ± 0.00017913481646966145
  L:        24.989277237823508 ± 0.5323560781482971
    -> ΔwoRP: 1.2128132352041732 ± 0.5323560781482971
  ENTR:     3.8542957209807445 ± 0.01889206794295077
    -> ΔwoRP: -0.010560609232252549 ± 0.01889206794295077

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 595449
  RR:       0.07663604019236032 (ΔwoRP: -0.006139737892038394)
  DET:      0.9987551782543926 (ΔwoRP: 0.0003159273873651891)
  L:        25.240845796802475 (ΔwoRP: 1.46438179418314)
  ENTR:     3.87017269561499 (ΔwoRP: 0.005316365401993206)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     23.2 ms
allocations: 118
storage:     178.4 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     24.33 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 595557.6 ± 17162.11
  RR:       0.07559445274607504 ± 0.0023033833867096634
    -> ΔwoRP: -0.007181325338323677 ± 0.0023033833867096634
  DET:      0.998580299967783 ± 0.00017693798888617057
    -> ΔwoRP: 0.00014104910075551924 ± 0.00017693798888617057
  L:        24.994504419905248 ± 0.5523740052406487
    -> ΔwoRP: 1.2180404172859127 ± 0.5523740052406487
  ENTR:     3.8552579489049834 ± 0.019356481258590616
    -> ΔwoRP: -0.009598381308013604 ± 0.019356481258590616

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 622976
  RR:       0.07297521851023114 (ΔwoRP: -0.009800559574167575)
  DET:      0.9986025195750016 (ΔwoRP: 0.00016326870797411797)
  L:        25.150621118012424 (ΔwoRP: 1.3741571153930892)
  ENTR:     3.8658099402424124 (ΔwoRP: 0.0009536100294154082)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     4.39 ms
allocations: 68
storage:     98.04 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.18 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 22907.22 ± 460.7
  RR:       0.08734170133911069 ± 0.0017524638725557676
    -> ΔwoRP: 0.004565923254711973 ± 0.0017524638725557676
  DET:      0.9985664871794871 ± 0.0008378579738165841
    -> ΔwoRP: 0.0001272363124596998 ± 0.0008378579738165841
  L:        24.454340774470914 ± 0.6222262105031006
    -> ΔwoRP: 0.6778767718515795 ± 0.6222262105031006
  ENTR:     3.8472740396523055 ± 0.022746005674335247
    -> ΔwoRP: -0.017582290560691494 ± 0.022746005674335247

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     4.47 ms
allocations: 112
storage:     84.37 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.42 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 29132.71 ± 54287.12
  RR:       0.0872975868617333 ± 0.0017908028770618728
    -> ΔwoRP: 0.004521808777334588 ± 0.0017908028770618728
  DET:      0.9985752975593986 ± 0.0008591827318036822
    -> ΔwoRP: 0.00013604669237110567 ± 0.0008591827318036822
  L:        24.466877656200886 ± 0.6198219983477297
    -> ΔwoRP: 0.690413653581551 ± 0.6198219983477297
  ENTR:     3.8465346787938723 ± 0.022104489597229122
    -> ΔwoRP: -0.018321651419124674 ± 0.022104489597229122

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     4.4 ms
allocations: 106
storage:     83.65 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.35 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 27235.78 ± 45646.44
  RR:       0.08734649876331588 ± 0.0017475797694113066
    -> ΔwoRP: 0.004570720678917159 ± 0.0017475797694113066
  DET:      0.9985696979415407 ± 0.0008454103774766207
    -> ΔwoRP: 0.00013044707451326243 ± 0.0008454103774766207
  L:        24.48415076399215 ± 0.6391268569655473
    -> ΔwoRP: 0.7076867613728162 ± 0.6391268569655473
  ENTR:     3.8471363921381534 ± 0.022797556304774983
    -> ΔwoRP: -0.017719938074843622 ± 0.022797556304774983

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 22426
  RR:       0.08918219923303311 (ΔwoRP: 0.006406421148634392)
  DET:      0.9994999999999998 (ΔwoRP: 0.0010607491329723828)
  L:        23.838945931398303 (ΔwoRP: 0.06248192877896841)
  ENTR:     3.8320473607612078 (ΔwoRP: -0.03280896945178924)


======================================================================
 SYSTEM: KLASSE 1: CHAOS (LORENZ SYSTEM)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     619.11 ms
allocations: 3
storage:     78.21 KiB
RR:   0.12050202018220797
DET:  0.9998998789325514
L:    40.53190731895452
ENTR: 4.524222130528146

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     39.4 ms
allocations: 69
storage:     160.0 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     22.66 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 590738.04 ± 13481.19
  RR:       0.12456759449220933 ± 0.004504984290608942
    -> ΔwoRP: 0.00406557431000136 ± 0.004504984290608942
  DET:      0.9998985718364038 ± 3.575728852439238e-5
    -> ΔwoRP: -1.3070961475403209e-6 ± 3.575728852439238e-5
  L:        40.45679711625979 ± 1.2589614352623806
    -> ΔwoRP: -0.07511020269472368 ± 1.2589614352623806
  ENTR:     4.437971052608048 ± 0.027618449868185884
    -> ΔwoRP: -0.08625107792009779 ± 0.027618449868185884

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 617671
  RR:       0.11708743063717104 (ΔwoRP: -0.003414589545036928)
  DET:      0.9998602375960867 (ΔwoRP: -3.964133646472412e-5)
  L:        39.56460532931121 (ΔwoRP: -0.9673019896433033)
  ENTR:     4.415985716337583 (ΔwoRP: -0.10823641419056251)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     55.56 ms
allocations: 132
storage:     203.05 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     30.2 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 769418.76 ± 23927.83
  RR:       0.10087755101121418 ± 0.003990517700728187
    -> ΔwoRP: -0.019624469170993794 ± 0.003990517700728187
  DET:      0.9999100728235293 ± 3.3990265989398094e-5
    -> ΔwoRP: 1.0193890977894249e-5 ± 3.3990265989398094e-5
  L:        41.904693630934794 ± 1.465044171104038
    -> ΔwoRP: 1.3727863119802777 ± 1.465044171104038
  ENTR:     4.471226346943911 ± 0.02920090097435951
    -> ΔwoRP: -0.05299578358423496 ± 0.02920090097435951

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 813909
  RR:       0.0970121861694318 (ΔwoRP: -0.02348983401277617)
  DET:      0.9999172342035566 (ΔwoRP: 1.7355271005214945e-5)
  L:        42.433015554440544 (ΔwoRP: 1.9011082354860278)
  ENTR:     4.493282877959766 (ΔwoRP: -0.030939252568379594)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     54.89 ms
allocations: 132
storage:     203.05 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     34.0 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 770124.69 ± 19932.45
  RR:       0.1009700385261704 ± 0.0040694119246457725
    -> ΔwoRP: -0.019531981656037575 ± 0.0040694119246457725
  DET:      0.999909572453212 ± 3.267852723920489e-5
    -> ΔwoRP: 9.693520660603028e-6 ± 3.267852723920489e-5
  L:        41.957009399414275 ± 1.375605420948459
    -> ΔwoRP: 1.4251020804597587 ± 1.375605420948459
  ENTR:     4.472086187486895 ± 0.02821491170348991
    -> ΔwoRP: -0.05213594304125024 ± 0.02821491170348991

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 817442
  RR:       0.09489365494296578 (ΔwoRP: -0.02560836523924219)
  DET:      0.9999157205292751 (ΔwoRP: 1.5841596723742413e-5)
  L:        41.6708479678876 (ΔwoRP: 1.1389406489330867)
  ENTR:     4.442449861300334 (ΔwoRP: -0.08177226922781156)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     2.82 ms
allocations: 106
storage:     123.81 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     4.14 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 15314.55 ± 428.44
  RR:       0.130550385632986 ± 0.002800387375290243
    -> ΔwoRP: 0.010048365450778016 ± 0.002800387375290243
  DET:      0.9998969999999998 ± 0.00023118054512531348
    -> ΔwoRP: -2.8789325515754527e-6 ± 0.00023118054512531348
  L:        41.04465977909012 ± 1.2161600194609703
    -> ΔwoRP: 0.5127524601356015 ± 1.2161600194609703
  ENTR:     4.4694139128254 ± 0.03166913972627722
    -> ΔwoRP: -0.05480821770274602 ± 0.03166913972627722

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 15610
  RR:       0.12812299807815503 (ΔwoRP: 0.007620977895947054)
  DET:      1.0 (ΔwoRP: 0.00010012106744861082)
  L:        40.74975746867797 (ΔwoRP: 0.2178501497234535)
  ENTR:     4.478812961390383 (ΔwoRP: -0.04540916913776272)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     24.41 ms
allocations: 121
storage:     84.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     25.32 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 573519.34 ± 99300.14
  RR:       0.13668665869297142 ± 0.005603074600328107
    -> ΔwoRP: 0.016184638510763447 ± 0.005603074600328107
  DET:      0.9998980067935891 ± 5.443392352689182e-5
    -> ΔwoRP: -1.8721389622999851e-6 ± 5.443392352689182e-5
  L:        40.61638298717009 ± 1.3631482492493725
    -> ΔwoRP: 0.08447566821557473 ± 1.3631482492493725
  ENTR:     4.44237583506873 ± 0.027821127986955428
    -> ΔwoRP: -0.08184629545941569 ± 0.027821127986955428

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 619520
  RR:       0.1270289901859504 (ΔwoRP: 0.00652697000374243)
  DET:      0.9998602233884392 (ΔwoRP: -3.965554411222705e-5)
  L:        39.56058320764203 (ΔwoRP: -0.9713241113124838)
  ENTR:     4.415893919671122 (ΔwoRP: -0.1083282108570236)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     29.18 ms
allocations: 121
storage:     84.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     27.73 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 575094.78 ± 94240.96
  RR:       0.13675049278871887 ± 0.005363938321361641
    -> ΔwoRP: 0.016248472606510897 ± 0.005363938321361641
  DET:      0.9999002206897406 ± 4.8133367739631804e-5
    -> ΔwoRP: 3.417571892150306e-7 ± 4.8133367739631804e-5
  L:        40.60189063422755 ± 1.2742909634882884
    -> ΔwoRP: 0.06998331527303492 ± 1.2742909634882884
  ENTR:     4.441548336489477 ± 0.027435740644827383
    -> ΔwoRP: -0.08267379403866837 ± 0.027435740644827383

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 619520
  RR:       0.1270289901859504 (ΔwoRP: 0.00652697000374243)
  DET:      0.9998602233884392 (ΔwoRP: -3.965554411222705e-5)
  L:        39.56058320764203 (ΔwoRP: -0.9713241113124838)
  ENTR:     4.415893919671122 (ΔwoRP: -0.1083282108570236)


======================================================================
 SYSTEM: KLASSE 2: PERIODIC (HARMONIC OSCILLATOR)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     213.86 ms
allocations: 3
storage:     78.19 KiB
RR:   0.16869916168804264
DET:  0.9998969369319293
L:    6.370145543977406
ENTR: 1.9267486031067216

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     1.85 ms
allocations: 61
storage:     159.59 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     2.14 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 66984.52 ± 1893.88
  RR:       0.16898628524778286 ± 0.0700088255139693
    -> ΔwoRP: 0.00028712355974022663 ± 0.0700088255139693
  DET:      0.9998867757289637 ± 0.00011203334831361512
    -> ΔwoRP: -1.0161202965597305e-5 ± 0.00011203334831361512
  L:        6.34521813906697 ± 2.6213292171921525
    -> ΔwoRP: -0.02492740491043577 ± 2.6213292171921525
  ENTR:     1.9174666414852128 ± 0.030887861144064985
    -> ΔwoRP: -0.009281961621508739 ± 0.030887861144064985

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 68745
  RR:       0.310202283300289 (ΔwoRP: 0.14150312161224635)
  DET:      0.9999164508313142 (ΔwoRP: 1.9513899384926425e-5)
  L:        11.97997997997998 (ΔwoRP: 5.609834436002574)
  ENTR:     1.9878967476966698 (ΔwoRP: 0.06114814458994822)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     3.18 ms
allocations: 76
storage:     177.29 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     3.84 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100683.14 ± 2890.35
  RR:       0.14957097986560616 ± 0.06125976997834061
    -> ΔwoRP: -0.019128181822436474 ± 0.06125976997834061
  DET:      0.9998987550624454 ± 0.00010035722049654214
    -> ΔwoRP: 1.818130516140215e-6 ± 0.00010035722049654214
  L:        8.249676888478993 ± 3.377447004896977
    -> ΔwoRP: 1.8795313445015864 ± 3.377447004896977
  ENTR:     2.203921262765427 ± 0.030603866975818433
    -> ΔwoRP: 0.2771726596587054 ± 0.030603866975818433

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 96342
  RR:       0.1274874859776963 (ΔwoRP: -0.04121167571034634)
  DET:      0.9998521147589471 (ΔwoRP: -4.482217298218405e-5)
  L:        6.767767767767768 (ΔwoRP: 0.3976222237903615)
  ENTR:     2.2395955728017842 (ΔwoRP: 0.31284696969506265)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     3.01 ms
allocations: 86
storage:     176.96 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     3.86 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 100712.88 ± 3259.49
  RR:       0.1514867359499661 ± 0.06377869867052818
    -> ΔwoRP: -0.017212425738076548 ± 0.06377869867052818
  DET:      0.9999036952538519 ± 8.960255833678799e-5
    -> ΔwoRP: 6.758321922650801e-6 ± 8.960255833678799e-5
  L:        8.365611139347747 ± 3.5272155448013915
    -> ΔwoRP: 1.9954655953703408 ± 3.5272155448013915
  ENTR:     2.2038992585991526 ± 0.031904838244262906
    -> ΔwoRP: 0.277150655492431 ± 0.031904838244262906

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 99457
  RR:       0.1722890020889068 (ΔwoRP: 0.0035898404008641582)
  DET:      0.9998936453070991 (ΔwoRP: -3.291624830148443e-6)
  L:        9.41091091091091 (ΔwoRP: 3.0407653669335044)
  ENTR:     2.230790756844401 (ΔwoRP: 0.3040421537376796)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     17.68 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     19.02 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11065.25 ± 366.2
  RR:       0.18093672172313136 ± 0.0057749036791174295
    -> ΔwoRP: 0.012237560035088718 ± 0.0057749036791174295
  DET:      0.9999069999999999 ± 0.00020710841096848335
    -> ΔwoRP: 1.0063068070609305e-5 ± 0.00020710841096848335
  L:        6.957799419381017 ± 0.3658081691572772
    -> ΔwoRP: 0.5876538754036105 ± 0.3658081691572772
  ENTR:     2.0295264106111066 ± 0.06002002552607694
    -> ΔwoRP: 0.10277780750438503 ± 0.06002002552607694

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     22.0 ms
allocations: 78
storage:     84.69 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     21.72 ms
allocations: 130
storage:     124.87 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11464.64 ± 4756.49
  RR:       0.1812948579166282 ± 0.010934016350903072
    -> ΔwoRP: 0.012595696228585557 ± 0.010934016350903072
  DET:      0.9999108959903483 ± 0.0002045383548802455
    -> ΔwoRP: 1.3959058419055204e-5 ± 0.0002045383548802455
  L:        6.957440256229291 ± 0.4445917745934319
    -> ΔwoRP: 0.587294712251885 ± 0.4445917745934319
  ENTR:     2.0265591733878305 ± 0.05755019014810703
    -> ΔwoRP: 0.09981057028110896 ± 0.05755019014810703

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     19.95 ms
allocations: 70
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     21.56 ms
allocations: 130
storage:     124.86 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 11516.04 ± 5028.67
  RR:       0.18103898044773634 ± 0.01131210147442948
    -> ΔwoRP: 0.0123398187596937 ± 0.01131210147442948
  DET:      0.9999083912264313 ± 0.0002124373432942578
    -> ΔwoRP: 1.1454294502000195e-5 ± 0.0002124373432942578
  L:        6.94953028916326 ± 0.4797109626632007
    -> ΔwoRP: 0.5793847451858536 ± 0.4797109626632007
  ENTR:     2.026440756658287 ± 0.05915577964664836
    -> ΔwoRP: 0.09969215355156558 ± 0.05915577964664836

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 11070
  RR:       0.18066847335140018 (ΔwoRP: 0.011969311663357546)
  DET:      1.0 (ΔwoRP: 0.00010306306807073007)
  L:        6.683379267519554 (ΔwoRP: 0.3132337235421474)
  ENTR:     1.9564003708872644 (ΔwoRP: 0.029651767780542793)


======================================================================
 SYSTEM: KLASSE 3: HOMOGENOUS RP (WHITE NOISE)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     987.83 ms
allocations: 3
storage:     78.19 KiB
RR:   0.31000792896992163
DET:  0.6957785520242857
L:    2.8168341761073212
ENTR: 1.24791486522226

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     0.5 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.33 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8075.74 ± 154.13
  RR:       0.3115337307606195 ± 0.005408644511157735
    -> ΔwoRP: 0.0015258017906978893 ± 0.005408644511157735
  DET:      0.6955117667674653 ± 0.010329478379175108
    -> ΔwoRP: -0.0002667852568204454 ± 0.010329478379175108
  L:        2.8177875702338677 ± 0.04000232867228232
    -> ΔwoRP: 0.0009533941265464918 ± 0.04000232867228232
  ENTR:     1.2450782627868708 ± 0.022354847083860065
    -> ΔwoRP: -0.0028366024353891905 ± 0.022354847083860065

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7741
  RR:       0.32202491386164855 (ΔwoRP: 0.012016984891726923)
  DET:      0.693278463648834 (ΔwoRP: -0.002500088375451681)
  L:        2.865079365079365 (ΔwoRP: 0.048245188972043884)
  ENTR:     1.2522346512278124 (ΔwoRP: 0.004319786005552384)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     0.75 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.65 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8099.71 ± 155.06
  RR:       0.31090689206099326 ± 0.005290283031157501
    -> ΔwoRP: 0.0008989630910716251 ± 0.005290283031157501
  DET:      0.6958816701596297 ± 0.009655561667988527
    -> ΔwoRP: 0.0001031181353439159 ± 0.009655561667988527
  L:        2.815713041282345 ± 0.0408290192054024
    -> ΔwoRP: -0.0011211348249764441 ± 0.0408290192054024
  ENTR:     1.2451279719043753 ± 0.02125128751215009
    -> ΔwoRP: -0.002786893317884731 ± 0.02125128751215009

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7978
  RR:       0.3114241001564945 (ΔwoRP: 0.0014161711865728899)
  DET:      0.6862088218872139 (ΔwoRP: -0.009569730137071852)
  L:        2.8059360730593608 (ΔwoRP: -0.010898103047960461)
  ENTR:     1.2252810802392875 (ΔwoRP: -0.022633784982972527)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     0.71 ms
allocations: 122
storage:     178.64 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.55 ms
allocations: 130
storage:     178.92 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 8093.7 ± 155.44
  RR:       0.31095111297944455 ± 0.00541010452157435
    -> ΔwoRP: 0.0009431840095229238 ± 0.00541010452157435
  DET:      0.6954464239613776 ± 0.010132213240336595
    -> ΔwoRP: -0.00033212806290816577 ± 0.010132213240336595
  L:        2.815934135272494 ± 0.0409654242091249
    -> ΔwoRP: -0.0009000408348271982 ± 0.0409654242091249
  ENTR:     1.2444443229989266 ± 0.02231312949835303
    -> ΔwoRP: -0.003470542223333428 ± 0.02231312949835303

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 8127
  RR:       0.30611192297773576 (ΔwoRP: -0.003896005992185869)
  DET:      0.6778994664420107 (ΔwoRP: -0.017879085582275023)
  L:        2.8300117233294255 (ΔwoRP: 0.013177547222104291)
  ENTR:     1.2183067996289512 (ΔwoRP: -0.029608065593308863)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     0.52 ms
allocations: 108
storage:     99.83 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.56 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4450.34 ± 72.06
  RR:       0.4495214712915063 ± 0.0072786672072006975
    -> ΔwoRP: 0.1395135423215847 ± 0.0072786672072006975
  DET:      0.6958644999999998 ± 0.010347364771172795
    -> ΔwoRP: 8.594797571404023e-5 ± 0.010347364771172795
  L:        2.8184931607607697 ± 0.02685924307594594
    -> ΔwoRP: 0.001658984653448492 ± 0.02685924307594594
  ENTR:     1.2474607872519783 ± 0.018972508931006243
    -> ΔwoRP: -0.000454077970281741 ± 0.018972508931006243

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     0.5 ms
allocations: 120
storage:     100.44 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.6 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4457.5 ± 73.5
  RR:       0.4488037837747431 ± 0.007407823228983937
    -> ΔwoRP: 0.13879585480482148 ± 0.007407823228983937
  DET:      0.6959364999999998 ± 0.010204918329320828
    -> ΔwoRP: 0.00015794797571411223 ± 0.010204918329320828
  L:        2.8182832555067603 ± 0.026697745378601142
    -> ΔwoRP: 0.0014490793994390572 ± 0.026697745378601142
  ENTR:     1.247520706187345 ± 0.018500156105590766
    -> ΔwoRP: -0.00039415903491502036 ± 0.018500156105590766

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     0.54 ms
allocations: 124
storage:     100.63 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     0.47 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 4457.5 ± 75.45
  RR:       0.44881032129754383 ± 0.007603104347211809
    -> ΔwoRP: 0.1388023923276222 ± 0.007603104347211809
  DET:      0.6951805 ± 0.010338716497167767
    -> ΔwoRP: -0.0005980520242857557 ± 0.010338716497167767
  L:        2.817077245956509 ± 0.026599464097733803
    -> ΔwoRP: 0.00024306984918798236 ± 0.026599464097733803
  ENTR:     1.2459818269737284 ± 0.018885478735657695
    -> ΔwoRP: -0.0019330382485316377 ± 0.018885478735657695

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 4433
  RR:       0.45116174148432164 (ΔwoRP: 0.1411538125144)
  DET:      0.6789999999999997 (ΔwoRP: -0.01677855202428602)
  L:        2.812130717365976 (ΔwoRP: -0.004703458741345035)
  ENTR:     1.2170702796361048 (ΔwoRP: -0.030844585586155215)


======================================================================
 SYSTEM: KLASSE 4: DRIFT (RANDOM WALK)
======================================================================

=== PERFORMANCE - woRP (BASELINE) ===
runtime:     197.6 ms
allocations: 3
storage:     78.19 KiB
RR:   0.21585802044425884
DET:  0.9889694676180966
L:    34.58999692843248
ENTR: 3.5367546661084104

=== PERFORMANCE - Norberts Sampling ===

  [Benchmark W/O Seed]
runtime:     5.87 ms
allocations: 121
storage:     162.36 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     6.22 ms
allocations: 121
storage:     162.36 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184970.33 ± 4055.32
  RR:       0.23714014875246459 ± 0.013683978896630514
    -> ΔwoRP: 0.02128212830820575 ± 0.013683978896630514
  DET:      0.988886669345183 ± 0.0008023907481339224
    -> ΔwoRP: -8.279827291357567e-5 ± 0.0008023907481339224
  L:        34.566524741978164 ± 1.9221166011968094
    -> ΔwoRP: -0.02347218645431326 ± 1.9221166011968094
  ENTR:     3.4488342411789854 ± 0.04616992570398844
    -> ΔwoRP: -0.08792042492942498 ± 0.04616992570398844

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186476
  RR:       0.22912194478966594 (ΔwoRP: 0.013263924345407102)
  DET:      0.9887612746810216 (ΔwoRP: -0.0002081929370749691)
  L:        33.12044046799725 (ΔwoRP: -1.4695564604352285)
  ENTR:     3.4562719601227028 (ΔwoRP: -0.08048270598570761)

=== PERFORMANCE - Importance Stratified Memory ===

  [Benchmark W/O Seed]
runtime:     7.7 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     8.82 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197101.63 ± 4495.36
  RR:       0.22900257197016727 ± 0.014852010737700273
    -> ΔwoRP: 0.013144551525908432 ± 0.014852010737700273
  DET:      0.989217630833254 ± 0.0008139333229813279
    -> ΔwoRP: 0.00024816321515741535 ± 0.0008139333229813279
  L:        35.29031269955453 ± 2.29017629195812
    -> ΔwoRP: 0.7003157711220567 ± 2.29017629195812
  ENTR:     3.4695238733550173 ± 0.04528751089405672
    -> ΔwoRP: -0.06723079275339305 ± 0.04528751089405672

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 198407
  RR:       0.2258144267998181 (ΔwoRP: 0.009956406355559277)
  DET:      0.9889733914641538 (ΔwoRP: 3.923846057185543e-6)
  L:        35.226323119777156 (ΔwoRP: 0.6363261913446792)
  ENTR:     3.4236046505015083 (ΔwoRP: -0.11315001560690208)

=== PERFORMANCE - Importance Stratified Memory EP ===

  [Benchmark W/O Seed]
runtime:     7.63 ms
allocations: 130
storage:     178.93 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     8.16 ms
allocations: 130
storage:     178.93 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 197125.41 ± 4507.09
  RR:       0.2282946132692812 ± 0.013452576456815087
    -> ΔwoRP: 0.012436592825022352 ± 0.013452576456815087
  DET:      0.9891859077915112 ± 0.0007823790770134183
    -> ΔwoRP: 0.00021644017341460042 ± 0.0007823790770134183
  L:        35.174427049540164 ± 2.0621727092724447
    -> ΔwoRP: 0.5844301211076868 ± 2.0621727092724447
  ENTR:     3.4659179085401712 ± 0.04526255954784878
    -> ΔwoRP: -0.07083675756823915 ± 0.04526255954784878

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 199562
  RR:       0.2438211328833257 (ΔwoRP: 0.02796311243906685)
  DET:      0.9898579031304316 (ΔwoRP: 0.000888435512335084)
  L:        38.52231520223152 (ΔwoRP: 3.9323182737990408)
  ENTR:     3.506187118408789 (ΔwoRP: -0.030567547699621223)

=== PERFORMANCE - Importance Stratified Memory LFBOTH ===

  [Benchmark W/O Seed]
runtime:     2.14 ms
allocations: 128
storage:     100.75 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     1.81 ms
allocations: 128
storage:     100.75 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 7547.88 ± 145.23
  RR:       0.2650731690547981 ± 0.0051015031007639955
    -> ΔwoRP: 0.04921514861053927 ± 0.0051015031007639955
  DET:      0.9891179999999998 ± 0.002318394045659831
    -> ΔwoRP: 0.0001485323819032658 ± 0.002318394045659831
  L:        35.17695148613087 ± 1.8196445195253816
    -> ΔwoRP: 0.586954557698391 ± 1.8196445195253816
  ENTR:     3.513870315864584 ± 0.1415235876963954
    -> ΔwoRP: -0.02288435024382629 ± 0.1415235876963954

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 7382
  RR:       0.270929287455974 (ΔwoRP: 0.055071267011715164)
  DET:      0.9875 (ΔwoRP: -0.0014694676180965205)
  L:        38.527089283106655 (ΔwoRP: 3.937092354674178)
  ENTR:     3.44695434022687 (ΔwoRP: -0.0898003258815403)

=== PERFORMANCE - Hybrid (LFboth Condition) ===

  [Benchmark W/O Seed]
runtime:     6.84 ms
allocations: 121
storage:     84.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     6.24 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184630.05 ± 4018.96
  RR:       0.27397355630433173 ± 0.01690827549183469
    -> ΔwoRP: 0.0581155358600729 ± 0.01690827549183469
  DET:      0.9889643613114493 ± 0.0008145184602431051
    -> ΔwoRP: -5.106306647295611e-6 ± 0.0008145184602431051
  L:        34.62945059375612 ± 2.0253173288656963
    -> ΔwoRP: 0.039453665323641474 ± 2.0253173288656963
  ENTR:     3.4537891206511566 ± 0.047516318577792496
    -> ΔwoRP: -0.08296554545725376 ± 0.047516318577792496

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186708
  RR:       0.2612796452214153 (ΔwoRP: 0.045421624777156444)
  DET:      0.9887255806325974 (ΔwoRP: -0.00024388698549915322)
  L:        33.26413793103448 (ΔwoRP: -1.3258589973979937)
  ENTR:     3.4532498097039555 (ΔwoRP: -0.08350485640445493)

=== PERFORMANCE - Hybrid (Forward Condition) ===

  [Benchmark W/O Seed]
runtime:     6.07 ms
allocations: 121
storage:     84.27 KiB

  [Benchmark WITH Seed (Random.seed!(42))]
runtime:     6.72 ms
allocations: 121
storage:     84.27 KiB

  [Statistisch W/O Seed (1000 Läufe)]
  countAll: 184694.84 ± 4169.52
  RR:       0.27325314105546983 ± 0.017312741604073232
    -> ΔwoRP: 0.05739512061121099 ± 0.017312741604073232
  DET:      0.9889162421518252 ± 0.0008165263706424385
    -> ΔwoRP: -5.322546627140046e-5 ± 0.0008165263706424385
  L:        34.570453245448356 ± 2.0027823840253625
    -> ΔwoRP: -0.019543682984121347 ± 2.0027823840253625
  ENTR:     3.4509993262017855 ± 0.046105887244723275
    -> ΔwoRP: -0.08575533990662487 ± 0.046105887244723275

  [Exakt WITH Seed (Random.seed!(42))]
  countAll: 186708
  RR:       0.2612796452214153 (ΔwoRP: 0.045421624777156444)
  DET:      0.9887255806325974 (ΔwoRP: -0.00024388698549915322)
  L:        33.26413793103448 (ΔwoRP: -1.3258589973979937)
  ENTR:     3.4532498097039555 (ΔwoRP: -0.08350485640445493)

%
\item jetzt verstehen wie das mit dme diagonale merken geht udn dann implementieren und hoffentlich mega schenll und für alle systeme und dann noch shcauen, dass ich die qualität der werte in smilfb optimiere auch mit kleinkram (0.0 zu zero(T) kinda shit), dann das selbe für norbert UND dann nochmal zeit optimieren auch mit kleinkram und gucken ob die werte schlechter werden
%
## verstehen wie das diagonalen merken ohne speichern und zeit fressen geht (zero allocation - trick)
%
\item kann man den zero allocations-trick, den ich noch nciht kenne auch für active_boxs verwenden, da das ja noch mit richtig speichern, also mit array [] und dann in jeder box mit einem schwarzen punkt push! macht, also langsam und scheiße!??
%
### 01 h : 00 min (seit dem letzten Zeitstempel)
}