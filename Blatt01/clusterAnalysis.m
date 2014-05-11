function clusterData = clusterAnalysis(argumentData,leftMin,leftMax,midMin,midMax,rightMin,rightMax)
%CLUSTERANALYSIS
% Zaehlt, wie oft Argumente in welchem Cluster der Funktion liegen
% Gibt einen Vektor clusterData zurueck:
% clusterData(1):   Anzahl Treffer in linkem Cluster
% clusterData(2):   Anzahl Treffer in mittlerem Cluster
% clusterData(3):   Anzahl Treffer in rechtem Cluster
% Parameter:
%   argumentData:   Funktionsargumente die analysiert werden sollen
%   leftMin:        untere Grenze des linken Clusters
%   leftMax:        obere Grenze des linken Clusters
%   midMin:         untere Grenze des mittleren Clusters
%   midax:          obere Grenze des mittleren Clusters
%   rightMin:       untere Grenze des rechten Clusters
%   rightMin:       obere Grenze des rechten Clusters

clusterData = [0,0,0];

% Durch 'argumentData' gehen und 'clusterData' anpassen
for i=1:numel(argumentData)

    if (argumentData(i) > leftMin) && (argumentData(i) <= leftMax)
       clusterData(1) = clusterData(1) + 1; 
    elseif (argumentData(i) > midMin) && (argumentData(i) <= midMax)
       clusterData(2) = clusterData(2) + 1;
    elseif (argumentData(i) > rightMin) && (argumentData(i) <= rightMax)
        clusterData(3) = clusterData(3) + 1;
    end

end

end

