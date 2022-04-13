M280 P7 S60
G28 X Y 			; home X and Y, hope that Z hasn't moved
M116 				; wait for temperatures
M83 				; relative extrusion
G1 E4 F800 			; undo the retraction that was done in the M911 power fail script
M300 S1111 P222		; beep