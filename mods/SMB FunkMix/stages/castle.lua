local suff = ""

local fireballCenterX = 77
local fireballCenterY = 40
local fireballAngle = 0

local lavaVelocity1 = 0
local lavaVelocity2 = 0
local lavaJumpPower = 10
local lavaGravity = 10
local jumpThres = 112 * 6
local beatsUntilJump1 = math.random(2,8)
local beatsUntilJump2 = math.random(2,8)

local lavaJump1 = false
local lavaJump2 = false
	
function onCreate()
	if songName == "Lethal Lava Lair B-Side" then
		addLuaScript("scripts/extra/fonts/Lost Levels Font")
		suff = "-bSide"
	else
		addLuaScript("scripts/extra/fonts/Default Font")
	end

	if week ~= "funkMix" and week ~= "funkMixDX" then
		if lowQuality then
			makeLuaSprite("bg", "backgrounds/castle/castle"..suff, -160 * 3, -81 * 3 + 3)
			setScrollFactor("bg", 1, 1)
			setProperty("bg.antialiasing", false)
			scaleObject("bg", 3, 3)
			addLuaSprite("bg", false)

			makeLuaSprite("lavaOverlay", "backgrounds/castle/lavaOverlay"..suff, -160 * 3, -81 * 3 + 3)
			setScrollFactor("lavaOverlay", 1, 1)
			setProperty("lavaOverlay.antialiasing", false)
			scaleObject("lavaOverlay", 6, 6)
			addLuaSprite("lavaOverlay", false)
		else
			makeLuaSprite("sky", "backgrounds/castle/sky"..suff, -160 * 3, -81 * 3 + 3)
			setScrollFactor("sky", 1, 1)
			setProperty("sky.antialiasing", false)
			scaleObject("sky", 6, 6)
			addLuaSprite("sky", false)

			makeLuaSprite("level", "backgrounds/castle/level"..suff, -160 * 3, -81 * 3 + 3)
			setScrollFactor("level", 0.5, 1)
			setProperty("level.antialiasing", false)
			setProperty("level.alpha", 0.5)
			scaleObject("level", 3, 3)
			addLuaSprite("level", false)

			makeLuaSprite("background", "backgrounds/castle/background"..suff, -160 * 3, -81 * 3 + 3)
			setScrollFactor("background", 1, 1)
			setProperty("background.antialiasing", false)
			scaleObject("background", 6, 6)
			addLuaSprite("background", false)

			makeLuaSprite("ground", "backgrounds/castle/ground"..suff, -160 * 3, -81 * 3 + 3)
			setScrollFactor("ground", 1, 1)
			setProperty("ground.antialiasing", false)
			scaleObject("ground", 6, 6)
			addLuaSprite("ground", false)

			makeLuaSprite("lavaOverlay", "backgrounds/castle/lavaOverlay"..suff, -160 * 3, -81 * 3 + 3)
			setScrollFactor("lavaOverlay", 1, 1)
			setProperty("lavaOverlay.antialiasing", false)
			scaleObject("lavaOverlay", 6, 6)
			addLuaSprite("lavaOverlay", false)
		end
	else
		makeLuaSprite("bg", "backgrounds/castle/bg", -160 * 3, -81 * 3 + 3)
		setScrollFactor("bg", 1, 1)
		setProperty("bg.antialiasing", false)
		scaleObject("bg", 6, 6)
		addLuaSprite("bg", false)
	end

	if lowQuality or week == "funkMix" or week == "funkMixDX" then
		makeAnimatedLuaSprite("lava", "backgrounds/castle/lava"..suff, 25 * 6, 68 * 6)
		addAnimationByPrefix("lava", "idle", "idle0", 4, true)
		setScrollFactor("lava", 1, 1)
		setProperty("lava.antialiasing", false)
		scaleObject("lava", 6, 6)
		addLuaSprite("lava", false)
	else
		makeAnimatedLuaSprite("bgLavaLeft", "backgrounds/castle/lava"..suff, 25 * 6 - (56 * 6), 68 * 6)
		addAnimationByPrefix("bgLavaLeft", "idle", "idle0", 4, true)
		setScrollFactor("bgLavaLeft", 0.75, 1)
		setProperty("bgLavaLeft.antialiasing", false)
		scaleObject("bgLavaLeft", 6, 6)
		addLuaSprite("bgLavaLeft", false)
		setObjectOrder("bgLavaLeft", getObjectOrder("level") + 1)

		makeAnimatedLuaSprite("bgLavaRight", "backgrounds/castle/lava"..suff, 25 * 6 + (56 * 6), 68 * 6)
		addAnimationByPrefix("bgLavaRight", "idle", "idle0", 4, true)
		setScrollFactor("bgLavaRight", 0.75, 1)
		setProperty("bgLavaRight.antialiasing", false)
		scaleObject("bgLavaRight", 6, 6)
		addLuaSprite("bgLavaRight", false)
		setObjectOrder("bgLavaRight", getObjectOrder("level") + 1)

		makeAnimatedLuaSprite("fgLava", "backgrounds/castle/lava"..suff, 25 * 6, 76 * 6)
		addAnimationByPrefix("fgLava", "idle", "idle0", 4, true)
		setScrollFactor("fgLava", 1, 1)
		setProperty("fgLava.antialiasing", false)
		scaleObject("fgLava", 6, 6)
		addLuaSprite("fgLava", true)

		setProperty("lavaOverlay.y", -81 * 3 + 3 + (8 * 6))
		setObjectOrder("lavaOverlay", getObjectOrder("fgLava") + 1)
		setProperty("bgLavaLeft.animation.curAnim.curFrame", 2)
		setProperty("bgLavaRight.animation.curAnim.curFrame", 2)
	end

	if week ~= "funkMix" and week ~= "funkMixDX" then
		if not lowQuality then
			makeLuaSprite("lavaBubble1", "backgrounds/castle/lavaBubble"..suff, -160 + (4 * 6) - 2, -75 + 3)
			setScrollFactor("lavaBubble1", 1, 1)
			setProperty("lavaBubble1.antialiasing", false)
			scaleObject("lavaBubble1", 6, 6)
			addLuaSprite("lavaBubble1", false)
			setProperty("lavaBubble1.x", getProperty("lavaBubble1.x") + 56 * 6)
			setProperty("lavaBubble1.y", getProperty("lavaBubble1.y") + 128 * 6)
			lavaPos1 = getProperty("lavaBubble1.y")
			ogPos1 = getProperty("lavaBubble1.y")
			setObjectOrder("lavaBubble1", getObjectOrder("bgLavaLeft") + 1)

			makeLuaSprite("lavaBubble2", "backgrounds/castle/lavaBubble"..suff, -160 + (4 * 6) - 2, -75 + 3)
			setScrollFactor("lavaBubble2", 1, 1)
			setProperty("lavaBubble2.antialiasing", false)
			scaleObject("lavaBubble2", 6, 6)
			addLuaSprite("lavaBubble2", false)
			setProperty("lavaBubble2.x", getProperty("lavaBubble2.x") + 136 * 6)
			setProperty("lavaBubble2.y", getProperty("lavaBubble2.y") + 128 * 6)
			lavaPos2 = getProperty("lavaBubble2.y")
			ogPos2 = getProperty("lavaBubble2.y")
			setObjectOrder("lavaBubble2", getObjectOrder("bgLavaRight") + 1)
		end
	end

	for i = 0,5 do
		makeAnimatedLuaSprite("fireball"..i, "backgrounds/castle/fireball"..suff, fireballCenterX * 6, fireballCenterY - (i * 8) * 6)
		addAnimationByPrefix("fireball"..i, "idle", "idle0", 18, true)
		setScrollFactor("fireball"..i, 1, 1)
		setProperty("fireball"..i..".antialiasing", false)
		scaleObject("fireball"..i, 6, 6)
		addLuaSprite("fireball"..i, false)
	end
end

function onBeatHit()
	if beatsUntilJump1 > 0 then
		beatsUntilJump1 = beatsUntilJump1 - 1
		if beatsUntilJump1 <= 0 then
			beatsUntilJump1 = 0
			lavaJump1 = true
		end
	end
	if beatsUntilJump2 > 0 then
		beatsUntilJump2 = beatsUntilJump2 - 1
		if beatsUntilJump2 <= 0 then
			beatsUntilJump2 = 0
			lavaJump2 = true
		end
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		fireballAngle = fireballAngle + elapsed * 115
		if fireballAngle > 360 then
			fireballAngle = fireballAngle % 360
		end
		angleRadians = math.floor(-fireballAngle / 7.5) * 7.5 * math.pi/180
		for i = 0,5 do
			setProperty("fireball"..i..".animation.curAnim.paused", false)

			setProperty("fireball"..i..".x", fireballCenterX * 6)
			setProperty("fireball"..i..".y", fireballCenterY * 6)

			setProperty("fireball"..i..".x", getProperty("fireball"..i..".x") + math.cos(angleRadians) * i * 8 * 6)
			setProperty("fireball"..i..".y", getProperty("fireball"..i..".y") + math.sin(angleRadians) * i * 8 * 6)
			
			setProperty("fireball"..i..".x", math.floor(getProperty("fireball"..i..".x") / 6) * 6)
			setProperty("fireball"..i..".y", math.floor(getProperty("fireball"..i..".y") / 6) * 6)
			i = i + 1
		end

		if lavaJump1 then
			lavaVelocity1 = lavaVelocity1 + (lavaGravity * elapsed)
			lavaPos1 = lavaPos1 + (lavaVelocity1 * (elapsed * 120))
			setProperty("lavaBubble1.y", (math.floor(lavaPos1 / 6) * 6))
			if lavaPos1 > jumpThres then
				lavaVelocity1 = -lavaJumpPower
			end
			if lavaPos1 < 105 then
				setProperty("lavaBubble1.flipY", true)
			elseif lavaPos1 > (600 + 8 * 6) and getProperty("lavaBubble1.flipY") then
				lavaJump1 = false
				beatsUntilJump1 = getRandomInt(2,8,beatsUntilJump2)
				setProperty("lavaBubble1.flipY", false)
			end
		end
		if lavaJump2 then
			lavaVelocity2 = lavaVelocity2 + (lavaGravity * elapsed)
			lavaPos2 = lavaPos2 + (lavaVelocity2 * (elapsed * 120))
			setProperty("lavaBubble2.y", (math.floor(lavaPos2 / 6) * 6))
			if lavaPos2 > jumpThres then
				lavaVelocity2 = -lavaJumpPower
			end
			if lavaPos2 < 105 then
				setProperty("lavaBubble2.flipY", true)
			elseif lavaPos2 > (600 + 8 * 6) and getProperty("lavaBubble2.flipY") then
				lavaJump2 = false
				beatsUntilJump2 = getRandomInt(2,8,beatsUntilJump1)
				setProperty("lavaBubble2.flipY", false)
			end
		end

		if isRunning("scripts/extra/menus/Pause") then
			setProperty("lava.animation.curAnim.paused", false)
			setProperty("fgLava.animation.curAnim.paused", false)
			setProperty("bgLavaLeft.animation.curAnim.paused", false)
			setProperty("bgLavaRight.animation.curAnim.paused", false)
			for i = 0,5 do
				setProperty("fireball"..i..".animation.curAnim.paused", false)
			end
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("lava.animation.curAnim.paused", true)
			setProperty("fgLava.animation.curAnim.paused", true)
			setProperty("bgLavaLeft.animation.curAnim.paused", true)
			setProperty("bgLavaRight.animation.curAnim.paused", true)
			for i = 0,5 do
				setProperty("fireball"..i..".animation.curAnim.paused", true)
			end
		end
	end
end