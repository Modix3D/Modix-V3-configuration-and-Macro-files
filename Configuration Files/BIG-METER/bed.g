; bed.g
; called to perform automatic bed compensation via G32
;
;M561 ; clear any bed transform
;G29  ; probe the bed and enable compensation


M291 S1 T46 R"Function disabled" P"For performing bed compensation, please navigate to the ""Macros"" tab"