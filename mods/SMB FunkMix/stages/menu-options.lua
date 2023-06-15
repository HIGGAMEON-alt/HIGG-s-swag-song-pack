local curMenu = 3
local subMenu = 0
local inMenu = "Options"
local music = inMenu
local pipes = {1,2,3}

function onCreate()
	addLuaScript("scripts/extra/menus/Options")

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
	makeLuaText("canPressBack", "true", 0, 0, 64)
	setObjectCamera("canPressBack", "other")
end

function onCreatePost()
	playMusic("optionsMenu", 0.55, true)
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
		if subMenu > 0 then
			subMenu = subMenu - 1
			setTextString("subMenuGlobal", subMenu)
		elseif subMenu <= 0 then
			subMenu = 0
			setTextString("subMenuGlobal", subMenu)
			setTextString("canPressBack", false)
			exitSong(false)
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

	if getDataFromSave("playerSettings", "debugInfo") then
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
	if tag == "pipeEntered" then
		if getTextString("curSelectedGlobal") == "3" then
			exitSong(false)
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