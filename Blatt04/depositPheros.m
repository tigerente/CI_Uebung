function pheroDeposition = depositPheros(paths, costs, n)
%DEPOSITPHEROS Berechnet aus den gegebenen Wegen aller Ameisen die
%kumulierte Pheromondeposition und gibt diese zurueck.
% PARAMETER
% paths:            Cell-Array der Ameisen-Pfade. Die Eintraege sind Vektoren
%                   mit den Indizes der abgelaufenen Knoten
% costs:            Pfadkosten der Ameisen als Vektor der Laenge nrAnts.
% n:                Anzahl der Knoten

% RETURN
% pehroDepostion    Neu deponierte Pheromone auf den Kanten als (n x n)-Array
%                   (Adjazenzmatrix).

% Initialisierung:
pheroDeposition = zeros (n);

% Gehe alle Wege durch:
for a = 1 : size(paths,2)
    p = paths{a};
    % Gehe alle Knoten des Weges durch:
    for v = 1 : size(p,2)-1
        w = v+1;
        pheroDeposition(p(v),p(w)) = pheroDeposition(p(v),p(w)) + 1/costs(a);
    end
end

end
