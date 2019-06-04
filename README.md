# Supersonic Aerofoil Calculator - SAC



## Description

Cross-platform interactive flow calculator for aerofoils. Cross-sections are constructed in 2D pixel coordinates by point-clicking, using a touchscreen or LMB mouse, to add nodal points (defining line segments), which form the outline. The aerofoil can be rotated (up to 10 deg) to simulate varying angle of attack's (AoA), and oblique shocks (OS) and expansion fans (EF) are calculated for every segment and rendered using colour-coded primitives (lines for OS, triangles for ES). Plots can be generated for common coefficients, namely cL and cD, for user-defined inlet flow speed and gas gamma. A 3D mesh can be optionally generated, either as a single hollow blade/wing, or a set of instanced blades arranged around the hub of a turbine.



## Features

 - Cross-platform design, with support for Windows, Linux, Mac, Android and iOS
 - Sketch and edit tools to create aerofoils
 - Built-in geomtery editor
 - 3D aerofoil mesh visualiser - visualise a single blade/wing or a turbine in 3D
 - Basic save/load aerofoil system
 - Plot cL, cD, and coefficient ratios vs. AoA
 - Display pressure ratios, flow speeds, bow shock data and more using the data tables
 - Weak and strong shocks resolved numerically using the bisection method
 - Oblique shock and expansion fan visualisation
 - Integrated aerofoil library, with ready-to-use presets
 - User-defined AoA, flow speed and gas gamma
 
 ![](https://github.com/mhd1msyb/supersonic-aerofoil-calculator-SAC/blob/master/preview.png)
 
 ## Pre-compiled binaries (DOWNLOADS)
Download the zipped files for your platform, then extract and run.
  #### - Windows
  #### - Linux
  #### - Mac
  
  
  
## How to use
Watch the tutorial video (to come)



## Compile from source
If you want to compile and run the source files:
 - Download and extract the source files (`Clone or download -> Download ZIP`). Alternatively: open a command window and run `git clone https://github.com/mhd1msyb/supersonic-aerofoil-calculator-SAC.git` (this will save the files to your directory)
 - Download and extract the Godot Engine from www.godotengine.org
 - Open the `project.godot` file using the Godot Engine application (an .exe on Windows)
 - Press `F5` to run
 
 #### Export to Android
 ...
 
 ## Issues, comments and queries
 Please report any bugs/crashes using the issue tracker. When reporting crashes, pleas provide a screenshot of the command window. Additionally, if you would like to ask a question(s) regarding any aspect of the program, feel free to send me (Mehdi) an email at [mhdmsy@hotmail.co.uk].
 
## License details
This program is licensed under...
This program uses the Godot Engine. Please refer to the `godot_engine_license.txt` file for viewing its (Godot Engine) license (alternatively visit godotengine.org/license).  

