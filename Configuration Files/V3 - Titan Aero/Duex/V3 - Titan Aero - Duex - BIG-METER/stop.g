; stop.g
; called when M0 (Stop) is run (e.g. when a print from SD card is cancelled)

M83																							; Extruder relative moves
G1 E-5 F2700 																				; Retract a bit

M568 P0 R0 S0																				; set primary hotend temperatures to 0
if {global.printheads} = 2
	M568 P1 R0 S0																			; set secondary hotend temperatures to 0
M106 S0																						; set fans to 0
T-1 P0																						; deselect any tools
G4 P1																						; dwell 1ms

G91																							; relative moves
if {(move.axes[2].machinePosition) < (move.axes[2].max - 10)} 								; check if there's sufficient space to raise head
	G1 Z+5 F3000																			; move Z up a bit
else
	G4 S3 																					; wait for popup to display

G90																							; absolute moves moves
G1 X{move.axes[0].min+2} Y{move.axes[1].max-2} F6000  										; move quickly to the rear left
M84																							; release power from steppers