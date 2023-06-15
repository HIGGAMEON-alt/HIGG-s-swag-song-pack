local konami = {"UP", "UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT", "B", "A"}
local konamiCount = 1
local konamiComplete = false

function konamiSlot(int)
	return getPropertyFromClass("flixel.FlxG", "keys.justPressed."..konami[int])
end

function onUpdate()
	if getTextString("curMenuGlobal") == "1" or tonumber(getTextString("curMenuGlobal")) < 0 then
		if getTextString("curMenuGlobal") == "1" then
			if getPropertyFromClass("flixel.FlxG", "keys.justPressed."..konami[konamiCount]) then
				konamiCount = konamiCount + 1
			elseif konamiSlot(1,#konami) then
				konamiCount = 1
			end
			if konamiCount > #konami then
				konamiComplete = true
			end
		end

		if konamiComplete then
			konamiComplete = false
			setTextString("curMenuGlobal", -1)
			setPropertyFromClass("PlayState", "isStoryMode", true)
			setDataFromSave("songSaveData", "isStoryMode", false)
			setDataFromSave("songSaveData", "startIntro", true)
			setDataFromSave("songSaveData", "defPowerUpSet", getDataFromSave("playerSettings", "powerUpHP"))
			addLuaScript("scripts/extra/menus/GameboyStartup")
		end
	else
		konamiCount = 1
	end
end