function costs = calcCosts(path, E)
%CALCCOSTS Berechnet die Kosten eines Weges.
%PARAMETER
% path      Der Weg, dessen Kosten berechnet werden sollen, als Vektor mit
%           den Knoten des Weges.
% E=Kanten  n x n - Array (Adjazenzmatrix).
%               E(i,j)=0: keine Kante zwischen i &  j
%               E(i,j)> 0: Kantengewicht (Distanz) zwischen i und j
%
%RETURN
% costs     Wegkosten

% Initialisierung
costs = 0;

% Gehe alle Knoten des Weges durch:
for v = 1 : (size(path,2)-1)
    w = v+1;
    costs = costs + E(path(v),path(w));
end

end