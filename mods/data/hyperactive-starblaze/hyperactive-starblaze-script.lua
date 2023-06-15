local xx = 160 * 3
local yy = 81 * 3
local metaKnightIn = false
local metalKnight = false

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	setDataFromSave("songSaveData", "powerupNotes", false)
	loadGraphic("border", "borders/kirbys-adventure")
end

function onCreatePost()
	metaKnightOgY = getProperty("gf.y")
	setProperty("gf.y", metaKnightOgY - 16*5*6)
	metaKnightNewY = getProperty("gf.y")
	setProperty("JukeBoxTag.color", 0x00541e02)
	if getDataFromSave("songSaveData", "lifeCount") > 1 or getDataFromSave("playerSettings", "lifeStart") <= 0 then
		setPropertyFromClass("GameOverSubstate", "characterName", "retry-kirby")
	else
		setPropertyFromClass("GameOverSubstate", "characterName", "gameover-kirby")
	end
	if getDataFromSave("playerSettings", "pauseMenu") == true then
		if getPropertyFromClass("PlayState", "seenCutscene") then
			makeLuaSprite("restartBox", nil, 0, 0)
			makeGraphic("restartBox", screenWidth, screenHeight, "000000")
			setObjectCamera("restartBox", "other")
			addLuaSprite("restartBox", true)
			doTweenAlpha("resetState", "restartBox", 0, 0.25, "linear")
		else
			setPropertyFromClass("PlayState", "seenCutscene", true)
		end
	end
end

function onUpdatePost()
	if getProperty("gf.animation.curAnim.name") == "spinBounce" and getProperty("gf.animation.curAnim.finished") then
		if metaKnightIn then
			playAnim("gf", "spin")
			setProperty("gf.specialAnim", true)
			doTweenY("metaKnightExit", "gf", metaKnightNewY, 0.31, "linear")
			metaKnightIn = false
		else
			playAnim("gf", "enter")
			setProperty("gf.specialAnim", true)
			metaKnightIn = true
		end
	end
	if getProperty("gf.animation.curAnim.name") == "exit" and getProperty("gf.animation.curAnim.finished") then
		playAnim("gf", "spinBounce", true)
		setProperty("gf.specialAnim", true)
	end
end

function onCountdownStarted()
	triggerEvent("Intro",""," ")
end

function onBeatHit()
	if curBeat >= 340 and curBeat < 505 then
		if not metalKnight then
			metalKnight = true
			playAnim("gf", "spin")
			setProperty("gf.specialAnim", true)
			doTweenY("metaKnightEnter", "gf", metaKnightOgY, 0.31, "linear")
		end
	elseif curBeat >= 505 then
		if metalKnight then
			metalKnight = false
			playAnim("gf", "exit")
			setProperty("gf.specialAnim", true)
		end
	end
	if not funkMixCam() then
	end
end

function onTweenCompleted(tag)
	if tag == "metaKnightEnter" then
		playAnim("gf", "spinBounce", true)
		setProperty("gf.specialAnim", true)
	elseif tag == "resetState" then
		removeLuaSprite("restartBox")
	end
end

function onGameOver()
	setPropertyFromClass("PlayState", "seenCutscene", false)
end

function onGameOverStart()
	loadGraphic("border", "borders/kirbys-adventure")
	makeLuaSprite("gameOverBG", nil, 0, 0)
	makeGraphic("gameOverBG", screenWidth, screenHeight, "fcc2e5")
	addLuaSprite("gameOverBG", false)

	if getDataFromSave("playerSettings", "aspectRatio") ~= "4:3" then
		makeLuaSprite("gameOverBorder", "gameovers/kirby/border", 0, 0)
		scaleObject("gameOverBorder", 5,5)
		setProperty("gameOverBorder.y", -32*5)
		setProperty("gameOverBorder.antialiasing", false)
		addLuaSprite("gameOverBorder", false)
	end

	setPropertyFromClass("PlayState", "seenCutscene", true)
end

function onDestroy()
	setDataFromSave("songSaveData", "powerupNotes", true)
end