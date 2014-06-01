function pathMatrix = path2Mat(path, n)
%PATH2MAT Wandelt einen Weg in eine Adjazenzmatrix um.
%PARAMETER
% path          Weg, der umgewandelt werden soll, als Vektor mit den
%               Knotenindizes
% n             Anzahl der Knoten im Graphen
%
%RETURN
% pathMatrix    Ungewichtete Adjazenz-Matrix mit den Kanten, die zum
%               gegebenen Weg gehoeren.

% Initialisierung
pathMatrix = zeros(n);

% Gehe alle Knoten des Weges durch
for v = 1 : size(path,2)-1
    w = v+1;
    pathMatrix (path(v), path(w)) = 1;
end

end