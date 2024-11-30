function loaded_case = initialize(case_name)        
    system('rmdir /S /Q  temp\.', '-echo');
    
    loaded_case = load("cases\" + case_name +  ".mat").datcom_case;
    
    write_on_dat(loaded_case, 'DATCOM\for005.dat');
    system('cd DATCOM\ && datcom');
end