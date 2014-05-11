function fitness = evalFitness(population, fhandle, flagGrayCode)
% EVALFITNESS:
% Ueberfuehrt zunaechst die Binaerrepresentation der Argumente der Fitnessfunktion in
% Dezimaldarstellung. Anschliessend wird das Argument in die, durch
% 'fhanlde' uebergebene Funktion eingesetzt und die Fitness in den
% Rueckgabevector 'fitness' geschrieben.
% Parameter: 
%   population: Die Population (Binaerrepresentation der Argumente)
%   fhandle: Function handle der Fitnessfunktion
%   flagGrayCode: true  => Genom als GrayCode interpretieren
%                 false => Genom als Binaerzahl interpretieren

    % Genom jedes Individuums in Dezimalrepresentation ueberfuehren
    numIndivids = size(population,1);       % Anzahl Individuen
    
    binaryStringPop = cell(numIndivids,1);  % Matrix fuer Strings
    dezimalPop = zeros(numIndivids, 1);     % Dezimalrepresentation des Genoms
    
    for i=1:numIndivids
        
        % Wenn Interpretation von Genomen als GrayCode gewuenscht:
        % Jedes Genom von GrayCode in BinaerCode und dann in Dezimalzahl
        % wandeln
        if flagGrayCode == true
            binaryStringPop{i,1} = gray2binary(char('0'+population(i,:)));
            dezimalPop(i) = bin2dec(binaryStringPop{i,1});
        else
            binaryStringPop{i,1} = char('0'+population(i,:));      
            dezimalPop(i) = bin2dec(binaryStringPop{i,1});
        end
        
    end
    
    % Dezimalrepresentation in Fitness-Funktion einsetzen
    resultVector = zeros(size(dezimalPop)); % Ergebnisvektor 
    
    for i=1:numel(dezimalPop)
        resultVector(i) = fhandle(dezimalPop(i));
    end
    
    % Ergebnisvektor zurueckgeben
    fitness = resultVector;

end

