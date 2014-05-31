%Definitionsbereich der Zielfunktion
minVal = -2*pi;
maxVal = 2*pi;

% I) ZUFAELLIGE SUCHE
nrRuns = 100;
nFuncCalls = 1060;

mins = Inf (1, nrRuns);

for run = 1:nrRuns
    %tic;
    for fCall = 1: nFuncCalls
        x = minVal + (maxVal-minVal) * rand(1,2);
        y = f(x);
        if y < mins(run)
            mins(run) = y;
        end
    end
    %toc;
end

disp(' ');
disp('_________Zufällige Suche__________');
disp(['Durchschnittliches Minimum: ', num2str(mean(mins))]);

% II) RASTER-SUCHE
nRasterPoints = 5;

[xMesh yMesh] = meshgrid(linspace(minVal, maxVal, nRasterPoints), ...
            linspace(minVal, maxVal, nRasterPoints));
x = [xMesh(:) yMesh(:)]';
y = f(x);

minimum = min(y);
disp(' ');
disp('_________Raster-Suche__________');
disp(['Gefundenes Minimum: ', num2str(minimum)]);
