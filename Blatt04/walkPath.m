function paths = walkPath(antColony, graph, pheromones, start, goal)
%WALKPATH(antColony, graph)
% Laesst jede Ameise der einegebenen Kolonie einen Weg suchen
% PARAMETER:
%   antColony:      Ameisenkolonie, deren Ameisen Pfade suchen sollen
%   graph:          Der Graph, dessen kuerzester Weg gefunden werden soll
%   pheromones:     Matrix des Graphen. Statt Kosten der Kanten, Menge an
%                   Pheromonen, die dort liegen
%   start:          Index des Startknotens
%   goal:           Index des Zielknotens
% RETURN:
%   paths:          Eine Matrix, in der fuer jedes Individuum der gelaufene
%                   Pfad steht

% Anzahl der Ameisen
numOfAnts = size(antColony,1);

% Array fuer Pfad der aktuellen Ameise
% An erster Stelle stehen die Gesamtkosten des Pfades, der dahinter steht
pathArray = zeros(1,5);

% flag ob Pfad gefunden
pathFound = false;

% Jede Ameise einen Pfad suchen lassen
for a=1:numOfAnts

    % Variable fuer aktuellen Knoten
    currentNode = start;
    
    % Pfad suchen
    while pathFound == false
       
        % Naechsten Knoten waehlen
        nextNode = pickNextStreet(pheromones,currentNode);
        
        % Kosten der gewaehlten Kante aufaddieren
        pathArray(1) = pathArray(1) + 
        
        
        
        
    end
    
    
end















end
