%% MatCom - MATLAB Missile DATCOM Interface
% Main execution script for running MatCom simulations

clear all; close all; clc;

% Setup paths for the project structure
setup_paths();

%% Load and configure case
my_case = initialize("BOREALIS");

% Define Mach number range
mach_array = linspace(0.1, 1.2, 24);

% Run simulation
[x, y] = simulate(my_case, mach_array, "x_cp", "linear");

% Plot results
figure;
plot(x, y);
xlabel('Mach Number');
ylabel('Center of Pressure [m]');
title('Center of Pressure vs Mach Number');
grid on;