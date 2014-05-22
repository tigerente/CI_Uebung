% Visualisierung eines Baums
% tree - Baum, der dargestellt werden soll
% nodeName - Beschreibung der Operatoren
% leafName - Beschreibung der Terminalsymbole
% dx - Abstand des Textes vom Knoten in x-Richtung (optional)
% dy - Abstand des Textes vom Knoten in y-Richtung (optional)
function treeShow(tree, nodeName, leafName, dx, dy)


%Standardparameter festlegen
if(nargin< 4), dx = 0.05; end
if(nargin< 4), dy = 0.0; end

%Baum zeichnen mit matlabeigener Funktion
treeplot(tree(:,2)')

%Knotenpositionen holen
[x,y] = treelayout(tree(:,2)');
%Und die Texte entsprechend schreiben
for i=1:size(tree,1)
    children = find(tree(:,2) == i);
    if(isempty(children))
        text(x(i)+dx, y(i)+dy, leafName(tree(i,1)));
    else
        text(x(i)+dx, y(i)+dy, nodeName(tree(i,1)));
    end
end