%                                                               
%   Author: Nicolò Basso                                        
%   Email: nicolo.basso@aurorarocketry.eu                       
%   MSA Department, Aurora Rocketry, University of Bologna      
%                                  
function x_cp = fast_import_x_cp(file_path)
    fid = fopen(file_path, 'r');
    
    % Check if file was opened successfully
    if fid == -1
        error('Error opening file');
    end
    
    i = 1;

    % Loop to read the file line by line
    while ~feof(fid)
        % Read a line from the file
        currentLine = fgetl(fid);
        
        % Check if the line contains center of pressure data
        if contains(currentLine, 'D     X-C.P.')

            nextLine = fgetl(fid);  
            nextLine = fgetl(fid);  % Read two lines ahead
            coefficients = strsplit(strtrim(nextLine));
            x_cp(i) = str2double(coefficients{5});
            i = i + 1;
        end
    end

    % Close the file
    fclose(fid);
end