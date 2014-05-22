% Rekursive Funktion, um einen Teilbaum von einem Baum zu erhalten
% tree - Ausgangsbaum
% node - Knoten von dem der Teilbaum geholt werden soll
%
% subtree - resultierender Teilbaum
function subtree = treeGetSub(tree, node)

%Überprüfen ob korrekter Knoten angegeben
if(node < 0 || node > size(tree,1))
    error('Invalid node given!')
end

%Wurzel holen
subtree = [tree(node,1) 0];

%Kinder finden
children = find(tree(:,2) == node);

%Rekursiv Kinder anhängen
for i=1:length(children)
    subsubtree = treeGetSub(tree, children(i));
    subtree = treeAppend(subtree, 1, subsubtree);
end