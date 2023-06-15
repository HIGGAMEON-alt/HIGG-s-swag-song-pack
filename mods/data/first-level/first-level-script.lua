local xx = 160 * 3
local yy = 80 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCountdownStarted()
	triggerEvent("Intro","first level :)","by B.O. Eszett")
end

function onBeatHit()
	if not funkMixCam() then
		if curBeat == 16 then
			setProperty("defaultCamZoom", 1.25)
		elseif curBeat == 48 then
			setProperty("defaultCamZoom", 1)
		elseif curBeat == 80 or curBeat == 88 or curBeat == 96 or curBeat == 104 then
			setProperty("defaultCamZoom", 1.5)
		elseif curBeat == 112 or curBeat == 120 or curBeat == 128 or curBeat == 136 then
			setProperty("defaultCamZoom", 2)
		elseif curBeat == 144 or curBeat == 152 or curBeat == 160 or curBeat == 168 then
			setProperty("defaultCamZoom", 1.5)
		elseif curBeat == 176 then
			setProperty("defaultCamZoom", 1.25)
		elseif curBeat == 208 then
			triggerEvent("Camera Follow Pos",xx,yy)
			setProperty("defaultCamZoom", 0.75)
		elseif curBeat == 272 then
			setProperty("defaultCamZoom", 1 + (1/3) + 0.001)
		end
	end
end

function onEvent(name, value1, value2)
	if not funkMixCam() and name == "Hey!" and flashingLights then
		setPropertyFromClass("flixel.FlxG", "camera.zoom", getPropertyFromClass("flixel.FlxG", "camera.zoom") + 0.5 --[[0.015]])
		setProperty("camHUD.zoom", getProperty("camHUD.zoom") + 0.125)
		if curBeat > 144 and curBeat < 176 then
			setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.25)
		end
	end
end