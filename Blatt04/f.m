%Zu optimierende Funktion
% Eingabe x - Vektor, an dessen Dimensionalität sich die Funktion dynamisch
% anpasst
% Ausgabe y - Funktionswert
function y = f(x)

nrDim = length(x);
x = x-pi;
sqsum = sum(x.^2);
cossum = sum(cos(2*pi*x));
y = -20*exp(-0.2*sqrt(sqsum/nrDim))-exp(cossum/nrDim)+20 + exp(1);