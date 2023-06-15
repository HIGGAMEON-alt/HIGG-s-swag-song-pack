beatsUntilPepSpawn = -1
beatsUntilMaxSpawn = -1

function onBeatHit()
	if beatsUntilPepSpawn > 0 then
		beatsUntilPepSpawn = beatsUntilPepSpawn - 1
		if beatsUntilPepSpawn <= 0 then
			beatsUntilPepSpawn = 0
		end
	end
	if beatsUntilMaxSpawn > 0 then
		beatsUntilMaxSpawn = beatsUntilMaxSpawn - 1
		if beatsUntilMaxSpawn <= 0 then
			beatsUntilMaxSpawn = 0
		end
	end
end

function onUpdate()
	powerup = getDataFromSave("songSaveData", "powerState")
	if getDataFromSave("playerSettings", "powerUpHP") and getDataFromSave("songSaveData", "powerupNotes") then
		for i = 0, getProperty("unspawnNotes.length")-1 do
			if getPropertyFromGroup("unspawnNotes", i, "strumTime") - getPropertyFromClass("Conductor", "songPosition") < 3500 then
				if getPropertyFromGroup("unspawnNotes", i, "noteType") == "" and (beatsUntilPepSpawn == 0 or beatsUntilMaxSpawn == 0) and getPropertyFromGroup("unspawnNotes", i, "mustPress") and not getPropertyFromGroup("unspawnNotes", i, "isSustainNote") then
					if powerup < 5 then
						beatsUntilPepSpawn = 36
						setPropertyFromGroup("unspawnNotes", i, "noteType", "Pep-Drink Note")
					else
						beatsUntilPepSpawn = -1
					end
					if powerup < 3 then
						beatsUntilMaxSpawn = 72
						setPropertyFromGroup("unspawnNotes", i, "noteType", "Maxim Note")
					else
						beatsUntilMaxSpawn = -1
					end
					callPowerup()
				end
				if getPropertyFromGroup("unspawnNotes", i, "noteType") == "Pep-Drink Note" then
					setPropertyFromGroup("unspawnNotes", i, "texture", "kirby/pepdrinkNOTE_assets")
				elseif getPropertyFromGroup("unspawnNotes", i, "noteType") == "Maxim Note" then
					setPropertyFromGroup("unspawnNotes", i, "texture", "kirby/maximNOTE_assets")
				end
			end
		end
	end

	if keyJustPressed("reset") and getPropertyFromClass("ClientPrefs", "noReset") == false then
		if practice then
			if not powerupVisuals then
				callPowerup()
			end
		end
	end
end

function callPowerup()
	if powerup < 5 then
		beatsUntilPepSpawn = 36
	else
		beatsUntilPepSpawn = -1
	end
		
	if powerup < 3 then
		beatsUntilMaxSpawn = 72
	else
		beatsUntilMaxSpawn = -1
	end
end