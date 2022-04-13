; pause.g
; called when a print from SD card is paused
M300 S1111 P222
M117"Is filament change required? Navigate to the macros tab and press on Filament Change"
M564 H1 S1 		; 
M116
M83            		; relative extruder moves
G1 E-5 F800  		; retract 10mm of filament
G91            		; relative positioning
G1 Z20 F360     	; lift Z by 20mm
G90
G1 Y0 F6000 		; go to the front
G1 X0 F6000 		; go to the left
M300 S1111 P333
M291 R"Attention !" P"It is recommended to turn off the heaters if the pause is expected to last a long time" T46