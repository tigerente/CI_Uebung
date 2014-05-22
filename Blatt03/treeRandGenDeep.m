% Erzeugung eines zufälligen Baumes durch Wachstum
% maxDepth - maximale Tiefe des Baumes
% descPropab - Wahrscheinlichkeit, dass an einem Knoten weiter abgestiegen wird
% nrOp - Anzahl der Operatoren
% nrTerm - Anzahl der Terminalsymbole
% 
% tree - erzeugter Baum
function tree = treeRandGenDeep(maxDepth, descPropab, nrOp, nrTerm)


%Anzahl der maximalen Knoten berechnen
nrNodes = 2^maxDepth-1;
%Leeren Baum erzeugen
tree = zeros(nrNodes, 2);

%Verknüpfung der Knoten für vollständigen binären Baum erzeugen
tree(1,2) = 0;
for i=2:2:nrNodes
    tree(i,2) = tree(i-1,2)+1;
    tree(i+1,2) = tree(i-1,2)+1;
end

%Zufällige Entscheidung in der Wurzel treffen aus [1, nrOp]
tree(1,1) = ceil(rand*nrOp);
i = 2;
%Restliche Knoten durchlaufen um sie zu füllen
while(i <= nrNodes)
    %Kinder suchen
    children = find(tree(:,2) == i);
    %Keine Kinder mehr vorhanden
    if(isempty(children))
        %Terminalsymbol aus [1, nrSym] zufällig wählen
        tree(i,1) = ceil(rand*nrTerm);
    %Zufällig entscheiden, ob weiter abgestiegen werden soll ...
    elseif(rand < descPropab)
        %Zufällige Entscheidung aus [1, nrOp] erzeugen
        tree(i,1) = ceil(rand*nrOp);
    %... oder ein vorzeitiges Terminalsymbol eingefügt werden soll
    else
        %Kinder entfernen ...
        for j=1:length(children)
            tree = treeRemove(tree, children(j)-j+1);
        end
        %... und Terminalsymbol aus [1, nrSym] zufällig wählen
        tree(i,1) = ceil(rand*nrTerm);
    end
    i = i+1;
    nrNodes = size(tree,1);
end