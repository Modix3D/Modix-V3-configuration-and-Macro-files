; Printer model______________________________________________________________
global printer_model = "DuetTest" 		; Pick from "big40", "big60", "big120x", "big120z", "big180x", "meter", "big60_v2_to_v3", "big60_v2_to_v3_motionsystem", "big120x_v2_to_v3", "big120x_v2_to_v3_motionsystem"

; board type______________________________________________________________
global board_type = "duet" 			; pick from "duet" or "duex".

;amount of printheads______________________________________________________________
global printhead = 1 				; pick from 1 or 2
global extruder = "aero" 		; pick from "aero" or "griffin"

;printhead settings primary______________________________________________________________
global e0_sensortyp = "thermistor" 		; pick from "thermistor", "pt100" or "pt1000"
global e0_maxtemp = 285 			; Change this temperature 

;printhead settings secondary______________________________________________________________
global e1_sensortyp = "thermistor" 	; pick from "thermistor", "pt100" or "pt1000"
global e1_maxtemp = 285				; change this if you need a higher temperature. 

; extruder E-steps
if {global.extruder} = "griffin"	; do not make changes to this particular line of code.
	global steps_e0axis = 415		; Adjust this number to change the E-steps of the primary extruder
	global steps_e1axis = 415		; Adjust this number to change the E-steps of the secondary extruder
else
	global steps_e0axis = 418.5		; Adjust this number to change the E-steps of the primary extruder
	global steps_e1axis = 418.5 	; Adjust this number to change the E-steps of the secondary extruder

;add-ons setting______________________________________________________________
global filament_sensor_e0 = "regular" 	; pick from "regular", "clog", or "disabled"
global filament_sensor_e1 = "regular" 	; pick from "regular", "clog", or "disabled"
global crash_detector = "disabled" 	; pick from "enabled" or "disabled"
global emergencystop = "disabled" 	; pick from "enabled" or "disabled"

;Griffin settings______________________________________________________________
global errorfix = 0.01				; set the griffin offset