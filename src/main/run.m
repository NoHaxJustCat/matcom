%% MatCom - MATLAB Missile Datcom Interface
% Main execution script for running MatCom simulations

clear all; close all; clc;

% Setup paths for the project structure
setup_paths();

%% Load and configure case
my_case = initialize("BOREALIS");

mach_array = linspace(0.1, 1.2, 24);

my_case.semi_span(1) = 0.07; % m

[x, y] = simulate(my_case, mach_array, "x_cp", "linear");

figure;
plot(x, y);
xlabel('Mach Number');