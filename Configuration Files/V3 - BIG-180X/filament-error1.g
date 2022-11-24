M300 S1111 P222																				; beep
M83            																				; relative extruder moves
M300 S1111 P222																				; beep
G1 E-5 F800  																				; retract 5mm of filament
G92 E0																						; Set E position to 0
G91            																				; relative positioning

if {(move.axes[2].machinePosition) < (move.axes[2].max - 10)} 								; check if there's sufficient space to raise head
	G1 Z+5 F3000 																			; move Z up a bit
else
	G4 S3 																					; wait for popup to display

G90																							; absolute moves
G1 X1 Y1 F6000  																			; move quickly to the front left
M300 S1111 P333																				; beep
M106 S0																						; set fans to 0
T-1 P0																						; deselect tools

M25
M291 R"Attention!" P"Filament Sensor Raised An Error On E1" S1								; message