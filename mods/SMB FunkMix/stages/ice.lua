cloudsBackPos = 0
cloudsFrontPos = 0
billDelay = 0
flipped = 0
flipped2 = 41 * 6
terrainPosX = 0
terrainPosY = flipped2
tweeningBF = false
tweeningDad = false
toBeFlipped = false
billTween = false

function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")
	if flashingLights then
		moveMult = 1
	else
	 	moveMult = 0.5
	end

	makeLuaSprite("sky", "backgrounds/ice/sky", -160 * 3, -81 * 3)
	setScrollFactor("sky", 1, 1)
	setProperty("sky.antialiasing", false)
	scaleObject("sky", 6, 6)
	addLuaSprite("sky", false)

	if not lowQuality then
		makeLuaSprite("cloudsBack", "backgrounds/ice/clouds1", 0, 0)
		setScrollFactor("cloudsBack", 1, 1)
		setProperty("cloudsBack.antialiasing", false)
		scaleObject("cloudsBack", 6, 6)
		addLuaSprite("cloudsBack", false)
		makeLuaSprite("cloudsBack2", "backgrounds/ice/clouds1", 0, 0)
		setScrollFactor("cloudsBack2", 1, 1)
		setProperty("cloudsBack2.antialiasing", false)
		scaleObject("cloudsBack2", 6, 6)
		addLuaSprite("cloudsBack2", false)
		makeLuaSprite("cloudsBack3", "backgrounds/ice/clouds1", 0, 0)
		setScrollFactor("cloudsBack3", 1, 1)
		setProperty("cloudsBack3.antialiasing", false)
		scaleObject("cloudsBack3", 6, 6)
		addLuaSprite("cloudsBack3", false)
	end

	makeLuaSprite("cloudsFront", "backgrounds/ice/clouds2", 0, 0)
	setScrollFactor("cloudsFront", 1, 1)
	setProperty("cloudsFront.antialiasing", false)
	scaleObject("cloudsFront", 6, 6)
	addLuaSprite("cloudsFront", false)
	makeLuaSprite("cloudsFront2", "backgrounds/ice/clouds2", 0, 0)
	setScrollFactor("cloudsFront2", 1, 1)
	setProperty("cloudsFront2.antialiasing", false)
	scaleObject("cloudsFront2", 6, 6)
	addLuaSprite("cloudsFront2", false)
	makeLuaSprite("cloudsFront3", "backgrounds/ice/clouds2", 0, 0)
	setScrollFactor("cloudsFront2", 1, 1)
	setProperty("cloudsFront3.antialiasing", false)
	scaleObject("cloudsFront3", 6, 6)
	addLuaSprite("cloudsFront3", false)

	makeAnimatedLuaSprite("terrain", "backgrounds/ice/terrain", 0, 0)
	addAnimationByPrefix("terrain", "idle", "idle0", 0, false)
	setScrollFactor("terrain", 1, 1)
	setProperty("terrain.antialiasing", false)
	scaleObject("terrain", 6, 6)
	addLuaSprite("terrain", false)
	makeAnimatedLuaSprite("terrain2", "backgrounds/ice/terrain2", 0, getProperty("terrain.y") + getProperty("terrain.height"))
	addAnimationByPrefix("terrain2", "idle", "idle0", 0, false)
	setScrollFactor("terrain2", 1, 1)
	setProperty("terrain2.antialiasing", false)
	scaleObject("terrain2", 6, 6)
	addLuaSprite("terrain2", false)
end

function onCreatePost()
	ogDadY = getProperty("dad.y")
	ogBfY = getProperty("boyfriend.y")
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if not lowQuality then
			cloudsBackPos = cloudsBackPos - 180 * elapsed * moveMult
			if cloudsBackPos + getProperty("cloudsBack.width") <= 0 then
				cloudsBackPos = 0
			end
			setProperty("cloudsBack.x", math.floor(cloudsBackPos / 6) * 6)
			setProperty("cloudsBack2.x", getProperty("cloudsBack.x") + getProperty("cloudsBack.width"))
			setProperty("cloudsBack3.x", getProperty("cloudsBack.x") - getProperty("cloudsBack.width"))
		end

		cloudsFrontPos = cloudsFrontPos - 540 * elapsed * moveMult
		if cloudsFrontPos + getProperty("cloudsFront.width") <= 0 then
			cloudsFrontPos = 0
		end
		setProperty("cloudsFront.x", math.floor(cloudsFrontPos / 6) * 6)
		setProperty("cloudsFront2.x", getProperty("cloudsFront.x") + getProperty("cloudsFront.width"))
		setProperty("cloudsFront3.x", getProperty("cloudsFront.x") - getProperty("cloudsFront.width"))

		terrainPosX = terrainPosX - 1440 * elapsed * moveMult
		if terrainPosX < -160 * 2 * 6 then
			toBeFlipped = getRandomBool()
			if toBeFlipped then
				flipped2 = 0 * 6
			else
				flipped2 = 41 * 6
			end

			setProperty("terrain.animation.curAnim.curFrame", getRandomInt(-1, 3, -1))
			setProperty("terrain2.animation.curAnim.curFrame", getProperty("terrain.animation.curAnim.curFrame"))
			setProperty("terrain.flipY", toBeFlipped)
			setProperty("terrain2.flipY", toBeFlipped)
			billDelay = 0.4

			terrainPosX = 160 * 2 * 6
			terrainPosY = flipped2

			if getProperty("terrain.flipY") then
				flipped = 30 * 6
			else
				flipped = 0 * 6
			end

			tweeningBF = true
			billTween = false
		end
		setProperty("terrain.x", math.floor(terrainPosX / 6) * 6)
		setProperty("terrain2.x", math.floor(terrainPosX / 6) * 6)
		setProperty("terrain.y", math.floor(terrainPosY / 6) * 6)
		if toBeFlipped then
			setProperty("terrain2.y", getProperty("terrain.y") - getProperty("terrain.height"))
		else
			setProperty("terrain2.y", getProperty("terrain.y") + getProperty("terrain.height"))
		end

		billDelay = billDelay - elapsed
		if billDelay <= 0 and billTween == false then
			billTween = true
			tweeningDad = true
		else
			billDelay = billDelay - elapsed
		end

		if tweeningBF and not inGameOver then
			tweeningBF = false
			targetBfY = flipped + ogBfY
			doTweenY("lerpBF", "boyfriend", targetBfY, 1, "circOut")
		end

		if tweeningDad and not inGameOver then
			tweeningDad = false
			targetBillY = flipped + ogDadY
			doTweenY("lerpBill", "dad", targetBillY, 1, "circOut")
		end
	end

	setProperty("dad.y", math.floor(getProperty("dad.y") / 6) * 6 + 0.5)
	setProperty("boyfriend.y", math.floor(getProperty("boyfriend.y") / 6) * 6 + 3)
end