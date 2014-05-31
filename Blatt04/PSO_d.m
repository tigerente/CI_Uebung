% 1) TESTPARAMETER
flagPlot = true;
nrRuns = 1;

% 2) PARAMETER DES PSO
nrParticle = 10; %49; % Anzahl an Partikeln
vmin = 0.0001; vmax = 12; % Minimale bzw. maximale Geschwindigkeit
c0 = 0.3; % Traegheit
c1 = 0.01; % kognitiver Einfluss
c2 = 1; % sozialer Einfluss

% 3) KONSTANTEN
N = 5; % Anzahl an Dimensionen

%Bedeutung der einzelnen Eintraege
X = 1:N; % Position
DX = N+1:2*N; % Geschwindigkeit
BESTX = 2*N+1:3*N; % Beste individuelle Position
PERF = 3*N+1; BESTPERF = 3*N+2; % 

%Definitionsbereich der Zielfunktion
minVal = -2*pi;
maxVal = 2*pi;

% 4) TESTLAEUFE
% Zaehler fuer Iterationen und Funktionsaufrufe
nIters = zeros (1, nrRuns);
nFuncCalls = zeros (1, nrRuns);
for run = 1:nrRuns
    %tic;
    nAuswertungen = 0;
    nIter = 0;

    % 4.1) INITIALISIERUNG
    schwarm = zeros(3*N+2,nrParticle);

    %Startposition der Partikel
    schwarm(X,:) = minVal + (maxVal-minVal) * rand(N,nrParticle);

    %Startgeschwindigkeit der Partikel
    schwarm(DX,:) = vmin + (vmax-vmin) * rand(N,nrParticle);
    sign = 2*randi(2,N,nrParticle)-3; % zufällige Vorzeichen
    schwarm(DX,:) = schwarm(DX,:) .* sign;

    %Bestes bisher gefundenes Ergebnis
    schwarm(BESTX,:) = schwarm(X,:);

    %Performance der Partikel
    %alle Partikel bewerten
    for j = 1:nrParticle
        perf = f(schwarm(X,j));
        nAuswertungen = nAuswertungen + 1;
        schwarm(PERF, j) = perf;
        schwarm(BESTPERF, j) = perf;
    end
    
    % 4.2) SIMULATION
    %Speicher fuer Verlaufsvariablen anlegen
    winnerPerf = Inf;
    lastWinnerPerf = Inf;

    %Optimierungsschleife
    finished = false;
    while ~finished
        %alle Partikel bewerten
        for j = 1:nrParticle
            schwarm(PERF, j) = f(schwarm(X,j));
            nAuswertungen = nAuswertungen + 1;
        end

        %Besten des Schwarms ggf. merken und Abbruchbedingung pruefen
        lastWinnerPerf = winnerPerf;
        [winnerPerf,winnerIdx] = min(schwarm(PERF, :));
        if (winnerPerf < 0.1 && abs(lastWinnerPerf - winnerPerf) < 0.1)
            finished = true;
        end

        %Interaktion jedes Partikels auswerten
        for j=1:nrParticle
            % Individuelles Optimum aktualisieren
            if schwarm(PERF, j) < schwarm(BESTPERF, j)
                schwarm(BESTPERF, j) = schwarm(PERF, j);
                schwarm(BESTX, j) = schwarm(X, j);
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
            if (schwarm(PERF, leftNb) < schwarm(PERF, rightNb))
                bestNb = leftNb;
            else
                bestNb = rightNb;
            end

            %Eigene Bewegungsrichtung anpassen
            x = schwarm(X, j);
            xOpt = schwarm(BESTX, j);
            xNb = schwarm(X, bestNb);
            v = schwarm(DX, j);

            phi1 = c1 * rand(N,1);
            phi2 = c2 * rand(N,1);
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
            schwarm(X, j) = x;
            schwarm(DX, j) = v;
        end
        nIter = nIter + 1;
    end

    %toc;
    nIters(run)=nIter;
    nFuncCalls(run)=nAuswertungen;
end

% 5) AUSWERTUNG DER RESULTATE
disp(['Durchschnittliche Anzahl an Iterationen: ', num2str(mean(nIter))]);
disp(['Durchschnittliche Anzahl an Auswertungen: ', num2str(mean(nFuncCalls))]);