%                                                               
%   Author: Nicolò Basso                                        
%   Email: nicolo.basso@aurorarocketry.eu                       
%   MSA Department, Aurora Rocketry, University of Bologna      
%                                  
function output = eval_mach(datcom_case, mach, output_type)

    datcom_case.mach = round(mach, 2);

    path = round(mach(1) * 1000);
    
    system(['mkdir temp\' int2str(path) '\']);
    system(['copy "DATCOM\for005.dat" "temp\"' int2str(path) '\'], '-echo');
    write_on_dat(datcom_case, ['temp\' int2str(path) '\for005.dat']);
    system(['cd temp\' int2str(path) ' &&  datcom.exe']);

    switch output_type
        case "cd"
        output = fast_import_cd(['temp\' int2str(path) '\for006.dat']);
        case "x_cp"
        output = fast_import_x_cp(['temp\' int2str(path) '\for006.dat']);
    end
    system(['rmdir /S /Q "temp\' int2str(path) '"']);
end