function nextFreeFieldToDraw = decodeGene(numDraw, playerGenome)
%DECODEGENE Summary
% Bestimmt die naechste freie Stelle, an der der Spieler seinen Zug setzt
% abhaengig von der Nummer des aktuellen Zugs

% Grenzen des relevanten Gens in Genom
leftBorder = 0;
rightBorder = 0;

% Matrix ueber Anzahl Regeln und Anzahl der noch freien Felder
rules_freeFields(1,:) = [1,3,12,38,108,174,204,153];
rules_freeFields(2,:) = [9,8,7,6,5,4,3,2];
rules_freeFields(3,:) = rules_freeFields(2,:).^rules_freeFields(1,:);

% Je nach Nummer des aktuellen Zugs in Genom schauen
switch numDraw 
    case 1
        leftBorder = 1;
        rightBorder = 4;
    case 2
        leftBorder = 5;
        rightBorder = 13;
    case 3
        leftBorder = 14;
        rightBorder = 47;
    case 4
        leftBorder = 48;
        rightBorder = 146;
    case 5
        leftBorder = 147;
        rightBorder = 397;
    case 6
        leftBorder = 398;
        rightBorder = 745;
    case 7
        leftBorder = 746;
        rightBorder = 1069;
    case 8
        leftBorder = 1070;
        rightBorder = 1222;
end

% Genom in den oben definierten Grenzen auswerten und eins addieren, 
% da Ergebnis nur aus [1,anzahlFreieFelder] sein darf, 
% aber die Binaerzahl auch eine 0 sein kann  
nextFreeFieldToDraw = bin2dec(char('0'+playerGenome(leftBorder:rightBorder))) + 1;

% Overflow abfangen
% Wenn codierte Zahl groesser als benoetigt, dann nehme den modulo davon
if nextFreeFieldToDraw > rules_freeFields(3,numDraw)
    nextFreeFieldToDraw = mod(nextFreeFieldToDraw, rules_freeFields(3,numDraw));
end





end

