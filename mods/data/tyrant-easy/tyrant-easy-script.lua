function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	initSaveData("playerSettings", "funkmixadvance")
	setProperty("dad.exists", false)
	prevDifficulty = getPropertyFromClass("PlayState", "storyDifficulty")
end

function onBeatHit()
	if curBeat == 549 then
		doTweenY("curtainCall", "curtains", -67*6, 0.45, "linear")
	end
end

function onTweenCompleted(tag)
	if tag == "outOfContext" then
		removeLuaSprite("contextBlack", true)
		removeLuaSprite("letter", true)
		removeLuaText("conTxtA")
		removeLuaText("conTxtB")
	end
end

function onPause()
	setPropertyFromClass("PlayState", "SONG.song", "Tyrant")
end

function onEndSong()
	setPropertyFromClass("PlayState", "SONG.song", "Tyrant")
end

function onResume()
	setPropertyFromClass("PlayState", "SONG.song", "Tyrant Easy")
end

function onDestroy()
	if getPropertyFromClass("PlayState", "storyDifficulty") ~= prevDifficulty then
		setPropertyFromClass("PlayState", "SONG.song", "Tyrant")
	else
		setPropertyFromClass("PlayState", "SONG.song", "Tyrant Easy")
	end
end