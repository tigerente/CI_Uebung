% PARAMETER-SETUP
E = streetGraph;    % Adjazenzmatrix
s = 66;             % Startknoten-Index
d = 2393;           % Zielknoten-Index
nrAnts = 2;        % Groesse der Ameisenkolonie
rho = 0.9;          % Verfluechtigungsfaktor der Pheromone
exitCond = [1 0 0]; % Abbruchbedingungen. Boolean-Array der Laenge 3.
%                           1 = maximale Anzahl an Iterationen
%                           2 = minimale Guete
%                           3 = konvergierende Guete
q = [5 0 0];                % Quantifizierung der Abbruchbedingung.
%                           Array der Laenge 3.
%                           1, 2: selbsterklaerend (siehe exitCond)
%                           3: Aenderung der Guete im letzten Durchlauf

% GO!
[bestPath bestPathCosts] = SACO(E, s, d, nrAnts, rho, exitCond, q)