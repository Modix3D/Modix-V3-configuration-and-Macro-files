M558 H15 F80															; This raises the probing height from 4mm to 15mm, to increase the range in which the tilt calibration can adjust the bed. 
M566 Z20																; Reducing the Z jerk a slight bit
M203 Z100																; Reducing max Z speed a bit.
M201 Z60																; Reducing Z acceleration a slight bit
M98 P"config_probe.g"													; Load Z-probe data
T-1																		; deselect any tools

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed	; If the printer hasn't been homed, home it
	G28

G29 S2																	; cancel mesh bed compensation
M290 R0 S0																; cancel baby stepping

G90																		; absolute moves
G1 Z5 F400																; insure Z starting position is high enough to avoid probing errors
G1 X{move.axes[0].min+2} Y{move.axes[1].min+2} F9000					; move to front left
G30																		; do single probe which sets Z to trigger height of Z probe

; --- level bed ---
while true
	G30 P0 X{move.axes[0].min + sensors.probes[0].offsets[0] + 2} Y{move.axes[1].min + sensors.probes[0].offsets[1] + 2} Z-99999	; Probe near front left leadscrew
	G30 P1 X{move.axes[0].max + sensors.probes[0].offsets[0] - 2} Y{move.axes[1].min + sensors.probes[0].offsets[1] + 2} Z-99999	; Probe near front right leadscrew
	G30 P2 X{move.axes[0].max + sensors.probes[0].offsets[0] - 2} Y{move.axes[1].max + sensors.probes[0].offsets[1] - 2} Z-99999	; Probe near rear right leadscrew
	G30 P3 X{move.axes[0].min + sensors.probes[0].offsets[0] + 2} Y{move.axes[1].max + sensors.probes[0].offsets[1] - 2} Z-99999 S4	; Probe near rear left leadscrew
	
	if move.calibration.initial.deviation = 0
		echo "The reported deviation is equal to zero. Verify that the BLTouch tip was able to deploy, and re-run the tilt calibration"
	elif move.calibration.initial.deviation < 0.02
		echo "Your bed is within 0.02 mm between the corners. The difference was " ^ move.calibration.initial.deviation ^ "mm. You can proceed to print"
		break
	; check pass limit - abort if pass limit reached
	if iterations = 10
		M291 P"Bed Leveling Aborted" R"Pass Limit Reached"
		abort "Bed Leveling Aborted - Pass Limit Reached. Re-run the tilt calibration"

G1 X{move.axes[0].min+2} Y{move.axes[1].min+2} Z5 F6000 				; move to front left
M558 H4 																; BLTouch probing settings
M558 F180																; reset BLTouch probing settings to default
M566 Z30																; reset jerk
M203 Z400																; reset max speed
M201 Z240																; reset acceleration
M98 P"config_probe.g"
G30																		; do single probe which sets Z to trigger height of Z probe
if {global.idex} = 1
	M18 XYU																; release XYU stepper motors
else
	M18 XY																; release XY stepper motors