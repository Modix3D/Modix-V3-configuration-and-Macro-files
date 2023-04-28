; homeall.g
; called to home all axes
M98 P"config_probe.g"									; Load Primary Z-offset probe settings
if {global.idex} = 1
	M98 P"config_probe_secondary.g"						; Load secondary Z-offset settings
	M98 P"config_probe_offset_U.g"						; Load secondary U offset settings
	M98 P"config_probe_offset_X.g"						; Load secondary X offset settings
M280 P0 S60 I1											; clear any probe errors
G29 S2													; cancel mesh bed compensation
if {global.idex} = 1
	T-1 P0													; Deselect all tools
G91                    									; relative positioning

M913 X50 												; X axis 50% power

G1 H2 Z5 F200          									; lift Z relative to current position
if {global.idex} = 1
	G1 H2 X0.5 Y0.5 U-0.5											; back off 0.5mm from X, Y and U
	G1 H1 X{(move.axes[0].max+5)*-1} Y{(move.axes[1].max+5)*-1} U{(move.axes[3].max+5)} F5000  		; move quickly to X, Y and Y axis endstops and stop there (first pass)
	G1 H2 X2 Y2 U-2 F600      										; go back a few mm
	G1 H1 X{(move.axes[0].max+5)*-1} Y{(move.axes[1].max+5)*-1} U{(move.axes[3].max+5)} F600  		; move slowly to X, Y and Y axis endstops once more (second pass)
else
	G1 H2 X0.5 Y-0.5 												; back off 0.5mm from X, Y and U
	G1 H1 X{(move.axes[0].max+5)*-1} Y{(move.axes[1].max+5)} F5000  ; move quickly to X, Y and Y axis endstops and stop there (first pass)
	G1 H2 X2 Y2 U-2 F600      										; go back a few mm
	G1 H1 X{(move.axes[0].max+5)*-1} Y{(move.axes[1].max+5)} F600  	; move slowly to X, Y and Y axis endstops once more (second pass)
M913 X100 												; X axis 100% power

G90														; absolute positioning
G1 X{move.axes[0].min+5} Y{move.axes[1].min+5} F6000 	; move to front left
G1 F2000												; reduce speed
G30														; home Z by probing the bed
G29 S1													; load heightmap

if {global.idex} = 1
	if job.file.fileName = null
		G4 S0
	else
		if state.currentTool = 0
			G90
			T0
			G4 P0
			G1 Y200 X10 Z5
			G4 S0
		elif state.currentTool = 1
			G90
			T0
			G4 P0
			G1 Y200 X10 Z5
			G4 S0
			T1
if {global.idex} = 1
	set global.pausetime= 0