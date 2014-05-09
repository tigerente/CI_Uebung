function identityVector = stochasticUniversalSampling(fitnessVector, nOffspring)
% STOCHASTICUNIVERSALSAMPLING:
% Waehlt aus einer Population mit nach dem Verfahren des "Stochastic
% Universal Sampling" je nach relativer Fitness die Elternteile aus, die
% zur Rekombination genutzt werden sollen.
% Parameter: 
%   fitnessVector: Fitnessweerte der Individuen, aus denen die Elternteile
%   ausgewaehlt werden sollen
%   nOffspring: Anzahl der Eltern, die ausgewaehlt werden sollen
% Return: Gibt einen Vektor mit Identitaeten der Elternteile zurueck.
%   Identitaet = Index der Zeile des Individuums in der Population = Index
%   der Zeile des Individuums in 'fitnessVector'


% relative Fitness berechnen
% Vektor fuer relative Fitness und Identitaet
relativeFitness = zeros(numel(fitnessVector),2);   
% Summe aller Fitnesses
sumFit = sum(fitnessVector);                        

for i=1:numel(fitnessVector)
    relativeFitness(i,1) = fitnessVector(i)/sumFit;
    relativeFitness(i,2) = i;
end

% 'relativeFitness' nach Fitnesswert absteigend sortieren,
% Identitaetszuweisung beibehalten
relativeFitness = sortrows(relativeFitness,-1);

% Schrittweite fuer Auswahl
dist = 1/nOffspring;

% Vektor mit Pointer-Werten fuer Auswahl
% Erster Pointer zufaellig aus Intervall [0,dist]
pointers = zeros(nOffspring,1);
start = dist*rand;
for i=0:(nOffspring-1)
    pointers(i+1) = start + i*dist;
end

% Vektor fuer Identitaeten der ausgewaehlten Individuen
chosen = zeros(nOffspring,1);

% Durch 'relativeFitness' gehen und aequidistante Auswahl (startend bei
% 'start') treffen
index = 1;
for i=1:numel(pointers)
    while (sum(relativeFitness(1:index)) < pointers(i))
        index = index+1;
    end
    % Identitaet des ausgewaehlten Individuums merken
    chosen(i) = relativeFitness(index,2); 
end

% Vektor mit Identitaeten der ausgewaehlten Individuen zurueckgeben
identityVector = chosen;


end

