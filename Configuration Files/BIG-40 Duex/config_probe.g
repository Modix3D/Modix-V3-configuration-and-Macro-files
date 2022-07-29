M558 P9 C"zprobe.in" H5 F120 T6000 A1 R0.7			; BLTouch probing settings
M950 S0 C"duex.pwm5"								; sets the BLTouch probe
M376 H100			                				; Height (mm) over which to taper off the bed compensation
G31 P500 X-14 Y21 									; BLTouch X and Y offset
G31 Z-3												; BLTouch Z offset