local velocity = 0
local prefix = "pixel/"
local oneupArray = {}
local wideScreen = (26 * 6) + 4
local wideScreen2 = 0
local moveByX = 0
deathSuff = ""
gameoverSuff = ""
overConfirm = "title_confirm"
lifeupSuff = ""

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or week == "funkMixMX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function gameOverBlacklist()
	return not (songName == "Funk Mix" or songName == "Funk Mix DX" or songName == "Funk Mix MX" or songName == "Cutscene" or songName == "Options" or songName == "Green Screen")
end

function onCreate()
	initSaveData("playerSettings", "funkmixadvance")
	initSaveData("songSaveData", "funkmixadvance")
	bfName = boyfriendName
	daBF = boyfriendName
	lifeBF = "bf"
	if daBF == "bf-water" or daBF == "bf-captured" or daBF == "bf-lakitu" then
		daBF = "bf"
	elseif daBF == "mario-ccc" then
		daBF = "mario"
		lifeBF = "mario"
	elseif daBF == "luigi-player" then
		daBF = "luigi"
		lifeBF = "luigi"
	elseif daBF == "bf-bSide" then
		daBF = "advance/b-side/bf"
		lifeBF = boyfriendName
	elseif daBF == "bf-kirby" then
		daBF = "advance/kirby/bf"
		deathSuff = "-kirby"
		gameoverSuff = "-kirby"
		lifeupSuff = "-kirby"
		overConfirm = "door_open-kirby"
		if getDataFromSave("playerSettings", "compatMode") == true then
			deathSuff = "-kirbyAlt"
		end
	elseif daBF == "bf-pcport" then
		daBF = "advance/pcport/bf"
		lifeBF = boyfriendName
		deathSuff = "-pcport"
		gameoverSuff = "-pcport"
		overConfirm = "death_confirm-pcport1"
	elseif daBF == "bf-smb3" then
		daBF = "advance/smb3/bf"
		deathSuff = "-smb3"
		gameoverSuff = "-smb3"
	elseif daBF == "skyblue" then
		daBF = "advance/skyblue"
		lifeBF = boyfriendName
	elseif daBF == "bf-portal" or daBF == "bf-glitch" then
		lifeBF = boyfriendName
	end

	if downscroll and songName ~= "Hyperactive Starblaze" then
		downscrool = - (17 * 6)
	end

	if getDataFromSave("playerSettings", "aspectRatio") ~= "4:3" or getDataFromSave("playerSettings", "showBorder") == true then
		wideScreen = 0
	end

	arrowSkin = getPropertyFromClass("PlayState", "SONG.arrowSkin")
	prefix = arrowSkin:gsub("NOTE_assets", "")
	if prefix == "SONG.arrowSkin" then prefix = "" end

	if getDataFromSave("playerSettings", "lifeStart") > 0 then
		if (not isStoryMode and (getPropertyFromClass("PlayState", "deathCounter") == 0 or songName == "Options")) or (isStoryMode and (songName == "Funk Mix" or songName == "Funk Mix DX" or songName == "Funk Mix MX")) then
			setDataFromSave("songSaveData", "deathCount", 0)
			setDataFromSave("songSaveData", "lifeCount", getDataFromSave("playerSettings", "lifeStart"))
			setDataFromSave("songSaveData", "disable1UP", false)
			setPropertyFromClass("PlayState", "deathCounter", 0)
		end
	else
		setDataFromSave("songSaveData", "deathCount", 0)
		setDataFromSave("songSaveData", "lifeCount", 0)
		setDataFromSave("songSaveData", "disable1UP", true)
	end

	if getDataFromSave("songSaveData", "lifeCount") >= 127 then
		setDataFromSave("songSaveData", "disable1UP", true)
	end

	if getDataFromSave("songSaveData", "lifeCount") > 1 or getDataFromSave("playerSettings", "lifeStart") <= 0 then
		setPropertyFromClass("GameOverSubstate", "characterName", "retry")
	else
		setPropertyFromClass("GameOverSubstate", "characterName", "gameover")
	end
	setPropertyFromClass("GameOverSubstate", "deathSoundName", "")
	setPropertyFromClass("GameOverSubstate", "loopSoundName", "")
	setPropertyFromClass("GameOverSubstate", "endSoundName", "")
end

function onCountdownStarted()
	if getDataFromSave("playerSettings", "lifeStart") > 0 and gameOverBlacklist() then
		if getDataFromSave("playerSettings", "aspectRatio") == "4:3" and getDataFromSave("playerSettings", "showBorder") ~= true then
			wideScreen2 = (26 * 6) + 4
		end

		makeLuaSprite("lifeCount", "ui/pixel/lifeCount", 0, 0)
		setProperty("lifeCount.antialiasing", false)
		updateHitbox("lifeCount")
		setObjectCamera("lifeCount", "other")
		screenCenter("lifeCount")
		setProperty("lifeCount.x", getProperty("lifeCount.x") - wideScreen2)
		addLuaSprite("lifeCount", true)

		makeLuaSprite("lifeIcon", "icons/life-"..lifeBF, getProperty("lifeCount.x"), getProperty("lifeCount.y"))
		setProperty("lifeIcon.antialiasing", false)
		updateHitbox("lifeIcon")
		setObjectCamera("lifeIcon", "other")
		addLuaSprite("lifeIcon", true)

		if getDataFromSave("songSaveData", "lifeCount") < 10 then
			makeLuaText("lifeTxt", getDataFromSave("songSaveData", "lifeCount"), 0, getProperty("lifeCount.x") + 288 - 3, getProperty("lifeCount.y") + 24 - 3)
		elseif getDataFromSave("songSaveData", "lifeCount") >= 10 then
			makeLuaText("lifeTxt", getDataFromSave("songSaveData", "lifeCount"), 0, getProperty("lifeCount.x") + 240 - 3, getProperty("lifeCount.y") + 24 - 3)
		end
		setTextSize("lifeTxt", 8 * 6)
		setTextFont("lifeTxt", "smb1.ttf")
		setProperty("lifeTxt.antialiasing", false)
		setObjectCamera("lifeTxt", "other")
		addLuaText("lifeTxt")
	end
end

function onSongStart()
	removeLuaSprite("lifeCount", true)
	removeLuaSprite("lifeIcon", true)
	removeLuaText("lifeTxt")
end

function onCreatePost()
	if getDataFromSave("playerSettings", "debugInfo") == true and gameOverBlacklist() then
		makeLuaText("bfname", bfName, 0, 0, 0)
		setObjectCamera("bfname", "other")
		addLuaText("bfname")
		makeLuaText("dabf", daBF, 0, 0, 16)
		setObjectCamera("dabf", "other")
		addLuaText("dabf")
		makeLuaText("boyfriendname", boyfriendName, 0, 0, 32)
		setObjectCamera("boyfriendname", "other")
		addLuaText("boyfriendname")
	end

	if getDataFromSave("playerSettings", "lifeStart") > 0 and gameOverBlacklist() then
		if getDataFromSave("playerSettings", "debugInfo") == true then
			makeLuaText("lifeStarted", getDataFromSave("playerSettings", "lifeStart"), 0, 0, 32)
			setObjectCamera("lifeStarted", "other")
			addLuaText("lifeStarted")
			makeLuaText("lifeCounted", getDataFromSave("songSaveData", "lifeCount"), 0, 0, 48)
			setObjectCamera("lifeCounted", "other")
			addLuaText("lifeCounted")
			makeLuaText("deathCounted", getDataFromSave("songSaveData", "deathCount"), 0, 0, 64)
			setObjectCamera("deathCounted", "other")
			addLuaText("deathCounted")
		end
	end

	if getDataFromSave("playerSettings", "lifeStart") > 0 and getDataFromSave("songSaveData", "disable1UP") == false then
		for i = 0,getProperty("unspawnNotes.length")-1 do
			if getPropertyFromGroup("unspawnNotes", i, "mustPress") and not getPropertyFromGroup("unspawnNotes", i, "isSustainNote") and (getPropertyFromGroup("unspawnNotes", i, "noteType") == "" or getPropertyFromGroup("unspawnNotes", i, "noteType") == "GF Sing" or getPropertyFromGroup("unspawnNotes", i, "noteType") == "2 Player Note") then
				oneupArray[#oneupArray+1] = i
			end
		end
		setPropertyFromGroup("unspawnNotes", oneupArray[getRandomInt(1,#oneupArray)], "noteType", "1-Up Note")
		for i = 0,getProperty("unspawnNotes.length")-1 do
			if getPropertyFromGroup("unspawnNotes", i, "noteType") == "1-Up Note" then
				setPropertyFromGroup("unspawnNotes", i, "texture", prefix.."1upNOTE_assets")
				if getDataFromSave("playerSettings", "powerUpHP") == false then
					setPropertyFromGroup("unspawnNotes", i, "missHealth", 0)
				end
			end
		end
		if getDataFromSave("playerSettings", "debugInfo") == true and songName ~= "Funk Mix" and songName ~= "Funk Mix DX" and songName ~= "Funk Mix MX" and songName ~= "Cutscene" and songName ~= "Options" then
			for i = 0,getProperty("unspawnNotes.length")-1 do
				if getPropertyFromGroup("unspawnNotes", i, "noteType") == "1-Up Note" then
					makeLuaText("1upIndicator", i, 0, 0, 80)
					setObjectCamera("1upIndicator", "other")
					addLuaText("1upIndicator")
					break
				end
			end
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == "1-Up Note" then
		setDataFromSave("songSaveData", "deathCount", getDataFromSave("songSaveData", "deathCount") - 1)
		setDataFromSave("songSaveData", "lifeCount", getDataFromSave("playerSettings", "lifeStart") - getDataFromSave("songSaveData", "deathCount"))
		setDataFromSave("songSaveData", "disable1UP", true)
		playSound("1up"..lifeupSuff)
		if getDataFromSave("playerSettings", "debugInfo") == true then
			setTextString("lifeCounted", getDataFromSave("songSaveData", "lifeCount"))
			setTextString("deathCounted", getDataFromSave("songSaveData", "deathCount"))
			removeLuaText("1upIndicator")
		end
		setPropertyFromClass("PlayState", "deathCounter", getPropertyFromClass("PlayState", "deathCounter") - 1)
	end
end

function onEndSong()
	setDataFromSave("songSaveData", "disable1UP", false)
	if (isStoryMode and (songName == "Lethal Lava Lair" or songName == "Koopa Armada")) or not isStoryMode then
		setDataFromSave("songSaveData", "deathCount", 0)
		setDataFromSave("songSaveData", "lifeCount", getDataFromSave("playerSettings", "lifeStart"))
	end
	return Function_Continue
end

function onUpdate()
	if inGameOver then
		if getProperty("boyfriend.animation.curAnim.name") == "firstDeath" then
			playAnim("boyfriend", "secondDeath", false)
		end
		if keyJustPressed("back") then
			cancelTimer("restartWeek")
			setPropertyFromClass("PlayState", "seenCutscene", false)
			exitSong(false)
		end
	end
end

function onUpdatePost()
	xPosition = getProperty("boyfriend.x")
	setTextString("bfname", bfName)
	setTextString("dabf", daBF)
	setTextString("boyfriendname", boyfriendName)
	if not inGameOver then
		if not funkMixCam() then
			moveByX = -12*6
			yPosition = getProperty("boyfriend.y") - 9*6
			if boyfriendName == "boyfriend-small" or bfName == "bf-captured" or boyfriendName == "bf-glitch-small" or boyfriendName == "bf-smm-small" or boyfriendName == "bf-smb3-small" then
				moveByX = moveByX - 1
			elseif boyfriendName == "boyfriend" or boyfriendName == "boyfriend-fire" or boyfriendName == "bf-glitch" or boyfriendName == "bf-glitch-fire" or boyfriendName == "bf-smm" or boyfriendName == "bf-smm-fire" or boyfriendName == "bf-smb3" or boyfriendName == "bf-smb3-fire" then
				moveByX = moveByX + 1 - 6
			elseif bfName == "bf-water" then
				moveByX = moveByX + 2
				yPosition = yPosition + (2*6)
			elseif bfName == "bf-portal" then
				moveByX = moveByX - 3*6 + 1
				yPosition = yPosition - 3*6
				if boyfriendName == "bf-portal-small" then
					moveByX = moveByX - 6
				end
			elseif bfName == "bf-lakitu" then
				moveByX = moveByX + 1*6 - 2.5
				yPosition = yPosition + 1*6 + 1
			elseif bfName == "mario-ccc" then
				moveByX = moveByX + 8*6
				yPosition = yPosition + 18*6 + 4*6
			elseif bfName == "luigi-player" then
				moveByX = moveByX + 8*6 - 1
				yPosition = yPosition + 3*6 + 12*6
			elseif bfName == "bf-pcport-flip" then
				moveByX = moveByX - 5
				if boyfriendName == "bf-pcport-flip-small" then
					moveByX = moveByX + 4
				end
			elseif bfName == "bf-kirby" then
				moveByX = moveByX - 1*6 + 1.5
			elseif bfName == "skyblue" then
				moveByX = moveByX + 4
				yPosition = yPosition + 4*6
			end
		else
			moveByX = 14*6 - wideScreen
			yPosition = getProperty("boyfriend.y") + 19*6
			if boyfriendName == "boyfriend-small" or boyfriendName == "bf-glitch-small" or boyfriendName == "bf-smm-small" or boyfriendName == "bf-bSide-small" or boyfriendName  == "bf-smb3-small" then
				yPosition = yPosition + 1
			elseif boyfriendName == "boyfriend" or boyfriendName == "boyfriend-fire" or boyfriendName == "bf-glitch" or boyfriendName == "bf-glitch-fire" or boyfriendName == "bf-smm" or boyfriendName == "bf-smm-fire" or boyfriendName == "bf-bSide" or boyfriendName == "bf-bSide-fire" or boyfriendName == "bf-smb3" or boyfriendName == "bf-smb3-fire" then
				moveByX = moveByX - 1
				yPosition = yPosition - 1*6 + 1
			elseif bfName == "bf-captured" then
				moveByX = moveByX + 3
			elseif bfName == "bf-water" then
				yPosition = yPosition + 6
			elseif bfName == "bf-portal" then
				moveByX = moveByX - 2*6 - 1
				yPosition = yPosition - 3*6
				if boyfriendName == "bf-portal-small" then
					moveByX = moveByX - 6
				end
			elseif bfName == "bf-chase" then
				moveByX = moveByX + 2
				yPosition = yPosition + 6*6
			elseif bfName == "bf-wall" then
				moveByX = moveByX + 11*6
				yPosition = yPosition + 32*6
			elseif bfName == "bf-lakitu" then
				moveByX = moveByX + 2*6 - 3
				yPosition = yPosition + 1*6
			elseif bfName == "mario-ccc" then
				moveByX = moveByX + 8*6 + 3
				yPosition = yPosition + 18*6 + 4*6
			elseif bfName == "luigi-player" then
				moveByX = moveByX + 8*6 + 2
				yPosition = yPosition + 3*6 + 12*6
			elseif bfName == "bf-pcport-flip" then
				moveByX = moveByX - 7
				if boyfriendName == "bf-pcport-flip-small" then
					moveByX = moveByX + 4
				end
			elseif bfName == "bf-chase" then
				moveByX = moveByX + 2
				yPosition = yPosition + 6*6
			elseif bfName == "bf-wall" then
				moveByX = moveByX + 11*6
				yPosition = yPosition + 32*6
			elseif bfName == "skyblue" then
				moveByX = moveByX + 3
				yPosition = yPosition + 4*6
			end
			yPosition = yPosition + downscrool
		end
		setTextString("boyfriendname", moveByX)
	else
		if getProperty("boyfriend.animation.curAnim.name") == "secondDeath" then
			if getProperty("boyfriend.animation.curAnim.curFrame") == getProperty("boyfriend.animation.curAnim.numFrames") - 1 then
				setProperty("boyfriend.animation.curAnim.paused", true)
			end
		end
	end
end

function onGameOver()
	stopSound("countdown3")
	stopSound("countdown2")
	stopSound("countdown1")
	stopSound("countdownGo")
	setPropertyFromClass("PlayState", "SONG.validScore", false)
	if songName ~= "Green Screen" and getDataFromSave("songSaveData", "lifeCount") > 1 then
		setPropertyFromClass("PlayState", "deathCounter", getPropertyFromClass("PlayState", "deathCounter") + 1)
	end
	setDataFromSave("songSaveData", "deathCount", getDataFromSave("songSaveData", "deathCount") + 1)
	setDataFromSave("songSaveData", "lifeCount", getDataFromSave("playerSettings", "lifeStart") - getDataFromSave("songSaveData", "deathCount"))
	setDataFromSave("songSaveData", "disable1UP", false)
	if getDataFromSave("playerSettings", "debugInfo") == true then
		setTextString("lifeCounted", getDataFromSave("songSaveData", "lifeCount"))
		setTextString("deathCounted", getDataFromSave("songSaveData", "deathCount"))
	end
	if getDataFromSave("playerSettings", "compatMode") == false and gameOverBlacklist() and getDataFromSave("songSaveData", "lifeCount") ~= 0 and getDataFromSave("playerSettings", "lifeStart") >= 0 then
		if bfName == "bf-kirby" then
			timeUntilStart = 1
			timeUntilReset = 3.5
			timeUntilRotate = 0.15
		elseif bfName == "bf-smb3" then
			timeUntilStart = 0.4
			timeUntilReset = 3.25
		else
			timeUntilStart = 0.4
			timeUntilReset = 3
		end

		openCustomSubstate("funkMixGameOver", true)
		setProperty("boyfriend.visible", false)
		playSound("death"..deathSuff, 1, "death")
		return Function_Stop
	else
		setProperty("camGame.zoom", 1)
		setProperty("cameraSpeed", math.huge)
		return Function_Continue
	end
end

function onGameOverStart()
	if getDataFromSave("songSaveData", "lifeCount") == 0 then
		setDataFromSave("songSaveData", "deathCount", 0)
		setDataFromSave("songSaveData", "disable1UP", false)
		playSound("gameover"..gameoverSuff, 1, "gameover")
	else
		playSound("death"..deathSuff, 1, "death")
	end
	if daBF == "advance/pcport/bf" and getDataFromSave("songSaveData", "lifeCount") == 0 then
		overConfirm = "death_confirm-pcport2"
	end
	setPropertyFromClass("flixel.FlxG", "camera.x", 0)
	setPropertyFromClass("flixel.FlxG", "camera.y", 0)
	screenCenter("boyfriend")
end

function onGameOverConfirm(retry)
	stopSound("death")
	stopSound("gameover")
	if retry then
		playSound(overConfirm)
		if getDataFromSave("playerSettings", "lifeStart") > 0 and getDataFromSave("songSaveData", "lifeCount") <= 0 then
			if isStoryMode then
				if songName == "Mushroom Plains" or songName == "Bricks and Lifts" or songName == "Lethal Lava Lair" then
					if week == "funkMix" then
						setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Mushroom Plains", "Bricks and Lifts", "Lethal Lava Lair", "Funk Mix"})
					elseif week == "funkMixDX" then
						setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Cutscene", "Mushroom Plains", "Cutscene", "Bricks and Lifts", "Cutscene", "Lethal Lava Lair", "Cutscene", "Funk Mix DX"})
					else
						setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Mushroom Plains", "Bricks and Lifts", "Lethal Lava Lair"})
					end
					setDataFromSave("songSaveData", "sceneNum", 0)
				end
				if songName == "Deep Deep Voyage" or songName == "Hop-Hop Heights" or songName == "Koopa Armada" then
					if week == "funkMixDX" then
						setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Cutscene", "Deep Deep Voyage", "Cutscene", "Hop-Hop Heights", "Cutscene", "Koopa Armada", "Cutscene", "Funk Mix DX"})
					else
						setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Deep Deep Voyage", "Hop-Hop Heights", "Koopa Armada"})
					end
					setDataFromSave("songSaveData", "sceneNum", 3)
				end
			end
		end
		runTimer("restartWeek", 2.68)
	end
end

function onTimerCompleted(tag)
	if tag == "restartWeek" then
		if isStoryMode and (week == "funkMix" or week == "funkMixDX" or week == "funkMixMX") then
			if getDataFromSave("songSaveData", "isStoryMode") == false or (getDataFromSave("playerSettings", "lifeStart") > 0 and getDataFromSave("songSaveData", "lifeCount") > 0) then
				restartSong(true)
			else
				if getDataFromSave("playerSettings", "lifeStart") > 0 and getDataFromSave("songSaveData", "lifeCount") <= 0 then
					setDataFromSave("songSaveData", "lifeCount", getDataFromSave("playerSettings", "lifeStart"))
				end
				endSong()
			end
		else
			if getDataFromSave("playerSettings", "lifeStart") > 0 and getDataFromSave("songSaveData", "lifeCount") <= 0 then
				setDataFromSave("songSaveData", "lifeCount", getDataFromSave("playerSettings", "lifeStart"))
			end
			restartSong(true)
		end
	end
end

function onCustomSubstateCreate(name)
	if name == "funkMixGameOver" then
		removeLuaSprite("lifeCount", true)
		removeLuaSprite("lifeIcon", true)
		removeLuaText("lifeTxt")

		makeLuaSprite("boyfriendDead", "characters/"..daBF.."-dead", xPosition + moveByX, 0)
		scaleObject("boyfriendDead", 6, 6)
		setProperty("boyfriendDead.antialiasing", false)
		if funkMixCam() then
			if getDataFromSave("playerSettings", "showcaseCam") == true then
				setObjectCamera("boyfriendDead", "other")
				addLuaSprite("boyfriendDead", false)
			else
				setObjectCamera("boyfriendDead", "hud")
				setObjectOrder("boyfriendDead", getObjectOrder("accuracyText2") + 1)
				addLuaSprite("boyfriendDead", false)
			end
		else
			addLuaSprite("boyfriendDead", true)
		end
	end
end

function onCustomSubstateUpdatePost(name, elapsed)
	if name == "funkMixGameOver" then
		timeUntilReset = timeUntilReset - elapsed
		if timeUntilReset <= 0 or keyJustPressed("accept") then
			restartSong(true)
		elseif keyJustPressed("back") then
			setDataFromSave("songSaveData", "disable1UP", false)
			setPropertyFromClass("PlayState", "deathCounter", 0)
			setPropertyFromClass("PlayState", "seenCutscene", false)
			if week == "funkMix" then
				setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix"})
				endSong()
			elseif week == "funkMixDX" then
				setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix DX"})
				endSong()
			elseif week == "funkMixMX" then
				setPropertyFromClass("PlayState", "storyPlaylist", {songName, "Funk Mix MX"})
				endSong()
			else
				stopSound("death")
				exitSong(false)
			end
		end

		if timeUntilStart > 0 then
			timeUntilStart = timeUntilStart - elapsed
			if timeUntilStart <= 0 then
				timeUntilStart = 0
				velocity = -750
				removeLuaSprite("redScreen", true)
			end
		else
			if songName == "Wrong Warp" then
				velocity = velocity - (12.5 * 130 * elapsed)
			else
				velocity = velocity + (12.5 * 130 * elapsed)
			end
		end	

		yPosition = yPosition + velocity * elapsed
		setProperty("boyfriendDead.y", math.floor(yPosition / 6) * 6)

		if bfName == "bf-kirby" and timeUntilStart <= 0 then
			timeUntilRotate = timeUntilRotate - elapsed
			if timeUntilRotate <= 0 then
				timeUntilRotate = 0.15
				if not getProperty("boyfriendDead.flipX") and not getProperty("boyfriendDead.flipY") then
					setProperty("boyfriendDead.flipY", true)
				elseif not getProperty("boyfriendDead.flipX") and getProperty("boyfriendDead.flipY") then
					setProperty("boyfriendDead.x", getProperty("boyfriendDead.x") - 1)
					setProperty("boyfriendDead.flipX", true)
				elseif getProperty("boyfriendDead.flipX") and getProperty("boyfriendDead.flipY") then
					setProperty("boyfriendDead.flipY", false)
				elseif getProperty("boyfriendDead.flipX") and not getProperty("boyfriendDead.flipY") then
					setProperty("boyfriendDead.x", getProperty("boyfriendDead.x") + 1)
					setProperty("boyfriendDead.flipX", false)
				end
			end
		end
	end
end

function onEvent(name, value1, value2)
	if name == "Change Character" and (value1 == "bf" or value1 == "boyfriend") then
		bfName = value2
		bfName = bfName:gsub("-fire", "")
		bfName = bfName:gsub("-small", "")
	end
end