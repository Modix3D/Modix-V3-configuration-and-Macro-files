if {param.D ^ ""} = "0"
	if sensors.filamentMonitors[0].status = "sensorError"
		echo "SensorError-0 Continuing to Print"
		M99
	if sensors.filamentMonitors[0].status = "noDataReceived"
		echo "No data received on E0 Continuing to Print - Check configuration and wiring"
		M99
	echo "No filament or possible clog on E0 - Paused"
	M291 p"Filament Sensor 0 - No filament or movement error" S1
	M25 ;pause the print

if {param.D ^ ""} = "1"
	if sensors.filamentMonitors[1].status = "sensorError"
		echo "SensorError-1 Continuing to Print"
		M99
	if sensors.filamentMonitors[1].status = "noDataReceived"
		echo "No data received on E1 Continuing to Print - Check configuration and wiring"
		M99
	echo "No filament or possible clog on E1"
	M291 p"Filament Sensor 1 - No filament or movement error" S1
	M25 ;pause the print
M99