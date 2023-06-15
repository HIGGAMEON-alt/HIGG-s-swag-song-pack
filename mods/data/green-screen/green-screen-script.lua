local xx = 160 * 3 - 0.5
local yy = 64 * 3 - 1
local yyD = 82 * 3 - 0.5

function onCreate()
	setDataFromSave("songSaveData", "disable1UP", true)
	if downscroll then
		triggerEvent("Camera Follow Pos", xx, yyD)
	else
		triggerEvent("Camera Follow Pos", xx, yy)
	end

	setProperty("boyfriend.visible", false)
	setHealth(2)

	makeAnimatedLuaSprite("gameboyFade", "characters/camera/fade", getProperty("boyfriend.x") - 310, getProperty("boyfriend.y") - 190)
	addAnimationByPrefix("gameboyFade", "in", "in0", 24, false)
	addAnimationByPrefix("gameboyFade", "out", "out0", 24, false)
	setProperty("gameboyFade.antialiasing", false)
	scaleObject("gameboyFade", 6, 6)
	addLuaSprite("gameboyFade", true)

	setProperty("JukeBoxTag.color", 0x009BBC0F)
	loadGraphic("border", "borders/gameboyCamera")
	setProperty("boyfriend.visible", mustHitSection)
end

function onCreatePost()
	playAnim("gameboyFade", "out")
	updateHitbox("gameboyFade")
end

function onCountdownStarted()
	triggerEvent("Intro","","by KrystalPhantasm")
end

function onUpdate()
	if getProperty("boyfriend.visible") ~= mustHitSection then
		playAnim("gameboyFade", "in")
		updateHitbox("gameboyFade")
	end
end

function onUpdatePost()
	if getProperty("gameboyFade.animation.curAnim.name") == "in" and getProperty("gameboyFade.animation.curAnim.finished") then
		setProperty("boyfriend.visible", mustHitSection)
		playAnim("gameboyFade", "out")
		updateHitbox("gameboyFade")
	end
end

function onEndSong()
	if week == "funkMix" or week == "funkMixDX" then
		setDataFromSave("playerSettings", "powerUpHP", getDataFromSave("songSaveData", "defPowerUpSet"))
		return Function_Continue
	end
end

function onGameOver()
	addLuaScript("scripts/extra/menus/GameboyPowerdown")
	return Function_Stop
end