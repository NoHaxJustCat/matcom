# MatComLib - MATLAB Interface for Missile DATCOM

A powerful MATLAB library that provides a seamless interface to Missile DATCOM (Digital Datcom), enabling automated aerodynamic analysis and parameter sweeps for rocket and missile configurations.

**Author:** Nicolò Basso  
**Email:** nicolo.basso@aurorarocketry.eu  
**Organization:** MSA Department, Aurora Rocketry, University of Bologna

---

## 📋 Overview

MatComLib bridges the gap between MATLAB's computational capabilities and Missile DATCOM's aerodynamic prediction tools. It automates the entire workflow of:

- Creating DATCOM input files from MATLAB structures
- Running DATCOM simulations
- Importing and processing results
- Performing multi-dimensional parameter sweeps
- Visualizing aerodynamic data

This library is particularly useful for rocket design optimization, stability analysis, and aerodynamic characterization across varying flight conditions.

---

## ✨ Features

- **Structured Case Definition**: Define rocket geometry using intuitive MATLAB structures
- **Single Variable Simulations**: Sweep across Mach numbers or other flight conditions
- **Double Variable Simulations**: Simultaneous variation of two parameters (e.g., Mach vs. fin geometry)
- **Parallel Processing**: Leverages MATLAB's parallel computing for faster simulations
- **Automatic File Management**: Handles temporary file creation and cleanup
- **Multiple Output Types**: Extract drag coefficient (CD), center of pressure (X_CP), and more
- **Data Interpolation**: Built-in interpolation for smooth result surfaces
- **Case Management**: Save and load rocket configurations

---

## 🚀 Getting Started

### Prerequisites

- MATLAB (tested with parallel computing toolbox)
- Missile DATCOM executable (`datcom.exe`)
- Windows OS (current version uses Windows-specific commands)

### Installation

1. Clone or download this repository
2. Ensure DATCOM executable is in the `DATCOM\` directory
3. Add the library to your MATLAB path:

```matlab
addpath('lib');
addpath('src/main');
addpath('src/modules');
addpath('src/utils');
```

---

## 📖 Usage

### Quick Start Example

```matlab
% Setup environment
setup_paths();

% Load a rocket case
my_case = initialize("BOREALIS");

% Define Mach number range
mach_array = linspace(0.1, 1.2, 24);

% Run simulation for center of pressure
[x, y] = simulate(my_case, mach_array, "x_cp");

% Visualize results
figure;
plot(x, y);
xlabel('Mach Number');
ylabel('Center of Pressure [m]');
grid on;
```

### Creating a New Rocket Case

Use the `caseBuilder.m` template to define your rocket geometry:

```matlab
datcom_case = struct();

% Basic info
datcom_case.name = "MY_ROCKET";
datcom_case.unit = "M";  % Meters

% Reference point
datcom_case.x_cg = 1.29;  % CG distance from nose tip

% Flight conditions
datcom_case.alphas = [0];     % Angles of attack
datcom_case.alt = 300;        % Altitude
datcom_case.mach = [0.4];     % Mach number

% Nose geometry
datcom_case.nose_type = "OGIVE";
datcom_case.nose_length = 0.55;
datcom_case.nose_diameter = 0.1;

% Body geometry
datcom_case.ctrbody_length = 0.140;
datcom_case.ctrbody_diameter = 0.1;

% Afterbody/boattail
datcom_case.aftbody_type = "CONE";
datcom_case.aftbody_length = 0.1;
datcom_case.aftbody_diameter = 0.0698;

% Fins
datcom_case.n_fins = 3;
datcom_case.semi_span = [0.0, 0.11];  % Root and tip
datcom_case.chord = [0.24, 0.12];
datcom_case.x_le = [1.71, 1.77];

% Save the case
save('data/cases/MY_ROCKET.mat', 'datcom_case');
```

### Single Variable Simulation

```matlab
% Load case
my_case = initialize("BOREALIS");

% Define parameter sweep
mach_array = linspace(0.3, 1.2, 20);

% Simulate drag coefficient across Mach range
[mach, cd] = simulate(my_case, mach_array, "cd");

% With interpolation for smoother curves
[mach, cd] = simulate(my_case, mach_array, "cd", "spline", 10);
```

### Double Variable Simulation

Vary two parameters simultaneously (e.g., Mach number and fin size):

```matlab
% Load case
my_case = initialize("BOREALIS");

% Mach number range
mach_array = linspace(0.3, 1.2, 10);

% Fin semi-span configurations
% Each column is [root, tip] for one configuration
param_matrix = [
    0.0,  0.0,  0.0,  0.0;    % Root (attached to body)
    0.08, 0.10, 0.12, 0.14    % Tip semi-span variations
];

% Run double simulation
[x, y, Z] = simulate_double(my_case, mach_array, ...
                           param_matrix, 'semi_span', 'x_cp');

% Z is a matrix: rows = Mach values, columns = parameter values
surf(y(2,:), x, Z);
xlabel('Fin Semi-Span [m]');
ylabel('Mach Number');
zlabel('Center of Pressure [m]');
```

---

## 🎯 Demonstration: Double Variable Simulation

Here's a real example from our test case analyzing the BOREALIS rocket. We varied both Mach number (0.3 to 1.2) and fin semi-span (0.08 to 0.14 m) to observe their effect on the center of pressure:

### Simulation Setup

- **Rocket**: BOREALIS configuration
- **Mach Range**: 0.30 to 1.20 (10 points)
- **Fin Semi-Span**: 0.080, 0.100, 0.120, 0.140 meters (tip span)
- **Output**: Center of Pressure (x_cp) in meters from nose tip

### Results

```
Center of Pressure (x_cp) vs Mach Number and Fin Semi-Span
Units: meters from nose tip

Mach \ Span |   0.080 m |   0.100 m |   0.120 m |   0.140 m |
---------------------------------------------------------------
   0.30     |   -1.7400 |   -2.4660 |   -2.9430 |   -3.2740 |
   0.40     |   -1.7350 |   -2.4690 |   -2.9500 |   -3.2830 |
   0.50     |   -1.7200 |   -2.4660 |   -2.9540 |   -3.2910 |
   0.60     |   -1.6770 |   -2.4470 |   -2.9480 |   -3.2920 |
   0.70     |   -1.5430 |   -2.3570 |   -2.8890 |   -3.2520 |
   0.80     |   -1.3630 |   -2.2440 |   -2.8190 |   -3.2120 |
   0.90     |   -1.0570 |   -2.0640 |   -2.6910 |   -3.1160 |
   1.00     |   -1.3980 |   -2.2610 |   -2.8060 |   -3.1730 |
   1.10     |   -2.1770 |   -2.9910 |   -3.4940 |   -3.8480 |
   1.20     |   -2.8040 |   -3.4390 |   -3.8490 |   -4.1260 |

Summary Statistics:
  Average x_cp: -2.6657 m
  Min x_cp: -4.1260 m (supersonic, large fins)
  Max x_cp: -1.0570 m (transonic, small fins)
```

### Key Observations

1. **Fin Size Effect**: Larger fins move the center of pressure significantly aft (more negative)
2. **Transonic Behavior**: Notable shift around Mach 0.9-1.0 due to shock formation
3. **Supersonic Trend**: Center of pressure moves aft as Mach increases beyond 1.0
4. **Stability Implications**: All configurations show stable characteristics (CP aft of nominal CG)

Run the demo yourself:

```matlab
run('demo_double_sim.m');
```

---

## 📁 Project Structure

```
matcom/
├── lib/                        # Core library functions
│   ├── simulate.m             # Single variable simulation
│   ├── simulate_double.m      # Double variable simulation
│   ├── eval_mach.m            # Evaluate single Mach point
│   ├── fast_import_cd.m       # Import drag coefficient
│   ├── fast_import_x_cp.m     # Import center of pressure
│   └── write_on_dat.m         # Generate DATCOM input files
├── src/
│   ├── main/
│   │   ├── initialize.m       # Initialize and load cases
│   │   ├── run.m              # Example run script
│   │   └── setup_paths.m      # Path configuration
│   ├── modules/
│   │   └── caseBuilder.m      # Template for creating cases
│   └── utils/                 # Utility functions
├── data/
│   └── cases/                 # Saved rocket configurations
├── output/                    # Simulation results
├── DATCOM/                    # DATCOM executable location
└── demo_double_sim.m          # Demonstration script
```

---

## 🔧 Available Functions

### Core Simulation Functions

- `simulate(case, mach_array, output_type, [interp_type], [scale])` - Single parameter sweep
- `simulate_double(case, mach_array, param_matrix, param_type, output_type)` - Double parameter sweep
- `initialize(case_name)` - Load and initialize a rocket case
- `eval_mach(case, mach, output_type)` - Evaluate single Mach number

### Supported Output Types

- `"cd"` - Drag coefficient
- `"x_cp"` - Center of pressure location

### Interpolation Types

- `"linear"` - Linear interpolation
- `"spline"` - Cubic spline interpolation
- `"pchip"` - Piecewise cubic Hermite interpolation

---

## 📊 Typical Workflow

1. **Define Geometry**: Create rocket case using `caseBuilder.m`
2. **Save Case**: Store as `.mat` file in `data/cases/`
3. **Initialize**: Load case with `initialize()`
4. **Simulate**: Run `simulate()` or `simulate_double()`
5. **Analyze**: Process and visualize results
6. **Iterate**: Refine design based on findings

---

## ⚠️ Notes & Limitations

- Currently optimized for Windows (uses Windows-specific file commands)
- Requires valid DATCOM installation and executable
- Parallel processing requires MATLAB Parallel Computing Toolbox
- Temporary files are created in `temp/` directory during simulation
- Large parameter sweeps may take considerable time

---

## 🤝 Contributing

Contributions are welcome! Areas for improvement:

- Cross-platform compatibility (Linux/Mac support)
- Additional output parameter extraction
- Visualization tools
- Performance optimization
- Documentation examples

---

## 📝 License

Please refer to the original author and Aurora Rocketry, University of Bologna for licensing information.

---

## 📧 Contact

For questions, issues, or collaboration:

- **Author**: Nicolò Basso
- **Email**: nicolo.basso@aurorarocketry.eu
- **Organization**: MSA Department, Aurora Rocketry, University of Bologna

---

## 🙏 Acknowledgments

- Missile DATCOM development team
- Aurora Rocketry at University of Bologna
- Contributors to the MATLAB aerospace community

---

_Happy simulating! 🚀_
