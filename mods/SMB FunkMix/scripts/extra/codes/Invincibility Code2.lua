-- Reference used: https://www.consoledatabase.com/cheats/nes/supermariobros/
local gameGenie = {"U", "A", "T", "I", "U", "E"}
local gameGenieCount = 1
local gameGenieComplete = false

function genieSlot(int)
	return getPropertyFromClass("flixel.FlxG", "keys.justPressed."..gameGenie[int])
end

function onUpdate()
	if getTextString("curMenuGlobal") == "1" or tonumber(getTextString("curMenuGlobal")) < 0 then
		if getPropertyFromClass("flixel.FlxG", "keys.justPressed."..gameGenie[gameGenieCount]) then
			gameGenieCount = gameGenieCount + 1
		elseif genieSlot(1,#gameGenie) then
			gameGenieCount = 1
		end
		if gameGenieCount > #gameGenie then
			gameGenieComplete = true
		end
	else
		gameGenieCount = 1
	end
end

function onUpdatePost()
	if gameGenieComplete then
		if songName == "Funk Mix" or songName == "Funk Mix DX" then
			gameGenieComplete = false
			setTextString("curMenuGlobal", -1)

			gameGenieCount = 1
			setPropertyFromClass("PlayState", "isStoryMode", true)
			setDataFromSave("songSaveData", "isStoryMode", false)
			setPropertyFromClass("PlayState", "storyPlaylist", {songName, "balls", songName})
			makeLuaSprite("whiteFade", nil, 0, 0)
			makeGraphic("whiteFade", screenWidth, screenHeight, "FFFFFF")
			setProperty("whiteFade.alpha", 0)
			setObjectCamera("whiteFade", "other")
			addLuaSprite("whiteFade", false)

			doTweenAlpha("whiteFadeIn", "whiteFade", 1, 0.5, "linear")

			setPropertyFromClass("flixel.FlxG", "sound.music.volume", 0)

			playSound("sm64enterCourse", 1, "starSound")
			runTimer("starSound", 2.25)
		end
	end
end

function onTimerCompleted(tag)
	if tag == "starSound" then
		endSong()
	end
end