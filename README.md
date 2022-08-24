# Modix V3 configuration and Macro files

We are updating the naming scheme for the firmware updates. The naming scheme will now depend on the compatible RepRapFimware version, followed by a letter schema to indicate the variant of the configuration and macro files.

For example:

Version 3.4.1 Config A

This is compatible with RepRapFimware 3.4.1, and it's the first update to the configuration files (Config A).

If an update to RepRapFirmware happens, and the configuration files have been updated to work with the new RRF update, this will be Version 3.5.0 Config A for the first release.


**3.4.1 Config D update notes** 

- Fixed a bug with the Griffin auto-Z probe for the Duet enabled printers
- Updated the tilt calibration process to better work with the Griffin
- the Z-offset and PID macro's now automatically write their results of their calibration processes to config_probe.g and PID_tune_E0.g or PID_tune_E1.g, no longer requiring you to edit those files manually.

**3.4.1 Config C update notes** 

- Adjusted the bed.g to work for all duex enabled printers in the same fashion, no longer requiring the BLTouch X/Y offset, but rather going off the max movement area of the nozzle.
- Cleaned up the configuration files
- Moved some data from the config_probe.g file back to config.g file. The config_probe.g now only contains the Z-offset data.
- Added a new macro file that allows you to move the bed down by 50mm even when not homed.

**3.4.1 Config B update notes**

- Added Griffin specific variants to the configuration files

**3.4.1 Config A update notes**

- Updated the filament-error.g to now only display a message, then execute M25 to run pause.g
- Removed some of the text from pause.g to prevent confusion regarding the source of the pause
- Updated the positioning of the M376 in the config_probe.g file to not be at the end, making the Z-offset process a little bit clearer/easier

**3.3 Config C update notes:**
- Updated the filament change macro, there were some reports of the extruder gear spinning extremely quickly when using it.
- Added a filament-error.g, which is required for compatibility with RRF3.4
- A M25 is added at the end of the filament-error0.g and filament error1.g files. This does double up on the pause movements but should help with issues related to not being able to resume after pausing
- Config.g is updated to contain the right interpotlation settings for the Z axis, reducing noise
- Added the configuration changes required for all add-ons to the config.g as commented out sections to help with the update process.

**3.3 Config B update notes:**

Homing, tilt and bed calibration
- Improved the homing and calibration files to properly load and unload the heightmap, and properly establish the Z=0 datum
- Adjusted the homing position to be in the front left of the build area for all printers.This way the front left corner (which is X0, Y0) now also has Z=0
- Updated the homing, tilt and bed calibration files to reference the min/max position, rather than a fixed number, so they are usable across all printers.

Adjusted the pausing and resume functionality
- Adjusted the resume.g to be a bit slower speed and changed the m116 S value from S7 to S3, to be slightly closer to printing temperatures 
- Changed the pause.g to un-select the used printhead, so that it cools down during the pause

Added filament-error0.g and filament-error1.g
- These trigger if the primary or secondary filament sensors (or clog detectors) trigger. This allows you to differentiate between a user-initiated pause, or a pause caused by a filament runout error.
- The messages differentiate between the two tools

Added stop.g functionality
- Allows you to use M0 in the end-gcode of your print, allowing for more unified end-gcode. It has been populated by our suggested end-gcode.

Mesh bed and adjustments:
- Adjusted the M557 parameters, now uses P for spacing instead of S. it uses between a 8x8 (for 40) to 30:10 (180x) to 15:15 (meter) grid instead of a set distance. Changed the mesh area to be -1mm from each edge
- Adjusted the M376 H value from H10 to H100, to better work with the large bed size  Modix printers.

Config.g adjustments:
- Increased the motor idle factor for the motors to be 50%
- Removed the U axis, instead set up the X axis to use two endstops.
- Added names to the blower fans and LED

Config_probe.g is a new file. This is where the BLTouch related settings are now loaded in. This allows multiple files to load in the correct BLTouch data, preventing the possibility of the BLTouch data not being properly loaded

Macro B update notes

- All macro files are now identical across all printers. 
- Changed the order of the calibration macros to be the same for all printers. It now goes probe -> Z-offset -> tilt -> bed compensation
- The LED on and off macros are now LED toggle, which toggles the LED between on and off.
- filament change macro has been updated, slightly lower retraction/extrusion speed, and uses relative extruder movements. Also properly re-selects the tools after pausing
