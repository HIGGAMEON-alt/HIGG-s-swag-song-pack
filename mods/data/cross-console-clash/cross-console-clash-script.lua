local xx = 160 * 3
local yy = 81 * 3

local marioBounces = 0
local marioVelocity = 0

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	marioPos = getProperty("boyfriend.y")
	groundPos = getProperty("boyfriend.y")
end

function onCreatePost()
	if not funkMixCam() then
		triggerEvent("Camera Follow Pos", xx, yy)
	end

	setProperty("dad2.x", getProperty("dad.x") - 70 * 6 + 2)
	setProperty("dad2.y", getProperty("dad.y") - 28 * 6)
	setProperty("boyfriend2.x", getProperty("boyfriend.x") + 20 * 6)
	setProperty("boyfriend2.y", getProperty("boyfriend.y") - 36 * 6)
	
	tailsPosX = getProperty("dad2.x") - (80 * 6)
	tailsPosY = getProperty("dad2.y") - (64 * 6)
	tailsTargetX = getProperty("dad2.x")
	tailsTargetY = getProperty("dad2.y")
	
	luigiPosX = getProperty("boyfriend2.x") + (64 * 6)
	luigiPosY = getProperty("boyfriend2.y") - (20 * 6)
	luigiTargetX = getProperty("boyfriend2.x")
	luigiTargetY = getProperty("boyfriend2.y")

	setProperty("dad2.x", math.floor(tailsPosX / 6) * 6)
	setProperty("dad2.y", math.floor(tailsPosY / 6) * 6)
	setProperty("boyfriend2.x", math.floor(luigiPosX / 6) * 6)
	setProperty("boyfriend2.y", math.floor(luigiPosY / 6) * 6)
end

function onCountdownStarted()
	triggerEvent("Intro","","by B.O. Eszett")
	setTextWidth("JukeBoxSubText", 308)
end

function onCountdownTick(tick)
	if tick == 4 then
		if not funkMixCam() then
			triggerEvent("Camera Follow Pos", "", "")
			cameraSetTarget("boyfriend")
		end
	end
end

function onStepHit()
	if curStep == 79.75 * 4 then
		playAnim("dad", "hey")
		setProperty("dad.specialAnim", true)
		setProperty("boyfriend.stunned", true)
	end

	if curStep == 81.5 * 4 then
		playAnim("boyfriend", "hey", true)
		setProperty("boyfriend.specialAnim", true)
	end

	if curStep == 83.75 * 4 then
		setProperty("boyfriend.stunned", false)
	end
end

function onBeatHit()
	if not funkMixCam() then
		if curBeat == 29 or curBeat == 82 then
			cameraSetTarget("boyfriend")
		elseif curBeat == 42 or curBeat == 45 then
			cameraSetTarget("dad")
		elseif curBeat == 30 or curBeat == 46 or curBeat == 140 then
			triggerEvent("Camera Follow Pos", xx, yy)
		elseif curBeat == 148 then
			setProperty("defaultCamZoom", 1.35)
		elseif curBeat == 31 or curBeat == 47 or curBeat == 163 then
			triggerEvent("Camera Follow Pos", "", "")
		elseif curBeat >= 164 then
			setProperty("defaultCamZoom", 1.5)
		end
	end
	
	if curBeat == 150 then
		setProperty("boyfriend.stunned", true)
	end

	if curBeat == 151 then
		marioBounces = 2
		marioVelocity = -800
		playAnim("boyfriend", "jump", true)
		setProperty("boyfriend.flipX", true)
	end
	
	if curBeat == 152 then
		playAnim("dad", "wave", true)
		setProperty("dad.stunned", true)
	end

	if curBeat == 154 then
		setProperty("boyfriend.flipX", false)
	end

	if curBeat == 156 then
		playAnim("dad2", "fly", true)
		updateHitbox("dad2")
		doTweenX("tailsPosX", "dad2", tailsTargetX - 16, 1.1, "quadOut")
		doTweenY("tailsPosY", "dad2", tailsTargetY, 1.1, "quadOut") -- tailsLanded
	end

	if curBeat == 162 then
		playAnim("boyfriend2", "jump", true)
		updateHitbox("boyfriend2")
		doTweenX("luigiPosX", "boyfriend2", luigiTargetX, 0.5, "quintOut")
		doTweenY("luigiPosY", "boyfriend2", luigiTargetY, 0.3, "sineIn") -- luigiArrived
	end

	if curBeat % 2 == 0 and getProperty("boyfriend.animation.curAnim.name") == "idle" then
		characterDance("boyfriend")
	end
end

function onTweenCompleted(tag)
	if tag == "luigiPosY" then
		playAnim("boyfriend2", "idle", true)
		updateHitbox("boyfriend2")
	end
	if tag == "tailsPosX" or tag == "tailsPosY" then
		setProperty("dad.stunned", false)
		playAnim("dad2", "skid", true)
		updateHitbox("dad2")
		doTweenX("tailsArrived", "dad2", tailsTargetX, 0.3, "sineOut")
	elseif tag == "tailsArrived" then
		playAnim("dad2", "idle", true)
		updateHitbox("dad2")
	end
end

function onUpdate(elapsed)
	if marioBounces > 0 then
		if marioPos > groundPos then
			marioBounces = marioBounces - 1
			playAnim("boyfriend", "jump", true)
			if marioBounces > 0 then
				marioPos = groundPos - 6
				marioVelocity = -800
			else
				marioPos = groundPos
				marioVelocity = 0
				playAnim("boyfriend", "idle")
				setProperty("boyfriend.stunned", false)
			end
		end

		marioVelocity = marioVelocity + 6000 * elapsed
		marioPos = marioPos + marioVelocity * elapsed
	end
	if not inGameOver then
		setProperty("boyfriend.y", math.floor(marioPos / 6) * 6)
	end
	setProperty("dad2.x", math.floor(getProperty("dad2.x") / 6) * 6)
	setProperty("dad2.y", math.floor(getProperty("dad2.y") / 6) * 6)
	setProperty("boyfriend2.x", math.floor(getProperty("boyfriend2.x") / 6) * 6)
	setProperty("boyfriend2.y", math.floor(getProperty("boyfriend2.y") / 6) * 6)
end

function onUpdatePost()
	if getDataFromSave("playerSettings", "stageView") == true and week ~= "funkMix" and week ~= "funkMixDX" then
		setProperty("camGame.zoom", 1)
	end

	if getProperty("dad.animation.curAnim.name") == "hey" and getProperty("dad.animation.curAnim.finished") then
		playAnim("dad", "loop", true)
		setProperty("dad.specialAnim", true)
	end

	if getProperty("dad.animation.curAnim.name") == "loop" then
		playAnim("dad", "loop")
		setProperty("dad.specialAnim", true)
	end

	if getProperty("boyfriend.animation.curAnim.name") == "hey" then
		if getProperty("boyfriend.animation.curAnim.curFrame") == getProperty("boyfriend.animation.curAnim.numFrames") - 1 then
			setProperty("boyfriend.animation.curAnim.paused", true)
		end
	end

	if getProperty("boyfriend.animation.curAnim.name") == "jump" then
		playAnim("boyfriend", "jump", true)
		setProperty("boyfriend.specialAnim", true)
	end
end