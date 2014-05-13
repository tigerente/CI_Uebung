function nextFreeFieldToDraw = decodeGene(numDraw, playerGenome)
%DECODEGENE Summary
% Bestimmt die naechste freie Stelle, an der der Spieler seinen Zug setzt
% abhaengig von der Nummer des aktuellen Zugs

% Grenzen des relevanten Gens in Genom
leftBorder = 0;
rightBorder = 0;

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

% Genom in den oben definierten Grenzen auswerten     
nextFreeFieldToDraw = bin2dec(char('0'+playerGenome(leftBorder:rightBorder)));

end

