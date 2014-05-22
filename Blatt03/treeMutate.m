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
mutated = zeros(size(tree,1),1); % ggf. wird der Platz dynamisch erweitert
mutatedTree = tree;

% Gehe alle Knoten b des mutierten Bauemes durch
% Bemerkung: Der Baum aendert waehrend des Durchlaufs ggf. seine Groesse
% und Struktur. Dadurch aendert sich auch fortlaufend die Knotennummerierung
% der noch nicht betrachteten Knoten. Da jedoch nur Teilbaeume mutiert
% werden, deren Elternknoten nicht mutiert wurde,
% stimmen die Nummern der betreffenden Elternknoten stets mit der
% urspruenglichen Nummerierung ueberein.

b = 1;
while b < size (mutatedTree, 1)
    
    parentNode = mutatedTree(b,2);
    
    % Falls Elternknoten von b noch nicht mutiert wurde...
    if (parentNode == 0) || ~(mutated(parentNode))
        % Mit Wahrscheinlichkeit mutateProb...
        if (rand < mutateProb)

            % entferne b und seinen Teilbaum:
            [treeRemoved, left] = treeRemove(mutatedTree, b);

            % erzeuge zufaelligen Baum:
            randTree = treeRandGenDeep(maxMutateDepth, descprobab, nrOp, nrTerm);

            % fuege zufaelligen Baum an die Stelle von b ein:
            mutatedTree = treeAppend(treeRemoved, parentNode, randTree, left);
            
            % markiere b als mutiert:
            mutated(b)=1;

        else
            mutated(b)=0;
        end
        
    else if mutated(parentNode)
            % Da der Elternknoten mutiert wurde, ist auch der Kindknoten
            % bereits verändert und gilt daher als mutiert.
            mutated(b)=1;
        end
    end
    
    % weiter gehts:
    b = b + 1;
end
end

