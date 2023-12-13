; homez.g
; called to home the Z axis

M98 P"config_probe.g"									; Load BLTouch probe settings
M280 P0 S60												; clear any probe errors
G29 S2													; cancel mesh bed compensation

G91														; relative positioning
G1 H2 Z5 F200											; lift Z relative to current position
G90														; absolute positioning

G1 X{move.axes[0].min+5} Y{move.axes[1].min+5} F6000 	; move to front left

G1 F600													; slow speed
G30														; home Z by probing the bed
G29 S1													; load heightmap