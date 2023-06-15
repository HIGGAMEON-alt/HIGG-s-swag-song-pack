local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	addCharacterToList("mario-hammer", "dad")
end

function onCountdownStarted()
	triggerEvent("Intro","HAMMERED","by fire_mario_fan ft. joker and friedfrick\nremix by kirbykid johnson")
	setProperty("JukeBoxTag.color", 0x00000000)
end

function onUpdatePost()
	if dadName == "mario-transformer" then
		if getProperty("dad.animation.curAnim.name") == "hammered" and getProperty("dad.animation.curAnim.curFrame") == getProperty("dad.animation.curAnim.numFrames") - 1 then
			triggerEvent("Change Character", "dad", "mario-hammer")
		end
	end

	if curBeat >= 8 and dadName ~= "mario-hammer" then
		triggerEvent("Change Character", "dad", "mario-hammer")
	end
end

function onStepHit()
	if curStep == 21 then
		playAnim("dad", "hammered")
		setProperty("dad.specialAnim", true)
	end
	if curStep == 271 then
		playAnim("dad", "hey")
		setProperty("dad.specialAnim", true)
	end

	if not funkMixCam() then
	end
end

function onBeatHit()
	if curBeat == 72 then
		doTweenY("skyIn", "sky", -200*6, 2, "circOut")
		doTweenY("bgIn", "background", -200*6, 2, "circOut")
		doTweenY("cloudIntroOut", "cloudsIntro", -200*12, 2, "circIn")
		doTweenY("cloudAIn", "cloudsA", -200*6, 2, "circOut")
		doTweenY("cloudBIn", "cloudsB", -200*6+16*6, 2, "circOut")
	elseif curBeat == 264 then
		doTweenAlpha("altSky", "skyAlt", 1, 2, "linear")
		doTweenY("cloudAOut", "cloudsA", -200*12, 2, "circIn")
		doTweenY("cloudBOut", "cloudsB", -200*12, 2, "circIn")
	elseif curBeat == 294 then
		doTweenY("logoIn", "logo", -200*6+32*6, 3, "bounceOut")
	elseif curBeat == 525 then
		doTweenY("curtainCall", "curtains", -67*6, 0.45, "linear")
	end

	if not funkMixCam() then	
	end
end

function onTweenCompleted(tag)
	if tag == "skyIn" then
		removeLuaSprite("skyIntro", true)
		removeLuaSprite("cloudsIntro", true)
	end

	if tag == "altSky" then
		removeLuaSprite("cloudsA", true)
		removeLuaSprite("cloudsB", true)
		removeLuaSprite("cloudsB2", true)
		removeLuaSprite("cloudsB3", true)
	end
end