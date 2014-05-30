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

%Parameter des PSO
nrParticle = 50;
vmin = 0.0; vmax = 1.0;
c1 = 1; c2 = 1;

%Bedeutung der einzelnen Einträge
X = 1; Y = 2; DX = 3; DY = 4; BESTX = 5; BESTY = 6; PERF = 7; BESTPERF = 8;

%Schwarm anlegen und mit sinnvollen Werten initialisieren
schwarm = rand(8,nrParticle);
schwarm([X Y],:) = ...;		%Startposition der Partikel
schwarm([DX DY],:) = ...;	%Startgeschwindigkeit der Partikel
schwarm([BESTX BESTY],:) = ...;	%Bestes bisher gefundenes Ergebnis
schwarm([PERF BESTPERF],:) = ...;	%Performance des Partikels

notFinished = true;
nrIter = 0;

%Speicher für Verlaufsvariablen anlegen

%Optimierungsschleife
while notFinished
    %2D-Zielfunktion in den Hintergrund legen
    pcolor(x2,x1,y), shading flat;
    hold on
    %und Schwarm darauf zeichnen
    plot(schwarm(Y,:), schwarm(X,:), '.k');
    hold off
    drawnow;
    pause(0.01);
    
    %alle Partikel bewerten
    for j=1:nrParticle
    end
    
    %Besten des Schwarms ggf. merken und Abbruchbedingung prüfen
    
    %Verlaufsinformationen speichern
    
    %Interaktion jedes Partikels auswerten
    for j=1:nrParticle
        %Den Besten der beiden Nachbarn in der Matrix auswählen
        
        %Eigene Bewegungsrichtung anpassen
        
        %Geschwindigkeit auf [vmin, vmax] begrenzen
        
        %Bewegung ausführen
        
    end
    nrIter = nrIter + 1;
end

%Auswertung der Resultate