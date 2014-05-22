function [child1 child2] = treeCrossover(parent1, parent2)
%TREECROSSOVER(parent1, parent2)
% Funktion zur Rekombination durch Austausch von Teilbaeumen
% PARAMETER:
%   parent1:    Elternbaum, der mit 'parent2' Nachkommen erzeugen soll
%   parent2:    Elternbaum, der mit 'parent1' Nachkommen erzeugen soll
% 
% RETURN:
%   child1:     Durch Crossover entstandenes Kind Nr. 1
%   child2:     Durch Crossover entstandenes Kind Nr. 2

% Kopien der Eltern anlegen
child1 = parent1;
child2 = parent2;

% Zufaellige Knoten fuer Crossover auswaehlen
% Auch ein Blatt kann ausgetauscht werden...

% INDEX VON 2 ANFANGEN; DA EINFUEGEN AN 0-TER STELLE NICHT MIT 'left'
% MOEGLICH BZW ABFANGEN, WENN DER ELTERNKNOTEN == 0 IST UND NEUEN KNOTEN
% WAEHLEN SINNVOLL??!?!?!

randomNode1 = randi([2,size(parent1,1)]);
randomNode2 = randi([2,size(parent2,1)]);
    
parentNode1 = parent1(randomNode1,2);
parentNode2 = parent2(randomNode2,2);

randomSubTree1 = treeGetSub(parent1, randomNode1);
randomSubTree2 = treeGetSub(parent2, randomNode2);

while (parentNode1 == 0 || parentNode2 == 0)
    
    randomNode1 = randi([2,size(parent1,1)]);
    randomNode2 = randi([2,size(parent2,1)]);
    
    parentNode1 = parent1(randomNode1,2);
    parentNode2 = parent2(randomNode2,2);

    randomSubTree1 = treeGetSub(parent1, randomNode1);
    randomSubTree2 = treeGetSub(parent2, randomNode2);

end

% Austausch der gewaehlten subTrees
% Baeume an gewaehltem Knoten entfernen
[child1,left1] = treeRemove(child1,randomNode1);
[child2,left2] = treeRemove(child2,randomNode2);

% auszutauschende UnterBaeume anfuegen
child1 = treeAppend(child1, parentNode1,randomSubTree2,left1);
child2 = treeAppend(child2, parentNode2,randomSubTree1,left2);

end

