; pause.g
; called when a print from SD card is paused
M300 S1111 P222																				; beep
M117"Print is being paused. Is a filament change required? Navigate to the macros tab and press on Filament Change"	; message
G4 P1																						; dwell 1ms
M83            																				; relative extruder moves
G1 E-5 F800  																				; retract 5mm of filament
G91																							; relative moves
if {(move.axes[2].machinePosition) < (move.axes[2].max - 10)} 								; check if there's sufficient space to raise head
	M291 P{"Raising head to...  " ^ move.axes[2].machinePosition+5}  R"Raising head" S0 T3	; message
	G1 Z+5 F3000 																			; move Z up a bit
else
	M291 P{"Cannot raise head- insufficient space  " ^ move.axes[2].machinePosition ^ " : " ^ (move.axes[2].max - 10) ^ "."} R"Raising head" S0 T3
	G4 S3 																					; wait for popup to display

G90																							; absolute moves
G1 X1 Y1 F6000  																			; move quickly to the front left
M300 S1111 P333																				; beep
M106 S0																						; set fans to 0
T-1 P0																						; deselect tools