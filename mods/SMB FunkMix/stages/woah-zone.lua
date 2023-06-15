local xx = 160 * 3
local yy = 81 * 3
starsPos = 0

function onCreate()
	addLuaScript("scripts/extra/Default Font")

	makeLuaSprite("space", "backgrounds/woah-zone/space", -160 * 3, -81 * 3)
	setScrollFactor("space", 1, 1)
	setProperty("space.antialiasing", false)
	scaleObject("space", 6, 6)
	addLuaSprite("space", false)

	makeLuaSprite("stars", "backgrounds/woah-zone/stars", 0, 0)
	setScrollFactor("stars", 1, 1)
	setProperty("stars.antialiasing", false)
	scaleObject("stars", 6, 6)
	addLuaSprite("stars", false)
	makeLuaSprite("stars2", "backgrounds/woah-zone/stars", getProperty("stars.width"), 0)
	setScrollFactor("stars2", 1, 1)
	setProperty("stars2.antialiasing", false)
	scaleObject("stars2", 6, 6)
	addLuaSprite("stars2", false)

	if not lowQuality then
		makeLuaSprite("stars3", "backgrounds/woah-zone/stars", - getProperty("stars.width"), 0)
		setScrollFactor("stars3", 1, 1)
		setProperty("stars3.antialiasing", false)
		scaleObject("stars3", 6, 6)
		addLuaSprite("stars3", false)
	end

	makeAnimatedLuaSprite("bg", "backgrounds/woah-zone/bg", -160 * 3, -81 * 3)
	if flashingLights then
		addAnimationByPrefix("bg", "idle", "idle0", 1, true)
	end
	setScrollFactor("bg", 1, 1)
	setProperty("bg.antialiasing", false)
	scaleObject("bg", 6, 6)
	addLuaSprite("bg", false)

	-- Placeholder until Brobot appearence.
	makeLuaSprite("platformBig", "backgrounds/woah-zone/platformBig", (80 - 48) * 6, 121 * 3)
	setScrollFactor("platformBig", 1, 1)
	setProperty("platformBig.antialiasing", false)
	scaleObject("platformBig", 6, 6)
	addLuaSprite("platformBig", false)

	makeLuaSprite("ground", "backgrounds/woah-zone/ground", -160 * 3, -81 * 3)
	setScrollFactor("ground", 1, 1)
	setProperty("ground.antialiasing", false)
	scaleObject("ground", 6, 6)
	addLuaSprite("ground", false)
end

function onUpdate(elapsed)
	setProperty("bg.y", math.floor(getProperty("bg.y") / 6) * 6)
	setProperty("ground.y", math.floor(getProperty("ground.y") / 6) * 6)
	setProperty("platformBig.y", math.floor(getProperty("platformBig.y") / 6) * 6)
end

function onUpdatePost(elapsed)
	-- Space Section
	if flashingLights then
		moveMult = 1
	else
		moveMult = 0.5
	end

	starsPos = starsPos - 600 * elapsed * moveMult
	if starsPos + getProperty("stars.width") <= 0 then
		starsPos = 0
	end
	if not lowQuality then
		setProperty("stars.x", starsPos)
	else
		setProperty("stars.x", math.floor(starsPos / 6) * 6)
	end
	setProperty("stars2.x", getProperty("stars.x") + getProperty("stars.width"))
	if not lowQuality then
		setProperty("stars3.x", getProperty("stars.x") - getProperty("stars.width"))
	end
end

function onTweenCompleted(tag)
	if tag == "bgRemove" then
		setProperty("bg.visible", false)
		setProperty("ground.visible", false)
	end
end