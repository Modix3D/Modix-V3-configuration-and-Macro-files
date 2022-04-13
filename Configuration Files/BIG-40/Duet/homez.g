; homez.g
; called to home the Z axis
M280 P0 S60
M98 P"config_probe.g"
G29 S2                  ; cancel mesh bed compensation

G91                 	; relative positioning
G1 H2 Z5 F200      		; lift Z relative to current position
G90                    	; absolute positioning

G1 X{(move.axes[0].max-move.axes[0].min)/2} Y{(move.axes[1].max-move.axes[1].min)/2} F3000 ; move probe to center of bed
G1 F600
G30                    	; home Z by probing the bed
G29 S1					; load heightmap
