local suff = ""

function onCreate()
	initSaveData("playerSettings", "funkmixadvance")
	if getDataFromSave("playerSettings", "powerUpHP") then
		addLuaScript("scripts/extra/Power-Up System")
		if difficulty >= 2 then
			setDataFromSave("songSaveData", "powerupNotes", false)
		else
			setDataFromSave("songSaveData", "powerupNotes", true)
		end
	end

	if difficulty == 0 then
		setProperty("healthLoss", 0)
	elseif difficulty >= 2 then
		setProperty("healthGain", 0)
		if songName ~= "2 PLAYER GAME" then
			setHealth(2)
		end
	end
	if difficulty >= 3 then
		if getProperty("practiceMode") == false then
			setProperty("instakillOnMiss", true)
		end
	end

	if songName == "Hyperactive Starblaze" then
		suff = "-kirby"
	end
end

function noteMissPress()
	if getDataFromSave("playerSettings", "powerUpHP") == false or (getDataFromSave("playerSettings", "powerUpHP") == true and difficulty == 0) then
		playSound("missnote"..suff)
	end
end

function onKeyPress(key)
	if getPropertyFromClass("ClientPrefs", "ghostTapping") and getProperty("unspawnNotes.length") == 0 then
		setProperty("boyfriend.specialAnim", true)
		if key == 0 then
			playAnim("boyfriend", "singLEFT", true)
		elseif key == 1 then
			playAnim("boyfriend", "singDOWN", true)
		elseif key == 2 then
			playAnim("boyfriend", "singUP", true)
		elseif key == 3 then
			playAnim("boyfriend", "singRIGHT", true)
		end
	end
end