function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
end

function onCountdownStarted()
	triggerEvent("Intro","","by SuperStamps")
end

function onBeatHit()
end