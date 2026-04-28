# 26.04.2026: 
## Einarbeitung in Source Tree 02 h : 00 min:
%
\itemize{
\item SSH kram unverstanden, aber mit always use manager aus der Welt!?!
\item Staged und unstaged und commit und push
\item Pull?
\item mehr nicht wichtig erstmal!?!
\item Clone?
}

## Paper von 2006 (Sektionsspezifisch auf Empfehlung gem) Sektion 3. - Methods und 3.1 - Traj.s in Ph. Sp.:
%
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
%
\item man nehme eine ausreichende anzahl an time delay schritten m \geq 2D_2+1 (D_2 \leq d = korrelations-dimenson of the (original)attractor (fraktale dimension des attraktors (wie viel raum des originalen Phasenraums nimmt der attraktor ein) (d = dim des originalen ph sp (oft unbekannt, deshalb D_2)))), und jeder dieser schritte ist ein \Delta t (messfrequenz) zurück in unserer zeitreihe/unseren messwerten der einen gemessenen observable. jeder dieser werte bekommt einen index j = 1, 2, ..., m (j = index der time delay schritte) und einen beliebigen richtungsvektor \Vec{e_j} (j = 1, 2, ..., m) (bilden ein beliebiges koordinatensystem, also gilt \Vec{e_i} \cdot \Vec{e_j} = \delta_{ij}) (Richtung der time delay schritte in unserem rekonstruierten phasenraum), und diese axialen (axen des rekonstruierten phasenraums) vektoren bilden dann den rekonstruierten \Vec{x}(t_i) = \Vec{x}_i (k.A. weshalb \hat) zu zeitpunkt t_i (i = 1, 2, ..., N) (N = anzahl der messwerte in unserer zeitreihe der einen observable) durch die folgende formel:
\begin{align*}
\Vec{x}_i = \sum_{j=1}^{m} x(t_i - (j-1)\Delta t) \Vec{e_j}
\end{align*}
und über alle i = 1,2, ..., N durchgeführt erhält man so den rekonstruierten Phasenraum mit dimension m \geq 2D_2+1 statt d und in ihm die gesamtheit an N \Vec{x}_i, die einen Attraktor bilden, der topologisch äquivalent zum originalen Attraktor ist, also die gleiche Dynamik hat.
%
\item embedding parameters dimension m (dimension des rekonstruierten Phasenraums D = d * m (d = dimension des originalen phasenraums, m = dimension für eine observable)
%) and time delay \tau (?=?(j-1)_\tau (j = 1, 2, ..., m) (time delay steps for each observable))
%
## Paper von 2006 Sektion 3.2 - RP und 3.2.1 - Definition:
%
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
## Paper von 2006 Sektion 3.2.2 - Wie ist \epsilon zu wählen?:
%
\item right size of \epsilon crucial \rightarrow dynamic \epsilon of some sort? or filtering later on in black points ? das ist mein sampling oder?
%
\item "Moreover,
the influence of noise can entail choosing a larger threshold, because noise would distort any existing structure in the
RP. At a higher threshold, this structure may be preserved (see Section 3.12)."
%
\item "Several “rules of thumb” for the choice of the threshold ε have been advocated in the literature, e.g., a few per cent
of the maximum phase space diameter has been suggested [48]. Furthermore, it should not exceed 10% of the mean or
the maximum phase space diameter [49,50]."
%
\item "A further possibility is to choose ε according to the recurrence point density of the RP by seeking a scaling region
in the recurrence point density [51]. However, this may not be suitable for non-stationary data. For this case it was
proposed to choose ε such that the recurrence point density is approximately 1% [51]"
%
\item "Another criterion for the choice of ε takes into account that a measurement of a process is a composition of the real
signal and some observational noise with standard deviation \sigma [52]. In order to get similar results as for the noise-free
situation, ε has to be chosen such that it is five times larger than the standard deviation of the observational noise, i.e.
ε > 5\sigma (cf. Section 3.12). This criterion holds for a wide class of processes."
%
\item "For (quasi-)periodic processes, the diagonal structures within the RP can be used in order to determine an optimal
threshold [53]" 
\rightarrow 
"For this purpose, the density distribution of recurrence points along the diagonals parallel to the LOI
is considered (which corresponds to the diagonal-wise defined 
-recurrence rate RR
, Eq. (50)). From such a density
plot, the number of significant peaks Np is counted. Next, the average number of neighbours Nn, Eq. (44), that each
point has, is computed. The threshold ε should be chosen in such a way that Np is maximal and Nn approaches Np."
\rightarrow 
aber das erfordert RP komplett bestimmen? oder kann ich "For this purpose, the density distribution of recurrence points along the diagonals parallel to the LOI
is considered" demnach aus meinen eh gespeciherten daten, dann dynamisch, nachdem ich irwie einige linien habe und vlt noch ein paar punkte in umgebung (density along the lines) speichere (speicherplatz verschwendung?!), die ich eh berechnet habe beim sampling (passiert glaube nicht, bei entlang der linien samplen oder zumindest nicht ausreichend um eine vertrauenswürdige density distribution zu erhalten!?!) dann ein besseres \epsilon bestimmen und damit weiter machen?
\rightarrow ICh denke die ganzen Ns bestimmen usw. dauert viel zu lange/Ukostet viel zu viel und ist es in der genauigkeit nicht wert, wenn eine der anderen methoden zur bestimmung von \epsilon viel schneller und annähernd so genau ist!!??
\rightarrow "Therefore, a good choice of ε would be to minimise the quantity

(ε) = |Nn(ε) − Np(ε)|
Nn(ε) .
\begin{align*}
\beta(ε) = \frac{|N_n(ε) - N_p(ε)|}{N_n(ε)}"
\Rightarrow "This criterion minimises the fragmentation and thickness of the diagonal lines with respect to the threshold, which can
be useful for de-noising, e.g., of acoustic signals." 
\Rightarrow Sceletonization einsparen? \rightarrow also derartig dynamisches epsilon/eine (nicht unbedingt letztere/diese hier) methode des epsilon-bestimmens besser als scelletonization durch coarse graining? oder etwas völlig anderes um das problem der dicken linien präventiv (wie mit epsilon) oder im nachhinein/reaktiv (wie mit coarse graining) am effizientesten zu lösen?
% 
### 04 h : 18 min (seit dem letzten Zeitstempel)
%
# 28.04.2026
%
\item letztere Methode mit crazy mathe mit \beta ist sehr anfällig für rauschen\\
(, weil sie auf der Anzahl der Punkte entlang der Linien basiert, die durch rauschen stark beeinflusst werden kann, während die anderen Methoden zur Bestimmung von \epsilon eher auf globalen Eigenschaften des RPs basieren und daher robuster gegenüber Rauschen sein können. Daher würde ich eher eine der anderen Methoden zur Bestimmung von \epsilon bevorzugen, um das Problem der dicken Linien zu lösen, anstatt die Methode mit \beta zu verwenden, die anfällig für Rauschen ist.)\\
das dann ?irgendwie? dafür sorgt, dass diagonale nicht mehr ordentlich gesehen werden, weil \epsilon zu klein wird/underestimated wird, weil das rauschen irwie berücksichtigt wird oder so ä.?!! 
%
\item if recurrence rate/recurrance point density (selbe?) konstant, dann epsilon konstant auch gut!!?
\rightarrow Das als kriterium und falls gegeben, dann eine von den undynamischen epsilon-bestimmungsmethoden verwenden, um die rechenzeit zu sparen, anstatt eine der dynamischen methoden zu verwenden, die mehr rechenzeit kosten, aber nicht unbedingt genauer sind als die undynamischen methoden, wenn die recurrence rate konstant ist!!?
%
\item "Other approaches use a fixed recurrence point density. In order to find an ε which corresponds to a fixed recurrence point density RR (or recurrence rate, Eq. (41)), the cumulative distribution of the N2 distances between
each pair of vectors Pc(D) can be used. The RRth percentile is then the requested ε (e.g. for RR = 0.1 the threshold ε is given by ε = D with Pc(D) = 0.1). "
%
\item "An alternative is to fix the number of neighbours for every point of
the trajectory. In this case, the threshold is actually different for each point of the trajectory, i.e. ε = ε(x_i) = ε_i
(cf. Section 3.2.5). "
%
\item " The advantage of the latter two methods is that both of them preserve the recurrence point
density and allow to compare RPs of different systems without the necessity of normalising the time series
beforehand.
Nevertheless, the choice of ε depends strongly on the considered system under study."
%
## Paper von 2006 Sektion 3.2.3 Structures in RPs:
%
\item RP initial purpose: visualisieren von traj.s im ph sp, v.A. von high dim systems (i.e. sys.s mit high dim ph sp). 
\rightarrow weshalb ist das bild vom RP hilfreich? I mean im ph.sp von z.b. pendel in 2D hast du auf also zwei achsen: für impuls und position? und dann kannst du sehen: ah impuls hoch, position runter und irwann attraktor und das ist die dynamik/das verhalten des sys.\\
Aber im RP siehst du: ah schau: impuls und ort verändern sich oder verändern sich nicht?!? Was bringt das? Was kann ich daraus lernen? Was kann ich damit machen?
%
\item "RPs yield important insights into the time evolution of these
trajectories, because typical patterns in RPs are linked to a specific behaviour of the system."
%
\item (The most important structures in RPs are diagonal lines, vertical and horizontal lines, and single isolated points. The presence of these structures is related to the behaviour of the system. For example, diagonal lines indicate that the system is evolving in a similar way at different times, while vertical and horizontal lines indicate that the system is evolving in a similar way at different times but with a time lag. Single isolated points indicate that the system is evolving in a unique way at a specific time.)
%
\item (Diagonal lines parallel to the LOI indicate that the system evolves in a similar way at different times. The length of these lines is related to the predictability of the system, because they indicate how long the system evolves in a similar way. The longer the diagonal lines, the more predictable the system is. Vertical and horizontal lines indicate that the system evolves in a similar way at different times but with a time lag. The length of these lines is related to the laminarity of the system, because they indicate how long the system evolves in a similar way with a time lag. The longer the vertical and horizontal lines, the more laminar the system is. Single isolated points indicate that the system evolves in a unique way at a specific time. The number of these points is related to the complexity of the system, because they indicate how many unique states the system passes through. The more single isolated points, the more complex the system is.)
%
### 00 h : 46 min (seit dem letzten Zeitstempel)
%
\item 
}

