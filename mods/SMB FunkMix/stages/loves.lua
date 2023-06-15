function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	if not lowQuality then
		makeLuaSprite("sky", "backgrounds/loves/sky", -160 * 3, -87 * 3 + 3)
		setScrollFactor("sky", 0.75, 1)
		setProperty("sky.antialiasing", false)
		scaleObject("sky", 6, 6)
		addLuaSprite("sky", false)
	end

	makeLuaSprite('bricks', 'backgrounds/loves/bricks', -160*3, -81*3+3)
	makeAnimatedLuaSprite('lava', 'backgrounds/loves/lava', -48*6, 81*6-12*6)
	addAnimationByPrefix('lava', 'flow', 'flow', 12, true)
	makeLuaSprite('lavaOverlay', 'backgrounds/loves/lavaOverlay', -160*3, -81*3+3)

	setProperty('bricks.antialiasing', false)
	setProperty('lava.antialiasing', false)
	setProperty('lavaOverlay.antialiasing', false)
	scaleObject('sky', 6, 6)
	scaleObject('bricks', 6, 6)
	scaleObject('lava', 6, 6)
	scaleObject('lavaOverlay', 6, 6)

	addLuaSprite('sky', false)
	addLuaSprite('bricks', false)
	addLuaSprite('lava', true)
	addLuaSprite('lavaOverlay', true)
end

function onUpdate()
	if isRunning("scripts/extra/menus/Pause") then
		if getTextString("isPaused") ~= "true" then
			setProperty("lava.animation.curAnim.paused", false)
		else
			setProperty("lava.animation.curAnim.paused", true)
		end
	end
end