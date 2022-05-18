M558 P9 C"zprobe.in" H5 F120 T6000 A1 R0.7			; BLTouch probing settings
M950 S0 C"exp.heater3"								; set probe pin
G31 P500 X-13 Y-18                         			; BLTouch X and Y offset from nozzle
G31 Z-3												; set Z probe trigger value and Z-offset
M376 H50			                				; Height (mm) over which to taper off the bed compensation