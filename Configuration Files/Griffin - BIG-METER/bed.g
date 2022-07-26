M98 P"config_probe.g"   											; insure probe is using most recent configuration values
G28 																; home all
G29 S2                       										; cancel mesh bed compensation
M290 R0 S0                   										; cancel baby stepping

G90                          										; absolute moves
G1 Z5 F99999                 										; insure Z starting position is high enough to avoid probing errors
G1 X{move.axes[0].min+2} Y{move.axes[1].min+2} F6000 				; move to front left
G30                          										; do single probe which sets Z to trigger height of Z probe

; --- level bed ---
while true

; run leveling pass
	M280 P0 S60 I1														; clear any probe errors
	G30 P0 X{move.axes[0].min-24.5} Y{move.axes[1].min+27.9} Z-99999	; Probe near front left leadscrew
	M280 P0 S60 I1														; clear any probe errors
	G30 P1 X{move.axes[0].max-26.5} Y{move.axes[1].min+27.9} Z-99999	; Probe near front right leadscrew
	M280 P0 S60 I1														; clear any probe errors
	G30 P2 X{move.axes[0].max-26.5} Y{move.axes[1].max+25.9} Z-99999	; Probe near rear right leadscrew
	M280 P0 S60 I1														; clear any probe errors
	G30 P3 X{move.axes[0].min-24.5} Y{move.axes[1].max+25.9} Z-99999 S4	; Probe near rear right leadscrew

	if move.calibration.initial.deviation < 0.02
		break
	; check pass limit - abort if pass limit reached
	if iterations = 10
		M291 P"Bed Leveling Aborted" R"Pass Limit Reached"
		abort "Bed Leveling Aborted - Pass Limit Reached"

G1 X{move.axes[0].min+2} Y{move.axes[1].min+2} F6000 				; move to front left
G30																	; do single probe which sets Z to trigger height of Z probe
echo "Your bed is within 0.02 mm between the corners. The difference was " ^ move.calibration.initial.deviation ^ "mm. You can proceed to print"