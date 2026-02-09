%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%   Author: Nicolò Basso                                        %
%   Email: nicolo.basso@aurorarocketry.eu                       %
%   MSA Department, Aurora Rocketry, University of Bologna      %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc, clear all

datcom_case = struct();

% Nome del case
datcom_case.name = "TEST"; % <---- edit here
datcom_case.date = datestr(now,'dd-mmm-yyyy HH-MM-SS');

% Unità di misura
datcom_case.unit = "IN";  % M metri, CM centiemtri, IN inches, ft feet

% REFQ
% datcom_case.sref = 0.0176;
% datcom_case.lref = 0.15;
% datcom_case.latref = 0.15;
datcom_case.x_cg = 24; % distanza CG longitudinale dalla sommità del nosecone
% datcom_case.z_cg = 0;% distanza CG verticale, default 0
% datcom_case.b_layer = "NATURAL"; % tipo di strato limite, TURB o NATURAL, default TURB
% datcom_case.roughness = 0.002; % Altezza della rugosità, in centimetri se sistema metrico, default 0
% datcom_case.rhr = 250; % Roughness Height Rating, alternativo alla roughness, default 0
% datcom_case.scale = 1.2; % Fattore di scala, default 1

% FLTCON
datcom_case.alphas = [0]; % angoli di attacco (almeno 1)
% datcom_case.beta = 5; % Angolo di deriva, default 0
% datcom_case.phi = 30; % Angolo di rollio, default 0

datcom_case.alt = 0; % altitudini (tante quanti sono i mach o gli altri dati), default 0
datcom_case.mach = [0.7]; % numeri di mach (almeno 1)
% datcom_case.ren = [19053590]; % Reynolds (tanti quanti sono i mach o gli altri dati)
% datcom_case.vinf = []; % Freestream velocities (tanti quanti sono i mach o gli altri dati)
% datcom_case.tinf = []; % Freestream static temperatures (tanti quanti sono i mach o gli altri dati)
% datcom_case.pinf = []; % Freestream static pressures (tanti quanti sono i mach o gli altri dati)

% Any of the following combinations satisfy the minimum requirements for calculating atmospheric
% conditions (Mach and Reynolds number):
% 1. MACH and REN
% 2. MACH and ALT
% 3. MACH and VINF and TINF
% 4. VINF and ALT
% 5. VINF and TINF and PINF

% AXIBOD
% datcom_case.x0 = 0.2; % coordinate dell'inizio del nose, default 0
datcom_case.nose_type = "OGIVE"; % CONE, OGIVE, POWER, HAACK, KARMAN
% datcom_case.power = 0.5; % se power definire il coefficiente
datcom_case.nose_length = 12; % lunghezza nose
datcom_case.nose_diameter = 4; % diametro
% datcom_case.nose_bluntness = 0.3 % raggio di troncamento
% datcom_case.trunc = 'TRUE'; % se troncato mettere TRUE, default FALSE
datcom_case.ctrbody_length = 34; % lunghezza del corpo centrale (fusoliera) dopo il nose
datcom_case.ctrbody_diameter = 4; % diametro del corpo centrale, default nose_diameter
% datcom_case.aftbody_type = "CONE"; % tipo di afterbody, CONE o OGIVE, default CONE
% datcom_case.aftbody_length = 0.1; % lughezza dell'afterbody (boattail)
% datcom_case.aftbody_diameter = 0.1; % diametro dell'afterbody, diverso da 0 e ctrbody_diameter
% datcom_case.nozzle_diameter = 0.098; % diametro ugello per calcolo del drag della base, default restituisce 0 base drag 
                          % se 0 restituisce il base drag massimo.
% BETAN, JMACH, PRAT, TRAT non inseriti ma possono essere aggiunti (non
% credo abbiamo modo di conoscerli, mentre BETAN non si modifica)

% PROTUB
% datcom_case.n_prot = 2; % numero di set di protuberanze
% datcom_case.prot_type = ["VCYL", "LUG"]; % tipo di protuberanza in ciascun set, VCYL, HCYL, BLOCK, FAIRING, LUG (lunch lug), SHOE (lunch shoe)
% datcom_case.x_prot = [0.4, 1.0]; % distanza dalla punta del nose per ciascun set
% datcom_case.prot_in_set = [2, 1]; % numero di protuberanze in ciascun set;
% datcom_case.l_prot = [0.01, 0.06, 0.004, 0.004, 0.006]; % lunghezza di ciascun protuberanza
% datcom_case.w_prot = [0.01, 0.06, 0.004, 0.004, 0.006]; % larghezza di ciascun protuberanza
% datcom_case.h_prot = [0.01, 0.04, 0.002, 0.002, 0.002]; % altezza di ciascun protuberanza
% datcom_case.o_prot = [0, 0, 0.03, 0.05, 0.06]; % offset di ciascuna protuberanza

% LUG type has 4 members. SHOE type has three members. LPROT, WPROT, HPROT, and
% OPROT must be specified for each member.

% FINSET1
datcom_case.section_type = "HEX"; % tipo di sezione, HEX, ARC, NACA, USER
datcom_case.semi_span = [0, 3]; % distanza semi-span, 0.0 se le alette sono direttamente sulla fusoliera
datcom_case.chord = [4, 2]; % corda del singolo pannello ad ogni semi-span definito
datcom_case.x_le = [42, 44]; % distanza dalla punta del nose per ogni singolo semi-span definito
% datcom_case.sweep = 0;
% datcom_case.sta = 1;
% datcom_case.ler = [0, 0]; % raggio di curvatura del LE a ciascun semi-span definito, default 0
datcom_case.n_fins = 3; % numero di fins, default 4
datcom_case.z_upper = [0.025, 0.05]; % rapporto spessore su corda della parte superiore della sezione HEX o ARC
% datcom_case.z_lower = []; % rapporto spessore su corda della parte inferiore della sezione HEX o ARC, default zupper
datcom_case.l_max_upper = [0.25, 0.5]; % Frazione della corda dalla sezione del bordo d'attacco allo spessore massimo della superficie superiore. 
% datcom_case.l_max_lower = []; % Frazione della corda dalla sezione del bordo d'attacco allo spessore massimo della superficie inferiore, default lmaxupper
datcom_case.l_flat_upper = [0.5, 0]; % La frazione della corda di spessore costante, sezione superiore
% datcom_case.l_flat_lower = []; % La frazione della corda di spessore costante, sezione inferiore, default lflatupper
% datcom_case.phi_fins = [0, 120, 240]; % angoli in cui posizionare ciascuna fins, guardando il razzo da dietro, dal semiasse verticale in senso orario
% Se phi fins non è definito, le alette sono equispaziate sul corpo

% PRINT BODY
datcom_case.print_geom_body = true;
datcom_case.print_aero_body = true;

% NB: l_max * 2 + l_flat = 1

% delete("cases\" + datcom_case.name + ".mat");
save("cases\" + datcom_case.name + ".mat", 'datcom_case');

% formatted_case = formattedDisplayText(datcom_case);
% writelines(formatted_case, "Cases/" + datcom_case.name + ".xml");

% writetable(struct2table(datcom_case), "Cases/" + datcom_case.name + ".xml");