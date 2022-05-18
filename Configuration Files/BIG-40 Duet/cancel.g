; called when a print is cancelled after a pause.
G10 P0 R0 S0	; set temperatures to 0
G10 P1 R0 S0	; set temperatures to 0
M106 S0			; set fans to 0
T-1 P0			; deselect any tools
M290 R0 S0 		; clear babystepping 
G29 S2			; cancel mesh bed compensation
M84				; disable the X, Y and E0:1 stepper motors 