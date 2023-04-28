; homey.g
; called to home the Y axis
G91              						; relative positioning
if {global.idex} = 1
	T-1 P0									; Deselect all tools

G1 H2 Z5 F200   						; lift Z relative to current position
if {global.idex} = 1
	G1 H2 Y0.5 F600      					; go back 1mm
	G1 H1 Y{(move.axes[1].max+5)*-1} F5000	; move quickly to Y axis endstop and stop there (first pass)
	G1 H2 Y2 F600   						; go back a 2 mm
	G1 H1 Y{(move.axes[01].max+5)*-1} F600	; move slowly to Y axis endstop once more (second pass)
else
	G1 H2 X0.5 Y-0.5 						; back off 0.5mm from X, Y and U
	G1 H1 Y{(move.axes[1].max+5)} F5000  	; move quickly to X, Y and Y axis endstops and stop there (first pass)
	G1 H2 X2 Y2 U-2 F600      				; go back a few mm
	G1 H1 Y{(move.axes[1].max+5)} F600  	; move slowly to X, Y and Y axis endstops once more (second pass)

G1 H2 Z-5 F3000  						; lower Z again
G90              						; absolute positioning