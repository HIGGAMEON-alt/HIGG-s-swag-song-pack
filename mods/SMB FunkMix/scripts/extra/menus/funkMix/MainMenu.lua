local grpMenuShit2 = {}
local grpMenuShit1 = {}
local curSelected = 1
local menuItems = {"STORY MODE", "FREEPLAY", "OPTIONS"}
local canControl = true

function onCreate()
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then 
		wideScreen = 0
	else
		wideScreen = (26 * 6) + 4
	end

	makeLuaSprite("bgTitle", "menus/title/bg", 0, 0)
	setObjectCamera("bgTitle", "other")
	scaleObject("bgTitle", 6, 6)
	screenCenter("bgTitle", "x")
	setProperty("bgTitle.x", getProperty("bgTitle.x") + 3)
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		setProperty("bgTitle.x", getProperty("bgTitle.x") - ((26 * 6) + 4))
	end
	setProperty("bgTitle.antialiasing", false)
	addLuaSprite("bgTitle", false)

	makeLuaSprite("logo", "menus/title/logo", (6 * 6) + wideScreen, 4 * 6)
	setObjectCamera("logo", "other")
	scaleObject("logo", 6, 6)
	setProperty("logo.antialiasing", false)
	addLuaSprite("logo", false)

	makeLuaSprite("version", "menus/title/version", (132 * 6) + wideScreen, 112 * 6)
	setObjectCamera("version", "other")
	scaleObject("version", 6, 6)
	setProperty("version.antialiasing", false)
	addLuaSprite("version", false)

	makeLuaSprite("selector", "menus/title/selector", 0 + wideScreen, (12 * 6))
	setObjectCamera("selector", "other")
	scaleObject("selector", 6, 6)
	setProperty("selector.antialiasing", false)
	addLuaSprite("selector", false)

	for i = 1,#menuItems do
		makeLuaText("optionTextA"..i, menuItems[i], 0, 0 + wideScreen, (16 * 6 * i) + (49 * 6) - 3)
		setTextSize("optionTextA"..i, 8 * 6)
		setTextBorder("optionTextA"..i, 0, "000000")
		setTextFont("optionTextA"..i, "smb1.ttf")
		setObjectCamera("optionTextA"..i, "other")
		updateHitbox("optionTextA"..i)
		setObjectOrder("optionTextA"..i, getObjectOrder("selector"))
		if i == 1 then
			screenCenter("optionTextA"..i, "x")
			setProperty("optionTextA"..i..".x", (math.floor(getProperty("optionTextA"..i..".x") / 6) * 6) + (17 * 6) + 1)
			if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
				setProperty("optionTextA"..i..".x", getProperty("optionTextA"..i..".x") - ((26 * 6) + 4))
			end
		else
			setProperty("optionTextA"..i..".x", getProperty(grpMenuShit1[1]..".x"))
		end
		grpMenuShit1[i] = "optionTextA"..i

		makeLuaText("optionTextB"..i, menuItems[i], 0, 0 + wideScreen, (16 * 6 * i) + (49 * 6) - 3)
		setTextSize("optionTextB"..i, 8 * 6)
		setTextBorder("optionTextB"..i, 0, "000000")
		setTextFont("optionTextB"..i, "smb1.ttf")
		setObjectCamera("optionTextB"..i, "other")
		updateHitbox("optionTextB"..i)
		setProperty("optionTextB"..i..".x", getProperty("optionTextA"..i..".x") + 1 * 6)
		setProperty("optionTextB"..i..".y", getProperty("optionTextA"..i..".y") + 1 * 6)
		setTextColor("optionTextB"..i, "0x000000")
		setObjectOrder("optionTextB"..i, getObjectOrder("selector") - 1)
		grpMenuShit2[i] = "optionTextB"..i

		addLuaText(grpMenuShit2[i])
		addLuaText(grpMenuShit1[i])
	end

	setProperty("selector.x", getProperty(grpMenuShit1[1]..".x") - (16 * 6) + 3)
	setProperty("selector.y", getProperty(grpMenuShit1[1]..".y") + (1 * 6) + 3)
end

function onUpdate()
	if getTextString("curMenuGlobal") == "1" then
		setTextString("curSelectedGlobal", curSelected)		
		if getTextString("inMenuGlobal") ~= "MainMenu" then
			setTextString("inMenuGlobal", "MainMenu")
			canControl = true
		end
		if getTextString("optionsPipeExitFix") == "false" then
			setTextString("optionsPipeExitFix", "true")
			canControl = true
		end
		if keyJustPressed("back") then
			canControl = false
		end

		if canControl then
			if keyJustPressed("up") then
				changeSelection(-1)
			end
			if keyJustPressed("down") then
				changeSelection(1)
			end
		end

		if keyJustPressed("accept") and canControl then
			local daSelected = menuItems[curSelected]
			local menuItem = grpMenuShit1[curSelected]
			local menuItemBG = grpMenuShit2[curSelected]
			canControl = false
			setTextString("canControlGlobal", "false")

			if daSelected == "STORY MODE" then
				playSound("coin", 1)
				flicker(menuItem, 0.8, 0.05, false)
				setDataFromSave("songSaveData", "isStoryMode", true)
				setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Mushroom Plains", "Bricks and Lifts", "Lethal Lava Lair", songName})
				runTimer("storyTime", 1, 1)
			elseif daSelected == "FREEPLAY" then
				playSound("stomp", 1)
				flicker(menuItem, 0.8, 0.05, false)
				runTimer("freeForAll", 1, 1)
			elseif daSelected == "OPTIONS" then
				playSound("stomp", 1)
				flicker(menuItem, 0.8, 0.05, false)
				runTimer("workerMario", 1, 1)
			elseif daSelected == "EXIT" then
				playSound("power_down", 1)
				flicker(menuItem, 0.8, 0.05, false)
				runTimer("quitMenu", 1, 1)
			end
		end
		setProperty(grpMenuShit2[curSelected]..".visible", getProperty(grpMenuShit1[curSelected]..".visible"))

		for i = 1,2 do
			addLuaScript("scripts/extra/codes/Invincibility Code"..i, true)
		end
	else
		curSelected = 1
		setProperty("selector.x", getProperty(grpMenuShit1[curSelected]..".x") - (16 * 6) + 3)
		setProperty("selector.y", getProperty(grpMenuShit1[curSelected]..".y") + (1 * 6) + 3)
		for i = 1,#menuItems do
			setProperty(grpMenuShit2[i]..".visible", true)
			setProperty(grpMenuShit1[i]..".visible", true)
		end

		for i = 1,2 do
			removeLuaScript("scripts/extra/codes/Invincibility Code"..i, true)
		end
	end
end

function onUpdatePost()
	if canControl then
		setTextString("canControlGlobal", canControl)
	end
end

function changeSelection(change)
	if getTextString("curMenuGlobal") == "1" then
		curSelected = curSelected + change

		if curSelected < 1 then
			curSelected = #menuItems
		elseif curSelected > #menuItems then
			curSelected = 1
		end
		
		if change ~= 0 then
			playSound("menu_select", 1)
		end

		local bullShit = 1

		for item = 1,#menuItems do
			if bullShit == curSelected then
				setProperty("selector.x", getProperty(grpMenuShit1[item]..".x") - (16 * 6) + 3)
				setProperty("selector.y", getProperty(grpMenuShit1[item]..".y") + (1 * 6) + 3)
			end
			bullShit = bullShit + 1
		end
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
		end
	end
end