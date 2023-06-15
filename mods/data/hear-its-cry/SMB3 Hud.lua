local scoreGroup = {}
local scoreText = {}
local healthGroup = {}
local accGroup = {}
local accText = {}
local wideScreen = (26 * 6) + 4

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	loadGraphic("overlay", "ui/smb3/overlay")
	setProperty("overlay.alpha", 1)
	setProperty("iconP1.exists", false)
	setProperty("iconP2.exists", false)
	aspectRatio = getDataFromSave("playerSettings", "aspectRatio")
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		setProperty("overlay.x", -wideScreen - 2)
		wideScreen = 1
	end

	barY = screenHeight - (9 * 6)
	if downscroll then
		barY = 5 * 6
		loadGraphic("overlay", "ui/smb3/overlay-flip")
	end
	setProperty("scoreBar.exists", false)
	setProperty("accuracyText.exists", false)
	setProperty("accuracyText2.color", 0x00000000)
	for index = 1,6 do
		makeAnimatedLuaSprite("scoreNum"..index, "ui/smb3/number", 8 * (index - 1) * 6, barY - (2 * 6))
		addAnimationByPrefix("scoreNum"..index, "idle", "idle", 0, false)
		setProperty("scoreNum"..index..".animation.frameIndex", 0)
		setProperty("scoreNum"..index..".x", getProperty("scoreNum"..index..".x") + 8 * 6 + wideScreen - 1)
		setProperty("scoreNum"..index..".antialiasing", false)
		setObjectCamera("scoreNum"..index, "hud")
		scaleObject("scoreNum"..index, 6, 6)
		scoreGroup[index] = "scoreNum"..index
		addLuaSprite("scoreNum"..index, false)
	end
	
	if getDataFromSave("playerSettings", "powerUpHP") ~= true then
		loadGraphic("healthDecor", "ui/smb3/hp")
		setProperty("healthDecor.x", getProperty("healthDecor.x") - 3)
		if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
			setProperty("healthDecor.x", getProperty("healthDecor.x") - ((26 * 6) + 3))
		end
		if downscroll then
			setProperty("healthDecor.y", getProperty("healthDecor.y") + 2 * 6 - 1)
			setProperty("healthBarBF.y", getProperty("healthBarBF.y") - 3 * 6 - 1)
			setProperty("healthBarDAD.y", getProperty("healthBarDAD.y") - 3 * 6 - 1)
		else
			setProperty("healthDecor.y", getProperty("healthDecor.y") - 1 * 6)
			setProperty("healthBarBF.y", getProperty("healthBarBF.y") - 6 * 6)
			setProperty("healthBarDAD.y", getProperty("healthBarDAD.y") - 6 * 6)
		end
		removeLuaSprite("healthArrowBF")
		removeLuaSprite("healthArrowDAD")
	end

	for index = 1,3 do
		makeAnimatedLuaSprite("accNum"..index, "ui/smb3/number", 8 * (index - 1) * 6, barY - (2 * 6))
		addAnimationByPrefix("accNum"..index, "idle", "idle", 0, false)
		setProperty("accNum"..index..".animation.frameIndex", 0)
		setProperty("accNum"..index..".x", getProperty("accNum"..index..".x") + 114 * 6 + wideScreen - 1)
		setProperty("accNum"..index..".antialiasing", false)
		scaleObject("accNum"..index, 6, 6)
		setObjectCamera("accNum"..index, "hud")
		updateHitbox("accNum"..index)
		accGroup[index] = "accNum"..index
		addLuaSprite("accNum"..index, false)
	end
	if aspectRatio == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		setProperty("ratingIcon.x", screenWidth - (1 * 6) + 2)
	elseif getDataFromSave("playerSettings", "showBorder") == true then
		setProperty("ratingIcon.x", 960 - (1 * 6) + 2)
	else
		setProperty("ratingIcon.x", screenWidth - (81 * 6) + 1)
	end
	setProperty("ratingIcon.y", barY - (2 * 6))
	setProperty("flagIcon.x", getProperty("ratingIcon.x") - 8 * 6)
	setProperty("flagIcon.y", barY - (2 * 6))
	if aspectRatio == "4:3" or getDataFromSave("playerSettings", "showBorder") == true then
		setProperty("accuracyText2.x", (27 * 6) + (163 * 6) - 1)
	else
		setProperty("accuracyText2.x", 163 * 6)
	end
	setProperty("accuracyText2.y", barY + 3)
end

function onUpdatePost()
	for i = 1,#getTextString("scoreBar") do
		local c = string.sub(getTextString("scoreBar"), i, i)
		scoreText[i] = c
	end
	for i = 1,#getTextString("accuracyText") do
		local c = string.sub(getTextString("accuracyText"), i, i)
		accText[i] = c
	end
	setTextString("accuracyText2", string.gsub(getTextString("accuracyText2"), "^.", " "))

	for i = 1,#scoreGroup do
		setProperty("scoreNum"..i..".animation.frameIndex", scoreText[i])
		setProperty("scoreNum"..i..".color", 0x00FFFFFF)
		if score < 0 then
			setProperty("scoreNum"..i..".color", 0x00ff0000)
		end
	end
	for i = 1,#accGroup do
		setProperty("accNum"..i..".animation.frameIndex", accText[i])
	end
end