function onCreate()
	setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Green Screen", songName})
	setDataFromSave("playerSettings", "powerUpHP", false)

	makeLuaSprite("oldScreen", nil, 0, 0)
	makeGraphic("oldScreen", screenWidth, screenHeight, "000000")
	setObjectCamera("oldScreen", "other")
	setProperty("oldScreen.alpha", 0)
	addLuaSprite("oldScreen", true)
	if getProperty("border.exists") == true then
		setObjectOrder("oldScreen", getObjectOrder("border") - 1)
	end

	setPropertyFromClass("flixel.FlxG", "sound.music.volume", 0)
	setProperty("vocals.volume", 0)

	playSound("gameboy_off")
	
	doTweenAlpha("turnOff", "oldScreen", 1, 0.1, "linear")
	doTweenAlpha("gameboyBorderFadeOut", "border", 0, 0.1, "linear")
	runTimer("turnOn", 2)
end

function onUpdate()
    setProperty("logoGameboy.y", math.floor(getProperty("logoGameboy.y") / 6) * 6)
end

function onTweenCompleted(tag)
	if tag == "gameboyBorderFadeOut" then
		loadGraphic("border", "borders/gameboyCamera")
	end
	if tag == "tweenFinished" then
		playSound("gameboy_startup")
		runTimer("gotoGreenScreen", 2)
	end
end

function onTimerCompleted(tag)
	if tag == "turnOn" then
		playSound("gameboy_on")
		setProperty("border.alpha", 1)

		makeLuaSprite("bgGameboy", nil, 0, 0)
		makeGraphic("bgGameboy", screenWidth, screenHeight, "9bbc0f")
		setObjectCamera("bgGameboy", "other")
		addLuaSprite("bgGameboy", true)
		setObjectOrder("bgGameboy", getObjectOrder("oldScreen") + 1)

		makeLuaSprite("logoGameboy", "cutscene/gameboy/logo", 0, 0)
		setObjectCamera("logoGameboy", "other")
		scaleObject("logoGameboy", 6, 6)
		setProperty("logoGameboy.antialiasing", false)
		screenCenter("logoGameboy", "xy")
		addLuaSprite("logoGameboy", true)
		setObjectOrder("logoGameboy", getObjectOrder("bgGameboy") + 1)

		local centerY = getProperty("logoGameboy.y")
		setProperty("logoGameboy.y", -40)
		doTweenY("tweenFinished", "logoGameboy", centerY, 1.95, "linear")
	elseif tag == "gotoGreenScreen" then
		endSong()
	end
end