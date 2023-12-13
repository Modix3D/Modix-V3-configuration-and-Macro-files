; homey.g
; called to home the Y axis
G91										; relative positioning

G1 H2 Z5 F200							; lift Z relative to current position
G1 H1 Y{(move.axes[1].max+5)} F3000		; move quickly to Y axis endstop and stop there (first pass)
G1 H2 Y-2 F600							; go back a few mm
G1 H1 Y{(move.axes[1].max+5)} F600		; move slowly to Y axis endstop once more (second pass)

G1 H2 Z-5 F3000							; lower Z again
G90										; absolute positioning