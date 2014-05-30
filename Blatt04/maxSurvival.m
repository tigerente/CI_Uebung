% Simulation zu Aufgabe 4.3: Selbstorganisation zur Nahrungssuche
% behavior: function handle mit dem Verhalten der einzelnen Partikel
% rounds(=300): Anzahl der Simulationsschritte
% show(=ture): Flag für Visualisierung
function nrSurvive = maxSurvival(behavior,rounds,show)
if nargin < 2
	rounds = 300;
end
if nargin < 3
	show = true;
end
act = behavior;
fieldSize = 40;
maxFoodPerParticle = 100;
foodGainPerParticle = 4;
maxFoodPerSource = 100;
foodGain = 8;
nrParticles = 40;
nrSources = 5;
nrRounds = rounds;

field = struct;
field.food = zeros(fieldSize);
field.part = zeros(fieldSize);
field.pher = zeros(fieldSize);
moveX = zeros(3);
moveY = zeros(3);
moveY(1,:) = -1;
moveY(3,:) = 1;
moveX(:,1) = -1;
moveX(:,3) = 1;

%Zufällige Futterquellen erstellen
source = randi(fieldSize,nrSources,2);
%Unterschiedliche Positionen der Futterquellen sicherstellen
while (numel(source) ~= numel(unique(source,'rows')))
	source = randi(fieldSize,nrSources,2);
end
for i=1:nrSources
	field.food(source(i,1),source(i,2)) = maxFoodPerSource;
end
%Zufällige Startposition der Partikel
particles = struct();
particles.pos = randi(fieldSize-2, 2, nrParticles)+1;
%Alle starten mit vollen Mägen
particles.food = maxFoodPerParticle+zeros(1,nrParticles);

notFinished = true;
nrIter = 0;

while notFinished
	nrIter = nrIter+1;
	%Alle Futterquellen bekommen neue Nahrung dazu
	for i=1:nrSources
		field.food(source(i,1),source(i,2)) = min(maxFoodPerSource, field.food(source(i,1),source(i,2))+foodGain);
	end
	%Alle Partikel verbrauchen Nahrung
	particles.food = max(0, particles.food-1);
	%Zerfall des Pheromons (nach 40 Schritten ist noch die Hälfte übrig)
	newPher = field.pher*0.982820598545251;
	%Partikelzahl zurücksetzen
	newPart = zeros(fieldSize);
	%Jedes Partikel kann nun agieren
	for i=1:nrParticles
		%aber nur wenn das Partikel noch lebt
		if(particles.food(i) > 0)
			partPos = particles.pos(:,i);
			posX = partPos(1);
			posY = partPos(2);
			[move, pher, eat] = act(particles.food(i), getEnvironment(field,partPos));
			%Essen
			if(eat)
				%Wie viel kann maximal gegessen werden?
				gain = min(field.food(posX,posY), foodGainPerParticle);
				%das dem Feld abziehen...
				field.food(posX,posY) = field.food(posX,posY)-gain;
				%... und dem Partikel geben
				particles.food(i) = particles.food(i) + gain;
			end
			%Pheromon auf [0, 5] beschränken und verstreuen
			pher = max(0,min(5, pher));
			newPher(posX,posY) = newPher(posX,posY) + pher;
			%Bewegen (move = 0 entspricht stehen bleiben)
			posX = posX + moveX(move);
			posY = posY + moveY(move);
			if posX>fieldSize
				posX = 1;
			end
			if posX<1
				posX = fieldSize;
			end
			if posY>fieldSize
				posY = 1;
			end
			if posY<1
				posY = fieldSize;
			end
			newPart(posX,posY) = newPart(posX,posY) + 1;
			particles.pos(1,i) = posX;
			particles.pos(2,i) = posY;
		end
	end
	field.pher = newPher;
	field.part = newPart;
	if show
		%Visualisierung
		subplot(1,3,1)
		pcolor(field.food)
		title('Nahrungsvorräte')
		subplot(1,3,2)
		pcolor(field.part)
		title('Partikel')
		subplot(1,3,3)
		pcolor(field.pher)
		title('Pheromone')
		drawnow
	end
	%Abbruch wenn alle tot sind oder die Spielzeit um ist
	if(all(particles.food == 0) || nrIter >= nrRounds)
		notFinished = false;
	end
end
if show
	disp(['Es haben nach ' num2str(nrIter) ' Iterationen ' num2str(sum(particles.food > 0)) ' Partikel überlebt!']);
end
if nargout == 1
	nrSurvive = num2str(sum(particles.food > 0));
end

	function env = getEnvironment(field,pos)
		env = struct();
		fSize = length(field.food);
		indexMask = [-1 0 1];
		indexSetX = pos(1)+indexMask;
		indexSetY = pos(2)+indexMask;
		for k=1:numel(indexSetX)
			if indexSetX(k)<1
				indexSetX(k) = fSize;
			elseif indexSetX(k)>fSize
				indexSetX(k) = 1;
			end
			if indexSetY(k)<1
				indexSetY(k) = fSize;
			elseif indexSetY(k)>fSize
				indexSetY(k) = 1;
			end
		end
		env.food = field.food(indexSetX,indexSetY)';
		env.part = field.part(indexSetX,indexSetY)';
		env.pher = field.pher(indexSetX,indexSetY)';
	end
end