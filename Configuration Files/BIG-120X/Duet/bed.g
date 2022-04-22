M291 S3 R"Tilt calibration" P"Press OK to continue, or CANCEL to abort"

M98 P"config_probe.g"   		; insure probe is using most recent configuration values

G28 			; home all
G29 S2			; cancel mesh bed compensation
M290 R0 S0		; cancel baby stepping

G90				; absolute moves
G1 Z5 F99999	; insure Z starting position is high enough to avoid probing errors
G1 X{(move.axes[0].max-move.axes[0].min)/2} Y{(move.axes[1].max-move.axes[1].min)/2} F6000 	; move probe to center of bed
G30 			; do single probe which sets Z to trigger height of Z probe

M564 H0 S0      ; movements outside print area are allowed

G91 			; relative moves
G1 Z10 F200		; Raise nozzle 10mm
G90 			; absolute movements
M300 S666 P666 	; beep

M291 S2 R"Centre reference point" P"Place a bracket under the nozzle and adjust the Z height until slight friction can be noticed" Z1 

M300 S666 P666 	; beep
M291 S2 R"Please remove the bracket" P"Press OK only after the bracket has been removed" 

G91 			; relative moves
G1 Z10 F200		; Raise nozzle 10mm
G90 			; absolute movements
M300 S666 P666 	; beep
 
G1 X{(move.axes[0].min-move.axes[0].min)+5} Y{(move.axes[1].min-move.axes[1].min)+5} F6000 ; Front left

G91 			; relative moves
G1 Z-10 F200	; lower nozzle 10mm
G90 			; absolute movements
M18 Z 			; disable Z stepper motors

M291 S2 R"Front-Left corner" P"Place the bracket and adjust the Z height by manually rotating the ball screw until slight friction can be noticed" ; 
M300 S666 P666 ; 
M291 S2 R"Please remove the bracket" P"Press OK only after the bracket has been removed"  ;

G91 			; relative moves
G1 Z10 F200		; Raise nozzle 10mm
G90 			; absolute movements
M300 S666 P666 	; beep

G1 X{(move.axes[0].max-move.axes[0].min)-5} Y{(move.axes[1].min-move.axes[1].min)+5} F6000 ; Front right

G91 			; relative moves
G1 Z-10 F200	; lower nozzle 10mm
G90 			; absolute movements
M18 Z 			; disable Z stepper motors

M291 S2 R"Front-Right corner" P"Place the bracket and adjust the Z height by manually rotating the ball screw until slight friction can be noticed" ;
M300 S666 P666 ; 
M291 S2 R"Please remove the bracket" P"Press OK only after the bracket has been removed"  ;

G91 			; relative moves
G1 Z10 F200		; Raise nozzle 10mm
G90 			; absolute movements
M300 S666 P666 	; beep
G1 X{(move.axes[0].max-move.axes[0].min)-5} Y{(move.axes[1].max-move.axes[1].min)-5} F6000 ; rear right

G91 			; relative moves
G1 Z-10 F200	; lower nozzle 10mm
G90 			; absolute movements
M18 Z 			; disable Z stepper motors

M291 S2 R"Rear-Right corner" P"Place the bracket and adjust the Z height by manually rotating the ball screw until slight friction can be noticed" ; 
M300 S666 P666 ; 
M291 S2 R"Please remove the bracket" P"Press OK only after the bracket has been removed"  ;

G91 			; relative moves
G1 Z10 F200		; Raise nozzle 10mm
G90 			; absolute movements
M300 S666 P666 	; beep
G1 X{(move.axes[0].min-move.axes[0].min)+5} Y{(move.axes[1].max-move.axes[1].min)-5} F6000 ; rear right

G91 			; relative moves
G1 Z-10 F200	; lower nozzle 10mm
G90 			; absolute movements
M18 Z 			; disable Z stepper motors

M291 S2 R"Rear-Left" P"Place the bracket and adjust the Z height by manually rotating the ball screw until slight friction can be noticed" ;


M300 S666 P666 	; beep
M291 S2 R"Please remove the bracket" P"Press OK only after the bracket has been removed"  
M300 S666 P666 	; beep
M564 S1 H1     	; Negative movements are forbidden
M291 S2 R"Tilt calibration has been completed" P"You may proceed to the next step"