function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	setDataFromSave("songSaveData", "sceneNum", 3)
	if isStoryMode and not getPropertyFromClass("PlayState", "seenCutscene") and week ~= "funkMix" and week ~= "funkMixDX" then
		addLuaScript("scripts/extra/menus/Cutscene")
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by KrystalPhantasm")
end

function onUpdatePost()
	if not funkMixCam() and flashingLights then
		if mustHitSection then
			cameraSetTarget("boyfriend")
		end
	end
end

function onStepHit()
	if not funkMixCam() then
		if curStep == 256 then
			setProperty("defaultCamZoom", 1)
		elseif curStep == 512 then
			setProperty("defaultCamZoom", 2.5)
		elseif curStep == 640 then
			setProperty("defaultCamZoom", 2)
		elseif curStep == 768 then
			setProperty("defaultCamZoom", 1.5)
		elseif curStep == 896 then
			doTweenZoom("dramaticZoom", "camGame", 3, 12, "linear")
		elseif curStep == 1008 then
			cancelTween("dramaticZoom")
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1 + (1/3) + 0.001)
		elseif curStep == 1024 then
			setProperty("defaultCamZoom", 0.75)
		elseif curStep == 1280 then
			setProperty("defaultCamZoom", 1 + (1/3) + 0.001)
		end
	end
end

function onEndSong()
	if isStoryMode and not inGameOver then
		setDataFromSave("songSaveData", "sceneNum", 4)
	end
end