local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCountdownStarted()
	triggerEvent("Intro","","by Polynine")
end

function onUpdatePost()
	if not funkMixCam() then
		if mustHitSection then
			cameraSetTarget("boyfriend")
		else
			cameraSetTarget("dad")
		end
	end
end