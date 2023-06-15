isChase = false

-- jumped1 = false
-- jumped2 = false

jumpedBrick = false
jumpedGap1 = false
jumpedGap2 = false
jumpedPipe = false

jumpedGapB = false
jumpedGapB2 = false
jumpedStairs = false
jumpedStairs2 = false
jumpedGap3 = false
jumpedGap3M = false
jumpedGap4M = false
jumpedGap4 = false
jumpTriggers = {}

bfIsJumping = false
dadIsJumping = false

chaseBGPos = -2128 * 6 - 1*6

mxLegsHighY = 0
mxLegsDefY = 0
bfLegsHighY = 0
bfLegsDefY = 0

breakableObjects = {}
legsPrefix = ""
skinSuffix = ""
pipeEnd = false

bfLegsPrefix = ""
legsSuffix = ""

impact = true

function funkMixCam()
	return week == "funkMixMX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")
	precacheImage("backgrounds/pcport/popup")
	precacheImage("backgrounds/pcport/luigi")

	if week == "funkMixMX" then
		skinSuffix = "-old"
		chaseBGPos = -960 * 6 + 2*6
	end

	jumpTriggers[1] = jumpedBrick
	jumpTriggers[2] = jumpedGap1
	jumpTriggers[3] = jumpedGap2
	jumpTriggers[4] = jumpedPipe
	jumpTriggers[5] = jumpedGapB
	jumpTriggers[6] = jumpedGapB2
	jumpTriggers[7] = jumpedStairs
	jumpTriggers[8] = jumpedGap3
	jumpTriggers[9] = jumpedGap3M
	jumpTriggers[10] = jumpedStairs2
	jumpTriggers[11] = jumpedGap4
	jumpTriggers[12] = jumpedGap4M

	if flashingLights then
		moveMult = 1
		jumpMult = 1
	else
		moveMult = 0.5
		jumpMult = 2
	end

	makeLuaSprite("blackScreen", nil, -screenWidth*2, -screenHeight*2)
	makeGraphic("blackScreen", screenWidth * 4, screenHeight * 4, "000000")
	setProperty("blackScreen.visible", false)
	screenCenter("blackScreen")
	addLuaSprite("blackScreen", true)

	if week ~= "funkMixMX" then
		makeLuaSprite("redScreen", nil, -screenWidth*2, -screenHeight*2)
		makeGraphic("redScreen", screenWidth * 4, screenHeight * 4, "7F0000")
		setProperty("redScreen.visible", false)
		screenCenter("redScreen")
		addLuaSprite("redScreen", false)
	end

	makeLuaSprite("bg", "backgrounds/pcport/goal"..skinSuffix, -180 * 3 + 10*6, -81 * 3 + 3)
	setProperty("bg.antialiasing", false)
	scaleObject("bg", 6, 6)
	addLuaSprite("bg", false)

	if week ~= "funkMixMX" then
		makeAnimatedLuaSprite("bgFake", "backgrounds/pcport/goalFake", -180 * 3 + 10*6, -81 * 3 + 3)
		addAnimationByIndices("bgFake", "idle", "idle", "0", 12)
		addAnimationByIndices("bgFake", "trans", "idle", "1, 2, 3", 12)
		setProperty("bgFake.antialiasing", false)
		scaleObject("bgFake", 6, 6)
		addLuaSprite("bgFake", false)
	end

	makeLuaSprite("luigi", "backgrounds/pcport/luigi", 25, -125)
	setProperty("luigi.antialiasing", false)
	scaleObject("luigi", 6, 6)
	setObjectCamera("luigi", "camHUD")
	setProperty("luigi.visible", false)
	addLuaSprite("luigi", true)

	makeAnimatedLuaSprite("popup", "backgrounds/pcport/popup", 0, 85)
	addAnimationByIndices("popup", "innocence", "anim", "0", 60)
	addAnimationByIndices("popup", "doesnt", "anim", "1", 60)
	addAnimationByIndices("popup", "get", "anim", "2", 60)
	addAnimationByIndices("popup", "you", "anim", "3", 60)
	addAnimationByIndices("popup", "far", "anim", "4", 60)
	setProperty("popup.antialiasing", false)
	setObjectCamera("popup", "camHUD")
	scaleObject("popup", 6, 6)
	setProperty("popup.visible", false)
	addLuaSprite("popup", true)

	makeAnimatedLuaSprite('select', 'backgrounds/pcport/level select', -25, -100)
	addAnimationByPrefix('select', 'blank', 'Blank', 25, false)
	addAnimationByPrefix('select', 'get', 'GET', 25, false)
	addAnimationByPrefix('select', 'back', 'BACK', 25, false)
	addAnimationByPrefix('select', 'here', 'HERE.', 15, false)
	setProperty('select.antialiasing', false)
	scaleObject('select', 4, 4)
	addLuaSprite('select')
	setProperty('select.visible', false)
	objectPlayAnimation('select', 'blank')
	setObjectCamera('select', 'hud')
		
	makeLuaSprite('wahoo', 'backgrounds/pcport/wahoo', -15, 130)
	setProperty('wahoo.antialiasing', false)
	addLuaSprite('wahoo')
	setProperty('wahoo.visible', false)
	setObjectCamera('wahoo', 'hud')

	if getDataFromSave("playerSettings", "aspectRatio") == "16:9" then
		scaleObject("popup", 8, 8)
		setProperty('popup.x', 0)
		setProperty('popup.y', 55)
		setProperty('luigi.x', 150)
		setProperty('luigi.y', -125)
		scaleObject('select', 5, 5)
		setProperty('select.x', 2)
		setProperty('select.y', -155)
		setProperty('wahoo.x', 138)
		setProperty('wahoo.y', 130)
	end


	
	if not lowQuality then
		makeLuaSprite("chaseBG", "backgrounds/pcport/loop"..skinSuffix, chaseBGPos, -81 * 3 + 3)
		setProperty("chaseBG.antialiasing", false)
		scaleObject("chaseBG", 6, 6)
		setProperty("chaseBG.visible", false)
		addLuaSprite("chaseBG")

		makeLuaSprite("emptyBG", "backgrounds/pcport/empty"..skinSuffix, chaseBGPos, -81 * 3 + 3)
		setProperty("emptyBG.antialiasing", false)
		scaleObject("emptyBG", 6, 6)
		setProperty("emptyBG.visible", false)
		addLuaSprite("emptyBG")
		setObjectOrder("emptyBG", getObjectOrder("chaseBG") + 1)

		makeLuaSprite("chaseBG2", "backgrounds/pcport/loop"..skinSuffix, getProperty("chaseBG.x") + getProperty("chaseBG.width") - 160*6 - 1*6, -81 * 3 + 3)
		setProperty("chaseBG2.antialiasing", false)
		scaleObject("chaseBG2", 6, 6)
		setProperty("chaseBG2.visible", false)
		addLuaSprite("chaseBG2", false)
		setObjectOrder("chaseBG2", getObjectOrder("chaseBG") + 1)

		makeLuaSprite("chaseBG3", "backgrounds/pcport/saved"..skinSuffix, getProperty("chaseBG.x") - getProperty("chaseBG.width") + 160*6 - 1*6, -81 * 3 + 3)
		setProperty("chaseBG3.antialiasing", false)
		scaleObject("chaseBG3", 6, 6)
		setProperty("chaseBG3.visible", false)
		addLuaSprite("chaseBG3")
		setObjectOrder("chaseBG3", getObjectOrder("chaseBG") - 1)

		makeLuaSprite("emptyBG2", "backgrounds/pcport/empty"..skinSuffix, getProperty("chaseBG.x") - getProperty("chaseBG.width") + 160*6 - 1*6, -81 * 3 + 3)
		setProperty("emptyBG2.antialiasing", false)
		scaleObject("emptyBG2", 6, 6)
		setProperty("emptyBG2.visible", false)
		addLuaSprite("emptyBG2")
		setObjectOrder("emptyBG2", getObjectOrder("chaseBG3") + 1)
	else
		makeLuaSprite("chaseBG", "backgrounds/pcport/loopLQ"..skinSuffix, chaseBGPos + 6, -5 * 6)
		setProperty("chaseBG.antialiasing", false)
		scaleObject("chaseBG", 6, 6)
		setProperty("chaseBG.visible", false)
		addLuaSprite("chaseBG")
	end

	if not lowQuality then
		if week == "funkMixMX" then
			-- OBJECTS MAKING
			makeAnimatedLuaSprite("pipe2", "backgrounds/pcport/pipe", 0, -16 * 6)
			addAnimationByPrefix("pipe2", "idle", "idle", 15)
			addAnimationByPrefix("pipe2", "break", "idle", 20, false)
			setProperty("pipe2.antialiasing", false)
			scaleObject("pipe2", 6, 6)
			setProperty("pipe2.visible", false)
			breakableObjects[1] = getProperty("pipe2")

			makeAnimatedLuaSprite("solidbrick1", "backgrounds/pcport/bricksolid", 0, 33 * 6)
			addAnimationByIndices("solidbrick1", "idle", "idle", "0", 15)
			addAnimationByIndices("solidbrick1", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10", 20)
			setProperty("solidbrick1.antialiasing", false)
			scaleObject("solidbrick1", 6, 6)
			setProperty("solidbrick1.visible", false)
			breakableObjects[2] = getProperty("solidbrick1")
				
			makeAnimatedLuaSprite("solidbrick2", "backgrounds/pcport/bricksolid", 0, 33 * 6)
			addAnimationByIndices("solidbrick2", "idle", "idle", "0", 15)
			addAnimationByIndices("solidbrick2", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10", 20)
			setProperty("solidbrick2.antialiasing", false)
			scaleObject("solidbrick2", 6, 6)
			setProperty("solidbrick2.visible", false)
			breakableObjects[3] = getProperty("solidbrick2")

			makeAnimatedLuaSprite("solidbrick3", "backgrounds/pcport/bricksolid", 0, 17 * 6)
			addAnimationByIndices("solidbrick3", "idle", "idle", "0", 15)
			addAnimationByIndices("solidbrick3", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10", 20)
			setProperty("solidbrick3.antialiasing", false)
			scaleObject("solidbrick3", 6, 6)
			setProperty("solidbrick3.visible", false)
			breakableObjects[4] = getProperty("solidbrick3")

			makeAnimatedLuaSprite("solidbrick4", "backgrounds/pcport/bricksolid", 0, 33 * 6)
			addAnimationByIndices("solidbrick4", "idle", "idle", "0", 15)
			addAnimationByIndices("solidbrick4", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10", 20)
			setProperty("solidbrick4.antialiasing", false)
			scaleObject("solidbrick4", 6, 6)
			setProperty("solidbrick4.visible", false)
			breakableObjects[5] = getProperty("solidbrick4")

			makeAnimatedLuaSprite("solidbrick5", "backgrounds/pcport/bricksolid", 0, 33 * 6)
			addAnimationByIndices("solidbrick5", "idle", "idle", "0", 15)
			addAnimationByIndices("solidbrick5", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10", 20)
			setProperty("solidbrick5.antialiasing", false)
			scaleObject("solidbrick5", 6, 6)
			setProperty("solidbrick5.visible", false)
			breakableObjects[6] = getProperty("solidbrick5")

			makeAnimatedLuaSprite("solidbrick6", "backgrounds/pcport/bricksolid", 0, 17 * 6)
			addAnimationByIndices("solidbrick6", "idle", "idle", "0", 15)
			addAnimationByIndices("solidbrick6", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10", 20)
			setProperty("solidbrick6.antialiasing", false)
			scaleObject("solidbrick6", 6, 6)
			setProperty("solidbrick6.visible", false)
			breakableObjects[7] = getProperty("solidbrick6")

			makeAnimatedLuaSprite("emptyblock1", "backgrounds/pcport/emptybrick", 0, -16 * 6)
			addAnimationByIndices("emptyblock1", "idle", "idle", "0", 15)
			addAnimationByIndices("emptyblock1", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10", 20)
			setProperty("emptyblock1.antialiasing", false)
			scaleObject("emptyblock1", 6, 6)
			setProperty("emptyblock1.visible", false)
			breakableObjects[8] = getProperty("emptyblock1")

			makeAnimatedLuaSprite("emptyblock2", "backgrounds/pcport/emptybrick", 0, -16 * 6)
			addAnimationByIndices("emptyblock2", "idle", "idle", "0", 15)
			addAnimationByIndices("emptyblock2", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10", 20)
			setProperty("emptyblock2.antialiasing", false)
			scaleObject("emptyblock2", 6, 6)
			setProperty("emptyblock2.visible", false)
			breakableObjects[9] = getProperty("emptyblock2")

			makeAnimatedLuaSprite("emptyblock3", "backgrounds/pcport/emptybrick", 0, -16 * 6)
			addAnimationByIndices("emptyblock3", "idle", "idle", "0", 15)
			addAnimationByIndices("emptyblock3", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10", 20)
			setProperty("emptyblock3.antialiasing", false)
			scaleObject("emptyblock3", 6, 6)
			setProperty("emptyblock3.visible", false)
			breakableObjects[10] = getProperty("emptyblock3")

			makeAnimatedLuaSprite("pipe3", "backgrounds/pcport/pipe", 0, -16 * 6)
			addAnimationByIndices("pipe3", "idle", "idle", "0", 15)
			addAnimationByIndices("pipepipe32", "break", "idle", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11", 20)
			setProperty("pipe3.antialiasing", false)
			scaleObject("pipe3", 6, 6)
			setProperty("pipe3.visible", false)
			breakableObjects[11] = getProperty("pipe2")
			-- OBJECTS END

			for i,object in pairs(breakableObjects) do
				addLuaSprite(object)
			end
		else
			-- OBJECTS MAKING
			makeAnimatedLuaSprite("pipe1", "backgrounds/pcport/pipe", 0, -16*6)
			addAnimationByIndices("pipe1", "idle", "idle", "0", 9)
			addAnimationByPrefix("pipe1", "break", "idle", 24, false)
			setProperty("pipe1.antialiasing", false)
			scaleObject("pipe1", 6, 6)
			addLuaSprite("pipe1")
			setProperty("pipe1.visible", false)
			
			breakableObjects[1] = getProperty("pipe1")
			
			makeAnimatedLuaSprite("pipe2", "backgrounds/pcport/pipe", 0, -16*6)
			addAnimationByIndices("pipe2", "idle", "idle", "0", 9)
			addAnimationByPrefix("pipe2", "break", "idle", 24, false)
			setProperty("pipe2.antialiasing", false)
			scaleObject("pipe2", 6, 6)
			addLuaSprite("pipe2")
			setProperty("pipe2.visible", false)
			
			breakableObjects[12] = getProperty("pipe2")
			
			makeAnimatedLuaSprite("solidB1", "backgrounds/pcport/bricksolid", 0, 33*6)
			addAnimationByIndices("solidB1", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB1", "break", "idle", 24, false)
			setProperty("solidB1.antialiasing", false)
			scaleObject("solidB1", 6, 6)
			addLuaSprite("solidB1")
			setProperty("solidB1.visible", false)
			
			breakableObjects[2] = getProperty("solidB1")
			
			makeAnimatedLuaSprite("solidB2", "backgrounds/pcport/bricksolid", 0, 33*6)
			addAnimationByIndices("solidB2", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB2", "break", "idle", 24, false)
			setProperty("solidB2.antialiasing", false)
			scaleObject("solidB2", 6, 6)
			addLuaSprite("solidB2")
			setProperty("solidB2.visible", false)
			
			breakableObjects[3] = getProperty("solidB2")
			
			makeAnimatedLuaSprite("solidB3", "backgrounds/pcport/bricksolid", 0, 17*6)
			addAnimationByIndices("solidB3", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB3", "break", "idle", 24, false)
			setProperty("solidB3.antialiasing", false)
			scaleObject("solidB3", 6, 6)
			addLuaSprite("solidB3")
			setProperty("solidB3.visible", false)
			
			breakableObjects[4] = getProperty("solidB3")
			
			makeAnimatedLuaSprite("solidB4", "backgrounds/pcport/bricksolid", 0, 33*6)
			addAnimationByIndices("solidB4", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB4", "break", "idle", 24, false)
			setProperty("solidB4.antialiasing", false)
			scaleObject("solidB4", 6, 6)
			addLuaSprite("solidB4")
			setProperty("solidB4.visible", false)
			
			breakableObjects[5] = getProperty("solidB4")
			
			makeAnimatedLuaSprite("solidB5", "backgrounds/pcport/bricksolid", 0, 33*6)
			addAnimationByIndices("solidB5", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB5", "break", "idle", 24, false)
			setProperty("solidB5.antialiasing", false)
			scaleObject("solidB5", 6, 6)
			addLuaSprite("solidB5")
			setProperty("solidB5.visible", false)
			
			breakableObjects[6] = getProperty("solidB5")
			
			makeAnimatedLuaSprite("solidB6", "backgrounds/pcport/bricksolid", 0, 17*6)
			addAnimationByIndices("solidB6", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB6", "break", "idle", 24, false)
			setProperty("solidB6.antialiasing", false)
			scaleObject("solidB6", 6, 6)
			addLuaSprite("solidB6")
			setProperty("solidB6.visible", false)
			
			breakableObjects[7] = getProperty("solidB6")
			
			makeAnimatedLuaSprite("emptyB1", "backgrounds/pcport/emptybrick", 0, -20*6+30)
			addAnimationByIndices("emptyB1", "idle", "idle", "0", 9)
			addAnimationByPrefix("emptyB1", "break", "idle", 24, false)
			setProperty("emptyB1.antialiasing", false)
			scaleObject("emptyB1", 6, 6)
			addLuaSprite("emptyB1")
			setProperty("emptyB1.visible", false)
			
			breakableObjects[8] = getProperty("emptyB1")
			
			makeAnimatedLuaSprite("emptyB2", "backgrounds/pcport/emptybrick", 0, -20*6+30)
			addAnimationByIndices("emptyB2", "idle", "idle", "0", 9)
			addAnimationByPrefix("emptyB2", "break", "idle", 24, false)
			setProperty("emptyB2.antialiasing", false)
			scaleObject("emptyB2", 6, 6)
			addLuaSprite("emptyB2")
			setProperty("emptyB2.visible", false)
			
			breakableObjects[9] = getProperty("emptyB2")
			
			makeAnimatedLuaSprite("emptyB3", "backgrounds/pcport/emptybrick", 0, -20*6+30)
			addAnimationByIndices("emptyB3", "idle", "idle", "0", 9)
			addAnimationByPrefix("emptyB3", "break", "idle", 24, false)
			setProperty("emptyB3.antialiasing", false)
			scaleObject("emptyB3", 6, 6)
			addLuaSprite("emptyB3")
			setProperty("emptyB3.visible", false)
			
			breakableObjects[10] = getProperty("emptyB3")
			
			makeAnimatedLuaSprite("emptyB4", "backgrounds/pcport/emptybrick", 0, -16*6+6)
			addAnimationByIndices("emptyB4", "idle", "idle", "0", 9)
			addAnimationByPrefix("emptyB4", "break", "idle", 24, false)
			setProperty("emptyB4.antialiasing", false)
			scaleObject("emptyB4", 6, 6)
			addLuaSprite("emptyB4")
			setProperty("emptyB4.visible", false)
			
			breakableObjects[11] = getProperty("emptyB4")
			
			makeAnimatedLuaSprite("emptyB5", "backgrounds/pcport/emptybrick", 0, -20*6+30)
			addAnimationByIndices("emptyB5", "idle", "idle", "0", 9)
			addAnimationByPrefix("emptyB5", "break", "idle", 24, false)
			setProperty("emptyB5.antialiasing", false)
			scaleObject("emptyB5", 6, 6)
			addLuaSprite("emptyB5")
			setProperty("emptyB5.visible", false)
			
			breakableObjects[13] = getProperty("emptyB5")
			
			makeAnimatedLuaSprite("emptyB6", "backgrounds/pcport/emptybrick", 0, -20*6+30)
			addAnimationByIndices("emptyB6", "idle", "idle", "0", 9)
			addAnimationByPrefix("emptyB6", "break", "idle", 24, false)
			setProperty("emptyB6.antialiasing", false)
			scaleObject("emptyB6", 6, 6)
			addLuaSprite("emptyB6")
			setProperty("emptyB6.visible", false)
			
			breakableObjects[14] = getProperty("emptyB6")
			
			makeAnimatedLuaSprite("emptyB7", "backgrounds/pcport/emptybrick", 0, -20*6+30)
			addAnimationByIndices("emptyB7", "idle", "idle", "0", 9)
			addAnimationByPrefix("emptyB7", "break", "idle", 24, false)
			setProperty("emptyB7.antialiasing", false)
			scaleObject("emptyB7", 6, 6)
			addLuaSprite("emptyB7")
			setProperty("emptyB7.visible", false)
			
			breakableObjects[15] = getProperty("emptyB7")
			
			makeAnimatedLuaSprite("solidB7", "backgrounds/pcport/bricksolid", 0, 33*6)
			addAnimationByIndices("solidB7", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB7", "break", "idle", 24, false)
			setProperty("solidB7.antialiasing", false)
			scaleObject("solidB7", 6, 6)
			addLuaSprite("solidB7")
			setProperty("solidB7.visible", false)
			
			breakableObjects[16] = getProperty("solidB7")
			
			makeAnimatedLuaSprite("solidB8", "backgrounds/pcport/bricksolid", 0, 33*6)
			addAnimationByIndices("solidB8", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB8", "break", "idle", 24, false)
			setProperty("solidB8.antialiasing", false)
			scaleObject("solidB8", 6, 6)
			addLuaSprite("solidB8")
			setProperty("solidB8.visible", false)
			
			breakableObjects[17] = getProperty("solidB8")
			
			makeAnimatedLuaSprite("solidB9", "backgrounds/pcport/bricksolid", 0, 17*6)
			addAnimationByIndices("solidB9", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB9", "break", "idle", 24, false)
			setProperty("solidB9.antialiasing", false)
			scaleObject("solidB9", 6, 6)
			addLuaSprite("solidB9")
			setProperty("solidB9.visible", false)
			
			breakableObjects[18] = getProperty("solidB9")
			
			makeAnimatedLuaSprite("solidB10", "backgrounds/pcport/bricksolid", 0, 17*6)
			addAnimationByIndices("solidB10", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB10", "break", "idle", 24, false)
			setProperty("solidB10.antialiasing", false)
			scaleObject("solidB10", 6, 6)
			addLuaSprite("solidB10")
			setProperty("solidB10.visible", false)
			
			breakableObjects[19] = getProperty("solidB10")
			
			makeAnimatedLuaSprite("solidB11", "backgrounds/pcport/bricksolid", 0, 33*6)
			addAnimationByIndices("solidB11", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB11", "break", "idle", 24, false)
			setProperty("solidB11.antialiasing", false)
			scaleObject("solidB11", 6, 6)
			addLuaSprite("solidB11")
			setProperty("solidB11.visible", false)
			
			breakableObjects[20] = getProperty("solidB11")
			
			makeAnimatedLuaSprite("solidB12", "backgrounds/pcport/bricksolid", 0, 33*6)
			addAnimationByIndices("solidB12", "idle", "idle", "0", 9)
			addAnimationByPrefix("solidB12", "break", "idle", 24, false)
			setProperty("solidB12.antialiasing", false)
			scaleObject("solidB12", 6, 6)
			addLuaSprite("solidB12")
			setProperty("solidB12.visible", false)
			
			breakableObjects[21] = getProperty("solidB12")
			-- OBJECTS END
		end
	end

	makeLuaSprite("wall", "backgrounds/pcport/hiddenwall", -180 * 3 + (10*6), -81 * 3 + 3)
	setProperty("wall.antialiasing", false)
	scaleObject("wall", 6, 6)
	setProperty("wall.visible", false)
	addLuaSprite("wall", false)

	makeAnimatedLuaSprite("mxLegs", "backgrounds/pcport/legs", 0, 0)
	addAnimationByPrefix("mxLegs", "idle", "legs", 60, true)
	addAnimationByPrefix("mxLegs", "idle-mad", "runmad", 60, true)
	addAnimationByPrefix("mxLegs", "jump", "legjump", 55, true)
	setProperty("mxLegs.antialiasing", false)
	scaleObject("mxLegs", 6, 6)
	setObjectOrder("mxLegs", getObjectOrder("dadGroup"))
	setProperty("mxLegs.visible", false)
	addLuaSprite("mxLegs", false)

	makeAnimatedLuaSprite("bfLegs", "backgrounds/pcport/bflegs", 0, 0)
	addAnimationByPrefix("bfLegs", "runfire", "runfire", 30, true)
	addAnimationByPrefix("bfLegs", "jumpfire", "jumpfire", 55, true)
	addAnimationByPrefix("bfLegs", "runsmall", "runsmall", 30, true)
	addAnimationByPrefix("bfLegs", "jumpsmall", "jumpsmall", 55, true)
	addAnimationByPrefix("bfLegs", "run", "run0", 30, true)
	addAnimationByPrefix("bfLegs", "jump", "jump0", 55, true)
	setProperty("bfLegs.antialiasing", false)
	scaleObject("bfLegs", 6, 6)
	setObjectOrder("bfLegs", getObjectOrder("bfGroup"))
	setProperty("bfLegs.visible", false)
	addLuaSprite("bfLegs", false)
	
	makeLuaSprite("mxPoint", nil, 74*6, 8.95*6)
	makeLuaSprite("bfPoint", nil, 74*6, 8.95*6)
end

function onCreatePost()
	--[[for i = 1,2 do
		if i == 1 then -- a
			jump1Array[1] = -2982
			jump2Array[1] = -1260
			bfJumpBrick[1] = -5604
			bfJumpGap1[1] = -3210 -- + (48 * 6)
			bfJumpGap2[1] = -1234
			bfJumpPipe[1] = -700
		end
		if i == 2 then -- b
			jump1Array[2] = -3018
			jump2Array[2] = -1344
			bfJumpBrick[2] = -5736
			bfJumpGap1[2] = -3804 -- + (48 * 6)
			bfJumpGap2[2] = -1908
			bfJumpPipe[2] = -942
		end
	end]]
end

function onUpdate()
	if isChase and not inGameOver then
		if getDataFromSave("playerSettings", "powerUpHP") then
			if getDataFromSave("songSaveData", "powerState") == 0 then
				bfLegsPrefix = "small"
			elseif getDataFromSave("songSaveData", "powerState") >= 2 then
				bfLegsPrefix = "fire"
			else
				bfLegsPrefix = ""
			end
		end

		if boyfriendName == "bf-chase" or boyfriendName == "bf-chase-small" or boyfriendName == "bf-chase-fire" then
			if getProperty("boyfriend.animation.curAnim.name") == "idle" then
				setProperty("bfLegs.visible", false)
			else
				setProperty("bfLegs.visible", true)
			end
		end
		if dadName == "mx-chase" or dadName == "mx-angry" then
			if getProperty("dad.animation.curAnim.name") == "idle" then
				setProperty("mxLegs.visible", false)
			else
				setProperty("mxLegs.visible", true)
			end
		end
	else
		setProperty("bfLegs.visible", false)
		setProperty("mxLegs.visible", false)
	end

	shakepos = getRandomInt(1, 4)
	if getDataFromSave("playerSettings", "aspectRatio") == "16:9" then
		if shakepos == 1 then
			setProperty('wahoo.x', 148)
			setProperty('wahoo.y', 130)
		end
		if shakepos == 2 then
			setProperty('wahoo.x', 158)
			setProperty('wahoo.y', 130)
		end
		if shakepos == 3 then
			setProperty('wahoo.x', 148)
			setProperty('wahoo.y', 140)
		end
		if shakepos == 4 then
			setProperty('wahoo.x', 158)
			setProperty('wahoo.y', 140)
		end
	else
			if shakepos == 1 then
			setProperty('wahoo.x', -25)
			setProperty('wahoo.y', 130)
		end
		if shakepos == 2 then
			setProperty('wahoo.x', -35)
			setProperty('wahoo.y', 130)
		end
		if shakepos == 3 then
			setProperty('wahoo.x', -25)
			setProperty('wahoo.y', 140)
		end
		if shakepos == 4 then
			setProperty('wahoo.x', -35)
			setProperty('wahoo.y', 140)
		end
	end


end

local startTrigger = false
function onUpdatePost(elapsed)
	legFrame = getProperty("mxLegs.animation.curAnim.curFrame")
	bfLegFrame = getProperty("bfLegs.animation.curAnim.curFrame")

	if getPropertyFromClass("flixel.FlxG", "keys.justPressed.F1") then
		impact = not impact
		playSound("coin")
	end

	if isChase and not inGameOver then
		removeLuaSprite("bg")
		if getProperty("chaseBG.visible") == false then
			if not lowQuality then
				if not startTrigger then
					makeLuaSprite("flagPole", "backgrounds/pcport/flagpole"..skinSuffix, 0, -81*3 - 3)
					setProperty("flagPole.antialiasing", false)
					scaleObject("flagPole", 6, 6)
					addLuaSprite("flagPole", false)
					loadGraphic("chaseBG2", "backgrounds/pcport/goalEnd")

					setProperty("dad.y", getProperty("dad.y") - 4)
					setProperty("mxLegs.x", getProperty("dad.x") - 30*6 - 3)
					setProperty("mxLegs.y", getProperty("mxLegs.y") + 10*6 - 2)
					setProperty("bfLegs.x", getProperty("boyfriend.x") - 19*6 - 2)
					setProperty("bfLegs.y", getProperty("bfLegs.y") + 44*6 + 2)
		
					setProperty("mxPoint.y", getProperty("mxLegs.y"))
					mxLegsHighY = getProperty("mxLegs.y") - (40*6)
					mxLegsDefY = getProperty("mxLegs.y")
					
					setProperty("bfPoint.y", getProperty("bfLegs.y"))
					bfLegsHighY = getProperty("bfLegs.y") - (40*6)
					bfLegsDefY = getProperty("bfLegs.y")
					startTrigger = true
				end
			end
			
			for i=1,#jumpTriggers do
				jumpTriggers[i] = false
			end

			for i,object in pairs(breakableObjects) do
				if not pipeEnd then
					playAnim(object, "idle")
					updateHitbox(object)
					setProperty(object..".visible", true)
				end
			end

			setProperty("chaseBG.visible", true)
			setProperty("chaseBG2.visible", true)
			setProperty("chaseBG3.visible", true)
		end

		if week == "funkMixMX" then
			chaseBGPos = chaseBGPos + 1420 * elapsed * moveMult
		else
			chaseBGPos = chaseBGPos + 1640 * elapsed * moveMult
		end
		if chaseBGPos >= 0 then
			if week == "funkMixMX" then
				chaseBGPos = -960 * 6 + 2*6
			else
				chaseBGPos = -2128 * 6 + 16*6
			end

			if getProperty("brickScroll.visible") == false then
				setProperty("brickScroll.visible", true)
			elseif getProperty("brickScroll.visible") == "brickScroll.visible" then
				makeLuaSprite("brickScroll", "backgrounds/pcport/brickscroll"..skinSuffix, 0, 0)
				setProperty("brickScroll.antialiasing", false)
				scaleObject("brickScroll", 6, 6)
				addLuaSprite("brickScroll", false)
				loadGraphic("chaseBG2", "backgrounds/pcport/loop")
			end

			removeLuaSprite("flagPole")
			if not pipeEnd then
				if curStep > 2317 then
					makeLuaSprite("endingPipe", "backgrounds/pcport/endpipe"..skinSuffix, 0, 0)
					setProperty("endingPipe.antialiasing", false)
					scaleObject("endingPipe", 6, 6)
					addLuaSprite("endingPipe", true)
					setProperty("emptyBG.visible", true)
					setProperty("chaseBG.visible", false)
					pipeEnd = true
				end
			end

			for i=1,#jumpTriggers do
				jumpTriggers[i] = false
			end

			for i,object in pairs(breakableObjects) do
				if not pipeEnd then
					playAnim(object, "idle")
					updateHitbox(object)
					setProperty(object..".visible", true)
				end
			end
		end

		setProperty("chaseBG.x", math.floor(chaseBGPos / 6) * 6)
		if week == "funkMixMX" then
			setProperty("chaseBG2.x", getProperty("chaseBG.x") + getProperty("chaseBG.width") - 160*6)
			setProperty("chaseBG3.x", getProperty("chaseBG.x") - getProperty("chaseBG.width") + 160*6)
			setProperty("flagPole.x", getProperty("chaseBG.x") - 2*6)
		else
			setProperty("chaseBG2.x", getProperty("chaseBG.x") + getProperty("chaseBG.width") - 160*6 - 16*6)
			setProperty("chaseBG3.x", getProperty("chaseBG.x") - getProperty("chaseBG.width") + 160*6 + 16*6)
			setProperty("flagPole.x", getProperty("chaseBG.x"))
		end
		if pipeEnd then
			setProperty("endingPipe.x", getProperty("chaseBG.x") + 6*6)
		end
		setProperty("brickScroll.x", getProperty("chaseBG.x"))
		setProperty("emptyBG.x", getProperty("chaseBG.x"))
		setProperty("emptyBG2.x", getProperty("chaseBG3.x"))

		if not pipeEnd then
			for i=-1684*6, -1648*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[1] then
					jumpTriggers[1] = true
					dadIsJumping = true
					doTweenY("jumpMX", "mxPoint", mxLegsHighY, 0.4 * jumpMult, "sineOut")
					playAnim("mxLegs", "jump", true)
					updateHitbox("mxLegs")
					if getProperty("dad.animation.curAnim.name") == "idle" then
						playAnim("dad", "jump", true)
						setProperty("dad.specialAnim", true)
					end
				end
			end

			for i=-1356*6, -1340*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[2] then
					jumpTriggers[2] = true
					dadIsJumping = true
					doTweenY("jumpMX", "mxPoint", mxLegsHighY, 0.45 * jumpMult, "sineOut")
					playAnim("mxLegs", "jump", true)
					updateHitbox("mxLegs")
					if getProperty("dad.animation.curAnim.name") == "idle" then
						playAnim("dad", "jump", true)
						setProperty("dad.specialAnim", true)
					end
				end
			end

			for i=-835*6, -825*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[7] then
					jumpTriggers[7] = true
					dadIsJumping = true
					doTweenY("jumpMX", "mxPoint", mxLegsHighY, 0.45 * jumpMult, "sineOut")
					playAnim("mxLegs", "jump", true)
					updateHitbox("mxLegs")
					if getProperty("dad.animation.curAnim.name") == "idle" then
						playAnim("dad", "jump", true)
						setProperty("dad.specialAnim", true)
					end
				end
			end

			for i=-549*6, -540*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[9] then
					jumpTriggers[9] = true
					dadIsJumping = true
					doTweenY("jumpMX", "mxPoint", mxLegsHighY, 0.45 * jumpMult, "sineOut")
					playAnim("mxLegs", "jump", true)
					updateHitbox("mxLegs")
					if getProperty("dad.animation.curAnim.name") == "idle" then
						playAnim("dad", "jump", true)
						setProperty("dad.specialAnim", true)
					end
				end
			end

			for i=-138*6, -130*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[12] then
					jumpTriggers[12] = true
					dadIsJumping = true
					doTweenY("jumpMX", "mxPoint", mxLegsHighY, 0.45 * jumpMult, "sineOut")
					playAnim("mxLegs", "jump", true)
					updateHitbox("mxLegs")
					if getProperty("dad.animation.curAnim.name") == "idle" then
						playAnim("dad", "jump", true)
						setProperty("dad.specialAnim", true)
					end
				end
			end

			for i=-2119*6, -2075*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[3] then
					jumpTriggers[3] = true
					bfIsJumping = true
					doTweenY("jumpBF", "bfPoint", bfLegsHighY+(2*6), 0.45 * jumpMult, "sineOut")
					playAnim("bfLegs", "jump"..bfLegsPrefix, true)
					updateHitbox("bfLegs")
					if getProperty("boyfriend.animation.curAnim.name") == "idle" then
						playAnim("boyfriend", "jump", true)
						setProperty("boyfriend.specialAnim", true)
					end
				end
			end

			for i=-1760*6, -1712*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[4] then
					jumpTriggers[4] = true
					bfIsJumping = true
					doTweenY("jumpBF", "bfPoint", bfLegsHighY+(6*6), 0.5 * jumpMult, "sineOut")
					playAnim("bfLegs", "jump"..bfLegsPrefix, true)
					updateHitbox("bfLegs")
					if getProperty("boyfriend.animation.curAnim.name") == "idle" then
						playAnim("boyfriend", "jump", true)
						setProperty("boyfriend.specialAnim", true)
					end
				end
			end

			for i=-1430*6, -1411*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[5] then
					jumpTriggers[5] = true
					bfIsJumping = true
					doTweenY("jumpBF", "bfPoint", bfLegsHighY+(10*6), 0.45 * jumpMult, "sineOut")
					playAnim("bfLegs", "jump"..bfLegsPrefix, true)
					updateHitbox("bfLegs")
					if getProperty("boyfriend.animation.curAnim.name") == "idle" then
						playAnim("boyfriend", "jump", true)
						setProperty("boyfriend.specialAnim", true)
					end
				end
			end

			for i=-955*6, -910*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[6] then
					jumpTriggers[6] = true
					bfIsJumping = true
					doTweenY("jumpBFs", "bfPoint", bfLegsHighY-(2*6), 0.5 * jumpMult, "sineOut")
					playAnim("bfLegs", "jump"..bfLegsPrefix, true)
					updateHitbox("bfLegs")
					if getProperty("boyfriend.animation.curAnim.name") == "idle" then
						playAnim("boyfriend", "jump", true)
						setProperty("boyfriend.specialAnim", true)
					end
				end
			end

			for i=-620*6, -600*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[8] then
					jumpTriggers[8] = true
					bfIsJumping = true
					doTweenY("jumpBFF", "bfPoint", bfLegsHighY+(15*6), 0.3 * jumpMult, "sineOut")
					playAnim("bfLegs", "jump"..bfLegsPrefix, true)
					updateHitbox("bfLegs")
					if getProperty("boyfriend.animation.curAnim.name") == "idle" then
						playAnim("boyfriend", "jump", true)
						setProperty("boyfriend.specialAnim", true)
					end
				end
			end

			for i=-440*6, -415*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[10] then
					jumpTriggers[10] = true
					bfIsJumping = true
					doTweenY("jumpBF", "bfPoint", bfLegsHighY, 0.4 * jumpMult, "sineOut")
					playAnim("bfLegs", "jump"..bfLegsPrefix, true)
					updateHitbox("bfLegs")
					if getProperty("boyfriend.animation.curAnim.name") == "idle" then
						playAnim("boyfriend", "jump", true)
						setProperty("boyfriend.specialAnim", true)
					end
				end
			end

			for i=-194*6, -180*6 do
				if getProperty("chaseBG.x") == i and not jumpTriggers[11] then
					jumpTriggers[11] = true
					bfIsJumping = true
					doTweenY("jumpBFF", "bfPoint", bfLegsHighY+(18*6), 0.25 * jumpMult, "sineOut")
					playAnim("bfLegs", "jump"..bfLegsPrefix, true)
					updateHitbox("bfLegs")
					if getProperty("boyfriend.animation.curAnim.name") == "idle" then
						playAnim("boyfriend", "jump", true)
						setProperty("boyfriend.specialAnim", true)
					end
				end
			end
		end
		setProperty("bfLegs.alpha", getProperty("boyfriend.alpha"))

		-- if week == "funkMixMX" then
		-- 	local offset = {}
		-- 	local hitboxOfs = {}
		--[[for i = 1,#breakableObjects do
				if i == 1 then
					offset[i] = 99 -- - 7
					hitboxOfs[i] = 72
				end
				if i == 2 then
					offset[i] = 926 -- + 2
					hitboxOfs[i] = 72
				end
				if i == 3 then
					offset[i] = 910 -- + 2
					hitboxOfs[i] = 40
				end
				if i == 4 then
					offset[i] = 910 -- + 2
					hitboxOfs[i] = 40
				end
				if i == 5 then
					offset[i] = 830 -- + 2
					hitboxOfs[i] = 40
				end
				if i == 6 then
					offset[i] = 846 -- + 2
					hitboxOfs[i] = 40
				end
				if i == 7 then
					offset[i] = 846 -- + 2
					hitboxOfs[i] = 40
				end
				if i == 8 then
					offset[i] = 239
					hitboxOfs[i] = 40
				end
				if i == 9 then
					offset[i] = 207
					hitboxOfs[i] = 40
				end
				if i == 10 then
					offset[i] = 174
					hitboxOfs[i] = 40
				end
			end
		else]]
			for i,object in pairs(breakableObjects) do
				local offset = 0
				if i == 1 then --pipe 1
					offset = 2010 + 11
				elseif i == 2 then
					offset = 2088 + 8
				elseif i == 3 or i == 4 then
					offset = 2072 + 8
				elseif i == 5 then
					offset = 1992 + 8
				elseif i == 6 or i == 7 then
					offset = 2008 + 8
				elseif i == 8 then
					offset = 1400
				elseif i == 9 then
					offset = 1369
				elseif i == 10 then
					offset = 1336
				elseif i == 11 then
					offset = 1768 + 8
				elseif i == 12 then --pipe 2
					offset = 870 - 9
				elseif i == 13 then
					offset = 602
				elseif i == 14 then
					offset = 571
				elseif i == 15 then
					offset = 540
				elseif i == 16 then
					offset = 426
				elseif i == 17 or i == 18 then
					offset = 410
				elseif i == 19 or i == 20 then
					offset = 345
				elseif i == 21 then
					offset = 329
				end
				
				local hitboxOfs = 0
				
				if i == 1 or i == 12 then
					hitboxOfs = 52 + 12
				else
					hitboxOfs = 20 + 12
				end
				
				setProperty(object..".x", getProperty("chaseBG.x") + (offset * 6))
				
				if getProperty(object..".x") >= (getProperty("dad.x") - (hitboxOfs * 6)) and not pipeEnd then
					if getProperty(object..".animation.curAnim.name") ~= "break" then
						playAnim(object, "break", true)
						updateHitbox(object)
						if impact and getProperty("popup.visible") ~= true then
							triggerEvent("Pixel Cam Shake", "5, 4, 3", "0.015")
							playSound("break-pcport", 0.5)
						end
					end
				end
			end
		-- end

		setProperty("boyfriend.y", math.floor(getProperty("bfPoint.y")/6)*6+(1*6))
		setProperty("bfLegs.y", getProperty("boyfriend.y")-19*6)
			
		setProperty("dad.y", math.floor(getProperty("mxPoint.y")/6)*6+(22*6)-2)
		setProperty("mxLegs.y", getProperty("dad.y")-21*6-4)

		if not funkMixCam() and not lowQuality then
			if not funkMixCam() then
				if mustHitSection then
					cameraSetTarget("boyfriend")
				else
					cameraSetTarget("dad")
				end
			end
		end
	elseif pipeEnd then
		for i,object in pairs(breakableObjects) do
			removeLuaSprite(object)
		end
		for i=1,#jumpTriggers do
			jumpTriggers[i] = true
		end
	end

	if bfIsJumping then
		if getProperty("boyfriend.animation.curAnim.name") == "idle" then
			playAnim("boyfriend", "jump", true)
			setProperty("boyfriend.specialAnim", true)
		end
	else
		if getProperty("boyfriend.animation.curAnim.name") == "jump" then
			setProperty("boyfriend.specialAnim", false)
			characterDance("bf")
		end
	end
	if dadIsJumping then
		if getProperty("dad.animation.curAnim.name") == "idle" then
			playAnim("dad", "jump", true)
			setProperty("dad.specialAnim", true)
		end
	else
		if getProperty("dad.animation.curAnim.name") == "jump" then
			setProperty("dad.specialAnim", false)
			characterDance("dad")
		end
	end

	if boyfriendName:find("-chase") then
		if (bfLegFrame >= 3 and bfLegFrame < 6 or bfLegFrame >= 9 and bfLegFrame < 12) and (getProperty("boyfriend.animation.curAnim.name") ~= "idle" and getProperty("boyfriend.animation.curAnim.name") ~= "jump") and getProperty("bfLegs.visible") then
			setProperty("boyfriend.offset.y", -9)
		else
			setProperty("boyfriend.offset.y", -3)
		end
		if boyfriendName == "bf-chase-small" and (getProperty("boyfriend.animation.curAnim.name") == "jump" or getProperty("boyfriend.animation.curAnim.name") == "singUP") then
			setProperty("boyfriend.offset.y", getProperty("boyfriend.offset.y") - 6)
		end
	else
		setProperty("boyfriend.offset.y", 0)
	end
end

function onTweenCompleted(tag)
	-- if week == "funkMixMX" then
	-- 	if tag == "jumpBF" then
	-- 		doTweenY("jumpFallBF", "boyfriend", bfDefPosY, 0.5 * jumpMult, "sineIn")
	-- 	end
	-- 	if tag == "jumpFallBF" then
	-- 		bfIsJumping = false
	-- 		if getProperty("boyfriend.animation.curAnim.name") == "jump" then
	-- 			characterDance("boyfriend")
	-- 		end
	-- 		jumpedBrick = false
	-- 		jumpedGap1 = false
	-- 		playAnim("bfLegs", "run"..bfLegsPrefix, true)
	-- 		updateHitbox("bfLegs")
	-- 	end

	-- 	if tag == "jumpFastBF" then
	-- 		doTweenY("bfFallFast", "boyfriend", bfDefPosY, 0.3 * jumpMult, "sineIn")
	-- 	end
	-- 	if tag == "bfFallFast" then
	-- 		bfIsJumping = false
	-- 		if getProperty("boyfriend.animation.curAnim.name") == "jump" then
	-- 			characterDance("boyfriend")
	-- 		end
	-- 		jumpedGap2 = false
	-- 		jumpedPipe = false
	-- 		playAnim("bfLegs", "run"..bfLegsPrefix, true)
	-- 		updateHitbox("bfLegs")
	-- 	end

	-- 	if tag == "jumpMX" then
	-- 		doTweenY("jumpFall", "dad", mxDefPosY, 0.4 * jumpMult, "sineIn")
	-- 	end
	-- 	if tag == "jumpFall" then
	-- 		dadIsJumping = false
	-- 		if getProperty("dad.animation.curAnim.name") == "jump" then
	-- 			characterDance("dad")
	-- 		end
	-- 		jumped1 = false
	-- 		jumped2 = false
	-- 		playAnim("mxLegs", "idle", true)
	-- 		updateHitbox("mxLegs")
	-- 	end
	-- else
		if tag == "jumpMX" then
			doTweenY("fallMX", "mxPoint", mxLegsDefY, 0.45 * jumpMult, "sineIn")
		end
		
		if tag == "fallMX" then
			dadIsJumping = false
			playAnim("mxLegs", "idle"..legsSuffix, true)
			updateHitbox("mxLegs")
			if getProperty("dad.animation.curAnim.name") == "jump" then
				characterDance("dad")
			end
		end
		
		if tag == "jumpBF" then
			doTweenY("fallBF", "bfPoint", bfLegsDefY, 0.4 * jumpMult, "sineIn")
		end
		
		if tag == "jumpBFF" then
			doTweenY("fallBF", "bfPoint", bfLegsDefY, 0.25 * jumpMult, "sineIn")
		end
		
		if tag == "jumpBFs" then
			doTweenY("fallBF", "bfPoint", bfLegsDefY, 0.5 * jumpMult, "sineIn")
		end
		
		if tag == "fallBF" then
			bfIsJumping = false
			playAnim("bfLegs", "run"..bfLegsPrefix, true)
			updateHitbox("bfLegs")
			if getProperty("boyfriend.animation.curAnim.name") == "jump" then
				characterDance("boyfriend")
			end
		end
	-- end
end

function onStepHit()
	if curStep == 768 then
		isChase = true
	elseif curStep == 1254 then
		setProperty("blackScreen.visible", true)
		setProperty("popup.visible", true)
	elseif curStep == 1263 then
		playAnim("popup", "doesnt")
		updateHitbox("popup")
	elseif curStep == 1266 then
		playAnim("popup", "get")
		updateHitbox("popup")
	elseif curStep == 1268 then
		playAnim("popup", "you")
		updateHitbox("popup")
	elseif curStep == 1270 then
		playAnim("popup", "far")
		updateHitbox("popup")
	elseif curStep == 1276 then
		setProperty("blackScreen.visible", false)
		removeLuaSprite("popup")
	elseif curStep == 1399 then
		setProperty('wahoo.visible', true)
	elseif curStep == 1408 then
		removeLuaSprite("wahoo")
	elseif curStep == 1532 then
		setProperty("blackScreen.visible", true)
		setProperty("luigi.visible", true)

		isChase = false
		setProperty("chaseBG.visible", false)
		setProperty("chaseBG2.visible", false)
		setProperty("chaseBG3.visible", false)
		setProperty("brickScroll.visible", false)
		setProperty("wall.visible", true)
		for i,object in pairs(breakableObjects) do
			setProperty(object..".visible", false)
		end
	elseif curStep == 1536 then
		removeLuaSprite("luigi")
		removeLuaSprite("blackScreen")
	elseif curStep == 2016 then -- 2032
		setProperty('select.visible', true)
		setProperty("camGame.visible", false)
	elseif curStep == 2034 then
		legsSuffix = "-mad"
		playAnim("mxLegs", "idle"..legsSuffix, true)
		updateHitbox("mxLegs")
		if week == "funkMixMX" then
			chaseBGPos = -960 * 6 - 2*6
		else
			chaseBGPos = -2128 * 6 - 1*6
		end
		setProperty("chaseBG.x", chaseBGPos)
		removeLuaSprite("wall")		
	elseif curStep == 2036 then -- 2036
		objectPlayAnimation('select', 'here') -- get
	elseif curStep == 2048 then
		removeLuaSprite("select")
		isChase = true
		setProperty("camGame.visible", true)
	elseif curStep == 2344 then
		isChase = false
		removeLuaSprite("mxLegs")
		removeLuaSprite("bfLegs")
		setProperty("endingPipe.x", getProperty("chaseBG.x") + 6*6)
		runTimer("goIntoPipe", 0.05, 30)
	end

	if curStep > 2317 then
		setProperty("emptyBG2.visible", true)
		setProperty("chaseBG3.visible", false)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "goIntoPipe" then
		setProperty("boyfriend.x", getProperty("boyfriend.x")-6)
		if loopsLeft <= 0 then
			runTimer("goIntoPipe", 0.05, 30)
		end
	end
end

function onCustomSubstateCreate(name)
	if name == "funkMixGameOver" then
		setProperty("bfLegs.visible", false)
	end
end