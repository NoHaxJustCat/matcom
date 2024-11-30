%                                                               
%   Author: Nicolò Basso                                        
%   Email: nicolo.basso@aurorarocketry.eu                       
%   MSA Department, Aurora Rocketry, University of Bologna      
%                     
function [x, y, Z] = simulate_double(datcom_case, mach_array, param, param_type, varargin)
    %SIMULATE_DOUBLE Summary of this function goes here
    %   Detailed explanation goes here

    output_type = 'cd';

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

    output = zeros(length(mach_array), length(param));
    
    for j = 1:length(param)
        datcom_case.(param_type) = param(:, j);
        [~, output(:, j)] = simulate(datcom_case, mach_array, "cd");
    end

    if exist("interpolation_type", "var")
        x = linspace(mach_array(1), mach_array(end), length(mach_array)*sample_scale);
        y = linspace(param(end, 1), param(end, end), length(param)*sample_scale);
        [X, Y] = meshgrid(x, y(end, :));
        Z = interp2(mach_array, param(end, :), output', X, Y, interpolation_type);
    else
        x = mach_array;
        y = param;
        Z = output;
    end

end