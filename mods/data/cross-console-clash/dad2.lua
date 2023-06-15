local holdTimer = 0
local singDuration = 4

function onCreate()
	makeAnimatedLuaSprite("dad2", "characters/tails", 0, 0)
	addAnimationByPrefix("dad2", "idle", "idle", 12, false)
	addAnimationByPrefix("dad2", "singLEFT", "left", 12, false)
	addAnimationByPrefix("dad2", "singDOWN", "down", 12, false)
	addAnimationByPrefix("dad2", "singUP", "up", 12, false)
	addAnimationByPrefix("dad2", "singRIGHT", "right", 12, false)
	addAnimationByPrefix("dad2", "fly", "fly", 12, true)
	addAnimationByPrefix("dad2", "skid", "skid", 12, true)
	setScrollFactor("dad2", 1, 1)
	setProperty("dad2.antialiasing", false)
	scaleObject("dad2", 6, 6)
	addLuaSprite("dad2", true)
end

function onBeatHit()
	if getProperty("dad2.animation.curAnim.name") == "idle" and curBeat % 2 == 0 then
		playAnim("dad2", "idle")
		updateHitbox("dad2")
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == "2 Player Note" then
		if noteData == 0 then
			playAnim("dad2", "singLEFT", true)
		end
		if noteData == 1 then
			playAnim("dad2", "singDOWN", true)
		end
		if noteData == 2 then
			playAnim("dad2", "singUP", true)
		end
		if noteData == 3 then
			playAnim("dad2", "singRIGHT", true)
		end
		updateHitbox("dad2")
		holdTimer = 0
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if getProperty("dad2.animation.curAnim.name") ~= "idle" and getProperty("dad2.animation.curAnim.name") ~= "fly" then
			holdTimer = holdTimer + elapsed
		else
			holdTimer = 0
		end

		if holdTimer >= stepCrochet * 0.0011 * singDuration then
			holdTimer = 0
			playAnim("dad2", "idle")
			updateHitbox("dad2")
		end

		if curStep == 1056 then
			playAnim("dad2", "singUP", true)
			updateHitbox("dad2")
			holdTimer = 0
		elseif curStep == 1062 then
			playAnim("dad2", "singRIGHT", true)
			updateHitbox("dad2")
			holdTimer = 0
		elseif curStep == 1066 then
			playAnim("dad2", "singLEFT", true)
			updateHitbox("dad2")
			holdTimer = 0
		elseif curStep == 1070 then
			playAnim("dad2", "singDOWN", true)
			updateHitbox("dad2")
			holdTimer = 0
		elseif curStep >= 1200 and curStep < 1207 then
			playAnim("dad2", "singDOWN", true)
			updateHitbox("dad2")
			holdTimer = 0
		elseif curStep >= 1208 and curStep < 1215 then
			playAnim("dad2", "singLEFT", true)
			updateHitbox("dad2")
			holdTimer = 0
		elseif curStep >= 1216 and curStep < 1223 then
			playAnim("dad2", "singRIGHT", true)
			updateHitbox("dad2")
			holdTimer = 0
		elseif curStep >= 1224 and curStep < 1231 then
			playAnim("dad2", "singLEFT", true)
			updateHitbox("dad2")
			holdTimer = 0
		end
	end
end