%                                                               
%   Author: Nicolò Basso                                        
%   Email: nicolo.basso@aurorarocketry.eu                       
%   MSA Department, Aurora Rocketry, University of Bologna      
%                                  
function x_cp = fast_import_x_cp(file_path)
    fid = fopen(file_path, 'r');
    
    % Controlla se il file è stato aperto correttamente
    if fid == -1
        error('Errore nell''apertura del file');
    end
    
    i = 1;

    % Loop per leggere il file linea per linea
    while ~feof(fid)
        % Leggi una riga dal file
        currentLine = fgetl(fid);
        
        % Controlla se la linea contiene 'CP'
        if contains(currentLine, 'D     X-C.P.')

            nextLine = fgetl(fid);  
            nextLine = fgetl(fid);  % Leggi due righe successiva
            coefficients = strsplit(strtrim(nextLine));
            x_cp(i) = str2double(coefficients{5});
            i = i + 1;
        end
    end

    % Chiudi il file
    fclose(fid);
end