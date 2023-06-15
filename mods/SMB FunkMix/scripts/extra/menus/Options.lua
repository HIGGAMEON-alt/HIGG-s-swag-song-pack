optionsSkin = "pixel/"
local activeSubgroup = nil
local selectColor = 0xE69C21

local curSelection = 1
local curSelected = 1
local curSelectionGroup = 1
local curPipe = 3
local curCategory = nil

local lockedMovement = false
local isPipes = true
local enteringPipe = false
local marioY = 0
local ogY = 0

local pipes = {"prefs", "ctrls", "exit"}
local grpPipes = {"pipe1", "pipe2", "pipe3"}
local grpPipeText = {"pipeText1", "pipeText2", "pipeText3"}

local wideScreen = (26 * 6) + 4
local timerRunning = false
local subMenuLoaded = false
local reloadSubgroup = false

local moveByY = 27 * 6
local holdTime = 0

local pressesLeft = 8
local lastPressed = false

local easterEggTime = 123.695
local easterEggStop = -2
local totaka = false

pipeSound = "power_down"
menuSelectSound = "menu_select"
selectSound = "stomp"
bumpSound = "bump"
coinSound = "coin"

function onCreate()
	runHaxeCode([[ClientPrefs.saveSettings();]])
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then 
		wideScreen = 0
	end
	if week == "funkMixMX" then
		optionsSkin = "pcport/"
		menuSelectSound = "pcport/menu_select"
		selectSound = "pcport/stomp"
		selectColor = 0xC8913E
	end

	preferences = {"Funk Mix", "Graphics", "Visuals and UI", "Gameplay"}
	funkMix = {"Power-Ups", "Life Count:", "Quant Notes", "Funk Mix Camera", "Pause Menu Overhaul", "Show Border", "Aspect Ratio:", "Showcase Camera", "Compatibility Mode", "BotPlay Cheat", "Debug Info"}
	if getDataFromSave("playerSettings", "compatMode") == true then
		graphics = {"Low Quality", "Anti-Aliasing", "Shaders", "Framerate:"}
	else
		graphics = {"Low Quality", "Anti-Aliasing", "Framerate:"}
	end
	if getDataFromSave("playerSettings", "compatMode") == true then
		visualsAndUI = {"Note Splashes", "Hide Hud", "Time Bar:", "Flashing Lights", "Camera Zooms", "Score Text Zoom on Hit", "Health Bar Transparency", "FPS Counter", "Pause Screen Song:", "Check for Updates", "Combo Stacking"}
	else
		visualsAndUI = {"Note Splashes", "Hide Hud", "Time Bar:", "Flashing Lights", "Camera Zooms", "Score Text Zoom on Hit", "Health Bar Transparency", "FPS Counter", "Pause Screen Song:", "Check for Updates"}
	end
	ratioStrings = {"16:9", "4:3"}
	timeBarStrings = {"Time Left", "Time Elapsed", "Song Name", "Disabled"}
	pauseSongStrings = {"None", "Breakfast", "Tea Time"}
	gameplay = {"Controller Mode", "Downscroll", "Middlescroll", "Opponent Notes", "Ghost Tapping", "Disable Reset Button", "Hitsound Volume", "Rating Offset", "Sick! Hit Window", "Good Hit Window", "Bad Hit Window", "Safe Frames"}

	controls = {"NOTES", "UI", "VOLUME", "DEBUG", "Reset to Default Keys"}

	categoryMap = {preferences, controls, exit}
	setProperty("camHUD.visible", false)
    
	makeLuaSprite("bgOptions", "menus/options/"..optionsSkin.."bg", 0, 0)
	setObjectCamera("bgOptions", "other")
	scaleObject("bgOptions", 6, 6)
	screenCenter("bgOptions", "x")
	setProperty("bgOptions.x", getProperty("bgOptions.x") + 3)
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		setProperty("bgOptions.x", getProperty("bgOptions.x") - ((26 * 6) + 4))
	end
	setProperty("bgOptions.antialiasing", false)
	addLuaSprite("bgOptions", false)

	makeLuaSprite("bgOptions2", "menus/options/"..optionsSkin.."bg2", 0, 0)
	setObjectCamera("bgOptions2", "other")
	scaleObject("bgOptions2", 6, 6)
	screenCenter("bgOptions2", "x")
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		setProperty("bgOptions2.x", getProperty("bgOptions2.x") - ((26 * 6) + 4))
	end
	setProperty("bgOptions2.antialiasing", false)
	setProperty("bgOptions2.visible", false)
	addLuaSprite("bgOptions2", false)

	makeLuaText("warpText", "WELCOME TO\nWARP ZONE!", 0, (41 * 6) + wideScreen - 3, (23 * 6) - 3)
	setTextSize("warpText", 8 * 6)
	setTextBorder("warpText", 0, "000000")
	setTextFont("warpText", "smb1.ttf")
	setObjectCamera("warpText", "other")
	setObjectOrder("warpText", getObjectOrder("bgOptions") + 1)
	addLuaText("warpText")

	loadPipes()
end

function loadPipes()
	isPipes = true
	lockedMovement = false
	enteringPipe = false
	timerRunning = false
	subMenuLoaded = false
	setTextString("canControlGlobal", not lockedMovement)

	for i = 1,17 do
		-- kill previous subgroup if it exists
		if activeSubgroup ~= nil then
			removeLuaText("thisOption"..i, true)
			removeLuaSprite("checkmark"..i, true)
			removeLuaSprite("checkmarkFilled"..i, true)
			removeLuaSprite("selectorLeft"..i, true)
			removeLuaSprite("selectorRight"..i, true)
		end
	end

	makeAnimatedLuaSprite("marioOptions", "menus/options/"..optionsSkin.."mario", 0 + wideScreen, 56 * 6)
	addAnimationByPrefix("marioOptions", "glitch", "idle0", 0, false)
	setObjectCamera("marioOptions", "other")
	scaleObject("marioOptions", 6, 6)
	setProperty("marioOptions.antialiasing", false)
	addLuaSprite("marioOptions", false)

	for i = 1,#pipes do
		j = i - 1
		makeLuaText("pipeText"..i, pipes[i], 0, 4 * 6 + wideScreen + 3, 66 * 6 + 3)
		setTextSize("pipeText"..i, 8 * 6)
		setTextBorder("pipeText"..i, 0, "000000")
		setProperty("pipeText"..i..".x", getProperty("pipeText"..i..".x") + 56 * 6 * j)
		setTextFont("pipeText"..i, "smb1.ttf")
		setObjectOrder("pipeText"..i, getObjectOrder("warpText") + 1)
		setObjectCamera("pipeText"..i, "other")
		setTextAlignment("pipeText"..i, "center")
		if i == 1 then
			setProperty("pipeText"..i..".x", getProperty("pipeText"..i..".x") + 1 * 6)
		elseif i == 3 and pipes[3] == "exit" then
			setProperty("pipeText"..i..".x", getProperty("pipeText"..i..".x") + 4 * 6)
		end
		addLuaText(grpPipeText[i])

		makeLuaSprite("pipe"..i, "menus/options/"..optionsSkin.."pipe", 8 * 6 + wideScreen, 88 * 6)
		setProperty("pipe"..i..".x", getProperty("pipe"..i..".x") + 56 * 6 * j)
		setObjectCamera("pipe"..i, "other")
		scaleObject("pipe"..i, 6, 6)
		setProperty("pipe"..i..".antialiasing", false)
		addLuaSprite(grpPipes[i], false)
	end

	selectPipe(0)

	setProperty("marioOptions.visible", true)
	setProperty("bgOptions.visible", true)
	setProperty("warpText.visible", true)
	setProperty("bgOptions2.visible", false)

	setProperty("marioOptions.x", 42 * 6 - 2)
	setProperty("marioOptions.x", getProperty("marioOptions.x") + 56 * 6 * (curPipe - 1))
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		setProperty("marioOptions.x", getProperty("marioOptions.x") - ((26 * 6) + 4))
	end
	marioY = 56 * 6
	ogY = 56 * 6
	setProperty("marioOptions.y", ogY)

	for i = 1,#pipes do 
		if i == curPipe then
			setProperty("pipeText"..i..".visible", false)
		else
			setProperty("pipeText"..i..".visible", true)
		end
		setProperty(grpPipes[i]..".visible", true)
	end

	for i = 1,17 do
		setProperty("thisOption"..i..".visible", getProperty("bgOptions2.visible"))
		setProperty("checkmark"..i..".visible", getProperty("bgOptions2.visible"))
		setProperty("selectorLeft"..i..".visible", getProperty("bgOptions2.visible"))
		setProperty("selectorRight"..i..".visible", getProperty("bgOptions2.visible"))
		setProperty("chosenOptionString"..i..".visible", getProperty("bgOptions2.visible"))
	end
end

function loadGroup()
	categoryMap = {preferences, controls, exit}
	settingTypePref = {"subgroup", "subgroup", "subgroup", "subgroup", "subgroup", "subgroup"}

	lockedMovement = false
	setTextString("canControlGlobal", not lockedMovement)

	for i = 1,#pipes do
		setProperty(grpPipes[i]..".visible", false)
		setProperty(grpPipeText[i]..".visible", false)
	end

	for i = 1,17 do
		-- kill previous subgroup if it exists
		if activeSubgroup ~= nil then
			removeLuaText("thisOption"..i, true)
			removeLuaSprite("checkmark"..i, true)
			removeLuaSprite("checkmarkFilled"..i, true)
			removeLuaSprite("selectorLeft"..i, true)
			removeLuaSprite("selectorRight"..i, true)
			removeLuaText("chosenOptionString"..i, true)
		end
	end

	-- load subgroup lmfao
	if pipes[curPipe] == "ctrls" then
		settingTypePref = {"subgroup", "subgroup", "subgroup", "subgroup", "trigger"}
	end

	setProperty("marioOptions.visible", false)
	setProperty("bgOptions.visible", false)
	setProperty("warpText.visible", false)
	setProperty("bgOptions2.visible", true)

	if categoryMap[curPipe] == preferences then
		moveByY = 38 * 6
	elseif categoryMap[curPipe] == controls then
		moveByY = 34 * 6
	end

	activeSubgroup = categoryMap[curPipe]
	returnSubgroup(categoryMap[curPipe])
	returnExtrasMap(settingTypePref)

	-- reset the selection
	curSelection = 1
	selectOption(curSelection)

	updateCheckmark()
	updateTable()
end

function selectPipe(change)
	if getTextString("curMenuGlobal") == "3" and getTextString("subMenuGlobal") == "0" then
		if change ~= 0 then
			playSound(menuSelectSound)
		end

		curPipe = curPipe + change
		if curPipe > #pipes then
			curPipe = 1
		elseif curPipe < 1 then
			curPipe = #pipes
		end
		
		setProperty("marioOptions.x", 42 * 6 - 2)
		setProperty("marioOptions.x", getProperty("marioOptions.x") + 56 * 6 * (curPipe - 1))
		if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
			setProperty("marioOptions.x", getProperty("marioOptions.x") - ((26 * 6) + 4))
		end

		for i = 1,#grpPipeText do 
			if i == curPipe then
				setProperty("pipeText"..i..".visible", false)
			else
				setProperty("pipeText"..i..".visible", true)
			end
		end
	end
end

function selectOption(newSelection)
	if newSelection ~= curSelection and getTextString("thisOption"..curSelection) ~= "thisOption"..curSelection then
		playSound(menuSelectSound)
	end

	-- direction increment finder
	if newSelection > curSelection then
		directionIncrement = 1 
	else 
		directionIncrement = -1
	end

	-- updates to that new selection
	curSelection = newSelection
	-- skip line if the selected script is null (indicates line break)
	if activeSubgroup[curSelection] == "" then
		curSelection = curSelection + directionIncrement
	end

	-- wrap the current selection
	if curSelection < 1 then
		curSelection = #activeSubgroup
	elseif curSelection > #activeSubgroup then
		curSelection = 1
	end

	-- set the correct group stuffs lol
	for i = 1,#activeSubgroup + 1 do
	 	setProperty("thisOption"..i..".color", selectColor)
		if curSelection ~= "" then
			setAttachmentColor("thisOption"..i, selectColor)
			setAttachmentColor("checkmark"..i, selectColor)
			setAttachmentColor("selectorLeft"..i, selectColor)
			setAttachmentColor("selectorRight"..i, selectColor)
			setAttachmentColor("chosenOptionString"..i, selectColor)
		end

		-- check for null members and hardcode the dividers
		setProperty("thisOption"..curSelection..".color", 0xFFFFFF)
		setProperty("checkmark"..curSelection..".color", 0xFFFFFF)
		setProperty("selectorLeft"..curSelection..".color", 0xFFFFFF)
		setProperty("selectorRight"..curSelection..".color", 0xFFFFFF)
		setProperty("chosenOptionString"..curSelection..".color", 0xFFFFFF)
	end

	setProperty(activeSubgroup[curSelection]..".color", 0xFFFFFF)
	setProperty("checkmark"..curSelection..".color", 0xFFFFFF)
	if curSelection == "" then
		setAttachmentColor(activeSubgroup[curSelection], 0xFFFFFF)
		setAttachmentColor("checkmark"..curSelection, 0xFFFFFF)
		setAttachmentColor("selectorLeft"..curSelection, 0xFFFFFF)
		setAttachmentColor("selectorRight"..curSelection, 0xFFFFFF)
		setAttachmentColor("chosenOptionString"..curSelection, 0xFFFFFF)
	end

	settingInfo()
end

function loadSubgroup(subgroupName)
	lockedMovement = false
	setTextString("canControlGlobal", not lockedMovement)

	for i = 1,17 do
		-- kill previous subgroup if it exists
		if activeSubgroup ~= nil then
			removeLuaText("thisOption"..i, true)
			removeLuaSprite("checkmark"..i, true)
			removeLuaSprite("checkmarkFilled"..i, true)
			removeLuaSprite("selectorLeft"..i, true)
			removeLuaSprite("selectorRight"..i, true)
			removeLuaText("chosenOptionString"..i, true)
		end
	end

	if subgroupName == funkMix then
		moveByY = 17 * 6
	elseif subgroupName == graphics then
		if getDataFromSave("playerSettings", "compatMode") == false then
			moveByY = 42 * 6
		else
			moveByY = 49 * 6
		end
	elseif subgroupName == visualsAndUI then
		if getDataFromSave("playerSettings", "compatMode") == false then
			moveByY = 17 * 6
		else
			moveByY = 21 * 6
		end
	elseif subgroupName == gameplay then
		moveByY = 14 * 6
	else
		moveByY = 27 * 6
	end

	-- load subgroup lmfao
	activeSubgroup = subgroupName
	returnSubgroup(subgroupName)
	returnExtrasMap(settingTypePref)

	setProperty("marioOptions.visible", false)
	setProperty("bgOptions.visible", false)
	setProperty("warpText.visible", false)
	setProperty("bgOptions2.visible", true)

	-- reset the selection
	if not reloadSubgroup then
		curSelection = 1
	end
	selectOption(curSelection)

	for i = 1,#activeSubgroup do
		setProperty("thisOption"..i..".visible", getProperty("bgOptions2.visible"))
		setProperty("checkmark"..i..".visible", getProperty("bgOptions2.visible"))
		setProperty("selectorLeft"..i..".visible", getProperty("bgOptions2.visible"))
		setProperty("selectorRight"..i..".visible", getProperty("bgOptions2.visible"))
		setProperty("chosenOptionString"..i..".visible", getProperty("bgOptions2.visible"))
	end

	updateCheckmark()
	updateTable()
end

function setAttachmentColor(attachment, newColor)
	-- oddly enough, you can't set alphas of objects that arent directly and inherently defined as a value.
	-- ya flixel is weird lmao
	if attachment ~= nil then
		setProperty(attachment..".color", newColor)
		-- therefore, I made a script to circumvent this by defining the attachment with the `attachment` variable!
		-- pretty neat, huh?
	end
end

function onUpdate(elapsed)
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if reloadSubgroup then
		loadSubgroup(activeSubgroup)
		if (aspectRatio == "4:3" and getPropertyFromClass("openfl.Lib", "current.stage.stageWidth") == 960) or (aspectRatio == "16:9" and getPropertyFromClass("openfl.Lib", "current.stage.stageWidth") == 1280) or getDataFromSave("playerSettings", "showBorder") == true then
			reloadSubgroup = false
		end
	end

	if getTextString("curMenuGlobal") == "3" then
		if getDataFromSave("playerSettings", "compatMode") == false then
			graphics = {"Low Quality", "Anti-Aliasing", "Shaders", "Framerate:"}
			visualsAndUI = {"Note Splashes", "Hide Hud", "Time Bar:", "Flashing Lights", "Camera Zooms", "Score Text Zoom on Hit", "Health Bar Transparency", "FPS Counter", "Pause Screen Song:", "Check for Updates", "Combo Stacking"}
		else
			graphics = {"Low Quality", "Anti-Aliasing", "Framerate:"}
			visualsAndUI = {"Note Splashes", "Hide Hud", "Time Bar:", "Flashing Lights", "Camera Zooms", "Score Text Zoom on Hit", "Health Bar Transparency", "FPS Counter", "Pause Screen Song:", "Check for Updates"}
		end
		if getTextString("subMenuGlobal") == "0" then
			if week ~= "funkMix" then
				if easterEggTime > 0 then
					easterEggTime = easterEggTime - elapsed
					if easterEggTime <= 0 then
						totaka = true
						easterEggTime = -2
						easterEggStop = 8.7
						playMusic("totakaSong", 0.55, false)
					end
				end

				if easterEggStop > 0 then
					easterEggStop = easterEggStop - elapsed
					if easterEggStop <= 0 then
						totaka = false
						easterEggTime = 123.695
						easterEggStop = -2
						playMusic("optionsMenu", 0.55, true)
					end
				end
			end

			setTextString("subMenuGlobal", 0)
			setTextString("curSelectedGlobal", curPipe)
			if not lockedMovement then
				if keyJustPressed("left") then
					selectPipe(-1)
				end
				if keyJustPressed("right") then
					selectPipe(1)
				end
				if keyJustPressed("down") then
					lockedMovement = true
					setTextString("canControlGlobal", "false")
					enteringPipe = true
					playSound(pipeSound)

					if pipes[curPipe] == "exit" then
						if getTextString("optionsPipeExitFix") == "true" then
							setTextString("optionsPipeExitFix", "false")
						end
					end
				end
				if keyJustPressed("back") and getTextString("subMenuGlobal") == "0" then
					runHaxeCode([[ClientPrefs.saveSettings();]])
					if songName == "Options" then
						lockedMovement = true
						setTextString("canControlGlobal", "false")
						exitSong(false)
					end
				end
			end

			if enteringPipe then
				marioY = marioY + (1 * 6) * 48 * elapsed
				setProperty("marioOptions.y", math.floor(marioY / 6) * 6)

				if marioY > 88 * 6 and timerRunning == false then
					timerRunning = true
					runTimer("pipeEntered", 1, 1)
				end
			end

			if keyJustPressed("down") and not lastPressed and week == "funkMixDX" then
				pressesLeft = pressesLeft - 1
				if pressesLeft <= 4 then
					setProperty("marioOptions.animation.frameIndex", 1)
					setProperty("marioOptions.y", ogY)
					playSound(pipeSound)
					if pressesLeft <= 2 then
						setProperty("marioOptions.animation.frameIndex", 2)
						if pressesLeft <= 0 then
							setDataFromSave("songSaveData", "isStoryMode", false)
							setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Wrong Warp", songName})
							endSong()
						end
					end
				end
			end

			if subMenuLoaded == true then
				subMenuLoaded = false
			end
		else
			-- just uses my outdated code for the main menu state where I wanted to implement
			-- hold scrolling but I couldnt because I'm dumb and lazy
			if not lockedMovement then
				-- check for the current selection
				setTextString("curSelectedGlobal", curSelection)
				if keyJustPressed("up") then
					selectOption(curSelection - 1)
				end
				if keyJustPressed("down") then
					selectOption(curSelection + 1)
				end
				if keyJustPressed("accept") then
					getFromOption()
				end
				if settingTypePref[curSelection] == "selector" then
					if keyJustPressed("right") then
						updateSelector(1)
						playSound(menuSelectSound)
					elseif keyJustPressed("left") then
						updateSelector(-1)
						playSound(menuSelectSound)
					end
					if (keyPressed("left") or keyPressed("right")) and activeSubgroup[curSelection] ~= "Aspect Ratio:" and activeSubgroup[curSelection] ~= "Framerate Cap" and activeSubgroup[curSelection] ~= "Time Bar:" and activeSubgroup[curSelection] ~= "Pause Screen Song:" then
						holdTime = holdTime + elapsed
					end
					if holdTime > 0.5 then
						if holdTime > 0.55 and keyPressed("right") then
							updateSelector(1)
							holdTime = 0.5
						elseif holdTime > 0.55 and keyPressed("left") then
							updateSelector(-1)
							holdTime = 0.5
						end
					end
					if keyReleased("left") then
						setAttachmentColor("selectorLeft"..curSelection, 0xFFFFFF)
						holdTime = 0
					end
					if keyReleased("right") then
						setAttachmentColor("selectorRight"..curSelection, 0xFFFFFF)
						holdTime = 0
					end
				end
			end

			if subMenuLoaded == false then
				subMenuLoaded = true
				loadGroup()
			end

			if keyJustPressed("back") and tonumber(getTextString("subMenuGlobal")) > 0 then
				removeLuaText("settingInfo")

				removeLuaSprite("genieFrame", true)
				removeLuaSprite("genieThumbnail", true)
				removeLuaSprite("genieFlag", true)
				removeLuaSprite("genieRating", true)
				removeLuaText("genieScore")
			end
			
			if keyJustPressed("back") and getTextString("subMenuGlobal") == "1" then
				loadPipes()
				cancelTimer("flickerInt")
				cancelTimer("flickerDur")
			elseif keyJustPressed("back") and tonumber(getTextString("subMenuGlobal")) >= 2 then
				loadGroup()
				cancelTimer("flickerInt")
				cancelTimer("flickerDur")
			end

			pressesLeft = 8
			lastPressed = false
			easterEggTime = 123.695
			easterEggStop = -2
		end
		setTextString("canControlGlobal", not lockedMovement)
	else
		curPipe = 3
		selectPipe(0)
		marioY = 56 * 6
		setProperty("marioOptions.x", 42 * 6 - 2)
		setProperty("marioOptions.x", getProperty("marioOptions.x") + 56 * 6 * (curPipe - 1))
		if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
			setProperty("marioOptions.x", getProperty("marioOptions.x") - ((26 * 6) + 4))
		end
		setProperty("marioOptions.y", 56 * 6)
		enteringPipe = false
		timerRunning = false
		for i = 1,#pipes do 
			if i == curPipe then
				setProperty("pipeText"..i..".visible", false)
			else
				setProperty("pipeText"..i..".visible", true)
			end
			setProperty(grpPipes[i]..".visible", true)
		end

		pressesLeft = 8
		lastPressed = false
		easterEggTime = 123.695
		easterEggStop = -2
	end
	
	if getProperty("marioOptions.y") > getProperty("pipe1.y") then
		setProperty("marioOptions.y", getProperty("pipe1.y"))
	end
end

function returnSubgroup(groupName)
	for i = 1,#groupName do
		if groupName[i] ~= "" then
			makeLuaText("thisOption"..i, groupName[i], 0, 0, 0)
			setTextFont("thisOption"..i, "pixel_small.ttf")
			setTextBorder("thisOption"..i, 0, "000000")
			setTextSize("thisOption"..i, 5 * 6)
			setObjectCamera("thisOption"..i, "other")
			setObjectOrder("thisOption"..i, getObjectOrder("bgOptions2") + 1)

			screenCenter("thisOption"..i, "x")
			setProperty("thisOption"..i..".x", math.floor(getProperty("thisOption"..i..".x") / 6) * 6 + (1 * 6) + 1)
			setProperty("thisOption"..i..".y", getProperty("thisOption"..i..".y") + (8 * 6 * (i - 1)) + moveByY - 3)
			addLuaText("thisOption"..i)

			if settingTypePref[i] == "subgroup" then
				setTextFont("thisOption"..i, "smb1.ttf")
				setTextSize("thisOption"..i, 8 * 6)
				screenCenter("thisOption"..i, "x")
				setProperty("thisOption"..i..".x", math.floor(getProperty("thisOption"..i..".x") / 6) * 6 + (1 * 6) + 1)
				setProperty("thisOption"..i..".y", (12 * 6 * (i - 1)) + moveByY - 2)
			end
			if settingTypePref[i] == "trigger" and settingTypePref[i-1] == "subgroup" then
				setProperty("thisOption"..i..".y", getProperty("thisOption"..i..".y") + 17*6 + 1)
			end
		end
	end
end

function returnExtrasMap(alphabetGroup)
	for i = 1,#alphabetGroup do
		if getTextString(alphabetGroup[i]) ~= "" then
			if alphabetGroup[i] == "checkmark" then
				-- checkmark
				makeLuaSprite("checkmark"..i, "ui/"..optionsSkin.."checkboxThingie", 0, 0)
				makeLuaSprite("checkmarkFilled"..i, "ui/"..optionsSkin.."checkboxThingieFilled", 0, 0)
				setObjectCamera("checkmark"..i, "other")
				setObjectCamera("checkmarkFilled"..i, "other")
				setProperty("checkmark"..i..".x", getProperty("thisOption"..i..".x") - (7 * 6) + 2)
				setProperty("checkmarkFilled"..i..".x", getProperty("thisOption"..i..".x") - (7 * 6) + 2)
				setProperty("checkmark"..i..".y", getProperty("thisOption"..i..".y") + 2 + 1)
				setProperty("checkmarkFilled"..i..".y", getProperty("thisOption"..i..".y") + 2 + 1)
				scaleObject("checkmark"..i, 6, 6)
				scaleObject("checkmarkFilled"..i, 6, 6)
				setProperty("checkmark"..i..".antialiasing", false)
				setProperty("checkmarkFilled"..i..".antialiasing", false)
				addLuaSprite("checkmark"..i, false)
				addLuaSprite("checkmarkFilled"..i, false)
				setObjectOrder("checkmark"..i, getObjectOrder("bgOptions2") + 1)
				setObjectOrder("checkmarkFilled"..i, getObjectOrder("bgOptions2") + 1)
			elseif alphabetGroup[i] == "selector" then
				-- selector
				makeLuaText("chosenOptionString"..i, "", 0, 0, 0)
				setTextFont("chosenOptionString"..i, "pixel_small.ttf")
				setTextBorder("chosenOptionString"..i, 0, "000000")
				setTextSize("chosenOptionString"..i, 5 * 6)
				updateHitbox("chosenOptionString"..i)
				setObjectCamera("chosenOptionString"..i, "other")
				setObjectOrder("chosenOptionString"..i, getObjectOrder("bgOptions2") + 1)
				setProperty("chosenOptionString"..i..".x", getProperty("thisOption"..i..".x") + getProperty("thisOption"..i..".width") + (1 * 6) - 1)
				setProperty("chosenOptionString"..i..".y", getProperty("thisOption"..i..".y"))
				addLuaText("chosenOptionString"..i)

				makeLuaSprite("selectorLeft"..i, "ui/"..optionsSkin.."selectorLeft", 0, 0)
				makeLuaSprite("selectorRight"..i, "ui/"..optionsSkin.."selectorRight", 0, 0)
				setObjectCamera("selectorLeft"..i, "other")
				setObjectCamera("selectorRight"..i, "other")
				setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
				setProperty("selectorRight"..i..".x", getProperty("thisOption"..i..".x") + getProperty("thisOption"..i..".width") + (1 * 6) - 1)
				setProperty("selectorLeft"..i..".y", getProperty("thisOption"..i..".y") + 3)
				setProperty("selectorRight"..i..".y", getProperty("thisOption"..i..".y") + 3)
				scaleObject("selectorLeft"..i, 6, 6)
				scaleObject("selectorRight"..i, 6, 6)
				setProperty("selectorLeft"..i..".antialiasing", false)
				setProperty("selectorRight"..i..".antialiasing", false)
				addLuaSprite("selectorLeft"..i, false)
				addLuaSprite("selectorRight"..i, false)
				setObjectOrder("selectorLeft"..i, getObjectOrder("bgOptions2") + 1)
				setObjectOrder("selectorRight"..i, getObjectOrder("bgOptions2") + 1)
			elseif alphabetGroup[i] == "keybind" then
			end
		end
	end
end

-- This is the base option return
function getFromOption()
	if settingTypePref[curSelection] == "checkmark" or settingTypePref[curSelection] == "subgroup" or settingTypePref[curSelection] == "trigger" then
		if keyJustPressed("accept") then
			lockedMovement = true
			setTextString("canControlGlobal", not lockedMovement)
			flicker("thisOption"..curSelection, 0.5, 0.06 * 2, true)

			if settingTypePref[curSelection] == "checkmark" then
				playSound(selectSound)
				if activeSubgroup[curSelection] == "Power-Ups" then
					setDataFromSave("playerSettings", "powerUpHP", not getDataFromSave("playerSettings", "powerUpHP"))
				elseif activeSubgroup[curSelection] == "Quant Notes" then
					setDataFromSave("playerSettings", "quantNotes", not getDataFromSave("playerSettings", "quantNotes"))
				elseif activeSubgroup[curSelection] == "Funk Mix Camera" then
					setDataFromSave("playerSettings", "funkMixCam", not getDataFromSave("playerSettings", "funkMixCam"))
				elseif activeSubgroup[curSelection] == "Pause Menu Overhaul" then
					setDataFromSave("playerSettings", "pauseMenu", not getDataFromSave("playerSettings", "pauseMenu"))
				elseif activeSubgroup[curSelection] == "Show Border" then
					setDataFromSave("playerSettings", "showBorder", not getDataFromSave("playerSettings", "showBorder"))
					reloadSubgroup = true
					resetMenu()
				elseif activeSubgroup[curSelection] == "Showcase Camera" then
					setDataFromSave("playerSettings", "showcaseCam", not getDataFromSave("playerSettings", "showcaseCam"))
				elseif activeSubgroup[curSelection] == "Stage View" then
					setDataFromSave("playerSettings", "stageView", not getDataFromSave("playerSettings", "stageView"))
				elseif activeSubgroup[curSelection] == "Compatibility Mode" then
					setDataFromSave("playerSettings", "compatMode", not getDataFromSave("playerSettings", "compatMode"))
				elseif activeSubgroup[curSelection] == "BotPlay Cheat" then
					setDataFromSave("playerSettings", "botplayCheat", not getDataFromSave("playerSettings", "botplayCheat"))
				elseif activeSubgroup[curSelection] == "Debug Info" then
					setDataFromSave("playerSettings", "debugInfo", not getDataFromSave("playerSettings", "debugInfo"))
				elseif activeSubgroup[curSelection] == "Low Quality" then
					setPropertyFromClass("ClientPrefs", "lowQuality", not getPropertyFromClass("ClientPrefs", "lowQuality"))
				elseif activeSubgroup[curSelection] == "Anti-Aliasing" then
					setPropertyFromClass("ClientPrefs", "globalAntialiasing", not getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
				elseif activeSubgroup[curSelection] == "Shaders" then
					setPropertyFromClass("ClientPrefs", "shaders", not getPropertyFromClass("ClientPrefs", "shaders"))
				elseif activeSubgroup[curSelection] == "Note Splashes" then
					setPropertyFromClass("ClientPrefs", "noteSplashes", not getPropertyFromClass("ClientPrefs", "noteSplashes"))
				elseif activeSubgroup[curSelection] == "Hide Hud" then
					setPropertyFromClass("ClientPrefs", "hideHud", not getPropertyFromClass("ClientPrefs", "hideHud"))
				elseif activeSubgroup[curSelection] == "Flashing Lights" or activeSubgroup[curSelection] == "Photosensitivity" then
					setPropertyFromClass("ClientPrefs", "flashing", not getPropertyFromClass("ClientPrefs", "flashing"))
				elseif activeSubgroup[curSelection] == "Camera Zooms" then
					setPropertyFromClass("ClientPrefs", "camZooms", not getPropertyFromClass("ClientPrefs", "camZooms"))
				elseif activeSubgroup[curSelection] == "Score Text Zoom on Hit" then
					setPropertyFromClass("ClientPrefs", "scoreZoom", not getPropertyFromClass("ClientPrefs", "scoreZoom"))
				elseif activeSubgroup[curSelection] == "FPS Counter" then
					setPropertyFromClass("ClientPrefs", "showFPS", not getPropertyFromClass("ClientPrefs", "showFPS"))
					setPropertyFromClass("Main", "fpsVar.visible", getPropertyFromClass("ClientPrefs", "showFPS"))
				elseif activeSubgroup[curSelection] == "Check for Updates" then
					setPropertyFromClass("ClientPrefs", "checkForUpdates", not getPropertyFromClass("ClientPrefs", "checkForUpdates"))
				elseif activeSubgroup[curSelection] == "Combo Stacking" then
					setPropertyFromClass("ClientPrefs", "comboStacking", not getPropertyFromClass("ClientPrefs", "comboStacking"))
				elseif activeSubgroup[curSelection] == "Controller Mode" then
					setPropertyFromClass("ClientPrefs", "controllerMode", not getPropertyFromClass("ClientPrefs", "controllerMode"))
				elseif activeSubgroup[curSelection] == "Downscroll" then
					setPropertyFromClass("ClientPrefs", "downScroll", not getPropertyFromClass("ClientPrefs", "downScroll"))
				elseif activeSubgroup[curSelection] == "Centered Notefield" or activeSubgroup[curSelection] == "Middlescroll" then
					setPropertyFromClass("ClientPrefs", "middleScroll", not getPropertyFromClass("ClientPrefs", "middleScroll"))
				elseif activeSubgroup[curSelection] == "Opponent Notes" then
					setPropertyFromClass("ClientPrefs", "opponentStrums", not getPropertyFromClass("ClientPrefs", "opponentStrums"))
				elseif activeSubgroup[curSelection] == "Ghost Tapping" then
					setPropertyFromClass("ClientPrefs", "ghostTapping", not getPropertyFromClass("ClientPrefs", "ghostTapping"))
				elseif activeSubgroup[curSelection] == "Disable Reset Button" then
					setPropertyFromClass("ClientPrefs", "noReset", not getPropertyFromClass("ClientPrefs", "noReset"))
				elseif activeSubgroup[curSelection] == "Invincible" and getDataFromSave("gameGenie", "invincible") ~= "invincible" then
					setDataFromSave("gameGenie", "invincible", not getDataFromSave("gameGenie", "invincible"))
				end
			elseif settingTypePref[curSelection] == "subgroup" then
				playSound(selectSound)
			elseif settingTypePref[curSelection] == "trigger" then
				playSound(coinSound)
				if activeSubgroup[curSelection] == "Reset to Default Keys" then
					runHaxeCode("ClientPrefs.keyBinds = ClientPrefs.defaultKeys.copy();")
				end
			end
		end
	else
		if keyJustPressed("accept") then
			playSound(bumpSound)
		end
	end

	settingInfo()
	setTextString("subMenuGlobal", 2)

	flushSaveData("playerSettings")
	flushSaveData("gameGenie")
end

function updateCheckmark()
	for i = 1,#activeSubgroup do
		if activeSubgroup[i] == "Power-Ups" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "powerUpHP"))
		elseif activeSubgroup[i] == "Quant Notes" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "quantNotes"))
		elseif activeSubgroup[i] == "Funk Mix Camera" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "funkMixCam"))
		elseif activeSubgroup[i] == "Pause Menu Overhaul" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "pauseMenu"))
		elseif activeSubgroup[i] == "Show Border" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "showBorder"))
		elseif activeSubgroup[i] == "Showcase Camera" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "showcaseCam"))
		elseif activeSubgroup[i] == "Stage View" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "stageView"))
		elseif activeSubgroup[i] == "Compatibility Mode" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "compatMode"))
		elseif activeSubgroup[i] == "BotPlay Cheat" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "botplayCheat"))
		elseif activeSubgroup[i] == "Debug Info" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("playerSettings", "debugInfo"))
		elseif activeSubgroup[i] == "Low Quality" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "lowQuality"))
		elseif activeSubgroup[i] == "Anti-Aliasing" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
		elseif activeSubgroup[i] == "Shaders" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "shaders"))
		elseif activeSubgroup[i] == "Note Splashes" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "noteSplashes"))
		elseif activeSubgroup[i] == "Hide Hud" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "hideHud"))
		elseif activeSubgroup[i] == "Flashing Lights" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "flashing"))
		elseif activeSubgroup[i] == "Photosensitivity" then
			setProperty("checkmarkFilled"..i..".visible", not getPropertyFromClass("ClientPrefs", "flashing"))
		elseif activeSubgroup[i] == "Camera Zooms" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "camZooms"))
		elseif activeSubgroup[i] == "Score Text Zoom on Hit" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "scoreZoom"))
		elseif activeSubgroup[i] == "FPS Counter" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "showFPS"))
		elseif activeSubgroup[i] == "Check for Updates" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "checkForUpdates"))
		elseif activeSubgroup[i] == "Combo Stacking" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "comboStacking"))
		elseif activeSubgroup[i] == "Controller Mode" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "controllerMode"))
		elseif activeSubgroup[i] == "Downscroll" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "downScroll"))
		elseif activeSubgroup[i] == "Centered Notefield" or activeSubgroup[i] == "Middlescroll" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "middleScroll"))
		elseif activeSubgroup[i] == "Opponent Notes" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "opponentStrums"))
		elseif activeSubgroup[i] == "Ghost Tapping" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "ghostTapping"))
		elseif activeSubgroup[i] == "Disable Reset Button" then
			setProperty("checkmarkFilled"..i..".visible", getPropertyFromClass("ClientPrefs", "noReset"))
		elseif activeSubgroup[i] == "Invincible" and getDataFromSave("gameGenie", "invincible") ~= "invincible" then
			setProperty("checkmarkFilled"..i..".visible", getDataFromSave("gameGenie", "invincible"))
		end
	end
end

function updateTable()
	for i = 1,#activeSubgroup do		
		if activeSubgroup[i] == "Life Count:" then
			if getDataFromSave("playerSettings", "lifeStart") == 0 then
				setTextString("chosenOptionString"..i, "INF")
			else
				setTextString("chosenOptionString"..i, getDataFromSave("playerSettings", "lifeStart"))
			end
			local moveByX = 10 * 6
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Aspect Ratio:" then
			setTextString("chosenOptionString"..i, getDataFromSave("playerSettings", "aspectRatio"))
			local moveByX = 12 * 6
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Framerate Cap" then
			if getPropertyFromClass("ClientPrefs", "framerate") < 100 then
				setTextString("chosenOptionString"..i, "0"..getPropertyFromClass("ClientPrefs", "framerate"))
			else
				setTextString("chosenOptionString"..i, getPropertyFromClass("ClientPrefs", "framerate"))
			end
			local moveByX = 22 * 6
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Framerate:" then
			setTextString("chosenOptionString"..i, getPropertyFromClass("ClientPrefs", "framerate").." FPS")
			local moveByX = 22 * 6
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Time Bar:" then
			setTextString("chosenOptionString"..i, getPropertyFromClass("ClientPrefs", "timeBarType"))
			local moveByX = 24 * 6
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Health Bar Transparency" then
			setTextString("chosenOptionString"..i, (getPropertyFromClass("ClientPrefs", "healthBarAlpha") * 100).."%")
			local moveByX = 10 * 6
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Pause Screen Song:" then
			setTextString("chosenOptionString"..i, getPropertyFromClass("ClientPrefs", "pauseMusic"))
			local moveByX = 24 * 6
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Hitsound Volume" then
			setTextString("chosenOptionString"..i, (getPropertyFromClass("ClientPrefs", "hitsoundVolume") * 100).."%")
			local moveByX = 10 * 6 + 3
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Rating Offset" then
			setTextString("chosenOptionString"..i, getPropertyFromClass("ClientPrefs", "ratingOffset").."ms")
			local moveByX = 8 * 6 + 3
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Sick! Hit Window" then
			setTextString("chosenOptionString"..i, getPropertyFromClass("ClientPrefs", "sickWindow").."ms")
			local moveByX = 10 * 6 + 3
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Good Hit Window" then
			setTextString("chosenOptionString"..i, getPropertyFromClass("ClientPrefs", "goodWindow").."ms")
			local moveByX = 9 * 6 + 3
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Bad Hit Window" then
			setTextString("chosenOptionString"..i, getPropertyFromClass("ClientPrefs", "badWindow").."ms")
			local moveByX = 11 * 6 + 3
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		elseif activeSubgroup[i] == "Safe Frames" then
			setTextString("chosenOptionString"..i, getPropertyFromClass("ClientPrefs", "safeFrames").."ms")
			local moveByX = 10 * 6 + 3
			setProperty("thisOption"..i..".x", getProperty("thisOption"..i..".x") - moveByX)
			setProperty("selectorLeft"..i..".x", getProperty("thisOption"..i..".x") - (6 * 6) + 2)
			setProperty("chosenOptionString"..i..".x", getProperty("chosenOptionString"..i..".x") - moveByX)
			setProperty("selectorRight"..i..".x", getProperty("chosenOptionString"..i..".x") + getProperty("chosenOptionString"..i..".width") + 4)
		end
	end
end

function updateSelector(updateBy)
	-- bro I dont even know if the engine works in html5 why am I even doing this
	-- lazily hardcoded fps cap
	for i = 1,#ratioStrings do
		if getDataFromSave("playerSettings", "aspectRatio") == ratioStrings[i] then
			curSelectedRatio = i
		end
	end
	for i = 1,#timeBarStrings do
		if getPropertyFromClass("ClientPrefs", "timeBarType") == timeBarStrings[i] then
			curSelectedTimeBar = i
		end
	end
	for i = 1,#pauseSongStrings do
		if getPropertyFromClass("ClientPrefs", "pauseMusic") == pauseSongStrings[i] then
			curSelectedPauseSong = i
		end
	end

	curSelected = curSelected + updateBy
	curSelectedRatio = curSelectedRatio + updateBy
	curSelectedTimeBar = curSelectedTimeBar + updateBy
	curSelectedPauseSong = curSelectedPauseSong + updateBy
	if keyPressed("left") then
		setAttachmentColor("selectorLeft"..curSelection, selectColor)
	end
	if keyPressed("right") then
		setAttachmentColor("selectorRight"..curSelection, selectColor)
	end

	if activeSubgroup[curSelection] == "Life Count:" then
		local increase = 1 * updateBy
		if getDataFromSave("playerSettings", "lifeStart") + increase <= 0 then
			increase = 0
			setDataFromSave("playerSettings", "lifeStart", 0)
		elseif getDataFromSave("playerSettings", "lifeStart") + increase > 127 then
			increase = 0
			setDataFromSave("playerSettings", "lifeStart", 127)
		end
		setDataFromSave("playerSettings", "lifeStart", getDataFromSave("playerSettings", "lifeStart") + increase)
		if getDataFromSave("playerSettings", "lifeStart") == 0 then
			setTextString("chosenOptionString"..curSelection, "INF")
		else
			setTextString("chosenOptionString"..curSelection, getDataFromSave("playerSettings", "lifeStart"))
		end
	elseif activeSubgroup[curSelection] == "Aspect Ratio:" then
		if curSelectedRatio < 1 then
			curSelectedRatio = #ratioStrings
		elseif curSelectedRatio > #ratioStrings then
			curSelectedRatio = 1
		end
		setDataFromSave("playerSettings", "aspectRatio", ratioStrings[curSelectedRatio])
		setTextString("chosenOptionString"..curSelection, getDataFromSave("playerSettings", "aspectRatio"))
		reloadSubgroup = true
		resetMenu()
	elseif activeSubgroup[curSelection] == "Framerate Cap" then
		local increase = 15 * updateBy
		if getPropertyFromClass("ClientPrefs", "framerate") + increase < 60 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "framerate", 60)
		elseif getPropertyFromClass("ClientPrefs", "framerate") + increase > 240 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "framerate", 240)
		end
		setPropertyFromClass("ClientPrefs", "framerate", getPropertyFromClass("ClientPrefs", "framerate") + increase)
		if getPropertyFromClass("ClientPrefs", "framerate") < 100 then
			setTextString("chosenOptionString"..curSelection, "0"..getPropertyFromClass("ClientPrefs", "framerate"))
		else
			setTextString("chosenOptionString"..curSelection, getPropertyFromClass("ClientPrefs", "framerate"))
		end
	elseif activeSubgroup[curSelection] == "Framerate:" then
		local increase = 1 * updateBy
		if getPropertyFromClass("ClientPrefs", "framerate") + increase < 60 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "framerate", 60)
		elseif getPropertyFromClass("ClientPrefs", "framerate") + increase > 240 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "framerate", 240)
		end
		setPropertyFromClass("ClientPrefs", "framerate", getPropertyFromClass("ClientPrefs", "framerate") + increase)
		setTextString("chosenOptionString"..curSelection, getPropertyFromClass("ClientPrefs", "framerate").." FPS")
	elseif activeSubgroup[curSelection] == "Time Bar:" then
		if curSelectedTimeBar < 1 then
			curSelectedTimeBar = #timeBarStrings
		elseif curSelectedTimeBar > #timeBarStrings then
			curSelectedTimeBar = 1
		end
		setPropertyFromClass("ClientPrefs", "timeBarType", timeBarStrings[curSelectedTimeBar])
		setTextString("chosenOptionString"..curSelection, getPropertyFromClass("ClientPrefs", "timeBarType"))
	elseif activeSubgroup[curSelection] == "Health Bar Transparency" then
		local increase = 0.1 * updateBy
		if getPropertyFromClass("ClientPrefs", "healthBarAlpha") + increase <= 0.11 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "healthBarAlpha", 0.1)
		elseif getPropertyFromClass("ClientPrefs", "healthBarAlpha") + increase >= 0.99 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "healthBarAlpha", 1)
		end
		setPropertyFromClass("ClientPrefs", "healthBarAlpha", getPropertyFromClass("ClientPrefs", "healthBarAlpha") + increase)
		setTextString("chosenOptionString"..curSelection, (getPropertyFromClass("ClientPrefs", "healthBarAlpha") * 100).."%")
	elseif activeSubgroup[curSelection] == "Pause Screen Song:" then
		if curSelectedPauseSong < 1 then
			curSelectedPauseSong = #pauseSongStrings
		elseif curSelectedPauseSong > #pauseSongStrings then
			curSelectedPauseSong = 1
		end
		setPropertyFromClass("ClientPrefs", "pauseMusic", pauseSongStrings[curSelectedPauseSong])
		setTextString("chosenOptionString"..curSelection, getPropertyFromClass("ClientPrefs", "pauseMusic"))
	elseif activeSubgroup[curSelection] == "Hitsound Volume" then
		local increase = 0.1 * updateBy
		if getPropertyFromClass("ClientPrefs", "hitsoundVolume") + increase <= 0.01 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "hitsoundVolume", 0)
		elseif getPropertyFromClass("ClientPrefs", "hitsoundVolume") + increase >= 0.99 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "hitsoundVolume", 1)
		end
		setPropertyFromClass("ClientPrefs", "hitsoundVolume", getPropertyFromClass("ClientPrefs", "hitsoundVolume") + increase)
		setTextString("chosenOptionString"..curSelection, (getPropertyFromClass("ClientPrefs", "hitsoundVolume") * 100).."%")
	elseif activeSubgroup[curSelection] == "Rating Offset" then
		local increase = 1 * updateBy
		if getPropertyFromClass("ClientPrefs", "ratingOffset") + increase <= -30 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "ratingOffset", -30)
		elseif getPropertyFromClass("ClientPrefs", "ratingOffset") + increase >= 30 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "ratingOffset", 30)
		end
		setPropertyFromClass("ClientPrefs", "ratingOffset", getPropertyFromClass("ClientPrefs", "ratingOffset") + increase)
		setTextString("chosenOptionString"..curSelection, getPropertyFromClass("ClientPrefs", "ratingOffset").."ms")
	elseif activeSubgroup[curSelection] == "Sick! Hit Window" then
		local increase = 1 * updateBy
		if getPropertyFromClass("ClientPrefs", "sickWindow") + increase <= 15 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "sickWindow", 15)
		elseif getPropertyFromClass("ClientPrefs", "sickWindow") + increase >= 45 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "sickWindow", 45)
		end
		setPropertyFromClass("ClientPrefs", "sickWindow", getPropertyFromClass("ClientPrefs", "sickWindow") + increase)
		setTextString("chosenOptionString"..curSelection, getPropertyFromClass("ClientPrefs", "sickWindow").."ms")
	elseif activeSubgroup[curSelection] == "Good Hit Window" then
		local increase = 1 * updateBy
		if getPropertyFromClass("ClientPrefs", "goodWindow") + increase <= 15 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "goodWindow", 15)
		elseif getPropertyFromClass("ClientPrefs", "goodWindow") + increase >= 90 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "goodWindow", 90)
		end
		setPropertyFromClass("ClientPrefs", "goodWindow", getPropertyFromClass("ClientPrefs", "goodWindow") + increase)
		setTextString("chosenOptionString"..curSelection, getPropertyFromClass("ClientPrefs", "goodWindow").."ms")
	elseif activeSubgroup[curSelection] == "Bad Hit Window" then
		local increase = 1 * updateBy
		if getPropertyFromClass("ClientPrefs", "badWindow") + increase <= 15 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "badWindow", 15)
		elseif getPropertyFromClass("ClientPrefs", "badWindow") + increase >= 135 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "badWindow", 135)
		end
		setPropertyFromClass("ClientPrefs", "badWindow", getPropertyFromClass("ClientPrefs", "badWindow") + increase)
		setTextString("chosenOptionString"..curSelection, getPropertyFromClass("ClientPrefs", "badWindow").."ms")
	elseif activeSubgroup[curSelection] == "Safe Frames" then
		local increase = 0.1 * updateBy
		if getPropertyFromClass("ClientPrefs", "safeFrames") + increase < 2 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "safeFrames", 2)
		elseif getPropertyFromClass("ClientPrefs", "safeFrames") + increase > 10 then
			increase = 0
			setPropertyFromClass("ClientPrefs", "safeFrames", 10)
		end
		setPropertyFromClass("ClientPrefs", "safeFrames", getPropertyFromClass("ClientPrefs", "safeFrames") + increase)
		setTextString("chosenOptionString"..curSelection, getPropertyFromClass("ClientPrefs", "safeFrames").."ms")
	end
	setProperty("selectorRight"..curSelection..".x", getProperty("chosenOptionString"..curSelection..".x") + getProperty("chosenOptionString"..curSelection..".width") + 2)
end

function onUpdatePost()
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
		loadGraphic("bgOptions2", "menus/options/"..optionsSkin.."bg2")
		updateHitbox("bgOptions2")
		screenCenter("bgOptions2", "x")
	else
		loadGraphic("bgOptions2", "menus/options/"..optionsSkin.."bg2Wide")
		updateHitbox("bgOptions2")
		screenCenter("bgOptions2", "x")
	end

	if getTextString("curMenuGlobal") == "3" and getTextString("subMenuGlobal") == "0" then
		setProperty("settingInfo.visible", false)
		setProperty("marioOptions.visible", true)
		for i = 1,#pipes do
			setProperty("pipe"..i..".visible", true)
		end
	else
		setProperty("settingInfo.visible", true)
		setProperty("marioOptions.visible", false)
		for i = 1,#pipes do
			setProperty("pipe"..i..".visible", false)
		end
	end
end

function resetMenu()
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true and wideScreen ~= 0 then
		setProperty("bgOptions.x", getProperty("bgOptions.x") - wideScreen)
		setProperty("bgOptions2.x", getProperty("bgOptions2.x") - wideScreen)
		setProperty("warpText.x", getProperty("warpText.x") - wideScreen)

		if week == "funkMix" then
			setProperty("map.x", getProperty("map.x") - wideScreen)
			setProperty("infoText.x", getProperty("infoText.x") - wideScreen)
			for i = 1,4 do
				setProperty("songText"..i..".x", getProperty("songText"..i..".x") - wideScreen)
				setProperty("icon"..i..".x", getProperty("icon"..i..".x") - wideScreen)
			end

			setProperty("bgTitle.x", getProperty("bgTitle.x") - wideScreen)
			setProperty("logo.x", getProperty("logo.x") - wideScreen)
			setProperty("version.x", getProperty("version.x") - wideScreen)
			setProperty("selector.x", getProperty("selector.x") - wideScreen)
			for i = 1,3 do
				setProperty("optionTextA"..i..".x", getProperty("optionTextA"..i..".x") - wideScreen)
				setProperty("optionTextB"..i..".x", getProperty("optionTextB"..i..".x") - wideScreen)
			end
		end
		wideScreen = 0
	elseif (getDataFromSave("playerSettings", "aspectRatio") == "16:9" or (getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") == true)) and wideScreen ~= (26 * 6) + 4 then
		wideScreen = (26 * 6) + 4
		setProperty("bgOptions.x", getProperty("bgOptions.x") + wideScreen)
		setProperty("bgOptions2.x", getProperty("bgOptions2.x") + wideScreen)
		setProperty("warpText.x", getProperty("warpText.x") + wideScreen)

		if week == "funkMix" then
			setProperty("map.x", getProperty("map.x") + wideScreen)
			setProperty("infoText.x", getProperty("infoText.x") + wideScreen)
			for i = 1,4 do
				setProperty("songText"..i..".x", getProperty("songText"..i..".x") + wideScreen)
				setProperty("icon"..i..".x", getProperty("icon"..i..".x") + wideScreen)
			end

			setProperty("bgTitle.x", getProperty("bgTitle.x") + wideScreen)
			setProperty("logo.x", getProperty("logo.x") + wideScreen)
			setProperty("version.x", getProperty("version.x") + wideScreen)
			setProperty("selector.x", getProperty("selector.x") + wideScreen)
			for i = 1,3 do
				setProperty("optionTextA"..i..".x", getProperty("optionTextA"..i..".x") + wideScreen)
				setProperty("optionTextB"..i..".x", getProperty("optionTextB"..i..".x") + wideScreen)
			end
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
			else
				setProperty(object..".visible", false)
			end

			if getTextString("curMenuGlobal") == "3" then
				if settingTypePref[curSelection] == "subgroup" then
					curSelectionGroup = curSelection
					setTextString("subMenuGlobal", "2")
					if activeSubgroup[curSelection] == "Funk Mix" then
						settingTypePref = {"checkmark", "selector", "checkmark", "checkmark", "checkmark", "checkmark", "selector", "checkmark", "checkmark", "checkmark", "checkmark"}
						loadSubgroup(funkMix)
					elseif activeSubgroup[curSelection] == "Graphics" then
						if getDataFromSave("playerSettings", "compatMode") == false then
							settingTypePref = {"checkmark", "checkmark", "checkmark", "selector"}
						else
							settingTypePref = {"checkmark", "checkmark", "selector"}
						end
						loadSubgroup(graphics)
					elseif activeSubgroup[curSelection] == "Visuals and UI" then
						if getDataFromSave("playerSettings", "compatMode") == false then
							settingTypePref = {"checkmark", "checkmark", "selector", "checkmark", "checkmark", "checkmark", "selector", "checkmark", "selector", "checkmark", "checkmark"}
						else
							settingTypePref = {"checkmark", "checkmark", "selector", "checkmark", "checkmark", "checkmark", "selector", "checkmark", "selector", "checkmark"}
						end
						loadSubgroup(visualsAndUI)
					elseif activeSubgroup[curSelection] == "Gameplay" then
						settingTypePref = {"checkmark", "checkmark", "checkmark", "checkmark", "checkmark", "checkmark", "selector", "selector", "selector", "selector", "selector", "selector"}
						loadSubgroup(gameplay)
					end

					if activeSubgroup[curSelection] == "NOTES" then
						settingTypePref = {"keybind", "keybind", "keybind", "keybind"}
						loadSubgroup(notes)
					elseif activeSubgroup[curSelection] == "UI" then
						settingTypePref = {"keybind", "keybind", "keybind", "keybind", "", "keybind", "keybind", "keybind", "keybind",}
						loadSubgroup(ui)
					elseif activeSubgroup[curSelection] == "VOLUME" then
						settingTypePref = {"keybind", "keybind", "keybind"}
						loadSubgroup(volume)
					elseif activeSubgroup[curSelection] == "DEBUG" then
						settingTypePref = {"keybind", "keybind"}
						loadSubgroup(debug)
					end
				end
			end

			updateCheckmark()

			if settingTypePref[curSelection] ~= "song" then
				lockedMovement = false
				setTextString("canControlGlobal", not lockedMovement)
			end
		end
	end
end

function onTimerCompleted(tag)
	if tag == "workerMario" or tag == "switchOptions" then
		loadPipes()
	end
	if tag == "pipeEntered" then
		firstPipeEnter = true
		easterEggTime = -2
		if pipes[curPipe] == "exit" then
			if week == "funkMix" then
				setTextString("curMenuGlobal", 1)
				setTextString("inMenuGlobal", "MainMenu")
			end
		else
			loadGroup()
			if totaka then
				playMusic("optionsMenu", 0.55, true)
			end
		end
	end
end

function checkSetting(data)
	local savedSong = ""
	local songTitle = data:gsub("-", " ")
	local wordCount = songTitle:gsub("%S+","")
	local words = {}
	local i = 0

	for word in songTitle:gmatch("%w+") do
		i = i + 1
		words[i] = word:match("(%w+)")
		words[i] = words[i]:lower()
		if i ~= 1 then
			words[i] = words[i]:sub(1,1):upper()..words[i]:sub(2)
		end
		savedSong = savedSong..words[i]
	end
	return savedSong
end

function settingInfo()
	local info = ""

	if activeSubgroup[curSelection] == "Psych Pipe" then
		info = "If checked, gives the player access to all player controlled options in both\n\nPsych Engine and for the mod, and this text shows up."
	elseif activeSubgroup[curSelection] == "Power-Ups" then
		info = "If checked, instead of using the vanilla health system, your health is based\n\non the Funk Mix Power-Up System."
	elseif activeSubgroup[curSelection] == "Life Count:" then
		info = "Determines the amount of lives you start with. When you die on your last life,\n\nyou'll return back to the begining of the world. 1-Ups are auto-enabled."
	elseif activeSubgroup[curSelection] == "Quant Notes" then
		info = "If checked, the notes change color based on the current quant. I think that's\n\nhow it works. I don't know what a quant note even is."
	elseif activeSubgroup[curSelection] == "Funk Mix Camera" then
		info = "- Only used in Advance Stages -\n\nIf checked, the camera changes will apply to the Advance Stages as well."
	elseif activeSubgroup[curSelection] == "Pause Menu Overhaul" then
		info = "- Only used in Advance Stages -\n\nIf checked, the Funk Mix pause menu will appear in Advance Stages."
	elseif activeSubgroup[curSelection] == "Show Border" then
		info = "If unchecked, the window changes to fit the chosen aspect ratio. However,\n\nyou can't resize the window or play in fullscreen due to bugs."
	elseif activeSubgroup[curSelection] == "Aspect Ratio:" then
		info = "You can either play in 4:3 ratio like the original mod, or play in widescreen\n\nwith the 16:9 ratio."
	elseif activeSubgroup[curSelection] == "Showcase Camera" then
		info = "Removes the HUD camera and automatically turns on BotPlay."
	elseif activeSubgroup[curSelection] == "Stage View" then
		info = "- Only used in Advance Stages -\n\nSets the camera position and zoom to show the entire stage."
	elseif activeSubgroup[curSelection] == "Compatibility Mode" then
		info = "Toggle if you're using a version below Psych Engine 0.6.3."
	elseif activeSubgroup[curSelection] == "BotPlay Cheat" then
		info = "If checked, the game will still record the score when BotPlay or Practice\n\nMode is enabled."
	elseif activeSubgroup[curSelection] == "Debug Info" then
		info = "Just some debug text stuff for the Funk Mix menus, including the pause menu."
	end

	if activeSubgroup[curSelection] == "Low Quality" then
		info = "If checked, disables some background details, decreases loading times, and\n\nimproves performance."
	elseif activeSubgroup[curSelection] == "Anti-Aliasing" then
		info = "- This option doesn't affect the mod. -\n\nIf unchecked, disables anti-aliasing, increases performance at the cost of\n\nsharper visuals."
	elseif activeSubgroup[curSelection] == "Shaders" then
		info = "If unchecked, disables shaders. It's used for some visual effects, and also CPU\n\nintensive for weaker PCs."
	elseif activeSubgroup[curSelection] == "Framerate:" or activeSubgroup[curSelection] == "Framerate Cap" then
		info = "Pretty self explanatory, isn't it?"
	end

	if activeSubgroup[curSelection] == "Note Splashes" then
		info = "If unchecked, hitting \"Sick!\" notes won't show particles."
	elseif activeSubgroup[curSelection] == "Hide Hud" then
		info = "If checked, hides most HUD elements."
	elseif activeSubgroup[curSelection] == "Time Bar:" then
		info = "What should the Time Bar display?"
	elseif activeSubgroup[curSelection] == "Flashing Lights" then
		info = "Uncheck this if you're sensitive to flashing lights!"
	elseif activeSubgroup[curSelection] == "Photosensitivity" then
		info = "Check this if you're sensitive to flashing lights! Also, you're gonna turn into\n\na Goomba!"
	elseif activeSubgroup[curSelection] == "Camera Zooms" then
		info = "- This option doesn't affect the mod. -\n\nIf unchecked, the camera won't zoom in on a beat hit."
	elseif activeSubgroup[curSelection] == "Score Text Zoom on Hit" then
		info = "- This option doesn't affect the mod. -\n\nIf unchecked, disables the Score text zooming everytime you hit a note."
	elseif activeSubgroup[curSelection] == "Health Bar Transparency" then
		info = "How much transparent should the health bar and icons be."
	elseif activeSubgroup[curSelection] == "FPS Counter" then
		info = "If unchecked, hides FPS Counter."
	elseif activeSubgroup[curSelection] == "Pause Screen Song:" then
		info = "What song do you prefer for the Pause Screen?"
	elseif activeSubgroup[curSelection] == "Check for Updates" then
		info = "On Release builds, turn this on to check for updates when you start the game."
	elseif activeSubgroup[curSelection] == "Combo Stacking" then
		info = "If unchecked, Ratings and Combo won't stack, saving on System Memory and making\n\nthem easier to read"
	end

	if activeSubgroup[curSelection] == "Controller Mode" then
		info = "Check this if you want to play with a controller instead of using your\n\nKeyboard."
	elseif activeSubgroup[curSelection] == "Downscroll" then
		info = "If checked, notes go Down instead of Up, simple enough."
	elseif activeSubgroup[curSelection] == "Middlescroll" or activeSubgroup[curSelection] == "Centered Notefield" then
		info = "If checked, your notes get centered."
	elseif activeSubgroup[curSelection] == "Opponent Notes" then
		info = "If unchecked, opponent notes get hidden."
	elseif activeSubgroup[curSelection] == "Ghost Tapping" then
		info = "If checked, you won't get misses from pressing keys while there are no notes\n\nable to be hit."
	elseif activeSubgroup[curSelection] == "Disable Reset Button" then
		info = "If checked, pressing Reset won't do anything."
	elseif activeSubgroup[curSelection] == "Hitsound Volume" then
		info = "Funny notes does \"Tick!\" when you hit them."
	elseif activeSubgroup[curSelection] == "Rating Offset" then
		info = "Changes how late/early you have to hit for a \"Sick!\" Higher values mean you\n\nhave to hit later."
	elseif activeSubgroup[curSelection] == "Sick! Hit Window" then
		info = "Changes the amount of time you have for hitting a \"Sick!\" in milliseconds."
	elseif activeSubgroup[curSelection] == "Good Hit Window" then
		info = "Changes the amount of time you have for hitting a \"Good\" in milliseconds."
	elseif activeSubgroup[curSelection] == "Bad Hit Window" then
		info = "Changes the amount of time you have for hitting a \"Bad\" in milliseconds."
	elseif activeSubgroup[curSelection] == "Safe Frames" then
		info = "Changes how many frames you have for hitting a note earlier or late."
	end

	makeLuaText("settingInfo", info, screenWidth - (wideScreen*2), 0, 0)
	screenCenter("settingInfo", "x")
	setProperty("settingInfo.x", math.floor(getProperty("settingInfo.x") / 6) * 6)
	setProperty("settingInfo.y", screenHeight - getProperty("settingInfo.height") - (3 * 6) + 1)
	setTextFont("settingInfo", "pixel_smaller.ttf")
	setTextBorder("settingInfo", 0, "000000")
	setTextSize("settingInfo", 2.5 * 6)
	updateHitbox("settingInfo")
	setObjectCamera("settingInfo", "other")
	addLuaText("settingInfo")
end