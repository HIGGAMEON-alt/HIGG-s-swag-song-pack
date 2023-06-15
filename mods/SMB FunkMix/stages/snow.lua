enemyX = 0
enemyY = 0
local ogX = 0
local ogY = 0
enemyVelocity = 0
local enemyType = 0
local beatsUntilRespawn = 12
local spawned = false
flipped = 1

function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	if not lowQuality then
		makeLuaSprite("sky", "backgrounds/snow/sky", -160 * 3, -81 * 3 + 3)
		setScrollFactor("sky", 1, 1)
		setProperty("sky.antialiasing", false)
		scaleObject("sky", 6, 6)
		addLuaSprite("sky", false)
	
		makeLuaSprite("background", "backgrounds/snow/background", -160 * 3, -81 * 3 + 3)
		setScrollFactor("background", 0.75, 1)
		setProperty("background.antialiasing", false)
		scaleObject("background", 6, 6)
		addLuaSprite("background", false)
	
		makeAnimatedLuaSprite("ground", "backgrounds/snow/ground", -160 * 3, -81 * 3 + 3)
		addAnimationByPrefix("ground", "anim", "anim0", 9, true)
		setScrollFactor("ground", 1, 1)
		setProperty("ground.antialiasing", false)
		scaleObject("ground", 6, 6)
		addLuaSprite("ground", false)

		makeAnimatedLuaSprite("snow", "backgrounds/snow/snowGif", 0, 0)
		addAnimationByPrefix("snow", "anim", "anim0", 12, true)
		setObjectCamera("snow", "hud")
		setProperty("snow.antialiasing", false)
		scaleObject("snow", 4, 4)
		addLuaSprite("snow", false)
	else
		makeLuaSprite("bg", "backgrounds/snow/snow", -160 * 3, -81 * 3 + 3)
		setScrollFactor("bg", 1, 1)
		setProperty("bg.antialiasing", false)
		scaleObject("bg", 6, 6)
		addLuaSprite("bg", false)
	end

	makeLuaSprite("fg", "backgrounds/snow/foreground", -160 * 3, -81 * 3 + 3)
	setScrollFactor("fg", 1, 1)
	setProperty("fg.antialiasing", false)
	scaleObject("fg", 6, 6)
	addLuaSprite("fg", true)

	makeAnimatedLuaSprite("water", "backgrounds/snow/water", -160 * 3, -81 * 3 + 3)
	addAnimationByPrefix("water", "anim", "anim0", 4, true)
	setScrollFactor("water", 1, 1)
	setProperty("water.antialiasing", false)
	scaleObject("water", 6, 6)
	addLuaSprite("water", false)

	makeAnimatedLuaSprite("enemy", "backgrounds/snow/enemy", 156 * 6 + (48 * 6), 41 * 6)
	addAnimationByPrefix("enemy", "goomba", "goomba0", 6, true)
	addAnimationByPrefix("enemy", "koopa-green", "koopaGreen0", 6, true)
	addAnimationByPrefix("enemy", "koopa-red", "koopaRed0", 6, true)
	setScrollFactor("enemy", 1, 1)
	setProperty("enemy.antialiasing", false)
	scaleObject("enemy", 6, 6)
	setProperty("enemy.visible", false)
	addLuaSprite("enemy", false)

	enemyX = getProperty("enemy.x")
	enemyY = getProperty("enemy.y")
	ogX = getProperty("enemy.x")
	ogY = getProperty("enemy.y")
end

function onBeatHit(curBeat)
	if beatsUntilRespawn > 0 then
		beatsUntilRespawn = beatsUntilRespawn - 1
		if beatsUntilRespawn <= 0 then
			beatsUntilRespawn = 0
			spawned = true
			setProperty("enemy.visible", true)
		end
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if getProperty("enemy.flipX") == false then
			flipped = 1
		else
			flipped = -1
		end

		if spawned == true then
			enemyX = enemyX - (1 * 130 * elapsed * flipped)
			if enemyType ~= 2 then
				if enemyX < (128 * 6) then
					enemyVelocity = enemyVelocity + (20 * 130 * elapsed)
				end
			else
				if enemyX < (130 * 6) then
					setProperty("enemy.flipX", true)
				end
			end
			enemyY = enemyY + (enemyVelocity * elapsed)

			if (enemyY > 128 * 6) or (getProperty("enemy.flipX") and enemyX > ogX) then
				enemyX = ogX
				enemyY = ogY
				enemyVelocity = 0

				enemyType = getRandomInt(-1, 2, -1)
				enemyName = "goomba"
				if enemyType == 0 then
					enemyName = "goomba"
				elseif enemyType == 1 then
					enemyName = "koopa-green"
				elseif enemyType == 2 then
					enemyName = "koopa-red"
				end
			
				playAnim("enemy", enemyName, true)
				updateHitbox("enemy")
				beatsUntilRespawn = getRandomInt(11, 36, 11)

				spawned = false
				setProperty("enemy.visible", false)
				setProperty("enemy.flipX", false)
			end	
			setProperty("enemy.x", math.floor(enemyX / 6) * 6)
			setProperty("enemy.y", math.floor(enemyY / 6) * 6)
		end

		if isRunning("scripts/extra/menus/Pause") then
			setProperty("enemy.animation.curAnim.paused", false)
			setProperty("water.animation.curAnim.paused", false)
			setProperty("ground.animation.curAnim.paused", false)
			setProperty("bg.animation.curAnim.paused", false)
			setProperty("snow.animation.curAnim.paused", false)
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("enemy.animation.curAnim.paused", true)
			setProperty("water.animation.curAnim.paused", true)
			setProperty("ground.animation.curAnim.paused", true)
			setProperty("bg.animation.curAnim.paused", true)
			setProperty("snow.animation.curAnim.paused", true)
		end
	end
end