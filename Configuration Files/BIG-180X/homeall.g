; homeall.g
; called to home all axes
M280 P7 S60
G91                    					; relative positioning
G1 H2 Z5 F200          					; lift Z relative to current position
M584 X0 Y5 Z6:7:8:9 U1 E3:4 P4			; Driver mapping
M400
M913 X50 U50
G1 H1 X-1805 Y605 U-1805 F3000 			; move quickly to X axis endstop and stop there (first pass)
G1 H2 X5 Y-5 U5 F600      				; go back a few mm
G1 H1 X-1805 Y605 U-1805 F600  			; move slowly to X and Y axis endstops once more (second pass)
M400
M913 X100 U100
M584 X0:1 Y5 Z6:7:8:9 U1 E3:4 P3		; Driver mapping
M400
G90                    					; absolute positioning
G30                    					; home Z by probing the bed
M375									; Loads the grid matrix file (Heightmap)