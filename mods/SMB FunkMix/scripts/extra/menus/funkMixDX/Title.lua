local wideScreen = (26 * 6) + 4

local initialized = false
local disclaimerTime = 5
local nextFlash = 0.75

local loadSprites = false

local canControl = true

function onCreate()
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then 
		wideScreen = 0
	end

	if getDataFromSave("songSaveData", "showDisclaimer") then
		if aspectRatio ~= "4:3" then
			makeLuaSprite("disclaimerWide", nil, 0, 0)
			makeGraphic("disclaimerWide", screenWidth, screenHeight, "000000")
			setObjectCamera("disclaimerWide", "other")
			scaleObject("disclaimerWide", 6, 6)
			addLuaSprite("disclaimerWide", false)
		end

		makeLuaSprite("disclaimer", "menus/intro/disclaimer", wideScreen, 0)
		setObjectCamera("disclaimer", "other")
		scaleObject("disclaimer", 6, 6)
		setProperty("disclaimer.antialiasing", false)
		addLuaSprite("disclaimer", false)
	end
end

function onCreatePost()
	if getDataFromSave("songSaveData", "startIntro") == true and not getDataFromSave("songSaveData", "showDisclaimer") then
		disclaimerTime = 0
		startIntro()
	end
end

local bgPos = nil
local velocity = 0
local logoY = nil
local bounces = -1
local sparkleTime = 7.3

function startIntro()
	if not initialized then
		if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then 
			wideScreen = 0
		else
			wideScreen = (26 * 6) + 4
		end

		makeLuaSprite("bgIntro", "menus/intro/bg", wideScreen, 0)
		setObjectCamera("bgIntro", "other")
		scaleObject("bgIntro", 6, 6)
		setProperty("bgIntro.antialiasing", false)
		addLuaSprite("bgIntro", false)

		makeLuaSprite("bgIntro2", "menus/intro/bg", wideScreen + getProperty("bgIntro.width"), 0)
		setObjectCamera("bgIntro2", "other")
		scaleObject("bgIntro2", 6, 6)
		setProperty("bgIntro2.antialiasing", false)
		addLuaSprite("bgIntro2", false)

		makeLuaSprite("bgIntro3", "menus/intro/bg", wideScreen - getProperty("bgIntro.width"), 0)
		setObjectCamera("bgIntro3", "other")
		scaleObject("bgIntro3", 6, 6)
		setProperty("bgIntro3.antialiasing", false)
		addLuaSprite("bgIntro3", false)

		bgPos = getProperty("bgIntro.x")

		makeLuaSprite("infoText", "menus/intro/spare-me-ninjas", wideScreen, 0)
		setObjectCamera("infoText", "other")
		scaleObject("infoText", 6, 6)
		updateHitbox("infoText")
		setProperty("infoText.antialiasing", false)
		addLuaSprite("infoText", false)

		makeLuaSprite("titleText", "menus/intro/title-text", wideScreen, 0)
		setObjectCamera("titleText", "other")
		scaleObject("titleText", 6, 6)
		updateHitbox("titleText")
		setProperty("titleText.antialiasing", false)
		setProperty("titleText.alpha", 0)
		setProperty("titleText.visible", false)
		addLuaSprite("titleText", false)

		makeAnimatedLuaSprite("logo", "menus/intro/logo", wideScreen + 14 * 6, 7 * 6)
		addAnimationByIndices("logo", "still", "idle", "0", 0)
		addAnimationByPrefix("logo", "flash", "flash", 18, true)
		addAnimationByPrefix("logo", "idle", "idle", 24, true)
		setObjectCamera("logo", "other")
		scaleObject("logo", 6, 6)
		setProperty("logo.antialiasing", false)
		addLuaSprite("logo", false)

		logoY = -76
		bounces = 6

		makeAnimatedLuaSprite("deluxe", "menus/intro/deluxe", wideScreen + 74 * 6, 44 * 6)
		addAnimationByIndices("deluxe", "write", "write", "0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16", 14)
		setObjectCamera("deluxe", "other")
		scaleObject("deluxe", 6, 6)
		setProperty("deluxe.antialiasing", false)
		setProperty("deluxe.visible", false)
		addLuaSprite("deluxe", false)

		makeAnimatedLuaSprite("sparkle", "menus/intro/sparkle", wideScreen + 91 * 6, 31 * 6)
		addAnimationByIndices("sparkle", "sparkle", "sparkle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0", 16)
		setObjectCamera("sparkle", "other")
		scaleObject("sparkle", 6, 6)
		setProperty("sparkle.antialiasing", false)
		setProperty("sparkle.visible", false)
		addLuaSprite("sparkle", false)

		setProperty("bgIntro.visible", false)
		setProperty("bgIntro2.visible", false)
		setProperty("bgIntro3.visible", false)
		setProperty("infoText.visible", false)
		setProperty("logo.visible", false)

		setProperty("bgIntro.x", wideScreen)
		setProperty("bgIntro2.x", wideScreen + getProperty("bgIntro.width"))
		setProperty("bgIntro3.x", wideScreen - getProperty("bgIntro.width"))
		setProperty("infoText.x", wideScreen)
		setProperty("titleText.x", wideScreen)
		setProperty("logo.x", wideScreen + 14 * 6)
		setProperty("deluxe.x", wideScreen + 74 * 6)
		setProperty("sparkle.x", wideScreen + 91 * 6)

		initialized = true
		loadSprites = true
		canControl = true
		setDataFromSave("songSaveData", "showDisclaimer", false)
	end
end

local transitioning = false

function onUpdate(elapsed)
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if getTextString("curMenuGlobal") == "0" then
		if loadSprites then
			loadSprites = false
			setProperty("bgIntro.visible", true)
			setProperty("bgIntro2.visible", true)
			setProperty("bgIntro3.visible", true)
			setProperty("infoText.visible", true)
			setProperty("logo.visible", true)
			playMusic("titleMenu", 0.65, false)
			setProperty("disclaimer.visible", false)
			setProperty("disclaimerWide.visible", false)
		end

		if bounces > -1 then
			setProperty("logo.y", math.floor(logoY) * 6)

			velocity = velocity + 300 * elapsed
			logoY = logoY + velocity * elapsed
			if logoY > 7 then
				velocity = -15 * bounces
				logoY = 6
				bounces = bounces - 1
				if bounces < 0 then
					setProperty("logo.y", 7 * 6)
					playAnim("deluxe", "write", true)
					updateHitbox("deluxe")
					
					setProperty("deluxe.visible", true)
				end
			end
		end

		if getPropertyFromClass("flixel.FlxG", "sound.music") ~= nil then
			setPropertyFromClass("Conductor", "songPosition", getPropertyFromClass("flixel.FlxG", "sound.music.time"))
		end

		if keyJustPressed("accept") and not transitioning and initialized and canControl then
			canControl = false
			bounces = -1
			setProperty("logo.y", 7 * 6)
			playAnim("logo", "flash", true)
			updateHitbox("logo")
			playAnim("deluxe", "write", true)
			updateHitbox("deluxe")
			setProperty("deluxe.animation.curAnim.frameRate", 9999)
			setProperty("deluxe.visible", true)
			setProperty("titleText.visible", false)

			if getPropertyFromClass("flixel.FlxG", "sound.music") ~= nil then
				setPropertyFromClass("flixel.FlxG", "sound.music.volume", 0)
			end
			playSound("title_confirm", 0.45)

			transitioning = true

			runTimer("switchMainMenu", 2)
		end

		setTextString("canControlGlobal", canControl)

		if disclaimerTime > 0 then
			disclaimerTime = disclaimerTime - elapsed
			if keyJustPressed("accept") then
				disclaimerTime = 0
			end

			if disclaimerTime <= 0 then
				disclaimerTime = 0
				startIntro()
			end
		end

		if initialized then
			bgPos = bgPos - 166 * elapsed
			if bgPos + getProperty("bgIntro.width") <= 0 then
				bgPos = 0
			end
			setProperty("bgIntro.x", math.floor(bgPos / 6) * 6 - 2)
			setProperty("bgIntro2.x", getProperty("bgIntro.x") + getProperty("bgIntro.width"))
			setProperty("bgIntro3.x", getProperty("bgIntro.x") - getProperty("bgIntro.width"))

			if not transitioning then
				nextFlash = nextFlash - elapsed
				if nextFlash < 0 then
					nextFlash = 0.75
					setProperty("titleText.visible", not getProperty("titleText.visible"))
				end
			end

			if sparkleTime > 0 then
				sparkleTime = sparkleTime - elapsed
				if sparkleTime <= 0 then
					sparkleTime = 0
					setProperty("sparkle.visible", true)
					if not transitioning then
						playAnim("logo", "idle")
						updateHitbox("logo")
					end
				end
			else
				playAnim("sparkle", "sparkle")
				updateHitbox("sparkle")
			end
		end
	end

	if keyJustPressed("back") and getTextString("curMenuGlobal") == "1" and getTextString("subMenuGlobal") == "0" and getTextString ("canControlGlobal") == "true" then
		bgPos = wideScreen
		logoY = -76
		startIntro()
	elseif keyJustPressed("back") and getTextString("curMenuGlobal") == "0" then
		canControl = false
		setDataFromSave("songSaveData", "showDisclaimer", true)
	end
end

function onTimerCompleted(tag)
	if tag == "switchMainMenu" then
		initialized = false
		nextFlash = 0.75
		velocity = 0
		transitioning = false
		sparkleTime = 7.3

		removeLuaSprite("disclaimerWide")
		removeLuaSprite("disclaimer")
		removeLuaSprite("bgIntro")
		removeLuaSprite("bgIntro2")
		removeLuaSprite("bgIntro3")
		removeLuaSprite("infoText")
		removeLuaSprite("logo")
		removeLuaSprite("deluxe")
		removeLuaSprite("sparkle")
	end
end