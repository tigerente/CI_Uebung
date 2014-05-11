function nextPopulation = doCrossover(population, fitness, numParents,flagWindowing)
% DOCROSSOVER:
% Erstellt eine Folgegeneration von 'population'. 
% Eltern werden zufaellig proportional zu ihrer Fitness ausgewaehlt
% Es wird ein 1-Punkt-Crossover an einer zufaellig ausgewaehlten Position
% durchgefuehrt.
% Parameter:
%   population: Elterngeneration
%   fitness: Vektor mit Fitnesswerten der Individuen der Elternpopulation
%   numParents: Anzahl an Eltern, die aus 'population' ausgewaehlt werden
%   sollen
%   flagWindowing: flag-Variable, die angibt, ob Wondowing genutzt wird
% Returns: 
%   nextPopulation: Naechste Generation der Population


% Laenge jeden Genoms
genomeLength = size(population,2);

% Durch Stochastic Universal Sampling Elternteile aus 'population'
% auswaehlen
parentIdentities = stochasticUniversalSampling(fitness,numParents,flagWindowing);

% Matrix anlegen fuer naechste Generation (Gleiche Groesse wie
% 'population')
nextPopulation = population;

% Jedes Kind-Individuum erzeugen
for i=1:size(nextPopulation,1)
    
    % Zufaellige Crossover-Position
    crossIndex = randi([1,genomeLength]);
    
    % Eltern zufaellig aus Eltern-Pool 'parentIdentities' auswaehlen
    parent1 = population(parentIdentities(randi([1,numParents])),:);
    parent2 = population(parentIdentities(randi([1,numParents])),:);
    
    % Kind aus Eltern erzeugen
    child = zeros(1,genomeLength);
    child(1:crossIndex) = parent1(1:crossIndex);
    child(crossIndex+1:genomeLength) = parent2(crossIndex+1:genomeLength);
    nextPopulation(i,:) = child;
    
end


end

