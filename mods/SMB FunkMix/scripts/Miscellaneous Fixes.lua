camIsFixed = false
stopZooming = false

function onCreate()
	-- BF and GF
	initSaveData("playerSettings", "funkmixadvance")
	addCharacterToList("boyfriend", "boyfriend")
	addCharacterToList("girlfriend", "gf")
	if gfName == nil then
		gfName = getPropertyFromClass("PlayState", "SONG.gfVersion")
	end

	-- Camera
	defCamSpeed = getProperty("cameraSpeed")
	setProperty("cameraSpeed", math.huge)

	-- Song Intro Trigger
	if week ~= "funkMix" and week ~= "funkMixDX" and week ~= "funkMixMX" then
		addLuaScript("scripts/extra/Song Intro")
	end

	-- Mouse Visibility Fix
	setPropertyFromClass("flixel.FlxG", "mouse.visible", false)
end

function onCreatePost()
	-- BF and GF
	if getDataFromSave("playerSettings", "powerUpHP") == false then
		if boyfriendName == "bf" then
			triggerEvent("Change Character", "bf", "boyfriend")
		end
	end
	if gfName == "gf" then
		triggerEvent("Change Character", "gf", "girlfriend")
	end

	-- Hurt Note and Poison Note
	for i = 0,getProperty("unspawnNotes.length")-1 do
		if getPropertyFromGroup("unspawnNotes", i, "noteType") == "Hurt Note" or getPropertyFromGroup("unspawnNotes", i, "noteType") == "Poison Note" then
			setPropertyFromGroup("unspawnNotes", i, "ignoreNote", true)
			setPropertyFromGroup("unspawnNotes", i, "noteSplashTexture", "noteSplashes/pixel-hurt")
		end
	end
end

function onUpdatePost()
	if getDataFromSave("playerSettings", "powerUpHP") == false and not inGameOver then
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
			setProperty("iconP1.x", getProperty("healthDecor.x") - (7 * 6))
			setProperty("iconP2.x", getProperty("healthDecor.x") - (7 * 6))
			setProperty("iconP1.y", getProperty("healthDecor.y") + getProperty("healthDecor.height") - (21 * 6))
			setProperty("iconP2.y", getProperty("healthDecor.y") - (5 * 6) + 3)
			setProperty("iconP1.flipX", true)
		else
			setProperty("iconP1.x", getProperty("healthDecor.x") + getProperty("healthDecor.width") - (20 * 6) - 2)
			setProperty("iconP2.x", getProperty("healthDecor.x") - (4 * 6) - 2)
			setProperty("iconP1.y", getProperty("healthDecor.y") - (7 * 6))
			setProperty("iconP2.y", getProperty("healthDecor.y") - (7 * 6))
		end
		setObjectOrder("iconP1", getObjectOrder("healthArrowBF") + 1)
		setObjectOrder("iconP2", getObjectOrder("healthArrowDAD") + 1)
		setProperty("iconP1.scale.x", 0.5)
		setProperty("iconP2.scale.x", 0.5)
		setProperty("iconP1.scale.y", 0.5)
		setProperty("iconP2.scale.y", 0.5)
	end

	-- Note Splash Pixel Fix
	for i = 0,getProperty("grpNoteSplashes.length")-1 do
		setPropertyFromGroup("grpNoteSplashes", i, "antialiasing", false)
	end
end

function onStepHit()
	-- Camera
	if camIsFixed == false then
		camIsFixed = true
		setProperty("cameraSpeed", defCamSpeed)
	end
end

function opponentNoteHit()
	stopZooming = true
end

function onSectionHit()
	-- Cam Zooming Overhaul
	if stopZooming and getPropertyFromClass("PlayState", "camZooming") and getProperty("camGame.zoom") < 1.35 and getPropertyFromClass("ClientPrefs", "camZooms") then
		setProperty("camGame.zoom", getProperty("camGame.zoom") - 0.015 * getProperty("camZoomingMult"))
		setProperty("camHUD.zoom", getProperty("camHUD.zoom") - 0.03 * getProperty("camZoomingMult"))
	end
end

function onCountdownTick(tick)
	-- Camera
	if tick >= 0 then
		camIsFixed = true
		setProperty("cameraSpeed", defCamSpeed)
	end
end

function onEndSong()
	setProperty("vocals.volume", 0)
	return Function_Continue
end