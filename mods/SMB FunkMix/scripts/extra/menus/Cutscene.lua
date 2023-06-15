local wideScreen = (26 * 6) + 4
local ratioed = 160
local ratioed2 = 0
local runningTimer = false
local doUpdate = true
local endCutscene = false
local inEpilogue = false
local inCutscene = false

-- FrameData
local frameIndex = 0
local frameRates = {20, 20, 24, 20, 16, 20, 96, 96}

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

function split(s, delimiter)
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end

function getFrameIndexesExpanded(allData, toString)
	local totalDuration = 0
	local duration = split(getTextFromFile("images/cutscene/"..sceneNum.."/duration.txt"), "\n")
	for data = 1,getProperty(allData) do
		totalDuration = totalDuration + duration[data]
	end

	local i = 0
	local frames = {}
	local fps = frameRates[sceneNum + 1]
	local output = {frames, fps}
	for data = 1,getProperty(allData) do
		if sceneNum < 6 then
			local percentOfFullDuration = math.floor((duration[data] / totalDuration) * 100)
			for j = 0,percentOfFullDuration do
				frames[tablelength(frames)] = i
			end
			i = i + 1
		else
			for j = 1,math.floor(duration[data] / 12.5) do
				frames[tablelength(frames)] = i
			end
			i = i + 1
		end
	end
	if toString then
		local string = ""
		for i,v in pairs(frames) do
			if i == #frames then
				string = "" .. string .. "" .. v .. ""
			else
				string = "" .. string .. "" .. v .. ", "
			end
		end
		frames = string
	end
	return output
end

function onCreate()
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		ratioed = 0
		ratioed2 = 160
		wideScreen = 0
		fireballCenterX = 77
	end
	sceneNum = getDataFromSave("songSaveData", "sceneNum")
	if week == "cutscene" then
		sceneNum = difficulty
	end
	if sceneNum < 0 then
		sceneNum = 0
    elseif sceneNum > 7 then
		sceneNum = 7
    end
	if (songName == "Lethal Lava Lair" or songName == "Koopa Armada") and week ~= "funkMix" and week ~= "funkMixDX" then
		endCutscene = true
	end
	inCutscene = true
end

function onCreatePost()
	if songName == "Cutscene" then
		startCutscene()
	end
end

function startCutscene()
	makeLuaSprite("layer-1", nil, 0, 0)
	makeGraphic("layer-1", screenWidth, screenHeight, "000000")
	setObjectCamera("layer-1", "other")
	addLuaSprite("layer-1", false)

	makeLuaSprite("layer0", "cutscene/"..sceneNum.."/layer0", -ratioed2, 0)
	setObjectCamera("layer0", "other")
	addLuaSprite("layer0", false)

	if sceneNum == 7 then
		makeLuaSprite("cloudsScene", "backgrounds/airship/bg", 0, 16 * 6 - (81 * 6))
		setScrollFactor("cloudsScene", 1, 1)
		setProperty("cloudsScene.antialiasing", false)
		scaleObject("cloudsScene", 6, 6)
		setObjectCamera("cloudsScene", "other")
		addLuaSprite("cloudsScene", false)
	end

	makeAnimatedLuaSprite("layer1", "cutscene/"..sceneNum.."/layer1", ratioed, 0)
	local layer1FramesData = getFrameIndexesExpanded("layer1.numFrames", true)
	addAnimationByIndices("layer1", "cutscene", "anim", layer1FramesData[1], layer1FramesData[2])
	setProperty("layer1.antialiasing", false)
	scaleObject("layer1", 6, 6)
	setObjectCamera("layer1", "other")
	addLuaSprite("layer1", false)

	makeAnimatedLuaSprite("layer2", "cutscene/"..sceneNum.."/layer2", ratioed, 0)
	local layer2FramesData = getFrameIndexesExpanded("layer2.numFrames", true)
	addAnimationByIndices("layer2", "cutscene", "anim", layer2FramesData[1], layer2FramesData[2])
	setProperty("layer2.antialiasing", false)
	scaleObject("layer2", 6, 6)
	setObjectCamera("layer2", "other")
	addLuaSprite("layer2", false)

	if sceneNum == 2 then
		for i = 1,6 do
			makeAnimatedLuaSprite("fireballScene"..i, "backgrounds/castle/fireball", (fireballCenterX * 6), fireballCenterY - ((i - 1) * 8) * 6)
			addAnimationByPrefix("fireballScene"..i, "idle", "idle0", 18, true)
			setScrollFactor("fireballScene"..i, 1, 1)
			setProperty("fireballScene"..i..".antialiasing", false)
			scaleObject("fireballScene"..i, 6, 6)
			setObjectCamera("fireballScene"..i, "other")
			addLuaSprite("fireballScene"..i, false)
			fireballs[i] = "fireballScene"..i
		end
	end

	makeAnimatedLuaSprite("layer3", "cutscene/"..sceneNum.."/layer3", ratioed, 0)
	local layer3FramesData = getFrameIndexesExpanded("layer3.numFrames", true)
	addAnimationByIndices("layer3", "cutscene", "anim", layer3FramesData[1], layer3FramesData[2])
	setProperty("layer3.antialiasing", false)
	scaleObject("layer3", 6, 6)
	setObjectCamera("layer3", "other")
	addLuaSprite("layer3", false)

	if sceneNum > 5 then
		setObjectOrder("layer0", getObjectOrder("layer3") + 1)
	end

	playSound("cutscene/"..sceneNum.."/music", 0.5, "music")
	playSound("cutscene/"..sceneNum.."/sounds", 1, "sounds")
end

cloudsPos = wideScreen + 7

fireballs = {}
fireballCenterX = 77 + 27
fireballCenterY = 65
fireballAngle = 180

function onUpdate(elapsed)
	if doUpdate then
		if keyJustPressed("accept") or getProperty("layer2.animation.finished") then
			if not keyJustPressed("accept") and sceneNum == 5 and runningTimer == false then
				runningTimer = true
				runTimer("loadSong", 1)
			end
			if not keyJustPressed("accept") and sceneNum == 7 and runningTimer == false then
				runningTimer = true
				stopCutscene()
				runTimer("switchEpilogue", 1, 1)
			elseif runningTimer == false then
				if sceneNum == 6 then
					endCutscene = false
					endSong()
				elseif sceneNum == 7 then
					stopCutscene()
					addLuaScript("scripts/extra/menus/funkMixDX/Epilogue")
					inEpilogue = true
				else
					startSong()
				end
			end
		end

		if sceneNum == 2 then
			fireballAngle = fireballAngle - elapsed * 75
			if fireballAngle < 0 then
				fireballAngle = 360
			end
			local i = 0
			angleRadians = math.floor(-fireballAngle / 7.5) * 7.5 * math.pi/180
			for fireball = 1,#fireballs do
				setProperty(fireballs[fireball]..".x", fireballCenterX * 6)
				setProperty(fireballs[fireball]..".y", fireballCenterY * 6)

				setProperty(fireballs[fireball]..".x", getProperty(fireballs[fireball]..".x") + math.cos(angleRadians) * i * 8 * 6)
				setProperty(fireballs[fireball]..".y", getProperty(fireballs[fireball]..".y") + math.sin(angleRadians) * i * 8 * 6)

				setProperty(fireballs[fireball]..".x", math.floor(getProperty(fireballs[fireball]..".x") / 6) * 6 - 2)
				setProperty(fireballs[fireball]..".y", math.floor(getProperty(fireballs[fireball]..".y") / 6) * 6)
				i = i + 1
			end
		end

		if sceneNum == 7 then
			cloudsPos = cloudsPos - 96 * elapsed
			if cloudsPos + getProperty("cloudsScene.width") <= 0 then
				cloudsPos = 0
			end
			setProperty("cloudsScene.x", math.floor(cloudsPos / 6) * 6 - 2)
			setProperty("cloudsScene2.x", getProperty("cloudsScene.x") + getProperty("cloudsScene.width"))
		end
	else
		if getProperty("layer2.animation.frameIndex") == 0 then
			doUpdate = true
		end
	end
end

function onUpdatePost()
	if keyJustPressed("back") and week == "cutscene" then
		stopSound("music")
		stopSound("sounds")
		exitSong(false)
	end
	if inEpilogue and keyJustPressed("accept") then
		endCutscene = false
	end
end

function onTimerCompleted(tag)
	if tag == "loadSong" then
		startSong()
	elseif tag == "switchEpilogue" then
		inEpilogue = true
		addLuaScript("scripts/extra/menus/funkMixDX/Epilogue")
		endCutscene = false
	end
end

function startSong()
	if week == "cutscene" then
		restartSong(true)
	elseif songName == "Cutscene" then
		endSong()
	else
		doUpdate = false
		stopCutscene()
		startCountdown()
		setProperty("layer-1.exists", false)
		setPropertyFromClass("PlayState", "seenCutscene", true) 
	end
end

function onStartCountdown()
	if inCutscene then
		return Function_Stop
	end
	return Function_Continue
end

function stopCutscene()
	inCutscene = false
	stopSound("music")
	stopSound("sounds")

	setProperty("layer0.exists", false)
	setProperty("layer1.exists", false)
	setProperty("layer2.exists", false)
	setProperty("layer3.exists", false)

	if sceneNum == 2 then
		for i = 1,6 do
			setProperty("fireballScene"..i..".exists", false)
		end
	elseif sceneNum == 7 then
		setProperty("cloudsScene.exists", false)
	end
end

function onEndSong()
	if week == "cutscene" then
		restartSong(true)
		return Function_Stop
	elseif isStoryMode and week ~= "funkMix" and week ~= "funkMixDX" and endCutscene then
		if not inEpilogue then
			if songName == "Lethal Lava Lair" then
				sceneNum = 6
				startCutscene()
			elseif songName == "Koopa Armada" then
				sceneNum = 7
				startCutscene()
			end
		end
		return Function_Stop
	else
		stopSound("music")
		stopSound("sounds")
		return Function_Continue
	end
end