% Rekursive Funktion, um einen Teilbaum aus einem Baum zu entfernen
% tree - Ausgangsbaum
% node - Knoten der entfernt werden soll
%
% tree - resultierender Baum
% left - entfernter Baum linkes Kind des Elternknoten?
function [tree left] = treeRemove(tree, node)
	sibling = find(tree(:,2) == tree(node,2),1,'first');
	left = node==sibling;
	tree = rekTreeRemove(tree,node);
	function tree = rekTreeRemove(tree,node)
		%Überprüfen ob korrekter Knoten angegeben
		if(node < 0 || node > size(tree,1))
			error('Invalid node given!')
		end
		
		%Kinder suchen
		children = find(tree(:,2) == node);
		if(isempty(children))
			child = 0;
		else
			child = children(1);
		end
		
		%Solange noch Kinder da sind
		while(child ~= 0)
			%Kind entfernen
			tree = rekTreeRemove(tree, child);
			%Restliche Kinder suchen
			children = find(tree(:,2) == node);
			if(isempty(children))
				child = 0;
			else
				child = children(1);
			end
		end
		
		%Baummatrix restrukturieren, um den Knoten zu entfernen
		tree(node:end-1,:) = tree(node+1:end,:);
		tree = tree(1:end-1,:);
		subs = find(tree(:,2) > node);
		tree(subs,2) = tree(subs,2)-1;
	end
end