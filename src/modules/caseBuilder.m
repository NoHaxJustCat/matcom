%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%   Author: Nicolò Basso                                        %
%   Email: nicolo.basso@aurorarocketry.eu                       %
%   MSA Department, Aurora Rocketry, University of Bologna      %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc, clear all

datcom_case = struct();

% Case name
datcom_case.name = "BOREALIS"; % <---- edit here
datcom_case.date = datestr(now,'dd-mmm-yyyy HH-MM-SS');

% Unit of measurement
datcom_case.unit = "M";  % M meters, CM centimeters, IN inches, FT feet

% REFQ
datcom_case.x_cg = 1.29; % Longitudinal CG distance from nose tip
% datcom_case.z_cg = 0; % Vertical CG distance, default 0
% datcom_case.b_layer = "TURB"; % Boundary layer type, TURB or NATURAL, default TURB
datcom_case.roughness = 0.002; % Roughness height, in centimeters if metric system, default 0
% datcom_case.rhr = 250; % Roughness Height Rating, alternative to roughness, default 0
% datcom_case.scale = 1.2; % Scale factor, default 1

% FLTCON
datcom_case.alphas = [0]; % Angles of attack (at least 1)
% datcom_case.beta = 5; % Sideslip angle, default 0
% datcom_case.phi = 30; % Roll angle, default 0

datcom_case.alt = 300; % Altitudes (as many as mach numbers or other data), default 0
datcom_case.mach = [0.4]; % Mach numbers (at least 1)
% datcom_case.ren = [3.E06]; % Reynolds numbers (as many as mach numbers or other data)
% datcom_case.vinf = []; % Freestream velocities (as many as mach numbers or other data)
% datcom_case.tinf = []; % Freestream static temperatures (as many as mach numbers or other data)
% datcom_case.pinf = []; % Freestream static pressures (as many as mach numbers or other data)

% Any of the following combinations satisfy the minimum requirements for calculating atmospheric
% conditions (Mach and Reynolds number):
% 1. MACH and REN
% 2. MACH and ALT
% 3. MACH and VINF and TINF
% 4. VINF and ALT
% 5. VINF and TINF and PINF

% AXIBOD
% datcom_case.x0 = 0.2; % Starting coordinate of the nose, default 0
datcom_case.nose_type = "OGIVE"; % CONE, OGIVE, POWER, HAACK, KARMAN
% datcom_case.power = 0.7; % If POWER type, define the power coefficient
datcom_case.nose_length = 0.55; % Nose length
datcom_case.nose_diameter = 0.1; % Nose diameter
% datcom_case.nose_bluntness = 0.3; % Bluntness radius
% datcom_case.trunc = 'TRUE'; % If truncated set TRUE, default FALSE
datcom_case.ctrbody_length = 0.140; % Center body (fuselage) length after nose
datcom_case.ctrbody_diameter = 0.1; % Center body diameter, default is nose_diameter
datcom_case.aftbody_type = "CONE"; % Afterbody type, CONE or OGIVE, default CONE
datcom_case.aftbody_length = 0.1; % Afterbody (boattail) length
datcom_case.aftbody_diameter = 0.0698; % Afterbody diameter, different from 0 and ctrbody_diameter
datcom_case.nozzle_diameter = 0.05; % Nozzle diameter for base drag calculation
                                     % If 0, returns maximum base drag

% PROTUB
% datcom_case.n_prot = 2; % Number of protuberance sets
% datcom_case.prot_type = ["VCYL", "LUG"]; % Type of protuberance in each set: VCYL, HCYL, BLOCK, FAIRING, LUG (launch lug), SHOE (launch shoe)
% datcom_case.x_prot = [0.4, 1.0]; % Distance from nose tip for each set
% datcom_case.prot_in_set = [2, 1]; % Number of protuberances in each set
% datcom_case.l_prot = [0.01, 0.06, 0.004, 0.004, 0.006]; % Length of each protuberance
% datcom_case.w_prot = [0.01, 0.06, 0.004, 0.004, 0.006]; % Width of each protuberance
% datcom_case.h_prot = [0.01, 0.04, 0.002, 0.002, 0.002]; % Height of each protuberance
% datcom_case.o_prot = [0, 0, 0.03, 0.05, 0.06]; % Offset of each protuberance

% LUG type has 4 members. SHOE type has three members. LPROT, WPROT, HPROT, and
% OPROT must be specified for each member.

% FINSET1
% datcom_case.section_type = "HEX"; % Section type: HEX, ARC, NACA, USER
datcom_case.semi_span = [0.0, 0.11]; % Semi-span distance, 0.0 if fins are directly on fuselage
datcom_case.chord = [0.24, 0.12]; % Chord of single panel at each defined semi-span
datcom_case.x_le = [1.71, 1.77]; % Distance from nose tip for each semi-span
% datcom_case.ler = [0, 0]; % Leading edge radius at each semi-span, default 0
datcom_case.n_fins = 3; % Number of fins, default 4
datcom_case.z_upper = [0.00625, 0.0125]; % Thickness-to-chord ratio of upper surface (HEX or ARC section)
% datcom_case.z_lower = []; % Thickness-to-chord ratio of lower surface (HEX or ARC section), default zupper
datcom_case.l_max_upper = [0.25, 0.25]; % Fraction of chord from leading edge to max thickness, upper surface
% datcom_case.l_max_lower = []; % Fraction of chord from leading edge to max thickness, lower surface, default lmaxupper
datcom_case.l_flat_upper = [0.5, 0.5]; % Fraction of chord with constant thickness, upper surface
% datcom_case.l_flat_lower = []; % Fraction of chord with constant thickness, lower surface, default lflatupper
datcom_case.phi_fins = [0, 120, 240]; % Angles to position each fin, viewed from behind, from vertical semi-axis clockwise
% If phi_fins is not defined, fins are equally spaced around the body

% PRINT BODY
datcom_case.print_geom_body = true;
datcom_case.print_aero_body = true;

% NB: l_max * 2 + l_flat = 1

% Save the case
save("cases\" + datcom_case.name + ".mat", 'datcom_case');