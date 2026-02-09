%% MatCom Double Variable Simulation Demo
% This script demonstrates the double variable simulation capability
% by varying both Mach number and fin semi-span

clear all; close all; clc;

% Add library paths
addpath('lib');
addpath('src\main');
addpath('src\modules');
addpath('src\utils');
addpath('data\cases');

% Load the BOREALIS rocket case
fprintf('Loading BOREALIS case...\n');
loaded_case = load('data\cases\BOREALIS.mat');
my_case = loaded_case.datcom_case;

% Define Mach number range
mach_array = linspace(0.3, 1.2, 10);

% Define fin semi-span variations (meters)
% Original value is [0.0, 0.11], we'll vary the tip semi-span
% Each column represents the full semi_span array [root, tip]
param_matrix = [
    0.0,  0.0,  0.0,  0.0;   % root semi-span (always 0 - attached to body)
    0.08, 0.10, 0.12, 0.14    % tip semi-span values to test
];

fprintf('Running double variable simulation...\n');
fprintf('Mach range: %.2f to %.2f (%d points)\n', mach_array(1), mach_array(end), length(mach_array));
fprintf('Fin tip semi-span values: %s\n', mat2str(param_matrix(2,:)));

% Run the double variable simulation
% Varying Mach and fin semi-span, measuring center of pressure (x_cp)
[x, y, Z] = simulate_double(my_case, mach_array, param_matrix, 'semi_span', 'x_cp');

fprintf('Simulation complete!\n\n');

% Display results
fprintf('=== SIMULATION RESULTS ===\n\n');
fprintf('Center of Pressure (x_cp) variation with Mach number and Fin Semi-Span\n');
fprintf('Units: meters from nose tip\n\n');
fprintf('Mach \\ Span | ');
for i = 1:size(param_matrix, 2)
    fprintf('%7.3f m | ', param_matrix(2,i));
end
fprintf('\n');
fprintf(repmat('-', 1, 15 + 12*size(param_matrix, 2)));
fprintf('\n');

for i = 1:length(x)
    fprintf('  %5.2f     | ', x(i));
    for j = 1:size(param_matrix, 2)
        fprintf('%9.4f  | ', Z(i,j));
    end
    fprintf('\n');
end

fprintf('\n\n=== SUMMARY STATISTICS ===\n\n');
fprintf('Average x_cp: %.4f m\n', mean(Z(:)));
fprintf('Min x_cp: %.4f m\n', min(Z(:)));
fprintf('Max x_cp: %.4f m\n', max(Z(:)));

% Create visualization
figure('Position', [100, 100, 1000, 600]);
plot(x, Z, 'LineWidth', 2, 'Marker', 'o');
grid on;
xlabel('Mach Number', 'FontSize', 12);
ylabel('Center of Pressure x_{cp} [m]', 'FontSize', 12);
title('Center of Pressure vs Mach Number for Different Fin Semi-Spans', 'FontSize', 14);
legend(arrayfun(@(s) sprintf('Semi-span = %.3f m', s), param_matrix(2,:), 'UniformOutput', false), ...
       'Location', 'best', 'FontSize', 10);
set(gca, 'FontSize', 11);

% Save the figure
savefig('output/demo_double_simulation.fig');
print('output/demo_double_simulation.png', '-dpng', '-r300');
fprintf('\nPlot saved to output/demo_double_simulation.png\n');
