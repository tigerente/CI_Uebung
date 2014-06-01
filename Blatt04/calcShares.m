function shares = calcShares(paths)
%CALCSHARES Berechnet die Anteile der Wegenutzung durch die Ameisen.

%PARAMETER
% paths     Die Ameisenwege als Cell-Array der Laenge nrAnts.
%           Die einzelnen Eintraege sind Vektoren mit den Knoten der Wege.
%
%RETURN
% shares    Die Anteile der Wegenutzung. Vektor mit je einem Eintrag je
%           unterschiedlichem Weg.

% Konstanten
nrAnts = size(paths,2);

% Verlaufsvariablen
shares = zeros(1,nrAnts); % Vektor wird spaeter ggf. gekuerzt


% Gehe alle Wege durch
for a = 1 : nrAnts
    % Wenn Pfad noch nicht vorkam...
    if ~ ismember paths{a} 
end

end
