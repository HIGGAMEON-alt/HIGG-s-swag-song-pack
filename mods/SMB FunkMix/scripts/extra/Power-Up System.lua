beatsUntilSpawn = -1
damageCooldown = 0
powerup = 1
powerupVisuals = false
suffix = ""
skinPrefix = "pixel/"
getFlipX = nil
powerUpSound = "powerup"
powerDownSound = "power_down"
refillTo = powerup
refillTime = 0

function noDamageSongs()
	return songName ~= "Funk Mix" and songName ~= "Funk Mix DX" and songName ~= "Funk Mix MX" and songName ~= "Cutscene" and songName ~= "Options"
end

function onCreate()
	bfPrefix = boyfriendName
	setProperty("healthGain", 0)
	setProperty("healthLoss", 0)
	
	-- The blacklist of players who don't have unique power-up characters.
	if boyfriendName ~= "luigi-player" then
		powerup = 2
		powerupVisuals = true
	end
	if boyfriendName == "bf-kirby" then
		powerUpSound = "powerup-kirby"
		powerDownSound = "missnote-kirby"
	end
	arrowSkin = getPropertyFromClass("PlayState", "SONG.arrowSkin")
end

function onCreatePost()
	if boyfriendName == "bf" then
		bfPrefix = "boyfriend"
		triggerEvent("Change Character", "bf", "boyfriend")
	end

	if getPropertyFromClass("ClientPrefs", "optimization") == false or getPropertyFromClass("ClientPrefs", "optimization") == "optimization" then
		setProperty("healthBarBG.visible", false)
		setProperty("healthBar.visible", false)
		setProperty("iconP1.exists", false)
		setProperty("iconP2.exists", false)
	end

	-- Note that the songName variable is SUPER SPECIFIC! The casing of the letters, spaces, and hyphens matter.
	if songName == "2 PLAYER GAME" then
		powerup = 1
		powerupVisuals = true
	elseif songName == "balls" then
		powerup = 0
		powerupVisuals = false
		triggerEvent("Change Character", "bf", bfPrefix..suffix)
		if getProperty("practiceMode") == false and (getDataFromSave("gameGenie", "invincible") ~= true) then
			setProperty("instakillOnMiss", true)
		end
	elseif songName == "Green Screen" then
		powerup = 2
		powerupVisuals = false
		triggerEvent("Change Character", "bf", bfPrefix..suffix)
	elseif songName == "Hyperactive Starblaze" then
		powerup = 5
		powerupVisuals = false
		triggerEvent("Change Character", "bf", bfPrefix..suffix)
	end
	if difficulty >= 3 then
		powerup = 0
		powerupVisuals = false
	end

	-- Note Skins for Power-Ups
	skinPrefix = arrowSkin:gsub("NOTE_assets", "")
	if skinPrefix == "SONG.arrowSkin" then skinPrefix = "pixel/" end
end

function onUpdate(elapsed)
	if getProperty("powerup.animation.curAnim.name") ~= powerup then
		if powerup > 0 then
			playAnim("powerup", powerup)
		else
			playAnim("powerup", 0)
		end
		updateHitbox("powerup")
		setProperty("powerup.exists", true)
		if songName ~= "Green Screen" then
			setProperty("healthDecor.visible", false)
			setProperty("healthBarDAD.visible", false)
			setProperty("healthBarBF.visible", false)
		end
	end

	if damageCooldown > 0 and powerup >= 0 and songName ~= "Green Screen" and getTextString("isPaused") ~= "true" then
		setProperty("boyfriend.alpha", getPropertyFromClass("flixel.FlxG", "game.ticks") % 2)
		damageCooldown = damageCooldown - elapsed
		if damageCooldown <= 0 then
			damageCooldown = 0
			setProperty("boyfriend.alpha", 1)
		end
	elseif damageCooldown > 0 and powerup >= 0 and songName == "Green Screen" and flashingLights then
		setProperty("boyfriend.alpha", getPropertyFromClass("flixel.FlxG", "game.ticks") % 2)
		setProperty("dad.alpha", getPropertyFromClass("flixel.FlxG", "game.ticks") % 2)
		damageCooldown = damageCooldown - elapsed
		if damageCooldown <= 0 then
			damageCooldown = 0
			setProperty("boyfriend.alpha", 1)
			setProperty("dad.alpha", 1)
		end
	end

	if powerupVisuals then
		if powerup == 0 and boyfriendName ~= bfPrefix.."-small" then
			suffix = "-small"
			getFlipX = getProperty("boyfriend.flipX")
			getAnim = getProperty("boyfriend.animation.curAnim.name")
			getX = getProperty("boyfriend.x")
			getY = getProperty("boyfriend.y")
			triggerEvent("Change Character", "bf", bfPrefix..suffix)
			if bfPrefix == "bf-lakitu" or bfPrefix == "bf-wall" then
				if getProperty("boyfriend.x") ~= getX then
					setProperty("boyfriend.x", getX)
				end
				if getProperty("boyfriend.y") ~= getY then
					setProperty("boyfriend.y", getY)
				end
			end
			setProperty("boyfriend.flipX", getFlipX)
			playAnim("boyfriend", getAnim)
			setProperty("boyfriend.specialAnim", true)
			if getDataFromSave("songSaveData", "powerupNotes") then
				beatsUntilSpawn = 24
			end
		elseif powerup == 1 and boyfriendName ~= bfPrefix then
			suffix = ""
			getFlipX = getProperty("boyfriend.flipX")
			getAnim = getProperty("boyfriend.animation.curAnim.name")
			getX = getProperty("boyfriend.x")
			getY = getProperty("boyfriend.y")
			triggerEvent("Change Character", "bf", bfPrefix..suffix)
			if bfPrefix == "bf-lakitu" or bfPrefix == "bf-wall" then
				if getProperty("boyfriend.x") ~= getX then
					setProperty("boyfriend.x", getX)
				end
				if getProperty("boyfriend.y") ~= getY then
					setProperty("boyfriend.y", getY)
				end
			end
			setProperty("boyfriend.flipX", getFlipX)
			playAnim("boyfriend", getAnim)
			setProperty("boyfriend.specialAnim", true)
			if getDataFromSave("songSaveData", "powerupNotes") then
				beatsUntilSpawn = 48
			end
		elseif powerup == 2 and boyfriendName ~= bfPrefix.."-fire" then
			suffix = "-fire"
			getFlipX = getProperty("boyfriend.flipX")
			getAnim = getProperty("boyfriend.animation.curAnim.name")
			getX = getProperty("boyfriend.x")
			getY = getProperty("boyfriend.y")
			triggerEvent("Change Character", "bf", bfPrefix..suffix)
			if bfPrefix == "bf-lakitu" or bfPrefix == "bf-wall" then
				if getProperty("boyfriend.x") ~= getX then
					setProperty("boyfriend.x", getX)
				end
				if getProperty("boyfriend.y") ~= getY then
					setProperty("boyfriend.y", getY)
				end
			end
			setProperty("boyfriend.flipX", getFlipX)
			playAnim("boyfriend", getAnim)
			setProperty("boyfriend.specialAnim", true)
			beatsUntilSpawn = -1
		end
	else
		if boyfriendName ~= bfPrefix then
			triggerEvent("Change Character", "bf", bfPrefix..suffix)
		end
	end

	if powerup < 0 then
		if getProperty("practiceMode") then
			powerup = 0
		else
			setProperty("health", 0)
		end
	elseif powerup == 0 then
		setProperty("health", 0.001)
	elseif powerup >= 1 then
		setProperty("health", powerup)
	end

	if getProperty("health") > powerup and powerup ~= 0 then
		setProperty("health", powerup)
	end

	if getPropertyFromClass("ClientPrefs", "noReset") == false and keyJustPressed("reset") and getProperty("canReset") and not getProperty("inCutscene") and startedCountdown and not getProperty("endingSong") then
		if boyfriendName ~= "luigi-player" then
			if practice then
				if damageCooldown <= 0 and noDamageSongs() then
					playSound(powerDownSound)
				end
				if damageCooldown <= 0 then
					setProperty("health", 0.001)
					powerup = 0
				end
				if damageCooldown <= 0 then
					damageCooldown = 2
				end
				if not powerupVisuals then
					callPowerup()
				end
			else
				powerup = -1
			end
		end
	end

	if getDataFromSave("songSaveData", "powerupNotes") then
		for i = 0, getProperty("unspawnNotes.length")-1 do
			if getPropertyFromGroup("unspawnNotes", i, "strumTime") - getPropertyFromClass("Conductor", "songPosition") < 3500 then
				if getPropertyFromGroup("unspawnNotes", i, "noteType") == "" and beatsUntilSpawn == 0 and getPropertyFromGroup("unspawnNotes", i, "mustPress") and not getPropertyFromGroup("unspawnNotes", i, "isSustainNote") then
					if powerup == 0 then
						beatsUntilSpawn = 24 -- These are extra percautions to make sure that you're not swarmed with the power-up.
						setPropertyFromGroup("unspawnNotes", i, "noteType", "Power-Up Note")
					elseif powerup == 1 then
						beatsUntilSpawn = 48
						setPropertyFromGroup("unspawnNotes", i, "noteType", "Power-Up Note")
					else
						beatsUntilSpawn = -1
					end
				end
				if getPropertyFromGroup("unspawnNotes", i, "noteType") == "Power-Up Note" then
					if powerup == 0 then
						setPropertyFromGroup("unspawnNotes", i, "texture", skinPrefix.."shroomNOTE_assets")
					elseif powerup == 1 then
						setPropertyFromGroup("unspawnNotes", i, "texture", skinPrefix.."flowerNOTE_assets")
					end
				end
			end
		end
	end

	if songName == "Boo Blitz" then
		if getProperty("fireball1.animation.name") == "shoot" then
			hitDetection()
		end
	end

	if refillTime > 0 then
		refillTime = refillTime - elapsed
		if refillTime <= 0 then
			if powerup ~= refillTo then
				refillTime = 0.15
				powerup = powerup + 1
				playSound(powerUpSound)
			end
		end
	end

	setDataFromSave("songSaveData", "powerState", powerup)
end

function callPowerup()
	if powerup == 0 then
		if getDataFromSave("songSaveData", "powerupNotes") then
			beatsUntilSpawn = 24
		end
	elseif powerup == 1 then
		if getDataFromSave("songSaveData", "powerupNotes") then
			beatsUntilSpawn = 48
		end
	elseif powerup == 2 then
		beatsUntilSpawn = -1
	end
end

function onGameOver()
	playAnim("powerup", 0)
end

function onGameOverStart()
	damageCooldown = 0
end

function onBeatHit()
	if beatsUntilSpawn > 0 then
		beatsUntilSpawn = beatsUntilSpawn - 1
		if beatsUntilSpawn <= 0 then
			beatsUntilSpawn = 0
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == "Power-Up Note" then
		if powerup >= 0 then
			playSound(powerUpSound)
			powerup = powerup + 1
		end
		if not powerupVisuals then
			callPowerup()
		end
	end
	if noteType == "Pep-Drink Note" then
		if powerup >= 0 and powerup < 5 then
			refillTo = powerup + 2
			if refillTo > 5 then
				refillTo = 5
			end
			refillTime = 0.15
			powerup = powerup + 1
		end
		playSound(powerUpSound)
	end
	if noteType == "Maxim Note" then
		if powerup >= 0 and powerup < 5 then
			refillTo = 5
			refillTime = 0.15
			powerup = powerup + 1
		end
		playSound(powerUpSound)
	end
end

function noteMiss(id, noteData, noteType)
	if difficulty > 0 and (getDataFromSave("gameGenie", "invincible") == false or getDataFromSave("gameGenie", "invincible") == "invincible") and noteType ~= "Power-Up Note" and noteType ~= "1-Up Note" and noteType ~= "Pep-Drink Note" and noteType ~= "Maxim Note" then
		if powerup < 0 then
			setProperty("boyfriend2.visible", false)
		end
		if boyfriendName ~= "luigi-player" then
			if damageCooldown <= 0 and powerup > 0 then
				playSound(powerDownSound)
			end
		end

		if damageCooldown <= 0 and powerup > 0 then
			powerup = powerup - 1
			refillTo = refillTo - 1
		elseif damageCooldown <= 0 and powerup == 0 and practice == false then
			powerup = -1
		end

		if damageCooldown <= 0 and powerup >= 0 then
			damageCooldown = 2
		end

		if not powerupVisuals then
			callPowerup()
		end
	end
end

function noteMissPress()
	if noDamageSongs() then
		if difficulty > 0 and (getDataFromSave("gameGenie", "invincible") == false or getDataFromSave("gameGenie", "invincible") == "invincible") and getTextString("isPaused") ~= "true" then
			if powerup < 0 then
				setProperty("boyfriend2.visible", false)
			end
			if boyfriendName ~= "luigi-player" then
				if damageCooldown <= 0 and powerup > 0 then
					playSound(powerDownSound)
				end
			end
	
			if damageCooldown <= 0 and powerup > 0 then
				powerup = powerup - 1
				refillTo = refillTo - 1
			elseif damageCooldown <= 0 and powerup == 0 and practice == false then
				powerup = -1
			end

			if damageCooldown <= 0 and powerup >= 0 then
				damageCooldown = 2
			end

			if not powerupVisuals then
				callPowerup()
			end
		end
	end
end

-- For "Boo Blitz"
function hitDetection()
	if difficulty > 0 then
		if damageCooldown <= 0 then
			for i = 1,6 do
				if getProperty("fireball"..i..".exists") and (getProperty("bfHitbox.x") + (8 * 6)) > getProperty("fireball"..i..".x") then
					if getProperty("bfHitbox.x") < getProperty("fireball"..i..".x") + (16 * 6) then
						if powerup > 0 then
							damageCooldown = 2
							playSound(powerDownSound)
						end
						if not powerupVisuals then
							callPowerup()
						end
						powerup = powerup - 1
						break
					end
				end
			end
		end
	end
end

function onEvent(n,v1,v2)
	if n == "Powerup Visuals" then
		bfPrefix = v1
		if v2 ~= "" then
			powerup = tonumber(v2)
		end
		triggerEvent("Change Character", "bf", bfPrefix..suffix)
	end
end