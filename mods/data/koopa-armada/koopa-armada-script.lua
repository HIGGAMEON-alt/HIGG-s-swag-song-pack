local roaring = false
local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	if isStoryMode and week ~= "funkMix" and week ~= "funkMixDX" then
		addLuaScript("scripts/extra/menus/Cutscene")
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by B.O. Eszett")
end

function onBeatHit()
	if not funkMixCam() then
		if curBeat == 144 then
			setProperty("defaultCamZoom", 1.5)
		elseif curBeat == 201 then
			cameraSetTarget("boyfriend")
		elseif curBeat == 202 then
			cameraSetTarget("dad")
		elseif curBeat == 204 then
			triggerEvent("Camera Follow Pos", xx, yy)
		elseif curBeat == 206 then
			setProperty("defaultCamZoom", 1.75)
		elseif curBeat == 207 then
			setProperty("defaultCamZoom", 2)
		elseif curBeat == 208 then
			setProperty("defaultCamZoom", 1)
		elseif curBeat == 272 then
			setProperty("defaultCamZoom", 1 + (1/3) + 0.001)
		elseif curBeat == 275 then
			cameraSetTarget("boyfriend")
			setProperty("defaultCamZoom", 1.75)
			triggerEvent("Camera Follow Pos", "", "")
		elseif curBeat == 336 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1 + (1/3) + 0.001)
		elseif curBeat == 352 then
			setProperty("defaultCamZoom", 1)
		end
	end
end

function onStepHit()
	if curStep == 1087 then
		triggerEvent("Hey!", "BF", "2")
		playAnim("dad", "roarStart", true)
		setProperty("dad.specialAnim", true)
		runTimer("readyToRumble", 0.25)
		roaring = true
	elseif curStep == 1120 then
		roaring = false
		setProperty("dad.specialAnim", false)
	end
end

function onUpdate()
	if getProperty("dad.animation.curAnim.name") == "roarStart" and getProperty("dad.animation.curAnim.finished") then
		roaring = true
	end
	if getTextString("isPaused") ~= "true" then
		if roaring then
			playAnim("dad", "roar")
			setProperty("dad.specialAnim", true)
		end
	end
end

function onTimerCompleted(tag)
	if tag == "readyToRumble" then
		triggerEvent("Screen Rumble", "", "")
	end
end

function onEndSong()
	if isStoryMode and week ~= "funkMixDX" and getDataFromSave("songSaveData", "sceneNum") ~= -1 then
		setDataFromSave("songSaveData", "sceneNum", 7)
		return Function_Stop
	elseif isStoryMode and not inGameOver and week == "funkMixDX" then
		setDataFromSave("songSaveData", "sceneNum", 7)
	end
end