function fitness = evalFitness(population, fhandle)
% EVALFITNESS:
% Ueberfuehrt zunaechst die Binaerrepresentation der Argumente der Fitnessfunktion in
% Dezimaldarstellung. Anschliessend wird das Argument in die, durch
% 'fhanlde' uebergebene Funktion eingesetzt und die Fitness in den
% Rueckgabevector 'fitness' geschrieben.
% Parameter: 
%   population: Die Population (Binaerrepresentation der Argumente)
%   fhandle: Function handle der Fitnessfunktion

    % Genom jedes Individuums in Dezimalrepresentation ueberfuehren
    numIndivids = size(population,1);       % Anzahl Individuen
    genomeLength = size(population,2);      % Groesse der Genome
    
    binaryStringPop = cell(numIndivids,1);  % Matrix fuer Strings
    dezimalPop = zeros(numIndivids, 1);     % Dezimalrepresentation des Genoms
    
    for i=1:numIndivids
        binaryStringPop{i,1} = char('0'+population(i,:));
        dezimalPop(i) = bin2dec(binaryStringPop{i,1});
    end
    
    % Dezimalrepresentation in Fitness-Funktion einsetzen
    resultVector = zeros(size(dezimalPop)); % Ergebnisvektor 
    
    for i=1:numel(dezimalPop)
        resultVector(i) = fhandle(dezimalPop(i));
    end
    
    % Ergebnisvektor zurueckgeben
    fitness = resultVector;

end

