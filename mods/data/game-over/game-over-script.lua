function onCreate()
	loadGraphic("border", "borders/pcport")

	precacheImage("gameovers/pcport/bf-die")
	addCharacterToList("false-hero", "dad")
	addCharacterToList("mario-near", "dad")
	addCharacterToList("mx-chase", "dad")
	addCharacterToList("mx-angry", "dad")
	addCharacterToList("mx-big", "dad")

	addCharacterToList("bf-pcport-flip", "boyfriend")
	addCharacterToList("bf-chase", "boyfriend")
	addCharacterToList("bf-wall", "boyfriend")

	if getDataFromSave("playerSettings", "powerUpHP") == true then
		triggerEvent("Powerup Visuals", "bf-pcport-flip", "")
	else
		triggerEvent("Change Character", "bf", "bf-pcport-flip")
	end
	cameraSetTarget("bf")
	if week == "funkMixMX" then
		triggerEvent("Change Character", "dad", "mario-fake-old")
	end
	if getDataFromSave("songSaveData", "lifeCount") == 1 then
		setPropertyFromClass("GameOverSubstate", "characterName", "gameover-pcport")
	end
	if week == "funkMixMX" then
		setProperty("boyfriend.x", getProperty("boyfriend.x") + 12)
		setProperty("dad.x", getProperty("dad.x") + 12)
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by Saster (ft. Kiwiquest)")
end

function onUpdatePost()
	if week ~= "funkMixMX" then
		if curBeat >= 63 and curBeat < 64 and getProperty("dad.animation.curAnim.name") == "idle" then
			setProperty("dad.animation.curAnim.paused", true)
			playAnim("dad", "transition")
			playAnim("bgFake", "trans")
			setProperty("dad.specialAnim", true)
		end
	end
	if getProperty("dad.animation.curAnim.name") == "transition" or getProperty("dad.animation.curAnim.name") == "scream" then
		if getProperty("dad.animation.curAnim.curFrame") == getProperty("dad.animation.curAnim.numFrames") - 1 then
			setProperty("dad.animation.curAnim.paused", true)
			setProperty("bgFake.animation.curAnim.paused", true)
		end
	end
end

function onBeatHit()
	if week ~= "funkMixMX" then
		if curBeat == 64 then
			triggerEvent("Change Character", "dad", "false-hero")
		elseif curBeat == 128 then
			removeLuaSprite("bgFake")
		end
	end
end

function onStepHit()
	if curStep >= 496 and curStep < 507  then
		playAnim("dad", "singUP", true)
		setProperty("dad.specialAnim", true)
	elseif curStep == 507 then
		playAnim("dad", "transition", true)
		setProperty("dad.specialAnim", true)
	elseif curStep == 512 then
		if week == "funkMixMX" then
			triggerEvent("Change Character", "dad", "mario-near-old")
		else
			triggerEvent("Change Character", "dad", "mario-near")
		end
		setProperty("dad.x", getProperty("dad.x") - 0.25)
		setProperty("dad.y", getProperty("dad.y") + 10)
		if week == "funkMixMX" then
			setProperty("dad.x", getProperty("dad.x") + 12)
		end
	elseif curStep == 751 then
		playAnim("dad", "laugh1", true)
		setProperty("dad.specialAnim", true)
	elseif curStep == 757 then
		playAnim("dad", "laugh2", true)
		setProperty("dad.specialAnim", true)
	elseif curStep == 760 then
		playAnim("dad", "laugh3", true)
		setProperty("dad.specialAnim", true)
	elseif curStep == 764 then
		if week ~= "funkMixMX" then
			playAnim("dad", "laugh3", true)
			setProperty("dad.specialAnim", true)
			makeLuaText("oShit", "RUN!", 0,0,0)
			setTextFont("oShit", "smb1.ttf")
			setTextSize("oShit", 8*6)
			setObjectCamera("oShit", "other")
			screenCenter("oShit")
			addLuaText("oShit")
		end
		if lowQuality then
			setProperty("camGame.visible", false)
		end
	elseif curStep == 768 then
		if week ~= "funkMixMX" then
			removeLuaText("oShit")
		end
		triggerEvent("Change Character", "dad", "mx-chase")
		setProperty("dad.x", getProperty("dad.x") - 20*6 - 0.25)
		if getDataFromSave("playerSettings", "powerUpHP") == true then
			triggerEvent("Powerup Visuals", "bf-chase", "")
		else
			triggerEvent("Change Character", "bf", "bf-chase")
		end
		if week == "funkMixMX" then
			setProperty("boyfriend.x", getProperty("boyfriend.x") + 12)
		end
		if lowQuality then
			setProperty("camGame.visible", true)
		end
	elseif curStep == 1399 then
		triggerEvent("Change Character", "dad", "mx-angry")
		setProperty("dad.x", getProperty("dad.x") - 20*6 - 0.25)
		if week == "funkMixMX" then
			setProperty("dad.x", getProperty("dad.x") + 12)
		end
	elseif curStep == 1408 then
		triggerEvent("Change Character", "dad", "mx-chase")
	elseif curStep == 1533 then
		if week == "funkMixMX" then
			triggerEvent("Change Character", "dad", "mx-big-old")
		else
			triggerEvent("Change Character", "dad", "mx-big")
		end
		setProperty("dad.x", 1280 - getProperty("dad.width") + (10 * 6) + 2)
		setProperty("dad.y", 720 - getProperty("dad.height") + (6 * 6))
		if getDataFromSave("playerSettings", "powerUpHP") == true then
			triggerEvent("Powerup Visuals", "bf-wall", "")
		else
			triggerEvent("Change Character", "bf", "bf-wall")
		end
		mxDefObjOrd = getObjectOrder("dadGroup")
		setObjectOrder("dadGroup", getObjectOrder("wall") - 1)
		setProperty("boyfriend.x", getProperty("dad.x"))
		setProperty("boyfriend.y", getProperty("dad.y") + (9 * 6) - 2)
		if getDataFromSave("playerSettings", "powerUpHP") == true then
			triggerEvent("Powerup Visuals", "bf-wall", "")
		end
	elseif curStep == 1784 then
		playAnim("dad", "scream", true)
		setProperty("dad.specialAnim", true)
	elseif curStep == 2034 then
		triggerEvent("Change Character", "dad", "mx-angry")
		setObjectOrder("dadGroup", mxDefObjOrd)
		if getDataFromSave("playerSettings", "powerUpHP") == true then
			triggerEvent("Powerup Visuals", "bf-chase", "")
		else
			triggerEvent("Change Character", "bf", "bf-chase")
		end
	elseif curStep == 2344 then
		setProperty("boyfriend.y", getProperty("boyfriend.y") - 4*6-3)
	end
	if curStep >= 2344 then
		characterDance("boyfriend")
		characterDance("dad")
		setProperty("dad.animation.curAnim.paused", true)
		setProperty("dad.specialAnim", true)
		setProperty("boyfriend.animation.curAnim.paused", true)
		setProperty("boyfriend.specialAnim", true)
	end
end

function onEvent(name, value1, value2)
	if name == "Change Character" and week == "funkMixMX" then
		if value1 == "bf" then
			setProperty("boyfriend.x", getProperty("boyfriend.x") + 12)
		elseif value1 == "dad" then
			setProperty("dad.x", getProperty("dad.x") + 12)
		end
	end
end

function onCustomSubstateCreate(name)
	if name == "funkMixGameOver" and curStep >= 769 and getDataFromSave("playerSettings", "compatMode") ~= true then
		setProperty("redScreen.visible", true)
	end
end

function opponentNoteHit()
	if getDataFromSave("playerSettings", "powerUpHP") == false then
		if difficulty >= 1 then
			if getProperty("health") > 0 and curStep >= 512 and curStep < 640 then
				setProperty("health", getProperty("health") - 0.023 / 4)
			elseif getProperty("health") > 0 and curStep >= 640 and curStep < 768 then
				setProperty("health", getProperty("health") - 0.023 / 2)
			elseif getProperty("health") > 0 and curStep >= 768 then
				setProperty("health", getProperty("health") - 0.023)
			end
		end

		if getProperty("health") <= 0 then
			setProperty("health", 0.001)
		end
	end
	if getProperty("dad.curCharacter") == "mx-big" and flashingLights and difficulty >= 2 then
		triggerEvent("Pixel Cam Shake", "3, 2, 2", "0.025")
	end
end

function onGameOverStart()
	if getDataFromSave("songSaveData", "lifeCount") == 0 and getDataFromSave("playerSettings", "lifeStart") > 0 then
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
			setProperty("boyfriend.x", 0)
		else
			setProperty("boyfriend.x", 560)
		end
		setProperty("boyfriend.y", 371)
		loadGraphic("border", "borders/pcport")
	end
end