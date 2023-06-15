function onCreate()
	initSaveData("playerSettings", "funkmixadvance")
end

function boolToNumber(bool)
	if bool == true then
		return 1
	else
		return 0
	end
end

function flicker(object)
	if getProperty(object..".exists") and getRandomBool(3) then
		setProperty(object..".exists", false)
	else
		setProperty(object..".exists", true)
	end
end

function onUpdate(elapsed)
	if flashingLights and math.floor(elapsed) % 12 == 0 and getTextString("isPaused") ~= "true" then
		flicker("scoreBar")
		flicker("accuracyText")
		flicker("accuracyText2")
		flicker("ratingIcon")
		flicker("flagIcon")
		flicker("healthBarBG")
		flicker("healthBar")
		if getDataFromSave("playerSettings", "powerUpHP") ~= true then
			flicker("iconP1")
			flicker("iconP2")
		end
		if getDataFromSave("playerSettings", "aspectRatio") ~= "4:3" then
			flicker("scoreTxt")
			flicker("timeBarBG")
			flicker("timeBar")
			flicker("botplayTxt")
			flicker("timeTxt")
		end

		if getRandomBool(8) then
			setProperty("dad.alpha", 0)
			setProperty("boyfriend.alpha", 0)
		else
			setProperty("dad.alpha", 1)
			setProperty("boyfriend.alpha", 1)
		end
	end
end