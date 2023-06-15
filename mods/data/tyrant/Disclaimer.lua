local inMenu = false
local inContext = false

function onCreate()
	if getPropertyFromClass("PlayState", "seenCutscene") == false then
		inContext = true
		inMenu = true
		playMusic("contextTyrant", 1, true)

		makeLuaSprite("contextBlack", nil, 0, 0)
		makeGraphic("contextBlack", screenWidth, screenHeight, "000000")
		setObjectCamera("contextBlack", "other")
		addLuaSprite("contextBlack")

		makeLuaSprite("letter", "backgrounds/blocks/letter", 0, 0)
		setObjectCamera("letter", "other")
		setProperty("letter.antialiasing", false)
		scaleObject("letter", 5, 5)
		screenCenter("letter", "xy")
		addLuaSprite("letter")
		
		makeLuaText("conTxtA", "disclaimer", 0, 0, 0)
		setTextSize("conTxtA", 32)
		setTextFont("conTxtA", "smb3.ttf")
		setObjectCamera("conTxtA", "other")
		screenCenter("conTxtA", "xy")
		setProperty("conTxtA.y", getProperty("conTxtA.y") - 48)
		addLuaText("conTxtA")

		makeLuaText("conTxtB", "this song is for a fanmade mod of the sonic.exe mario mix\nand will be moved to that mod once the pixel demo is finished.\n\npress accept to continue or back to quit", 0, 0, 0)
		setTextSize("conTxtB", 16)
		setTextFont("conTxtB", "smb3.ttf")
		setObjectCamera("conTxtB", "other")
		screenCenter("conTxtB", "xy")
		setProperty("conTxtB.y", getProperty("conTxtB.y") + 32)
		addLuaText("conTxtB")
	end
end

function onUpdate()
	-- Context Cutscene Stuff
	if inContext then
		if keyJustPressed("back") then
			exitSong()
		end
		if keyJustPressed("accept") then
			inContext = false
			outContext = true
			playSound("title_confirm")
			setPropertyFromClass("PlayState", "seenCutscene", true)
			doTweenAlpha("contextFadeOut", "contextBlack", 0, 1, "linear")
			doTweenY("conTxtAOut", "conTxtA", screenHeight+getProperty("conTxtA.y"), 1, "quadIn")
			doTweenY("conTxtBOut", "conTxtB", screenHeight+getProperty("conTxtB.y"), 1, "quadIn")
			doTweenY("outOfContext", "letter", screenHeight+getProperty("letter.y"), 1, "quadIn")
		end
	elseif outContext and not startedCountdown then
		setPropertyFromClass("flixel.FlxG", "sound.music.volume", getPropertyFromClass("flixel.FlxG", "sound.music.volume") - 0.01)
		if getPropertyFromClass("flixel.FlxG", "sound.music.volume") <= 0 then
			startCountdown()
			inMenu = false
		end
	end
end

function onStartCountdown()
	if not getPropertyFromClass("PlayState", "seenCutscene") then
		return Function_Stop
	end
	return Function_Continue
end

function onTweenCompleted(tag)
	if tag == "outOfContext" then
		removeLuaSprite("contextBlack", true)
		removeLuaSprite("letter", true)
		removeLuaText("conTxtA")
		removeLuaText("conTxtB")
	end
end

function onGameOver()
	if inMenu then
		return Function_Stop
	end
end