starsPos = 0
cloudsPos = 0
coinsBackPos = 0
coinsFrontPos = 0

function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	makeLuaSprite("sky", "backgrounds/sky/skyNight", -160 * 3, -81 * 3)
	setScrollFactor("sky", 1, 1)
	setProperty("sky.antialiasing", false)
	scaleObject("sky", 6, 6)
	addLuaSprite("sky", false)
	
	maxObjects = 4
	if week == "funkMix" or week == "funkMixDX" then
		maxObjects = 3
	end

	for i = 1,maxObjects do
		makeLuaSprite("stars"..i, "backgrounds/sky/stars", 0, 0)
		setScrollFactor("stars"..i, 1, 1)
		setProperty("stars"..i..".antialiasing", false)
		scaleObject("stars"..i, 6, 6)
		addLuaSprite("stars"..i, false)
	end

	if week ~= "funkMix" and week ~= "funkMixDX" then
		if not lowQuality then
			makeLuaSprite("skyDay", "backgrounds/sky/skyDay", -160 * 3, -81 * 3)
			setScrollFactor("skyDay", 1, 1)
			setProperty("skyDay.antialiasing", false)
			setProperty("skyDay.alpha", 0)
			scaleObject("skyDay", 6, 6)
			addLuaSprite("skyDay", false)

			makeLuaSprite("bonus", "backgrounds/sky/bonus", 162 + - (8 * 6), -136 * 6)
			setScrollFactor("bonus", 1, 1)
			setProperty("bonus.antialiasing", false)
			setProperty("bonus.alpha", 0.5)
			scaleObject("bonus", 6, 6)
			addLuaSprite("bonus", false)
		end

		for i = 1,maxObjects do
			makeLuaSprite("clouds"..i, "backgrounds/sky/bgClouds", 0, -81 * 3 + 3)
			setScrollFactor("clouds"..i, 1, 1)
			setProperty("clouds"..i..".antialiasing", false)
			scaleObject("clouds"..i, 6, 6)
			addLuaSprite("clouds"..i, false)
		end
	end

	for i = 1,4 do
		makeAnimatedLuaSprite("coinsBack"..i, "backgrounds/sky/coins1", 0, 0)
		setScrollFactor("coinsBack"..i, 1, 1)
		setProperty("coinsBack"..i..".antialiasing", false)
		scaleObject("coinsBack"..i, 6, 6)
		addLuaSprite("coinsBack"..i, false)
		if flashingLights and week ~= "funkMix" then
			addAnimationByPrefix("coinsBack"..i, "idle", "idle0", 9, true)
		end
	end

	for i = 1,maxObjects do
		makeAnimatedLuaSprite("coinsFront"..i, "backgrounds/sky/coins2", 0, 0)
		setScrollFactor("coinsFront"..i, 1, 1)
		setProperty("coinsFront"..i..".antialiasing", false)
		scaleObject("coinsFront"..i, 6, 6)
		addLuaSprite("coinsFront"..i, false)
		if flashingLights and week ~= "funkMix" then
			addAnimationByPrefix("coinsFront"..i, "idle", "idle0", 9, true)
		end
	end

	if songName == "Co-op" then
		makeLuaSprite("platform", "backgrounds/sky/cloudsCoOp", 0, 0)
		setScrollFactor("platform", 1, 1)
		setProperty("platform.antialiasing", false)
		scaleObject("platform", 6, 6)
		addLuaSprite("platform", false)

		if not lowQuality and flashingLights and week ~= "funkMix" and week ~= "funkMixDX" then
			makeAnimatedLuaSprite("platformAnim", "backgrounds/sky/cloudsCoOpAnim", 0, 0)
			addAnimationByPrefix("platformAnim", "idle", "idle0001", 24, false)
			addAnimationByIndices("platformAnim", "dancePrep", "idle000", "2, 3, 0", 24)
			addAnimationByPrefix("platformAnim", "dance", "idle0", 24, false)
			setScrollFactor("platformAnim", 1, 1)
			setProperty("platformAnim.antialiasing", false)
			scaleObject("platformAnim", 6, 6)
			addLuaSprite("platformAnim", false)
		end
	else
		makeLuaSprite("platform", "backgrounds/sky/clouds", 0, 0)
		setScrollFactor("platform", 1, 1)
		setProperty("platform.antialiasing", false)
		scaleObject("platform", 6, 6)
		addLuaSprite("platform", false)

		if not lowQuality and flashingLights and week ~= "funkMix" and week ~= "funkMixDX" then
			makeAnimatedLuaSprite("platformAnim", "backgrounds/sky/cloudsAnim", 0, 0)
			addAnimationByPrefix("platformAnim", "idle", "idle0001", 24, false)
			addAnimationByIndices("platformAnim", "dancePrep", "idle000", "2, 3, 0", 24)
			addAnimationByPrefix("platformAnim", "dance", "idle0", 24, false)
			setScrollFactor("platformAnim", 1, 1)
			setProperty("platformAnim.antialiasing", false)
			scaleObject("platformAnim", 6, 6)
			addLuaSprite("platformAnim", false)
		end
	end

	setProperty("stars2.x", getProperty("stars1.x") + getProperty("stars1.width"))
	setProperty("stars3.x", getProperty("stars1.x") + getProperty("stars1.width") * 2)
	setProperty("stars4.x", getProperty("stars1.x") - getProperty("stars1.width"))
	setProperty("coinsBack2.x", getProperty("coinsBack1.x") + getProperty("coinsBack1.width"))
	setProperty("coinsBack3.x", getProperty("coinsBack1.x") + (getProperty("coinsBack1.width") * 2))
	setProperty("coinsBack4.x", getProperty("coinsBack1.x") - getProperty("coinsBack1.width"))
	setProperty("coinsFront2.x", getProperty("coinsFront1.x") + getProperty("coinsFront1.width"))
	setProperty("coinsFront3.x", getProperty("coinsFront1.x") + (getProperty("coinsFront1.width") * 2))
	setProperty("coinsFront4.x", getProperty("coinsFront1.x") - getProperty("coinsFront1.width"))
	if week ~= "funkMix" and week ~= "funkMixDX" then
		setProperty("clouds2.x", getProperty("clouds1.x") + getProperty("clouds1.width"))
		setProperty("clouds3.x", getProperty("clouds1.x") + (getProperty("clouds1.width") * 2))
		setProperty("clouds4.x", getProperty("clouds1.x") - getProperty("clouds1.width"))
	end
end

function onCreatePost()
	if week == "funkMix" or week == "funkMixDX" then
		setProperty("gf.visible", false)
		if week == "funkMix" then
			for i = 1,maxObjects do
				loadGraphic("stars"..i, "backgrounds/sky/starsOld")
				updateHitbox("stars"..i)
			end
		end
	end
	if songName == "Co-op" then
		setProperty("gf.visible", true)
		setProperty("gf.x", 332)
		setProperty("gf.y", 151.5)
		loadGraphic("bonus", "backgrounds/sky/bonus-bros")
	elseif songName == "balls" then
		setProperty("gf.visible", false)
		loadGraphic("bonus", "backgrounds/sky/bonus-bros")
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
		if starsPos + getProperty("stars1.width") <= 0 then
			starsPos = 0
		end
		setProperty("stars1.x", math.floor(starsPos / 6) * 6)
		setProperty("stars2.x", getProperty("stars1.x") + getProperty("stars1.width"))
		setProperty("stars3.x", getProperty("stars1.x") + getProperty("stars1.width") * 2)
		setProperty("stars4.x", getProperty("stars1.x") - getProperty("stars1.width"))

		coinsBackPos = coinsBackPos - 200 * elapsed * moveMult
		if coinsBackPos + getProperty("coinsBack1.width") <= 0 then
			coinsBackPos = 0
		end
		setProperty("coinsBack1.x", math.floor(coinsBackPos / 6) * 6)
		setProperty("coinsBack2.x", getProperty("coinsBack1.x") + getProperty("coinsBack1.width"))
		setProperty("coinsBack3.x", getProperty("coinsBack1.x") + (getProperty("coinsBack1.width") * 2))
		setProperty("coinsBack4.x", getProperty("coinsBack1.x") - getProperty("coinsBack1.width"))

		coinsFrontPos = coinsFrontPos - 600 * elapsed * moveMult
		if coinsFrontPos + getProperty("coinsFront1.width") <= 0 then
			coinsFrontPos = 0
		end
		setProperty("coinsFront1.x", math.floor(coinsFrontPos / 6) * 6)
		setProperty("coinsFront2.x", getProperty("coinsFront1.x") + getProperty("coinsFront1.width"))
		setProperty("coinsFront3.x", getProperty("coinsFront1.x") + (getProperty("coinsFront1.width") * 2))
		setProperty("coinsFront4.x", getProperty("coinsFront1.x") - getProperty("coinsFront1.width"))

		if week ~= "funkMix" and week ~= "funkMixDX" then
			cloudsPos = cloudsPos - 100 * elapsed * moveMult
			if cloudsPos + getProperty("clouds1.width") <= -320 then
				cloudsPos = -320
			end
			setProperty("clouds1.x", math.floor(cloudsPos / 6) * 6)
			setProperty("clouds2.x", getProperty("clouds1.x") + getProperty("clouds1.width"))
			setProperty("clouds3.x", getProperty("clouds1.x") + (getProperty("clouds1.width") * 2))
			setProperty("clouds4.x", getProperty("clouds1.x") - getProperty("clouds1.width"))
			setProperty("bonus.y", math.floor(getProperty("bonus.y") / 6) * 6)
		end
		
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("platformAnim.animation.curAnim.paused", false)
			for i = 1,4 do
				setProperty("coinsBack"..i..".animation.curAnim.paused", false)
				setProperty("coinsFront"..i..".animation.curAnim.paused", false)
			end
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("platformAnim.animation.curAnim.paused", true)
			for i = 1,4 do
				setProperty("coinsBack"..i..".animation.curAnim.paused", true)
				setProperty("coinsFront"..i..".animation.curAnim.paused", true)
			end
		end
	end
end