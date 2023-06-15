-- FreeplayState
local wideScreen = (26 * 6) + 4
local wideScreen2 = 0

local songs = {"Mushroom Plains", "Bricks and Lifts", "Lethal Lava Lair", "Deep Deep Voyage", "Hop-Hop Heights", "Koopa Armada", "2 PLAYER GAME", "Destruction Dance", "Portal Power", "Bullet Time", "Boo Blitz", "Cross Console Clash", "Wrong Warp", "First Level", "Green Screen"}

local curSelected = 1
local curSongPlaying = -1

local grpSongs = {}
local grpIcons = {}
local grpFlags = {}
local grpRatings = {}

local canControl = true

local existingSongs = {}
local existingDifficulties = {}

local selectedCategory = 0
local nextFlash = 0.5

local secretGroup = {"secretBg", "secretDoorShadow", "secretDoor"}
	
local secretCount = 0
local secretTimer = 0

local savedSongs = {"mushroomPlains", "bricksAndLifts", "lethalLavaLair", "deepDeepVoyage", "hopHopHeights", "koopaArmada", "2PlayerGame", "destructionDance", "portalPower", "bulletTime", "booBlitz", "crossConsoleClash", "wrongWarp", "firstLevel", "greenScreen"}
local secretSongs = {"Wrong Warp", "first level :)", "Green Screen"}
local lockedSongs = {}

local timmy = false
local funRoom = true

-- SongSubState
local grpMenuShit = {"songMenuText1", "songMenuText2"}
local menuItems = {"Play", "Exit"}
local curSelectedSub = 1
local transitionType = 0
local bgPos = 0
local song = nil
local inSongSub = false

-- Code
function onCreate()
	for i = 1,#savedSongs do
		initSaveData(savedSongs[i].."-"..difficultyName, "funkmixadvanceSongs")
		if savedSongs[i] == "wrongWarp" or savedSongs[i] == "firstLevel" then
			if getDataFromSave(savedSongs[i].."-"..difficultyName, "unlocked") == "unlocked" then
				setDataFromSave(savedSongs[i].."-"..difficultyName, "unlocked", false)
			end
		end
	end
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		wideScreen = 0
		wideScreen2 = (26 * 6) + 4
	end
	selectedCategory = 0

	makeLuaSprite("bgFreeplayBack", nil, 0, 0)
	makeGraphic("bgFreeplayBack", screenWidth, screenHeight, "000000")
	setObjectCamera("bgFreeplayBack", "other")
	addLuaSprite("bgFreeplayBack", false)

	-- SECRET STUFF
	makeLuaSprite("secretBg", "menus/freeplayDX/firstLevel/bgfirst", wideScreen, 0)
	if funDoor() then
		loadGraphic("secretBg", "menus/freeplayDX/firstLevel/bgfirst-fun")
	end
	setObjectCamera("secretBg", "other")
	scaleObject("secretBg", 6, 6)
	setProperty("secretBg.antialiasing", false)

	if funDoor() and getDataFromSave("funValues", "bore") == true then
		makeAnimatedLuaSprite("secretDoor", "menus/freeplayDX/firstLevel/door-fun", wideScreen + 72 * 6, 51 * 6)
		addAnimationByPrefix("secretDoor", "closed", "closed", 15)
		addAnimationByPrefix("secretDoor", "open", "open", 15, false)
	else
		makeAnimatedLuaSprite("secretDoor", "menus/freeplayDX/firstLevel/door", wideScreen + 72 * 6, 51 * 6)
		addAnimationByPrefix("secretDoor", "closed", "closed", 15)
		addAnimationByPrefix("secretDoor", "open1", "open1", 15, false)
		addAnimationByPrefix("secretDoor", "open2", "open2", 15, false)
		addAnimationByPrefix("secretDoor", "open3", "open3", 15, false)
		addAnimationByPrefix("secretDoor", "open4", "open4", 15, false)
		addAnimationByPrefix("secretDoor", "open5", "open5", 15, false)
	end
	setObjectCamera("secretDoor", "other")
	scaleObject("secretDoor", 6, 6)
	setProperty("secretDoor.antialiasing", false)

	makeLuaSprite("secretDoorShadow", "menus/freeplayDX/firstLevel/door_shadow", getProperty("secretDoor.x") + (2 * 6), getProperty("secretDoor.y") + (2 * 6))
	setObjectCamera("secretDoorShadow", "other")
	scaleObject("secretDoorShadow", 6, 6)
	setProperty("secretDoorShadow.alpha", 0.36)
	setProperty("secretDoorShadow.antialiasing", false)
	if funDoor() then
		setProperty("secretDoorShadow.alpha", 0)
	end

	-- LOAD CHARACTERS

	makeAnimatedLuaSprite("bgFreeplay", "menus/freeplayDX/bg", wideScreen, 0)
	addAnimationByPrefix("bgFreeplay", "idle", "idle", 0, false)
	setObjectCamera("bgFreeplay", "other")
	scaleObject("bgFreeplay", 6, 6)
	setProperty("bgFreeplay.antialiasing", false)
	addLuaSprite("bgFreeplay", false)

	for i = 1,#secretGroup do
		setProperty(secretGroup[i]..".visible", false)
		addLuaSprite(secretGroup[i])
	end

	makeLuaSprite("arrow", "menus/freeplayDX/arrow", wideScreen + 147 * 6, 104 * 6)
	setObjectCamera("arrow", "other")
	scaleObject("arrow", 6, 6)
	setProperty("arrow.antialiasing", false)
	addLuaSprite("arrow", false)

	makeLuaText("grpName", "STORY MODE", 0, 0, 106 * 6 - 3)
	setTextBorder("grpName", 0, "000000")
	setTextFont("grpName", "smb1.ttf")
	setTextSize("grpName", 8 * 6)
	setObjectCamera("grpName", "other")
	updateHitbox("grpName")
	screenCenter("grpName", "x")
	setProperty("grpName.x", math.floor(getProperty("grpName.x") / 6) * 6 + (1 * 6) + 1)
	setObjectOrder("grpName", getObjectOrder("arrow"))
	addLuaText("grpName")

	addWeeks()

	-- Preload Song Sub State
	makeAnimatedLuaSprite("bgSong", "menus/song/bg", wideScreen, 0)
	makeLuaSprite("bgSongWide", nil, 0, 0)
	makeLuaText("levelInfo", songDetails, 0, wideScreen, (4 * 6) + (3 * 6 - 3))
	makeLuaText("description", songDesc, 0, wideScreen + 64 * 6 + (2 * 6 + 3), 23 * 6 + (3 * 6 - 3))
	makeAnimatedLuaSprite("levelThumb", "menus/song/thumbnails", wideScreen + 5 * 6, 24 * 6)
	makeLuaText("score", songScore, 0, wideScreen + 3 * 6 + (2 * 6 + 3), 80 * 6 + (3 * 6 - 3))
	makeAnimatedLuaSprite("flagIconSong", "ui/pixel/flags", wideScreen + 40 * 6, 81 * 6)
	makeAnimatedLuaSprite("ratingIconSong", "ui/pixel/rankings", wideScreen + 49 * 6, 81 * 6)
	makeLuaSprite("selectorSong", "menus/song/selector", 0, (12 * 6))
	makeLuaText("songMenuText1", "cock", 0, wideScreen + 10 * 6 + (2 * 6 + 3), (10 * 6 * (i - 1)) + (94 * 6) + (3 * 6 - 3))
	makeLuaText("songMenuText2", "balls", 0, wideScreen + 10 * 6 + (2 * 6 + 3), (10 * 6 * (i - 1)) + (94 * 6) + (3 * 6 - 3))
end

function onCreatePost()
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true and getDataFromSave("songSaveData", "startIntro") ~= true then
		if getDataFromSave("songSaveData", "isStoryMode") ~= true then
			setProperty("grpName.x", getProperty("grpName.x") - wideScreen2)
			setProperty("grpName.x", math.floor(getProperty("grpName.x") / 6) * 6 + 1)
		end
	end
end

function songSubState(selectedSong, unlocked)
	menuItems = {"Play", "Exit"}
	curSelectedSub = 1
	transitionType = 1
	bgPos = screenHeight
	song = selectedSong

	local folderName = song:gsub(" ", "-")
	folderName = folderName:lower()
	if folderName == "first-level-:)" then
		folderName = "first-level"
	end

	local bgTypePath = "data/"..folderName.."/freeplay/bgType.txt"
	local thumbPath = "data/"..folderName.."/freeplay/thumbnail.txt"
	local textPath = "data/"..folderName.."/freeplay/description.txt"
	local hintPath = "data/"..folderName.."/freeplay/hint.txt"

	bgType = 0
	local thumbID = 0
	local songDesc = "I HAVE FURY!"

	bgType = tonumber(getTextFromFile(bgTypePath))
	thumbID = tonumber(getTextFromFile(thumbPath))
	if unlocked then
		songDesc = getTextFromFile(textPath)
	else
		songDesc = getTextFromFile(hintPath)
	end

	if not unlocked then
		menuItems = {"Exit"}
		thumbID = 15
		bgType = 6
	end

	makeAnimatedLuaSprite("bgSong", "menus/song/bg", wideScreen, 0)
	addAnimationByPrefix("bgSong", "idle", "idle", 0, false)
	setProperty("bgSong.animation.frameIndex", bgType)
	setObjectCamera("bgSong", "other")
	scaleObject("bgSong", 6, 6)
	setProperty("bgSong.antialiasing", false)
	setProperty("bgSong.alpha", 1)
	addLuaSprite("bgSong", false)

	local bgFrameX = 0
	local bgFrameY = 0
	local loopCount = 0
	for i = 1,getProperty("bgSong.animation.frameIndex") do
		bgFrameX = bgFrameX + 1
		if bgFrameX > 3 then
			bgFrameX = 0
			bgFrameX = bgFrameX + 1
		end
		if getProperty("bgSong.animation.frameIndex") % 3 == 0 then
			bgFrameX = 0
		end
		if i % 3 == 0 then
			loopCount = loopCount + 1
		end
	end
	bgFrameY = loopCount

	local bgTypeColor = string.format("%x", getPixelColor("bgSong", 160 * bgFrameX, 120 * bgFrameY))
	bgTypeColor = string.sub(bgTypeColor, 11, 16)

	makeLuaSprite("bgSongWide", nil, -wideScreen2, 0)
	makeGraphic("bgSongWide", screenWidth, screenHeight, bgTypeColor)
	setObjectCamera("bgSongWide", "other")
	setObjectOrder("bgSongWide", getObjectOrder("bgSong") - 1)
	addLuaSprite("bgSongWide", false)

	local songDetails = selectedSong
	if not unlocked then
		songDetails = "???"
	end

	makeLuaText("levelInfo", songDetails, 0, wideScreen, (4 * 6) + (3 * 6 - 3))
	setTextSize("levelInfo", 8 * 6)
	setTextBorder("levelInfo", 0, "000000")
	setTextFont("levelInfo", "smb1.ttf")
	setObjectCamera("levelInfo", "other")
	updateHitbox("levelInfo")
	setObjectOrder("levelInfo", getObjectOrder("bgSong") + 1)
	addLuaText("levelInfo")
	levelInfoPos = getProperty("levelInfo.y")

	makeLuaText("description", songDesc, 0, wideScreen + 64 * 6 + (2 * 6 + 3), 23 * 6 + (3 * 6 - 3))
	setTextSize("description", 5 * 6)
	setTextBorder("description", 0, "000000")
	setTextFont("description", "pixel_small.ttf")
	setObjectCamera("description", "other")
	updateHitbox("description")
	setObjectOrder("description", getObjectOrder("bgSong") + 1)
	addLuaText("description")
	setTextAlignment("description")
	descriptionPos = getProperty("description.y")

	makeAnimatedLuaSprite("levelThumb", "menus/song/thumbnails", wideScreen + 5 * 6, 24 * 6)
	addAnimationByPrefix("levelThumb", "idle", "idle", 0, false)
	setProperty("levelThumb.animation.frameIndex", thumbID)
	setObjectCamera("levelThumb", "other")
	scaleObject("levelThumb", 6, 6)
	setProperty("levelThumb.antialiasing", false)
	setProperty("levelThumb.alpha", 1)
	setObjectOrder("levelThumb", getObjectOrder("bgSong") + 1)
	addLuaSprite("levelThumb", false)
	levelThumbPos = getProperty("levelThumb.y")
	
	local songScore = 0
	if getDataFromSave(savedSongs[curSelected].."-"..difficultyName, "songScore") ~= "songScore" then
		songScore = getDataFromSave(savedSongs[curSelected].."-"..difficultyName, "songScore")
	end

	makeLuaText("score", songScore, 0, wideScreen + 3 * 6 + (2 * 6 + 3), 80 * 6 + (3 * 6 - 3))
	setTextSize("score", 5 * 6)
	setTextBorder("score", 0, "000000")
	setTextFont("score", "pixel_small.ttf")
	setObjectCamera("score", "other")

	if songScore < 10 then
		setTextString("score", "00000"..songScore)
	elseif songScore >= 10 and songScore < 100 then
		setTextString("score", "0000"..songScore)
	elseif songScore >= 100 and songScore < 1000 then
		setTextString("score", "000"..songScore)
	elseif songScore >= 1000 and songScore < 10000 then
		setTextString("score", "00"..songScore)
	elseif songScore >= 10000 and songScore < 100000 then
		setTextString("score", "0"..songScore)
	end

	updateHitbox("score")
	setObjectOrder("score", getObjectOrder("bgSong") + 1)
	addLuaText("score")
	scorePos = getProperty("score.y")

	makeAnimatedLuaSprite("flagIconSong", "ui/pixel/flags", wideScreen + 40 * 6, 81 * 6)
	addAnimationByPrefix("flagIconSong", "icon", "idle", 0, false)
	if getDataFromSave(savedSongs[curSelected].."-"..difficultyName, "cleared") ~= true or getDataFromSave(savedSongs[curSelected].."-"..difficultyName, "flagRating") == 0 then
		setProperty("flagIconSong.animation.frameIndex", getProperty("flagIconSong.numFrames") - 1)
	else
		setProperty("flagIconSong.animation.frameIndex", getDataFromSave(savedSongs[curSelected].."-"..difficultyName, "flagRating"))
	end
	setObjectCamera("flagIconSong", "other")
	scaleObject("flagIconSong", 6, 6)
	setProperty("flagIconSong.antialiasing", false)
	addLuaSprite("flagIconSong", false)
	flagIconPos = getProperty("flagIconSong.y")

	makeAnimatedLuaSprite("ratingIconSong", "ui/pixel/rankings", wideScreen + 49 * 6, 81 * 6)
	addAnimationByPrefix("ratingIconSong", "icon", "idle", 0, false)
	if getDataFromSave(savedSongs[curSelected].."-"..difficultyName, "cleared") ~= true then
		setProperty("ratingIconSong.animation.frameIndex", 1)
	else
		local leRating = getDataFromSave(savedSongs[curSelected].."-"..difficultyName, "accuracy")
		if leRating == 1 then
			setProperty("ratingIconSong.animation.frameIndex", 9)
		elseif leRating < 1 and leRating >= 0.9 then
			setProperty("ratingIconSong.animation.frameIndex", 8)
		elseif leRating < 0.9 and leRating >= 0.8 then
			setProperty("ratingIconSong.animation.frameIndex", 7)
		elseif leRating < 0.8 and leRating >= 0.7 then
			setProperty("ratingIconSong.animation.frameIndex", 6)
		elseif leRating < 0.7 and leRating >= 0.69 then
			setProperty("ratingIconSong.animation.frameIndex", 5)
		elseif leRating < 0.69 and leRating >= 0.6 then
			setProperty("ratingIconSong.animation.frameIndex", 4)
		elseif leRating < 0.6 and leRating >= 0.5 then
			setProperty("ratingIconSong.animation.frameIndex", 3)
		elseif leRating < 0.5 and leRating >= 0.4 then
			setProperty("ratingIconSong.animation.frameIndex", 2)
		elseif leRating < 0.4 and leRating >= 0.2 then
			setProperty("ratingIconSong.animation.frameIndex", 1)
		elseif leRating < 0.2 and leRating > 0 then
			setProperty("ratingIconSong.animation.frameIndex", 0)
		end
	end
	setObjectCamera("ratingIconSong", "other")
	scaleObject("ratingIconSong", 6, 6)
	setProperty("ratingIconSong.antialiasing", false)
	addLuaSprite("ratingIconSong", false)
	ratingIconPos = getProperty("ratingIconSong.y")

	makeLuaSprite("selectorSong", "menus/song/selector", 0, (12 * 6))
	setObjectCamera("selectorSong", "other")
	scaleObject("selectorSong", 6, 6)
	setProperty("selectorSong.antialiasing", false)
	addLuaSprite("selectorSong", false)

	screenCenter("levelInfo", "x")
	setProperty("levelInfo.x", math.floor(getProperty("levelInfo.x") / 6) * 6 + (1 * 6 + 1))

	if not unlocked or bgType == 6 then
		setProperty("score.visible", false)
		setProperty("flagIconSong.visible", false)
		setProperty("ratingIconSong.visible", false)
	end

	for i = 1,#menuItems do
		makeLuaText("songMenuText"..i, menuItems[i], 0, wideScreen + 10 * 6 + (2 * 6 + 3), (10 * 6 * (i - 1)) + (94 * 6) + (3 * 6 - 3))
		setTextSize("songMenuText"..i, 5 * 6)
		setTextBorder("songMenuText"..i, 0, "000000")
		setTextFont("songMenuText"..i, "pixel_small.ttf")
		setObjectCamera("songMenuText"..i, "other")
		updateHitbox("songMenuText"..i)
		setObjectOrder("songMenuText"..i, getObjectOrder("selectorSong") + 1)
		addLuaText("songMenuText"..i)
	end
	songText1Pos = getProperty("songMenuText1.y")
	if unlocked and bgType ~= 6 then
		songText2Pos = getProperty("songMenuText2.y")
	end

	setProperty("bgSong.y", bgPos)
	setProperty("bgSongWide.y", bgPos)
	setProperty("levelInfo.y", levelInfoPos + getProperty("bgSong.y"))
	setProperty("description.y", descriptionPos + getProperty("bgSong.y"))
	setProperty("levelThumb.y", levelThumbPos + getProperty("bgSong.y"))
	setProperty("score.y", scorePos + getProperty("bgSong.y"))
	setProperty("flagIconSong.y", flagIconPos + getProperty("bgSong.y"))
	setProperty("ratingIconSong.y", ratingIconPos + getProperty("bgSong.y"))
	setProperty("songMenuText1.y", songText1Pos + getProperty("bgSong.y"))
	if unlocked and bgType ~= 6 then
		setProperty("songMenuText2.y", songText2Pos + getProperty("bgSong.y"))
	end
	setProperty("selectorSong.x", getProperty("songMenuText"..curSelectedSub..".x") - (6 * 6) - 3)
	setProperty("selectorSong.y", getProperty("songMenuText"..curSelectedSub..".y") + (1 * 6) - 3)
	
	playSound("pause", 1)
	inSongSub = true
end

function addWeeks()
	if selectedCategory == 0 then
		songs = {"Mushroom Plains", "Bricks and Lifts", "Lethal Lava Lair", "Deep Deep Voyage", "Hop-Hop Heights", "Koopa Armada", nil, nil, nil}
		savedSongs = {"mushroomPlains", "bricksAndLifts", "lethalLavaLair", "deepDeepVoyage", "hopHopHeights", "koopaArmada", nil, nil, nil}
	elseif selectedCategory == 1 then
		songs = {"2 PLAYER GAME", "Destruction Dance", "Portal Power", "Bullet Time", "Boo Blitz", "Cross Console Clash", "Wrong Warp", "first level :)", nil}
		savedSongs = {"2PlayerGame", "destructionDance", "portalPower", "bulletTime", "booBlitz", "crossConsoleClash", "wrongWarp", "firstLevel", "greenScreen"}
		if getDataFromSave("greenScreen", "cleared") == true then
			songs[9] = "Green Screen"
		end
	end

	for i = 1,9 do
		removeLuaText("songText"..i)
		removeLuaSprite("icon"..i)
		removeLuaSprite("flag"..i)
		removeLuaSprite("rating"..i)
	end

	grpSongs = {}
	grpIcons = {}
	grpFlags = {}
	grpRatings = {}

	lockedSongs = {}

	for i = 1,#songs do
		local unlocked = true
		local songDetails = songs[i]

		for j = 1,#secretSongs do
			if secretSongs[j] == songs[i] and getDataFromSave(savedSongs[i].."-"..difficultyName, "cleared") ~= true then
				unlocked = false
			end
			if not unlocked then
				lockedSongs[#lockedSongs + 1] = {songs[i]}
				songDetails = "???"
			end
		end

		makeLuaText("songText"..i, songDetails, 0, -wideScreen2 + (49 * 6) + 1, (9 * 6 * (i - 1)) + (13 * 6) + 3)
		setTextBorder("songText"..i, 0, "000000")
		setTextFont("songText"..i, "pixel_small.ttf")
		setTextSize("songText"..i, 5 * 6)
		setObjectCamera("songText"..i, "other")
		updateHitbox("songText"..i)
		setObjectOrder("songText"..i, getObjectOrder("bgFreeplay") + 1)
		grpSongs[i] = {"songText"..i}

		local iconName = "icons"
		if selectedCategory == 1 then
			iconName = "icons2"
		end

		makeAnimatedLuaSprite("icon"..i, "menus/freeplayDX/"..iconName, wideScreen + (12 * 6) - 2, getProperty("songText"..i..".y") - (1 * 6) + 1)
		addAnimationByPrefix("icon"..i, "idle", "idle", 0, false)
		if unlocked then
			setProperty("icon"..i..".animation.frameIndex", i - 1)
		else
			setProperty("icon"..i..".animation.frameIndex", 9)
		end
		setObjectCamera("icon"..i, "other")
		scaleObject("icon"..i, 6, 6)
		setProperty("icon"..i..".antialiasing", false)
		setObjectOrder("icon"..i, getObjectOrder("songText"..i) + 1)
		grpIcons[i] = {"icon"..i}

		makeAnimatedLuaSprite("flag"..i, "ui/pixel/flags", wideScreen + (133 * 6) - 2, getProperty("songText"..i..".y") - (1 * 6) + 1)
		addAnimationByPrefix("flag"..i, "idle", "idle", 0, false)
		if getDataFromSave(savedSongs[i].."-"..difficultyName, "cleared") ~= true or getDataFromSave(savedSongs[i].."-"..difficultyName, "flagRating") == 0 then
			setProperty("flag"..i..".animation.frameIndex", getProperty("flag"..i..".numFrames") - 1)
		else
			setProperty("flag"..i..".animation.frameIndex", getDataFromSave(savedSongs[i].."-"..difficultyName, "flagRating"))
		end
		setObjectCamera("flag"..i, "other")
		scaleObject("flag"..i, 6, 6)
		setProperty("flag"..i..".antialiasing", false)
		setObjectOrder("flag"..i, getObjectOrder("songText"..i) + 1)
		grpFlags[i] = {"flag"..i}

		makeAnimatedLuaSprite("rating"..i, "ui/pixel/rankings", wideScreen + (143 * 6) - 2, getProperty("songText"..i..".y") - (1 * 6) + 1)
		addAnimationByPrefix("rating"..i, "idle", "idle", 0, false)
		if getDataFromSave(savedSongs[i].."-"..difficultyName, "cleared") ~= true then
			setProperty("rating"..i..".animation.frameIndex", 1)
		else
			local leRating = getDataFromSave(savedSongs[i].."-"..difficultyName, "accuracy")
			if leRating == 1 then
				setProperty("rating"..i..".animation.frameIndex", 9)
			elseif leRating < 1 and leRating >= 0.9 then
				setProperty("rating"..i..".animation.frameIndex", 8)
			elseif leRating < 0.9 and leRating >= 0.8 then
				setProperty("rating"..i..".animation.frameIndex", 7)
			elseif leRating < 0.8 and leRating >= 0.7 then
				setProperty("rating"..i..".animation.frameIndex", 6)
			elseif leRating < 0.7 and leRating >= 0.69 then
				setProperty("rating"..i..".animation.frameIndex", 5)
			elseif leRating < 0.69 and leRating >= 0.6 then
				setProperty("rating"..i..".animation.frameIndex", 4)
			elseif leRating < 0.6 and leRating >= 0.5 then
				setProperty("rating"..i..".animation.frameIndex", 3)
			elseif leRating < 0.5 and leRating >= 0.4 then
				setProperty("rating"..i..".animation.frameIndex", 2)
			elseif leRating < 0.4 and leRating >= 0.2 then
				setProperty("rating"..i..".animation.frameIndex", 1)
			elseif leRating < 0.2 and leRating > 0 then
				setProperty("rating"..i..".animation.frameIndex", 0)
			end
		end
		setObjectCamera("rating"..i, "other")
		scaleObject("rating"..i, 6, 6)
		setProperty("rating"..i..".antialiasing", false)
		setObjectOrder("rating"..i, getObjectOrder("songText"..i) + 1)
		grpRatings[i] = {"rating"..i}

		addLuaText(grpSongs[i])
		addLuaSprite(grpIcons[i])
		addLuaSprite(grpFlags[i])
		addLuaSprite(grpRatings[i])
	end
	changeSelection(0)
end

function changeCategorySelection(change)
	local oldCategory = selectedCategory
	selectedCategory = selectedCategory + change

	if selectedCategory > 1 then
		selectedCategory = 1
	elseif selectedCategory < -1 then
		selectedCategory = -1
	end

	if oldCategory ~= selectedCategory then
		addWeeks()
		playSound("menu_select", 1)

		local grpText = selectedCategory
		if grpText == 0 then
			grpText = "STORY MODE"
		elseif grpText == 1 then 
			grpText = "CHALLENGES"
		elseif grpText == -1 then
			grpText = "???"
		end

		for i = 1,#secretGroup do
			setProperty(secretGroup[i]..".visible", selectedCategory == -1)
		end
		setPropertyFromClass("flixel.FlxG", "mouse.visible", selectedCategory == -1)

		if funDoor() and getDataFromSave("funValues", "bore") == true then
			if selectedCategory == -1 then
				runHaxeCode([[FlxG.sound.music.pause()]])
			else
				runHaxeCode([[FlxG.sound.music.resume()]])
			end
		elseif funDoor() and getDataFromSave("funValues", "bore") == false then
			if oldCategory == -1 then
				setDataFromSave("funValues", "fun", 0)
				loadGraphic("secretBg", "menus/freeplayDX/firstLevel/bgfirst")
				setProperty("secretDoorShadow.alpha", 0.36)
			end
		end

		setTextString("grpName", grpText)
		updateHitbox("grpName")
		screenCenter("grpName", "x")
		setProperty("grpName.x", math.floor(getProperty("grpName.x") / 6) * 6 + (1 * 6) + 1)

		curSelected = 1
	end

	if selectedCategory == 1 then
		setProperty("arrow.x", wideScreen + 6 * 6)
	else
		setProperty("arrow.x", wideScreen + 147 * 6)
	end
	setProperty("arrow.flipX", selectedCategory == 1)

	setProperty("bgFreeplay.animation.frameIndex", selectedCategory)

	changeSelection(0)
end

function onUpdate(elapsed)
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if getTextString("curMenuGlobal") == "2" and inSongSub == false then
		setTextString("canPressBack", true)
		if canControl then
			if keyJustPressed("up") then
				changeSelection(-1)
			end
			if keyJustPressed("down") then
				changeSelection(1)
			end

			if keyJustPressed("left") then
				changeCategorySelection(-1)
			end
			if keyJustPressed("right") then
				changeCategorySelection(1)
			end
			setTextString("curSelectedGlobal", curSelected)
			setTextString("curCategoryGlobal", selectedCategory)
		end
		setTextString("canControlGlobal", canControl)

		if selectedCategory == -1 then
			-- secret door
			if getMouseX("other") >= getProperty("secretDoor.x") and getMouseX("other") < getProperty("secretDoor.x") + getProperty("secretDoor.width") and getMouseY("other") >= getProperty("secretDoor.y") and getMouseY("other") < getProperty("secretDoor.y") + getProperty("secretDoor.height") then
				if mouseClicked() then
					if secretCount >= 10 then
						return
					end

					secretCount = secretCount + 1
					secretTimer = 0.3

					if secretCount >= 10 then
						canControl = false

						playSound("door_open", 0.5)
						if funDoor() and getDataFromSave("funValues", "bore") == true then
							playAnim("secretDoor", "open")
							runTimer("delayForFadeOut", 1)
							setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
						else
							playAnim("secretDoor", "open"..getRandomInt(0, 4, 0))
							runTimer("gotoFirstLevel", 3)
						end
						updateHitbox("secretDoor")
					else
						playSound("knock"..getRandomInt(0, 4, 0), 0.5)
					end
				end
			end

			secretTimer = secretTimer - elapsed
			if secretCount > 0 and secretCount < 10 and secretTimer <= 0 then
				secretCount = 0
			end
		end

		if keyJustPressed("accept") and canControl and selectedCategory ~= -1 then
			local unlocked = getDataFromSave(savedSongs[curSelected].."-"..difficultyName, "unlocked")
			if unlocked == "unlocked" then 
				unlocked = true
			end
			songSubState(songs[curSelected], unlocked)
		end

		nextFlash = nextFlash - elapsed
		if nextFlash <= 0 then
			setProperty("arrow.visible", not getProperty("arrow.visible"))
			nextFlash = 0.5
		end
	elseif getTextString("curMenuGlobal") == "2" and inSongSub == true then
		setTextString("canPressBack", false)
		
		if canControl then
			if keyJustPressed("up") then
				changeSelectionSub(-1)
			end
			if keyJustPressed("down") then
				changeSelectionSub(1)
			end
			setTextString("curSelectedGlobal", curSelectedSub)
		end
		setTextString("canControlGlobal", canControl)

		if keyJustPressed("accept") and canControl then
			canControl = false
			local daSelected = menuItems[curSelectedSub]
			if song == "first level :)" then
				song = "First Level"
			end

			if daSelected == "Play" then
				setDataFromSave("songSaveData", "isStoryMode", false)
				setPropertyFromClass("PlayState", "storyPlaylist", {songName, song, songName})
				if song ~= "Green Screen" then
					playSound("coin", 1)
					flicker(grpMenuShit[curSelectedSub], 0.8, 0.05, false)
					runTimer("playSong", 1)
				else
					setDataFromSave("songSaveData", "startIntro", true)
					addLuaScript("scripts/extra/menus/GameboyStartup")
				end
			elseif daSelected == "Exit" then
				transitionType = -1
				canControl = false
				playSound("pause", 1)
			end
		end

		if transitionType == 1 then
			bgPos = bgPos - (18 * 130 * elapsed)
			setProperty("bgSong.y", math.floor(bgPos / 6) * 6)
			setProperty("bgSongWide.y", math.floor(bgPos / 6) * 6)
			if bgPos <= 0 then
				bgPos = 0
				setProperty("bgSong.y", 0)
				setProperty("bgSongWide.y", 0)
				transitionType = 0
				canControl = true
			end
		end

		if transitionType == -1 then
			bgPos = bgPos + (18 * 130 * elapsed)
			setProperty("bgSong.y", math.floor(bgPos / 6) * 6)
			setProperty("bgSongWide.y", math.floor(bgPos / 6) * 6)
			if bgPos >= screenHeight then
				bgPos = screenHeight
				setProperty("bgSong.y", screenHeight)
				setProperty("bgSongWide.y", screenHeight)
				transitionType = 0
				canControl = true
				inSongSub = false
			end
		end

		setProperty("levelInfo.y", levelInfoPos + getProperty("bgSong.y"))
		setProperty("description.y", descriptionPos + getProperty("bgSong.y"))
		setProperty("levelThumb.y", levelThumbPos + getProperty("bgSong.y"))
		setProperty("score.y", scorePos + getProperty("bgSong.y"))
		setProperty("flagIconSong.y", flagIconPos + getProperty("bgSong.y"))
		setProperty("ratingIconSong.y", ratingIconPos + getProperty("bgSong.y"))
		setProperty("songMenuText1.y", songText1Pos + getProperty("bgSong.y"))
		if getDataFromSave(savedSongs[curSelected].."-"..difficultyName, "unlocked") and bgType ~= 6 then
			setProperty("songMenuText2.y", songText2Pos + getProperty("bgSong.y"))
		end
		setProperty("selectorSong.x", getProperty("songMenuText"..curSelectedSub..".x") - (6 * 6) - 3)
		setProperty("selectorSong.y", getProperty("songMenuText"..curSelectedSub..".y") + (1 * 6) - 3)
	else
		if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
			wideScreen = 0
			wideScreen2 = (26 * 6) + 4
		else
			wideScreen = (26 * 6) + 4
			wideScreen2 = 0
		end
		setProperty("secretBg.x", wideScreen)
		setProperty("secretDoor.x", wideScreen + 72 * 6)
		setProperty("secretDoorShadow.x", getProperty("secretDoor.x") + (2 * 6))
		setProperty("bgFreeplay.x", wideScreen)
		setProperty("arrow.x", wideScreen + 147 * 6)
		screenCenter("grpName", "x")
		setProperty("grpName.x", math.floor(getProperty("grpName.x") / 6) * 6 + (1 * 6) + 1)
		for i = 1,#grpSongs do
			setProperty("songText"..i..".x", -wideScreen2 + (49 * 6) + 1)
			setProperty("icon"..i..".x", wideScreen + (12 * 6) - 2)
			setProperty("flag"..i..".x", wideScreen + (133 * 6) - 2)
			setProperty("rating"..i..".x", wideScreen + (143 * 6) - 2)
		end

		local oldCategory = selectedCategory
		selectedCategory = 0
		if oldCategory ~= selectedCategory then
			addWeeks()
			setTextString("grpName", "STORY MODE")
			updateHitbox("grpName")
			screenCenter("grpName", "x")
			setProperty("grpName.x", math.floor(getProperty("grpName.x") / 6) * 6 + (1 * 6) + 1)
			for i = 1,#secretGroup do
				setProperty(secretGroup[i]..".visible", selectedCategory == -1)
			end
			changeCategorySelection(0)
		end
		curSelected = 1
		changeSelection(0)
	end
end

function changeSelection(change)
	if selectedCategory < 0 then
		return
	end

	if change ~= 0 and #grpSongs > 1 then
		playSound("menu_select", 1)
	end

	curSelected = curSelected + change

	if curSelected < 1 then
		curSelected = #songs
	end
	if curSelected > #songs then
		curSelected = 1
	end

	-- song switching stuffs

	local bullShit = 1

	for item = 1,#grpSongs do
		bullShit = bullShit + 1

		setProperty("songText"..item..".color", 0x00E69C21)

		if curSelected == bullShit -  1 then
			setProperty("songText"..item..".color", 0x00FFFFFF)
		end
	end
end

function changeSelectionSub(change)
	curSelectedSub = curSelectedSub + change

	if curSelectedSub < 1 then
		curSelectedSub = #menuItems
	elseif curSelectedSub > #menuItems then
		curSelectedSub = 1
	end
		
	if change ~= 0 then
		playSound("menu_select", 1)
	end

	local bullShit = 1

	for item = 1,#grpMenuShit do
		if bullShit == curSelectedSub then
			setProperty("selectorSong.x", getProperty(grpMenuShit[item]..".x") - (6 * 6) - 3)
			setProperty("selectorSong.y", getProperty(grpMenuShit[item]..".y") + (1 * 6) - 3)
		end
		bullShit = bullShit + 1
	end
end

function onTimerCompleted(tag)
	if tag == "gotoFirstLevel" and getTextString("curMenuGlobal") == "2" then
		if getDataFromSave("firstLevel-"..difficultyName, "cleared") ~= true then
			setDataFromSave("songSaveData", "isStoryMode", false)
			setPropertyFromClass("PlayState", "storyPlaylist", {songName, "First Level", songName})

			makeLuaSprite("black", nil, 0, 0)
			makeGraphic("black", screenWidth, screenHeight, "000000")
			setObjectCamera("black", "other")
			addLuaSprite("black")
			setObjectOrder("black", getObjectOrder("border") - 1)
			timmy = true
		else
			canControl = true
			playAnim("secretDoor", "closed")
			updateHitbox("secretDoor")
			secretCount = 0
		end
	elseif tag == "delayForFadeOut" then
		setDataFromSave("songSaveData", "isStoryMode", false)
		-- setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Dev Room", songName})

		makeLuaSprite("black", nil, 0, 0)
		makeGraphic("black", screenWidth, screenHeight, "000000")
		setObjectCamera("black", "other")
		setProperty("black.alpha", 0)
		addLuaSprite("black", true)
		setObjectOrder("secretDoor", getObjectOrder("black") + 1)
		doTweenAlpha("fadeOutFakeHall", "black", 1, 1, "linear")

		makeLuaText("placeholder", "ROOM UNDER CONSTRUCTION\nCome back later.",0,0,0)
		setTextSize("placeholder", getTextSize("placeholder")*3)
		setObjectCamera("placeholder", "other")
		screenCenter("placeholder")
		addLuaText("placeholder")
	end
end

function onUpdatePost()
	if timmy then
		endSong()
	end

	setProperty("bgFreeplayBack.exists", getTextString("curMenuGlobal") == "2")
	setProperty("secretBg.exists", getTextString("curMenuGlobal") == "2")
	setProperty("secretDoor.exists", getTextString("curMenuGlobal") == "2")
	setProperty("secretDoorShadow.exists", getTextString("curMenuGlobal") == "2")
	setProperty("bgFreeplay.exists", getTextString("curMenuGlobal") == "2")
	setProperty("arrow.exists", getTextString("curMenuGlobal") == "2")
	setProperty("grpName.exists", getTextString("curMenuGlobal") == "2")
	for i = 1,9 do
		setProperty("songText"..i..".exists", getTextString("curMenuGlobal") == "2")
		setProperty("icon"..i..".exists", getTextString("curMenuGlobal") == "2")
		setProperty("flag"..i..".exists", getTextString("curMenuGlobal") == "2")
		setProperty("rating"..i..".exists", getTextString("curMenuGlobal") == "2")
	end
end

function onTweenCompleted(tag)
	if tag == "fadeOutFakeHall" then
		doTweenAlpha("fadeOutMysteryDoor", "secretDoor", 0, 1, "linear")
	elseif tag == "fadeOutMysteryDoor" then
		exitSong()
	end
end

function flicker(object, duration, interval, endVisibility)
	local visability = false
	runTimer("flickerDur", duration)
	runTimer("flickerInt", interval, math.huge)

	function onTimerCompleted(tag)
		if tag == "flickerInt" then
			setProperty(object..".visible", visability)
			visability = not visability
		end

		if tag == "flickerDur" then
			cancelTimer("flickerInt")
			if endVisibility then
				setProperty(object..".visible", true)
			end

			if daSelected == "STORY MODE" then
				changeCategorySelection(2)
				setTextString("subMenuGlobal", 1)
			elseif daSelected == "EXTRAS" then
				changeCategorySelection(1)
				setTextString("subMenuGlobal", 1)
			elseif daSelected == "BACK" then
				changeCategorySelection(0)
				setTextString("subMenuGlobal", 0)
			end
		end

		if tag == "playSong" then
			endSong()
		end
	end
end

function funDoor()
	return getDataFromSave("funValues", "fun") == 66 and getDataFromSave("firstLevel-"..difficultyName, "cleared") == true and funRoom
end