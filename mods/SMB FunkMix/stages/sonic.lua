function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	makeAnimatedLuaSprite("water", "backgrounds/sonic/water", 0, 0)
	addAnimationByPrefix("water", "idle", "idle0", 9, true)
	setProperty("water.antialiasing", false)
	scaleObject("water", 6, 6)
	addLuaSprite("water", false)

	makeLuaSprite("bg", "backgrounds/sonic/bg", -54 * 3, -56 * 3)
	setProperty("bg.antialiasing", false)
	scaleObject("bg", 6, 6)
	addLuaSprite("bg", false)
end

function onUpdate()
	if isRunning("scripts/extra/menus/Pause") then
		if getTextString("isPaused") ~= "true" then
			setProperty("water.animation.curAnim.paused", false)
		else
			setProperty("water.animation.curAnim.paused", true)
		end
	end
end