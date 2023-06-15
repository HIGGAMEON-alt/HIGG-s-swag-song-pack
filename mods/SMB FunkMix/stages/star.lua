function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	makeLuaSprite("sky", "backgrounds/star/sky", -160 * 3, -80 * 3)
	setProperty("sky.antialiasing", false)
	scaleObject("sky", 6, 6)
	addLuaSprite("sky", false)

	makeLuaSprite("background", "backgrounds/star/background", -160 * 3, -80 * 3)
	if not lowQuality then setScrollFactor("background", 0.75, 1) end
	setProperty("background.antialiasing", false)
	scaleObject("background", 6, 6)
	addLuaSprite("background", false)

	makeLuaSprite("ground", "backgrounds/star/ground", -160 * 3, -80 * 3)
	setProperty("ground.antialiasing", false)
	scaleObject("ground", 6, 6)
	addLuaSprite("ground", false)

	makeAnimatedLuaSprite("blocks", "backgrounds/star/blocks", -160 * 3, -80 * 3)
	addAnimationByPrefix("blocks", "idle", "anim", 9, true)
	setProperty("blocks.antialiasing", false)
	scaleObject("blocks", 6, 6)
	addLuaSprite("blocks", false)
end

function onUpdate()
	if isRunning("scripts/extra/menus/Pause") then
		if getTextString("isPaused") ~= "true" then
			setProperty("blocks.animation.curAnim.paused", false)
		else
			setProperty("blocks.animation.curAnim.paused", true)
		end
	end
end