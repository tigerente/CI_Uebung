%Definitionsbereich der Zielfunktion
minVal = -2*pi;
maxVal = 2*pi;

N = 5; % Anzahl an Dimensionen

% I) ZUFAELLIGE SUCHE
nrRuns = 100;
nFuncCalls = 7760;

mins = Inf (1, nrRuns);

for run = 1:nrRuns
    %tic;
    for fCall = 1: nFuncCalls
        x = minVal + (maxVal-minVal) * rand(1,N);
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
l = 6; % Rasterlaenge pro Dimension. nthroot(7760, 5) ~= 6
rasterSize = l^N;
rasterScheme = linspace(minVal, maxVal, l);

raster = zeros(rasterSize, N); % Zeilen: N Koordiaten der Rasterpunkte
y = zeros(rasterSize, 1);

% Raster-Koordinaten bestimmen und Funktionswerte ermitteln
for r = 1: rasterSize
    k = r;
    for i = 1:N
        o = mod(k,l)+1;
        raster(r,i)=rasterScheme(o);
        k = ceil(k/l);
    end
    y = f(raster(r,:));
end
    
minimum = min(y);
disp(' ');
disp('_________Raster-Suche__________');
disp(['Gefundenes Minimum: ', num2str(minimum)]);
