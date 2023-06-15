function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	if week ~= "funkMixDX" then
		if lowQuality then
			makeLuaSprite("bg", "backgrounds/test-chamber/test-chamber", -160 * 3, -81 * 3 + 3)
			setScrollFactor("bg", 1, 1)
			setProperty("bg.antialiasing", false)
			scaleObject("bg", 6, 6)
			addLuaSprite("bg", false)
		else
			makeLuaSprite("sky", "backgrounds/test-chamber/sky", -160 * 3, -81 * 3 + 3)
			setScrollFactor("sky", 1, 1)
			setProperty("sky.antialiasing", false)
			scaleObject("sky", 6, 6)
			addLuaSprite("sky", false)

			makeLuaSprite("ground", "backgrounds/test-chamber/ground", -160 * 3, -81 * 3 + 3)
			setScrollFactor("ground", 1, 1)
			setProperty("ground.antialiasing", false)
			scaleObject("ground", 6, 6)
			addLuaSprite("ground", false)
		end
	else
		makeLuaSprite("bg", "backgrounds/test-chamber/sky", -160 * 3, -81 * 3 + 3)
		setScrollFactor("bg", 1, 1)
		setProperty("bg.antialiasing", false)
		scaleObject("bg", 6, 6)
		addLuaSprite("bg", false)
	
		makeLuaSprite("fg", "backgrounds/test-chamber/fg", -160 * 3, -81 * 3 + 3)
		setScrollFactor("fg", 1, 1)
		setProperty("fg.antialiasing", false)
		scaleObject("fg", 6, 6)
		addLuaSprite("fg", false)
	end
	
	makeAnimatedLuaSprite("mParticles", "backgrounds/test-chamber/shooty_particles", -7 * 6, -18 * 6)
	addAnimationByPrefix("mParticles", "shoot", "shoot0", 15, false)
	setProperty("mParticles.angle", 90)
	setScrollFactor("mParticles", 1, 1)
	setProperty("mParticles.antialiasing", false)
	scaleObject("mParticles", 2, 2)
	addLuaSprite("mParticles", false)

	makeAnimatedLuaSprite("bfParticles", "backgrounds/test-chamber/shooty_particles", 12 * 6, 0 * 6)
	addAnimationByPrefix("bfParticles", "shoot", "shoot0", 15, false)
	setProperty("bfParticles.angle", 45)
	setScrollFactor("bfParticles", 1, 1)
	setProperty("bfParticles.antialiasing", false)
	scaleObject("bfParticles", 2, 2)
	addLuaSprite("bfParticles", false)

	setProperty("mParticles.animation.curAnim.curFrame", 4)
	setProperty("bfParticles.animation.curAnim.curFrame", 4)
end

function onCreatePost()
	if week == "funkMix" or week == "funkMixDX" then
		setProperty("gf.visible", false)
	end
end

function onUpdate()
	if isRunning("scripts/extra/menus/Pause") then
		if getTextString("isPaused") ~= "true" then
			setProperty("mParticles.animation.curAnim.paused", false)
			setProperty("bfParticles.animation.curAnim.paused", false)
		else
			setProperty("mParticles.animation.curAnim.paused", true)
			setProperty("bfParticles.animation.curAnim.paused", true)
		end
	end
end