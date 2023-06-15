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
	triggerEvent("Intro","","by KrystalPhantasm")
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

function onEndSong()
	if isStoryMode and not inGameOver then
		setDataFromSave("songSaveData", "sceneNum", 2)
	end
end