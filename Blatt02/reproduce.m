function lambdaOffspring = reproduce(parentsPool, lambda, flagGlobalRekombination, flagDiscreteOrArithmetic, flagAlphaGlobal)
%REPRODUCE 
% Funktion zur Erzeugnung von 'lambda' Nachkommen aus den gewaehlten Eltern.
% Es koennen alle Arten der Rekombination mittels Flag-Variablen
% ausgewaehlt werden
% Parameter:
%   parentsPool:                ElternPool mit ausgewaehlten Elterngenomen
%   lambda:                     Anzahl der zu generierenden Kinder
%   flagGlobalRekombination:    Soll globale Rekombination verwendet
%                               werden?
%                               true => fuer jedes Gen zwei zufaellige Eltern
%                               false => zwei zufaellige Eltern fuer ganzes
%                               Genom
%   flagDiscreteOrArithmetic:   true => diskrete Rekombination
%                               false => arithmetische Rekombination
%   flagAlphaGlobal:            true => arithmetischer Operator 'alpha' wird fuer
%                               ganzes Genom gewaehlt
%                               false => 'alpha' wird fuer jedes Gen einzeln gewaehlt

% Anzahl Gene
numGenes = size(parentsPool,2);

% Zwischenspeicherung der 'lambda' Nachkommen, aus denen spaeter die 'my'
% besten gewaehlt werden (bei (lambda,my)-Kriterium)
lambdaOffspring = zeros(lambda,numGenes);

% Rekombination fuer jedes Kind durchfuehren
for i=1:lambda

    
    % Wenn keine globale Rekombination
    if flagGlobalRekombination == false
        
        % Zufaellige Eltern fuer ganzes Genom waehlen
        parentIdx1 = randi([1, size(parentsPool,1)]);
        parentIdx2 = randi([1, size(parentsPool,1)]);
    end
    
    % Wenn gleiches 'alpha' fuer ale Gene
    if flagAlphaGlobal == true
        alpha = rand;
    end
    
    % Durch jedes Gen gehen
    for g=1:numGenes
        
        % Wenn Globale Rekombination
        if flagGlobalRekombination == true
            % Zufaellige Eltern fuer Gen waehlen
            parentIdx1 = randi([1, size(parentsPool,1)]);
            parentIdx2 = randi([1, size(parentsPool,1)]);
        end
                
        % Wenn diskret rekombiniert werden soll
        if flagDiscreteOrArithmetic == true
            
            % Auswaehlen, welches Elternteil fuer jeweiliges Gen
            if rand < 0.5
                lambdaOffspring(i,g) = parentsPool(parentIdx1,g);
            else
                lambdaOffspring(i,g) = parentsPool(parentIdx2,g);
            end
        
        % Wenn arithmetisch rekombiniert werden soll
        elseif flagDiscreteOrArithmetic == false
            
            % Wenn fuer jedes Gen ein 'alpha' benoetigt
            if flagAlphaGlobal == false
               alpha = rand;
            end
            
            % arithmetisch rekombinieren
            lambdaOffspring(i,g) = alpha*parentsPool(parentIdx1,g) + (1-alpha)*parentsPool(parentIdx2,g);
        end
        
    end
        
end


end

