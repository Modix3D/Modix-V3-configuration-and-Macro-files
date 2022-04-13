;Generated by Modix - 2.0
;Modix Big-40, Duex Expansion, Dual Printhead
; Configuration file for Duet WiFi (firmware version 3.3)


; General preferences_________________________________________________________
G90                                             			; send absolute coordinates...
M83                                             			; ...but relative extruder moves
M111 S0 								; Debug off
M555 P2 								; Set output to look like Marlin
M575 P1 B57600 S1							; Set auxiliary serial port baud rate and require checksum (for PanelDue)


; Network_____________________________________________________________________
M550 P"Big 40"                         					; set printer name
;M551 P"MODIX3D"               						; Set password (optional)
M552 S1                                        				; enable network
;M552 P0.0.0.0								; Uncomment this command for using Duet Ethernet board
M586 P0 S1                                      			; enable HTTP
M586 P1 S0                                      			; disable FTP
M586 P2 S0                                      			; disable Telnet

; Drives_________________________________________________________________________
;Main board______________________________________________________________________
M569 P0 S0                                                     		; Physical drive 0 . X1
M569 P1 S1                                                       	; Physical drive 1 . X2
M569 P2 R-1                                                        	; Physical drive 2 . Canceled
M569 P3 S1                                                       	; Physical drive 3 . Main Extruder
M569 P4 S0                                                       	; Physical drive 4 . Secondary Extruder
;Duex5 board_____________________________________________________________________
M569 P5 S0                                                       	; Physical drive 5 . Y
M569 P6 S0                                                       	; Physical drive 6 . Z1 (0,1000) 
M569 P7 S0                                                       	; Physical drive 7 . Z2 (0,0) 
M569 P8 S0                                                       	; Physical drive 8 . Z3 (1000,0) 
M569 P9 S0                                                       	; Physical drive 9 . Z4 (1000,1000) 

;Settings_________________________________________________________
M584 X0:1 Y5 Z6:7:8:9 U1 E3:4 P3					; Driver mapping
M671 X-169:-169:491:491 Y476:-58:-58:476 S30    			; Anticlockwise 
;___________________________________________________________________
M350 X16 Y16 U16 I1  		                           		; Configure microstepping with interpolation
M350 Z16 E16:16 I0              		                	; Configure microstepping without interpolation
M92 X100.00 Y100.00 Z2000.00 E400:400 U100.00      			; Set steps per mm
M566 X240 Y360 Z30.00 E120.00:120.00 U240 P1               		; Set maximum instantaneous speed changes (mm/min)
M203 X9000.00 Y9000.00 Z200.00 E1200.00:1200.00 U9000.00    		; Set maximum speeds (mm/min)
M201 X1000 Y1000 Z120.00 E250.00:250.00 U1000             		; Set accelerations (mm/s^2)
M204 P500                                      				; Set print and travel accelerations  (mm/s^2)
M906 X1800 Y1800.00 E1000.00:1000.00 U1800 I40 				; Set motor currents (mA) and motor idle factor in per cent
M906 Z1800.00 I50 							; Set motor currents (mA) and motor idle factor in per cent
M84 S100                                          			; Set idle timeout - one minute

; Axis Limits
M208 X0 Y0 Z-1 S1                               			; set axis minima
M208 X400 Y400 Z800 S0                          			; set axis maxima

; Endstops
M574 X1 S1 P"xstop"                            				; configure switch-type (e.g. microswitch) endstop for low end on X via pin xstop
M574 U1 S1 P"e0stop"                            			; configure switch-type (e.g. microswitch) endstop for low end on X via pin xstop
M574 Y2 S1 P"ystop"                            				; configure switch-type (e.g. microswitch) endstop for low end on Y via pin ystop

; Z-Probe

M558 P9 C"^zprobe.in" H5 F120 T6000 A1 R0.7  				; set Z probe type to bltouch and the dive height + speeds
M950 S0 C"duex.pwm5"
G31 P500 X-14 Y21 Z-3                        				; set Z probe trigger value, offset and trigger height
M556 S50 X0 Y0 Z0                               			; set orthogonal axis compensation parameters
M557 X-14:417 Y21:417 S66.5                 				; define mesh grid
M376 H10			                			; Height (mm) over which to taper off the bed compensation

; Heaters___________________________________________________________
M140 H-1                                       				; disable heated bed (overrides default heater mapping)

;E0_________________________________________________________________
M308 S0 P"e0temp" Y"thermistor" T100000 B4725   			; configure sensor 0 as thermistor on pin e0temp
M950 H0 C"e0heat" T0                            			; create nozzle heater output on e0heat and map it to sensor 0
;M307 H0 B0 S1.00                               			; PID calibration
M143 H0 S285                                    			; set temperature limit for heater 0 to 280C

;E1_________________________________________________________________
M308 S1 P"e1temp" Y"thermistor" T100000 B4725   			; configure sensor 1 as thermistor on pin e1temp
M950 H1 C"e1heat" T1                            			; create nozzle heater output on e1heat and map it to sensor 1
;M307 H1 B0 S1.00                               			; PID calibration
M143 H1 S285                                    			; set temperature limit for heater 1 to 280C


; Fans______________________________________________________________
M950 F0 C"fan0" Q500                            			; create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1                                  			; set fan 0 value. Thermostatic control is turned on
M950 F1 C"fan1" Q500                            			; create fan 1 on pin fan1 and set its frequency
M106 P1 S0 H-1                                  			; set fan 1 value. Thermostatic control is turned on
M950 F2 C"duex.fan7" Q500                            			; create LED on pin fan2 and set its frequency
M106 P2 S0 H-1                               				; Disable fan channel for LED
;M106 P2 S255								; LED on by default
M950 F3 C"duex.fan5" Q500                       			; create fan 3 on pin fan1 and set its frequency
M106 P3 S255 H0 T45                             			; set fan 3 value. Thermostatic control is turned on
M950 F4 C"duex.fan6" Q500                       			; create fan 4 on pin fan1 and set its frequency
M106 P4 S255 H1 T45                             			; set fan 4 value. Thermostatic control is turned on


; Tools______________________________________________________________
;T0_________________________________________________________________
M563 P0 S"E0 Primary" D0 H0 F0                  			; define tool 0
G10 P0 X0 Y0 Z0                                 			; set tool 0 axis offsets
G10 P0 R0 S210                                  			; set initial tool 0 active and standby temperatures to 0C

;T1_________________________________________________________________
M563 P1 S"E1 Secondary" D1 H1 F1                			; define tool 1
G10 P1 X0 Y49 Z0                                			; set tool 1 axis offsets
G10 P1 R0 S210                                    			; set initial tool 1 active and standby temperatures to 0C


; Custom settings__________________________________________________

M591 D0 P1 C"duex.e2stop" S1							; Regular filament sensor for E0

M591 D1 P1 C"duex.e3stop" S1							; Regular filament sensor for E1

; Automatic power saving____________________________________________
M911 S22.5 R29.0 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"              ; Set voltage thresholds and actions to run on power loss. Power Failure Pause
