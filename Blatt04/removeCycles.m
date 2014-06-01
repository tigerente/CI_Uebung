function pathOut = removeCycles(pathIn)
%REMOVECYCLES Entfernt Schlingen in einem Pfad und gibt den schlingenfreien
%Pfad zurueck.

pathOut = pathIn;
i = 1;
while i < size(pathOut,2)
    v = pathOut(i);
    j = find(pathOut == v, 1, 'last');
    if j < size(pathOut,2)
        pathOut = pathOut([1:i, j+1:size(pathOut,2)]);
    else
        pathOut = pathOut(1:i);
    end
    i = i + 1;
end

end

