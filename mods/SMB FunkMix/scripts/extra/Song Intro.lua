--script by SirTopHat
--tweaked for SMB Funk Mix Advance by KirbyKid Johnson
local xPosition = -305-91
local yPosition = 0
local active = false
local wideScreen = 0

--easy script configs
IntroTextSize = 8	--Size of the text for the Now Playing thing.
IntroSubTextSize = 16 --size of the text for the Song Name.
IntroTagColor = "FFFFFF"	--Color of the tag at the end of the box.
IntroBoxColor = "000000"	--Color of the box.
IntroTagWidth = -12	--Width of the box's tag thingy.
--easy script configs

--actual script
function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or week == "funkMixMX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	if downscroll then
		yPosition = 69
	else
		yPosition = screenHeight-169
	end
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") == true then
		wideScreen = (26 * 6) + 4
	end

	--the tag at the end of the box
	makeLuaSprite("JukeBoxTag", "", xPosition-IntroTagWidth+wideScreen, yPosition-3)
	makeGraphic("JukeBoxTag", 396+IntroTagWidth, 100+6, IntroTagColor)
	setObjectCamera("JukeBoxTag", "hud")
	addLuaSprite("JukeBoxTag", true)
	setProperty("JukeBoxTag.color", 0x00E69C21)

	--the box
	makeLuaSprite("JukeBox", "songIntro/null", xPosition-IntroTagWidth+wideScreen, yPosition)
	-- makeGraphic("JukeBox", 300, 100, IntroBoxColor)
	setObjectCamera("JukeBox", "hud")
	addLuaSprite("JukeBox", true)
	
	--the text for the "Now Playing" bit
	makeLuaText("JukeBoxText", "Now Playing:", 300, xPosition-IntroTagWidth+wideScreen, yPosition+85-15)
	setTextAlignment("JukeBoxText", "left")
	setObjectCamera("JukeBoxText", "hud")
	setTextSize("JukeBoxText", IntroTextSize)
	setTextBorder("JukeBoxText", 1, "000000")
	addLuaText("JukeBoxText")
	
	--text for the song name
	makeLuaText("JukeBoxSubText", songName, 300, xPosition-IntroTagWidth+wideScreen, yPosition+30-15)
	setTextAlignment("JukeBoxSubText", "left")
	setObjectCamera("JukeBoxSubText", "hud")
	setTextSize("JukeBoxSubText", IntroSubTextSize)
	setTextBorder("JukeBoxSubText", 2, "000000")
	addLuaText("JukeBoxSubText")

	--turns off antialiasing
	setProperty("JukeBoxTag.antialiasing", false)
	setProperty("JukeBox.antialiasing", false)

	-- Makes it invisible until event
	setProperty("JukeBoxTag.visible", false)
	setProperty("JukeBox.visible", false)
	setProperty("JukeBoxText.visible", false)
	setProperty("JukeBoxSubText.visible", false)

	if isStoryMode and seenCutscene then
		triggerEvent("Intro","","")
	elseif not isStoryMode then
		triggerEvent("Intro","","")
	end
end

function onCreatePost()
	loadGraphic("JukeBox", "songIntro/"..songName)
end

--motion functions
function onEvent(n,v,b)
	if n == "Intro" then
		active = true
		if v ~= "" then
			setTextString("JukeBoxSubText",v)
		end
		if b ~= "" then
			setTextString("JukeBoxText",b)
		end
		setProperty("JukeBoxTag.visible", true)
		setProperty("JukeBox.visible", true)
		setProperty("JukeBoxText.visible", true)
		setProperty("JukeBoxSubText.visible", true)
		setProperty("JukeBoxTackOn.visible", true)

		tweenRunning = true
		doTweenX("MoveInOne", "JukeBoxTag", 0+wideScreen, 1, "CircInOut")
		doTweenX("MoveInTwo", "JukeBox", 0+wideScreen, 1, "CircInOut")
		doTweenX("MoveInThree", "JukeBoxText", 10+wideScreen, 1, "CircInOut")
		doTweenX("MoveInFour", "JukeBoxSubText", 10+wideScreen, 1, "CircInOut")
		
		runTimer("JukeBoxWait", 3, 1)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is its tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if tag == "JukeBoxWait" and active then
		tweenRunning = true
		doTweenX("MoveOutOne", "JukeBoxTag", -450+wideScreen, 1.5, "CircInOut")
		doTweenX("MoveOutTwo", "JukeBox", -450+wideScreen, 1.5, "CircInOut")
		doTweenX("MoveOutThree", "JukeBoxText", -450+wideScreen, 1.5, "CircInOut")
		doTweenX("MoveOutFour", "JukeBoxSubText", -450+wideScreen, 1.5, "CircInOut")
	end
end

function onTweenCompleted(tag)
	tweenRunning = false
	if tag == "MoveOutOne" and active then
		setProperty("JukeBoxTag.visible", false)
		setProperty("JukeBox.visible", false)
		setProperty("JukeBoxText.visible", false)
		setProperty("JukeBoxSubText.visible", false)
		active = false
	end
end