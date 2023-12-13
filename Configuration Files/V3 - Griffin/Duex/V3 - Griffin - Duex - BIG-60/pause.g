; pause.g
; called when a print from SD card is paused
M300 S1111 P222																				; beep
G4 P1																						; dwell 1ms
M8																							; relative extruder moves
G1 E-5 F800																					; retract 5mm of filament
G91																							; relative moves
if {(move.axes[2].machinePosition) < (move.axes[2].max - 10)} 								; check if there's sufficient space to raise head
	G1 Z+5 F3000																			; move Z up a bit
else
	G4 P10																					; wait for popup to display

G90																							; absolute moves
G1 X1 Y1 F6000																				; move quickly to the front left
M300 S1111 P333																				; beep
M106 S0																						; set fans to 0
T-1 P0																						; deselect tools