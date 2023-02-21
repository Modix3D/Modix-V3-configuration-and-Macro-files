; Modix Big-120X V2 to V3 upgrade, Electronics and motion system upgrade, Dual Printhead
; Configuration file for Duet WiFi (firmware version 3.4.5)
; Generated by Modix - Version 3.4.5 Config B 
global config_version = "Version 3.4.5 Config B"
global generation = 2 ; Version 2 to version 3 printer
global printhead = 0 ; Aero printhead
global expansion = 0 ; no expansion board is installed
global printheads = 2 ; Dual printhead, change this value to 1 to switch it to a single-printhead setup

; General preferences_________________________________________________________
G90                                             			; send absolute coordinates...
M83                                             			; ...but relative extruder moves
M555 P2 													; Set output to look like Marlin
M575 P1 B57600 S1											; Set auxiliary serial port baud rate and require checksum (for PanelDue)

; Network_____________________________________________________________________
M550 P"Big 120X V2 to V3"                      				; set printer name
;M551 P"MODIX3D"               								; Set password (optional)
M98 P"config_networking.g"									; load networking settings
G4 P300														; wait 300ms
;M552 P0.0.0.0												; Uncomment this command for using Duet Ethernet board

; Drives_________________________________________________________________________
M569 P0 S1                                            		; Physical drive 0. X-Axis
M569 P1 S0                                                 	; Physical drive 1. Y-Axis
M569 P2 S0                                                  ; Physical drive 2. Z-Axis
M569 P3 S0													; Physical drive 3. Primary Extruder
M569 P4 S0													; Physical drive 4. Secondary Extruder

;Motor to stepper motor driver mapping_________________________________________________________
M584 X0 Y1 Z2 E3:4 P3										; Driver mapping

;Settings_________________________________________________________
M350 X16 Y16 Z16 E16:16 I1									; Configure microstepping with interpolation
M92 X100 Y100 Z2000 E418.5:418.5							; Set steps per mm
M566 X360 Y360 Z30 E3600:3600 P1							; Set maximum instantaneous speed changes (mm/min)
M203 X9000 Y9000 Z200 E5000:5000							; Set maximum speeds (mm/min)
M201 X1000 Y1000 Z200 E5000:5000							; Set accelerations (mm/s^2)
M204 P500													; Set print and travel accelerations  (mm/s^2)
M906 X1800 Y1800 E1000:1000 Z2300 I50						; Set motor currents (mA) and motor idle factor in per cent
M84 S100													; Set idle timeout - 100 seconds

; Axis Limits
M208 X0 Y0 Z-3 S1                               			; set axis minima
M208 X1200 Y600 Z600 S0                          			; set axis maxima

; Endstops
M574 X1 S1 P"xstop"                            				; configure switch-type (e.g. microswitch) endstop for low end on X via pin xstop
M574 Y2 S1 P"ystop"                            				; configure switch-type (e.g. microswitch) endstop for low end on Y via pin ystop

; Z-Probe
M558 P9 C"zprobe.in" H5 F120 T6000 A1 R0.7					; BLTouch probing settings
M950 S0 C"exp.heater3"										; set probe pin
M376 H50			                						; Height (mm) over which to taper off the bed compensation
G31 P500 X-14 Y21                         					; BLTouch X and Y offset from nozzle
M557 X{move.axes[0].min + sensors.probes[0].offsets[0] + 1, move.axes[0].max + sensors.probes[0].offsets[0] - 1} Y{move.axes[1].min + sensors.probes[0].offsets[1] + 1, move.axes[1].max + sensors.probes[0].offsets[1] - 1} P20:10   							; define mesh grid
M98 P"config_probe.g"										; Load the Z-offset from the config_probe.g file
; The Z_offset value is now set in config_probe.g, not in config.g
; Adjust the values there, do not adjust anything here.

; Heaters___________________________________________________________
M140 H-1                                       				; disable heated bed (overrides default heater mapping)

;E0_________________________________________________________________
M308 S0 P"e0temp" Y"thermistor" T100000 B4725 C7.06e-8   			; configure sensor 0 as thermistor on pin e0temp
;M308 S0 P"spi.cs1" Y"rtd-max31865"							; Configure sensor 0 as PT100 via the daughterboard
;M308 S0 P"e0temp" Y"pt1000"								; Configure sensor 0 as PT1000 on pin e0temp
M950 H0 C"e0heat" T0                            			; create nozzle heater output on e0heat and map it to sensor 0
M98 P"PID_tune_E0.g" R1										; PID calibration
; M307 is not used in this config. The M307 files are stored and executed from the PID_tune_E0.g file. You can verify the values there.
M143 H0 S285                                    			; set temperature limit for heater 0 to 285C

if {global.printheads} = 2
	;E1_________________________________________________________________
	M308 S1 P"e1temp" Y"thermistor" T100000 B4725 C7.06e-8   		; configure sensor 1 as thermistor on pin e1temp
	;M308 S1 P"spi.cs2" Y"rtd-max31865"						; Configure sensor 1 as PT100 via the daughterboard
	;M308 S1 P"e1temp" Y"pt1000"							; Configure sensor 1 as PT1000 on pin e1temp
	M950 H1 C"e1heat" T1									; create nozzle heater output on e1heat and map it to sensor 1
	M98 P"PID_tune_E1.g" R1									; PID calibration
	; M307 is not used in this config. The M307 files are stored and executed from the PID_tune_E1.g file. You can verify the values there.
	M143 H1 S285											; set temperature limit for heater 1 to 285C


; Fans & LED_________________________________________________________
M950 F0 C"fan0" Q500										; create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1 C"Primary blower fan"						; set fan 0 value.
M950 F2 C"fan2" Q500										; create LED on pin fan2 and set its frequency
M106 P2 S0 H-1 C"LED"										; Disable fan channel for LED

if {global.printheads} = 2
	M950 F1 C"fan1" Q500									; create fan 1 on pin fan1 and set its frequency
	M106 P1 S0 H-1 C"Secondary blower fan"					; set fan 1 value.


; Tools______________________________________________________________
;T0_________________________________________________________________
M563 P0 S"E0 Primary" D0 H0 F0                  			; define tool 0
G10 P0 X0 Y0 Z0                                 			; set tool 0 axis offsets
G10 P0 R0 S210                                  			; set initial tool 0 active and standby temperatures to 0C

if {global.printheads} = 2
	;T1_________________________________________________________________
	M563 P1 S"E1 Secondary" D1 H1 F1						; define tool 1
	G10 P1 X0 Y49 Z0 										; set tool 1 axis offsets
	G10 P1 R0 S210											; set initial tool 1 active and standby temperatures to 0C

; Automatic power saving____________________________________________
M911 S22.5 R29.0 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"  	; Set voltage thresholds and actions to run on power loss. Power Failure Pause

; Filament sensor settings__________________________________________________
M591 D0 P1 C"e0stop" S1										; Regular filament sensor for E0
M591 D1 P1 C"e1stop" S1										; Regular filament sensor for E1

; Add-on settings__________________________________________________

; Primary hotend Clog detector__________________________________________________
;M591 D0 P7 C"e0stop" S1 L3.2 E10 R10:300					; Clog Detector E0 [Add-On]

;Secondary hotend Clog detector__________________________________________________
;M591 D1 P7 C"e1stop" S1 L3.2 E10 R10:300					; Clog Detector E1 [Add-On]

; Crash detector__________________________________________________
;M950 J2 C"zstop" 											; create Input Pin 2 on Z-endstop to for M581 Command.
;M581 P2 T0 S0 R0											; Crash Detector   [Add-On]

; Emergency stop button__________________________________________________
;M950 J3 C"exp.e6stop" 										; create Input Pin 2 on pin E6 to for M581 Command.
;M581 P3 T0 S1 R0 											; Emergency stop [Add-On]
;M581 P3 T1 S1 R1											; Emergency stop, pause the print [Add-On]
;M581 P3 T1 S1 R0 											; Emergency stop, pause always [Add-On]