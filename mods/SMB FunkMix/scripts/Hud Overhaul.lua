local suffix = "pixel"
local hpSuffix = "pixel"
local ratingPosY = nil
local playRating = false
local wideHealthBar = true

function rgbToHex(r,g,b)
	local rh = string.format("%02x", r)
	local gh = string.format("%02x", g)
	local bh = string.format("%02x", b)
	local hex = "0x00"..rh..gh..bh
	local dec = tonumber(hex)
	print("Vals: "..r..", "..g..", "..b)
	print("Hex: "..hex)
	print("Decimal: "..dec)
	return dec
end

function inMenu() 
	return songName == "Funk Mix" or songName == "Funk Mix DX" or songName == "Funk Mix MX" or songName == "Cutscene" or songName == "Options"
end

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or week == "funkMixMX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function funkMixPause()
	return week == "funkMix" or week == "funkMixDX" or week == "funkMixMX" or getDataFromSave("playerSettings", "pauseMenu") == true
end

function onCreate()
	initSaveData("playerSettings", "funkmixadvance")
	bfPrefix = boyfriendName
	setProperty("introSoundsSuffix", "-silent")
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		wideScreen = (26 * 6) + 4
	else
		wideScreen = 0
	end
	if funkMixCam() then
		setProperty("skipArrowStartTween", true)
	end

	-- Basic Hud
	if funkMixPause() and not inMenu() and not getPropertyFromClass("PlayState", "chartingMode") then
		addLuaScript("scripts/extra/menus/Pause")
	end

	barY = screenHeight - (10 * 6)
	if downscroll then
		barY = 0 * 6
	end
	
	if songName == "Portal Power" then
		suffix = "mari0"
	elseif songName == "First Level" then
		suffix = "smm"
	elseif songName == "Green Screen" then
		suffix = "gameboy"
		hpSuffix = "gameboy"
	elseif songName == "Hyperactive Starblaze" then
		suffix = "kirby"
	elseif songName == "Game Over" then
		suffix = "pcport"
	elseif songName == "Hammered" or songName == "HEAR ITS CRY" or songName:find("Tyrant") then
		suffix = "smb3"
	end

	makeLuaSprite("overlay", "ui/pixel/overlay", -3, 0)
	scaleObject("overlay", 6, 6)
	setProperty("overlay.antialiasing", false)
	if songName ~= "Hyperactive Starblaze" then
		setProperty("overlay.alpha", 0.36)
	end
	setObjectCamera("overlay", "hud")
	addLuaSprite("overlay", false)

	if songName == "Cross Console Clash" then
		loadGraphic("overlay", "ui/sonic/overlay-ccc")
	elseif songName == "Green Screen" then
		removeLuaSprite("overlay", true)
	elseif songName == "Vine Depths Zone" then
		loadGraphic("overlay", "ui/sonic/overlay")
	elseif songName == "Hyperactive Starblaze" then
		loadGraphic("overlay", "ui/kirby/overlay")
		setProperty("overlay.x", getProperty("overlay.x") + 1)
		if downscroll then
			loadGraphic("overlay", "ui/kirby/overlay-flip")
		end
	end
	if downscroll and songName ~= "Hyperactive Starblaze" then
		setProperty("overlay.flipY", true)
	end

	if not hideHud and (getPropertyFromClass("ClientPrefs", "optimization") == false or getPropertyFromClass("ClientPrefs", "optimization") == "optimization") then
		makeLuaText("scoreBar", score, 0, 1 * 6 + 3, barY + 3)
		setTextString("scoreBar", "00000000")
		setTextSize("scoreBar", 8 * 6)
		setTextBorder("scoreBar", 0, 0)
		setTextFont("scoreBar", "smb1.ttf")
		setTextAlignment("scoreBar", "left")
		setProperty("scoreBar.antialiasing", false)
		addLuaText("scoreBar")

		makeLuaText("accuracyText", rating, 0, screenWidth - (41 * 6) - 3, barY + 3)
		setTextString("accuracyText", "000000.00%")
		setTextSize("accuracyText", 8 * 6)
		setTextBorder("accuracyText", 0, 0)
		setTextFont("accuracyText", "smb1.ttf")
		setTextAlignment("accuracyText", "left")
		setProperty("accuracyText.antialiasing", false)
		addLuaText("accuracyText")

		makeLuaText("accuracyText2", rating, 0, getProperty("accuracyText.x") + (24 * 6), barY + (3 * 6) + 3)
		setTextString("accuracyText2", "000000.00%")
		setTextSize("accuracyText2", 5 * 6)
		setTextBorder("accuracyText2", 0, 0)
		setTextFont("accuracyText2", "pixel_smaller.ttf")
		setTextAlignment("accuracyText2", "left")
		setProperty("accuracyText2.antialiasing", false)
		addLuaText("accuracyText2")

		--[[
		FNF onlineStuff
		makeAnimatedLuaSprite("e","ui/pixel/rankings")
		makeAnimatedLuaSprite("e","ui/mari0/rankings")
		makeAnimatedLuaSprite("e","ui/smm/rankings")
		makeAnimatedLuaSprite("e","ui/gameboy/rankings")
		makeAnimatedLuaSprite("e","ui/kirby/rankings")
		makeAnimatedLuaSprite("e","ui/pcport/rankings")
		makeAnimatedLuaSprite("e","ui/smb3/rankings")
		]]
		makeAnimatedLuaSprite("ratingIcon", "ui/"..suffix.."/rankings", screenWidth - (50 * 6), barY + (1 * 6))
		addAnimationByPrefix("ratingIcon", "You Suck!", "suck", 9, true);addAnimationByPrefix("ratingIcon", "F", "suck", 9, true)
		addAnimationByPrefix("ratingIcon", "Shit", "shit", 9, true);addAnimationByPrefix("ratingIcon", "D-", "bad", 9, true);addAnimationByPrefix("ratingIcon", "D", "bad", 9, true)
		addAnimationByPrefix("ratingIcon", "Bad", "bad", 9, true);addAnimationByPrefix("ratingIcon", "D+", "bruh", 9, true);addAnimationByPrefix("ratingIcon", "D+", "bruh", 9, true)
		addAnimationByPrefix("ratingIcon", "Bruh", "bruh", 9, true);addAnimationByPrefix("ratingIcon", "C-", "meh", 9, true);addAnimationByPrefix("ratingIcon", "C", "meh", 9, true)
		addAnimationByPrefix("ratingIcon", "Meh", "meh", 9, true);addAnimationByPrefix("ratingIcon", "C+", "good", 9, true);addAnimationByPrefix("ratingIcon", "B-", "good", 9, true)
		addAnimationByPrefix("ratingIcon", "Nice", "nice", 9, true)
		addAnimationByPrefix("ratingIcon", "Good", "good", 9, true);addAnimationByPrefix("ratingIcon", "B+", "good", 9, true);addAnimationByPrefix("ratingIcon", "A-", "good", 9, true)
		addAnimationByPrefix("ratingIcon", "Great", "great", 9, true);addAnimationByPrefix("ratingIcon", "A", "great", 9, true);addAnimationByPrefix("ratingIcon", "A+", "great", 9, true)
		addAnimationByPrefix("ratingIcon", "Sick!", "sick", 9, true)addAnimationByPrefix("ratingIcon", "S", "sick", 9, true);addAnimationByPrefix("ratingIcon", "S+", "sick", 9, true);
		addAnimationByPrefix("ratingIcon", "Perfect!!", "perfect", 9, true);addAnimationByPrefix("ratingIcon", "S++", "Perfect", 9, true);addAnimationByPrefix("ratingIcon", "Perfect", "perfect", 9, true)
		scaleObject("ratingIcon", 6, 6)
		setProperty("ratingIcon.antialiasing", false)
		setObjectCamera("ratingIcon", "hud")
		addLuaSprite("ratingIcon", false)

		makeAnimatedLuaSprite("flagIcon", "ui/"..suffix.."/flags", getProperty("ratingIcon.x") - 8 * 6, barY + (1 * 6))
		addAnimationByPrefix("flagIcon", "Clear", "null", 9, true)
		addAnimationByPrefix("flagIcon", "SDCB", "xbox", 9, true)
		addAnimationByPrefix("flagIcon", "FC", "minus", 9, true)
		addAnimationByPrefix("flagIcon", "GFC", "plus", 9, true)
		addAnimationByPrefix("flagIcon", "SFC", "check", 9, true)
		addAnimationByPrefix("flagIcon", "PFC", "crown", 9, true)
		scaleObject("flagIcon", 6, 6)
		setProperty("flagIcon.antialiasing", false)
		setObjectCamera("flagIcon", "hud")
		addLuaSprite("flagIcon", false)
	end

	-- Judgement Timings
	if getDataFromSave("playerSettings", "showcaseCam") ~= true then
		makeAnimatedLuaSprite("rating", "ui/"..suffix.."/judgements", 0, 0)
		addAnimationByPrefix("rating", "1up", "1up", 0, true)
		addAnimationByPrefix("rating", "3up", "3up", 0, true)
		addAnimationByPrefix("rating", "sick", "sick", 0, true)
		addAnimationByPrefix("rating", "good", "good", 0, true)
		addAnimationByPrefix("rating", "bad", "bad", 0, true)
		addAnimationByPrefix("rating", "shit", "shit", 0, true)
		addAnimationByPrefix("rating", "miss", "miss", 0, true)
		scaleObject("rating", 6, 6)
		setProperty("rating.antialiasing", false)
		setProperty("rating.visible", false)
		addLuaSprite("rating", true)
		setObjectOrder("rating", getObjectOrder("boyfriendGroup") + 1)
	end

	-- Countdown
	makeLuaText("stopCountdown", false, 0, 0, 0)
	local countdownOffsetX = 0
	local countdownOffsetY = 0
	if songName == "Cross Console Clash" then
		countdownOffsetX = -1
		makeAnimatedLuaSprite("countdown", "ui/sonic/countdown", (screenWidth/2 - 17 * 6) + countdownOffsetX - wideScreen, ((screenHeight/2 - 8 * 6)/2) + 10 * 6 + countdownOffsetY)
	elseif songName == "Wrong Warp" then
		makeAnimatedLuaSprite("countdown", "ui/"..suffix.."/countdown-glitched", (screenWidth/2 - 17 * 6) + countdownOffsetX - wideScreen, ((screenHeight/2 - 8 * 6)/2) + 10 * 6 + countdownOffsetY)
	elseif songName == "Green Screen" then
		countdownOffsetY = 1.5
		makeAnimatedLuaSprite("countdown", "ui/"..suffix.."/countdown", (screenWidth/2 - 17 * 6) + countdownOffsetX - wideScreen, ((screenHeight/2 - 8 * 6)/2) + 10 * 6 + countdownOffsetY)
	else
		makeAnimatedLuaSprite("countdown", "ui/"..suffix.."/countdown", (screenWidth/2 - 17 * 6) + countdownOffsetX - wideScreen, ((screenHeight/2 - 8 * 6)/2) + 10 * 6 + countdownOffsetY)
	end
	
	addAnimationByPrefix("countdown", "three", "three", 9, true)
	addAnimationByPrefix("countdown", "two", "two", 9, true)
	addAnimationByPrefix("countdown", "one", "one", 9, true)
	addAnimationByPrefix("countdown", "go", "go", 9, true)
	setScrollFactor("countdown", 1, 1)
	setProperty("countdown.antialiasing", false)
	scaleObject("countdown", 6, 6)
	setObjectCamera("countdown","other")
	if downscroll then
		setProperty("countdown.y", ((screenHeight/2 - 8 * 6)/2) - (6 * 6))
	end

	-- Health Bar
	if getDataFromSave("playerSettings", "powerUpHP") ~= true and getPropertyFromClass("ClientPrefs", "optimization") ~= true then
		if aspectRatio ~= "4:3" or suffix == "kirby" or suffix == "smb3" then
			wideHealthBar = true

			makeLuaSprite("healthDecor", "ui/"..hpSuffix.."/hp-wide", 0, barY - (1 * 6))
			setProperty("healthDecor.antialiasing", false)
			setProperty("healthDecor.alpha", healthBarAlpha)
			scaleObject("healthDecor", 6, 6)
			setObjectCamera("healthDecor", "hud")
			screenCenter("healthDecor", "x")
			addLuaSprite("healthDecor", false)

			makeLuaSprite("healthBarDAD", nil, getProperty("healthDecor.x") + 16 * 6, getProperty("healthDecor.y") + 8 * 6)
			makeGraphic("healthBarDAD", 40 * 6, 2 * 6, "FFFFFF")
			setProperty("healthBarDAD.alpha", healthBarAlpha)
			setObjectCamera("healthBarDAD", "hud")
			setObjectOrder("healthBarDAD", getObjectOrder("healthDecor") - 1)
			addLuaSprite("healthBarDAD", false)

			makeLuaSprite("healthBarBF", nil, getProperty("healthDecor.x") + 56 * 6, getProperty("healthDecor.y") + 8 * 6)
			makeGraphic("healthBarBF", 40 * 6, 2 * 6, "FFFFFF")
			setProperty("healthBarBF.alpha", healthBarAlpha)
			setObjectCamera("healthBarBF", "hud")
			setObjectOrder("healthBarBF", getObjectOrder("healthDecor") - 1)
			addLuaSprite("healthBarBF", false)

			if downscroll then
				setProperty("healthBarDAD.y", getProperty("healthBarDAD.y") + 7)
				setProperty("healthBarBF.y", getProperty("healthBarBF.y") + 7)
				setProperty("healthDecor.y", getProperty("healthDecor.y") + 7)
			end

			makeLuaSprite("healthArrowDAD", "ui/"..hpSuffix.."/hpDad-wide", getProperty("healthDecor.x"), getProperty("healthDecor.y"))
			setProperty("healthArrowDAD.antialiasing", false)
			setProperty("healthArrowDAD.alpha", healthBarAlpha)
			scaleObject("healthArrowDAD", 6, 6)
			setObjectCamera("healthArrowDAD", "hud")
			addLuaSprite("healthArrowDAD", false)

			makeLuaSprite("healthArrowBF", "ui/"..hpSuffix.."/hpBf-wide", getProperty("healthDecor.x"), getProperty("healthDecor.y"))
			setProperty("healthArrowBF.antialiasing", false)
			setProperty("healthArrowBF.alpha", healthBarAlpha)
			scaleObject("healthArrowBF", 6, 6)
			setObjectCamera("healthArrowBF", "hud")
			addLuaSprite("healthArrowBF", false)

			defWidth = 40 * 6
			defHeight = 2 * 6
			bfHealthBarX = getProperty("healthDecor.x") + 56 * 6
			dadHealthBarX = getProperty("healthDecor.x") + 16 * 6
			if suffix == "kirby" then
				defWidth = 38 * 6
				defHeight = 6 * 6
				bfHealthBarX = getProperty("healthDecor.x") + 52 * 6
				dadHealthBarX = getProperty("healthDecor.x") + 14 * 6
			elseif suffix == "smb3" then
				defWidth = 38 * 6
				defHeight = 5 * 6
				bfHealthBarX = getProperty("healthDecor.x") + 52 * 6
				dadHealthBarX = getProperty("healthDecor.x") + 14 * 6
				if aspectRatio ~= "4:3" or getDataFromSave("playerSettings", "showBorder") == true then
					bfHealthBarX = bfHealthBarX - 1
					dadHealthBarX = dadHealthBarX - 1
				end
			end
			if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
				bfHealthBarX = bfHealthBarX - wideScreen
				dadHealthBarX = dadHealthBarX - wideScreen
			end
			healthCall()
		elseif aspectRatio == "4:3" then
			wideHealthBar = false

			makeLuaSprite("healthDecor", "ui/"..hpSuffix.."/hp", (screenWidth - wideScreen) - (41 * 6) - 4, 28 * 6)
			setProperty("healthDecor.antialiasing", false)
			setProperty("healthDecor.alpha", healthBarAlpha)
			scaleObject("healthDecor", 6, 6)
			setObjectCamera("healthDecor", "hud")
			addLuaSprite("healthDecor", false)
	
			makeLuaSprite("healthBarDAD", nil, getProperty("healthDecor.x") + 8 * 6, getProperty("healthDecor.y") + 16 * 6)
			makeGraphic("healthBarDAD", 2 * 6, 40 * 6, "FFFFFF")
			setProperty("healthBarDAD.alpha", healthBarAlpha)
			setObjectCamera("healthBarDAD", "hud")
			setObjectOrder("healthBarDAD", getObjectOrder("healthDecor") - 1)
			addLuaSprite("healthBarDAD", false)
	
			makeLuaSprite("healthBarBF", nil, getProperty("healthDecor.x") + 8 * 6, getProperty("healthDecor.y") + 56 * 6)
			makeGraphic("healthBarBF", 2 * 6, 40 * 6, "FFFFFF")
			setProperty("healthBarBF.alpha", healthBarAlpha)
			setObjectCamera("healthBarBF", "hud")
			setObjectOrder("healthBarBF", getObjectOrder("healthDecor") - 1)
			addLuaSprite("healthBarBF", false)
	
			if downscroll then
				setProperty("healthBarDAD.y", getProperty("healthBarDAD.y") - 8 * 6)
				setProperty("healthBarBF.y", getProperty("healthBarBF.y") - 8 * 6)
				setProperty("healthDecor.y", getProperty("healthDecor.y") - 8 * 6)
			end

			makeLuaSprite("healthArrowDAD", "ui/"..hpSuffix.."/hpDad", getProperty("healthDecor.x"), getProperty("healthDecor.y"))
			setProperty("healthArrowDAD.antialiasing", false)
			setProperty("healthArrowDAD.alpha", healthBarAlpha)
			scaleObject("healthArrowDAD", 6, 6)
			setObjectCamera("healthArrowDAD", "hud")
			addLuaSprite("healthArrowDAD", false)

			makeLuaSprite("healthArrowBF", "ui/"..hpSuffix.."/hpBf", getProperty("healthDecor.x"), getProperty("healthDecor.y"))
			setProperty("healthArrowBF.antialiasing", false)
			setProperty("healthArrowBF.alpha", healthBarAlpha)
			scaleObject("healthArrowBF", 6, 6)
			setObjectCamera("healthArrowBF", "hud")
			addLuaSprite("healthArrowBF", false)
			
			defHeight = 40 * 6
			defWidth = 2 * 6
			bfHealthBarY = getProperty("healthDecor.y") + 56 * 6
			dadHealthBarY = getProperty("healthDecor.y") + 16 * 6
			healthCall()
		end
	end
end

function onCreatePost()
	if boyfriendName == "boyfriend" then
		bfPrefix = "boyfriend"
	end
	setProperty("showComboNum", false)

	if getDataFromSave("playerSettings", "powerUpHP") == false then
		reloadHealthBarColors()
	end

	if (getPropertyFromClass("ClientPrefs", "optimization") == false or getPropertyFromClass("ClientPrefs", "optimization") == "optimization") then
		setProperty("scoreTxt.visible", false)
	end
	setTextString("accuracyText", math.floor(rating * 100))
	
	if isRunning("scripts/extra/fonts/Lost Levels Font") and week ~= "funkMix" and week ~= "funkMixDX" then
		-- Lost Levels Hud
		setTextFont("scoreBar", "smb2LL.ttf")
		setTextFont("accuracyText", "smb2LL.ttf")
		setTextFont("botplayTxt", "smb2LL.ttf")
		setProperty("scoreBar.y", getProperty("scoreBar.y") + 2 * 6)
		setProperty("accuracyText.y", getProperty("accuracyText.y") + 2 * 6)

		makeLuaText("scoreBarLL", score, 0, getProperty("scoreBar.x") + 1 * 6, getProperty("scoreBar.y") + 1 * 6)
		setTextString("scoreBarLL", "00000000")
		setTextSize("scoreBarLL", 8 * 6)
		setTextBorder("scoreBarLL", 0, 0)
		setTextFont("scoreBarLL", "smb2LL.ttf")
		setTextAlignment("scoreBarLL", "left")
		setTextColor("scoreBarLL", "000000")
		setProperty("scoreBarLL.antialiasing", false)
		addLuaText("scoreBarLL")
		setObjectOrder("scoreBarLL", getObjectOrder("scoreBar") - 1)

		makeLuaText("accuracyTextLL", rating, 0, getProperty("accuracyText.x") + 1 * 6, getProperty("accuracyText.y") + 1 * 6)
		setTextString("accuracyTextLL", "000000.00%")
		setTextSize("accuracyTextLL", 8 * 6)
		setTextBorder("accuracyTextLL", 0, 0)
		setTextFont("accuracyTextLL", "smb2LL.ttf")
		setTextAlignment("accuracyTextLL", "left")
		setTextColor("accuracyTextLL", "000000")
		setProperty("accuracyTextLL.antialiasing", false)
		addLuaText("accuracyTextLL")
		setObjectOrder("accuracyTextLL", getObjectOrder("accuracyText") - 1)

		makeLuaText("accuracyText2LL", rating, 0, getProperty("accuracyText2.x") + 1 * 6, getProperty("accuracyText2.y") + 1 * 6)
		setTextString("accuracyText2LL", "000000.00%")
		setTextSize("accuracyText2LL", 5 * 6)
		setTextBorder("accuracyText2LL", 0, 0)
		setTextFont("accuracyText2LL", "pixel_smaller.ttf")
		setTextAlignment("accuracyText2LL", "left")
		setTextColor("accuracyText2LL", "000000")
		setProperty("accuracyText2LL.antialiasing", false)
		addLuaText("accuracyText2LL")
		setObjectOrder("accuracyText2LL", getObjectOrder("accuracyText2") - 1)
	elseif songName == "Green Screen" then
		wideHealthBar = false

		setProperty("iconP1.visible", false)
		setProperty("iconP2.visible", false)

		setProperty("scoreBar.x", getProperty("scoreBar.x") + 3 * 6)
		setProperty("scoreBar.y", getProperty("scoreBar.y") - 4 * 6)
		setProperty("accuracyText.x", getProperty("accuracyText.x") - 2 * 6)
		setProperty("accuracyText.y", getProperty("accuracyText.y") - 4 * 6)
		setProperty("accuracyText2.x", getProperty("accuracyText2.x") - 3 * 6)
		setProperty("accuracyText2.y", getProperty("accuracyText2.y") - 4 * 6)
		setProperty("ratingIcon.x", getProperty("ratingIcon.x") - 3 * 6)
		setProperty("ratingIcon.y", getProperty("ratingIcon.y") - 4 * 6)
		setProperty("flagIcon.x", getProperty("flagIcon.x") - 4 * 6)
		setProperty("flagIcon.y", getProperty("flagIcon.y") - 4 * 6)

		makeLuaSprite("healthDecor", "ui/"..hpSuffix.."/hp", (screenWidth - wideScreen) - (41 * 6) - 3, 28 * 6 + 1)
		setProperty("healthDecor.antialiasing", false)
		setProperty("healthDecor.alpha", healthBarAlpha)
		scaleObject("healthDecor", 6, 6)
		setObjectCamera("healthDecor", "hud")
		addLuaSprite("healthDecor", false)
		if getDataFromSave("playerSettings", "powerUpHP") then
			loadGraphic("healthDecor", "ui/"..hpSuffix.."/hp-powerup")
		end

		makeLuaSprite("healthBarDAD", nil, getProperty("healthDecor.x") + 8 * 6, getProperty("healthDecor.y") + 16 * 6)
		makeGraphic("healthBarDAD", 2 * 6, 40 * 6, "306230")
		setProperty("healthBarDAD.alpha", healthBarAlpha)
		setObjectCamera("healthBarDAD", "hud")
		setObjectOrder("healthBarDAD", getObjectOrder("healthDecor") - 1)
		addLuaSprite("healthBarDAD", false)

		makeLuaSprite("healthBarBF", nil, getProperty("healthDecor.x") + 8 * 6, getProperty("healthDecor.y") + 56 * 6)
		makeGraphic("healthBarBF", 2 * 6, 40 * 6, "8BAC0F")
		setProperty("healthBarBF.alpha", healthBarAlpha)
		setObjectCamera("healthBarBF", "hud")
		setObjectOrder("healthBarBF", getObjectOrder("healthDecor") - 1)
		addLuaSprite("healthBarBF", false)

		removeLuaSprite("healthArrowDAD", true)
		removeLuaSprite("healthArrowBF", true)

		if downscroll then
			setProperty("scoreBar.y", getProperty("scoreBar.y") + 7 * 6 + 1)
			setProperty("accuracyText.y", getProperty("accuracyText.y") + 7 * 6 + 1)
			setProperty("accuracyText2.y", getProperty("accuracyText2.y") + 7 * 6 + 1)
			setProperty("ratingIcon.y", getProperty("ratingIcon.y") + 7 * 6 + 1)
			setProperty("flagIcon.y", getProperty("flagIcon.y") + 7 * 6 + 1)

			setProperty("healthBarDAD.y", getProperty("healthBarDAD.y") - 8 * 6)
			setProperty("healthBarBF.y", getProperty("healthBarBF.y") - 8 * 6)
			setProperty("healthDecor.y", getProperty("healthDecor.y") - 8 * 6)
		end

		defHeight = 40 * 6
		defWidth = 2 * 6
		bfHealthBarY = getProperty("healthDecor.y") + 56 * 6
		dadHealthBarY = getProperty("healthDecor.y") + 16 * 6
		healthCall()

		-- Power-Up Indicator
		makeAnimatedLuaSprite("powerup", "ui/"..hpSuffix.."/powerup", 175 * 6 - 1, 60 * 6 - 2)
		addAnimationByPrefix("powerup", "0", "small", 0, true)
		addAnimationByPrefix("powerup", "1", "big", 0, true)
		addAnimationByPrefix("powerup", "2", "fire", 0, true)
		scaleObject("powerup", 3, 3)
		setProperty("powerup.antialiasing", false)
		setProperty("powerup.alpha", healthBarAlpha)
		setObjectCamera("powerup", "hud")
		setProperty("powerup.exists", false)
		setObjectOrder("powerup", getObjectOrder("healthDecor") + 1)
		addLuaSprite("powerup", false)
		
		if downscroll then
			setProperty("powerup.y", getProperty("powerup.y") - 8 * 6)
		end
	end

	if inMenu() and getPropertyFromClass("ClientPrefs", "optimization") == true then
		setProperty("healthBarBG.visible", false)
		setProperty("healthBar.visible", false)
		setProperty("iconP1.visible", false)
		setProperty("iconP2.visible", false)
		setProperty("scoreTxt.visible", false)
	end

	if getProperty("healthDecor.exists") == true then
		setProperty("healthBarBG.visible", false)
		setProperty("healthBar.visible", false)
	end
end

function healthCall()
	if wideHealthBar then
		local newWidth = math.floor(defWidth * (getProperty("health")/2) / 6) * 6
		local newWidth2 = math.ceil(defWidth * ((2 - getProperty("health"))/2) / 6) * 6

		if newWidth <= 0 or getProperty("health") <= 0 then
			setProperty("healthBarBF.exists", false)
		else
			setProperty("healthBarBF.exists", true)
		end
		if getProperty("health") >= 2 then
			setProperty("healthBarDAD.exists", false)
		else
			setProperty("healthBarDAD.exists", true)
			if newWidth2 > defWidth then
				newWidth2 = math.floor(defWidth * ((2 - getProperty("health"))/2) / 6) * 6
			end
		end

		setGraphicSize("healthBarBF", newWidth, defHeight)
		setGraphicSize("healthBarDAD", newWidth2, defHeight)
		setProperty("healthBarBF.x", bfHealthBarX - getProperty("healthBarBF.width"))
		setProperty("healthBarDAD.x", dadHealthBarX)
	else
		local newHeight = math.floor(defHeight * (getProperty("health")/2) / 6) * 6
		local newHeight2 = math.ceil(defHeight * ((2 - getProperty("health"))/2) / 6) * 6

		if newHeight <= 0 or getProperty("health") <= 0 then
			setProperty("healthBarBF.exists", false)
		else
			setProperty("healthBarBF.exists", true)
		end
		if getProperty("health") >= 2 then
			setProperty("healthBarDAD.exists", false)
		else
			setProperty("healthBarDAD.exists", true)
			if newHeight2 > defHeight then
				newHeight2 = math.floor(defHeight * ((2 - getProperty("health"))/2) / 6) * 6
			end
		end

		setGraphicSize("healthBarBF", defWidth, newHeight)
		setGraphicSize("healthBarDAD", defWidth, newHeight2)
		setProperty("healthBarBF.y", bfHealthBarY - getProperty("healthBarBF.height"))
		setProperty("healthBarDAD.y", dadHealthBarY)
	end
end

function onUpdate(elapsed)
	setProperty("showRating", false)
	if (getDataFromSave("playerSettings", "powerUpHP") == false or songName == "Green Screen") and not inGameOver then
		healthCall()
	end

	if math.floor(rating * 100) < 10 then
		setTextString("accuracyText", "00"..math.floor(rating * 100))
		setTextString("accuracyTextLL", "00"..math.floor(rating * 100))
	elseif math.floor(rating * 100) < 100 and math.floor(rating * 100) >= 10 then
		setTextString("accuracyText", "0"..math.floor(rating * 100))
		setTextString("accuracyTextLL", "0"..math.floor(rating * 100))
	elseif math.floor(rating * 100) == 100 then
		setTextString("accuracyText", math.floor(rating * 100))
		setTextString("accuracyTextLL", math.floor(rating * 100))
	end

	if math.floor(((rating * 100) % 1) * 100) < 10 then
		setTextString("accuracyText2", ".".."0"..string.gsub(math.floor(((rating * 100) % 1) * 100), "0.", "").."%")
		setTextString("accuracyText2LL", ".".."0"..string.gsub(math.floor(((rating * 100) % 1) * 100), "0.", "").."%")
	else
		setTextString("accuracyText2", "."..string.gsub(math.floor(((rating * 100) % 1) * 100), "0.", "").."%")
		setTextString("accuracyText2LL", "."..string.gsub(math.floor(((rating * 100) % 1) * 100), "0.", "").."%")
	end

	if math.abs(score) < 10 then
		setTextString("scoreBar", "00000"..math.abs(score))
		setTextString("scoreBarLL", "00000"..math.abs(score))
	elseif math.abs(score) >= 10 and math.abs(score) < 100 then
		setTextString("scoreBar", "0000"..math.abs(score))
		setTextString("scoreBarLL", "0000"..math.abs(score))
	elseif math.abs(score) >= 100 and math.abs(score) < 1000 then
		setTextString("scoreBar", "000"..math.abs(score))
		setTextString("scoreBarLL", "000"..math.abs(score))
	elseif math.abs(score) >= 1000 and math.abs(score) < 10000 then
		setTextString("scoreBar", "00"..math.abs(score))
		setTextString("scoreBarLL", "00"..math.abs(score))
	elseif math.abs(score) >= 10000 and math.abs(score) < 100000 then
		setTextString("scoreBar", "0"..math.abs(score))
		setTextString("scoreBarLL", "0"..math.abs(score))
	elseif math.abs(score) >= 100000 then
		setTextString("scoreBar", math.abs(score))
		setTextString("scoreBarLL", math.abs(score))
	end
	
	if songName == "Green Screen" then
		if score < 0 then
			setTextColor("scoreBar", "0x306230")
		else
			setTextColor("scoreBar", "0x9BBC0F")
		end
	else
		if score < 0 then
			setTextColor("scoreBar", "0xB53120")
		else
			setTextColor("scoreBar", "0xFFFFFF")
		end
	end

	playAnim("flagIcon", ratingFC, false)
	updateHitbox("flagIcon")
	playAnim("ratingIcon", ratingName)
	updateHitbox("ratingIcon")
end

function onUpdatePost(elapsed)
	if getTextString("isPaused") ~= "true" then
		if songName ~= "Green Screen" then
			if playRating then
				setProperty("rating.visible", true)
				ratingPosY = ratingPosY - 200 * elapsed
				local increment = 6
				if songName == "Wrong Warp" then
					increment = 18
					if getRandomBool(5) then
						ratingPosY = ratingPosY + 12
					end
				end
				if bfPrefix == "bf-water" then
					setProperty("rating.y", math.floor(ratingPosY / increment) * increment - 6)
				else
					setProperty("rating.y", math.floor(ratingPosY / increment) * increment)
				end
				if getPropertyFromClass("ClientPrefs", "optimization") == true then
					if getProperty("rating.y") < getProperty("iconP1.y") - (30 * 6) + 1 then
						playRating = false
					end
				else
					if getProperty("rating.y") < rateOffsetY - (30 * 6) + 1 then
						playRating = false
					end
				end
			else
				setProperty("rating.visible", false)
			end
			if keyJustPressed("reset") then
				healthCall()
			end
		else
			if playRating then
				setProperty("rating.visible", true)
			else
				setProperty("rating.visible", false)
			end
		end
	end
end

function noteMissPress(i)
	-- Judgement Timings
	for i = 0,3 do
		if getTextString("isPaused") ~= "true" then
			playRating = false
			ratingOffsetX()
			ratingOffsetY()
			ratingPosY = getProperty("rating.y")

			playAnim("rating", "miss")
			updateHitbox("rating")
			playRating = true
		end
		if songName == "Green Screen" then
			runTimer("killRating", 0.55)
		end
	end
end

function onCountdownTick(tick)
	-- Countdown
	if getTextString("stopCountdown") ~= "true" then
		if songName == "Cross Console Clash" then
			if tick == 0 then
				playAnim("countdown", "three", true)
				playSound("sonic_countdown", 0.25, "countdown3")
				addLuaSprite("countdown", false)
			elseif tick == 1 then
				playAnim("countdown", "two", true)
				playSound("sonic_countdown", 0.25, "countdown2")
			elseif tick == 2 then
				playAnim("countdown", "one", true)
				playSound("sonic_countdown", 0.25, "countdown1")
			elseif tick == 3 then
				playAnim("countdown", "go", true)
				playSound("sonic_countdownend", 0.25, "countdownGo")
			else
				removeLuaSprite("countdown")
			end
		elseif songName == "Wrong Warp" then
			if tick == 0 then
				playAnim("countdown", "three", true)
				playSound("coin", 0.5, "countdown3")
				addLuaSprite("countdown", false)
			elseif tick == 1 then
				playAnim("countdown", "two", true)
				playSound("coin", 0.5, "countdown2")
			elseif tick == 2 then
				playAnim("countdown", "one", true)
				playSound("coin", 0.5, "countdown1")
			elseif tick == 3 then
				playAnim("countdown", "go", true)
				playSound("pause", 0.5, "countdownGo")
			else
				removeLuaSprite("countdown")
			end
		else
			if tick == 0 then
				playAnim("countdown", "three", true)
				playSound("countdown", 1, "countdown3")
				addLuaSprite("countdown", false)
			elseif tick == 1 then
				playAnim("countdown", "two", true)
				playSound("countdown", 1, "countdown2")
			elseif tick == 2 then
				playAnim("countdown", "one", true)
				playSound("countdown", 1, "countdown1")
			elseif tick == 3 then
				playAnim("countdown", "go", true)
				playSound("countdownend", 1, "countdownGo")
			else
				removeLuaSprite("countdown")
			end
		end
		updateHitbox("countdown")
	end
	if tick == 1 then
		setProperty("countdownReady.visible", false)
	elseif tick == 2 then
		setProperty("countdownSet.visible", false)
	elseif tick == 3 then
		setProperty("countdownGo.visible", false)
	end
end

function onSongStart()
	removeLuaSprite("countdown", true)
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if not isSustainNote then
		playRating = false
		ratingOffsetX()
		ratingOffsetY()
		ratingPosY = getProperty("rating.y")

		if getPropertyFromGroup("notes", id, "ratingMod") == 1 and (rating == 1 or rating ~= 1 and (getProperty("goods") == 0 and getProperty("bads") == 0 and getProperty("shits") == 0 and misses == 0)) or noteType == "1-Up Note" then
			if getProperty("sicks") == 0 and noteType ~= "1-Up Note" then
				playAnim("rating", "3up")
			else
				playAnim("rating", "1up")
			end
		elseif getPropertyFromGroup("notes", id, "ratingMod") == 1 and (getProperty("goods") > 0 or getProperty("bads") > 0 or getProperty("shits") > 0 or misses > 0) then
			playAnim("rating", "sick")
		elseif getPropertyFromGroup("notes", id, "ratingMod") == 0.75 then
			playAnim("rating", "good")
		elseif getPropertyFromGroup("notes", id, "ratingMod") == 0.5 then
			playAnim("rating", "bad")
		elseif getPropertyFromGroup("notes", id, "ratingMod") == 0.25 then
			playAnim("rating", "shit")
		end
		updateHitbox("rating")
		playRating = true
	end
	if songName == "Green Screen" then
		runTimer("killRating", 0.55)
	end
end

-- Rating Offset
function noteMiss(id, noteData, noteType, isSustainNote) 
	if not isSustainNote then
		playRating = false
		ratingOffsetX()
		ratingOffsetY()
		if songName == "Green Screen" then
			setObjectCamera("rating", "hud")
			screenCenter("rating", "x")
			setProperty("rating.x", getProperty("rating.x") + (6 * 6))
			setProperty("rating.y", screenHeight - (12 * 6) - 1)
		end
		ratingPosY = getProperty("rating.y")

		playAnim("rating", "miss")
		updateHitbox("rating")
		playRating = true
	end
	if songName == "Green Screen" then
		runTimer("killRating", 0.55)
	end
end

function ratingOffsetX()
	if songName == "Green Screen" then
		setObjectCamera("rating", "hud")
		setProperty("rating.x", 101 * 6 - 2 - wideScreen)
	elseif getPropertyFromClass("ClientPrefs", "optimization") == true then
		setObjectCamera("rating", "hud")
		setProperty("rating.x", getProperty("iconP1.x") + 4 * 6)
	else
		if boyfriendName == "boyfriend-small" or boyfriendName == "bf-bSide-small" then
			setProperty("rating.x", getProperty("boyfriend.x") - (22 * 6) + 2)
		elseif bfPrefix == "bf-water" or bfPrefix == "bf-kirby" then
			setProperty("rating.x", getProperty("boyfriend.x") - (22 * 6) + 2)
		elseif bfPrefix == "bf-captured" then
			setProperty("rating.x", getProperty("boyfriend.x") - (22 * 6) - 1)
		elseif bfPrefix == "bf-lakitu" or bfPrefix == "skyblue" then
			setProperty("rating.x", getProperty("boyfriend.x") - (22 * 6) - 1.5)
		elseif bfPrefix == "luigi-player" then
			setProperty("rating.x", getProperty("boyfriend.x") - (22 * 6) - 2)
		elseif bfPrefix == "mario-ccc" then
			setProperty("rating.x", getProperty("boyfriend.x") - (22 * 6))
		elseif bfPrefix == "bf-chase" then
			setProperty("rating.x", getProperty("boyfriend.x") - (22 * 6) + 4)
		elseif bfPrefix == "bf-wall" then
			setProperty("rating.x", getProperty("boyfriend.x") - (10 * 6) + 2)
		else
			setProperty("rating.x", getProperty("boyfriend.x") - (22 * 6) + 1)
		end
	end
end

function ratingOffsetY()
	if songName == "Green Screen" then
		setProperty("rating.y", 108 * 6)
		if downscroll then
			setProperty("rating.y", 6 * 6)
		end
	elseif getPropertyFromClass("ClientPrefs", "optimization") == true then
		setProperty("rating.y", getProperty("iconP1.y") - getProperty("rating.height"))
	else
		if bfPrefix == "bf-water" then
			setProperty("rating.y", getProperty("boyfriend.y") - (2 * 6) - 2)
		elseif bfPrefix == "bf-portal" then
			setProperty("rating.y", getProperty("boyfriend.y") - (2 * 6) + 3)
		elseif bfPrefix == "mario-ccc" then
			setProperty("rating.y", getProperty("boyfriend.y") - (3 * 6))
		elseif bfPrefix == "bf-wall" then
			setProperty("rating.y", getProperty("boyfriend.y") + (30 * 6) + 1)
		else
			setProperty("rating.y", getProperty("boyfriend.y") - (2 * 6) + 1)
		end
		rateOffsetY = getProperty("rating.y")
	end
end

-- Reload Health Bar
function reloadHealthBarColors()
	bfColor = {getProperty("boyfriend.healthColorArray[0]"),getProperty("boyfriend.healthColorArray[1]"),getProperty("boyfriend.healthColorArray[2]")}
	dadColor = {getProperty("dad.healthColorArray[0]"),getProperty("dad.healthColorArray[1]"),getProperty("dad.healthColorArray[2]")}

	bfColor = rgbToHex(bfColor[1],bfColor[2],bfColor[3])
	dadColor = rgbToHex(dadColor[1],dadColor[2],dadColor[3])
	setProperty("healthBarBF.color", bfColor)
	setProperty("healthArrowBF.color", bfColor)
	setProperty("healthBarDAD.color", dadColor)
	setProperty("healthArrowDAD.color", dadColor)
end

function onEvent(name, value1, value2)
	if name == "Change Character" and songName ~= "Green Screen" and not inGameOver then
		reloadHealthBarColors()
	end
	if name == "Change Character" and (value1 == "bf" or value1 == "boyfriend") then
		bfPrefix = value2
		bfPrefix = bfPrefix:gsub("-fire", "")
		bfPrefix = bfPrefix:gsub("-small", "")
	end
end

function onGameOver()
	setProperty("healthBarBF.exists", false)
	return Function_Continue
end

function onTimerCompleted(tag)
	if tag == "killRating" then
		playRating = false
	end
end