local initSavedSongs = {"mushroomPlains","bricksAndLifts","lethalLavaLair","deepDeepVoyage","hopHopHeights","koopaArmada","2PlayerGame","destructionDance","portalPower","bulletTime","booBlitz","crossConsoleClash","wrongWarp","firstLevel","greenScreen"}
local songs = {"Mushroom Plains", "Bricks and Lifts", "Lethal Lava Lair", "Deep Deep Voyage", "Hop-Hop Heights", "Koopa Armada", "2 PLAYER GAME", "Destruction Dance", "Portal Power", "Bullet Time", "Boo Blitz", "Cross Console Clash", "Wrong Warp", "First Level", "Green Screen"}
local curMenu = 0
local subMenu = 0
local inMenu = "Title"
local music = ""

function onCreate()
	setDataFromSave("songSaveData", "defPowerUpSet", getDataFromSave("playerSettings", "powerUpHP"))
	setPropertyFromClass("PlayState", "storyPlaylist", {songName})
	setDataFromSave("songSaveData", "sceneNum", -1)
	if getDataFromSave("playerSettings", "powerUpHP") ~= getDataFromSave("songSaveData", "defPowerUpSet") then
		setDataFromSave("playerSettings", "powerUpHP", getDataFromSave("songSaveData", "defPowerUpSet"))
	end

	if getDataFromSave("songSaveData", "startIntro") ~= true then
		if getDataFromSave("songSaveData", "isStoryMode") == true then
			curMenu = 1
			subMenu = 0
			inMenu = "MainMenu"
		else
			curMenu = 2
			subMenu = 0
			inMenu = "Freeplay"
		end
	end

	makeLuaText("curMenuGlobal", curMenu, 0, 0, 0)
	setObjectCamera("curMenuGlobal", "other")
	addLuaText("curMenuGlobal")
	makeLuaText("subMenuGlobal", subMenu, 0, 16, 0)
	setObjectCamera("subMenuGlobal", "other")
	addLuaText("subMenuGlobal")
	makeLuaText("inMenuGlobal", inMenu, 0, 0, 16)
	setObjectCamera("inMenuGlobal", "other")
	addLuaText("inMenuGlobal")
	makeLuaText("canControlGlobal", "true", 0, 0, 32)
	setObjectCamera("canControlGlobal", "other")
	addLuaText("canControlGlobal")
	makeLuaText("curSelectedGlobal", 1, 0, 0, 48)
	setObjectCamera("curSelectedGlobal", "other")
	addLuaText("curSelectedGlobal")

	makeLuaText("curCategoryGlobal", 0, 0, 16, 48)
	setObjectCamera("curCategoryGlobal", "other")
	makeLuaText("optionsPipeExitFix", "false", 0, 0, 64)
	setObjectCamera("optionsPipeExitFix", "other")
	makeLuaText("canPressBack", "true", 0, 0, 64)
	setObjectCamera("canPressBack", "other")

	addLuaScript("scripts/extra/menus/Options")
	addLuaScript("scripts/extra/menus/funkMixDX/Freeplay")
	addLuaScript("scripts/extra/menus/funkMixDX/MainMenu")
	addLuaScript("scripts/extra/menus/funkMixDX/Title")
end

function onStartCountdown()
	return Function_Stop
end

function onUpdate()
	if getProperty("boyfriend.visible") or getProperty("dad.visible") then
		setProperty("boyfriend.visible", false)
		setProperty("dad.visible", false)
	end
	if getProperty("chartingMode") then
		setPropertyFromClass("PlayState", "chartingMode", false)
	end

	if keyJustPressed("back") and getTextString("canControlGlobal") == "true" and getTextString("canPressBack") == "true" then
		if curMenu == 1 and subMenu < 1 then
			inMenu = "Title"
			curMenu = curMenu - 1
			setTextString("curMenuGlobal", curMenu)
			setTextString("inMenuGlobal", inMenu)
			setDataFromSave("songSaveData", "startIntro", true)
		elseif curMenu <= 0 then
			setTextString("canPressBack", false)
			setTextString("canControlGlobal", false)
			setDataFromSave("songSaveData", "isStoryMode", true)
			endSong()
		elseif (curMenu == 2 or curMenu == 3) and subMenu < 1 then
			curMenu = 1
			inMenu = "MainMenu"
			setTextString("curMenuGlobal", curMenu)
			setTextString("inMenuGlobal", inMenu)
		end

		if subMenu > 0 then
			subMenu = subMenu - 1
			setTextString("subMenuGlobal", subMenu)
		elseif subMenu <= 0 then
			subMenu = 0
			setTextString("subMenuGlobal", subMenu)
		end
	end

	if keyJustPressed("accept") then
		if curMenu == 4 then
			curMenu = 1
			subMenu = 1
			inMenu = "MainMenu"
			setTextString("curMenuGlobal", curMenu)
			setTextString("subMenuGlobal", subMenu)
			setTextString("inMenuGlobal", inMenu)
		end
	end

	if curMenu == 0 or curMenu == 4 then
		if music ~= inMenu then
			music = inMenu
		end
	elseif curMenu == 1 then
		if music ~= inMenu then
			music = inMenu
			playMusic("freakyMenuMario", 0.7, true)
		end
	elseif curMenu == 2 then
		if music ~= inMenu then
			music = inMenu
			playMusic("freeplayMenuDX", 0.7, true)
		end
	elseif curMenu == 3 then
		if music ~= inMenu then
			music = inMenu
			playMusic("optionsMenu", 0.55, true)
		end
	end

	if getDataFromSave("playerSettings", "debugInfo") == true then
		setProperty("curMenuGlobal.visible", true)
		setProperty("subMenuGlobal.visible", true)
		setProperty("inMenuGlobal.visible", true)
		setProperty("canControlGlobal.visible", true)
		setProperty("curSelectedGlobal.visible", true)
		setProperty("curCategoryGlobal.visible", true)
	else
		setProperty("curMenuGlobal.visible", false)
		setProperty("subMenuGlobal.visible", false)
		setProperty("inMenuGlobal.visible", false)
		setProperty("canControlGlobal.visible", false)
		setProperty("curSelectedGlobal.visible", false)
		setProperty("curCategoryGlobal.visible", false)
	end
end

function onGameOver()
	return Function_Stop
end

function onTimerCompleted(tag)
	if tag == "switchMainMenu" then
		curMenu = 1
		subMenu = 0
		inMenu = "MainMenu"
		setDataFromSave("songSaveData", "startIntro", false)
	elseif tag == "switchFreeplay" then
		curMenu = 2
		subMenu = 0
		inMenu = "Freeplay"
	elseif tag == "switchOptions" then
		curMenu = 3
		subMenu = 0
		inMenu = "Options"
	elseif tag == "switchCredits" then
		curMenu = 4
		subMenu = 0
		inMenu = "Credits"
		addLuaScript("scripts/extra/menus/funkMixDX/Credits", true)
	elseif tag == "switchResetSubmenu" then
		setTextString("subMenuGlobal", 2)
	end

	if tag == "playWorld1" then
		setDataFromSave("songSaveData", "isStoryMode", true)
		setDataFromSave("songSaveData", "sceneNum", 0)
		setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Cutscene", "Mushroom Plains", "Cutscene", "Bricks and Lifts", "Cutscene", "Lethal Lava Lair", "Cutscene", songName})
		endSong()
	elseif tag == "playWorld2" then
		setDataFromSave("songSaveData", "isStoryMode", true)
		setDataFromSave("songSaveData", "sceneNum", 3)
		setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Cutscene", "Deep Deep Voyage", "Cutscene", "Hop-Hop Heights", "Cutscene", "Koopa Armada", "Cutscene", songName})
		endSong()
	end

	if tag == "pipeEntered" then
		if getTextString("curSelectedGlobal") == "3" then
			curMenu = 1
			subMenu = 0
			inMenu = "MainMenu"
		else
			subMenu = 1
		end
	end

	if tag == "wipeSave" then
		setDataFromSave("songSaveData", "startIntro", true)
	end

	if tag == "flickerDur" then
		if getTextString("curMenuGlobal") == "3" and getTextString("subMenuGlobal") == "1" and getTextString("curSelectedGlobal") == "8" then
			subMenu = 2
			setTextString("subMenuGlobal", subMenu)
		end
		if getTextString("subMenuGlobal") == "2" then
			subMenu = 2
		end
	end

	setTextString("curMenuGlobal", curMenu)
	setTextString("inMenuGlobal", inMenu)

	if curMenu == 1 or (curMenu == 3 and subMenu > 1) then
		local newSub = tonumber(getTextString("subMenuGlobal"))
		subMenu = newSub
	else
		setTextString("subMenuGlobal", subMenu)
	end
end

function onEndSong()
	setPropertyFromClass("PlayState", "SONG.validScore", true)
	if getPropertyFromClass("PlayState", "exitingSong") ~= "exitingSong" then
		for i = 1,#songs do
			setPropertyFromClass("PlayState", "campaignScore", getPropertyFromClass("PlayState", "campaignScore") + getHighscore(songs[i], difficulty))
		end
	else
		for i = 1,#initSavedSongs do
			if getDataFromSave(initSavedSongs[i].."-"..difficultyName, "songScore") ~= "songScore" then
				setPropertyFromClass("PlayState", "campaignScore", getPropertyFromClass("PlayState", "campaignScore") + getDataFromSave(initSavedSongs[i].."-"..difficultyName, "songScore"))
			end
		end
	end
end