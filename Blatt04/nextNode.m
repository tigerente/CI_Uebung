function idxNextNode = nextNode(pheromoneMap, currentNodeIdx)
%nextNode(pheromoneMap, currentNodeIdx)
% Waehlt proportional zur Pheromonstaerke eine Kante des Graphen aus, der
% durch 'pheromoneMap' repraesentiert wird
% PARAMETER:
%   pheromoneMap:       Graph, in dem statt Kantenkosten
%                       Pheromonkonzentrationen stehen
%   currentNodeIdx:     Index der aktuellen Position (aktueller Knoten)
%
% RETURN:       
%   idxNextNode:        Index des ausgewehlten naechsten Knotens


% Pheromonkonzentration der Kanten auslesen
targetNodes = find(pheromoneMap(currentNodeIdx,:) > 0)';
pheromones = pheromoneMap(targetNodes);
pheromones(:,2) = targetNodes;

% Pheromonkonzentrationen relativieren und sortieren
pheromones(:,1) = pheromones(:,1)/sum(pheromones(:,1));
pheromones = sortrows(pheromones,-1);

% Naechsten Knoten je nach Pheromonkonzentration auswaehlen
idx = find(cumsum(pheromones(:,1))>=rand);
idxNextNode = pheromones(idx(1),2);

end
