# Modix V3 configuration and Macro files

Version 2.1 Configuration and Macro files update notes:

Homing, tilt and bed calibration
- Improved the homing and calibration files to properly load and unload the heightmap, and properly establish the Z=0 datum
- Adjusted the homing position to be in the middle of the build area for all printers.
- Updated the homing, tilt and bed calibration files to reference the min/max position, rather than a fixed number, so they are usable across all printers.

Adjusted the pausing and resume functionality
- Adjusted the resume.g to be a bit slower speed and changed the m116 S value from S7 to S3, to be slightly closer to printing temperatures 
- Changed the pause.g to un-select the used printhead, so that it cools down during the pause

Mesh bed and adjustments:
- Adjusted the M557 parameters, now uses P for spacing instead of S. it uses between a 8x8 (for 40) to 30:10 (180x) to 15:15 (meter) grid instead of a set distance. Changed the mesh area to be -1mm from each edge
- Adjusted the M376 H value from H10 to H100, to better work with the large bed size  Modix printers.

Config.g adjustments:
- Increased the motor idle factor for the motors to be 50%
- Removed the U axis, instead set up the X axis to use two endstops.
- Added names to the blower fans and LED

Config_probe.g is a new file. This is where the BLTouch related settings are now loaded in. This allows multiple files to load in the correct BLTouch data, preventing the possibility of the BLTouch data not being properly loaded

Macro adjustments:
- All macro files are now identical across all printers. 
- Changed the order of the calibration macros to be the same for all printers. It now goes probe -> Z-offset -> tilt -> bed compensation
- The LED on and off macros are now LED toggle, which toggles the LED between on and off.