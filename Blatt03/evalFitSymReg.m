function fit = evalFitSymReg(forest,dataX,dataY,ops,terms)
%EVALFITSYMREG(forest,dataX,dataY,ops,terms)
% Bestimmt die Fitness jedes Baumes im Wald 'forest'.
% Zur Bestimmung der Fitness wird der RMSE der, von der Funktion des Baumes
% erzeugten Daten und der uebergebenen Daten bestimmt
% PARAMETER
%   forest:     Wald, der bewertet werden soll
%   dataX:      Eingabewerte: (n X m)-Matrix
%   dataY:      Ausgabewerte: (1 X m)-Matrix
%   ops:        Beschreibung der Menge der Operatoren 
%   terms:      Beschreibung der Menge der Terminalsymbole
%
% RETURN:
%   fit:        FitnessVektor des Waldes


% Fitnessvektor anlegen
fit = zeros(1,numel(forest));

% Durch kompletten Wald gehen
for i=1:numel(forest)

    % Baum in ein FunctionHandle wandeln
    fHandle = tree2fun(forest{i},ops,terms);
    
    % RMSE berechnen
    % Wenn NaN erzeugt wird, rmse auf inf setzen
    dataFromTree = fHandle(dataX);
    if sum(isnan(dataFromTree))>0
        rmse = inf;
    else
        rmse = sqrt(sum((dataY-dataFromTree).^2)/numel(dataX));
    end
     
    % Fitnesswert in 'fit' schreiben
    fit(i) = 1/(1+rmse);
end

end

