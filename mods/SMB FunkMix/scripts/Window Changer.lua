wideScreen = (26 * 6) + 4
local windowReset = false

function inMenu()
	return songName == "Funk Mix" or songName == "Funk Mix DX" or songName == "Funk Mix MX" or songName == "Options"
end

function onCreate()
	initSaveData("playerSettings", "funkmixadvance")
	if not inMenu() then
		if getDataFromSave("playerSettings", "showBorder") ~= true then
			if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and (getPropertyFromClass("openfl.Lib", "application.window.width") ~= 960 or getPropertyFromClass("openfl.Lib", "application.window.height") ~= 720) then
				setPropertyFromClass("flixel.FlxG", "width", 1280)
				setPropertyFromClass("openfl.Lib", "current.stage.stageWidth", 1280)
				runHaxeCode([[FlxG.resizeGame(1280,720)]])
				runHaxeCode([[FlxG.resizeWindow(1280,720)]])
				runHaxeCode([[FlxG.resizeWindow(960,720)]])
				setPropertyFromClass("flixel.FlxG", "width", 960)
				setPropertyFromClass("openfl.Lib", "current.stage.stageWidth", 960)
				setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") + wideScreen)
				setProperty("camGame.width", 960)
				setPropertyFromClass("flixel.FlxG", "fullscreen", false)
				setPropertyFromClass("openfl.Lib", "application.window.resizable", false)
				setPropertyFromClass("openfl.Lib", "current.stage.allowsFullScreen", false)
			end
		else
			wideScreen = 0
			if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
				createBorder()
			end
		end
	else
		createBorder()
		windowReset = not getDataFromSave("playerSettings", "showBorder")
	end
end

function createBorder()
	makeLuaSprite("borderBack", "borders/default-back", -128, -240)
	scaleObject("borderBack", 2, 2)
	setObjectCamera("borderBack", "other")
	setProperty("borderBack.antialiasing", false)
	addLuaSprite("borderBack", true)

	makeLuaSprite("border", "borders/default", -128, -240)
	scaleObject("border", 2, 2)
	setObjectCamera("border", "other")
	setProperty("border.antialiasing", false)
	addLuaSprite("border", true)
end

function setArrows()
	for i = 0,math.max(getProperty("opponentStrums.length")-1,getProperty("playerStrums.length"))-1 do
		noteTwnByX = (13 * 6) - 3
		noteTwnByY = (3 * 6)

		if getDataFromSave("playerSettings", "showBorder") ~= true then
			iPosX = _G["defaultOpponentStrumX"..i] - noteTwnByX
			jPosX = _G["defaultPlayerStrumX"..i] - noteTwnByX + (2 * 6) - 2
			iPosY = _G["defaultOpponentStrumY"..i] - noteTwnByY
			jPosY = _G["defaultPlayerStrumY"..i] - noteTwnByY
			iPosD = _G["defaultOpponentStrumY"..i] + noteTwnByY - (1 * 6) + 1
			jPosD = _G["defaultPlayerStrumY"..i] + noteTwnByY - (1 * 6) + 1
		else
			iPosX = _G["defaultOpponentStrumX"..i] - noteTwnByX + (26 * 6) + 4
			jPosX = _G["defaultPlayerStrumX"..i] - noteTwnByX + (2 * 6) - 2
			iPosY = _G["defaultOpponentStrumY"..i] - noteTwnByY
			jPosY = _G["defaultPlayerStrumY"..i] - noteTwnByY
			iPosD = _G["defaultOpponentStrumY"..i] + noteTwnByY - (1 * 6) + 1
			jPosD = _G["defaultPlayerStrumY"..i] + noteTwnByY - (1 * 6) + 1
		end

		if downscroll then
			setPropertyFromGroup("opponentStrums", i, "y", iPosD)
			setPropertyFromGroup("playerStrums", i, "y", jPosD)
		else
			setPropertyFromGroup("opponentStrums", i, "y", iPosY)
			setPropertyFromGroup("playerStrums", i, "y", jPosY)
		end
		if middlescroll then
			if i <= 1 then
				setPropertyFromGroup("opponentStrums", i, "x", _G["defaultOpponentStrumX"..i] - noteTwnByX + (2 * 6))
			else
				setPropertyFromGroup("opponentStrums", i, "x", _G["defaultOpponentStrumX"..i] - wideScreen + noteTwnByX + (1 * 6))
			end
			setPropertyFromGroup("playerStrums", i, "x", _G["defaultPlayerStrumX"..i] + (2 * 6))
		else
			setPropertyFromGroup("opponentStrums", i, "x", iPosX)
			setPropertyFromGroup("playerStrums", i, "x", jPosX)
		end
	end
end

--[[function setArrowsAlt()
	for i = 0,math.max(getProperty("opponentStrums.length")-1,getProperty("playerStrums.length")-1) do
		noteTwnByX = (16 * 6) + 2
		noteTwnByY = (4 * 6) - 4

		iPosX = _G["defaultOpponentStrumX"..i] + noteTwnByX - wideScreen - (i * 4) - 6
		jPosX = _G["defaultPlayerStrumX"..i] - noteTwnByX + (6 * 6) - (i * 4)
		iPosY = _G["defaultOpponentStrumY"..i] - noteTwnByY
		jPosY = _G["defaultPlayerStrumY"..i] - noteTwnByY
		iPosD = _G["defaultOpponentStrumY"..i] + noteTwnByY - (1 * 6) + 4
		jPosD = _G["defaultPlayerStrumY"..i] + noteTwnByY - (1 * 6) + 4

		if downscroll then
			setPropertyFromGroup("opponentStrums", i, "y", iPosD)
			setPropertyFromGroup("playerStrums", i, "y", jPosD)
		else
			setPropertyFromGroup("opponentStrums", i, "y", iPosY)
			setPropertyFromGroup("playerStrums", i, "y", jPosY)
		end
		if middlescroll then
			if i <= 1 then
				setPropertyFromGroup("opponentStrums", i, "x", _G["defaultOpponentStrumX"..i] - noteTwnByX + (7 * 6) - (i * 4) - 2)
			else
				setPropertyFromGroup("opponentStrums", i, "x", _G["defaultOpponentStrumX"..i] - wideScreen + noteTwnByX - (1 * 6) - (i * 4) - 3)
			end
			setPropertyFromGroup("playerStrums", i, "x", _G["defaultPlayerStrumX"..i] + (3 * 6) - (i * 4))
		else
			setPropertyFromGroup("opponentStrums", i, "x", iPosX)
			setPropertyFromGroup("playerStrums", i, "x", jPosX)
		end
	end
end]]

function onCreatePost()
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
		if downscroll then
			setProperty("timeTxt.y", getProperty("timeTxt.y") + 10)
			setProperty("timeBarBG.y", getProperty("timeBarBG.y") + 10)
			setProperty("timeBar.y", getProperty("timeBar.y") + 10)
			setProperty("botplayTxt.y", getProperty("botplayTxt.y") + 10)
		else
			setProperty("timeTxt.y", getProperty("timeTxt.y") - 20)
			setProperty("timeBarBG.y", getProperty("timeBarBG.y") - 20)
			setProperty("timeBar.y", getProperty("timeBar.y") - 20)
			setProperty("botplayTxt.y", getProperty("botplayTxt.y") - 20)
		end
		setArrows()
	end
end

function onUpdate()
	if inMenu() then
		if getDataFromSave("playerSettings", "showBorder") ~= true then
			setProperty("borderBack.exists", false)
			setProperty("border.exists", false)
			if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and (getPropertyFromClass("openfl.Lib", "application.window.width") ~= 960 or getPropertyFromClass("openfl.Lib", "application.window.height") ~= 720) then
				setPropertyFromClass("flixel.FlxG", "width", 1280)
				setPropertyFromClass("openfl.Lib", "current.stage.stageWidth", 1280)
				runHaxeCode([[FlxG.resizeGame(1280,720)]])
				runHaxeCode([[FlxG.resizeWindow(1280,720)]])
				runHaxeCode([[FlxG.resizeWindow(960,720)]])
				setPropertyFromClass("flixel.FlxG", "width", 960)
				setPropertyFromClass("openfl.Lib", "current.stage.stageWidth", 960)
				setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") + wideScreen)
			elseif getDataFromSave("playerSettings", "aspectRatio") == "16:9" and (getPropertyFromClass("openfl.Lib", "application.window.width") ~= 1280 or getPropertyFromClass("openfl.Lib", "application.window.height") ~= 720) then
				runHaxeCode([[FlxG.resizeGame(1280,720)]])
				runHaxeCode([[FlxG.resizeWindow(1280,720)]])
				setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") - wideScreen)
			end
			if windowReset then
				setPropertyFromClass("flixel.FlxG", "fullscreen", false)
				setPropertyFromClass("openfl.Lib", "application.window.resizable", false)
				setPropertyFromClass("openfl.Lib", "current.stage.allowsFullScreen", false)
				windowReset = false
			end
		else
			if getPropertyFromClass("flixel.FlxG", "width") ~= 1280 and not windowReset then
				runHaxeCode([[FlxG.resizeGame(1280,720)]])
				runHaxeCode([[FlxG.resizeWindow(1280,720)]])
				if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
					setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") - wideScreen)
				end
			end
			if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
				setProperty("borderBack.exists", true)
				setProperty("border.exists", true)
			else
				setProperty("borderBack.exists", false)
				setProperty("border.exists", false)
			end
			if not windowReset then
				setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
				setPropertyFromClass("openfl.Lib", "current.stage.allowsFullScreen", true)
				windowReset = true
			end
		end
	end
end

function onGameOverStart()
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") == true then
		createBorder()
	end
end

function onCountdownStarted()
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
		setArrows()
	end
end

function onExitSong()
	if getDataFromSave("playerSettings", "showBorder") ~= true then
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
			setPropertyFromClass("flixel.FlxG", "width", 1280)
		end
	end
end

function onRestartSong()
	if getDataFromSave("playerSettings", "showBorder") ~= true then
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
			setPropertyFromClass("flixel.FlxG", "width", 1280)
		end
	end
end

function onOpenChartEditor()
	if getDataFromSave("playerSettings", "showBorder") ~= true then
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
			setPropertyFromClass("flixel.FlxG", "width", 1280)
		end
	end
end

function onOpenCharacterEditor()
	if getDataFromSave("playerSettings", "showBorder") ~= true then
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
			setPropertyFromClass("flixel.FlxG", "width", 1280)
		end
	end
end

function onDestroy()
	if getDataFromSave("playerSettings", "showBorder") ~= true then
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
			runHaxeCode([[FlxG.resizeWindow(1280,720)]])
			runHaxeCode([[FlxG.resizeGame(1280,720)]])
			setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") - wideScreen)
			setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
			setPropertyFromClass("openfl.Lib", "current.stage.allowsFullScreen", true)
		end
	end
end