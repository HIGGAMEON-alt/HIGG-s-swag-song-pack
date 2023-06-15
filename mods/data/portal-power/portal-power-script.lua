local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	if not funkMixCam() then
		triggerEvent("Camera Follow Pos", xx, yy)
		setProperty("defaultCamZoom", 1 + 1/3 + 0.001)
		setProperty("camGame.zoom", 1 + 1/3 + 0.001)
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by fluffyhairs")
end

function onBeatHit()
	if not funkMixCam() then
		if curBeat == 15 then
			triggerEvent("Camera Follow Pos", "", "")
		elseif curBeat == 16 then
			setProperty("defaultCamZoom", 2.5)
		elseif curBeat == 48 then
			setProperty("defaultCamZoom", 1.5)
		elseif curBeat == 80 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1)
		elseif curBeat == 112 then
			setProperty("defaultCamZoom", 1.5)
		elseif curBeat == 143 then
			triggerEvent("Camera Follow Pos", "", "")
		elseif curBeat == 144 then
			setProperty("defaultCamZoom", 2)
		elseif curBeat == 176 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1.75)
		elseif curBeat == 208 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1 + 1/3 + 0.001)
		end
	end
end	