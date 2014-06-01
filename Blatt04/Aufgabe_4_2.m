% PARAMETER-SETUP
E = streetGraph;    % Adjazenzmatrix
V = streetNodes;
s = 66;             % Startknoten-Index
d = 2393;           % Zielknoten-Index
nrAnts = 20;         % Groesse der Ameisenkolonie
rho = 0.9;          % Verfluechtigungsfaktor der Pheromone
exitCond = [10 0 0]; % Abbruchbedingungen. Boolean-Array der Laenge 3.
%                           1 = maximale Anzahl an Iterationen
%                           2 = minimale Guete
%                           3 = konvergierende Guete
q = [2 0 0];                % Quantifizierung der Abbruchbedingung.
%                           Array der Laenge 3.
%                           1, 2: selbsterklaerend (siehe exitCond)
%                           3: Aenderung der Guete im letzten Durchlauf
visual = true;      % Visualisierung

% GO!
tic;
[bestPath bestPathCosts] = SACO(E, V, s, d, nrAnts, rho, exitCond, q, visual)
toc;