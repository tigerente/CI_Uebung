function [bestPath, bestPathCosts] = SACO(E, V, s, d, nrAnts, rho, exitCond, q, visual, initialPhero)
% SACO Implementation der Standard Ant Colony Optimization
% PARAMETER:
%           E,V             Graph auf dem ein kuerzester Weg
%                           angenaehert werden soll.
%           -> E            Kanten: n x n - Array (Adjazenzmatrix).
%                                     E(i,j)=0: keine Kante zwischen i &  j
%                                     E(i,j)> 0: Kantengewicht (Distanz)
%                                     zwischen i und j
%           -> V            Koordinatenliste der Knoten. Nur fuer
%                           Visualisierung
%           s               Index des Startknotens
%           d               Index des Zielknotens
%           nrAnts          Anzahl der suchenden Ameisen
%           rho             Verfluechtigungsfaktor der Pheromone
%           exitCond        Abbruchbedingungen. Boolean-Array der Laenge 3.
%                           1 = maximale Anzahl an Iterationen
%                           2 = minimale Guete
%                           3 = konvergierende Guete
%           q               Quantifizierung der Abbruchbedingung.
%                           Array der Laenge 3.
%                           1, 2: selbsterklaerend (siehe exitCond)
%                           3: Aenderung der Guete im letzten Durchlauf
%           visual          True: Visualisierung an
%           initialPhero    initiale Pheromonstaerke
%           
% RETURN:
%           bestPath        Kuerzester gefundener Weg. Repraesentiert als
%                           Vektor mit den Indizes der Knoten auf dem Weg
%                           vom Start- zum Zielknoten. Dient im Verlauf
%                           als Hall of Fame.

% KONSTANTEN
n = size(E,1);

% VERLAUFSVARIABLEN
pheros = zeros (size(E)); % Pheromonstaerke auf den Kanten
paths = cell (1, nrAnts);
costs = zeros (1, nrAnts); % Kosten der Ameisenpfade
bestPathCosts = Inf;

% INITIALISIERUNG
pheros = (E>0)*initialPhero; % Alle vorhandenen Kanten: initiale Pheromonstaerke

% SIMULATION
finished = false;
iterations = 0;
while ~finished
    iterations = iterations + 1
    % Jede Ameise ist einmal dran:
    for a = 1:nrAnts
        v = s;
        paths{a}= [s];
        while v ~= d
            v = nextNode(pheros, v);
            paths{a}=[paths{a} v];
        end
        paths{a} = removeCycles(paths{a});
        costs(a) = calcCosts(paths{a}, E);
    end
    
    % Aktualisiere Pheromonstaerken:
    pheros = (1-rho)*pheros + depositPheros(paths, costs, n);
    
    % Aktualisiere Hall of Fame:
    [newBestPathCosts, newBestPathIdx] = min(costs);
    if (newBestPathCosts < bestPathCosts)
        deltaCosts = abs(bestPathCosts - newBestPathCosts);
        bestPathIdx = newBestPathIdx;
        bestPath = paths{bestPathIdx};
        bestPathCosts = newBestPathCosts;
    end
    
    % Visualisierung:
    if visual
        figure('WindowStyle', 'docked');
        gplot(E,V, 'k');
        hold all;
        for a = 1 : nrAnts
            pathMatrix = path2Mat (paths{a}, n);
            gplot(pathMatrix,V);
        end
        hold off;
        drawnow;
    end
    
    % Abbruchbedingungen:
    if (exitCond(1) && iterations > q(1)-1)...
            || (exitCond(2) && bestPathCosts < q(2))...
            || (exitCond(3) && deltaCosts < q(3))
        finished = true;
    end
    
    
end
end

