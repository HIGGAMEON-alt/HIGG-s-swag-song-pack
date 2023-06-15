function onCreate()
	initSaveData("songSaveData", "funkmixadvance")
	addLuaScript("scripts/extra/fonts/Kirbys Adventure Font")

	makeAnimatedLuaSprite("bg", "backgrounds/vegetable-valley/stage", -48 * 6, -49 * 6)
	addAnimationByPrefix("bg", "noon", "noon0", 9, true)
	addAnimationByPrefix("bg", "day", "day0", 9, true)
	addAnimationByPrefix("bg", "preset", "preset0", 9, true)
	addAnimationByPrefix("bg", "sunset", "sunset0", 9, true)
	addAnimationByPrefix("bg", "night", "night0", 9, true)
	addAnimationByPrefix("bg", "midnight", "midnight0", 9, true)
	setScrollFactor("bg", 1, 1)
	setProperty("bg.antialiasing", false)
	scaleObject("bg", 6, 6)
	addLuaSprite("bg", false)
end

function onCreatePost()
	triggerEvent("Scene Shift", "bg", "day")
end

function onUpdate(elapsed)
	if isRunning("scripts/extra/menus/Pause") then
		if getTextString("isPaused") ~= "true" then
			setProperty("bg.animation.curAnim.paused", false)
		else
			setProperty("bg.animation.curAnim.paused", true)
		end
	end
end