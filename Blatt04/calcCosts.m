function costs = calcCosts(paths, E)
%CALCCOSTS Berechnet die Kosten von Wegen = Weglaengen.
%PARAMETER
% paths     Die Wege, deren Kosten berechnet werden sollen, als Cell Array
%           der Laenge nrAnts. Die einzelnen Eintraege sind Vektoren mit
%           den Knoten des jeweiligen Weges.
% E=Kanten  n x n - Array (Adjaszenzmatrix).
%               E(i,j)=0: keine Kante zwischen i &  j
%               E(i,j)> 0: Kantengewicht (Distanz) zwischen i und j
%
%RETURN
% costs     Vektor mit den Wegkosten. Laenge: nrAnts.

% Konstanten
nrAnts = size(paths,2);

% Initialisierung
costs = zeros(1, nrAnts);

% Gehe alle Wege durch
for a = 1 : nrAnts
    p = paths{a};
    % Gehe alle Knoten des Weges durch:
    for v = 1 : size(p,2)-1
        w = v+1;
        costs(a) = costs(a) + E(v,w);
    end
end
end