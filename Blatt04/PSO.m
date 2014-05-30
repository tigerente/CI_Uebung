%Definitionsbereich der Zielfunktion
minVal = -2*pi;
maxVal = 2*pi;

%Zielfunktion für Visualisierung erzeugen
x1 = linspace(minVal, maxVal, 100);
x2 = linspace(minVal, maxVal, 100);
y = zeros(length(x1), length(x1));
for i=1:length(x1)
    for j=1:length(x2)
        y(i,j) = f([x1(i) x2(j)]);
    end
end

% _________________________________________________________________________
%Parameter des PSO
nrParticle = 10^2; % Anzahl an Partikeln (Quadratzahl fuer regulaere Startverteilung)
vmin = 0.0; vmax = 1.0; % Minimale bzw. maximale Geschwindigkeit
c0 = 1; % Trägheit
c1 = 1; % kognitiver Einfluss
c2 = 1; % sozialer Einfluss
sPosRndElseRegl = true; % true: Startpositionen sind zufaellig gleichverteilt
                        % false: Startpositionen sind gleichmaeßig verteilt
sVelRndElseZero = true; % true: Startgeschwindigkeiten sind zufaellig gleichverteilt
                        % false: Startgeschwindigkeiten = 0
%__________________________________________________________________________

%Bedeutung der einzelnen Eintraege
X = 1; Y = 2; % Position
DX = 3; DY = 4; % Geschwindigkeit
BESTX = 5; BESTY = 6; % Beste individuelle Position
PERF = 7; BESTPERF = 8; % 

%Schwarm anlegen und mit sinnvollen Werten initialisieren
    schwarm = zeros(8,nrParticle);
    
    %Startposition der Partikel
    if sPosRndElseRegl
        schwarm([X Y],:) = minVal + (maxVal-minVal) * rand(2,nrParticle);
    else
        [xMesh yMesh] = meshgrid(linspace(minVal, maxVal, sqrt(nrParticle)), ...
            linspace(minVal, maxVal, sqrt(nrParticle)));
        schwarm([X Y],:) = [xMesh(:) yMesh(:)]';
    end
    
    %Startgeschwindigkeit der Partikel
    if sVelRndElseZero
        schwarm([DX DY],:) = vmin + (vmax-vmin) * rand(2,nrParticle);
    else
        schwarm([DX DY],:) = zeros(2,nrParticle);
    end
    
    %Bestes bisher gefundenes Ergebnis
    schwarm([BESTX BESTY],:) = schwarm([X Y],:);
    
    %Performance der Partikel
    perf = f(schwarm([X Y],:));
    bestPerf = f(schwarm([BESTX BESTY],:));
    schwarm([PERF BESTPERF],:) = [perf; bestPerf];

    finished = false;
    nrIter = 0;

%Speicher fuer Verlaufsvariablen anlegen
winnerPerf = Inf;
lastWinnerPerf = Inf;

%Optimierungsschleife
while ~finished
    %2D-Zielfunktion in den Hintergrund legen
    pcolor(x2,x1,y), shading flat;
    hold on
    %und Schwarm darauf zeichnen
    plot(schwarm(Y,:), schwarm(X,:), '.k');
    hold off
    drawnow;
    pause(0.01);
    
    %alle Partikel bewerten
    schwarm(PERF, :) = f(schwarm([X Y],:));
    
    %Besten des Schwarms ggf. merken und Abbruchbedingung pruefen
    lastWinnerPerf = winnerPerf
    [winnerPerf,winnerIdx] = max(schwarm(PERF, :));
    if (winnerPerf < 0.1 && abs(lastWinnerPerf - winnerPerf) < 0.1)
        finished = true;
    end
    
    %Verlaufsinformationen speichern
    
    %Interaktion jedes Partikels auswerten
    for j=1:nrParticle
        % Individuelles Optimum aktualisieren
        if schwarm(PERF, j) < schwarm(BESTPERF, j)
            schwarm(BESTPERF, j) = schwarm(PERF, j);
            schwarm([BESTX BESTY], j) = schwarm([X Y], j);
        end
        
        %Den Besten der beiden Nachbarn in der Matrix auswaehlen
        leftNb = j-1; % linker Nachbar
        if leftNb == 0
            leftNb = nrParticle;
        end
        rightNb = j+1; % rechter Nachbar
        if rightNb == nrParticle + 1
            rightNb = 1;
        end
        if (schwarm(PERF, leftNb) > schwarm(PERF, rightNb))
            bestNb = leftNb;
        else
            bestNb = rightNb;
        end
        
        %Eigene Bewegungsrichtung anpassen
        x = schwarm([X Y], j);
        xOpt = schwarm([BESTX BESTY], j);
        xNb = schwarm([X Y], bestNb);
        v = schwarm([DX DY], j);
        
        phi1 = c1 * rand(2,1);
        phi2 = c2 * rand(2,1);
        v = c0*v + phi1 .* (xOpt - x) + phi2 .* (xNb - x);
        
        %Geschwindigkeit auf [vmin, vmax] begrenzen
        vNorm = norm(v);
        if vNorm < vmin
            v = (vmin/vNorm)*v;
        end
        if vNorm > vmax
            v = (vmax/vNorm)*v;
        end
        %Bewegung ausfuehren
        x = x + v;
        %Ort und Geschwindigkeit speichern
        schwarm([X Y], j) = x;
        schwarm([DX DY], j) = v;
    end
    nrIter = nrIter + 1;
end

%Auswertung der Resultate