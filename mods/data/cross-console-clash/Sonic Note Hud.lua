local scoreGroup = {}
local scoreText = {}
local wideScreen = (26 * 6) + 4

local notePath = "sonic/NOTE_assets"
local notePathBy5 = "sonic/NOTE_assets_By5"

function onCreate()
	barY = screenHeight - (7 * 6) + 1
	if downscroll then
		barY = 3 * 6 + 1
	end
	setProperty("scoreBar.exists", false)
	for index = 1,6 do
		makeAnimatedLuaSprite("scoreNum"..index, "ui/sonic/score", 8 * (index - 1) * 6 + 1, barY - (1 * 6))
		addAnimationByPrefix("scoreNum"..index, "idle", "idle", 0, false)
		setProperty("scoreNum"..index..".animation.frameIndex", 0)
		setProperty("scoreNum"..index..".x", getProperty("scoreNum"..index..".x") + 2 * 6)
		scaleObject("scoreNum"..index, 6, 6)
		setObjectCamera("scoreNum"..index, "hud")
		setProperty("scoreNum"..index..".antialiasing", false)
		scoreGroup[index] = "scoreNum"..index
		addLuaSprite("scoreNum"..index, false)
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") == true then
			setProperty("scoreNum"..index..".x", getProperty("scoreNum"..index..".x") + wideScreen)
		end
	end
	if getDataFromSave("playerSettings", "quantNotes") == true then
		notePath = "quants/sonic/NOTE_quants"
	end
end

function onCreatePost()
	for i = 0,getProperty("opponentStrums.length")-1 do
		setPropertyFromGroup("opponentStrums", i, "texture", notePathBy5)
	end
	for i = 0,getProperty("unspawnNotes.length")-1 do
		if getDataFromSave("playerSettings", "quantNotes") == true then
			local quant = string.match(getPropertyFromGroup("unspawnNotes", i, "texture"),"_(.*)")
			notePathBy5 = "quants/sonic/NOTE_"..quant.."_By5"
		end
		if not getPropertyFromGroup("unspawnNotes", i, "mustPress") then
			setPropertyFromGroup("unspawnNotes", i, "texture", notePathBy5)
		end
	end
end

function onSongStart()
	if getPropertyFromClass("ClientPrefs", "opponentStrums") then
		for i = 0,getProperty("opponentStrums.length")-1 do
			makeAnimatedLuaSprite("sonicSturms"..i, "pixelUI/"..notePath, getPropertyFromGroup("opponentStrums", i, "x"), getPropertyFromGroup("opponentStrums", i, "y"))
			if getDataFromSave("playerSettings", "quantNotes") == true and not lowQuality then
				for q = 1,10 do
					addAnimationByPrefix("sonicSturms"..i, "idle"..q, "quant"..q.."note"..i.."idle", 0, false)
					addAnimationByPrefix("sonicSturms"..i, "press"..q, "quant"..q.."note"..i.."press", 12, false)
					addAnimationByPrefix("sonicSturms"..i, "hit"..q, "quant"..q.."note"..i.."hit", 24, false)
				end
			else
				addAnimationByPrefix("sonicSturms"..i, "idle", "note"..i.."idle", 0, false)
				addAnimationByPrefix("sonicSturms"..i, "press", "note"..i.."press", 12, false)
				addAnimationByPrefix("sonicSturms"..i, "hit", "note"..i.."hit", 24, false)
			end
			scaleObject("sonicSturms"..i, 6, 6)
			setObjectCamera("sonicSturms"..i, "hud")
			setProperty("sonicSturms"..i..".antialiasing", false)
			setProperty("sonicSturms"..i..".alpha", getPropertyFromGroup("opponentStrums", i, "alpha"))
			addLuaSprite("sonicSturms"..i, false)
			setObjectOrder("sonicSturms"..i, getObjectOrder("strumLineNotes"))
		end
	end
end

function onUpdatePost()
	for i = 1,#getTextString("scoreBar") do
		local c = string.sub(getTextString("scoreBar"), i, i)
		scoreText[i] = c
	end

	for i = 1,#scoreGroup do
		setProperty("scoreNum"..i..".animation.frameIndex", scoreText[i])
		setProperty("scoreNum"..i..".color", 0x00FFFFFF)
		if score < 0 then
			setProperty("scoreNum"..i..".color", 0x00B53120)
		end
	end

	for i = 0,getProperty("opponentStrums.length")-1 do
		if getPropertyFromGroup("opponentStrums", i, "animation.curAnim.name") == "static" or getPropertyFromGroup("opponentStrums", i, "animation.curAnim.name") == "pressed" then
			setProperty("sonicSturms"..i..".visible", false)
			setPropertyFromGroup("opponentStrums", i, "visible", true)
		else
			setProperty("sonicSturms"..i..".visible", true)
			setPropertyFromGroup("opponentStrums", i, "visible", false)
		end
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if getDataFromSave("playerSettings", "quantNotes") == true and not lowQuality then
		local quant = string.match(getPropertyFromGroup("notes", id, "texture"),"_quants(.*)_")
		playAnim("sonicSturms"..noteData, "hit"..quant, true)
	else
		playAnim("sonicSturms"..noteData, "hit", true)
	end
	updateHitbox("sonicSturms"..noteData)
end