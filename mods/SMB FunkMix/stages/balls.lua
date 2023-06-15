starsPos = 0
cloudsPos = 0
coinsBackPos = 0
coinsFrontPos = 0

function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	if week ~= "funkMix" and week ~= "funkMixDX" then
		-- Newgrounds Balls Stage
		if not lowQuality then
			makeLuaSprite("sky", "backgrounds/balls/sky", -160 * 3, -81 * 3 + 3)
			setScrollFactor("sky", 1, 1)
			setProperty("sky.antialiasing", false)
			scaleObject("sky", 6, 6)
			addLuaSprite("sky", false)

			makeLuaSprite("sky2", "backgrounds/balls/sky2", -160 * 3, -81 * 3 + 3)
			setScrollFactor("sky2", 1, 1)
			setProperty("sky2.antialiasing", false)
			scaleObject("sky2", 6, 6)
			addLuaSprite("sky2", false)

			makeLuaSprite("sky3", "backgrounds/balls/sky3", -160 * 3, -81 * 3 + 3)
			setScrollFactor("sky3", 1, 1)
			setProperty("sky3.antialiasing", false)
			scaleObject("sky3", 6, 6)
			updateHitbox("sky3")
			addLuaSprite("sky3", false)

			makeLuaSprite("clouds", "backgrounds/balls/clouds", -160 * 2, -81 * 3 + 3)
			setScrollFactor("clouds", 1/4, 1)
			setProperty("clouds.antialiasing", false)
			scaleObject("clouds", 6, 6)
			addLuaSprite("clouds", false)

			makeLuaSprite("mountains", "backgrounds/balls/mountains", -207.5 * 3, -81 * 3 + 3)
			setScrollFactor("mountains", 2/4, 1)
			setProperty("mountains.antialiasing", false)
			scaleObject("mountains", 6, 6)
			addLuaSprite("mountains", false)

			makeLuaSprite("background", "backgrounds/balls/background", -160 * 3, -81 * 3 + 3)
			setScrollFactor("background", 7/8, 1)
			setProperty("background.antialiasing", false)
			scaleObject("background", 6, 6)
			addLuaSprite("background", false)

			makeAnimatedLuaSprite("ground", "backgrounds/balls/ground", -160 * 3, -81 * 3 + 3)
			addAnimationByPrefix("ground", "anim", "anim0", 9, true)
			setScrollFactor("ground", 1, 1)
			setProperty("ground.antialiasing", false)
			scaleObject("ground", 6, 6)
			addLuaSprite("ground", false)
		else
			makeAnimatedLuaSprite("balls", "backgrounds/balls/balls", -160 * 3, -81 * 3 + 3)
			addAnimationByPrefix("balls", "anim", "anim0", 9, true)
			setScrollFactor("balls", 1, 1)
			setProperty("balls.antialiasing", false)
			scaleObject("balls", 6, 6)
			addLuaSprite("balls", false)
		end
	else
		-- Sky Stage Clone
		makeLuaSprite("sky", "backgrounds/sky/skyNight", -160 * 3, -81 * 3)
		setScrollFactor("sky", 1, 1)
		setProperty("sky.antialiasing", false)
		scaleObject("sky", 6, 6)
		addLuaSprite("sky", false)

		makeLuaSprite("stars", "backgrounds/sky/stars", 0, 0)
		setScrollFactor("stars", 1, 1)
		setProperty("stars.antialiasing", false)
		scaleObject("stars", 6, 6)
		addLuaSprite("stars", false)
		makeLuaSprite("stars2", "backgrounds/sky/stars", getProperty("stars.width"), 0)
		setScrollFactor("stars2", 1, 1)
		setProperty("stars2.antialiasing", false)
		scaleObject("stars2", 6, 6)
		addLuaSprite("stars2", false)
		makeLuaSprite("stars3", "backgrounds/sky/stars", - getProperty("stars.width"), 0)
		setScrollFactor("stars3", 1, 1)
		setProperty("stars3.antialiasing", false)
		scaleObject("stars3", 6, 6)
		addLuaSprite("stars3", false)

		makeAnimatedLuaSprite("coinsBack", "backgrounds/sky/coins1", 0, 0)
		setScrollFactor("coinsBack", 1, 1)
		setProperty("coinsBack.antialiasing", false)
		scaleObject("coinsBack", 6, 6)
		addLuaSprite("coinsBack", false)
		makeAnimatedLuaSprite("coinsBack2", "backgrounds/sky/coins1", getProperty("coinsBack.width"), 0)
		setScrollFactor("coinsBack2", 1, 1)
		setProperty("coinsBack2.antialiasing", false)
		scaleObject("coinsBack2", 6, 6)
		addLuaSprite("coinsBack2", false)
		makeAnimatedLuaSprite("coinsBack3", "backgrounds/sky/coins1", getProperty("coinsBack.width") * 2, 0)
		setScrollFactor("coinsBack3", 1, 1)
		setProperty("coinsBack3.antialiasing", false)
		scaleObject("coinsBack3", 6, 6)
		addLuaSprite("coinsBack3", false)
		makeAnimatedLuaSprite("coinsBack4", "backgrounds/sky/coins1", - getProperty("coinsBack.width"), 0)
		setScrollFactor("coinsBack4", 1, 1)
		setProperty("coinsBack4.antialiasing", false)
		scaleObject("coinsBack4", 6, 6)
		addLuaSprite("coinsBack4", false)

		if flashingLights and week ~= "funkMix" then
			addAnimationByPrefix("coinsBack", "idle", "idle0", 9, true)
			addAnimationByPrefix("coinsBack2", "idle", "idle0", 9, true)
			addAnimationByPrefix("coinsBack3", "idle", "idle0", 9, true)
			addAnimationByPrefix("coinsBack4", "idle", "idle0", 9, true)
		end

		makeAnimatedLuaSprite("coinsFront", "backgrounds/sky/coins2", 0, 0)
		setScrollFactor("coinsFront", 1, 1)
		setProperty("coinsFront.antialiasing", false)
		scaleObject("coinsFront", 6, 6)
		addLuaSprite("coinsFront", false)
		makeAnimatedLuaSprite("coinsFront2", "backgrounds/sky/coins2", getProperty("coinsFront.width"), 0)
		setScrollFactor("coinsFront2", 1, 1)
		setProperty("coinsFront2.antialiasing", false)
		scaleObject("coinsFront2", 6, 6)
		addLuaSprite("coinsFront2", false)

		if flashingLights and week ~= "funkMix" then
			addAnimationByPrefix("coinsFront", "idle", "idle0", 9, true)
			addAnimationByPrefix("coinsFront2", "idle", "idle0", 9, true)
		end

		makeLuaSprite("platform", "backgrounds/sky/clouds", 0, 0)
		setScrollFactor("platform", 1, 1)
		setProperty("platform.antialiasing", false)
		scaleObject("platform", 6, 6)
		addLuaSprite("platform", false)
	end
end

function onCreatePost()
	if week == "funkMix" or week == "funkMixDX" then
		setProperty("boyfriend.x", 636 + (9 * 6) + 1.8)
		setProperty("boyfriend.y", 204 + (3 * 6) + 1.5)
		setProperty("dad.x", 132 + (8 * 6) + 3.85)
		setProperty("dad.y", 90 + (2 * 6) + 4)
		if week == "funkMix" then
			loadGraphic("stars", "backgrounds/sky/starsOld")
			updateHitbox("stars")
			loadGraphic("stars2", "backgrounds/sky/starsOld")
			updateHitbox("stars2")
			loadGraphic("stars3", "backgrounds/sky/starsOld")
			updateHitbox("stars3")
		end
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if flashingLights then
			moveMult = 1
		else
			moveMult = 0.5
		end

		starsPos = starsPos - 25 * elapsed * moveMult
		if starsPos + getProperty("stars.width") <= 0 then
			starsPos = 0
		end
		setProperty("stars.x", math.floor(starsPos / 6) * 6)
		setProperty("stars2.x", getProperty("stars.x") + getProperty("stars.width"))
		setProperty("stars3.x", getProperty("stars.x") - getProperty("stars.width"))

		coinsBackPos = coinsBackPos - 200 * elapsed * moveMult
		if coinsBackPos + getProperty("coinsBack.width") <= 0 then
			coinsBackPos = 0
		end
		setProperty("coinsBack.x", math.floor(coinsBackPos / 6) * 6)
		setProperty("coinsBack2.x", getProperty("coinsBack.x") + getProperty("coinsBack.width"))
		setProperty("coinsBack3.x", getProperty("coinsBack.x") + (getProperty("coinsBack.width") * 2))
		setProperty("coinsBack4.x", getProperty("coinsBack.x") - getProperty("coinsBack.width"))

		coinsFrontPos = coinsFrontPos - 600 * elapsed * moveMult
		if coinsFrontPos + getProperty("coinsFront.width") <= 0 then
			coinsFrontPos = 0
		end
		setProperty("coinsFront.x", math.floor(coinsFrontPos / 6) * 6)
		setProperty("coinsFront2.x", getProperty("coinsFront.x") + getProperty("coinsFront.width"))

		if week ~= "funkMix" and week ~= "funkMixDX" then
			cloudsPos = cloudsPos - 100 * elapsed * moveMult
			if cloudsPos + getProperty("clouds.width") <= -320 then
				cloudsPos = -320
			end
			setProperty("clouds.x", math.floor(cloudsPos / 6) * 6)
			setProperty("clouds2.x", getProperty("clouds.x") + getProperty("clouds.width"))
			setProperty("clouds3.x", getProperty("clouds.x") - getProperty("clouds.width"))
			setProperty("bonus.y", math.floor(getProperty("bonus.y") / 6) * 6)
		end

		if isRunning("scripts/extra/menus/Pause") then
			setProperty("coinsBack.animation.curAnim.paused", false)
			setProperty("coinsBack2.animation.curAnim.paused", false)
			setProperty("coinsBack3.animation.curAnim.paused", false)
			setProperty("coinsBack4.animation.curAnim.paused", false)
			setProperty("coinsFront.animation.curAnim.paused", false)
			setProperty("coinsFront2.animation.curAnim.paused", false)
			setProperty("ground.animation.curAnim.paused", false)
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("coinsBack.animation.curAnim.paused", true)
			setProperty("coinsBack2.animation.curAnim.paused", true)
			setProperty("coinsBack3.animation.curAnim.paused", true)
			setProperty("coinsBack4.animation.curAnim.paused", true)
			setProperty("coinsFront.animation.curAnim.paused", true)
			setProperty("coinsFront2.animation.curAnim.paused", true)
			setProperty("ground.animation.curAnim.paused", true)
		end
	end
end