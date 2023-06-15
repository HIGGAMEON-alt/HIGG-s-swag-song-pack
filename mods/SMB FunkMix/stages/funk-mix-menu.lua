local initSavedSongs = {"mushroomPlains","bricksAndLifts","lethalLavaLair","2PlayerGame"}
local songs = {"Mushroom Plains", "Bricks and Lifts", "Lethal Lava Lair", "2 PLAYER GAME"}
local curMenu = 1
local subMenu = 0
local inMenu = "MainMenu"
local music = inMenu
local menuItems = {1,2,3}
local songs = {1,2,3,4,5,6,7,8}
local pipes = {1,2,3}

function onCreate()
	for i=1,#initSavedSongs do
		initSaveData(initSavedSongs[i].."-"..difficultyName, "funkmixadvance")
	end
	setPropertyFromClass("PlayState", "storyPlaylist", {songName})
	setPropertyFromClass("PlayState", "campaignScore", 0)
	setPropertyFromClass("PlayState", "campaignMisses", 0)

	if getDataFromSave("songSaveData", "isStoryMode") == true then
		curMenu = 1
		inMenu = "MainMenu"
		music = inMenu
	else
		curMenu = 2
		inMenu = "Freeplay"
		music = inMenu
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

	makeLuaText("optionsPipeExitFix", "false", 0, 0, 64)
	setObjectCamera("optionsPipeExitFix", "other")

	addLuaScript("scripts/extra/menus/Options")
	addLuaScript("scripts/extra/menus/funkMix/Freeplay")
	addLuaScript("scripts/extra/menus/funkMix/MainMenu")
end

function onCreatePost()
	if getDataFromSave("songSaveData", "isStoryMode") == true then
		playMusic("freakyMenuMario", 0.7, true)
	else
		playMusic("freeplayMenu", 0.55, true)
	end
end

function onUpdate()
	if getProperty("boyfriend.visible") or getProperty("dad.visible") then
		setProperty("boyfriend.visible", false)
		setProperty("dad.visible", false)
	end
	if getProperty("chartingMode") then
		setPropertyFromClass("PlayState", "chartingMode", false)
	end

	if keyJustPressed("back") and getTextString("canControlGlobal") == "true" then
		if curMenu ~= 1 and subMenu < 1 then
			curMenu = 1
			inMenu = "MainMenu"
			setTextString("curMenuGlobal", curMenu)
		elseif curMenu == 1 and subMenu < 1 then
			setTextString("canControlGlobal", false)
			setDataFromSave("songSaveData", "isStoryMode", true)
			endSong()
		end
		if subMenu > 0 then
			subMenu = subMenu - 1
			setTextString("subMenuGlobal", subMenu)
		elseif subMenu <= 0 then
			subMenu = 0
			setTextString("subMenuGlobal", subMenu)
		end
	end

	if curMenu == 1 then
		if music ~= inMenu then
			music = inMenu
			playMusic("freakyMenuMario", 0.7, true)
		end
		setProperty("bgTitle.exists", true)
		setProperty("logo.exists", true)
		setProperty("version.exists", true)
		setProperty("selector.exists", true)
		for i = 1,#menuItems do
			setProperty("optionTextA"..i..".exists", true)
			setProperty("optionTextB"..i..".exists", true)
		end
	else
		setProperty("bgTitle.exists", false)
		setProperty("logo.exists", false)
		setProperty("version.exists", false)
		setProperty("selector.exists", false)
		for i = 1,#menuItems do
			setProperty("optionTextA"..i..".exists", false)
			setProperty("optionTextB"..i..".exists", false)
		end
	end
	if curMenu == 2 then
		if music ~= inMenu then
			music = inMenu
			playMusic("freeplayMenu", 0.55, true)
		end
		setProperty("blackBG.exists", true)
		setProperty("map.exists", true)
		setProperty("infoText.exists", true)
		for i = 1,#songs do
			setProperty("songText"..i..".exists", true)
			setProperty("icon"..i..".exists", true)
		end
	else
		setProperty("blackBG.exists", false)
		setProperty("map.exists", false)
		setProperty("infoText.exists", false)
		for i = 1,#songs do
			setProperty("songText"..i..".exists", false)
			setProperty("icon"..i..".exists", false)
		end
	end
	if curMenu == 3 then
		if music ~= inMenu then
			music = inMenu
			playMusic("optionsMenu", 0.55, true)
		end
		for i = 1,#pipes do
			setProperty("mario.exists", true)
			setProperty("pipe"..i..".exists", true)
		end
	else
		for i = 1,#pipes do
			setProperty("mario.exists", false)
			setProperty("pipe"..i..".exists", false)
		end
	end

	if getDataFromSave("playerSettings", "debugInfo") == true then
		setProperty("curMenuGlobal.visible", true)
		setProperty("subMenuGlobal.visible", true)
		setProperty("inMenuGlobal.visible", true)
		setProperty("canControlGlobal.visible", true)
		setProperty("curSelectedGlobal.visible", true)
	else
		setProperty("curMenuGlobal.visible", false)
		setProperty("subMenuGlobal.visible", false)
		setProperty("inMenuGlobal.visible", false)
		setProperty("canControlGlobal.visible", false)
		setProperty("curSelectedGlobal.visible", false)
	end
end

function onStartCountdown()
	return Function_Stop
end

function onTimerCompleted(tag)
	if tag == "storyTime" then
		endSong()
	elseif tag == "freeForAll" then
		curMenu = 2
		inMenu = "Freeplay"
		setTextString("canControlGlobal", "true")
	elseif tag == "workerMario" then
		curMenu = 3
		subMenu = 0
		inMenu = "Options"
		setTextString("canControlGlobal", "true")
	elseif tag == "pipeEntered" then
		if getTextString("curSelectedGlobal") == "3" then
			curMenu = 1
			subMenu = 0
			inMenu = "MainMenu"
		else
			subMenu = 1
		end
	elseif tag == "flickerDur" then
		if getTextString("curMenuGlobal") == "3" and getTextString("subMenuGlobal") == "1" and getTextString("curSelectedGlobal") == "7" and getDataFromSave("playerSettings", "psychPipe") then
			subMenu = 2
			setTextString("subMenuGlobal", subMenu)
		elseif getTextString("curMenuGlobal") == "3" and getTextString("subMenuGlobal") == "1" and getDataFromSave("playerSettings", "psychPipe") == false then
			subMenu = 1
			setTextString("subMenuGlobal", subMenu)
		end
		if getTextString("subMenuGlobal") == "2" then
			subMenu = 2
		end
	end
	setTextString("curMenuGlobal", curMenu)
	setTextString("subMenuGlobal", subMenu)
	setTextString("inMenuGlobal", inMenu)
end

function onGameOver()
	return Function_Stop
end

function onEndSong()
	setPropertyFromClass("PlayState", "SONG.validScore", true)
	if getPropertyFromClass("PlayState", "exitingSong") ~= "exitingSong" then
		for i = 1,#leSongs do
			setPropertyFromClass("PlayState", "campaignScore", getPropertyFromClass("PlayState", "campaignScore") + getHighscore(leSongs[i], difficulty))
		end
	else
		for i = 1,#initSavedSongs do
			if getDataFromSave(initSavedSongs[i].."-"..difficultyName, "songScore") ~= "songScore" then
				setPropertyFromClass("PlayState", "campaignScore", getPropertyFromClass("PlayState", "campaignScore") + getDataFromSave(initSavedSongs[i].."-"..difficultyName, "songScore"))
			end
		end
	end
end