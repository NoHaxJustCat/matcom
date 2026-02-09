%                                                               
%   Author: Nicolò Basso                                        
%   Email: nicolo.basso@aurorarocketry.eu                       
%   MSA Department, Aurora Rocketry, University of Bologna      
%                                  
function array = resize_array(array, N)
    n_close = ceil(length(array)/N);
    array(end+1:n_close*N) = 0;
    array = reshape(array, N, []);
end