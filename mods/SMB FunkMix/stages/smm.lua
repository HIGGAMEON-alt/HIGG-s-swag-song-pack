enemyVelocity = 0
stackY = 0
enemyY = 0
shroomX = 0
shroomOgX = 0
shroomFlipped = 1
enemy2X = 0
enemy2Flipped = -1
enemy3X = 0
enemy3Flipped = -1
enemy4X = 0
enemy4Flipped = -1

function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	if lowQuality then
		makeLuaSprite("bg", "backgrounds/smm/smm", -160 * 3, -80 * 3 - (7 * 6))
		setProperty("bg.antialiasing", false)
		scaleObject("bg", 6, 6)
		addLuaSprite("bg", false)

		makeAnimatedLuaSprite("blocks_shadow", "backgrounds/smm/blocks", -156 * 3, -76 * 3 - (7 * 6))
		setProperty("blocks_shadow.color", 0x000000)
		setProperty("blocks_shadow.antialiasing", false)
		scaleObject("blocks_shadow", 6, 6)
		setProperty("blocks_shadow.alpha", 0.36)
		addLuaSprite("blocks_shadow", false)

		makeAnimatedLuaSprite("blocks", "backgrounds/smm/smm2", -160 * 3, -80 * 3 - (7 * 6))
		addAnimationByPrefix("blocks", "idle", "idle0", 9, true)
		setProperty("blocks.antialiasing", false)
		scaleObject("blocks", 6, 6)
		addLuaSprite("blocks", true)
	else
		makeLuaSprite("bg", "backgrounds/smm/bg", -160 * 3, -80 * 3)
		if week ~= "funkMixDX" then
			setScrollFactor("bg", 0.75, 1)
		end
		setProperty("bg.antialiasing", false)
		scaleObject("bg", 6, 6)
		addLuaSprite("bg", false)

		makeLuaSprite("bg2", "backgrounds/smm/bg2", 0, 0)
		setProperty("bg2.antialiasing", false)
		scaleObject("bg2", 6, 6)
		addLuaSprite("bg2", false)

		makeAnimatedLuaSprite("coin_shadow", "backgrounds/smm/coin", 2 * 6, 2 * 6)
		setProperty("coin_shadow.color", 0x000000)
		setProperty("coin_shadow.antialiasing", false)
		scaleObject("coin_shadow", 6, 6)
		setProperty("coin_shadow.alpha", 0.36)
		addLuaSprite("coin_shadow", false)

		makeAnimatedLuaSprite("coin", "backgrounds/smm/coin", 0, 0)
		addAnimationByPrefix("coin", "idle", "idle0", 9, true)
		setProperty("coin.antialiasing", false)
		scaleObject("coin", 6, 6)
		addLuaSprite("coin", false)

		makeAnimatedLuaSprite("blocks_shadow", "backgrounds/smm/blocks", -156 * 3, -76 * 3 - (7 * 6))
		setProperty("blocks_shadow.color", 0x000000)
		setProperty("blocks_shadow.antialiasing", false)
		scaleObject("blocks_shadow", 6, 6)
		setProperty("blocks_shadow.alpha", 0.36)
		addLuaSprite("blocks_shadow", false)

		makeAnimatedLuaSprite("blocks", "backgrounds/smm/blocks", -160 * 3, -80 * 3 - (7 * 6))
		addAnimationByPrefix("blocks", "idle", "idle0", 9, true)
		setProperty("blocks.antialiasing", false)
		scaleObject("blocks", 6, 6)
		addLuaSprite("blocks", true)
	end

	makeAnimatedLuaSprite("enemies_shadow", "backgrounds/smm/enemies", -156 * 3, -76 * 3)
	addAnimationByPrefix("enemies_shadow", "idle", "idle0", 6, true)
	setProperty("enemies_shadow.color", 0x000000)
	setProperty("enemies_shadow.antialiasing", false)
	scaleObject("enemies_shadow", 6, 6)
	setProperty("enemies_shadow.alpha", 0.36)
	addLuaSprite("enemies_shadow", false)

	makeAnimatedLuaSprite("enemies", "backgrounds/smm/enemies", -160 * 3, -80 * 3)
	addAnimationByPrefix("enemies", "idle", "idle0", 6, true)
	setProperty("enemies.antialiasing", false)
	scaleObject("enemies", 6, 6)
	addLuaSprite("enemies", false)
	enemyY = getProperty("enemies.y")

	makeLuaSprite("lift_shadow", "backgrounds/smm/lift", -156 * 3 - (32 * 6), 51 * 6 - (32 * 6))
	setProperty("lift_shadow.color", 0x000000)
	setProperty("lift_shadow.antialiasing", false)
	scaleObject("lift_shadow", 6, 6)
	setProperty("lift_shadow.alpha", 0.36)
	addLuaSprite("lift_shadow", false)

	makeLuaSprite("lift", "backgrounds/smm/lift", -160 * 3 - (32 * 6), 49 * 6 - (32 * 6))
	setProperty("lift.antialiasing", false)
	scaleObject("lift", 6, 6)
	addLuaSprite("lift", false)

	makeLuaSprite("weirdShadow", "backgrounds/smm/mushroom", 118 * 6, 99 * 6)
	setProperty("weirdShadow.color", 0x000000)
	setProperty("weirdShadow.antialiasing", false)
	scaleObject("weirdShadow", 6, 6)
	setProperty("weirdShadow.alpha", 0.36)
	addLuaSprite("weirdShadow", false)

	makeLuaSprite("weirdMushroom", "backgrounds/smm/mushroom", 116 * 6, 97 * 6)
	setProperty("weirdMushroom.antialiasing", false)
	scaleObject("weirdMushroom", 6, 6)
	addLuaSprite("weirdMushroom", true)

	for i = 4,1,-1 do
		makeAnimatedLuaSprite("enemyShadow"..i, "backgrounds/smm/enemy", 206 * 6, 59 * 6 - (15 * 6 * (i - 1)))
		if i == 4 then
			addAnimationByPrefix("enemyShadow"..i, "koopa-green", "koopaGreen0", 6, true)
		else
			addAnimationByPrefix("enemyShadow"..i, "goomba", "goomba0", 6, true)
		end
		setProperty("enemyShadow"..i..".color", 0x000000)
		setProperty("enemyShadow"..i..".antialiasing", false)
		scaleObject("enemyShadow"..i, 6, 6)
		setProperty("enemyShadow"..i..".alpha", 0.36)
		addLuaSprite("enemyShadow"..i, false)

		makeAnimatedLuaSprite("enemy"..i, "backgrounds/smm/enemy", 204 * 6, 57 * 6 - (15 * 6 * (i - 1)))
		if i == 4 then
			addAnimationByPrefix("enemy"..i, "koopa-green", "koopaGreen0", 6, true)
		else
			addAnimationByPrefix("enemy"..i, "goomba", "goomba0", 6, true)
		end
		setProperty("enemy"..i..".antialiasing", false)
		scaleObject("enemy"..i, 6, 6)
		addLuaSprite("enemy"..i, true)
	end

	if lowQuality then
		for i = 2,4 do
			removeLuaSprite("enemyShadow"..i, true)
			removeLuaSprite("enemy"..i, true)
		end
	end
	enemy2X = getProperty("enemy2.x")
	enemy3X = getProperty("enemy3.x")
	enemy4X = getProperty("enemy4.x")

	enemy1Y = getProperty("enemy1.y")
	enemy2Y = getProperty("enemy2.y")
	enemy3Y = getProperty("enemy3.y")
	enemy4Y = getProperty("enemy4.y")

	og1Y = getProperty("enemy1.y")
	og2Y = getProperty("enemy2.y")
	og3Y = getProperty("enemy3.y")
	og4Y = getProperty("enemy4.y")

	makeLuaSprite("fg_shadow", "backgrounds/smm/fg", -156 * 3, -76 * 3 - (7 * 6))
	setProperty("fg_shadow.color", 0x000000)
	setProperty("fg_shadow.antialiasing", false)
	scaleObject("fg_shadow", 6, 6)
	setProperty("fg_shadow.alpha", 0.36)
	addLuaSprite("fg_shadow", false)

	makeLuaSprite("fg", "backgrounds/smm/fg", -160 * 3, -80 * 3 - (7 * 6))
	setProperty("fg.antialiasing", false)
	scaleObject("fg", 6, 6)
	addLuaSprite("fg", true)

	makeLuaSprite("noShadowFG", "backgrounds/smm/noShadowFG", -160 * 3, -80 * 3 - (7 * 6))
	setProperty("noShadowFG.antialiasing", false)
	scaleObject("noShadowFG", 6, 6)
	addLuaSprite("noShadowFG", true)

	shroomX = getProperty("weirdMushroom.x")
	shroomOgX = getProperty("weirdMushroom.x")

	doTweenY("liftDown", "lift", (80 * 6), 3, "quadInOut")
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		-- Bah Jump
		if enemyY < 0 - (80 * 3) then
			enemyVelocity = enemyVelocity + (20 * 130 * elapsed)
		else
			enemyVelocity = 0
			enemyY = 0 - (80 * 3)
		end

		enemyY = enemyY + (enemyVelocity * elapsed)
		setProperty("enemies.y", enemyY)
		setProperty("enemies_shadow.y", getProperty("enemies.y") + 2 * 6)

		enemy1Y = enemy1Y + (enemyVelocity * elapsed)
		setProperty("enemy1.y", enemy1Y)
		setProperty("enemyShadow1.y", getProperty("enemy1.y") + 2 * 6)
		enemy2Y = enemy2Y + (enemyVelocity * elapsed)
		setProperty("enemy2.y", enemy2Y)
		setProperty("enemyShadow2.y", getProperty("enemy2.y") + 2 * 6)
		enemy3Y = enemy3Y + (enemyVelocity * elapsed)
		setProperty("enemy3.y", enemy3Y)
		setProperty("enemyShadow3.y", getProperty("enemy3.y") + 2 * 6)
		enemy4Y = enemy4Y + (enemyVelocity * elapsed)
		setProperty("enemy4.y", enemy4Y)
		setProperty("enemyShadow4.y", getProperty("enemy4.y") + 2 * 6)

		if enemy1Y >= og1Y then
			enemy1Y = og1Y
			enemy2Y = og2Y
			enemy3Y = og3Y
			enemy4Y = og4Y
		end

		-- Mushroom Movement
		shroomX = shroomX - (1 * 130 * (elapsed * 1.25) * shroomFlipped)
		if shroomX <= (96 * 6) then
			shroomFlipped = -1
		end

		if shroomX >= shroomOgX then
			shroomFlipped = 1
		end
		
		setProperty("weirdMushroom.x", shroomX)
		setProperty("weirdShadow.x", shroomX + (2 * 6))

		-- Enemy2 Movement
		enemy2X = enemy2X - (1 * 130 * (elapsed * 0.5) * enemy2Flipped)
		if enemy2X <= (202 * 6) then
			enemy2Flipped = -1
		end

		if enemy2X >= (204 * 6) then
			enemy2Flipped = 1
		end
		
		setProperty("enemy2.x", enemy2X)
		setProperty("enemyShadow2.x", enemy2X + (2 * 6))

		-- Enemy3 Movement
		enemy3X = enemy3X - (1 * 130 * (elapsed * 0.5) * enemy3Flipped)
		if enemy3X <= (201 * 6) then
			enemy3Flipped = -1
		end

		if enemy3X >= (205 * 6) then
			enemy3Flipped = 1
		end
		
		setProperty("enemy3.x", enemy3X)
		setProperty("enemyShadow3.x", enemy3X + (2 * 6))

		-- Enemy4 Movement
		enemy4X = enemy4X - (1 * 130 * (elapsed * 0.5) * enemy4Flipped)
		if enemy4X <= (200 * 6) then
			enemy4Flipped = -1
		end

		if enemy4X >= (206 * 6) then
			enemy4Flipped = 1
		end

		if enemy4Flipped == 1 then
			setProperty("enemy4.flipX", false)
			setProperty("enemyShadow4.flipX", false)
		elseif enemy4Flipped == -1 then
			setProperty("enemy4.flipX", true)
			setProperty("enemyShadow4.flipX", true)
		end
		
		setProperty("enemy4.x", enemy4X)
		setProperty("enemyShadow4.x", enemy4X + (2 * 6))

		if isRunning("scripts/extra/menus/Pause") then
			setProperty("blocks.animation.curAnim.paused", false)
			setProperty("coin.animation.curAnim.paused", false)
			setProperty("enemies.animation.curAnim.paused", false)
			setProperty("enemies_shadow.animation.curAnim.paused", false)
			for i = 1,4 do
				setProperty("enemy"..i..".animation.curAnim.paused", false)
				setProperty("enemyShadow"..i..".animation.curAnim.paused", false)
			end
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("blocks.animation.curAnim.paused", true)
			setProperty("coin.animation.curAnim.paused", true)
			setProperty("enemies.animation.curAnim.paused", true)
			setProperty("enemies_shadow.animation.curAnim.paused", true)
			for i = 1,4 do
				setProperty("enemy"..i..".animation.curAnim.paused", true)
				setProperty("enemyShadow"..i..".animation.curAnim.paused", true)
			end
		end
	end
end

function onUpdatePost()
	setProperty("lift_shadow.y", getProperty("lift.y") + (2 * 6))
end

function onEvent(name, value1, value2)
	if name == "Hey!" then
		enemyVelocity = -325
		enemyY = -1 - (80 * 3)

		enemy1Y = enemy1Y - 1
		enemy2Y = enemy2Y - 1
		enemy3Y = enemy3Y - 1
		enemy4Y = enemy4Y - 1
	end
end

function onTweenCompleted(tag)
	if tag == "liftDown" then
		doTweenY("liftUp", "lift", 49 * 6 - (32 * 6), 3, "quadInOut")
	elseif tag == "liftUp" then
		doTweenY("liftDown", "lift", (80 * 6), 3, "quadInOut")
	end
end