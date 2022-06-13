if {param.D == 0}
	M291 R"Attention!" P"Filament Sensor Raised An Error On E0" S1								; message
	M25
elif {param.D == 1}
	M291 R"Attention!" P"Filament Sensor Raised An Error On E1" S1								; message
	M25