function [representativeBoard, backTrans] = getRepresentative(boardSituation)
%GETREPRESENTATIVE
% Bildet eine SpielfeldSituation durch Rotation und Spiegelung auf seine
% Aequivalenzklasse ab. Gibt diese als Matrix/SpielfeldSituation zurueck
% und gibt die Tansformation an, mit der die Aequivalenzklasse wieder
% auf die uebergeben SpielfeldSituation transformiert werden kann.
% Eine Rotation mit 'rot90()' wird in Matlab immer gegeb den Uhrzeigersinn 
% ausgefuehrt

% Transformationen:

% Rotation um 90 Grad
trafoMat{1,1} = rot90(boardSituation,1);

% Rotation um 180 Grad
trafoMat{2,1} = rot90(boardSituation,2);

% Rotation um 270 Grad
trafoMat{3,1} = rot90(boardSituation,3);

% Rotation um 90 Grad + Spiegelung an x-Achse
trafoMat{4,1} = flipud(trafoMat{1,1});

% Rotation um 90 Grad + Spiegelung an y-Achse
trafoMat{5,1} = fliplr(trafoMat{1,1});

% Rotation um 180 Grad + Spiegelung an x-Achse
trafoMat{6,1} = flipud(trafoMat{2,1});

% Rotation um 180 Grad + Spiegelung an y-Achse
trafoMat{7,1} = fliplr(trafoMat{2,1})

representativeBoard = trafoMat;
backTrans = 0;

end
