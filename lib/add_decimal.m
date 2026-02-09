%                                                               
%   Author: Nicolò Basso                                        
%   Email: nicolo.basso@aurorarocketry.eu                       
%   MSA Department, Aurora Rocketry, University of Bologna      
%                                  
function output = add_decimal(num)
    % Convert number to string
    numStr = num2str(num);
    
    % Check if decimal point is present
    if ~contains(numStr, '.')
        % If not present, add decimal point at the end
        output = strcat(numStr, '.');
    else
        % If already present, return the original string
        output = numStr;
    end
end