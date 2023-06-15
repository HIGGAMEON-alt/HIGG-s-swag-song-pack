local xx = 160 * 3
local yy = 81 * 3
local doTheMario = false
local dayTime = false

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	for i = 0, getProperty("unspawnNotes.length")-1 do
		if getPropertyFromGroup('unspawnNotes', i, "mustPress") == false then
			if getPropertyFromGroup("unspawnNotes", i, "noteType") == "GF Sing" then
				setPropertyFromGroup("unspawnNotes", i, "texture", "pixel/luigiNOTE_assets")
			elseif getPropertyFromGroup("unspawnNotes", i, "noteType") == "" then
				setPropertyFromGroup("unspawnNotes", i, "texture", "pixel/marioNOTE_assets")
			end
		end
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by Geometric")
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if not lowQuality then
		if getPropertyFromGroup("notes", id, "texture") == "pixel/marioNOTE_assets" then
			setPropertyFromGroup("opponentStrums", noteData, "texture", getPropertyFromGroup("notes", id, "texture"))
		elseif getPropertyFromGroup("notes", id, "texture") == "pixel/luigiNOTE_assets" then
			setPropertyFromGroup("opponentStrums", noteData, "texture", getPropertyFromGroup("notes", id, "texture"))
		end
	end
end

function onStepHit()
	-- Cloud Dance
	if week ~= "funkMix" and week ~= "funkMixDX" then
		if curStep == 1 or curStep == 636 then
			playAnim("platformAnim", "dancePrep", true)
			updateHitbox("platformAnim")
		end
	end
end

function onBeatHit()
	-- Time Skip Support
	if curBeat >= 160 and dayTime == false then
		dayTime = true
		doTweenAlpha("dayCycle", "skyDay", 1, 4, "linear")
	elseif curBeat >= 320 and doTheMario == false then
		doTheMario = true
		doTweenY("goBros", "bonus", -44 * 6, 2, "quadOut")
	end

	-- Cloud Dance
	if week ~= "funkMix" and week ~= "funkMixDX" then
		if curBeat > 0 and curBeat < 320 then
			playAnim("platformAnim", "dance", true)
			updateHitbox("platformAnim")
		elseif curBeat >= 320 then
			setProperty("platformAnim.visible", false)
		end
	end

	if not funkMixCam() then
		if curBeat == 256 then
			doTweenZoom("dramaticZoom", "camGame", 3.5, 26, 'linear')
		elseif curBeat == 320 then
			triggerEvent("Camera Follow Pos",xx,yy)
			setProperty("defaultCamZoom", 1 + 1/3 + 0.001)
			cancelTween("dramaticZoom")
		end
	end

	if curBeat == 96 or curBeat == 176 or curBeat == 208 or curBeat == 272 or curBeat == 304 then
		setProperty("iconLuigi.visible", true)
		setProperty("iconP2.visible", false)
		reloadHealthBarColors(0x00388700, nil)
	elseif curBeat == 160 or curBeat == 192 or curBeat == 256 or curBeat == 288 then
		setProperty("iconLuigi.visible", false)
		setProperty("iconP2.visible", true)
		reloadHealthBarColors(0x00b53120, nil)
	elseif curBeat == 320 then
		setProperty("platformAnim.visible", false)
	end
end

function reloadHealthBarColors(dadColor, bfColor)
	if dadColor ~= nil then
		setProperty("healthBarDAD.color", dadColor)
		setProperty("healthArrowDAD.color", dadColor)
	end
	if bfColor ~= nil then
		setProperty("healthBarBF.color", bfColor)
		setProperty("healthArrowBF.color", bfColor)
	end
end