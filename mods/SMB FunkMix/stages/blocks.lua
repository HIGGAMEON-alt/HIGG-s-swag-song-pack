cloudsPos = 0

function onCreate()
	addLuaScript("scripts/extra/fonts/Bros 3 Font")

	makeLuaSprite("skyIntro", "backgrounds/blocks/sky", -155*6, -185*6)
	setScrollFactor("skyIntro", 1, 1)
	setProperty("skyIntro.antialiasing", false)
	scaleObject("skyIntro", 6, 6)
	addLuaSprite("skyIntro", false)

	if songName == "Hammered" then
		makeLuaSprite("sky", "backgrounds/blocks/skyH", -155*6, -185*12)
		setScrollFactor("sky", 1, 1)
		setProperty("sky.antialiasing", false)
		scaleObject("sky", 6, 6)
		addLuaSprite("sky", false)

		makeLuaSprite("skyAlt", "backgrounds/blocks/skyHalt", -155*6, -185*6)
		setScrollFactor("skyAlt", 1, 1)
		setProperty("skyAlt.antialiasing", false)
		setProperty("skyAlt.alpha", 0)
		scaleObject("skyAlt", 6, 6)
		addLuaSprite("skyAlt", false)
	end

	makeLuaSprite("cloudsIntro", "backgrounds/blocks/clouds", -155*6, -185*6)
	setScrollFactor("cloudsIntro", 1, 1)
	setProperty("cloudsIntro.antialiasing", false)
	scaleObject("cloudsIntro", 6, 6)
	addLuaSprite("cloudsIntro", false)

	if songName == "Hammered" then
		makeLuaSprite("cloudsA", "backgrounds/blocks/cloudsH", -155*6, -185*12)
		setScrollFactor("cloudsA", 1, 1)
		setProperty("cloudsA.antialiasing", false)
		scaleObject("cloudsA", 6, 6)
		addLuaSprite("cloudsA", false)

		makeAnimatedLuaSprite("logo", "backgrounds/blocks/title3", -155*6, -185*12)
		addAnimationByPrefix("logo", "idle", "logo", 9, true)
		setScrollFactor("logo", 1, 1)
		setProperty("logo.antialiasing", false)
		scaleObject("logo", 6, 6)
		addLuaSprite("logo", false)

		makeLuaSprite("cloudsB", "backgrounds/blocks/clouds2", -155*6, -185*12)
		setScrollFactor("cloudsB", 1, 1)
		setProperty("cloudsB.antialiasing", false)
		scaleObject("cloudsB", 6, 6)
		addLuaSprite("cloudsB", false)
		makeLuaSprite("cloudsB2", "backgrounds/blocks/clouds2", getProperty("cloudsB.x") + getProperty("cloudsB.width"), getProperty("cloudsB.y"))
		setScrollFactor("cloudsB2", 1, 1)
		setProperty("cloudsB2.antialiasing", false)
		scaleObject("cloudsB2", 6, 6)
		addLuaSprite("cloudsB2", false)
		makeLuaSprite("cloudsB3", "backgrounds/blocks/clouds2", getProperty("cloudsB.x") - getProperty("cloudsB.width"), getProperty("cloudsB.y"))
		setScrollFactor("cloudsB3", 1, 1)
		setProperty("cloudsB3.antialiasing", false)
		scaleObject("cloudsB3", 6, 6)
		addLuaSprite("cloudsB3", false)

		makeLuaSprite("background", "backgrounds/blocks/background", -155*6, -185*6+120*6)
		setScrollFactor("background", 0.5, 1)
		setProperty("background.antialiasing", false)
		scaleObject("background", 6, 6)
		addLuaSprite("background", false)
	end

	makeLuaSprite("ground", "backgrounds/blocks/ground", -155*6, -185*6)
	setScrollFactor("ground", 1, 1)
	setProperty("ground.antialiasing", false)
	scaleObject("ground", 6, 6)
	addLuaSprite("ground", false)

	--[[makeLuaSprite("players", "backgrounds/blocks/players", -155*6, -185*6)
	setScrollFactor("players", 1, 1)
	setProperty("players.antialiasing", false)
	scaleObject("players", 6, 6)
	addLuaSprite("players", false)]]

	makeLuaSprite("curtains", "backgrounds/blocks/curtains", -5*6 - 2, -67*6 - screenHeight)
	setScrollFactor("curtains", 1, 1)
	setProperty("curtains.antialiasing", false)
	setObjectCamera("curtains", "other")
	scaleObject("curtains", 6, 6)
	addLuaSprite("curtains", false)
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		cloudsPos = cloudsPos - 100 * elapsed
		if cloudsPos + getProperty("cloudsB.width") <= -480 then
			cloudsPos = -480
		end
		setProperty("cloudsB.x", math.floor(cloudsPos / 6) * 6)
		setProperty("cloudsB2.x", getProperty("cloudsB.x") + getProperty("cloudsB.width"))
		setProperty("cloudsB3.x", getProperty("cloudsB.x") - (getProperty("cloudsB.width")))
		setProperty("cloudsB2.y", getProperty("cloudsB.y"))
		setProperty("cloudsB3.y", getProperty("cloudsB.y"))

		if isRunning("scripts/extra/menus/Pause") then
			setProperty("logo.animation.curAnim.paused", false)
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("logo.animation.curAnim.paused", true)
		end
	end
end

--[[function onUpdatePost()
	-- Remove this if you're working on camera movements in the chart.
	-- "camera_opponent": [274, -34],
	cameraSetTarget("dad")
	setProperty("camGame.zoom", 0.5)
end]]