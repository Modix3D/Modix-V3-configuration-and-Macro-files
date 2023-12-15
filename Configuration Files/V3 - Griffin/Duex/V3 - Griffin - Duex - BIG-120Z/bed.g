if {global.expansion} = 1
	M98 P"0:/sys/bed_duex.g"
elif {global.expansion} = 0
	M98 P"0:/sys/bed_duet.g"