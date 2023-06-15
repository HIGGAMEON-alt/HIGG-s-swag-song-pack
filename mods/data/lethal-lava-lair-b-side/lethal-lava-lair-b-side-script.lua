local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	if isStoryMode and not getPropertyFromClass("PlayState", "seenCutscene") and week ~= "funkMix" and week ~= "funkMixDX" then
		addLuaScript("scripts/extra/menus/Cutscene")
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by Jatotz")
end

function onUpdate()
	if not funkMixCam() then
		if curBeat >= 28 and curBeat < 30 then
			cameraSetTarget("boyfriend")
		end
	end
end

function onBeatHit()
	if not funkMixCam() then
		if curBeat == 14 or curBeat == 15 or curBeat == 30 then
			cameraSetTarget("dad")
		elseif curBeat == 64 then
			setProperty("defaultCamZoom", 2)
		elseif curBeat == 96 then
			setProperty("defaultCamZoom", 1.45)
		elseif curBeat == 128 then
			setProperty("defaultCamZoom", 1.75)
		elseif curBeat == 142 or curBeat == 143 then
			cameraSetTarget("boyfriend")
		elseif curBeat == 160 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1 + 1/3 + 0.001)
		elseif curBeat == 192 then
			setProperty("defaultCamZoom", 1)
		elseif curBeat == 223 then
			triggerEvent("Camera Follow Pos", "", "")
		elseif curBeat == 224 then
			setProperty("defaultCamZoom", 2)
		elseif curBeat == 256 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1)
		elseif curBeat == 287 then
			triggerEvent("Camera Follow Pos", "", "")
		elseif curBeat == 288 then
			setProperty("defaultCamZoom", 1.45)
		elseif curBeat == 320 then
			setProperty("defaultCamZoom", 2.5)
		end
	end
end


function onEndSong()
	setDataFromSave("songSaveData", "sceneNum", 6)
	if isStoryMode and week ~= "funkMix" and week ~= "funkMixDX" and getPropertyFromClass("PlayState", "seenCutscene") then
		setPropertyFromClass("PlayState", "seenCutscene", false)
		return Function_Stop
	end
	return Function_Continue
end