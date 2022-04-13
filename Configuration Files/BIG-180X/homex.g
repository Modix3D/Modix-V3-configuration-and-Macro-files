; homex.g
; called to home the X axis
G91               							; relative positioning

G1 H2 Z5 F200          						; lift Z relative to current position
G1 H1 X{(move.axes[0].max+5)*-1} F3000  	; move quickly to X and Y axis endstops and stop there (first pass)
G1 H2 X5 F600      							; go back a few mm
G1 H1 X{(move.axes[0].max+5)*-1} F600  		; move slowly to X and Y axis endstops once more (second pass)

G1 H2 Z-5 F200   							; lower Z again
G90               							; absolute positioning