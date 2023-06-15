local wideScreen = (26 * 6) + 4

function onCreate()
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then 
		wideScreen = 0
	end
	playMusic("epilogue", 0.7, false)

	makeLuaSprite("epilogueBack", nil, 0, 0)
	makeGraphic("epilogueBack", screenWidth, screenHeight, "000000")
	setObjectCamera("epilogueBack", "other")
	addLuaSprite("epilogueBack", false)

	makeLuaSprite("image", "menus/epilogue/epilogue", wideScreen, 0)
	setProperty("image.antialiasing", false)
	scaleObject("image", 6, 6)
	setObjectCamera("image", "other")
	addLuaSprite("image", false)
end

function onUpdate()
	if keyJustPressed("accept") then
		setDataFromSave("songSaveData", "sceneNum", -1)
		endSong()
	end
end