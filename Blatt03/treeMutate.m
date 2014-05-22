function mutatedTree = treeMutate(tree, mutateProb, maxMutateDepth, descprobab, nrOp, nrTerm)
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

figure;
treeShow(tree, ['a' 'b' 'c' 'd'], ['1' '2' '3' '4' '5' '6' '7' '8' '9']);
% Mit Wahrscheinlichkeit mutateProb...
if (rand < mutateProb)
    mutatedTree = treeRandGenDeep(maxMutateDepth, descprobab, nrOp, nrTerm);
else
    treeLeft = TreeGetSub(tree, 2);
    treeRight = TreeGetSub(tree, 3);
    treeLeftMutated = treeMutate(treeLeft, mutateProb, maxMutateDepth, descprobab, nrOp, nrTerm);
    treeRightMutated = treeMutate(treeRight, mutateProb, maxMutateDepth, descprobab, nrOp, nrTerm);
    root = tree(1,:);
    mutatedTree = treeAppend(root,1,treeLeftMutated,1);
    mutatedTree = treeAppend(mutatedTree,1,treeRightMutated,0);
end

end

