function fitness = fitnessFunction(x)
%FITNESSFUNCTION fuer Audgabe 1.2
fitness = exp(-(0.003*x-3).^2)+1.5*exp(-1./(1+exp(-((x-3500)/682).^2)).^9)+1.15*exp(-0.001*(x-2000).^2)+(sin(x/20)+cos(x/21))/20-0.45;
end

