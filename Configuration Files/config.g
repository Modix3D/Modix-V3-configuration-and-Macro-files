; Modix universal, Automatically checks for Duex and adjusts for printhead amount
; Configuration file for Duet WiFi (firmware version 3.4.1)
; Generated by Modix - Version 3.4.1 Config B

M98 P"printer_variables.g" R1
M98 P"printer_model_adjustments.g" R1

; General preferences_________________________________________________________
G90																; send absolute coordinates...
M83																; ...but relative extruder moves
M111 S0															; Debug off
M555 P2															; Set output to look like Marlin
M575 P1 B57600 S1												; Set auxiliary serial port baud rate and require checksum (for PanelDue)

; Network_____________________________________________________________________
M550 P{global.printer_name}										; set printer name
;M551 P"MODIX3D"												; Set password (optional)
M552 S1															; enable network
;M552 P0.0.0.0													; Uncomment this command for using Duet Ethernet board

; Drives_____________________________________________________________________________________
;___________________________________Duet-Only Users__________________________________________
if {global.board_type} = "duet"
	M569 P0 S1													; Physical drive 0 goes forwards. X-Axis.
	M569 P1 S0													; Physical drive 1 goes backwards. Y-Axis.
	M569 P2 S0													; Physical drive 2 goes backwards. Z-Axis.
	M569 P3 S1													; Physical drive 3 goes forwards. E0-Extruder.
	M569 P4 S0													; Physical drive 4 goes backwards. E1-Extruder.
else
	M569 P0 S0													; Physical drive 0 . X1
	M569 P1 S1													; Physical drive 1 . X2
	M569 P2 R-1													; Physical drive 2 . Canceled
	M569 P3 S1													; Physical drive 3 . Main Extruder
	M569 P4 S0													; Physical drive 4 . Secondary Extruder
	M569 P5 S0													; Physical drive 5 . Y
	M569 P6 S0													; Physical drive 6 . Z1 (rear left) 
	M569 P7 S0													; Physical drive 7 . Z2 (front left) 
	M569 P8 S0													; Physical drive 8 . Z3 (front right) 
	M569 P9 S0													; Physical drive 9 . Z4 (rear right) 

if {global.board_type} = "duet"
	M584 X0 Y1 Z2 E3:4 P3										; Driver mapping
else
	M584 X0:1 Y5 Z6:7:8:9 E3:4 P3 								; Duex driver mapping

; microstepping, steps/mm, acceleration and motor currents ___________________________________________________________________
if {global.board_type} = "duet"
	M350 X16 Y16 Z16 E16:16 I1  		                    	; Configure microstepping with interpolation
	M92 Y100 Z2000 E{global.steps_e0axis, global.steps_e1axis}	; Set steps per mm for Y, Z and extruder
	M92 X{global.steps_xaxis}									; set steps per mm for X-Axis
	M566 X360 Y360 Z120 E3600:3600 P1               			; Set maximum instantaneous speed changes (mm/min)
	M203 X9000 Y9000 Z200 E12000:12000     						; Set maximum speeds (mm/min)
	M201 X1000 Y1000 Z120 E1000:1000              				; Set accelerations (mm/s^2)
	M204 P500                                      				; Set print and travel accelerations  (mm/s^2)
	M906 X1800 Y1800 Z2400 E1000:1000 I40 						; Set X, Y and E motor currents (mA) and motor idle factor in per cent
	M84 S100                                      				; Set idle timeout - 100 seconds
else
	M350 X16 Y16 Z16 E16:16 I1  		                    	; Configure microstepping with interpolation
	M92 X100 Y100 Z2000 E{global.steps_e0axis, global.steps_e1axis}	; Set steps per mm
	M566 X360 Y360 Z120 E3600:3600 P1               			; Set maximum instantaneous speed changes (mm/min)
	M203 X9000 Y9000 Z200 E12000:12000   						; Set maximum speeds (mm/min)
	M201 X1000 Y1000 Z120 E1000:1000              				; Set accelerations (mm/s^2)
	M204 P500                                      				; Set print and travel accelerations  (mm/s^2)
	M906 X1800 Y1800 Z1800 E1000:1000 I50						; Set motor currents (mA) and motor idle factor in per cent
	M84 S100                                      				; Set idle timeout - 100 seconds

; machine limits
M208 X{global.axis_limit_x0} Y{global.axis_limit_y0} Z{global.axis_limit_z0} S1		; set axis minima
M208 X{global.axis_limit_x} Y{global.axis_limit_y} Z{global.axis_limit_z} S0		; set axis maxima

; ballscrew positioning
M671 X{global.x1_BS, global.x1_BS, global.x2_BS, global.x2_BS} Y{global.y2_BS, global.y1_BS, global.y1_BS, global.y2_BS} S30  ;Ball-Screws Positions X-axis (Anticlockwise) 


; Endstops
if {global.board_type} = "duet"
	M574 X1 S1 P"xstop"                            				; configure switch-type (e.g. microswitch) endstop for low end on X via pin xstop
	M574 Y2 S1 P"ystop"                            				; configure switch-type (e.g. microswitch) endstop for low end on Y via pin ystop
else
	M574 X1 S1 P"xstop + e0stop"                            	; configure switch-type (e.g. microswitch) endstop for low end on X via pin xstop
	M574 Y2 S1 P"ystop"                            				; configure switch-type (e.g. microswitch) endstop for low end on Y via pin ystop

; Z-Probe
if {global.board_type} = "duet"
	M558 P9 C"zprobe.in" H5 F120 T6000 A1 R0.7					; BLTouch probing settings
	M950 S0 C"exp.heater3"										; sets the BLTouch probe
else
	M558 P9 C"zprobe.in" H5 F120 T6000 A1 R0.7					; BLTouch probing settings
	M950 S0 C"duex.pwm5"										; sets the BLTouch probe

; Griffin auto-Z probe
if {global.extruder} = "griffin"
	M574 Z1 S1 P"!zstop" 										; configure switch-type for Automatic z-offset
else
	G4 P4
	
M376 H100			                							; Height (mm) over which to taper off the bed compensation
G31 P500 X{global.probe_x_offs} Y{global.probe_y_offs}   		; BLTouch X and Y offset from nozzle
M98 P"config_probe.g" R1										; load Z-offset
	
;mesh grid area
M557 X{global.mesh_x_min, global.mesh_x_max} Y{global.mesh_y_min, global.mesh_y_max} P{global.mesh_probing_points_x, global.mesh_probing_points_y}   ; define mesh grid

; Heaters___________________________________________________________
M140 H-1                                       					; disable heated bed (overrides default heater mapping)

;E0_________________________________________________________________
if {global.e0_sensortyp} = "thermistor"
	M308 S0 P"e0temp" Y"thermistor" T100000 B4725				; configure sensor 0 as thermistor on pin e0temp
elif {global.e0_sensortyp} = "pt1000"							
	M308 S0 P"e0temp" Y"pt1000"									; configure sensor 0 as PT1000 on pin e0temp 
else
	M308 S0 P"spi.cs1" Y"rtd-max31865"							; configure sensor 0 as PT100 using input 1 on PT100 daughterboard
M950 H0 C"e0heat" T0                            				; create nozzle heater output on e0heat and map it to sensor 0
M143 H0 S{global.e0_maxtemp}									; set temperature limit
;M307 H0 B0 S1.00                               				; PID calibration, disabled by default.


;E1_________________________________________________________________
if {global.printhead} = 2	
	if {global.e1_sensortyp} = "thermistor"
		M308 S1 P"e1temp" Y"thermistor" T100000 B4725			; configure sensor 1 as thermistor on pin e1temp
	elif {global.e1_sensortyp} = "pt1000"
		M308 S1 P"e1temp" Y"pt1000"								; configure sensor 1 as PT1000 on pin e1temp 
	else
		M308 S1 P"spi.cs2" Y"rtd-max31865"						; configure sensor 1 as PT100 using input 2 on PT100 daughterboard
	M950 H1 C"e1heat" T1                            			; create nozzle heater output on e1heat and map it to sensor 1
	M143 H1 S{global.e1_maxtemp}									; set temperature limit
	;M307 H1 B0 S1.00                               			; PID calibration, disabled by default

; Fans______________________________________________________________
if {global.board_type} = "duet"
	if {global.printhead} = 1
		M950 F0 C"fan0" Q500                      				; create fan 0 on pin fan0 and set its frequency
		M106 P0 S0 H-1 C"Primary blower fan"              		; set fan 0 value. 
		M950 F2 C"fan2" Q500                            		; create LED on pin fan2 and set its frequency
		M106 P2 S0 H-1 C"LED"                              		; Disable fan channel for LED
	else 
		M950 F0 C"fan0" Q500                          			; create fan 0 on pin fan0 and set its frequency
		M106 P0 S0 H-1 C"Primary blower fan" 					; set fan 0 value. 
		M950 F1 C"fan1" Q500                        			; create fan 1 on pin fan1 and set its frequency
		M106 P1 S0 H-1 C"Secondary blower fan"             		; set fan 1 value. 
		M950 F2 C"fan2" Q500                            		; create LED on pin fan2 and set its frequency
		M106 P2 S0 H-1 C"LED"                  					; Disable fan channel for LED
else
	if {global.printhead} = 1
		M950 F0 C"fan0" Q500                            		; create fan 0 on pin fan0 and set its frequency
		M106 P0 S0 H-1 C"Primary blower fan"					; set fan 0 value. Thermostatic control is turned on
		M950 F2 C"duex.fan7" Q500                            	; create LED on pin fan2 and set its frequency
		M106 P2 S0 H-1 C"LED"                              		; Disable fan channel for LED
		M106 P2 S255											; LED on by default
		M950 F3 C"duex.fan5" Q500                       		; create fan 3 on pin fan1 and set its frequency
		M106 P3 S255 H0 T45                             		; set fan 3 value. Thermostatic control is turned on
	else
		M950 F0 C"fan0" Q500                            		; create fan 0 on pin fan0 and set its frequency
		M106 P0 S0 H-1 C"Primary blower fan"					; set fan 0 value. Thermostatic control is turned on
		M950 F1 C"fan1" Q500                            		; create fan 1 on pin fan1 and set its frequency
		M106 P1 S0 H-1 C"Secondary blower fan"					; set fan 1 value. Thermostatic control is turned on
		M950 F2 C"duex.fan7" Q500                            	; create LED on pin fan2 and set its frequency
		M106 P2 S0 H-1 C"LED"                              		; Disable fan channel for LED
		M106 P2 S255											; LED on by default
		M950 F3 C"duex.fan5" Q500                       		; create fan 3 on pin fan1 and set its frequency
		M106 P3 S255 H0 T45                             		; set fan 3 value. Thermostatic control is turned on
		M950 F4 C"duex.fan6" Q500                       		; create fan 4 on pin fan1 and set its frequency
		M106 P4 S255 H1 T45                             		; set fan 4 value. Thermostatic control is turned on


; Tools______________________________________________________________
;T0_________________________________________________________________

M563 P0 S"E0 Primary" D0 H0 F0                  				; define tool 0
G10 P0 X0 Y0 Z0                                 				; set tool 0 axis offsets
G10 P0 R0 S210                                  				; set initial tool 0 active and standby temperatures to 0C

;T1_________________________________________________________________
if {global.printhead} = 2
	M563 P1 S"E1 Secondary" D1 H1 F1                			; define tool 1
	G10 P1 X0 Y49 Z0                                			; set tool 1 axis offsets
	G10 P1 R0 S210                                    			; set initial tool 1 active and standby temperatures to 0C

; Automatic power saving____________________________________________
M911 S22.5 R29.0 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"     		; Set voltage thresholds and actions to run on power loss. Power Failure Pause

; Custom settings__________________________________________________

if {global.filament_sensor_e0} = "regular"	
	if {global.board_type} = "duet"
		M591 D0 P1 C"e0stop" S1									; Regular filament sensor for E0 on duet
	else
		M591 D0 P1 C"duex.e2stop" S1							; Regular filament sensor for E0 on duex
elif {global.filament_sensor_e0} = "clog"
	if {global.board_type} = "duet"
		M591 D0 P7 C"e0stop" S1 L4.2 E10 R10:300				; clog detector for E0 on duet
	else
		M950 J0 C"exp.e2stop"  					  				; create Input Pin 0 on pin E2 for the M581 Command.
		M581 T1 P0 S0 R1										; filament runout sensor for E0 As External Trigger
		M591 D0 P7 C"e1stop" S1 L4.2 E10 R10:300				; Clog Detector for e0 on duex
else
	M591 D0 S0													; filament sensor on e0 is disabled

if {global.printhead} = 2	
	if {global.filament_sensor_e1} = "regular"
		if {global.board_type} = "duet"
			M591 D0 P1 C"e1stop" S1								; Regular filament sensor for E1 on duet
		else
			M591 D0 P1 C"duex.e3stop" S1						; Regular filament sensor for E1 on duex
	elif {global.filament_sensor_e1} = "clog"		
		if {global.board_type} = "duet"	
			M591 D1 P7 C"e1stop" S1 L4.2 E10 R10:300			; clog detector for E1 on duet
		else
			M950 J1 C"exp.e3stop"  					  			; create Input Pin 1 on pin E3 for the M581 Command.
			M581 T1 P1 S0 R1									; Regular filament sensor for E1 As External Trigger
			M591 D1 P7 C"zstop" S1 L3.14 E10 R10:300			; Clog Detector for e1 on duex
	else
		M591 D1 S0												; filament sensor on e1 is disabled

if {global.crash_detector} = "enabled"
	if {global.board_type} = "duet"
		M950 J2 C"zstop"										; create Input Pin 2 on Zstop for the M581 Command.
		M581 P2 T0 S0 R0 										; Crash Detector   [Add-On]
	else
		M950 J2 C"duex.e4stop" 									; create Input Pin 2 on pin duex.e4 for the M581 Command.
		M581 P2 T0 S0 R0										; Crash Detector   [Add-On]
		
if {global.emergencystop} = "enabled"
	if {global.board_type} = "duet"
		M950 J3 C"exp.e6stop" 									; create Input Pin 3 on pin E6 for the M581 Command.
		M581 P3 T1 S1 R1										; Emergency stop, pause the print, for the duet
	else
		M950 J3 C"duex.e6stop" 									; create Input Pin 2 on pin duex.e6 for the M581 Command.
		M581 P3 T1 S1 R1										; Emergency stop, pause the print, for the duex