local xx = 160 * 3 - 0.5
local yy = 64 * 3 - 1
local yyD = 98 * 3 - 0.5
local wideScreen = (26 * 6) + 4

local allCleared = false
local wasCompleted = false
local dxCreditSongs = {"mushroomPlains", "bricksAndLifts", "lethalLavaLair", "deepDeepVoyage", "hopHopHeights", "koopaArmada", "2PlayerGame", "destructionDance", "portalPower", "bulletTime", "booBlitz", "crossConsoleClash", "wrongWarp", "firstLevel"}
local dxCreditSongNames = {"Mushroom Plains", "Bricks and Lifts", "Lethal Lava Lair", "Deep Deep Voyage", "Hop-Hop Heights", "Koopa Armada", "2 PLAYER GAME", "Destruction Dance", "Portal Power", "Bullet Time", "Boo Blitz", "Cross Console Clash", "Wrong Warp", "First Level"}
local allowEndSong = true

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or week == "funkMixMX" or week == "options" or getDataFromSave("playerSettings", "funkMixCam")
end

function inMenu()
	return songName == "Funk Mix" or songName == "Funk Mix DX" or songName == "Funk Mix MX" or songName == "Cutscene" or songName == "Options"
end

function onCreate()
	initSaveData("playerSettings", "funkmixadvance")
	initSaveData("songSaveData", "funkmixadvance")
	if not inMenu() and getPropertyFromClass("PlayState", "SONG.validScore") then
		initSavedSong()
	end

	for i = 1,#dxCreditSongs do
		initSaveData(dxCreditSongs[i].."-"..difficultyName, "funkmixadvanceSongs")
	end
	if getDataFromSave(savedSong, "cleared") == true then
		wasCompleted = true
	end

	-- For Player Controlled Settings (Editable through Save File and Options Menu)
	if getDataFromSave("playerSettings", "powerUpHP") == "powerUpHP" then
		setDataFromSave("playerSettings", "powerUpHP", true)
	end
	if getDataFromSave("playerSettings", "lifeStart") == "lifeStart" then
		setDataFromSave("playerSettings", "lifeStart", 0)
	end
	if getDataFromSave("playerSettings", "quantNotes") == "quantNotes" then
		setDataFromSave("playerSettings", "quantNotes", false)
	end
	if getDataFromSave("playerSettings", "funkMixCam") == "funkMixCam" then
		setDataFromSave("playerSettings", "funkMixCam", false)
	end
	if getDataFromSave("playerSettings", "pauseMenu") == "pauseMenu" then
		setDataFromSave("playerSettings", "pauseMenu", true)
	end
	if getDataFromSave("playerSettings", "showBorder") == "showBorder" then
		setDataFromSave("playerSettings", "showBorder", true)
	end
	if getDataFromSave("playerSettings", "aspectRatio") == "aspectRatio" then
		setDataFromSave("playerSettings", "aspectRatio", "4:3")
	end
	if getDataFromSave("playerSettings", "showcaseCam") == "showcaseCam" then
		setDataFromSave("playerSettings", "showcaseCam", false)
	end
	if getDataFromSave("playerSettings", "compatMode") == "compatMode" then
		setDataFromSave("playerSettings", "compatMode", getPropertyFromClass("PlayState", "exitingSong") == "exitingSong")
	end
	if getDataFromSave("playerSettings", "botplayCheat") == "botplayCheat" then
		setDataFromSave("playerSettings", "botplayCheat", false)
	end
	if getDataFromSave("playerSettings", "debugInfo") == "debugInfo" then
		setDataFromSave("playerSettings", "debugInfo", false)
	end

	-- For Save Data in the Mod (NOT Editable)
	if getDataFromSave("songSaveData", "startIntro") == "startIntro" or getDataFromSave("songSaveData", "gameMode") ~= week then
		setDataFromSave("songSaveData", "startIntro", true)
	end
	if getDataFromSave("songSaveData", "sceneNum") == "sceneNum" then
		setDataFromSave("songSaveData", "sceneNum", -1)
	end
	if getDataFromSave("songSaveData", "defPowerUpSet") == "defPowerUpSet" then
		setDataFromSave("songSaveData", "defPowerUpSet", getDataFromSave("playerSettings", "powerUpHP"))
	end
	if getDataFromSave("songSaveData", "lifeCount") == "lifeCount" then
		setDataFromSave("songSaveData", "lifeCount", getDataFromSave("playerSettings", "lifeStart"))
	end
	if getDataFromSave("songSaveData", "deathCount") == "deathCount" then
		setDataFromSave("songSaveData", "deathCount", getPropertyFromClass("PlayState", "deathCounter"))
	end
	if getDataFromSave("songSaveData", "disable1UP") == "disable1UP" then
		setDataFromSave("songSaveData", "disable1UP", false)
	end
	if getDataFromSave("songSaveData", "isStoryMode") == "isStoryMode" or getDataFromSave("songSaveData", "gameMode") ~= week then
		setDataFromSave("songSaveData", "isStoryMode", isStoryMode)
	end
	if getDataFromSave("songSaveData", "powerState") == "powerState" then
		setDataFromSave("songSaveData", "powerState", 2)
	end
	if getDataFromSave("songSaveData", "powerupNotes") == "powerupNotes" then
		setDataFromSave("songSaveData", "powerupNotes", true)
	end
	if getDataFromSave("songSaveData", "showDisclaimer") == "showDisclaimer" or getDataFromSave("songSaveData", "gameMode") ~= week then
		setDataFromSave("songSaveData", "showDisclaimer", true)
	end
	if getDataFromSave("songSaveData", "gameMode") ~= week then
		setDataFromSave("songSaveData", "gameMode", week)
	end

	-- Song Score Keeper
	if getDataFromSave("playerSettings", "lunarMode") then
		if getPropertyFromClass("PlayState", "SONG.validScore") and getHighscore(songName, difficulty) > 0 then
			setDataFromSave(savedSong, "cleared", getHighscore(songName, difficulty) > 0)
			setDataFromSave(savedSong, "songScore", getHighscore(songName, difficulty))
			setDataFromSave(savedSong, "accuracy", getSavedRating(songName, difficulty))
			if getSavedRating(songName, difficulty) == 0 then
				setDataFromSave(savedSong, "flagRating", 0)
			end
		end
	else
		if getPropertyFromClass("PlayState", "SONG.validScore") then
			if getDataFromSave(savedSong, "cleared") == "cleared" then
				setDataFromSave(savedSong, "cleared", false)
			end
			if getDataFromSave(savedSong, "songScore") == "songScore" then
				setDataFromSave(savedSong, "songScore", 0)
			end
			if getDataFromSave(savedSong, "accuracy") == "accuracy" then
				setDataFromSave(savedSong, "accuracy", 0)
			end
			if getDataFromSave(savedSong, "accuracy") == 0 then
				setDataFromSave(savedSong, "flagRating", 0)
			end
		end
	end
	flushSaveData(savedSong)

	-- Funk Mix Border
	if funkMixCam() then
		setProperty("defaultCamZoom", 1)
	end

	-- Call Quant Notes
	if getDataFromSave("playerSettings", "quantNotes") and songName ~= "Green Screen" then
		addLuaScript("scripts/extra/Quant Notes")
	end

	-- Funk Mix Camera Fix
	if songName == "Cross Console Clash" then
		xx = xx + 1
		yy = yy + 0.25
	elseif songName == "Green Screen" and downscroll then
		yyD = yyD - 8 * 6
	end
end

function onCreatePost()
	-- Funk Mix Border
	if funkMixCam() then
		if downscroll and songName ~= "Hyperactive Starblaze" then
			triggerEvent("Camera Follow Pos", xx, yyD)
		else
			triggerEvent("Camera Follow Pos", xx, yy)
		end
		setProperty("overlay.alpha", 1)
	end
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
		setProperty("botplayTxt.exists", false)
		if not hideHud then
			if getDataFromSave("playerSettings", "showBorder") == true then
				setProperty("scoreBar.x", getProperty("scoreBar.x") + wideScreen)
				setProperty("accuracyText.x", getProperty("accuracyText.x") - wideScreen)
				setProperty("accuracyText2.x", getProperty("accuracyText2.x") - wideScreen)
				setProperty("ratingIcon.x", getProperty("ratingIcon.x") - wideScreen)
				setProperty("flagIcon.x", getProperty("flagIcon.x") - wideScreen)
			else
				setProperty("accuracyText.x", getProperty("accuracyText.x") - wideScreen*2)
				setProperty("accuracyText2.x", getProperty("accuracyText2.x") - wideScreen*2)
				setProperty("ratingIcon.x", getProperty("ratingIcon.x") - wideScreen*2)
				setProperty("flagIcon.x", getProperty("flagIcon.x") - wideScreen*2)
			end
		end
	end
end

function onUpdate()
	-- BotPlay Cheat
	if getPropertyFromClass("flixel.FlxG", "keys.justPressed.SIX") then
		setProperty("cpuControlled", not getProperty("cpuControlled"))
		setProperty("botplayTxt.visible", getProperty("cpuControlled"))
	end

	-- Credits Fix
	if allowEndSong == false and keyJustPressed("accept") then
		allowEndSong = true
		endSong()
	end
end

function onUpdatePost()
	-- Showcase Camera
	if getDataFromSave("playerSettings", "showcaseCam") and songName ~= "Funk Mix" and songName ~= "Funk Mix DX" and songName ~= "Funk Mix MX" then
		setProperty("camHUD.visible", false)
		setProperty("cpuControlled", true)
		setProperty("rating.visible", false)
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	-- BotPlay Cheat
	if botPlay and not isSustainNote and getDataFromSave("playerSettings", "botplayCheat") == true then
		local plusScore = 0
		if getPropertyFromGroup("notes", id, "ratingMod") == 1 then
			plusScore = 350
		elseif getPropertyFromGroup("notes", id, "ratingMod") == 0.75 then
			plusScore = 200
		elseif getPropertyFromGroup("notes", id, "ratingMod") == 0.5 then
			plusScore = 100
		elseif getPropertyFromGroup("notes", id, "ratingMod") == 0.25 then
			plusScore = 50
		end

		if not getPropertyFromGroup("notes", id, "ratingDisabled") then
			addScore(plusScore)
			setProperty("totalPlayed", getProperty("totalPlayed") + 1)
			addHits(1)
		end 
		if getPropertyFromClass("ClientPrefs", "scoreZoom") then
			cancelTween("scoreTxtTweenX")
			cancelTween("scoreTxtTweenY")
			setProperty("scoreTxt.scale.x", 1.075)
			setProperty("scoreTxt.scale.y", 1.075)
			doTweenX("scoreTxtTweenX", "scoreTxt.scale", 1, 0.2, "linear")
			doTweenY("scoreTxtTweenY", "scoreTxt.scale", 1, 0.2, "linear")
		end
		setProperty("ratingPercent", math.min(1, math.max(0, getProperty("totalNotesHit") / getProperty("totalPlayed"))))
	end
end

function onEndSong()
	-- Song Score Keeper
	if (not botPlay and not practice) or ((botPlay or practice) and getDataFromSave("playerSettings", "botplayCheat") == true) then
		if not inMenu() and songName ~= "Cutscene" and getPropertyFromClass("PlayState", "SONG.validScore") then
			setDataFromSave(savedSong, "cleared", true)
			setDataFromSave(savedSong, "unlocked", true)
			if getDataFromSave(savedSong, "songScore") == "songScore" or getScore() > getDataFromSave(savedSong, "songScore") then
				setDataFromSave(savedSong, "songScore", getScore())
			end
			if getDataFromSave(savedSong, "accuracy") == "accuracy" or getProperty("ratingPercent") > getDataFromSave(savedSong, "accuracy") then
				setDataFromSave(savedSong, "accuracy", getProperty("ratingPercent"))
			end
			if getDataFromSave(savedSong, "flagRating") == "flagRating" or getProperty("flagIcon.animation.frameIndex") > getDataFromSave(savedSong, "flagRating") then
				setDataFromSave(savedSong, "flagRating", getProperty("flagIcon.animation.frameIndex"))
			end
		end
		flushSaveData(savedSong)
	end

	for i = 1,#dxCreditSongs do
		if getDataFromSave(dxCreditSongs[i].."-"..difficultyName, "cleared") == true then
			allCleared = true
		else
			allCleared = false
			break
		end
	end

	for i = 1,#dxCreditSongNames do
		if allCleared and not wasCompleted and songName == dxCreditSongNames[i] then
			if getProperty("creditScreen.visible") ~= true then
				allowEndSong = false
				addLuaScript("scripts/extra/menus/funkMixDX/Credits", true)
				return Function_Stop
			end
		end
	end
	if allowEndSong then
		return Function_Continue
	else
		return Function_Stop
	end
end

function initSavedSong()
	savedSong = ""
	local songTitle = songName:gsub("-", " ")
	local wordCount = songTitle:gsub("%S+","")
	local words = {}
	local i = 0

	for word in songTitle:gmatch("%w+") do
		i = i + 1
		words[i] = word:match("(%w+)")
		words[i] = words[i]:lower()
		if i ~= 1 then
			words[i] = words[i]:sub(1,1):upper()..words[i]:sub(2)
		end
		savedSong = savedSong..words[i]
	end
	savedSong = savedSong.."-"..difficultyName

	initSaveData(savedSong, "funkmixadvanceSongs")
end