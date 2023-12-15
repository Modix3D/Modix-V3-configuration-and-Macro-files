; sleep.g
; called when M1 (Sleep) is being processed
;

M300 S1111 P222														; beep	
M568 P0 R0 S0														; set primary hotend temperatures to 0
if {global.printheads} = 2
	M568 P1 R0 S0													; set secondary hotend temperatures to 0
G4 P1																; dwell 1ms
M83																	; relative extruder moves
G1 E-5 F800  														; retract 5mm of filament
G91																	; relative moves
if {(move.axes[2].machinePosition) < (move.axes[2].max - 10)} 		; check if there's sufficient space to raise head
	G1 Z+5 F3000													; move Z up a bit
else
	G4 P10															; wait 10ms

G90																	; absolute moves
G1 X5 Y5 F6000														; move quickly to the front left
M300 S1111 P333														; beep
M106 S0																; set fans to 0
T-1 P0																; deselect any tools
M290 R0 S0															; clear babystepping 
G29 S2																; cancel mesh bed compensation
M84																	; disable the stepper motors 