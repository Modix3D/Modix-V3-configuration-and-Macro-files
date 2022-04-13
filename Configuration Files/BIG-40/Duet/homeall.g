; homeall.g
; called to home all axes
M98 P"config_probe.g"		
M280 P0 S60 I1
G29 S2             			; cancel mesh bed compensation
G91                    		; relative positioning
M913 X50 					; X axis 50% power

G1 H2 Z5 F200          												; lift Z relative to current position
G1 H1 X{(move.axes[0].max+5)*-1} Y{(move.axes[1].max+5)} F3000  	; move quickly to X and Y axis endstops and stop there (first pass)
G1 H2 X5 Y-5 F600      												; go back a few mm
G1 H1 X{(move.axes[0].max+5)*-1} Y{(move.axes[1].max+5)} F600  		; move slowly to X and Y axis endstops once more (second pass)

G90                    		; absolute positioning
G1 X{(move.axes[0].max-move.axes[0].min)/2} Y{(move.axes[1].max-move.axes[1].min)/2} F3000 ; move probe to center of bed
G1 F600
M913 X100 					; X axis 100% power
G30                    		; home Z by probing the bed
G29 S1						; load heightmap