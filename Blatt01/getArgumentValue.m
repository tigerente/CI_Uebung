function argumentValue = getArgumentValue(population, index, flagGrayCode)
% GETARGUMENTVALUE:
% Gibt die Dezimaldarstellung des Individuums an Indexstelle/ mit Identitaet 
% 'index' in 'population' zurueck
% Parameter:
%   population: Population, in der das Individuum ist
%   index: Index der Zeile, in der das Genom des Individuums ist 
%          (=Identitaet)
%   flagGrayCode: true =>   Genom ist GrayCode
%                 false =>  Genom ist binaryCode

if flagGrayCode == true
    argumentValue = bin2dec(gray2binary(char('0'+population(index,:))));    
else
    argumentValue = bin2dec(char('0'+population(index,:)));
end

end

