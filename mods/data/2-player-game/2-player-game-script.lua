local xx = 160 * 3
local yy = 81 * 3
local mamaLuigi = false

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	setDataFromSave("songSaveData", "powerupNotes", false)
end

function onUpdatePost()
	if getDataFromSave("playerSettings", "stageView") == true and week ~= "funkMix" and week ~= "funkMixDX" then
		triggerEvent("Camera Follow Pos",xx,yy)
		setProperty("camGame.zoom", 0.75)
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by KrystalPhantasm")
end

function onStepHit()
	-- Cloud Dance
	if week ~= "funkMix" and week ~= "funkMixDX" then
		if curStep == 1 or curStep == 636 then
			playAnim("platformAnim", "dancePrep", true)
			updateHitbox("platformAnim")
		end
	end
end

function onBeatHit()
	-- Time Skip Support
	if curBeat >= 176 and mamaLuigi == false then
		mamaLuigi = true
		doTweenY("goWeegee", "bonus", -44 * 6, 2, "quadOut")
	end

	if not funkMixCam() then
		if curBeat == 176 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1)
		elseif curBeat == 208 then
			setProperty("defaultCamZoom", 1 + 1/3 + 0.001) 
		end
	end

	-- Cloud Dance
	if week ~= "funkMix" and week ~= "funkMixDX" then
		if curBeat > 0 and curBeat < 144 or curBeat >= 160 and curBeat < 208 then
			playAnim("platformAnim", "dance", true)
			updateHitbox("platformAnim")
		elseif curBeat >= 144 and curBeat < 160 then
			playAnim("platformAnim", "idle", true)
			updateHitbox("platformAnim")
		elseif curBeat >= 208 then
			setProperty("platformAnim.visible", false)
		end
	end
end

function onDestroy()
	setDataFromSave("songSaveData", "powerupNotes", true)
end