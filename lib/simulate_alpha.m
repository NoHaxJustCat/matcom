%                                                               
%   Author: Nicolò Basso                                        
%   Email: nicolo.basso@aurorarocketry.eu                       
%   MSA Department, Aurora Rocketry, University of Bologna      
%                                                               
function [x, y] = simulate_alpha(datcom_case, alpha_array, varargin)

    % Ciclo per elaborare i parametri opzionali da varargin
    if nargin > 2
        % `varargin` contiene coppie di nome-valore; lo scansioniamo
        for i = 1:1:length(varargin)
            switch i
                case 1
                    output_type = varargin{i};
                case 2
                    sample_scale = 10;
                    interpolation_type = varargin{i};
                case 3
                    sample_scale = varargin{i};
            end
       end
    end

    N = 12;

    extras = mod(length(alpha_array), N);
    alpha_matrix = resize_array(alpha_array, N);

    y = zeros(size(alpha_matrix));
    for i = 1:size(alpha_matrix, 2)-1
        y(:, i) = eval_alpha(datcom_case, alpha_matrix(:, i)', output_type);
    end   
    
    if extras > 0
        y(1:extras, end) = eval_alpha(datcom_case, alpha_matrix(1:extras, end)', output_type);
    else 
        y(:, end) = eval_alpha(datcom_case, alpha_matrix(:, end)', output_type);
    end

    y = reshape(y, 1, []);
    if extras > 0
        y = y(1:end-N+extras);
    end

    if exist("interpolation_type", "var")
        x = linspace(alpha_array(1), alpha_array(end), length(alpha_array)*sample_scale);
        y = interp1(alpha_array, y, x, interpolation_type);
    else
        x = alpha_array;
    end
end