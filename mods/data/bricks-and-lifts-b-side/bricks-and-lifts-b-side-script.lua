local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onStartCountdown()
	triggerEvent("Intro","","by Jatotz")
end

function onUpdatePost()
	if getDataFromSave("playerSettings", "stageView") == true and week ~= "funkMix" and week ~= "funkMixDX" then
		triggerEvent("Camera Follow Pos",xx,yy)
		setProperty("camGame.zoom", 0.75)
	end
end

function onStepHit()
	if not funkMixCam() then
		if curStep == 414 then
			triggerEvent("Camera Follow Pos",xx,yy)
			setProperty("defaultCamZoom", 0.75)
		elseif curStep == 544 then
			setProperty("defaultCamZoom", 1 + 1/3 + 0.001)
		end
	end
end