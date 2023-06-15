local stormCloudsPos = 0
local color1 = 0x00000d0f
local color2 = 0x0000424a
local color3 = 0x00007b8c
local color4 = 0x00b5efef

function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")
	airship1Pos = -getRandomInt(0,512)*3
	airship2Pos = -getRandomInt(0,512)*3
	airship3Pos = -getRandomInt(0,512)*3
	airship4Pos = -getRandomInt(0,512)*3
	airship5Pos = -getRandomInt(0,512)*3

	if lowQuality then
		makeLuaSprite("stormClouds", "backgrounds/airship/bg", 0, -81*6)
		setScrollFactor("stormClouds", 1, 1)
		setProperty("stormClouds.antialiasing", false)
		scaleObject("stormClouds", 6, 6)
		addLuaSprite("stormClouds", false)
		makeLuaSprite("stormClouds2", "backgrounds/airship/bg", getProperty("stormClouds.width"), -81*6)
		setScrollFactor("stormClouds2", 1, 1)
		setProperty("stormClouds2.antialiasing", false)
		scaleObject("stormClouds2", 6, 6)
		addLuaSprite("stormClouds2", false)
		makeLuaSprite("stormClouds3", "backgrounds/airship/bg", -getProperty("stormClouds.width"), -81*6)
		setScrollFactor("stormClouds3", 1, 1)
		setProperty("stormClouds3.antialiasing", false)
		scaleObject("stormClouds3", 6, 6)
		addLuaSprite("stormClouds3", false)
	else
		makeLuaSprite("sky", "backgrounds/airship/sky", -149*6, -81*6)
		setScrollFactor("sky", 1, 1)
		setProperty("sky.antialiasing", false)
		scaleObject("sky", 6, 6)
		addLuaSprite("sky", false)

		makeLuaSprite("stormClouds", "backgrounds/airship/stormClouds", 0, -81*6)
		setScrollFactor("stormClouds", 1, 1)
		setProperty("stormClouds.antialiasing", false)
		scaleObject("stormClouds", 6, 6)
		addLuaSprite("stormClouds", false)
		makeLuaSprite("stormClouds2", "backgrounds/airship/stormClouds", getProperty("stormClouds.width"), -81*6)
		setScrollFactor("stormClouds2", 1, 1)
		setProperty("stormClouds2.antialiasing", false)
		scaleObject("stormClouds2", 6, 6)
		addLuaSprite("stormClouds2", false)
		makeLuaSprite("stormClouds3", "backgrounds/airship/stormClouds", -getProperty("stormClouds.width"), -81*6)
		setScrollFactor("stormClouds3", 1, 1)
		setProperty("stormClouds3.antialiasing", false)
		scaleObject("stormClouds3", 6, 6)
		addLuaSprite("stormClouds3", false)
	end

	if not lowQuality and week ~= "funkMixDX" then
		loadShip1()
		loadShip2()
		loadShip3()
		loadShip4()
	end

	if week ~= "funkMixDX" then
		makeLuaSprite("background", "backgrounds/airship/background", -160 * 3, -80 * 3)
		setScrollFactor("background", 1, 1)
		setProperty("background.antialiasing", false)
		scaleObject("background", 6, 6)
		addLuaSprite("background", false)
	end

	makeLuaSprite("cage", "backgrounds/airship/cage", 0, 0)
	setScrollFactor("cage", 1, 1)
	setProperty("cage.antialiasing", false)
	scaleObject("cage", 6, 6)
	addLuaSprite("cage", false)

	makeAnimatedLuaSprite("hands", "backgrounds/airship/hands", 101 * 6, 25 * 6)
	addAnimationByIndices("hands", "danceLeft", "dancing0", "0,1,2,3,4", 12)
	addAnimationByIndices("hands", "danceRight", "dancing0", "5,6,7,8,9", 12)
	addAnimationByIndices("hands", "miss", "miss0", "0,1,2,3", 12)
	setScrollFactor("hands", 1, 1)
	setProperty("hands.antialiasing", false)
	scaleObject("hands", 6, 6)
	addLuaSprite("hands", false)
	setObjectOrder("hands", getObjectOrder("cage") + 1)

	if week == "funkMix" or week == "funkMixDX" then
		makeAnimatedLuaSprite("blasterBro", "backgrounds/airship/blaster-bro", 0 * 6, 21 * 6)
	else
		makeAnimatedLuaSprite("blasterBro", "backgrounds/airship/blaster-bro-new", 0 * 6, 21 * 6)
	end

	addAnimationByPrefix("blasterBro", "idle", "idle0", 12, false)
	addAnimationByPrefix("blasterBro", "shoot", "shoot0", 12, false)
	setProperty("blasterBro.x", getProperty("blasterBro.x") + 0.075)
	setScrollFactor("blasterBro", 1, 1)
	setProperty("blasterBro.antialiasing", false)
	scaleObject("blasterBro", 6, 6)
	addLuaSprite("blasterBro", false)

	makeAnimatedLuaSprite("ground", "backgrounds/airship/ground", -160 * 3, -80 * 3)
	addAnimationByPrefix("ground", "idle", "idle0", 12, true)
	setScrollFactor("ground", 1, 1)
	setProperty("ground.antialiasing", false)
	scaleObject("ground", 6, 6)
	addLuaSprite("ground", false)

	if flashingLights then
		moveMult = 1
	else
		moveMult = 0.5
	end	
end

function onCreatePost()
	if week ~= "funkMix" and week ~= "funkMixDX" then
		if dadName == "bowser" then
			triggerEvent("Change Character", "dad", "bowser-new")
		end
	end
end

function onCountdownTick(tick)
	if tick == 0 or tick == 2 then
		playAnim("blasterBro", "idle", false)
		updateHitbox("blasterBro")
	end
end

function onBeatHit()
	playAnim("blasterBro", "idle", false)
	updateHitbox("blasterBro")
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if getProperty("gf2.animation.curAnim.name") == "danceLeft" then
			playAnim("hands", "danceLeft", false)
		elseif getProperty("gf2.animation.curAnim.name") == "danceRight" then
			playAnim("hands", "danceRight", false)
		elseif getProperty("gf2.animation.curAnim.name") == "sad" then
			playAnim("hands", "miss", false)
		end
		updateHitbox("hands")

		stormCloudsPos = stormCloudsPos - 96 * elapsed * moveMult
		if (stormCloudsPos + getProperty("stormClouds.width") <= 0) then
			stormCloudsPos = 0
		end
		setProperty("stormClouds.x", math.floor(stormCloudsPos / 6) * 6)
		setProperty("stormClouds2.x", getProperty("stormClouds.x") + getProperty("stormClouds.width"))
		setProperty("stormClouds3.x", getProperty("stormClouds.x") - getProperty("stormClouds.width"))

		if not lowQuality and week ~= "funkMixDX" then
			airship1Pos = airship1Pos + 512 * elapsed * moveMult
			if (airship1Pos >= 149*12) then
				airship1Pos = -149*6
				loadShip1()
			end
			setProperty("airship1.x", math.floor(airship1Pos / 1) * 1)

			airship2Pos = airship2Pos + 448 * elapsed * moveMult
			if (airship2Pos >= 149*12) then
				airship2Pos = -149*8
				loadShip2()
			end
			setProperty("airship2.x", math.floor(airship2Pos / 2) * 2)

			airship3Pos = airship3Pos + 384 * elapsed * moveMult
			if (airship3Pos >= 149*12) then
				airship3Pos = -149*10
				loadShip3()
			end
			setProperty("airship3.x", math.floor(airship3Pos / 3) * 3)

			airship4Pos = airship4Pos + 320 * elapsed * moveMult
			if (airship4Pos >= 149*12) then
				airship4Pos = -149*12
				loadShip4()
			end
			setProperty("airship4.x", math.floor(airship4Pos / 4) * 4)
		end

		if isRunning("scripts/extra/menus/Pause") then
			setProperty("ground.animation.curAnim.paused", false)
			setProperty("hands.animation.curAnim.paused", false)
			setProperty("blasterBro.animation.curAnim.paused", false)
			setProperty("gf2.animation.curAnim.paused", false)
			for i = 1,4 do
				setProperty("airship"..i..".animation.curAnim.paused", false)
			end
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("ground.animation.curAnim.paused", true)
			setProperty("hands.animation.curAnim.paused", true)
			setProperty("blasterBro.animation.curAnim.paused", true)
			setProperty("gf2.animation.curAnim.paused", true)
			for i = 1,4 do
				setProperty("airship"..i..".animation.curAnim.paused", true)
			end
		end
	end
end

function onUpdatePost()
	if curStep == 832 then
		color1 = 0x000f0000
		color2 = 0x004a0000
		color3 = 0x008c0000
		color4 = 0x00efb5b5
		setProperty("airship1.color", color1)
		setProperty("airship2.color", color2)
		setProperty("airship3.color", color3)
		setProperty("airship4.color", color4)
	elseif curStep == 1088 then
		color1 = 0x00000d0f
		color2 = 0x0000424a
		color3 = 0x00007b8c
		color4 = 0x00b5efef
		setProperty("airship1.color", color1)
		setProperty("airship2.color", color2)
		setProperty("airship3.color", color3)
		setProperty("airship4.color", color4)
	end
end

function loadShip1()
	makeAnimatedLuaSprite("airship1", "backgrounds/airship/small-airship-"..getRandomInt(1,5), -149*6, 0)
	addAnimationByPrefix("airship1", "idle", "idle0", 12, true)
	setScrollFactor("airship1", 1, 1)
	setProperty("airship1.antialiasing", false)
	setProperty("airship1.color", color1)
	scaleObject("airship1", 1, 1)
	setObjectOrder("airship1", getObjectOrder("stormClouds3") + 1)
	addLuaSprite("airship1", false)
end

function loadShip2()
	makeAnimatedLuaSprite("airship2", "backgrounds/airship/small-airship-"..getRandomInt(1,5), -149*8, 0)
	addAnimationByPrefix("airship2", "idle", "idle0", 12, true)
	setScrollFactor("airship2", 1, 1)
	setProperty("airship2.antialiasing", false)
	setProperty("airship2.color", color2)
	scaleObject("airship2", 2, 2)
	setObjectOrder("airship2", getObjectOrder("airship1") + 1)
	addLuaSprite("airship2", false)
end

function loadShip3()
	makeAnimatedLuaSprite("airship3", "backgrounds/airship/small-airship-"..getRandomInt(1,5), -149*10, 0)
	addAnimationByPrefix("airship3", "idle", "idle0", 12, true)
	setScrollFactor("airship3", 1, 1)
	setProperty("airship3.antialiasing", false)
	setProperty("airship3.color", color3)
	scaleObject("airship3", 3, 3)
	setObjectOrder("airship3", getObjectOrder("airship2") + 1)
	addLuaSprite("airship3", false)
end

function loadShip4()
	makeAnimatedLuaSprite("airship4", "backgrounds/airship/small-airship-"..getRandomInt(1,5), -149*12, 0)
	addAnimationByPrefix("airship4", "idle", "idle0", 12, true)
	setScrollFactor("airship4", 1, 1)
	setProperty("airship4.antialiasing", false)
	setProperty("airship4.color", color4)
	scaleObject("airship4", 4, 4)
	setObjectOrder("airship4", getObjectOrder("airship3") + 1)
	addLuaSprite("airship4", false)
end