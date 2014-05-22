function mutatedTree = treeMutate(tree,mutateProb,maxMutateDepth,descprobab, nrOp, nrTerm)
%TREEMUTATE Fuehrt eine Reihe von Teilbaummutationen durch.
%   Eingabe-Paremter:   
%       - tree: der zu mutierende Baum als (m x 2)-Matrix, wobei m die
%         Anzahl der Knoten ist
%       - mutateProb: Mutationswahrscheinlichkeit jedes Knoten bzw. Blattes
%         bei der Mutation
%       - maxMutateDepth: Maximale Tiefe des zufalligen Teilbaumes bei der
%         Mutation
%       - decsprobab: Abstiegswahrscheinlichkeit des zufalligen Teilbaumes
%         bei der Mutation.
%   Rückgabe-Parameter:
%       - mutatedTree: mutierter Baum

% Initialisierung:
mutated = zeros(size(tree,1),1);
mutatedTree = tree;

treeShow(tree, ['a' 'b' 'c' 'd'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);

% Gehe alle Knoten b durch:
for b = 1 : size(tree,1)
    parentNode = tree(b,2);
    % Falls Elternknoten von b noch nicht mutiert wurde...
    if (parentNode == 0) || ~(mutated(parentNode))
        % Mit Wahrscheinlichkeit mutateProb...
        if (rand < mutateProb)
            disp (['Ersetze Knoten ' num2str(b)]);
            % ersetze Teilbaum des Knotens b durch zufaelligen Teilbaum
            [treeRemoved, left] = treeRemove(tree,b);
            figure;
            treeShow(treeRemoved, ['a' 'b' 'c' 'd'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);
            randTree = treeRandGenDeep(maxMutateDepth, descprobab, nrOp, nrTerm);
            figure;
            treeShow(randTree, ['a' 'b' 'c' 'd'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);
            mutatedTree = treeAppend(treeRemoved, parentNode, randTree, left);
            % markiere b als mutiert
            mutated(b)=1;
            figure;
            treeShow(mutatedTree, ['a' 'b' 'c' 'd'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);
        end
    end
    
end
end

