; homex.g
; called to home the X axis - DUAL ENDSTOPS
M400
G91               					; relative positioning
M584 X0 Y5 Z6:7:8:9 U1 E3:4 P4				; Driver mapping
M400

M913 X50 U50
G1 H2 Z5 F200   					; lift Z relative to current position
G1 H1 X-405 U-405 F3000 				; move quickly to X axis endstop and stop there (first pass)
G1 H2 X5 U5 F600    					; go back a few mm
G1 H1 X-405 U-405 F600  				; move slowly to X axis endstop once more (second pass)
M400

M913 X100 U100
M584 X0:1 Y5 Z6:7:8:9 U1 E3:4 P3		        ; Driver mapping
G1 H2 Z-5 F200   					; lower Z again
G90               					; absolute positioning
M400