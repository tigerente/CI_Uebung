function trafoCells = calculateTrafos(boardSituation)
%CALCULATETRAFOS
% berechnet zu einer SpielfeldSituation alle moeglichen
% Drehungen/Spiegelungen und legt sie in ein cellArray ab, das
% zurueckgegeben wird

% Transformationen:

% keine Rotation
trafoCells{1,1} = boardSituation;

% Rotation um 90 Grad
trafoCells{2,1} = rot90(boardSituation,1);

% Rotation um 180 Grad
trafoCells{3,1} = rot90(boardSituation,2);

% Rotation um 270 Grad
trafoCells{4,1} = rot90(boardSituation,3);

% Rotation um 90 Grad + Spiegelung an x-Achse
trafoCells{5,1} = flipud(trafoCells{1,1});

% Rotation um 90 Grad + Spiegelung an y-Achse
trafoCells{6,1} = fliplr(trafoCells{1,1});

% Rotation um 180 Grad + Spiegelung an x-Achse
trafoCells{7,1} = flipud(trafoCells{2,1});

% Rotation um 180 Grad + Spiegelung an y-Achse
trafoCells{8,1} = fliplr(trafoCells{2,1});


end

