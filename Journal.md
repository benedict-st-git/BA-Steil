# 26.04.2026: 
## Einarbeitung in Source Tree 02 h : 00 min:
\itemize{
\item SSH kram unverstanden, aber mit always use manager aus der Welt!?!
\item Staged und unstaged und commit und push
\item Pull?
\item mehr nicht wichtig erstmal!?!
\item Clone?
}

## Paper von 2006 Sektion 3.1 (+Intro) (empfehlung gem):
\itemize{
\item Formally dynamical sys given by phase space, discrete or cont time and a time evolution law
%
\item time evolution (physikalische gesetze) determine at every time t all d phase space dimensions/all d variables in t.e.l./the state of the system ?from its states at all previous times?
%
\item  For time-continuous systems the time
evolution is given by a set of differential equations:
\begin{align*}
\Vec{\dot{x}}(t) = \frac{d\Vec{x}(t)}{dt} = F(\Vec{x}(t)), F: \mathbb{R}^d \rightarrow \mathbb{R}^d
\end{align*}
The vectors $\Vec{x}(t)$ define a trajectory in phase space, which is called the orbit of the system. Which is the set of all states that the system passes through as time evolves. The state of the system at time t is given by $\Vec{x}(t)$, and the initial state at time t=0 is given by $\Vec{x}(0)$. The time evolution of the system is determined by the function F, which describes how the state of the system changes over time. The behavior of the system can be analyzed by studying the properties of F and its fixed points, periodic orbits, and chaotic attractors.
\subitem For time-discrete systems, the time evolution is given by a map?
\subitem \Vec{x(t)} enthält hier die Werte aller d Variablen zum Zeitpunkt t, also den Zustand des Systems zu diesem Zeitpunkt. Die Funktion F beschreibt, wie sich der Zustand des Systems von einem Zeitpunkt zum nächsten ändert. Die Trajektorie des Systems in der Phasenraum ist die Menge aller Zustände, die das System im Laufe der Zeit durchläuft. Die Anfangsbedingung \Vec{x(0)} bestimmt, von welchem Punkt im Phasenraum das System startet und beeinflusst somit die Trajektorie und das langfristige Verhalten des Systems. 
%
\item Attractors are sets of states towards which the system tends to evolve over time. They can be points, curves, or more complex structures in phase space. Attractors can be classified into three types: fixed points, limit cycles, and strange attractors.
%
### 01 h : 00 min (seit dem letzten Zeitstempel)
%
# 27.04.2026:
## Paper von 2006 Sektion 3.1 (+Intro) further:
\item man nehme eine ausreichende anzahl an time delay schritten m \geq 2D_2+1 (D_2 \leq d = korrelations-dimenson of the (original)attractor (fraktale dimension des attraktors (wie viel raum des originalen Phasenraums nimmt der attraktor ein) (d = dim des originalen ph sp (oft unbekannt, deshalb D_2)))), und jeder dieser schritte ist ein \Delta t (messfrequenz) zurück in unserer zeitreihe/unseren messwerten der einen gemessenen observable. jeder dieser werte bekommt einen index j = 1, 2, ..., m (j = index der time delay schritte) und einen beliebigen richtungsvektor \Vec{e_j} (j = 1, 2, ..., m) (bilden ein beliebiges koordinatensystem, also gilt \Vec{e_i} \cdot \Vec{e_j} = \delta_{ij}) (Richtung der time delay schritte in unserem rekonstruierten phasenraum), und diese axialen (axen des rekonstruierten phasenraums) vektoren bilden dann den rekonstruierten \Vec{x}(t_i) = \Vec{x}_i (k.A. weshalb \hat) zu zeitpunkt t_i (i = 1, 2, ..., N) (N = anzahl der messwerte in unserer zeitreihe der einen observable) durch die folgende formel:
\begin{align*}
\Vec{x}_i = \sum_{j=1}^{m} x(t_i - (j-1)\Delta t) \Vec{e_j}
\end{align*}
und über alle i = 1,2, ..., N durchgeführt erhält man so den rekonstruierten Phasenraum mit dimension m \geq 2D_2+1 statt d und in ihm die gesamtheit an N \Vec{x}_i, die einen Attraktor bilden, der topologisch äquivalent zum originalen Attraktor ist, also die gleiche Dynamik hat.
%
\item embedding parameters dimension m (dimension des rekonstruierten Phasenraums D = d * m (d = dimension des originalen phasenraums, m = dimension für eine observable)
%) and time delay \tau (?=?(j-1)_\tau (j = 1, 2, ..., m) (time delay steps for each observable))
%
## Paper von 2006 Sektion 3.2.1:
\item RP mit L_x-Normen (x = 1, 2, \infty) ; L_1 = city block (simple differenz), L_2 = euklidisch (standard (von Norbert), aber quad und dann sqrt), L_\infty = max aller simplen diffs (max norm); L_2 norm ist am gebräuchlichsten, aber L_\infty norm ist am robustesten gegenüber rauschen (weil nur max diff zählt, nicht alle diffs), L_1 norm ist am empfindlichsten gegenüber rauschen (weil alle diffs zählen, nicht nur max diff); am schnellsten ist L_\infty norm, weil nur max diff berechnet werden muss, nicht alle diffs (L_1 und L_2 norm müssen alle diffs berechnen, aber L_2 norm muss zusätzlich quadrieren und sqrt machen, was mehr rechenzeit kostet als nur max diff berechnen).
\\
\Rightarrow sampling (der indizes) der vektorkomponenten/differenzen der vektorkomponenten zur beschleunigung/sparen von Rechenzeit?! \rightarrow Nein! m ist zu klein, i.e. sampling kostet im bereich m \geq 2*D_2+1 mehr, als alle diffs benötigt in L_\infty zu berechnen!
%
\item Warum diese komishcen neighborhodd formen (L_1 ^= diamant, L_2 ^= kreis, L_\infty ^= quadrat)?
%
\item  "Considering a fixed ε, the L∞-norm finds the most, the L1-norm the least
and the L2-norm an intermediate amount of neighbours. To compute RPs, the L∞-norm is often applied, because it is
computationally faster and allows to study some features in RPs analytically."
%
## Paper von 2006 Sektion 3.2.2:
\item 
}

