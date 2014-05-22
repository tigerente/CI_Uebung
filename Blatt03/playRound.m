% Diese Funktion spielt mit einem gegebenen Genom eine Runde des
% Westernszenarios
% genome - Baum, der das Verhalten der Kutsche beschreibt
% show - true visualisiert das Spiel
%
% fitness - Rückgabe der erreichten Fitness im Spiel
function fitness = playRound(genome, show)
if nargin < 2
	show = false;
end
%Setup des Spielfelds
fieldColors = [1 1 1; 0 1 0; 0 0.5 0; 0 0 0; 0 0 1; 1 1 0];
field = zeros(17,17);
%Heimatstadt
hometown = [3 3];
%Poststation
postal = [10 15];
%Räuber
robber = [2 7];
walk = 1;
field(robber(1), robber(2)) = 3;
%Postkutsche
carriage = [3 3];
field(carriage(1), carriage(2)) = 4;
hasPost = 0;

maxSteps = 100;

%Ist die Kutsche auf dem Hin- oder Rückweg?
mode = 1;

%Simulation für 100 Schritte, bis die Nahrung ausgegangen ist
for i=1:maxSteps
	tic
	%Räuber bewegen
	field(robber(1), robber(2)) = 0;
	if(robber(1) > 9)
		walk = -1;
	elseif(robber(1) < 3)
		walk = 1;
	end
	if(rand < 0.5)
		robber(1) = robber(1)+walk;
	end
	field(robber(1), robber(2)) = 3;
	
	%Postkutsche bewegen
	field(carriage(1), carriage(2)) = 0;
	carriage = moveCarriage(carriage, hometown, postal, robber, mode, hasPost, genome);
	%Post abholen
	if(all(carriage==postal))
		hasPost = 1;
		mode = 2;
	end
	%Post wird vom Räuber gestolen
	if(all(carriage==robber))
		hasPost = 0;
	end
	%Heimatstadt wurde wieder erreicht
	if(mode==2 && all(carriage==hometown))
		break
	end
	field(carriage(1), carriage(2)) = 4+hasPost;
	
	if(show)
		%Visualisierung des Spielfeldes
		field(hometown(1), hometown(2)) = 1;
		field(postal(1), postal(2)) = 2;
		pcolor(field)
		colormap(fieldColors)
		caxis([0 5])
		t = toc;
		pause(0.1-t)
	end
end

%Fitness bewerten
if(mode == 1)
	fitness = max(0,(norm(hometown-postal)-norm(carriage-postal))/norm(hometown-postal));
else
	fitness = 1 ...
		+ hasPost ...
		+ max(0, (norm(hometown-postal)-norm(carriage-hometown))/norm(hometown-postal)) ...
		+ (maxSteps-i)/maxSteps;
end

	%----------------------------------------------------------------------
	% Diese Funktion bewegt die Kutsche aufgrund der aktuellen 
	% Spielsituation und des Genoms
	% carriage - Position der Kutsche
	% hometown - Position der Heimatstadt
	% postal - Position des Postamts
	% robber - Position des Räubers
	% mode - Hinweg (=1) oder Rückweg (=2)
	% hasPost - Hat die Kutsche Post dabei?
	% genome - Genom der Kutsche
	%
	% carriage - Neue Position der Kutsche
	function carriage = moveCarriage(carriage, hometown, postal, robber, mode, hasPost, genome)
		
		%Räuberabfragen
		isRN = robber(1)>carriage(1);
		isRE = robber(2)>carriage(2);
		isRS = robber(1)<carriage(1);
		isRW = robber(2)<carriage(2);
		
		%Zielabfragen
		if(mode == 1)
			isTN = postal(1)>carriage(1);
			isTE = postal(2)>carriage(2);
			isTS = postal(1)<carriage(1);
			isTW = postal(2)<carriage(2);
		else
			isTN = hometown(1)>carriage(1);
			isTE = hometown(2)>carriage(2);
			isTS = hometown(1)<carriage(1);
			isTW = hometown(2)<carriage(2);
		end
		
		%Wurzel des Baumes wählen
		node = find(genome(:,2) == 0);
		%und deren Kindknoten suchen
		children = find(genome(:,2) == node);
		
		%solange noch Kinder vorhanden sind, weiter absteigen im Baum
		while(~isempty(children))
			%Falls nur ein Kind da ist, dieses Kind wählen
			if(length(children) < 2)
				node = children(1);
			else
				%Sonst wird das Kind als Abstieg gewählt, das zum Kriterium passt
				if(genome(node,1) == 1  && hasPost || ...
						genome(node,1) == 2  && isRN || ...
						genome(node,1) == 3  && isRE || ...
						genome(node,1) == 4  && isRS || ...
						genome(node,1) == 5  && isRW || ...
						genome(node,1) == 6  && isTN || ...
						genome(node,1) == 7  && isTE || ...
						genome(node,1) == 8  && isTS || ...
						genome(node,1) == 9  && isTW)
					node = children(1);
				else
					node = children(2);
				end
			end
			%Kinder des neuen Knoten suchen
			children = find(genome(:,2) == node);
		end
		
		%der zuletzt gefundene Knoten gibt die Aktion an
		action = genome(node,1);
		
		%abhängig von der Aktion wird die Kutsche bewegt
		if(action == 1)
			carriage(1) = carriage(1)+1;
		elseif(action == 2)
			carriage(1) = carriage(1)-1;
		elseif(action == 3)
			carriage(2) = carriage(2)+1;
		elseif(action == 4)
			carriage(2) = carriage(2)-1;
		end
		
		%Am Spielfeldrand kann die Kutsche nicht weiter
		if(carriage(1) < 1)
			carriage(1) = 1;
		elseif(carriage(1) > 16)
			carriage(1) = 16;
		end
		if(carriage(2) < 1)
			carriage(2) = 1;
		elseif(carriage(2) > 16)
			carriage(2) = 16;
		end
	end
end