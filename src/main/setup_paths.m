function setup_paths()
    % setup_paths() - Configure MATLAB path for MatCom project
    % Adds all necessary folders to the MATLAB path for the project structure
    
    % Get the project root directory
    project_root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
    
    % Add source directories
    addpath(fullfile(project_root, 'src', 'main'));
    addpath(fullfile(project_root, 'src', 'modules'));
    addpath(fullfile(project_root, 'src', 'visualization'));
    
    % Add library directory
    addpath(fullfile(project_root, 'lib'));
    
    % Add data directories
    addpath(fullfile(project_root, 'data', 'cases'));
    addpath(fullfile(project_root, 'data', 'datcom'));
    
    % Add output directories
    addpath(fullfile(project_root, 'output', 'results'));
    addpath(fullfile(project_root, 'output', 'temp'));
    
    % Print confirmation
    fprintf('MatCom project paths configured successfully.\n');
    fprintf('Project root: %s\n', project_root);
end
