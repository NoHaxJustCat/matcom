%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%   Author: Nicolò Basso                                        %
%   Email: nicolo.basso@aurorarocketry.eu                       %
%   MSA Department, Aurora Rocketry, University of Bologna      %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = addDecimal(num)
    % Converti il numero in stringa
    numStr = num2str(num);
    
    % Controlla se è presente un punto decimale
    if ~contains(numStr, '.')
        % Se non è presente, aggiungi un punto alla fine
        output = strcat(numStr, '.');
    else
        % Se è già presente, restituisci la stringa originale
        output = numStr;
    end
end