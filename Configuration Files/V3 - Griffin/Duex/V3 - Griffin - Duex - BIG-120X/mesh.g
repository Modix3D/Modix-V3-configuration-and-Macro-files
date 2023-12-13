M98 P"config_probe.g"		; Load BLTouch probe settings
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed	; If the printer hasn't been homed, home it
	G28

G29 S2						; cancel mesh bed compensation
M290 R0 S0					; cancel baby stepping

G90							; absolute moves
G1 Z5 F99999				; ensure Z starting position is high enough to avoid probing errors
G1 X{move.axes[0].min+2} Y{move.axes[1].min+2} F6000 	; move to front left
G30							; do single probe which sets Z to trigger height of Z probe

G29 S0						; probe bed and create height map
G28							; home all