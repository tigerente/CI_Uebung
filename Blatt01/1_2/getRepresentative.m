function [representativeBoard, backTrans] = getRepresentative(boardSituation, equivalentClasses)
%GETREPRESENTATIVE
% Bildet eine SpielfeldSituation durch Rotation und Spiegelung auf seine
% Aequivalenzklasse ab. Gibt diese als Matrix/SpielfeldSituation zurueck
% und gibt die Tansformation an, mit der die Aequivalenzklasse wieder
% auf die uebergeben SpielfeldSituation transformiert werden kann.
% Eine Rotation mit 'rot90()' wird in Matlab immer gegeb den Uhrzeigersinn 
% ausgefuehrt

% Alle Transformationen berechnen
trafoMat = calculateTrafos(boardSituation);

% nach passender Aequivalenzklasse suchen



end

