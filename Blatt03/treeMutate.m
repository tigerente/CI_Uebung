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

treeShow(tree, ['+' '-' '*' '/'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);

% Gehe alle Knoten b durch:
for b = 1 : size(tree,1)
    % Falls Elternknoten von b noch nicht mutiert wurde...
    parentNode = tree(b,2);
    if (parentNode == 0) || ~(mutated(parentNode))
        % Mit Wahrscheinlichkeit mutateProb...
        if (rand < mutateProb)
            disp (['Ersetze Knoten ' num2str(b)]);
            % ersetze Teilbaum des Knotens b durch zufaelligen Teilbaum
            [removedTree, left] = treeRemove(tree,b);
            treeShow(removedTree, ['+' '-' '*' '/'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);
            randTree = treeRandGenDeep(maxMutateDepth, descprobab, nrOp, nrTerm);
            treeShow(randTree, ['+' '-' '*' '/'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);
            mutatedTree = treeAppend(mutatedTree, parentNode, randTree, left);
            % markiere b als mutiert
            mutated(b)=1;
            treeShow(mutatedTree, ['+' '-' '*' '/'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);
        end
    end
end    
end

