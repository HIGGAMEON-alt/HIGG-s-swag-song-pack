local wideScreen = (26 * 6) + 4
local wideScreen2 = (5 * 6) + 2

local grpMenuShit2 = {}
local grpMenuShit = {}

local curSelected = 1
local curGroup = 0

local submenuGroup = {"submenuText", "submenuText2", "submenuText3", "mario"}

local marioY = 0
local timeUntilStart = 0.4
local marioVelocity = 0

local menuItems = {"STORY MODE", "FREEPLAY", "OPTIONS", "EXTRAS"}
local menuItems2 = {"CREDITS", "RESET SAVE", "BACK"}
local menuItems3 = {"WORLD 1", "WORLD 2", "BACK"}
local curArray = {}
local canControl = true
local resetSave = false
local deleteData = false
local allCompleted = false

allSavedSongs = {
	"mushroomPlains",
	"bricksAndLifts",
	"lethalLavaLair",
	"mushroomPlainsBSide",
	"bricksAndLiftsBSide",
	"lethalLavaLairBSide",
	"deepDeepVoyage",
	"hopHopHeights",
	"koopaArmada",
	"2PlayerGame",
	"destructionDance",
	"portalPower",
	"bulletTime",
	"booBlitz",
	"crossConsoleClash",
	"wrongWarp",
	"firstLevel",
	"greenScreen",
	"balls",
	"gameOver",
	"lovesEnd",
	"hyperactiveStarblaze",
	"coOp",
	"starColors",
	"snowyPlains",
	"overfilled",
	"vagueMemories",
	"hammered",
	"athleticPAL"}
local initSavedSongs = {"mushroomPlains", "bricksAndLifts", "lethalLavaLair", "deepDeepVoyage", "hopHopHeights", "koopaArmada", "2PlayerGame", "destructionDance", "portalPower", "bulletTime", "booBlitz", "crossConsoleClash", "wrongWarp", "firstLevel", "greenScreen", "balls"}
local creditSongs = {"mushroomPlains", "bricksAndLifts", "lethalLavaLair", "deepDeepVoyage", "hopHopHeights", "koopaArmada", "2PlayerGame", "destructionDance", "portalPower", "bulletTime", "booBlitz", "crossConsoleClash", "wrongWarp", "firstLevel"}

function onCreate()
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		wideScreen = 0
		wideScreen2 = (32 * 6)
	end

	makeLuaSprite("bgMenu", "menus/titleDX/bg", wideScreen, 0)
	setObjectCamera("bgMenu", "other")
	scaleObject("bgMenu", 6, 6)
	setProperty("bgMenu.antialiasing", false)
	addLuaSprite("bgMenu", false)

	makeLuaSprite("bgMenu2", "menus/titleDX/bg", wideScreen + getProperty("bgMenu.width"), 0)
	setObjectCamera("bgMenu2", "other")
	scaleObject("bgMenu2", 6, 6)
	setProperty("bgMenu2.antialiasing", false)
	addLuaSprite("bgMenu2", false)

	makeLuaSprite("bgMenu3", "menus/titleDX/bg", wideScreen - getProperty("bgMenu.width"), 0)
	setObjectCamera("bgMenu3", "other")
	scaleObject("bgMenu3", 6, 6)
	setProperty("bgMenu3.antialiasing", false)
	addLuaSprite("bgMenu3", false)

	makeAnimatedLuaSprite("thumbnail", "menus/titleDX/thumbnails", wideScreen + 103 * 6, 38 * 6)
	addAnimationByPrefix("thumbnail", "idle", "idle", 0, false)
	setProperty("thumbnail.animation.frameIndex", 0)
	setObjectCamera("thumbnail", "other")
	scaleObject("thumbnail", 6, 6)
	setProperty("thumbnail.antialiasing", false)
	addLuaSprite("thumbnail", false)

	makeLuaSprite("selectorMenu", "menus/titleDX/selector", wideScreen, 12 * 6)
	setObjectCamera("selectorMenu", "other")
	scaleObject("selectorMenu", 6, 6)
	setProperty("selectorMenu.antialiasing", false)
	addLuaSprite("selectorMenu", false)

	makeLuaSprite("submenu", nil, 0, 0)
	makeGraphic("submenu", screenWidth, screenHeight, "000000")
	setObjectCamera("submenu", "other")
	setProperty("submenu.antialiasing", false)

	-- submenu group
	makeLuaText("submenuText", "Are you sure?", 0, 0, 0)
	setTextBorder("submenuText", 0, "000000")
	setTextFont("submenuText", "pixel_small.ttf")
	setTextSize("submenuText", 5 * 6)
	setObjectCamera("submenuText", "other")
	setObjectOrder("submenuText", getObjectOrder("submenu") + 1)
	updateHitbox("submenuText")
	screenCenter("submenuText", "xy")
	setProperty("submenuText.x", math.floor(getProperty("submenuText.x") / 6) * 6 + (2 * 6) + 1)
	setProperty("submenuText.y", math.floor(getProperty("submenuText.y") / 6) * 6 - (5 * 6) + 3)
	setProperty("submenuText.y", getProperty("submenuText.y") - 24 * 6)

	makeLuaText("submenuText2", "\n\nPress L+R to confirm", 0, 0, 0)
	setTextBorder("submenuText2", 0, "000000")
	setTextFont("submenuText2", "pixel_small.ttf")
	setTextSize("submenuText2", 5 * 6)
	setObjectCamera("submenuText2", "other")
	updateHitbox("submenuText2")
	screenCenter("submenuText2", "xy")
	setProperty("submenuText2.x", math.floor(getProperty("submenuText2.x") / 6) * 6 + 7)
	setProperty("submenuText2.y", math.floor(getProperty("submenuText2.y") / 6) * 6 + 3)
	setProperty("submenuText2.y", getProperty("submenuText2.y") - 24 * 6)

	makeLuaText("submenuText3", "Press ESC to exit", 0, 0, 0)
	if getPropertyFromClass("PlayState", "exitingSong") ~= "exitingSong" then
		setTextString("submenuText3", getTextString("submenuText3").."\n\nHold Z to delete mod data")
	end
	setTextBorder("submenuText3", 0, "000000")
	setTextFont("submenuText3", "pixel_small.ttf")
	setTextSize("submenuText3", 5 * 6)
	setObjectCamera("submenuText3", "other")
	updateHitbox("submenuText3")
	screenCenter("submenuText3", "xy")
	setProperty("submenuText3.x", math.floor(getProperty("submenuText3.x") / 6) * 6 + (1 * 6) + 1)
	setProperty("submenuText3.y", math.floor(getProperty("submenuText3.y") / 6) * 6 + 3)
	setProperty("submenuText3.y", getProperty("submenuText3.y") + 24 * 6)

	makeAnimatedLuaSprite("mario", "menus/titleDX/mario", 0, 0)
	addAnimationByPrefix("mario", "idle", "idle", 0, false)
	addAnimationByPrefix("mario", "die", "die", 0, false)
	setObjectCamera("mario", "other")
	scaleObject("mario", 6, 6)
	setProperty("mario.antialiasing", false)
	screenCenter("mario", "xy")
	setProperty("mario.x", math.floor(getProperty("mario.x") / 6) * 6 + 4)
	setProperty("mario.y", math.floor(getProperty("mario.y") / 6) * 6)
	marioY = getProperty("mario.y")

	curArray = menuItems
	addMenuItems()

	addLuaText(grpMenuShit2)
	addLuaText(grpMenuShit)
	addLuaSprite("submenu", false)

	makeLuaSprite("bricks", "menus/titleDX/bricks", -wideScreen2, 0)
	setObjectCamera("bricks", "other")
	scaleObject("bricks", 6, 6)
	setProperty("bricks.antialiasing", false)
	screenCenter("bricks", "x")
	addLuaSprite("bricks", false)

	makeLuaSprite("version", "menus/titleDX/info", wideScreen, 0)
	setObjectCamera("version", "other")
	scaleObject("version", 6, 6)
	setProperty("version.antialiasing", false)
	addLuaSprite("version", false)

	addLuaText(submenuGroup[1])
	addLuaText(submenuGroup[2])
	addLuaText(submenuGroup[3])
	addLuaSprite(submenuGroup[4], false)

	setProperty("submenu.visible", false)
	for i = 1,#submenuGroup do
		setProperty(submenuGroup[i]..".visible", false)
		setObjectOrder(submenuGroup[i], getObjectOrder("version") + 1)
	end
	setObjectOrder("mario", getObjectOrder(submenuGroup[1]) + 1)

	changeSelection(0)

	allCompleted = true
	for i = 1,#creditSongs do
		if getDataFromSave(creditSongs[i].."-"..difficultyName, "cleared") ~= true then
			allCompleted = false
			break
		end
	end

	if getDataFromSave("songSaveData", "startIntro") ~= true then
		if getDataFromSave("songSaveData", "isStoryMode") == true then
			if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
				wideScreen = 0
				wideScreen2 = (32 * 6)
			else
				wideScreen = (26 * 6) + 4
				wideScreen2 = (5 * 6) + 2
			end
			bgPos = wideScreen
	
			setProperty("bgMenu.x", math.floor(bgPos / 6) * 6 - 2)
			setProperty("bgMenu2.x", getProperty("bgMenu.x") + getProperty("bgMenu.width"))
			setProperty("bgMenu3.x", getProperty("bgMenu.x") - getProperty("bgMenu.width"))
			setProperty("thumbnail.x", wideScreen + 103 * 6, 38 * 6)
			setProperty("selectorMenu.x", wideScreen)
			screenCenter("submenuText", "x")
			setProperty("submenuText.x", math.floor(getProperty("submenuText.x") / 6) * 6 + (2 * 6) + 1)
			screenCenter("submenuText2", "x")
			setProperty("submenuText2.x", math.floor(getProperty("submenuText2.x") / 6) * 6 + 7)
			screenCenter("submenuText3", "x")
			setProperty("submenuText3.x", math.floor(getProperty("submenuText3.x") / 6) * 6 + (1 * 6) + 1)
			screenCenter("mario", "x")
			setProperty("mario.x", math.floor(getProperty("mario.x") / 6) * 6 + 4)
			setProperty("bricks.x", -wideScreen2)
			setProperty("version.x", wideScreen)
			for i=1,#grpMenuShit do
				setProperty("menuTextA"..i..".x", wideScreen + (12 * 6) + 3, (16 * 6 * (i - 1)) + (31 * 6) + 3)
				setProperty("menuTextB"..i..".x", getProperty("menuTextA"..i..".x") + 1 * 6)
				setProperty("menuTextB"..i..".y", getProperty("menuTextA"..i..".y") + 1 * 6)
			end
	
			curSelected = 1
			changeSelection(0)
		end
	end
end

function addMenuItems()
	for i = 1,#grpMenuShit do
		removeLuaText(grpMenuShit2[i], true)
		removeLuaText(grpMenuShit[i], true)
	end 

	for i = 1,#curArray do
		makeLuaText("menuTextA"..i, curArray[i], 0, wideScreen + (12 * 6) + 3, (16 * 6 * (i - 1)) + (31 * 6) + 3)
		setTextBorder("menuTextA"..i, 0, "000000")
		setTextFont("menuTextA"..i, "smb1.ttf")
		setTextSize("menuTextA"..i, 8 * 6)
		setObjectCamera("menuTextA"..i, "other")
		updateHitbox("menuTextA"..i)
		setObjectOrder("menuTextA"..i, getObjectOrder("selectorMenu") + 1)

		makeLuaText("menuTextB"..i, curArray[i], 0, 0, 0)
		setTextBorder("menuTextB"..i, 0, "000000")
		setTextFont("menuTextB"..i, "smb1.ttf")
		setTextSize("menuTextB"..i, 8 * 6)
		setObjectCamera("menuTextB"..i, "other")
		updateHitbox("menuTextB"..i)
		setProperty("menuTextB"..i..".x", getProperty("menuTextA"..i..".x") + 1 * 6)
		setProperty("menuTextB"..i..".y", getProperty("menuTextA"..i..".y") + 1 * 6)
		setProperty("menuTextB"..i..".color", 0x000000)
		setObjectOrder("menuTextB"..i, getObjectOrder("selectorMenu"))

		grpMenuShit2[i] = "menuTextB"..i
		grpMenuShit[i] = "menuTextA"..i
	end
	canControl = true
end

function onUpdate(elapsed)
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if getTextString("curMenuGlobal") == "1" or getTextString("curMenuGlobal") == "-1" then
		if getTextString("curMenuGlobal") == "-1" then
			canControl = false
		end

		if getTextString("optionsPipeExitFix") == "false" then
			setTextString("optionsPipeExitFix", "true")
			canControl = true
		end

		if getProperty("oldScreen.exists") == true then
			canControl = false
		end

		if canControl then
			setTextString("curSelectedGlobal", curSelected)
			if keyJustPressed("up") then
				changeSelection(-1)
			end
			if keyJustPressed("down") then
				changeSelection(1)
			end

			if keyJustPressed("back") then
				if curGroup ~= 0 then
					changeCategorySelection(0)
				end
			end
		else
			if getProperty("submenu.visible") then
				if not resetSave then
					if keyJustPressed("back") then
						canControl = true
						setProperty("submenu.visible", false)
						for i = 1,#submenuGroup do
							setProperty(submenuGroup[i]..".visible", false)
						end
					end
					if getPropertyFromClass("flixel.FlxG", "keys.pressed.L") and getPropertyFromClass("flixel.FlxG", "keys.pressed.R") then
						playAnim("mario", "die")
						updateHitbox("mario")

						if getPropertyFromClass("flixel.FlxG", "sound.music") ~= nil then
							setPropertyFromClass("flixel.FlxG", "sound.music.volume", 0)
						end

						playSound("death", 1)

						runTimer("wipeSave", 3)

						marioVelocity = -750
						resetSave = true
					end
				else
					timeUntilStart = timeUntilStart - elapsed
					if timeUntilStart <= 0 then
						marioVelocity = marioVelocity + (12.5 * 130 * elapsed)
						marioY = marioY + marioVelocity * elapsed
						setProperty("mario.y", math.floor(marioY / 6) * 6)
					end
				end
			end
		end

		setTextString("canControlGlobal", canControl)

		if keyJustPressed("accept") and canControl then
			daSelected = curArray[curSelected]
			local menuItem = grpMenuShit[curSelected];
			local menuItemBG = grpMenuShit2[curSelected];
			canControl = false

			if daSelected == "WORLD 1" then
				playSound("coin", 1)
				flicker(menuItem, 1, 0.05, true)
				runTimer("playWorld1", 1)
			elseif daSelected == "WORLD 2" then
				playSound("coin", 1)
				flicker(menuItem, 1, 0.05, true)
				runTimer("playWorld2", 1)
			elseif daSelected == "STORY MODE" then
				playSound("stomp", 1)
				flicker(menuItem, 1, 0.05, true)
			elseif daSelected == "FREEPLAY" then
				playSound("stomp", 1)
				flicker(menuItem, 1, 0.05, true)
				runTimer("switchFreeplay", 1)
			elseif daSelected == "OPTIONS" then
				playSound("stomp", 1)
				flicker(menuItem, 1, 0.05, true)
				runTimer("switchOptions", 1)
			elseif daSelected == "EXTRAS" then
				playSound("stomp", 1)
				flicker(menuItem, 1, 0.05, true)
			elseif daSelected == "BACK" then
				playSound("stomp", 1)
				flicker(menuItem, 1, 0.05, true)
			elseif daSelected == "CREDITS" then
				if allCompleted then
					playSound("coin", 1)
					flicker(menuItem, 1, 0.05, true);
					runTimer("switchCredits", 1)
				else
					playSound("bump")
					canControl = true
				end
			elseif daSelected == "RESET SAVE" then
				playSound("stomp", 1)
				flicker(menuItem, 1, 0.05, true)
				runTimer("switchResetSubmenu", 1)
			end
		end

		bgPos = bgPos - 96 * elapsed
		if bgPos + getProperty("bgMenu.width") <= 0 then
			bgPos = 0
		end
		if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
			setProperty("bgMenu.x", math.floor(bgPos / 6) * 6)
		else
			setProperty("bgMenu.x", math.floor(bgPos / 6) * 6 - 2)
		end
		setProperty("bgMenu2.x", getProperty("bgMenu.x") + getProperty("bgMenu.width"))
		setProperty("bgMenu3.x", getProperty("bgMenu.x") - getProperty("bgMenu.width"))

		addLuaScript("scripts/extra/codes/Konami Code")
		for i = 1,2 do
			addLuaScript("scripts/extra/codes/Invincibility Code"..i)
		end
	else
		if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
			wideScreen = 0
			wideScreen2 = (32 * 6)
		else
			wideScreen = (26 * 6) + 4
			wideScreen2 = (5 * 6) + 2
		end
		bgPos = wideScreen

		setProperty("bgMenu.x", math.floor(bgPos / 6) * 6 - 2)
		setProperty("bgMenu2.x", getProperty("bgMenu.x") + getProperty("bgMenu.width"))
		setProperty("bgMenu3.x", getProperty("bgMenu.x") - getProperty("bgMenu.width"))
		setProperty("thumbnail.x", wideScreen + 103 * 6, 38 * 6)
		setProperty("selectorMenu.x", wideScreen)
		screenCenter("submenuText", "x")
		setProperty("submenuText.x", math.floor(getProperty("submenuText.x") / 6) * 6 + (2 * 6) + 1)
		screenCenter("submenuText2", "x")
		setProperty("submenuText2.x", math.floor(getProperty("submenuText2.x") / 6) * 6 + 7)
		screenCenter("submenuText3", "x")
		setProperty("submenuText3.x", math.floor(getProperty("submenuText3.x") / 6) * 6 + (1 * 6) + 1)
		screenCenter("mario", "x")
		setProperty("mario.x", math.floor(getProperty("mario.x") / 6) * 6 + 4)
		setProperty("bricks.x", -wideScreen2)
		setProperty("version.x", wideScreen)
		for i=1,#grpMenuShit do
			setProperty("menuTextA"..i..".x", wideScreen + (12 * 6) + 3, (16 * 6 * (i - 1)) + (31 * 6) + 3)
			setProperty("menuTextB"..i..".x", getProperty("menuTextA"..i..".x") + 1 * 6)
			setProperty("menuTextB"..i..".y", getProperty("menuTextA"..i..".y") + 1 * 6)
		end

		curSelected = 1
		changeSelection(0)

		if keyJustPressed("back") and getTextString("subMenuGlobal") == "0" and getTextString("canControlGlobal") == "true" then
			canControl = true
			setTextString("canControlGlobal", canControl)
		end
	end

	if keyJustPressed("accept") and getTextString("curMenuGlobal") == "4" then
		canControl = getTextString("canControlGlobal")
		setTextString("canControlGlobal", canControl)
	end
end

function onUpdatePost()
	setProperty("thumbnail.animation.frameIndex", (curSelected - 1) + (4 * curGroup))
	for i = 1,4 do
		setProperty(grpMenuShit2[i]..".visible", getProperty(grpMenuShit[i]..".visible"))
	end

	if getTextString("curMenuGlobal") == "1" or tonumber(getTextString("curMenuGlobal")) <= 0 then
		setProperty("bgMenu.exists", true)
		setProperty("bgMenu2.exists", true)
		setProperty("bgMenu3.exists", true)
		setProperty("thumbnail.exists", true)
		setProperty("selectorMenu.exists", true)
		addLuaSprite("selectorMenu", true)
		setProperty("submenu.exists", true)
		setProperty("submenuText.exists", true)
		setProperty("submenuText2.exists", true)
		setProperty("mario.exists", true)
		setProperty("bricks.exists", true)
		setProperty("version.exists", true)
		for i = 1,4 do
			setProperty("menuTextA"..i..".exists",true)
			setProperty("menuTextB"..i..".exists",true)
		end
	else
		setProperty("bgMenu.exists", false)
		setProperty("bgMenu2.exists", false)
		setProperty("bgMenu3.exists", false)
		setProperty("thumbnail.exists", false)
		setProperty("selectorMenu.exists", false)
		addLuaSprite("selectorMenu", false)
		setProperty("submenu.exists", false)
		setProperty("submenuText.exists", false)
		setProperty("submenuText2.exists", false)
		setProperty("mario.exists", false)
		setProperty("bricks.exists", false)
		setProperty("version.exists", false)
		for i = 1,4 do
			setProperty("menuTextA"..i..".exists",false)
			setProperty("menuTextB"..i..".exists",false)
		end
	end
end

function changeCategorySelection(newGroup)
	curGroup = newGroup
	curSelected = 1

	curArray = menuItems
	if newGroup == 1 then
		curArray = menuItems2
	end
	if newGroup == 2 then
		curArray = menuItems3
	end

	addMenuItems()
	changeSelection(0)
end

function changeSelection(change)
	curSelected = curSelected + change

	if curSelected < 1 then
		curSelected = #curArray
	end
	if curSelected > #curArray then
		curSelected = 1
	end

	if change ~= 0 then
		playSound("menu_select", 1)
	end

	local bullShit = 1

	for item = 1,#grpMenuShit do
		if bullShit == curSelected then
			setProperty("selectorMenu.x", getProperty(grpMenuShit[item]..".x") - (8 * 6) + 3)
			setProperty("selectorMenu.y", getProperty(grpMenuShit[item]..".y") + (3 * 6) + 3)
		end

		bullShit = bullShit + 1
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
			setProperty(object..".visible", endVisibility)

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

		if tag == "switchResetSubmenu" then
			setProperty("submenu.visible", true)
			for i = 1,#submenuGroup do
				setProperty(submenuGroup[i]..".visible", true)
			end
		end

		if tag == "wipeSave" then
			if getPropertyFromClass("PlayState", "exitingSong") ~= "exitingSong" then
				if getPropertyFromClass("flixel.FlxG", "keys.pressed.Z") then
					deleteData = true
					exitSong()
				else
					for i = 1,#initSavedSongs do
						deleteDataFromSave(initSavedSongs[i].."-".."superstar")
						deleteDataFromSave(initSavedSongs[i].."-".."classic")
						deleteDataFromSave(initSavedSongs[i].."-".."hard")
					end
					restartSong(true)
				end
			else
				for i = 1,#initSavedSongs do
					setDataFromSave(initSavedSongs[i].."-"..difficultyName, "cleared", false)
					setDataFromSave(initSavedSongs[i].."-"..difficultyName, "songScore", 0)
					setDataFromSave(initSavedSongs[i].."-"..difficultyName, "accuracy", 0)
					setDataFromSave(initSavedSongs[i].."-"..difficultyName, "flagRating", 0)
					flushSaveData(initSavedSongs[i])
				end
				restartSong(true)
			end
		end
	end
end

function onDestroy()
	if deleteData then
		deleteDataFromSave("playerSettings")
		deleteDataFromSave("songSaveData")
		deleteDataFromSave("funValues")
		for i = 1,#allSavedSongs do
			deleteDataFromSave(allSavedSongs[i].."-".."superstar")
			deleteDataFromSave(allSavedSongs[i].."-".."classic")
			deleteDataFromSave(allSavedSongs[i].."-".."hard")
		end
	end
end