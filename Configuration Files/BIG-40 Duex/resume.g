; resume.g
; called before a print from SD card is resumed
M106 P0 R1					; Restore fan 0 speed
M106 P1 R1					; Restore Fan 1 speed
T R1						; select the tool that was active last time the print was paused
M116 S3						; wait for hotend temperatures to stabilise
M83                  		; relative extruder moves
G1 E5 F600         			; extrude 5mm of filament
G1 R1 X0 F3000 				; go to the X position of the last print move
G1 R1 Y0 F3000				; go to the Y position of the last print move
G1 R1 Z5 F2000				; go to 5mm above position of the last print move
G1 R1 Z0 F360	        	; go back to the last print move