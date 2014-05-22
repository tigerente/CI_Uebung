% Funktion, um einen Teilbaum an einen Baum anzuhängen
% tree - Ausgangsbaum
% parentNode - Knoten, wo der Baum eingefügt werden soll
% subtree - Teilbaum, der eingefügt werden soll
% left - Flag für: subtree links anhängen
%
% tree - resultierender Baum
function tree = treeAppend(tree, parentNode, subtree, left)

if nargin<4
	left = false;
end
%Überprüfen ob korrekter Knoten angegeben
if(any(parentNode < 0) || any(parentNode > size(tree,1)))
	error('Invalid node given!')
end

%Wo muss der Teilbaum in die Matrix eingehängt werden?
if isempty(tree) % leerer Baum -> komplett übernehmen
	tree = subtree;
else
	if left % subtree auf der linken Seite einhängen
		position = find(tree(:,2) == parentNode);
		tmptree = tree(position:end,:);
		tmptree(tmptree(:,2)>=position,2) = tmptree(tmptree(:,2)>=position,2) + size(subtree,1);
		subtree(1,2) = parentNode;
		subtree(2:end,2) = subtree(2:end,2) + position - 1;
		tree = [tree(1:position-1,:); subtree; tmptree];
	else % subtree auf der rechten Seite einhängen
		position = size(tree,1);
		subtree(1,2) = parentNode;
		subtree(2:end,2) = subtree(2:end,2) + position;
		tree = [tree;subtree];
	end
end