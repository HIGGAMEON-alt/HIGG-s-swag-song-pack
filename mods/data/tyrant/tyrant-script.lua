function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	addCharacterToList("emperorM", "dad")
end

function onUpdate()
	if dadName == "mario-transformer" then
		if curStep < 117 then
			setProperty("dad.animation.curAnim.curFrame", 3)
			setProperty("dad.specialAnim", true)
			setProperty("dad.animation.curAnim.paused", true)
		end
	end

	if not funkMixCam() then	
		if (curBeat >= 90 and curBeat < 96) or (curBeat >= 288 and curBeat < 320) then
			cameraSetTarget("dad")
		elseif curStep >= 2182 and curStep < 2188 then
			cameraSetTarget("boyfriend")
		elseif curStep >= 2188 then
			triggerEvent("Camera Follow Pos", "500", "240")
		end
	end
end

function onUpdatePost()
	if dadName == "mario-transformer" then
		if getProperty("dad.animation.curAnim.name") == "tyrant" then
			if getProperty("dad.animation.curAnim.curFrame") >= 11 then
				setProperty("skyIntro.visible", true)
				setProperty("cloudsIntro.visible", true)
				setProperty("ground.visible", true)
			elseif getProperty("dad.animation.curAnim.curFrame") == getProperty("dad.animation.curAnim.numFrames") - 1 then
				triggerEvent("Change Character", "dad", "emperorM")
			end
		end
	end

	if curBeat >= 31 and dadName ~= "emperorM" then
		triggerEvent("Change Character", "dad", "emperorM")
		loadGraphic("skyIntro", "backgrounds/blocks/skyT")
		loadGraphic("cloudsIntro", "backgrounds/blocks/cloudsT")
		loadGraphic("ground", "backgrounds/blocks/groundT")
	end
end

function onStepHit()
	if curStep == 117 then
		playAnim("dad", "tyrant")
		setProperty("dad.specialAnim", true)
	end

	if not funkMixCam() then
		if curStep == 384 then
			setProperty("defaultCamZoom", 0.7)
		elseif curStep == 1024 then
			setProperty("defaultCamZoom", 1.5)
		elseif curStep == 1280 then
			setProperty("defaultCamZoom", 0.7)
		elseif curStep == 2060 then
			setProperty("defaultCamZoom", 1.5)
		elseif curStep == 2064 then
			setProperty("defaultCamZoom", 0.7)
		elseif curStep == 2076 then
			setProperty("defaultCamZoom", 1)
		elseif curStep == 2078 then
			setProperty("defaultCamZoom", 1.5)
		elseif curStep == 2080 then
			setProperty("defaultCamZoom", 0.7)
		elseif curStep == 2124 then
			setProperty("defaultCamZoom", 1.5)
		elseif curStep == 2128 then
			setProperty("defaultCamZoom", 0.7)
		elseif curStep == 2140 then
			setProperty("defaultCamZoom", 1)
		elseif curStep == 2142 then
			setProperty("defaultCamZoom", 1.5)
		elseif curStep == 2144 then
			setProperty("defaultCamZoom", 0.7)
		elseif curStep == 2176 then
			setProperty("defaultCamZoom", 1.5)
		elseif curStep == 2192 then
			setProperty("defaultCamZoom", 1)
		end
	end
end

function onBeatHit()
	if curBeat == 29 then
		setProperty("skyIntro.visible", false)
		setProperty("cloudsIntro.visible", false)
		setProperty("ground.visible", false)
		loadGraphic("skyIntro", "backgrounds/blocks/skyT")
		loadGraphic("cloudsIntro", "backgrounds/blocks/cloudsT")
		loadGraphic("ground", "backgrounds/blocks/groundT")
	elseif curBeat == 32 then
		triggerEvent("Intro","TYRANT","by fire_mario_fan ft. joker and friedfrick")
		setProperty("JukeBoxTag.color", 0x00000000)
	elseif curBeat == 92 then
		playAnim("dad", "hey")
		setProperty("dad.specialAnim", true)
	elseif curBeat == 288 then
		playAnim("dad", "read")
		setProperty("dad.specialAnim", true)
	elseif curBeat == 549 then
		doTweenY("curtainCall", "curtains", -67*6, 0.45, "linear")
	end
end

function onTweenCompleted(tag)
	if tag == "outOfContext" then
		removeLuaSprite("contextBlack", true)
		removeLuaSprite("letter", true)
		removeLuaText("conTxtA")
		removeLuaText("conTxtB")
	end
end