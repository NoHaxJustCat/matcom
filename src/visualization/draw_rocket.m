fid = fopen("DATCOM\for006.dat", 'r');

% Controlla se il file è stato aperto correttamente
if fid == -1
    error('Errore nell''apertura del file');
end

i = 1;

% Loop per leggere il file linea per linea
while ~feof(fid)
    % Leggi una riga dal file
    currentLine = fgetl(fid);
    
    % Controlla se la linea contiene 'CD'
    if contains(currentLine, ' LONGITUDINAL STATIONS ')

        long = split(convertCharsToStrings(currentLine), " ");
        long(cellfun('isempty',long)) = []; 
        long(1:2) = [];
        
        currentLine = fgetl(fid);

        while currentLine ~= ""
            new_row = split(convertCharsToStrings(currentLine), " ");
            new_row(cellfun('isempty',new_row)) = []; 
            long = cat(1, long, new_row);
            currentLine = fgetl(fid);
        end

        long_stations = str2double(erase(long, "*"));
    end

    if contains(currentLine, ' BODY RADII ')

    radii = split(convertCharsToStrings(currentLine), " ");
    radii(cellfun('isempty',radii)) = []; 
    radii(1:2) = [];
    
    currentLine = fgetl(fid);

    while currentLine ~= "    NOTE - * INDICATES SLOPE DISCONTINUOUS POINTS"
        new_row = split(convertCharsToStrings(currentLine), " ");
        new_row(cellfun('isempty',new_row)) = []; 
        radii = cat(1, radii, new_row);
        currentLine = fgetl(fid);
    end

    body_radii = str2double(erase(radii, "*"));
end
end

x = long_stations';
r = body_radii';

% Creazione della griglia angolare
theta = linspace(0, 2*pi, 100); % 100 punti per un giro completo

% Creazione delle coordinate cilindriche
[Theta, X] = meshgrid(theta, x);
R = repmat(r', 1, length(theta)); % Ripete il raggio per ogni angolo

% Conversione in coordinate cartesiane
Y = R .* cos(Theta);
Z = R .* sin(Theta);

% Disegna la superficie con colori soft
figure;
surf(X, Y, Z, 'EdgeColor', 'none', 'FaceAlpha', 0.7); % Trasparenza leggera
colormap(parula); % Colormap meno intensa
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Corpo Assialsimmetrico con Colori Soft');
axis equal; % Mantiene le proporzioni corrette
grid on;
view(3); % Vista 3D