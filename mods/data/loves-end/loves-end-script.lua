-- Initial code by Lethrial

function funkMixCam()
	return getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	if getDataFromSave("songSaveData", "lifeCount") > 1 or getDataFromSave("playerSettings", "lifeStart") <= 0 then
		setPropertyFromClass("GameOverSubstate", "characterName", "retry")
	else
		setPropertyFromClass("GameOverSubstate", "characterName", "gameover-love")
	end
	setPropertyFromClass("GameOverSubstate", "deathSoundName", "")
	setPropertyFromClass("GameOverSubstate", "loopSoundName", "")
	setPropertyFromClass("GameOverSubstate", "endSoundName", "")
end

function onCountdownStarted()
	triggerEvent("Intro","","by SacriStuff")
	loadGraphic("JukeBox", "songIntro/Loves End")
end

function onCreatePost()
	bf_x = getProperty('boyfriend.x')
	bf_y = getProperty('boyfriend.y') --using defaultBoyfriendX/Y didn't work for some reason

	--shock effect (thank you SAKK for making the sprite)
	makeLuaSprite('shock', 'backgrounds/loves/shock', bf_x - 130, bf_y - 120)
	setProperty('shock.antialiasing', false)
	scaleObject('shock', 6, 6)
	addLuaSprite('shock', true)
	setProperty('shock.visible', false)

	--jumping sprites
	makeAnimatedLuaSprite('jump', 'backgrounds/loves/jump', getProperty('boyfriend.x') - 66, getProperty('boyfriend.y') - 66)
	addAnimationByPrefix('jump', 'fire_jump', 'fire_jump', 1, true)
	addAnimationByPrefix('jump', 'normal_jump', 'normal_jump', 1, true)
	addAnimationByPrefix('jump', 'small_jump', 'small_jump', 1, true)
	setProperty('jump.antialiasing', false)
	scaleObject('jump', 6, 6)
	addLuaSprite('jump', false)
	setProperty('jump.visible', false)
	playAnim('boyfriend', 'skid')
end

function onCountdownTick(counter)
	if counter < 4 then
		playAnim('boyfriend', 'skid')
	end
end

function onUpdate(elapsed)
	--why did you flip the skid animation funk mix team ):
	if getTextString("isPaused") ~= "true" then
		if getProperty('boyfriend.animation.curAnim.name') == 'skid' then
			setProperty('boyfriend.flipX', true)
			if not inGameOver then setProperty('boyfriend.x', bf_x + 18) end
			if not funkMixCam() then
				cameraSetTarget("boyfriend")
			end
		else
			if not inGameOver then setProperty('boyfriend.x', bf_x) end
		end
		if curBeat < 340 then setProperty('dad.x', getProperty('dad.x') + (3 * elapsed)) end --moves imario every frame. multiplying by elapsed so the speed is constant on any frame rate
	end
end

function onUpdatePost()
	if getTextString("isPaused") ~= "true" then
		if getProperty('boyfriend.animation.curAnim.name') ~= 'skid' then
			setProperty('boyfriend.flipX', false)
		end

		if not funkMixCam() then
			if not mustHitSection then
				cameraSetTarget("dad")
			end
		end
	end
end

function onEvent(name, value1, value2)
	if name == 'Shock' then
		setProperty('shock.visible', not getProperty('shock.visible'))
	end
end

function onBeatHit()
	--suicide time!
	if curBeat == 336 then characterDance('boyfriend') end
	if curBeat > 337 then
		if getProperty('boyfriend.curCharacter') == 'boyfriend-fire' then
			playAnim('jump', 'fire_jump', true)
		elseif getProperty('boyfriend.curCharacter') == 'boyfriend-small' then
			playAnim('jump', 'small_jump', true)
		else
			playAnim('jump', 'normal_jump', true)
		end
		updateHitbox("jump")
	end
	if curBeat == 338 then
		setProperty('boyfriend.visible', false)
		setProperty('jump.visible', true)
		doTweenX('jumpX', 'jump', bf_x - 270, 0.8, 'linear')
		doTweenY('jumpYup', 'jump', bf_y - 220, 0.3, 'circOut')
	end
	if curBeat == 340 and getProperty('ratingFC') == 'SFC' and (botPlay == false or botPlay == true and getDataFromSave("playerSettings", "botplayCheat") == true) then
		setScore(10241643)
	end
end

function onTweenCompleted(tag)
	if tag == 'jumpYup' then
		doTweenY('jumpYdown', 'jump', bf_y + 340, 0.5, 'circIn')
	end
end