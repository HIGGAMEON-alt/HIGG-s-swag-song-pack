local grpMenuShit = {"songText1", "songText2", "songText3"}
local menuItems = {"CONTINUE", "RETRY", "END"}
local curSelected = 1
local transitionType = 0
local canControl = false
local bgPos = nil
local wideScreen = (26 * 6) + 4
local canPause = false
local cantEnd = false
local exiting = false
paused = false

onPauseSound = "pause"
unpauseSound = "pause"
confirmSound = "stomp"
exitSound = "coin"
selectSound = "menu_select"

function onCreate()
	isMari0 = songName:find("Portal Power")
	isMinus = songName:find("Wrong Warp")
	isSMM = songName:find("First Level")
	isGameboy = songName:find("Green Screen")
	isMX = songName:find("Game Over")
	isKirby = songName:find("Hyperactive Starblaze")
	isBSide = songName:find("B-Side")
	isSMB3 = songName:find("Hammered") or songName:find("HEAR ITS CRY") or songName:find("Tyrant")

	pausePath = "menus/pause/PAUSE"
	marioPath = "menus/pause/walking"
	barPath = "menus/pause/progressbar"
	bgPath = "menus/pause/bg"
	bgWidePath = nil
	selectorPath = "menus/pause/selector"

	if isMinus then
		pausePath = "menus/pause/PAUSE-glitched"
		marioPath = "menus/pause/walking-glitched"
	end

	if isMari0 then
		marioPath = "menus/pause/mari0/walking"
		barPath = "menus/pause/mari0/progressbar"
	end

	if isSMM then
		marioPath = "menus/pause/smm/walking"
		barPath = "menus/pause/smm/progressbar"
	end

	if isGameboy then
		pausePath = "menus/pause/gameboy/PAUSE"
		marioPath = "menus/pause/gameboy/walking"
		barPath = "menus/pause/gameboy/progressbar"
		bgPath = "menus/pause/gameboy/bg"
		selectorPath = "menus/pause/gameboy/selector"
	end

	if isMX then
		pausePath = "menus/pause/pcport/PAUSE"
		if week == "funkMixMX" then
			marioPath = "menus/pause/pcport/walking-old"
		else
			marioPath = "menus/pause/pcport/walking"
		end
		barPath = "menus/pause/pcport/progressbar"

		onPauseSound = "pause-pcport"
		unpauseSound = "pause-pcport"
		confirmSound = "pcport/stomp"
		exitSound = "pcport/coin"
		selectSound = "pcport/menu_select"
	end

	if isKirby then
		pausePath = "menus/pause/kirby/PAUSE"
		marioPath = "menus/pause/kirby/walking"
		bgPath = "menus/pause/kirby/bg"
		barPath = "menus/pause/kirby/progressbar"
		bgWidePath = "menus/pause/kirby/bgWide"
	end

	if isBSide then
		marioPath = "menus/pause/bSide/walking"
	end

	if isSMB3 then
		pausePath = "menus/pause/smb3/PAUSE"
		marioPath = "menus/pause/smb3/walking"
		selectorPath = "menus/pause/smb3/selector"
	end

	makeLuaText("isPaused", paused, 0, 0, 32)
	setObjectCamera("isPaused", "other")
	makeLuaText("curSelectedGlobal", curSelected, 0, 0, 48)
	setObjectCamera("curSelectedGlobal", "other")
	makeLuaText("transitionType", transitionType, 0, 0, 64)
	setObjectCamera("transitionType", "other")
	makeLuaText("getBgPos", bgPos, 0, 0, 80)
	setObjectCamera("getBgPos", "other")
	if getDataFromSave("playerSettings", "debugInfo") == true and songName ~= "Funk Mix" and songName ~= "Funk Mix DX" and songName ~= "Options" then
		addLuaText("isPaused")
		addLuaText("curSelectedGlobal")
		addLuaText("transitionType")
		addLuaText("getBgPos")
	end

	makeLuaSprite("bgPause", bgPath, 0, 0)
	setObjectCamera("bgPause", "hud")
	scaleObject("bgPause", 6, 6)
	screenCenter("bgPause", "x")
	setProperty("bgPause.antialiasing", false)
	bgPos = screenHeight
	setProperty("bgPause.y", screenHeight)

	local bgColor = string.format("%x", getPixelColor("bgPause", 0, 0))
	bgColor = string.sub(bgColor, 11, 16)
	if getDataFromSave("playerSettings", "aspectRatio") ~= "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		makeLuaSprite("bgPauseWide", bgWidePath, 0, 0)
		if bgWidePath == nil then
			makeGraphic("bgPauseWide", screenWidth, screenHeight, bgColor)
		end
		setObjectCamera("bgPauseWide", "hud")
		setProperty("bgPauseWide.y", screenHeight)
	end

	makeLuaText("levelInfo", songName, 0, 0, 31 * 6 - 3)
	setTextSize("levelInfo", 8 * 6)
	setTextBorder("levelInfo", 0, "000000")
	setTextFont("levelInfo", "smb1.ttf")
	setObjectCamera("levelInfo", "hud")
	updateHitbox("levelInfo")
	levelInfoPos = getProperty("levelInfo.y")
	if songName == "First Level" then
		setTextString("levelInfo", "first level :)")
	elseif songName == "Tyrant Easy" then
		setTextString("levelInfo", "Tyrant")
	end
	if #getTextString("levelInfo") > 20 then
		local levelInfo = getTextString("levelInfo")
		local reverseInfo = levelInfo:reverse()
		local newLevelInfo = reverseInfo:gsub("%s", "\n", 1):reverse()
		setTextString("levelInfo", newLevelInfo)
	end

	makeLuaSprite("pauseText", pausePath, 0, 7 * 6)
	setObjectCamera("pauseText", "hud")
	scaleObject("pauseText", 6, 6)
	setProperty("pauseText.antialiasing", false)
	pauseTextPos = getProperty("pauseText.y")

	makeLuaSprite("progressBar", barPath, 0, 57 * 6)
	if version == "0.6" or version == "0.6.1" or version == "0.6.2" then
		setObjectCamera("progressBar", "hud")
		scaleObject("progressBar", 6, 6)
		setProperty("progressBar.antialiasing", false)
	else
		setProperty("progressBar.visible", false)
	end
	progressBarPos = getProperty("progressBar.y")

	makeAnimatedLuaSprite("marioPause", marioPath, 0, 46 * 6)
	if version == "0.6" or version == "0.6.1" or version == "0.6.2" then
		addAnimationByPrefix("marioPause", "walk", "walk0", 9, true)
		setObjectCamera("marioPause", "hud")
		scaleObject("marioPause", 6, 6)
		setProperty("marioPause.antialiasing", false)
	else
		setProperty("marioPause.visible", false)
	end
	marioPausePos = getProperty("marioPause.y")
	if songName == "Game Over" and week ~= "funkMixMX" then
		makeAnimatedLuaSprite("blenis", "menus/pause/pcport/walking-alt", 0, 46 * 6)
		removeLuaSprite("blenis")
	end

	makeLuaSprite("selector", selectorPath, 0, 12 * 6)
	setObjectCamera("selector", "hud")
	scaleObject("selector", 6, 6)
	setProperty("selector.antialiasing", false)

	for i = 1,#menuItems do
		makeLuaText("songText"..i, menuItems[i], 0, 0, (16 * 6 * (i - 1)) + (71 * 6) - 3)
		setTextSize("songText"..i, 8 * 6)
		setTextBorder("songText"..i, 0, "000000")
		setTextFont("songText"..i, "smb1.ttf")
		setObjectCamera("songText"..i, "hud")
		updateHitbox("songText"..i)

		if i == 1 then
			screenCenter("songText"..i, "x")
			setProperty("songText"..i..".x", (math.floor(getProperty("songText"..i..".x") / 6) * 6) + (1 * 6) + 1)
		else
			setProperty("songText"..i..".x", getProperty("songText1.x"))
		end
		songText1Pos = getProperty("songText1.y")
		songText2Pos = getProperty("songText2.y")
		songText3Pos = getProperty("songText3.y")
	end

	if isGameboy then
		bgColor = "0f380f"
	else
		bgColor = "000000"
	end
	makeLuaSprite("blackBox", nil, 0, 0)
	makeGraphic("blackBox", screenWidth, screenHeight, bgColor)
	setObjectCamera("blackBox", "hud")
	setProperty("blackBox.visible", false)

	screenCenter("levelInfo", "x")
	setProperty("levelInfo.x", math.floor(getProperty("levelInfo.x") / 6) * 6 + (1 * 6) + 1)

	screenCenter("pauseText", "x")
	setProperty("pauseText.x", math.floor(getProperty("pauseText.x") / 6) * 6 - (1 * 6) + 2)

	screenCenter("progressBar", "x")
	setProperty("progressBar.x", math.floor(getProperty("progressBar.x") / 6) * 6 + (1 * 6) - 2)

	if isGameboy then
		setTextColor("levelInfo", "9BBC0F")
		for i = 1,#menuItems do
			setTextColor("songText"..i, "9BBC0F")
		end
	end
end

function onCustomSubstateCreate(name)
	if name == "funkMixPauseState" then
		if songName == "Game Over" and week ~= "funkMixMX" then
			if curBeat < 64 then
				marioPath = "menus/pause/pcport/walking-alt"
			else
				marioPath = "menus/pause/pcport/walking"
			end
		end
		if isKirby then
			runHaxeCode([[
				progressBar = new FlxSprite(0, (60 * 6)).loadGraphic(Paths.modsImages("]]..barPath..[["));
				progressBar.setGraphicSize(progressBar.width * 6);
				progressBar.antialiasing = false;
				CustomSubstate.instance.add(progressBar);
				progressBar.x = ]]..getProperty("progressBar.x")..[[;
	
				mario = new FlxSprite(0, (56 * 6)).loadGraphic(Paths.modsImages("]]..marioPath..[["), true, 16, 16);
				mario.animation.add("walk", [0, 0, 1, 2, 2, 1], 9, true);
				mario.animation.play("walk");
				mario.setGraphicSize(mario.width * 6);
				mario.antialiasing = false;
				CustomSubstate.instance.add(mario);

				fadeScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
				fadeScreen.alpha = 0;
				CustomSubstate.instance.add(fadeScreen);
				FlxTween.tween(fadeScreen, {alpha: 1 }, 0.25, {
					onComplete: function(twn:FlxTween) {
						FlxTween.tween(fadeScreen, {alpha: 0 }, 0.25);
					}
				});
			]])
			runTimer("pauseScreenIn", 0.25)
		elseif isGameboy then
			runHaxeCode([[
				progressBar = new FlxSprite(0, (60 * 6)).loadGraphic(Paths.modsImages("]]..barPath..[["));
				progressBar.setGraphicSize(progressBar.width * 6);
				progressBar.antialiasing = false;
				CustomSubstate.instance.add(progressBar);
				progressBar.x = ]]..getProperty("progressBar.x")..[[;

				mario = new FlxSprite(0, (56 * 6)).loadGraphic(Paths.modsImages("]]..marioPath..[["), true, 16, 16);
				mario.animation.add("walk", [0, 0, 1, 2], 9, true);
				mario.animation.play("walk");
				mario.setGraphicSize(mario.width * 6);
				mario.antialiasing = false;
				CustomSubstate.instance.add(mario);

				fadeScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF0F380F);
				fadeScreen.visible = false;
				CustomSubstate.instance.add(fadeScreen);
			]])
		else
			runHaxeCode([[
				progressBar = new FlxSprite(0, (60 * 6)).loadGraphic(Paths.modsImages("]]..barPath..[["));
				progressBar.setGraphicSize(progressBar.width * 6);
				progressBar.antialiasing = false;
				CustomSubstate.instance.add(progressBar);
				progressBar.x = ]]..getProperty("progressBar.x")..[[;

				mario = new FlxSprite(0, (56 * 6)).loadGraphic(Paths.modsImages("]]..marioPath..[["), true, 16, 16);
				mario.animation.add("walk", [0, 0, 1, 2], 9, true);
				mario.animation.play("walk");
				mario.setGraphicSize(mario.width * 6);
				mario.antialiasing = false;
				CustomSubstate.instance.add(mario);

				fadeScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
				fadeScreen.visible = false;
				CustomSubstate.instance.add(fadeScreen);
			]])
		end
	end
end

function onCreatePost()
	if isSMB3 or getDataFromSave("playerSettings", "showcaseCam") == true then
		setObjectCamera("bgPause", "other")
		setObjectCamera("bgPauseWide", "other")
		setObjectCamera("levelInfo", "other")
		setObjectCamera("pauseText", "other")
		setObjectCamera("progressBar", "other")
		setObjectCamera("marioPause", "other")
		setObjectCamera("selector", "other")
		for i = 1,#menuItems do
			setObjectCamera("songText"..i, "other")
		end
		setObjectCamera("blackBox", "other")
		if getProperty("border.exists") == true then
			setObjectOrder("bgPause", getObjectOrder("border") - 1)
			setObjectOrder("bgPauseWide", getObjectOrder("border") - 1)
			setObjectOrder("levelInfo", getObjectOrder("border") - 1)
			setObjectOrder("pauseText", getObjectOrder("border") - 1)
			setObjectOrder("progressBar", getObjectOrder("border") - 1)
			setObjectOrder("marioPause", getObjectOrder("border") - 1)
			setObjectOrder("selector", getObjectOrder("border") - 1)
			for i = 1,#menuItems do
				setObjectOrder("songText"..i, getObjectOrder("border") - 1)
			end
			setObjectOrder("blackBox", getObjectOrder("border") - 1)
		end
	end

	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then 
		setProperty("progressBar.x", getProperty("progressBar.x") - wideScreen)
		setProperty("bgPause.x", getProperty("bgPause.x") - wideScreen)
		setProperty("levelInfo.x", getProperty("levelInfo.x") - wideScreen)
		setProperty("pauseText.x", getProperty("pauseText.x") - wideScreen)
		setProperty("selector.x", getProperty("selector.x") - wideScreen)
		setProperty("songText1.x", getProperty("songText1.x") - wideScreen)
		setProperty("songText2.x", getProperty("songText2.x") - wideScreen)
		setProperty("songText3.x", getProperty("songText3.x") - wideScreen)
	end
	if getDataFromSave("playerSettings", "showcaseCam") == true then
		if getDataFromSave("playerSettings", "aspectRatio") ~= "4:3" then
			setProperty("bgPause.visible", false)
		end
		setProperty("bgPauseWide.alpha", 0.5)
		setProperty("bgPause.alpha", 0.5)
	end

	if isSMB3 then
		setProperty("bgPause.visible", false)
		setProperty("bgPauseWide.visible", false)
		setTextFont("levelInfo", "smb3.ttf")
		setTextColor("levelInfo", "feccc5")
		setTextBorder("levelInfo", 6, "000000")
		setTextString("levelInfo", string.lower(" "..getTextString("levelInfo")))
		for i = 1,#menuItems do
			setTextFont("songText"..i, "smb3.ttf")
			setTextColor("songText"..i, "feccc5")
			setTextBorder("songText"..i, 6, "000000")
			setTextString("songText"..i, string.lower(" "..getTextString("songText"..i)))
		end
		screenCenter("levelInfo", "x")
		setProperty("levelInfo.x", math.floor(getProperty("levelInfo.x") / 6) * 6 + 1)
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showcaseCam") == true then
			setProperty("levelInfo.x", getProperty("levelInfo.x") - wideScreen)
		end
		unpauseSound = ""
	elseif isKirby then
		setProperty("selector.color", 0x00000000)
		setTextFont("levelInfo", "kirbys-adventure.ttf")
		screenCenter("levelInfo", "x")
		setProperty("levelInfo.x", getProperty("levelInfo.x") - 1)
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showcaseCam") == true then
			setProperty("levelInfo.x", getProperty("levelInfo.x") - wideScreen)
		end
		setTextColor("levelInfo", "000000")
		for i = 1,#menuItems do
			setTextFont("songText"..i, "kirbys-adventure.ttf")
			setTextColor("songText"..i, "000000")
		end
		pauseTextPos = pauseTextPos + 6
		setProperty("blackBox.alpha", 0)
		setProperty("blackBox.visible", true)
		onPauseSound = "pause-kirby"
		unpauseSound = "confirm-kirby"
		confirmSound = "confirm-kirby"
		exitSound = "door_open-kirby"
		selectSound = "menu_select-kirby"
	end

	addLuaSprite("bgPauseWide", true)
	addLuaSprite("bgPause", true)
	addLuaText("levelInfo")
	addLuaSprite("pauseText", true)
	addLuaSprite("progressBar", true)
	addLuaSprite("marioPause", true)
	addLuaSprite("selector", true)
	for i = 1,#menuItems do
		addLuaText(grpMenuShit[i])
	end
	addLuaSprite("blackBox", true)
end

function update(elapsed)
	if not inCutscene then
		if keyJustPressed("pause") and startedCountdown and canPause then
			if not paused then
				openCustomSubstate("funkMixPauseState", true)
				setPropertyFromClass("PlayState", "instance.canReset", false)
				playSound(onPauseSound)
				paused = true
				if isKirby then
				elseif isSMB3 then
					setProperty("boyfriend.visible", false)
					setProperty("dad.visible", false)
					setProperty("gf.visible", false)
					setProperty("rating.exists", false)
					setProperty("camHUD.visible", false)
					bgPos = 0
					setProperty("bgPause.y", 0)
					setProperty("bgPauseWide.y", 0)
					canControl = false
				else
					transitionType = 1
				end
			end
		end
	end
	setTextString("isPaused", paused)
	if isSMB3 and not keyJustPressed("pause") then
		canControl = true
	end

	if canControl and paused then
		if keyJustPressed("up") then
			changeSelection(-1)
			setTextString("curSelectedGlobal", curSelected)
		end
		if keyJustPressed("down") then
			changeSelection(1)
			setTextString("curSelectedGlobal", curSelected)
		end
	end

	if keyJustPressed("accept") and canControl and getProperty("bgPause.y") == 0 then
		local daSelected = menuItems[curSelected]

		if isKirby then
			runHaxeCode([[FlxTween.tween(fadeScreen, {alpha: 1 }, 0.25);]])
		end
	
		if daSelected == "CONTINUE" then
			if isKirby then
				runTimer("pauseScreenOut", 0.25)
			elseif isSMB3 then
				bgPos = screenHeight
				setProperty("bgPause.y", screenHeight)
				setProperty("bgPauseWide.y", screenHeight)
				paused = false
				setPropertyFromClass("PlayState", "instance.canReset", true)
				setProperty("boyfriend.visible", true)
				setProperty("dad.visible", true)
				setProperty("gf.visible", true)
				setProperty("rating.exists", true)
				if getDataFromSave("playerSettings", "showcaseCam") ~= true then
					setProperty("camHUD.visible", true)
				end
				closeCustomSubstate()
			else
				transitionType = -1
			end
			canControl = false
			playSound(unpauseSound)
		elseif daSelected == "RETRY" then
			playSound(confirmSound)
			setProperty("blackBox.visible", true)
			if getDataFromSave("playerSettings", "showBorder") ~= true then
				runHaxeCode([[fadeScreen.visible = true;]])
			else
				runHaxeCode([[
					progressBar.visible = false;
					mario.visible = false;
				]])
			end
			canControl = false
			runTimer("retrySong", 1)
		elseif daSelected == "END" then
			setPropertyFromClass("PlayState", "SONG.validScore", false)
			if week == "funkMix" then
				setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix"})
			elseif week == "funkMixDX" then
				setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix DX"})
			end

			if isGameboy then
				canControl = false
				addLuaScript("scripts/extra/menus/GameboyPowerdown")
				cantEnd = false
				canPause = false
				paused = false
			else
				playSound(exitSound)
				setProperty("blackBox.visible", true)
				if getDataFromSave("playerSettings", "showBorder") ~= true then
					runHaxeCode([[fadeScreen.visible = true;]])
				else
					runHaxeCode([[
						progressBar.visible = false;
						mario.visible = false;
					]])
				end
				canControl = false
				runTimer("exitToMenu", 1)
			end
		end
	end

	if transitionType == 1 then
		bgPos = bgPos - (18 * 130 * elapsed)
		setProperty("bgPause.y", math.floor(bgPos / 6) * 6)
		setProperty("bgPauseWide.y", math.floor(bgPos / 6) * 6)
		if bgPos <= 0 then
			bgPos = 0
			setProperty("bgPause.y", 0)
			setProperty("bgPauseWide.y", 0)
			transitionType = 0
			canControl = true
		end
	end

	if transitionType == -1 then
		bgPos = bgPos + (18 * 130 * elapsed)
		setProperty("bgPause.y", math.floor(bgPos / 6) * 6)
		setProperty("bgPauseWide.y", math.floor(bgPos / 6) * 6)
		if bgPos >= screenHeight then
			bgPos = screenHeight
			setProperty("bgPause.y", screenHeight)
			setProperty("bgPauseWide.y", screenHeight)
			transitionType = 0
			paused = false
			setPropertyFromClass("PlayState", "instance.canReset", true)
			closeCustomSubstate()
		end
	end

	setProperty("songText1.y", songText1Pos + getProperty("bgPause.y"))
	setProperty("songText2.y", songText2Pos + getProperty("bgPause.y"))
	setProperty("songText3.y", songText3Pos + getProperty("bgPause.y"))
	setProperty("levelInfo.y", levelInfoPos + getProperty("bgPause.y"))
	setProperty("pauseText.y", pauseTextPos + getProperty("bgPause.y"))
	setProperty("progressBar.y", progressBarPos + getProperty("bgPause.y"))
	setProperty("marioPause.y", marioPausePos + getProperty("bgPause.y"))

	if not canControl then
		if menuItems[curSelected] == "CONTINUE" then
			curSelected = 1
		end
		setProperty("selector.x", getProperty("songText1.x") - (9 * 6) + 3)
		setProperty("selector.y", getProperty("songText1.y") + (1 * 6) - 3)
	end
end

function onUpdate(elapsed)
	if version ~= "0.6" and version ~= "0.6.1" and version ~= "0.6.2" then
		update(elapsed)
	else
		if not inCutscene then
			if keyJustPressed("pause") and startedCountdown and canPause then
				if not paused then
					setPropertyFromClass("PlayState", "instance.canReset", false)
					setPropertyFromClass("flixel.FlxG", "sound.music.volume", 0)
					setProperty("vocals.volume", 0)
					playSound(onPauseSound)
					currentpausepos = getPropertyFromClass("Conductor", "songPosition")
					bfPause = getProperty("boyfriend.animation.curAnim.paused")
					dadPause = getProperty("dad.animation.curAnim.paused")
					bf2Pause = getProperty("boyfriend2.animation.curAnim.paused")
					dad2Pause = getProperty("dad2.animation.curAnim.paused")
					gfPause = getProperty("gf.animation.curAnim.paused")
					gf2Pause = getProperty("gf2.animation.curAnim.paused")
					curDadHeyTimer = getProperty("dad.heyTimer")
					curGfHeyTimer = getProperty("gf.heyTimer")
					curBfHeyTimer = getProperty("boyfriend.heyTimer")
					curDadHeyTimer = getProperty("dad.heyTimer")
					curGfHeyTimer = getProperty("gf.heyTimer")
					paused = true
					if isKirby then
						doTweenAlpha("pauseScreenIn", "blackBox", 1, 0.25, "linear")
					elseif isSMB3 then
						setProperty("boyfriend.visible", false)
						setProperty("dad.visible", false)
						setProperty("gf.visible", false)
						setProperty("rating.exists", false)
						setProperty("camHUD.visible", false)
						bgPos = 0
						setProperty("bgPause.y", 0)
						setProperty("bgPauseWide.y", 0)
						canControl = true
					else
						transitionType = 1
					end
				end
			end
		end
	
		if paused then
			setPropertyFromClass("Conductor", "songPosition", currentpausepos)
			setPropertyFromClass("flixel.FlxG", "sound.music.time", currentpausepos)
			setProperty("vocals.time", currentpausepos)
			
			setProperty("boyfriend.animation.curAnim.paused", true)
			setProperty("dad.animation.curAnim.paused", true)
			setProperty("boyfriend2.animation.curAnim.paused", true)
			setProperty("dad2.animation.curAnim.paused", true)
			setProperty("gf.animation.curAnim.paused", true)
	
			setProperty("boyfriend.heyTimer", curBfHeyTimer)
			setProperty("dad.heyTimer", curDadHeyTimer)
			setProperty("gf.heyTimer", curGfHeyTimer)
	
			if getProperty("boyfriend.animation.curAnim.name") ~= "idle" then
				bfSpecialAnim = getProperty("boyfriend.specialAnim")
				setProperty("boyfriend.specialAnim", true)
			end
			if getProperty("dad.animation.curAnim.name") ~= "idle" then
				dadSpecialAnim = getProperty("dad.specialAnim")
				setProperty("dad.specialAnim", true)
			end
			if getProperty("gf.animation.curAnim.name") ~= "idle" and getProperty("gf.animation.curAnim.name") ~= "danceIdle" then
				gfSpecialAnim = getProperty("gf.specialAnim")
				setProperty("gf.specialAnim", true)
			end
		end
		setTextString("isPaused", paused)

		if canControl and paused then
			if keyJustPressed("up") then
				changeSelection(-1)
				setTextString("curSelectedGlobal", curSelected)
			end
			if keyJustPressed("down") then
				changeSelection(1)
				setTextString("curSelectedGlobal", curSelected)
			end
		end
	
		if keyJustPressed("accept") and canControl and getProperty("bgPause.y") == 0 then
			local daSelected = menuItems[curSelected]
			if daSelected == "CONTINUE" then
				if isKirby then
					doTweenAlpha("pauseScreenOut", "blackBox", 1, 0.25, "linear")
				elseif isSMB3 then
					setProperty("boyfriend.visible", true)
					setProperty("dad.visible", true)
					setProperty("gf.visible", true)
					setProperty("rating.exists", true)
					if getDataFromSave("playerSettings", "showcaseCam") ~= true then
						setProperty("camHUD.visible", true)
					end
					bgPos = screenHeight
					setProperty("bgPause.y", screenHeight)
					setProperty("bgPauseWide.y", screenHeight)
					paused = false
		
					setProperty("boyfriend.animation.curAnim.paused", bfPause)
					setProperty("dad.animation.curAnim.paused", dadPause)
					setProperty("boyfriend2.animation.curAnim.paused", bf2Pause)
					setProperty("dad2.animation.curAnim.paused", dad2Pause)
					setProperty("gf.animation.curAnim.paused", gfPause)
					setProperty("gf2.animation.curAnim.paused", gf2Pause)
					setProperty("boyfriend.specialAnim", bfSpecialAnim)
					setProperty("dad.specialAnim", dadSpecialAnim)
					setProperty("gf.specialAnim", gfSpecialAnim)
		
					setPropertyFromClass("PlayState", "instance.canReset", true)
					setPropertyFromClass("flixel.FlxG", "sound.music.volume", 1)
					setProperty("vocals.volume", 1)
				else
					transitionType = -1
				end
				canControl = false
				playSound(unpauseSound)
			elseif daSelected == "RETRY" then
				playSound(confirmSound)
				if isKirby then
					doTweenAlpha("pauseScreenOut", "blackBox", 1, 0.25, "linear")
				else
					setProperty("blackBox.visible", true)
				end
				canControl = false
				runTimer("retrySong", 1)
			elseif daSelected == "END" then
				setPropertyFromClass("PlayState", "SONG.validScore", false)
				if week == "funkMix" then
					setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix"})
				elseif week == "funkMixDX" then
					setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix DX"})
				end
	
				if isGameboy then
					canControl = false
					addLuaScript("scripts/extra/menus/GameboyPowerdown")
					cantEnd = false
					canPause = false
					paused = false
				else
					playSound(exitSound, 1)
					if isKirby then
						doTweenAlpha("pauseScreenOut", "blackBox", 1, 0.25, "linear")
					else
						setProperty("blackBox.visible", true)
					end
					canControl = false
					runTimer("exitToMenu", 1)
				end
			end
		end
	
		if transitionType == 1 then
			bgPos = bgPos - (18 * 130 * elapsed)
			setProperty("bgPause.y", math.floor(bgPos / 6) * 6)
			setProperty("bgPauseWide.y", math.floor(bgPos / 6) * 6)
			if bgPos <= 0 then
				bgPos = 0
				setProperty("bgPause.y", 0)
				setProperty("bgPauseWide.y", 0)
				transitionType = 0
				canControl = true
			end
		end
	
		if transitionType == -1 then
			bgPos = bgPos + (18 * 130 * elapsed)
			setProperty("bgPause.y", math.floor(bgPos / 6) * 6)
			setProperty("bgPauseWide.y", math.floor(bgPos / 6) * 6)
			if bgPos >= screenHeight then
				bgPos = screenHeight
				setProperty("bgPause.y", screenHeight)
				setProperty("bgPauseWide.y", screenHeight)
				transitionType = 0
				paused = false
	
				setProperty("boyfriend.animation.curAnim.paused", bfPause)
				setProperty("dad.animation.curAnim.paused", dadPause)
				setProperty("boyfriend2.animation.curAnim.paused", bf2Pause)
				setProperty("dad2.animation.curAnim.paused", dad2Pause)
				setProperty("gf.animation.curAnim.paused", gfPause)
				setProperty("gf2.animation.curAnim.paused", gf2Pause)
				setProperty("boyfriend.specialAnim", bfSpecialAnim)
				setProperty("dad.specialAnim", dadSpecialAnim)
				setProperty("gf.specialAnim", gfSpecialAnim)
	
				setPropertyFromClass("PlayState", "instance.canReset", true)
				setPropertyFromClass("flixel.FlxG", "sound.music.volume", 1)
				setProperty("vocals.volume", 1)
			end
		end
	
		setProperty("songText1.y", songText1Pos + getProperty("bgPause.y"))
		setProperty("songText2.y", songText2Pos + getProperty("bgPause.y"))
		setProperty("songText3.y", songText3Pos + getProperty("bgPause.y"))
		setProperty("levelInfo.y", levelInfoPos + getProperty("bgPause.y"))
		setProperty("pauseText.y", pauseTextPos + getProperty("bgPause.y"))
		setProperty("progressBar.y", progressBarPos + getProperty("bgPause.y"))
		setProperty("marioPause.y", marioPausePos + getProperty("bgPause.y"))
	
		if not canControl then
			if menuItems[curSelected] == "CONTINUE" then
				curSelected = 1
			end
			setProperty("selector.x", getProperty("songText1.x") - (9 * 6) + 3)
			setProperty("selector.y", getProperty("songText1.y") + (1 * 6) - 3)
		end
	end
end

function onCustomSubstateUpdate(name, elapsed)
	if name == "funkMixPauseState" then
		onUpdate(elapsed)
		runHaxeCode([[
			mario.x = ]]..(getProperty("marioPause.x")+7*6-2)..[[;
			mario.y = ]]..(getProperty("marioPause.y")+7*6-2)..[[;
			progressBar.y = ]]..(getProperty("progressBar.y")+3*6+2)..[[;

			FlxG.sound.music.pause();
			game.vocals.pause();
		]])
	end
end

function updatePost()
	changeSelection(0)

	setTextString("transitionType", transitionType)
	setTextString("getBgPos", bgPos)

	songProgress = getSongPosition() / songLength
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		setProperty("marioPause.x", math.floor(songProgress * 64) * 6 + ((67 * 6) - 2) - wideScreen)
	else
		setProperty("marioPause.x", math.floor(songProgress * 64) * 6 + (67 * 6) - 2)
	end

	if version == "0.6" or version == "0.6.1" or version == "0.6.2" then
		if paused then
			setProperty("boyfriend.stunned", true)
			setProperty("vocals.volume", 0)
		else
			setProperty("boyfriend.stunned", false)
		end
	end

	if inGameOver and keyJustPressed("back") then
		setProperty("blackBox.visible", true)
		setPropertyFromClass("PlayState", "SONG.validScore", false)
		if week == "funkMix" then
			setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix"})
		elseif week == "funkMixDX" then
			setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix DX"})
		end
		endSong()
	end
end

function onUpdatePost()
	updatePost()
	if exiting then
		setProperty("vocals.volume", 0)
	end
end

function onCustomSubstateUpdatePost(name)
	if name == "funkMixPauseState" then
		updatePost()
	end
end

function changeSelection(change)
	curSelected = curSelected + change

	if curSelected < 1 then
		curSelected = #menuItems
	elseif curSelected > #menuItems then
		curSelected = 1
	end

	if change ~= 0 then
		playSound(selectSound)
	end

	local bullShit = 1

	for item = 1,#menuItems do
		if bullShit == curSelected then
			setProperty("selector.x", getProperty(grpMenuShit[item]..".x") - (9 * 6) + 3)
			setProperty("selector.y", getProperty(grpMenuShit[item]..".y") + (2 * 6) - 3)
		end
		bullShit = bullShit + 1
	end
end

function onSongStart()
	canPause = true
end

function onPause()
	return Function_Stop
end

function onGameOver()
	canPause = false
	if cantEnd then
		return Function_Stop
	end
end

function onEndSong()
	canPause = false
	if cantEnd then
		return Function_Stop
	end
end

function onTimerCompleted(tag)
	if tag == "retrySong" then
		restartSong(true)
	elseif tag == "exitToMenu" then
		paused = false
		if isStoryMode then
			endSong()
		else
			cantEnd = true
			canPause = false
			if getDataFromSave("playerSettings", "lifeStart") > 0 then
				setDataFromSave("songSaveData", "deathCount", 0)
				setDataFromSave("songSaveData", "lifeCount", getDataFromSave("playerSettings", "lifeStart"))
				setDataFromSave("songSaveData", "disable1UP", false)
				setPropertyFromClass("PlayState", "deathCounter", 0)
			end
			setPropertyFromClass("PlayState", "seenCutscene", false)
			setProperty("blackBox.alpha", 1)
			exiting = true
			exitSong(false)
		end
	elseif tag == "pauseScreenIn" then
		bgPos = 0
		setProperty("bgPause.y", 0)
		setProperty("bgPauseWide.y", 0)
		canControl = true
	elseif tag == "pauseScreenOut" then
		setProperty("blackBox.alpha", 1)
		runHaxeCode([[fadeScreen.visible = false;]])
		bgPos = screenHeight
		setProperty("bgPause.y", screenHeight)
		setProperty("bgPauseWide.y", screenHeight)
		doTweenAlpha("blackBoxOut", "blackBox", 0, 0.25, "linear")
	end
end

function onTweenCompleted(tag)
	if tag == "pauseScreenIn" then
		bgPos = 0
		setProperty("bgPause.y", 0)
		setProperty("bgPauseWide.y", 0)
		canControl = true
		doTweenAlpha("blackBoxIn", "blackBox", 0, 0.25, "linear")
	elseif tag == "pauseScreenOut" then
		bgPos = screenHeight
		setProperty("bgPause.y", screenHeight)
		setProperty("bgPauseWide.y", screenHeight)
		if curSelected == 1 then
			doTweenAlpha("blackBoxOut", "blackBox", 0, 0.25, "linear")
		end
	elseif tag == "blackBoxOut" then
		paused = false
		setPropertyFromClass("PlayState", "instance.canReset", true)
		if getDataFromSave("songSaveData", "compatMode") == true then
			setProperty("boyfriend.animation.curAnim.paused", bfPause)
			setProperty("dad.animation.curAnim.paused", dadPause)
			setProperty("boyfriend2.animation.curAnim.paused", bf2Pause)
			setProperty("dad2.animation.curAnim.paused", dad2Pause)
			setProperty("gf.animation.curAnim.paused", gfPause)
			setProperty("gf2.animation.curAnim.paused", gf2Pause)
			setProperty("boyfriend.specialAnim", bfSpecialAnim)
			setProperty("dad.specialAnim", dadSpecialAnim)
			setProperty("gf.specialAnim", gfSpecialAnim)

			setPropertyFromClass("PlayState", "instance.canReset", true)
			setPropertyFromClass("flixel.FlxG", "sound.music.volume", 1)
			setProperty("vocals.volume", 1)
		else
			closeCustomSubstate()
		end
	end
end