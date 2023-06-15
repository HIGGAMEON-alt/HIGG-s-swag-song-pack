local suff = ""

local platformPos1 = nil
local platformPos2 = nil

function onCreate()
	if songName == "Bricks and Lifts B-Side" then
		addLuaScript("scripts/extra/fonts/Lost Levels Font")
		suff = "-bSide"
	else
		addLuaScript("scripts/extra/fonts/Default Font")
	end

	-- background shit
	makeLuaSprite("bg", "backgrounds/underground/bg"..suff, -160 * 3, -81 * 3)
	setScrollFactor("bg", 1, 1)
	setProperty("bg.antialiasing", false)
	scaleObject("bg", 6, 6)
	addLuaSprite("bg", false)

	if week ~= "funkMix" and week ~= "funkMixDX" then
		if not lowQuality then
			makeAnimatedLuaSprite("background", "backgrounds/underground/background", -160 * 7/3, -81 * 2.5)
			addAnimationByPrefix("background", "anim", "anim0", 9, true)
			setScrollFactor("background", 1/3, 1)
			setProperty("background.antialiasing", false)
			setProperty("background.alpha", 0.5)
			scaleObject("background", 6, 6)
			addLuaSprite("background", false)

			makeLuaSprite("foreground", "backgrounds/underground/foreground"..suff, -160 * 3, -81 * 3)
			setScrollFactor("foreground", 1.5, 1)
			setProperty("foreground.antialiasing", false)
			scaleObject("foreground", 6, 6)
			addLuaSprite("foreground", true)
		end

		makeAnimatedLuaSprite("background2", "backgrounds/underground/background2"..suff, -160 * 8/3, -81 * 3)
		addAnimationByPrefix("background2", "anim", "anim0", 9, true)
		setScrollFactor("background2", 2/3, 1)
		setProperty("background2.antialiasing", false)
		scaleObject("background2", 6, 6)
		addLuaSprite("background2", false)

		makeLuaSprite("ground", "backgrounds/underground/ground"..suff, -160 * 3, -81 * 3)
		setScrollFactor("ground", 1, 1)
		setProperty("ground.antialiasing", false)
		scaleObject("ground", 6, 6)
		addLuaSprite("ground", false)

		makeAnimatedLuaSprite("groundAnim", "backgrounds/underground/groundAnim", -160 * 3, -81 * 3)
		addAnimationByPrefix("groundAnim", "anim", "anim0", 9, true)
		setScrollFactor("groundAnim", 1, 1)
		setProperty("groundAnim.antialiasing", false)
		scaleObject("groundAnim", 6, 6)
		addLuaSprite("groundAnim", false)

		if lowQuality then
			setProperty("background2.x", -160 * 3)
			setScrollFactor("background2", 1, 1)
		end
	end

	makeLuaSprite("bgPlatform1", "backgrounds/underground/platform"..suff, -20 * 6 + 1, 24 * 6)
	setScrollFactor("bgPlatform1", 1, 1)
	setProperty("bgPlatform1.antialiasing", false)
	scaleObject("bgPlatform1", 6, 6)
	if week ~= "funkMix" and week ~= "funkMixDX" then
		setProperty("bgPlatform1.x", getProperty("bgPlatform1.x") - 28)
	else
		setProperty("bgPlatform1.x", getProperty("bgPlatform1.x") + 5)
	end
	platformPos1 = getProperty("bgPlatform1.y")
	addLuaSprite("bgPlatform1", false)

	makeLuaSprite("bgPlatform2", "backgrounds/underground/platform"..suff, 131 * 6 - 1, 84 * 6)
	setScrollFactor("bgPlatform2", 1, 1)
	setProperty("bgPlatform2.antialiasing", false)
	scaleObject("bgPlatform2", 6, 6)
	if week ~= "funkMix" and week ~= "funkMixDX" then
		setProperty("bgPlatform2.x", getProperty("bgPlatform2.x") + 35)
	else
		setProperty("bgPlatform2.x", getProperty("bgPlatform2.x") + 1)
	end
	platformPos2 = getProperty("bgPlatform2.y")
	addLuaSprite("bgPlatform2", false)

	if week ~= "funkMix" and week ~= "funkMixDX" then
		makeLuaSprite("brickStand", "backgrounds/underground/brickStand"..suff, 0, 0)
		setScrollFactor("brickStand", 1, 1)
		setProperty("brickStand.antialiasing", false)
		scaleObject("brickStand", 6, 6)
		addLuaSprite("brickStand", false)
	else
		makeLuaSprite("bricks", "backgrounds/underground/bricks", 0, -24)
		setScrollFactor("bricks", 1, 1)
		setProperty("bricks.antialiasing", false)
		scaleObject("bricks", 6, 6)
		addLuaSprite("bricks", false)
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		platformPos1 = platformPos1 - (3 * 130 * elapsed)
		platformPos2 = platformPos2 - (3 * 130 * elapsed)
		if week ~= "funkMix" and week ~= "funkMixDX" then
			if platformPos1 < (-48 * 6) then
				platformPos1 = platformPos1 + 168 * 6
			end
			if platformPos2 < (-48 * 6) then
				platformPos2 = platformPos2 + 168 * 6
			end
		else
			if platformPos1 < (-32 * 6) then
				platformPos1 = platformPos1 + 192 * 6
			end
			if platformPos2 < (-32 * 6) then
				platformPos2 = platformPos2 + 192 * 6
			end
		end
		setProperty("bgPlatform1.y", math.floor(platformPos1 / 6) * 6)
		setProperty("bgPlatform2.y", math.floor(platformPos2 / 6) * 6)
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("background.animation.curAnim.paused", false)
			setProperty("background2.animation.curAnim.paused", false)
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("background.animation.curAnim.paused", true)
			setProperty("background2.animation.curAnim.paused", true)
		end
	end
end

function onUpdatePost()
	if week == "funkMix" or week == "funkMixDX" then
		if getDataFromSave("playerSettings", "aspectRatio") == "16:9" then
			if getProperty("camHUD.visible") then
				loadGraphic("bricks", "backgrounds/underground/bricksWide")
				updateHitbox("bricks")
				setProperty("bricks.x", -160 * 3)
				setProperty("bricks.y", 0)
			else
				loadGraphic("bricks", "backgrounds/underground/bricksLongWide")
				updateHitbox("bricks")
				setProperty("bricks.x", -160 * 3)
				setProperty("bricks.y", -81 * 3 + 3)
			end
		else
			if getProperty("camHUD.visible") then
				loadGraphic("bricks", "backgrounds/underground/bricks")
				updateHitbox("bricks")
				setProperty("bricks.x", 0)
				setProperty("bricks.y", 0)
			else
				loadGraphic("bricks", "backgrounds/underground/bricksLong")
				updateHitbox("bricks")
				setProperty("bricks.x", 0)
				setProperty("bricks.y", -81 * 3 + 3)
			end
		end
	end
end