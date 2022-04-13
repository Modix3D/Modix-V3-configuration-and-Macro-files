; homeall.g
; called to home all axes
M280 P3 S60 I1
G91                    		; relative positioning
G1 H2 Z5 F200          		; lift Z relative to current position
G1 H1 X-605 Y605 F3000 		; move quickly to X and Y axis endstops and stop there (first pass)
G1 H2 X5 Y-5 F600      		; go back a few mm
G1 H1 X-605 Y605 F600  		; move slowly to X and Y axis endstops once more (second pass)
G90                    		; absolute positioning
G30                    		; home Z by probing the bed
M375						; Loads the grid matrix file (Heightmap)
