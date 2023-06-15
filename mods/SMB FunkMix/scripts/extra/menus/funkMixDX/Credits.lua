local wideScreen = (26 * 6) + 4

local screenCount = 17
local curScreen = 0

local nextImage = 6
local switchScreen = false
local yPos = 0

local allowEndSong = false

function onCreate()
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then 
		wideScreen = 0
	end
	nextImage = 6

	if getPropertyFromClass("flixel.FlxG", "sound.music") ~= nil then
		setPropertyFromClass("flixel.FlxG", "sound.music.volume", 0)
	end
	
	playSound("dx-credits", 0.9, "music")

	makeLuaSprite("creditScreen", nil, 0, 0)
	makeGraphic("creditScreen", screenWidth, screenHeight, "000000")
	setObjectCamera("creditScreen", "other")
	addLuaSprite("creditScreen", false)

	makeLuaSprite("image1", "menus/credits/screens/0", wideScreen, 0)
	scaleObject("image1", 6, 6)
	setObjectCamera("image1", "other")
	setProperty("image1.antialiasing", false)
	addLuaSprite("image1", false)

	makeLuaSprite("image2", "menus/credits/screens/0", wideScreen, screenHeight)
	scaleObject("image2", 6, 6)
	setObjectCamera("image2", "other")
	setProperty("image2.antialiasing", false)
	addLuaSprite("image2", false)
end

function onUpdate(elapsed)
	if (songName ~= "Funk Mix DX" or (songName == "Funk Mix DX" and getTextString("curMenuGlobal") == "4")) and getProperty("creditScreen.visible") then
		nextImage = nextImage - elapsed
		if nextImage <= 0 and curScreen ~= screenCount then
			local imageName = tostring(curScreen + 1)
			if curScreen + 1 == 15 then
				if getDataFromSave("greenScreen-"..difficultyName, "cleared") == true then
					imageName = imageName.."-alt"
				end
			end

			nextImage = 5.125
			makeLuaSprite("image2", "menus/credits/screens/"..imageName, wideScreen, screenHeight)
			scaleObject("image2", 6, 6)
			setObjectCamera("image2", "other")
			setProperty("image2.antialiasing", false)
			addLuaSprite("image2", false)

			switchScreen = true
			curScreen = curScreen + 1
		end

		if switchScreen then
			yPos = yPos - 500 * elapsed
			if yPos < -screenHeight then
				yPos = 0
				switchScreen = false

				local imageName = tostring(curScreen)
				if curScreen == 15 then
					if getDataFromSave("greenScreen-"..difficultyName, "cleared") == true then
						imageName = imageName.."-alt"
					end
				end

				makeLuaSprite("image1", "menus/credits/screens/"..imageName, wideScreen, 0)
				scaleObject("image1", 6, 6)
				setObjectCamera("image1", "other")
				setProperty("image1.antialiasing", false)
				addLuaSprite("image1", false)
			end

			setProperty("image1.y", math.floor(yPos / 6) * 6)
			setProperty("image2.y", getProperty("image1.y") + screenHeight)
		end
	else
		curScreen = 0

		nextImage = 6
		switchScreen = false
		yPos = 0

		setProperty("creditScreen.visible", false)
		setProperty("image1.visible", false)
		setProperty("image2.visible", false)
		setTextString("canControlGlobal", true)

		aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
		if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then 
			wideScreen = 0
		else
			wideScreen = (26 * 6) + 4
		end
	end

	if keyJustPressed("accept") then
		stopSound("music")
		if songName == "Funk Mix DX" then
			removeLuaScript("scripts/extra/menus/funkMixDX/Credits", true)
		end
	end
end