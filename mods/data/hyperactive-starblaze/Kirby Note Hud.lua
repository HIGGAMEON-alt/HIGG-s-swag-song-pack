local scoreGroup = {}
local scoreText = {}
local healthGroup = {}
local accGroup = {}
local accText = {}
local acc2Group = {}
local acc2Text = {}
local wideScreen = (26 * 6) + 4

local notePath = "kirby/NOTE_assets"
local notePathBy5 = "kirby/NOTE_assets_by5"

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
		setProperty("overlay.x", -wideScreen - 2)
		wideScreen = 0
	end
	barY = screenHeight - (9 * 6)
	if downscroll then
		barY = 3 * 6
	end
	setProperty("scoreBar.exists", false)
	setProperty("accuracyText.exists", false)
	setProperty("accuracyText2.exists", false)
	for index = 1,6 do
		makeAnimatedLuaSprite("scoreNum"..index, "ui/kirby/number-big", 8 * (index - 1) * 6, barY - (1 * 6))
		addAnimationByPrefix("scoreNum"..index, "idle", "idle", 0, false)
		setProperty("scoreNum"..index..".animation.frameIndex", 0)
		setProperty("scoreNum"..index..".x", getProperty("scoreNum"..index..".x") + 5 * 6 + wideScreen)
		setProperty("scoreNum"..index..".antialiasing", false)
		if downscroll then
			setProperty("scoreNum"..index..".y", getProperty("scoreNum"..index..".y") - 1 * 6)
		else
			setProperty("scoreNum"..index..".y", getProperty("scoreNum"..index..".y") + 1 * 6)
		end
		setObjectCamera("scoreNum"..index, "hud")
		scaleObject("scoreNum"..index, 6, 6)
		scoreGroup[index] = "scoreNum"..index
		addLuaSprite("scoreNum"..index, false)
	end
	if getDataFromSave("playerSettings", "powerUpHP") then
		for index = 1,6 do
			makeAnimatedLuaSprite("healthPoint"..index, "ui/kirby/health", 7 * (index - 1) * 6, barY)
			addAnimationByPrefix("healthPoint"..index, "full", "full", 6, true)
			addAnimationByPrefix("healthPoint"..index, "empty", "empty", 0, false)
			setProperty("healthPoint"..index..".animation.frameIndex", 0)
			setProperty("healthPoint"..index..".x", getProperty("healthPoint"..index..".x") + 57 * 6 + wideScreen)
			setProperty("healthPoint"..index..".antialiasing", false)
			if downscroll then
				setProperty("healthPoint"..index..".y", getProperty("healthPoint"..index..".y") - 2 * 6)
			end
			setObjectCamera("healthPoint"..index, "hud")
			scaleObject("healthPoint"..index, 6, 6)
			healthGroup[index] = "healthPoint"..index
			addLuaSprite("healthPoint"..index, false)
		end
	else
		setProperty("healthDecor.visible", false)
		removeLuaSprite("healthArrowDAD", true)
		removeLuaSprite("healthArrowBF", true)

		makeLuaSprite("healthDecorBack", "ui/kirby/hp", 0 * 6, barY)
		setProperty("healthDecorBack.x", getProperty("healthDecorBack.x") + 57 * 6 + wideScreen)
		if downscroll then
			setProperty("healthDecorBack.y", getProperty("healthDecorBack.y") - 2 * 6)
		end
		setObjectCamera("healthDecorBack", "hud")
		scaleObject("healthDecorBack", 6, 6)
		addLuaSprite("healthDecorBack", false)

		setProperty("healthBarDAD.x", getProperty("healthDecorBack.x") + 1 * 6)
		setProperty("healthBarDAD.y", getProperty("healthDecorBack.y") + 1 * 6)
		setProperty("healthBarBF.x", getProperty("healthDecorBack.x") + 1 * 6)
		setProperty("healthBarBF.y", getProperty("healthDecorBack.y") + 1 * 6)

		removeLuaSprite("healthDecorBack")

		makeLuaSprite("healthDecor", "ui/kirby/hp", 0 * 6, barY)
		setProperty("healthDecor.x", getProperty("healthDecor.x") + 57 * 6 + wideScreen)
		if downscroll then
			setProperty("healthDecor.y", getProperty("healthDecor.y") - 2 * 6)
		end
		setObjectCamera("healthDecor", "hud")
		scaleObject("healthDecor", 6, 6)
		addLuaSprite("healthDecor", false)
		setProperty("healthDecorBack.antialiasing", false)
		setProperty("healthDecor.antialiasing", false)
		setProperty("healthDecor.alpha", healthBarAlpha)
	end
	for index = 1,3 do
		makeAnimatedLuaSprite("accNum"..index, "ui/kirby/number-big", 8 * (index - 1) * 6, barY - (1 * 6))
		addAnimationByPrefix("accNum"..index, "idle", "idle", 0, false)
		setProperty("accNum"..index..".animation.frameIndex", 0)
		setProperty("accNum"..index..".x", getProperty("accNum"..index..".x") + 122 * 6 + wideScreen)
		setProperty("accNum"..index..".antialiasing", false)
		scaleObject("accNum"..index, 6, 6)
		setObjectCamera("accNum"..index, "hud")
		updateHitbox("accNum"..index)
		accGroup[index] = "accNum"..index
		addLuaSprite("accNum"..index, false)
	end
	for index = 1,2 do
		makeAnimatedLuaSprite("acc2Num"..index, "ui/kirby/number-small", 4 * (index - 1) * 6, barY + (2 * 6))
		addAnimationByPrefix("acc2Num"..index, "idle", "idle", 0, false)
		setProperty("acc2Num"..index..".animation.frameIndex", 0)
		setProperty("acc2Num"..index..".x", getProperty("acc2Num"..index..".x") + 148 * 6 + wideScreen)
		setProperty("acc2Num"..index..".antialiasing", false)
		scaleObject("acc2Num"..index, 6, 6)
		setObjectCamera("acc2Num"..index, "hud")
		updateHitbox("acc2Num"..index)
		acc2Group[index] = "acc2Num"..index
		addLuaSprite("acc2Num"..index, false)
	end
	if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
		setProperty("ratingIcon.x", screenWidth + (6 * 6) + 2)
	else
		setProperty("ratingIcon.x", screenWidth - (73 * 6) - 4)
	end
	setProperty("ratingIcon.y", barY - (1 * 6))
	setProperty("flagIcon.x", getProperty("ratingIcon.x") - 9 * 6)
	setProperty("flagIcon.y", barY - (1 * 6))
	if getDataFromSave("playerSettings", "quantNotes") == true then
		notePath = "quants/kirby/NOTE_quants"
	end
end

function onCreatePost()
	for i = 0,getProperty("opponentStrums.length")-1 do
		setPropertyFromGroup("opponentStrums", i, "texture", notePathBy5)
	end
	for i = 0,getProperty("playerStrums.length")-1 do
		setPropertyFromGroup("playerStrums", i, "texture", notePathBy5)
	end
	for i = 0,getProperty("unspawnNotes.length")-1 do
		if getPropertyFromGroup("unspawnNotes", i, "noteType") == "" or getPropertyFromGroup("unspawnNotes", i, "noteType") == "GF Sing" then
			setPropertyFromGroup("unspawnNotes", i, "texture", notePathBy5)
		end
	end
end

function onSongStart()
	if getPropertyFromClass("ClientPrefs", "opponentStrums") then
		for i = 0,getProperty("opponentStrums.length")-1 do
			makeAnimatedLuaSprite("kirbySturms"..i, "pixelUI/"..notePath, getPropertyFromGroup("opponentStrums", i, "x"), getPropertyFromGroup("opponentStrums", i, "y"))
			if getDataFromSave("playerSettings", "quantNotes") == true and not lowQuality then
				for q = 1,10 do
					addAnimationByPrefix("kirbySturms"..i, "idle"..q, "quant"..q.."note"..i.."idle", 0, false)
					addAnimationByPrefix("kirbySturms"..i, "press"..q, "quant"..q.."note"..i.."press", 12, false)
					addAnimationByPrefix("kirbySturms"..i, "hit"..q, "quant"..q.."note"..i.."hit", 24, false)
				end
			else
				addAnimationByPrefix("kirbySturms"..i, "idle", "note"..i.."idle", 0, false)
				addAnimationByPrefix("kirbySturms"..i, "press", "note"..i.."press", 12, false)
				addAnimationByPrefix("kirbySturms"..i, "hit", "note"..i.."hit", 24, false)
			end
			scaleObject("kirbySturms"..i, 6, 6)
			setObjectCamera("kirbySturms"..i, "hud")
			setProperty("kirbySturms"..i..".antialiasing", false)
			setProperty("kirbySturms"..i..".alpha", getPropertyFromGroup("opponentStrums", i, "alpha"))
			addLuaSprite("kirbySturms"..i, false)
			setObjectOrder("kirbySturms"..i, getObjectOrder("strumLineNotes"))
		end
	end
	for i = 0,getProperty("playerStrums.length")-1 do
		j = i + getProperty("opponentStrums.length")
		makeAnimatedLuaSprite("kirbySturms"..j, "pixelUI/"..notePath, getPropertyFromGroup("playerStrums", i, "x"), getPropertyFromGroup("playerStrums", i, "y"))
		if getDataFromSave("playerSettings", "quantNotes") == true and not lowQuality then
			for q = 1,10 do
				addAnimationByPrefix("kirbySturms"..j, "idle"..q, "quant"..q.."note"..i.."idle", 24, false)
				addAnimationByPrefix("kirbySturms"..j, "press"..q, "quant"..q.."note"..i.."press", 24, false)
				addAnimationByPrefix("kirbySturms"..j, "hit"..q, "quant"..q.."note"..i.."hit", 24, false)
			end
		else
			addAnimationByPrefix("kirbySturms"..j, "idle", "note"..i.."idle", 24, false)
			addAnimationByPrefix("kirbySturms"..j, "press", "note"..i.."press", 24, false)
			addAnimationByPrefix("kirbySturms"..j, "hit", "note"..i.."hit", 24, false)
		end
		scaleObject("kirbySturms"..j, 6, 6)
		setObjectCamera("kirbySturms"..j, "hud")
		setProperty("kirbySturms"..j..".antialiasing", false)
		setProperty("kirbySturms"..j..".alpha", getPropertyFromGroup("playerStrums", i, "alpha"))
		addLuaSprite("kirbySturms"..j, false)
		setObjectOrder("kirbySturms"..j, getObjectOrder("strumLineNotes"))
	end
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
	for i = 1,#getTextString("accuracyText2") do
		local c = string.gsub(getTextString("accuracyText2"), "%p", "")
		c = string.sub(c, i, i)
		acc2Text[i] = c
	end

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
	for i = 1,#acc2Group do
		setProperty("acc2Num"..i..".animation.frameIndex", acc2Text[i])
	end

	for i = 1,#healthGroup do
		if getDataFromSave("songSaveData", "powerState") >= i - 1 then
			playAnim("healthPoint"..i, "full")
			setProperty("healthPoint"..i..".animation.curAnim.curFrame", getProperty("healthPoint1.animation.curAnim.curFrame"))
		else
			playAnim("healthPoint"..i, "empty")
		end
		updateHitbox("healthPoint"..i)
	end

	for i = 0,getProperty("opponentStrums.length")-1 do
		if getPropertyFromGroup("opponentStrums", i, "animation.curAnim.name") == "static" or getPropertyFromGroup("opponentStrums", i, "animation.curAnim.name") == "pressed" then
			setProperty("kirbySturms"..i..".visible", false)
		else
			setProperty("kirbySturms"..i..".visible", true)
		end
	end

	for i = 0,getProperty("playerStrums.length")-1 do
		if getPropertyFromGroup("playerStrums", i, "animation.curAnim.name") == "static" or getPropertyFromGroup("playerStrums", i, "animation.curAnim.name") == "pressed" then
			setProperty("kirbySturms"..(i+getProperty("opponentStrums.length"))..".visible", false)
		else
			setProperty("kirbySturms"..(i+getProperty("opponentStrums.length"))..".visible", true)
		end
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if getDataFromSave("playerSettings", "quantNotes") == true and not lowQuality then
		local quant = string.match(getPropertyFromGroup("notes", id, "texture"),"_quants(.*)_")
		playAnim("kirbySturms"..noteData, "hit"..quant, true)
	else
		playAnim("kirbySturms"..noteData, "hit", true)
	end
	updateHitbox("kirbySturms"..noteData)
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if getDataFromSave("playerSettings", "quantNotes") == true and not lowQuality then
		local quant = string.match(getPropertyFromGroup("notes", id, "texture"),"_quants(.*)_")
		playAnim("kirbySturms"..noteData+getProperty("opponentStrums.length"), "hit"..quant, true)
	else
		playAnim("kirbySturms"..noteData+getProperty("opponentStrums.length"), "hit", true)
	end
	updateHitbox("kirbySturms"..noteData+getProperty("opponentStrums.length"))
	setProperty("kirbySturms"..(noteData+getProperty("opponentStrums.length"))..".visible", true)
end