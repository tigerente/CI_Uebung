function [ output_args ] = GenerateSituations( input_args )
% Erzeugt iterativ alle gueltigen Spielsituationen und fasst sie zu
% Aequivalenzklassen zusammen, zu denen jeweils ein Repraesentant
% hinterlegt ist.


S = zeros(3,3);
gueltige = cell(6046,1);
reps = cell(765,1);

% Gehe alle hypothetisch moeglichen Belegungen durch:
g = 0;
for i = 1:3^9
    c = i;
    einsen = 0;
    zweien = 0;
    for j = 1:9
        S(j)= mod(c,3);
        if mod(c,3) == 1, einsen = einsen + 1; end
        if mod(c,3) == 2, zweien = zweien + 1; end
        c = floor(c/3);
    end
    if (einsen >= zweien && (einsen-zweien) < 2)
        g=g+1;
        gueltige{g}=S;
        trafos = calculateTrafos(S);
        
    end
    
end

end