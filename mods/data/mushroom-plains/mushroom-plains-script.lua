local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	setDataFromSave("songSaveData", "sceneNum", 0)
	if isStoryMode and not getPropertyFromClass("PlayState", "seenCutscene") and week ~= "funkMix" and week ~= "funkMixDX" then
		addLuaScript("scripts/extra/menus/Cutscene")
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by KrystalPhantasm")
end

function onBeatHit()
	if not funkMixCam() then
		if curBeat == 48 then
			setProperty("defaultCamZoom", 1)
		elseif curBeat == 112 then
			triggerEvent("Camera Follow Pos",xx,yy)
			setProperty("defaultCamZoom", 1 + (1/3) + 0.001)
		elseif curBeat == 144 then
			setProperty("defaultCamZoom", 0.75)
		elseif curBeat == 176 then
			setProperty("defaultCamZoom", 1 + (1/3) + 0.001)
		end
	end
end

function onEndSong()
	if isStoryMode and not inGameOver then
		setDataFromSave("songSaveData", "sceneNum", 1)
	end
	return Function_Continue
end