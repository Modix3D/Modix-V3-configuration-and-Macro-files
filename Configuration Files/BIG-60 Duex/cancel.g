; called when a print is cancelled after a pause.
M568 P0 R0 S0	; set primary hotend temperatures to 0
M568 P1 R0 S0	; set secondary hotend temperatures to 0
M106 S0			; set fans to 0
T-1 P0			; deselect any tools
M290 R0 S0 		; clear babystepping 
G29 S2			; cancel mesh bed compensation
M84 			; disable the stepper motors 