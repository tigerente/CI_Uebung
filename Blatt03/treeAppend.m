% Funktion, um einen Teilbaum an einen Baum anzuh�ngen
% tree - Ausgangsbaum
% parentNode - Knoten, wo der Baum eingef�gt werden soll
% subtree - Teilbaum, der eingef�gt werden soll
% left - Flag f�r: subtree links anh�ngen
%
% tree - resultierender Baum
function tree = treeAppend(tree, parentNode, subtree, left)

if nargin<4
	left = false;
end
%�berpr�fen ob korrekter Knoten angegeben
if(any(parentNode < 0) || any(parentNode > size(tree,1)))
	error('Invalid node given!')
end

%Wo muss der Teilbaum in die Matrix eingeh�ngt werden?
if isempty(tree) % leerer Baum -> komplett �bernehmen
	tree = subtree;
else
	if left % subtree auf der linken Seite einh�ngen
		position = find(tree(:,2) == parentNode);
		tmptree = tree(position:end,:);
		tmptree(tmptree(:,2)>=position,2) = tmptree(tmptree(:,2)>=position,2) + size(subtree,1);
		subtree(1,2) = parentNode;
		subtree(2:end,2) = subtree(2:end,2) + position - 1;
		tree = [tree(1:position-1,:); subtree; tmptree];
	else % subtree auf der rechten Seite einh�ngen
		position = size(tree,1);
		subtree(1,2) = parentNode;
		subtree(2:end,2) = subtree(2:end,2) + position;
		tree = [tree;subtree];
	end
end