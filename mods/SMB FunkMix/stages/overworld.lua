local suff = ""

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
	if songName == "Mushroom Plains B-Side" then
		addLuaScript("scripts/extra/fonts/Lost Levels Font")
		suff = "-bSide"
	elseif songName == "Vague Memories" then
		addLuaScript("scripts/extra/fonts/Default Font")
		suff = "-night"
	else
		addLuaScript("scripts/extra/fonts/Default Font")
	end

	if week ~= "funkMix" and week ~= "funkMixDX" then
		if lowQuality then
			makeAnimatedLuaSprite("bg", "backgrounds/overworld/overworld"..suff, -160 * 3, -81 * 3 + 3)
			addAnimationByPrefix("bg", "anim", "anim0", 9, true)
			setProperty("bg.antialiasing", false)
			scaleObject("bg", 6, 6)
			addLuaSprite("bg", false)

			makeAnimatedLuaSprite("water", "backgrounds/overworld/water"..suff, -160 * 3, -81 * 3 + 3)
			addAnimationByPrefix("water", "anim", "anim0", 9, true)
			setProperty("water.antialiasing", false)
			scaleObject("water", 6, 6)
			addLuaSprite("water", false)

			makeLuaSprite("fg", "backgrounds/overworld/foreground"..suff, -160 * 3, -81 * 3 + 3)
			setProperty("fg.antialiasing", false)
			scaleObject("fg", 6, 6)
			addLuaSprite("fg", true)
		else
			makeLuaSprite("sky", "backgrounds/overworld/sky"..suff, -160 * 3, -81 * 3 + 3)
			setProperty("sky.antialiasing", false)
			scaleObject("sky", 6, 6)
			addLuaSprite("sky", false)

			if suff == "-night" then
				makeAnimatedLuaSprite("stars", "backgrounds/overworld/stars", -256 * 3, -256 * 3 + 3)
				addAnimationByPrefix("stars", "idle", "idle", 6, true)
				setScrollFactor("stars", 0.25, 1)
				setProperty("stars.antialiasing", false)
				scaleObject("stars", 6, 6)
				addLuaSprite("stars", false)
			end
		
			makeLuaSprite("background", "backgrounds/overworld/background"..suff, -160 * 6, -81 * 3 + 3)
			setScrollFactor("background", 0.5, 1)
			setProperty("background.antialiasing", false)
			scaleObject("background", 6, 6)
			addLuaSprite("background", false)
		
			makeAnimatedLuaSprite("ground", "backgrounds/overworld/ground"..suff, -160 * 3, -81 * 3 + 3)
			addAnimationByPrefix("ground", "anim", "anim0", 9, true)
			setProperty("ground.antialiasing", false)
			scaleObject("ground", 6, 6)
			addLuaSprite("ground", false)
		
			makeAnimatedLuaSprite("water", "backgrounds/overworld/water"..suff, -160 * 3, -81 * 3 + 3)
			addAnimationByPrefix("water", "anim", "anim0", 9, true)
			setProperty("water.antialiasing", false)
			scaleObject("water", 6, 6)
			addLuaSprite("water", false)

			makeLuaSprite("foreground", "backgrounds/overworld/foreground"..suff, -160 * 3, -81 * 3 + 3)
			setProperty("foreground.antialiasing", false)
			scaleObject("foreground", 6, 6)
			addLuaSprite("foreground", true)
		end
	else
		makeLuaSprite("bg", "backgrounds/overworld/bg", -160 * 3, -28 * 6)
		setProperty("bg.antialiasing", false)
		scaleObject("bg", 6, 6)
		addLuaSprite("bg", false)
	end

	if songName ~= "Vague Memories" then
		if week ~= "funkMix" and week ~= "funkMixDX" then
			makeAnimatedLuaSprite("enemy", "backgrounds/overworld/enemy", 156 * 6 + (48 * 6), 41 * 6)
		else
			makeAnimatedLuaSprite("enemy", "backgrounds/overworld/enemy", 159 * 6, 41 * 6)
		end

		if week == "funkMix" then
			addAnimationByPrefix("enemy", "goomba", "goomba0", 9, true)
			addAnimationByPrefix("enemy", "koopa-green", "koopaGreen0", 9, true)
			addAnimationByPrefix("enemy", "koopa-red", "koopaRed0", 9, true)
		else
			addAnimationByPrefix("enemy", "goomba", "goomba0", 6, true)
			addAnimationByPrefix("enemy", "koopa-green", "koopaGreen0", 6, true)
			addAnimationByPrefix("enemy", "koopa-red", "koopaRed0", 6, true)
		end

		setProperty("enemy.antialiasing", false)
		scaleObject("enemy", 6, 6)
		setProperty("enemy.visible", false)
		addLuaSprite("enemy", false)

		enemyX = getProperty("enemy.x")
		enemyY = getProperty("enemy.y")
		ogX = getProperty("enemy.x")
		ogY = getProperty("enemy.y")
	end
end

function onCreatePost()
	if suff == "-night" then
		setProperty("ground.x", getProperty("ground.x") - 48 * 6)
	end
	if songName == "Vague Memories" then
		setProperty("sky.x", getProperty("sky.x") - 48 * 6)
		setProperty("sky.y", getProperty("sky.y") - 56 * 6)
		setProperty("dad.x", getProperty("dad.x") - (32 - 7) * 6)
		setProperty("dad.y", getProperty("dad.y") - (64 - 7) * 6)
		setProperty("boyfriend.x", getProperty("boyfriend.x") - (49 + 6) * 6)
		setProperty("boyfriend.y", getProperty("boyfriend.y") - (64 - 7) * 6)
		cameraSetTarget("dad")
	end
end

function onBeatHit()
	if beatsUntilRespawn > 0 then
		beatsUntilRespawn = beatsUntilRespawn - 1
		if beatsUntilRespawn <= 0 then
			beatsUntilRespawn = 0
			spawned = true
			setProperty("enemy.visible", true)
		end
	end
end

function onUpdatePost()
	if week == "funkMix" or week == "funkMixDX" then
		if getDataFromSave("playerSettings", "aspectRatio") == "16:9" or getProperty("camHUD.visible") == false then
			ogX = 156 * 6 + (27 * 6)
		else
			ogX = 159 * 6
		end
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		setProperty("enemy.visible", true)
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

			if ((week == "funkMix" or week == "funkMixDX") and (enemyY > 89 * 6) or (getProperty("enemy.flipX") and enemyX > ogX)) or ((enemyY > 128 * 6) or (getProperty("enemy.flipX") and enemyX > ogX)) then
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
		else
			if week == "funkMix" or week == "funkMixDX" then
				if getDataFromSave("playerSettings", "aspectRatio") == "4:3" then
					setProperty("enemy.x", 159 * 6)
					enemyX = 159 * 6
				else
					setProperty("enemy.x", 156 * 6 + (27 * 6))
					enemyX = 156 * 6 + (27 * 6)	
				end
			end
		end
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("enemy.animation.curAnim.paused", false)
			setProperty("water.animation.curAnim.paused", false)
			setProperty("ground.animation.curAnim.paused", false)
			setProperty("bg.animation.curAnim.paused", false)
			setProperty("stars.animation.curAnim.paused", false)
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("enemy.animation.curAnim.paused", true)
			setProperty("water.animation.curAnim.paused", true)
			setProperty("ground.animation.curAnim.paused", true)
			setProperty("bg.animation.curAnim.paused", true)
			setProperty("stars.animation.curAnim.paused", true)
		end
	end
end