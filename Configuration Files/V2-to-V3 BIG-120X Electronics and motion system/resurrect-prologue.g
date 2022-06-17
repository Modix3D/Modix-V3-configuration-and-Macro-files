M280 P0 S60 I1		; clear BLTouch error state
G28 X Y 			; home X and Y, hope that Z hasn't moved
M116 				; wait for temperatures
M83 				; relative extrusion
G1 E4 F800 			; undo the retraction that was done in the M911 power fail script
M300 S1111 P222		; beep