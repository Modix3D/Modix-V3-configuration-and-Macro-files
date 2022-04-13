; resume.g
; called before a print from SD card is resumed
M106 P0 R1
M106 P1 R1
T R1						
M116 S7						; wait for hotend temperatures to stabilise
M83                  		; relative extruder moves
G1 E5 F600         			; extrude 5mm of filament
G1 R1 X0 F6000 				; go to the X position of the last print move
G1 R1 X0 Y0 F6000			; go to the Y position of the last print move
G1 R1 X0 Y0 Z5 F6000		; go to 5mm above position of the last print move
G1 E3 F600         			; extrude 3mm of filament
G1 R1 X0 Y0 Z0 F360	        ; go back to the last print move

