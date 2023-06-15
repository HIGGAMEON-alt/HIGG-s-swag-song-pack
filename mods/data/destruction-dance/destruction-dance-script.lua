local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	addCharacterToList("waluigi", "dad")

	targetY = getProperty("dad.y")
	dadVelocity = 0
	dadPos = getProperty("dad.y")
	spikeDead = false
	originalY = getProperty("dad.y")

	waluigiTime = false
	
	bfDeathVelocity = 0
	fakeDeath = false
end

function onCountdownStarted()
	triggerEvent("Intro","","by Nimbus Cumulus")
end

function onStepHit()
	if not funkMixCam() then
		if curStep == 56 then
			setProperty("defaultCamZoom", 2)
		elseif curStep == 172 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1.5)
		elseif curStep == 188 then
			triggerEvent("Camera Follow Pos", "", "")
		elseif curStep == 448 then
			setProperty("defaultCamZoom", 2)
		elseif curStep == 568 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1.25)
		elseif curStep == 576 then
			setProperty("defaultCamZoom", 0.75)
		elseif curStep == 696 then
			setProperty("defaultCamZoom", 1.5)
		elseif curStep == 700 then
			triggerEvent("Camera Follow Pos", "", "")
		elseif curStep == 704 then
			setProperty("defaultCamZoom", 2)
		elseif curStep == 952 then
			triggerEvent("Camera Follow Pos", xx, yy)
			setProperty("defaultCamZoom", 1.25)
		elseif curStep == 960 then
			setProperty("defaultCamZoom", 0.75)
		elseif curStep == 1088 then
			setProperty("defaultCamZoom", 1.5)
		end
	end
end

function onBeatHit()
	if curBeat == 164 then
		spikeDead = true
		setProperty("dad.specialAnim", true)
		playAnim("dad", "death", true)
		dadVelocity = -750
		dadPos = getProperty("dad.y")
		playAnim("bomb", "boom", true)
		updateHitbox("bomb")
	elseif curBeat == 175 then
		spikeDead = false

		targetY = originalY + 56;
		triggerEvent("Change Character", "dad", "waluigi")
		setProperty("dad.x", getProperty("dad.x") + 5 - 1)
		setProperty("dad.y", -128)
		dadPos = getProperty("dad.y")
		playAnim("dad", "singDOWN", true)
		waluigiTime = true
	elseif curBeat == 274 then
		makeLuaSprite("bfDeathFake", "characters/bf-dead", getProperty("boyfriend.x") - (12 * 6) + 1, getProperty("boyfriend.y") - (12 * 6) + 1)
		scaleObject("bfDeathFake", 6, 6)
		setProperty("bfDeathFake.antialiasing", false)
		bfDeathPos = getProperty("bfDeathFake")
		addLuaSprite("bfDeathFake", false)

		setProperty("boyfriend.visible", false)
		fakeDeath = true
		setProperty("boyfriend.stunned", true)
		bfDeathVelocity = -750
		bfDeathPos = getProperty("bfDeathFake.y")

		playAnim("bomb2", "boom", true)
		updateHitbox("bomb2")
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if spikeDead then
			playAnim("dad", "death", true)
			setProperty("dad.specialAnim", true)
		elseif waluigiTime then
			playAnim("dad", "singDOWN", true)
			setProperty("dad.specialAnim", true)
		end

		if targetY > 0 and getProperty("dad.y") < targetY then
			dadPos = dadPos + 4000 * elapsed
			setProperty("dad.y", math.floor(dadPos / 6) * 6)
			
			if dadPos >= targetY then
				dadPos = targetY
				waluigiTime = false
				setProperty("dad.y", targetY)
				playAnim("dad", "idle", true)
				targetY = 0
			end
		end

		if spikeDead and getProperty("dad.y") < 128 * 6 then
			dadVelocity = dadVelocity + (12.5 * 130 * elapsed)

			dadPos = dadPos + dadVelocity * elapsed
			setProperty("dad.y", math.floor(dadPos / 6) * 6)

			if getProperty("dad.y") > 128 * 6 then
				spikeDead = false
			end
		end

		if fakeDeath and getProperty("boyfriend.y") < 128 * 6 then
			bfDeathVelocity = bfDeathVelocity + (12.5 * 130 * elapsed)

			bfDeathPos = bfDeathPos + bfDeathVelocity * elapsed
			setProperty("bfDeathFake.y", math.floor(bfDeathPos / 6) * 6)
			setProperty("boyfriend.visible", false)
		end
	end
end