function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCountdownStarted()
	triggerEvent("Intro","","by coquers_")
end