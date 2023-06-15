local inCutscene = false
local inContext = false
local inMenu = false

function onCreate()
	if getPropertyFromClass("PlayState", "seenCutscene") == false then
		inCutscene = true
		inMenu = true
		playMusic("contextOverfilled", 0.75, true)

		makeLuaSprite("overfilledScreen", nil, 0, 0)
		makeGraphic("overfilledScreen", screenWidth, screenHeight, "000000")
		setObjectCamera("overfilledScreen", "other")
		addLuaSprite("overfilledScreen")

		makeLuaSprite("context", "backgrounds/overfilled/context", 0, 5)
		scaleObject("context", 0.5, 0.5)
		setObjectCamera("context", "other")
		screenCenter("context", "x")
		addLuaSprite("context")

		makeLuaSprite("ravioliScreen", nil, 0, 0)
		makeGraphic("ravioliScreen", screenWidth, screenHeight, "75d1ff")
		setObjectCamera("ravioliScreen", "other")
		addLuaSprite("ravioliScreen")

		makeLuaSprite("leDots", "backgrounds/overfilled/dots", 0, 0)
		setObjectCamera("leDots", "other")
		screenCenter("leDots", "x")
		addLuaSprite("leDots")
		
		makeLuaText("conTxtA", "DISCLAIMER", 0, 0, 0)
		setTextSize("conTxtA", 32)
		setTextFont("conTxtA", "smb1.ttf")
		setObjectCamera("conTxtA", "other")
		screenCenter("conTxtA", "xy")
		setProperty("conTxtA.y", getProperty("conTxtA.y") - 64)
		addLuaText("conTxtA")

		makeLuaText("conTxtB", "This song and current music is from Sky Remanifested\n\nThe following image is what happened before said song\n\n\nUse Up/Down Keys To Move Page\n\nPress Accept to continue or Back to quit", 0, 0, 0)
		setTextSize("conTxtB", 15)
		setTextFont("conTxtB", "pixel_small.ttf")
		setObjectCamera("conTxtB", "other")
		screenCenter("conTxtB", "xy")
		setProperty("conTxtB.y", getProperty("conTxtB.y") + 30)
		addLuaText("conTxtB")

		makeLuaText("conTxtC", "I would've had an animated cutscene here,\n\nbut I'm not skilled enough to do it myself", 0, 0, 0)
		setTextSize("conTxtC", 10)
		setTextFont("conTxtC", "pixel_smaller.ttf")
		setObjectCamera("conTxtC", "other")
		screenCenter("conTxtC", "x")
		setProperty("conTxtC.y", getProperty("conTxtB.y") + 140)
		addLuaText("conTxtC")
	end
end

function onUpdate()
	-- Context Cutscene Stuff because I can't animate all this
	if inCutscene then
		if keyJustPressed("back") then
			exitSong()
		end
		if not inContext then
			if keyJustPressed("accept") then
				inCutscene = false
				outCutscene = true
				playSound("stomp")
				doTweenY("ravioliOut", "ravioliScreen", screenHeight, 1, "quadIn")
				doTweenY("dotsOut", "leDots", screenHeight, 1, "quadIn")
				doTweenY("conTxtAOut", "conTxtA", screenHeight+getProperty("conTxtA.y"), 1, "quadIn")
				doTweenY("conTxtBOut", "conTxtB", screenHeight+getProperty("conTxtB.y"), 1, "quadIn")
				doTweenY("conTxtCOut", "conTxtC", screenHeight+getProperty("conTxtC.y"), 1, "quadIn")
			end
		end
	elseif outCutscene then
		if keyJustPressed("back") then
			exitSong()
		end
		if keyJustPressed("accept") then
			outCutscene = false
			inContext = false
			outContext = true
			playSound("title_confirm")
			setPropertyFromClass("PlayState", "seenCutscene", true)
			doTweenAlpha("overfilledOut", "overfilledScreen", 0, 1, "linear")
			doTweenX("outOfContext", "context", screenWidth+getProperty("context.x"), 1, "quadIn")
		end
	elseif inContext then
		if keyJustPressed("back") then
			exitSong()
		end

		if keyPressed("down") then
			if getProperty("context.y") > -535 then
				setProperty("context.y", getProperty("context.y") - 5)
			else
				setProperty("context.y", -535)
			end
		end

		if keyPressed("up") then
			if getProperty("context.y") < 5 then
				setProperty("context.y", getProperty("context.y") + 5)
			else
				setProperty("context.y", 5)
			end
		end

		if keyJustPressed("accept") then
			inContext = false
			outContext = true
			playSound("title_confirm")
			setPropertyFromClass("PlayState", "seenCutscene", true)
			doTweenAlpha("overfilledOut", "overfilledScreen", 0, 1, "linear")
			doTweenX("outOfContext", "context", screenWidth+getProperty("context.x"), 1, "quadIn")
		end
	elseif outContext and not startedCountdown then
		setPropertyFromClass("flixel.FlxG", "sound.music.volume", getPropertyFromClass("flixel.FlxG", "sound.music.volume") - 0.01)
		if getPropertyFromClass("flixel.FlxG", "sound.music.volume") <= 0 then
			startCountdown()
			inMenu = false
		end
	end
end

function onCountdownStarted()
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		setPropertyFromClass("flixel.FlxG", "width", 960)
	end
end

function onTweenCompleted(tag)
	if tag == "ravioliOut" then
		removeLuaSprite("ravioliScreen", true)
		removeLuaSprite("leDots", true)
		removeLuaText("conTxtA")
		removeLuaText("conTxtB")
		removeLuaText("conTxtC")
		if not outContext then
			inContext = true
			outCutscene = false
		end
	elseif tag == "outOfContext" then
		removeLuaSprite("overfilledScreen", true)
		removeLuaSprite("context", true)
	end
end

function onStartCountdown()
	if not getPropertyFromClass("PlayState", "seenCutscene") then
		return Function_Stop
	end
end

function onGameOver()
	if inMenu then
		return Function_Stop
	end
end