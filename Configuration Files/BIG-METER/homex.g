; homex.g
; called to home the X axis - DUAL ENDSTOPS
M400
G91               						; relative positioning
G1 H2 Z5 F200    						; lift Z relative to current position
M584 X0 Y5 Z6:7:8:9 U1 E3:4 P4			; Driver mapping
M400
G1 H1 X-1005 U-1005 F3000 				; move quickly to X axis endstop and stop there (first pass)
G1 H2 X5 U5 F600      					; go back a few mm
G1 H1 X-1005 U-1005 F600  				; move slowly to X and Y axis endstops once more (second pass)
M400
M584 X0:1 Y5 Z6:7:8:9 U1 E3:4 P3		; Driver mapping
G1 H2 Z-5 F200   						; lower Z again
G90               						; absolute positioning
M400