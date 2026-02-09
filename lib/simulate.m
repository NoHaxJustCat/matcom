%                                                               
%   Author: Nicolò Basso                                        
%   Email: nicolo.basso@aurorarocketry.eu                       
%   MSA Department, Aurora Rocketry, University of Bologna      
%                                                               
function [x, y] = simulate(datcom_case, mach_array, varargin)

    % Process optional parameters from varargin
    if nargin > 2
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

    extras = mod(length(mach_array), N);
    mach_matrix = resize_array(mach_array, N);

    y = zeros(size(mach_matrix));
   
    parfor i = 1:size(mach_matrix, 2)-1
        y(:, i) = eval_mach(datcom_case, mach_matrix(:, i)', output_type);
    end   
    
    if extras > 0
        y(1:extras, end) = eval_mach(datcom_case, mach_matrix(1:extras, end)', output_type);
    else 
        y(:, end) = eval_mach(datcom_case, mach_matrix(:, end)', output_type);
    end

    y = reshape(y, 1, []);
    if extras > 0
        y = y(1:end-N+extras);
    end

    if exist("interpolation_type", "var")
        x = linspace(mach_array(1), mach_array(end), length(mach_array)*sample_scale);
        y = interp1(mach_array, y, x, interpolation_type);
    else
        x = mach_array;
    end
end