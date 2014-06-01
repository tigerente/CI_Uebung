% Daten laden:
load('streetData.mat');

% PARAMETER-SETUP
E = streetGraph;    % Adjazenzmatrix
V = streetNodes;
s = 66;             % Startknoten-Index
d = 2393;           % Zielknoten-Index
nrAnts = 40;        % Groesse der Ameisenkolonie
rho = 0.85;         % Verfluechtigungsfaktor der Pheromone
exitCond = [1 1 1]; % Abbruchbedingungen. Boolean-Array der Laenge 3.
%                           1 = maximale Anzahl an Iterationen
%                           2 = minimale Guete
%                           3 = konvergierende Guete
q = [30 8000 20];   % Quantifizierung der Abbruchbedingung.
%                           Array der Laenge 3.
%                           1, 2: selbsterklaerend (siehe exitCond)
%                           3: Aenderung der Guete im letzten Durchlauf
visual = true;      % Visualisierung
initialPhero = 0.001; % initiale Pheromonstaerke

n = size(E,1);

% GO!
tic;
[bestPath bestPathCosts] = SACO(E, V, s, d, nrAnts, rho, exitCond, q, visual, initialPhero)
toc;

% Visualisierung:
if visual
    figure('WindowStyle', 'docked');
    gplot(E,V, 'k');
    hold all;
    pathMatrix = path2Mat (bestPath, n);
    gplot(pathMatrix,V);
    hold off;
    drawnow;
end