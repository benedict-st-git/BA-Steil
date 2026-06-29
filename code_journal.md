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
}