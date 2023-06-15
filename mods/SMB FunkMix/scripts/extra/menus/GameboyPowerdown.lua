local exiting = false

function onCreate()
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if week == "funkMixDX" then
		setDataFromSave("playerSettings", "powerUpHP", getDataFromSave("songSaveData", "defPowerUpSet"))
	end
	setTextString("stopCountdown", true)
	setPropertyFromClass("PlayState", "deathCounter", getPropertyFromClass("PlayState", "deathCounter") + 1)
	
	setPropertyFromClass("PlayState", "SONG.validScore", false)
	setProperty("boyfriend.stunned", true)
	if week == "funkMixDX" then
		setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix DX"})
	end

	makeLuaSprite("oldScreen", nil, 0, 0)
	makeGraphic("oldScreen", screenWidth, screenHeight, "000000")
	setObjectCamera("oldScreen", "other")
	setProperty("oldScreen.alpha", 0)
	addLuaSprite("oldScreen", true)
	if getProperty("border.exists") == true then
		setObjectOrder("oldScreen", getObjectOrder("border") - 1)
	end
	if getDataFromSave("playerSettings", "compatMode") ~= true then
		if getTextString("isPaused") == "true" then
			if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") == true then
				runHaxeCode([[
					bgSpr = new FlxSprite(160).makeGraphic(960, 720, 0xFF000000);
					bgSpr.alpha = 0;
					CustomSubstate.instance.add(bgSpr);
					FlxTween.tween(bgSpr, {alpha: 1 }, 0.1);
				]])
			else
				runHaxeCode([[
					bgSpr = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
					bgSpr.alpha = 0;
					CustomSubstate.instance.add(bgSpr);
					FlxTween.tween(bgSpr, {alpha: 1 }, 0.1);
				]])
			end
		else
			openCustomSubstate("GameboyPowerdown", true)
		end
		if week ~= "funkMixDX" then
			runTimer("turnOff", 1)
		end
	else
		doTweenAlpha("turnOff", "oldScreen", 1, 0.1, "linear")
	end
	runTimer("turnOn", 2)
	doTweenAlpha("gameboyBorderFadeOut", "border", 0, 0.1, "linear")
	runTimer("funkMixDXborderDelay", 1)
	playSound("gameboy_off")

	setProperty("updateTime", false)
	currentpausepos = getSongPosition()
end

function onCustomSubstateCreate(name)
	if name == "GameboyPowerdown" then
		if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") == true then
			runHaxeCode([[
				bgSpr = new FlxSprite(160).makeGraphic(960, 720, 0xFF000000);
				bgSpr.alpha = 0;
				CustomSubstate.instance.add(bgSpr);
				FlxTween.tween(bgSpr, {alpha: 1 }, 0.1);
			]])
		else
			runHaxeCode([[
				bgSpr = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
				bgSpr.alpha = 0;
				CustomSubstate.instance.add(bgSpr);
				FlxTween.tween(bgSpr, {alpha: 1 }, 0.1);
			]])
		end
	end
end

function onUpdate()
	if not exiting then
		setPropertyFromClass("flixel.FlxG", "sound.music.volume", 0)
		setProperty("vocals.volume", 0)
		curBfHeyTimer = getProperty("boyfriend.heyTimer")
		curDadHeyTimer = getProperty("dad.heyTimer")
		curGfHeyTimer = getProperty("gf.heyTimer")

		setPropertyFromClass("Conductor", "songPosition", currentpausepos)
		setPropertyFromClass("flixel.FlxG", "sound.music.time", currentpausepos)
		setProperty("vocals.time", currentpausepos)

		setProperty("boyfriend.animation.curAnim.paused", true)
		setProperty("dad.animation.curAnim.paused", true)
		setProperty("gf.animation.curAnim.paused", true)

		setProperty("boyfriend.heyTimer", curBfHeyTimer)
		setProperty("dad.heyTimer", curDadHeyTimer)
		setProperty("gf.heyTimer", curGfHeyTimer)

		setProperty("boyfriend.specialAnim", true)
		setProperty("dad.specialAnim", true)
		setProperty("gf.specialAnim", true)
	end

	if getProperty("health") <= 0 and keyJustPressed("accept") and week ~= "funkMix" and week ~= "funkMixDX" then
		restartSong(true)
	end
end

function onUpdatePost()
	setSoundVolume("countdown3", 0)
	setSoundVolume("countdown2", 0)
	setSoundVolume("countdown1", 0)
	setSoundVolume("countdownGo", 0)
end

function onEndSong()
	if exiting then
		return Function_Stop
	end
	return Function_Continue
end

function onPause()
	return Function_Stop
end

function onTimerCompleted(tag)
	if tag == "funkMixDXborderDelay" then
		if week == "funkMixDX" then
			loadGraphic("border", "borders/default")
			doTweenAlpha("funkMixDXborderFadeIn", "border", 1, 1, "linear")
		end
	end
	if tag == "turnOn" then
		if week == "funkMixDX" then
			endSong()
		else
			if getProperty("health") <= 0 then
				restartSong(true)
			else
				exiting = true
				exitSong(false)
			end
		end
	elseif tag == "turnOff" then
		setProperty("oldScreen.alpha", 1)
		setObjectOrder("oldScreen", getObjectOrder("blackBox"))
	end
end