M98 P"config_probe.g"        ; insure probe is using most recent configuration values
G28 						 ; home all
G29 S2                       ; cancel mesh bed compensation
M290 R0 S0                   ; cancel baby stepping

G90                          ; absolute moves
G1 Z5 F99999                 ; insure Z starting position is high enough to avoid probing errors
G1 X{(move.axes[0].max-move.axes[0].min)/2} Y{(move.axes[1].max-move.axes[1].min)/2} 	; move probe to center of bed
G30                          ; do single probe which sets Z to trigger height of Z probe

G29 S0                       ; probe bed and create height map