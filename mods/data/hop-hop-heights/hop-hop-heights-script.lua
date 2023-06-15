local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	addCharacterToList("bob-omb-lit", "dad")
	if isStoryMode and not getPropertyFromClass("PlayState", "seenCutscene") and week ~= "funkMix" and week ~= "funkMixDX" then
		addLuaScript("scripts/extra/menus/Cutscene")
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by KrystalPhantasm")
end

function onUpdate()
	if curBeat >= 192 and not funkMixCam() then
		cameraSetTarget("dad")
	end
end

function onBeatHit()
	if curBeat == 96 then
		triggerEvent("Change Character", "dad", "bob-omb-lit")
	elseif curBeat == 198 then
		playAnim("dad", "explode", true)
		setProperty("dad.specialAnim", true)
		setProperty("dad.y", getProperty("dad.y") + (3 * 6))
	end

	if not funkMixCam() then
		if curBeat == 32 then
			setProperty("defaultCamZoom", 1)
		elseif curBeat == 96 then
			setProperty("defaultCamZoom", 2)
		elseif curBeat == 128 then
			setProperty("defaultCamZoom", 1.5)
		elseif curBeat == 160 then
			triggerEvent("Camera Follow Pos",xx,yy)
			setProperty("defaultCamZoom", 0.75)
		elseif curBeat == 191 then
			triggerEvent("Camera Follow Pos","","")
		elseif curBeat == 192 then
			setProperty("defaultCamZoom", 1)
		elseif curBeat == 193 then
			setProperty("defaultCamZoom", 1 + (1/3))
		elseif curBeat == 194 then
			setProperty("defaultCamZoom", 1 + (2/3))
		elseif curBeat == 195 then
			setProperty("defaultCamZoom", 2)
		end
	end
end

function onEndSong()
	if isStoryMode and not inGameOver then
		setDataFromSave("songSaveData", "sceneNum", 5)
	end
end