%                                                               
%   Author: Nicolò Basso                                        
%   Email: nicolo.basso@aurorarocketry.eu                       
%   MSA Department, Aurora Rocketry, University of Bologna      
%                                  
function cd = fast_import_cd(file_path)
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
        
        % Check if the line contains 'CD'
        if contains(currentLine, ' CD ')

            nextLine = fgetl(fid);  
            nextLine = fgetl(fid);  % Read two lines ahead
            coefficients = strsplit(strtrim(nextLine));
            cd(i) = str2double(coefficients{3});
            i = i + 1;
        end
    end

    % Close the file
    fclose(fid);
end