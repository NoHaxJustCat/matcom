%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%   Author: Nicolò Basso                                        %
%   Email: nicolo.basso@aurorarocketry.eu                       %
%   MSA Department, Aurora Rocketry, University of Bologna      %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cd = fastimportCD(file_path)
    fid = fopen(file_path, 'r');
    
    % Controlla se il file è stato aperto correttamente
    if fid == -1
        error('Errore nell''apertura del file');
    end
    
    % Inizializza una variabile per controllare se abbiamo trovato il valore
    found = false;
    
    % Loop per leggere il file linea per linea
    while ~feof(fid)
        % Leggi una riga dal file
        currentLine = fgetl(fid);
        
        % Controlla se la linea contiene 'CD'
        if contains(currentLine, ' CD ')

            nextLine = fgetl(fid);  
            nextLine = fgetl(fid);  % Leggi due righe successiva
            coefficients = strsplit(strtrim(nextLine));
            cd = str2double(coefficients{3});
        end
    end

    % Chiudi il file
    fclose(fid);
end