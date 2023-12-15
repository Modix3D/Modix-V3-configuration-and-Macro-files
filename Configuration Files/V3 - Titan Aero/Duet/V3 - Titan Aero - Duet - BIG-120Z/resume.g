; resume.g
; called before a print from SD card is resumed
T R1 P0 					; re-select tool
M106 R1 					; Set fan 0 to last used speed
M116 S3						; wait for hotend temperatures to stabilise
M83                  		; relative extruder moves
G1 E5 F600         			; extrude 5mm of filament
G1 R1 Z5 F2000				; go to 5mm above position of the last print move
G1 R1 X0 F3000 				; go to the X position of the last print move
G1 R1 Y0 F3000				; go to the Y position of the last print move
G1 R1 Z0 F360	        	; go back to the last print move