% Funktion, um einen Baum für die symbolische Regression in ein
% function_handle umzuwandeln.
% tree - Ausgangsbaum
% ops - Beschreibung der Operatoren. Nur gültige Matlabfunktionen.
%       Operanden werden implizit als Leerzeichen angenommen.
% terms - Beschreibung der Terminalsymbole. 
%         -Beliebige Konstanten. Als
%         -Eine Eingabevariable 'x'. 
%         -Mehrere Eingabevariablen x_1,...,x_n -> 'x(1,:)',...,'x(n,:)'
%
% out - function_handle 
function out = tree2fun(tree,ops,terms)
	%String-Repräsentation der Funktion über eval in ein function_handle
	%überführen. 
	eval(['out = @(x) ' tree2string(tree,ops,terms) ';'])
	%Baum als Repräsentanten für eine Funktion in einen String
	%konvertieren. Leerzeichen in den Operatoren (ops) werden als
	%Platzhalter für Kinder interpretiert.
	function out = tree2string(tree,ops,terms,node)
		if nargin < 4
			%Wurzel des Baumes wählen
			node = find(tree(:,2) == 0);
		end
		%Kindknoten suchen
		children = find(tree(:,2) == node);
		if isempty(children)
			out = terms{tree(node,1)};
		else
			out = ops{tree(node,1)};
			for i=1:numel(children);
				out = regexprep(out,'[ ]',tree2string(tree,ops,terms,children(i)),'once');
			end
		end
	end
end