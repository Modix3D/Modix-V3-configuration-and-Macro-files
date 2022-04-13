; pause.g
; called when a print from SD card is paused
M300 S1111 P222		; beep
M117"Is a filament change required? Navigate to the macros and use the Filament Change macro"
M83            		; relative extruder moves
G1 E-5 F800  		; retract 5mm of filament
G91            		; relative positioning
G1 Z20 F360     	; lift Z by 20mm
G90					; absolute positioning
G1 X0 Y0 F5000 		; go to the front Left
M300 S1111 P333		; beep
T-1 P0				; deselect all tools