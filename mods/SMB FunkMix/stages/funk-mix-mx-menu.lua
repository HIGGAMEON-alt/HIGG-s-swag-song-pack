local initSavedSongs = {"gameOver"}
local songs = {"Game Over"}
local curMenu = 0
local subMenu = 0
local inMenu = "Title"
local music = ""

function onCreate()
	loadGraphic("border", "borders/pcport")
	setPropertyFromClass("PlayState", "storyPlaylist", {songName})
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
	-- addLuaScript("scripts/extra/menus/funkMixMX/Freeplay") -- For when and if I add more songs in.
	addLuaScript("scripts/extra/menus/funkMixMX/MainMenu")
	addLuaScript("scripts/extra/menus/funkMixMX/Title")
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

	if curMenu ~= 3 then
		if music ~= inMenu then
			music = inMenu
			playMusic("", 0, true)
		end
	else
		if music ~= inMenu then
			music = inMenu
			playMusic("optionsMenuMX", 0.55, true)
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
	elseif tag == "switchResetSubmenu" then
		setTextString("subMenuGlobal", 2)
	end

	if tag == "playGame" then
		setDataFromSave("songSaveData", "isStoryMode", true)
		setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Game Over", songName})

		makeLuaSprite("black", nil, 0, 0)
		makeGraphic("black", screenWidth, screenHeight, "000000")
		setObjectCamera("black", "other")
		addLuaSprite("black")
		setObjectOrder("black", getObjectOrder("border") - 1)

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