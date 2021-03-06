# Supersonic Aerofoil Calculator - S.A.C.

![S.A.C. Logo](https://github.com/mhd1msyb/S.A.C._Resources/blob/master/sac_icon_256.png)

## Description

Cross-platform interactive flow calculator for aerofoils. Cross-sections are constructed in 2D pixel coordinates by point-clicking, using a touchscreen or LMB mouse, to add nodal points (defining line segments), which form the outline. The aerofoil can be rotated (up to 10 deg) to simulate varying angle of attack's (AoA), and oblique shocks (OS) and expansion fans (EF) are calculated for every segment and rendered using colour-coded primitives (lines for OS, triangles for ES). Plots can be generated for common coefficients, namely cL and cD, for user-defined inlet flow speed and gas gamma. A 3D mesh can be optionally generated, either as a single hollow blade/wing, or a set of instanced blades arranged around the hub of a turbine. **Please note: this program is still a W.I.P and has room for many optimisations. So expect slow performance on older hardware and abrupt crashes.**



## Features

 - Cross-platform design, with support for Windows, Linux, Mac
 - Sketch and edit tools to create aerofoils
 - Built-in geometry editor
 - 3D aerofoil mesh visualiser - visualise a single blade/wing or a turbine in 3D
 - Basic save/load aerofoil system
 - Plot cL, cD, and coefficient ratios vs. AoA
 - Display pressure ratios, flow speeds, bow shock data and more using the data tables
 - Weak and strong shocks resolved numerically using the bisection method
 - Oblique shock and expansion fan visualisation
 - Integrated aerofoil library, with ready-to-use presets
 - User-defined AoA, flow speed and gas gamma
 - Self-contained - no external dependencies and no installation setup required; just run the executable

 ![](https://github.com/mhd1msyb/S.A.C._Resources/blob/master/preview_v0.3.png)
 ![](https://github.com/mhd1msyb/S.A.C._Resources/blob/master/3d_mesh_viewer.png)

 ## Pre-compiled binaries (DOWNLOADS)
Download the zipped files for your platform, then extract and run.
 #### - [Windows](https://github.com/mhd1msyb/S.A.C._Resources/raw/master/SAC_win_v0.3.zip)
 #### - [Linux](https://github.com/mhd1msyb/S.A.C._Resources/raw/master/SAC_lin_v0.3.zip)
 #### - [Mac](https://github.com/mhd1msyb/S.A.C._Resources/raw/master/SAC_mac_v0.3.zip)



## How to use

#### Instruction Manual
 - Download the [S.A.C. Instruction Manual](https://github.com/mhd1msyb/S.A.C._Resources/raw/master/SAC_instruction_manual.pdf) (for v0.3). This manual is a W.I.P.

#### Tutorial Videos
  - [Essentials Run-through](https://github.com/mhd1msyb/S.A.C._Resources/raw/master/Essentials%20Run-through.m4v)
  - [Sketch an Aerofoil](https://github.com/mhd1msyb/S.A.C._Resources/raw/master/Sketch%20Tutorial.m4v)
  - [Save and Load an Aerofoil](https://github.com/mhd1msyb/S.A.C._Resources/raw/master/Save%20and%20Load%20Aerofoil.m4v)
  - [Show Data Tables](https://github.com/mhd1msyb/S.A.C._Resources/raw/master/Show%20Data%20Tables.m4v)
  - [Generate 3D Mesh](https://github.com/mhd1msyb/S.A.C._Resources/raw/master/Generate%203D%20Mesh.m4v)






## Compile from source
If you want to compile and run the source files:
 - Download and extract the source files (`Clone or download -> Download ZIP`). Alternatively: open a command window and run `git clone https://github.com/mhd1msyb/supersonic-aerofoil-calculator-SAC.git` (this will save the files to your directory)
 - Download and extract the Godot Engine version 3.1 or above from www.godotengine.org
 - Open the `project.godot` file using the Godot Engine application (an .exe on Windows)
 - Press `F5` to run


 ## Issues
 Please report any bugs/crashes using the [issue tracker](https://github.com/mhd1msyb/supersonic-aerofoil-calculator-SAC/issues). When reporting crashes, please provide a screenshot of the command window.

## License details
This program is licensed under the Apache License Version 2.0 (for more details, view the `LICENSE` file).

This program uses the Godot Engine, which is licensed under the Expat license.

Fonts are rendered using FreeType. Portions of this software are © 2019 The FreeType Project (www.freetype.org). All rights reserved.

To view the Godot Engine and FreeType licenses, refer to the `godot_engine_and_freetype_LICENSES` file.
