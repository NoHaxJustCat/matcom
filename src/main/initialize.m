function loaded_case = initialize(case_name)
    % INITIALIZE Load a DATCOM case from file and prepare for simulation
    %   loaded_case = initialize(case_name) loads a rocket case configuration
    %   and runs initial DATCOM analysis
    
    addpath("libs");
    system('rmdir /S /Q temp\.');
    
    loaded_case = load("cases\" + case_name + ".mat").datcom_case;
    
    write_on_dat(loaded_case, 'DATCOM\for005.dat');
    system('cd DATCOM\ && datcom');
end