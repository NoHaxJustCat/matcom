%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%   Author: Nicolò Basso                                        %
%   Email: nicolo.basso@aurorarocketry.eu                       %
%   MSA Department, Aurora Rocketry, University of Bologna      %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function writeOnDat(case_settings)
%WRITEONDAT Write the case on for006.dat

fileID = fopen("DATCOM\for005.dat", 'w');

fprintf(fileID, 'CASEID %s\n', case_settings.name);
fprintf(fileID, 'DIM %s\n', case_settings.unit);

%REFQ

fprintf(fileID, ' $REFQ XCG=%s,', addDecimal(case_settings.x_cg));
if isfield(case_settings,'z_cg')
    fprintf(fileID, 'ZCG=%s,', addDecimal(case_settings.z_cg));
end
if isfield(case_settings,'b_layer')
    fprintf(fileID, 'BLAYER=%s,\n ', case_settings.b_layer);
end
if isfield(case_settings,'roughness')
    fprintf(fileID, 'ROUGH=%s,', addDecimal(case_settings.roughness));
end
if isfield(case_settings,'rhr')
    fprintf(fileID, 'RHR=%s,', addDecimal(case_settings.rhr));
end
if isfield(case_settings,'scale')
    fprintf(fileID, 'SCALE=%s,', addDecimal(case_settings.scale));
end
fprintf(fileID, '$\n');

%FLTCON

fprintf(fileID, ' $FLTCON ');
if length(case_settings.alphas) ~= 1
    fprintf(fileID, 'NALPHA=%s,', addDecimal(length(case_settings.alphas)));
end
fprintf(fileID, 'ALPHA=');
for i=1:length(case_settings.alphas)
    fprintf(fileID, '%s,', addDecimal(case_settings.alphas(i)));
end
fprintf(fileID, '\n ');
if isfield(case_settings,'beta')
    fprintf(fileID, 'BETA=%s,', addDecimal(case_settings.beta));
end
if isfield(case_settings,'phi')
    fprintf(fileID, 'PHI=%s,', addDecimal(case_settings.phi));
end
if isfield(case_settings,'mach')
    fprintf(fileID, 'NMACH=%s,', addDecimal(length(case_settings.mach)));
    fprintf(fileID, 'MACH=');
    for i=1:length(case_settings.mach)
        fprintf(fileID, '%s,', addDecimal(case_settings.mach(i)));
    end
end
if isfield(case_settings,'ren')
    fprintf(fileID, 'REN=');
    for i=1:length(case_settings.ren)
        fprintf(fileID, '%s,', addDecimal(case_settings.ren(i)));
    end
end
if isfield(case_settings,'alt')
    fprintf(fileID, 'ALT=');
    for i=1:length(case_settings.alt)
        fprintf(fileID, '%s,', addDecimal(case_settings.alt(i)));
    end
end
if isfield(case_settings,'vinf')
    fprintf(fileID, 'VINF=');
    for i=1:length(case_settings.vinf)
        fprintf(fileID, '%s,', addDecimal(case_settings.vinf(i)));
    end
end
if isfield(case_settings,'tinf')
    fprintf(fileID, 'TINF=');
    for i=1:length(case_settings.tinf)
        fprintf(fileID, '%s,', addDecimal(case_settings.tinf(i)));
    end
end
if isfield(case_settings,'pinf')
    fprintf(fileID, 'PINF=');
    for i=1:length(case_settings.pinf)
        fprintf(fileID, '%s,', addDecimal(case_settings.pinf(i)));
    end
end
fprintf(fileID, '$\n');

% AXIBOD

fprintf(fileID, ' $AXIBOD ');
if isfield(case_settings,'x0')
    fprintf(fileID, 'X0=%s,', addDecimal(case_settings.x0));
end
if isfield(case_settings,'nose_type')
    fprintf(fileID, 'TNOSE=%s,\n ', case_settings.nose_type);
end
if isfield(case_settings,'power')
    fprintf(fileID, 'POWER=%s,', addDecimal(case_settings.power));
end
if isfield(case_settings,'nose_length')
    fprintf(fileID, 'LNOSE=%s,', addDecimal(case_settings.nose_length));
end
if isfield(case_settings,'nose_diameter')
    fprintf(fileID, 'DNOSE=%s,', addDecimal(case_settings.nose_diameter));
end
if isfield(case_settings,'nose_bluntness')
    fprintf(fileID, 'BNOSE=%s,', addDecimal(case_settings.nose_bluntness));
end
if isfield(case_settings,'trunc')
    fprintf(fileID, 'TRUNC=%s,', case_settings.trunc);
end
if isfield(case_settings,'ctrbody_length')
    fprintf(fileID, 'LCENTR=%s,\n ', addDecimal(case_settings.ctrbody_length));
end
if isfield(case_settings,'ctrbody_diameter')
    fprintf(fileID, 'DCENTR=%s,\n ', addDecimal(case_settings.ctrbody_diameter));
end
if isfield(case_settings,'aftbody_type')
    fprintf(fileID, 'TAFT=%s,', case_settings.aftbody_type);
end
if isfield(case_settings,'aftbody_length')
    fprintf(fileID, 'LAFT=%s,', addDecimal(case_settings.aftbody_length));
end
if isfield(case_settings,'aftbody_diameter')
    fprintf(fileID, 'DAFT=%s,', addDecimal(case_settings.aftbody_diameter));
end
if isfield(case_settings,'nozzle_diameter')
    fprintf(fileID, 'DEXIT=%s,', addDecimal(case_settings.nozzle_diameter));
end
fprintf(fileID, '$\n');

% PROTUB

fprintf(fileID, ' $PROTUB ');
if isfield(case_settings,'n_prot')
    fprintf(fileID, 'NPROT=%s,\n ', addDecimal(case_settings.n_prot));
end
if isfield(case_settings,'prot_type')
    fprintf(fileID, 'PTYPE=');
    for i = 1:case_settings.n_prot
        fprintf(fileID, '%s,', case_settings.prot_type(i));
    end
    fprintf(fileID, '\n ');
end   
if isfield(case_settings,'x_prot')
    fprintf(fileID, 'XPROT=');
    for i = 1:case_settings.n_prot
        fprintf(fileID, '%s,', addDecimal(case_settings.x_prot(i)));
    end
        fprintf(fileID, '\n ');
end
if isfield(case_settings,'prot_in_set')
    fprintf(fileID, 'NLOC=');
    for i = 1:length(case_settings.n_prot)
        fprintf(fileID, '%s,', addDecimal(case_settings.prot_in_set(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'l_prot')
    fprintf(fileID, 'LPROT=');
    for i = 1:length(case_settings.l_prot)
        fprintf(fileID, '%s,', addDecimal(case_settings.l_prot(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'w_prot')
    fprintf(fileID, 'WPROT=');
    for i = 1:length(case_settings.w_prot)
        fprintf(fileID, '%s,', addDecimal(case_settings.w_prot(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'h_prot')
    fprintf(fileID, 'HPROT=');
    for i = 1:length(case_settings.h_prot)
        fprintf(fileID, '%s,', addDecimal(case_settings.h_prot(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'o_prot')
    fprintf(fileID, 'OPROT=');
    for i = 1:length(case_settings.o_prot)
        fprintf(fileID, '%s,', addDecimal(case_settings.o_prot(i)));
    end
end
fprintf(fileID, '$\n');

% FINSET1

fprintf(fileID, ' $FINSET1 ');
if isfield(case_settings,'section_type')
    fprintf(fileID, 'SECTYP=%s,\n ', case_settings.section_type);
end
if isfield(case_settings,'semi_span')
    fprintf(fileID, 'SSPAN=');
    for i = 1:length(case_settings.semi_span)
        fprintf(fileID, '%s,', addDecimal(case_settings.semi_span(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'chord')
    fprintf(fileID, 'CHORD=');
    for i = 1:length(case_settings.semi_span)
        fprintf(fileID, '%s,', addDecimal(case_settings.chord(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'x_le')
    fprintf(fileID, 'XLE=');
    for i = 1:length(case_settings.x_le)
        fprintf(fileID, '%s,', addDecimal(case_settings.x_le(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'ler')
    fprintf(fileID, 'LER=');
    for i = 1:length(case_settings.ler)
        fprintf(fileID, '%s,', addDecimal(case_settings.ler(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'n_fins')
    fprintf(fileID, 'NPANEL=%s,', addDecimal(case_settings.n_fins));
end
if isfield(case_settings,'z_upper')
    fprintf(fileID, 'ZUPPER=');
    for i = 1:length(case_settings.z_upper)
        fprintf(fileID, '%s,', addDecimal(case_settings.z_upper(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'z_lower')
    fprintf(fileID, 'ZLOWER=');
    for i = 1:length(case_settings.z_lower)
        fprintf(fileID, '%s,', addDecimal(case_settings.z_lower(i)));
    end
end
if isfield(case_settings,'l_max_upper')
    fprintf(fileID, 'LMAXU=');
    for i = 1:length(case_settings.l_max_upper)
        fprintf(fileID, '%s,', addDecimal(case_settings.l_max_upper(i)));
    end
    fprintf(fileID, '\n ');
end
if isfield(case_settings,'l_max_lower')
    fprintf(fileID, 'LMAXL=');
    for i = 1:length(case_settings.l_max_lower)
        fprintf(fileID, '%s,', addDecimal(case_settings.l_max_lower(i)));
    end
end   
if isfield(case_settings,'l_flat_upper')
    fprintf(fileID, 'LFLATU=');
    for i = 1:length(case_settings.l_flat_upper)
        fprintf(fileID, '%s,', addDecimal(case_settings.l_flat_upper(i)));
    end
end
if isfield(case_settings,'l_flat_lower')
    fprintf(fileID, 'LMAXL=');
    for i = 1:length(case_settings.l_flat_lower)
        fprintf(fileID, '%s,', addDecimal(case_settings.l_flat_lower(i)));
    end
end   
if isfield(case_settings,'phi_fins')
    fprintf(fileID, 'PHIF=');
    for i = 1:length(case_settings.phi_fins)
        fprintf(fileID, '%s,', addDecimal(case_settings.phi_fins(i)));
    end
end
fprintf(fileID, '$\n');

% PRINT BODY

if case_settings.print_geom_body
    fprintf(fileID, 'PRINT GEOM BODY\n');
end
if case_settings.print_aero_body
    fprintf(fileID, 'PRINT AERO BODY\n');
end

% SAVE

fprintf(fileID, 'SAVE\nNEXT CASE');

fclose(fileID);

end

