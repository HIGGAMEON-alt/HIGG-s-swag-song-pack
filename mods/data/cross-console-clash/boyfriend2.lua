local holdTimer = 0
local singDuration = 4

function onCreate()
	makeAnimatedLuaSprite("boyfriend2", "characters/luigi-ccc", 0, 0)
	addAnimationByPrefix("boyfriend2", "idle", "idle", 9, true)
	addAnimationByPrefix("boyfriend2", "singLEFT", "left", 12, false)
	addAnimationByPrefix("boyfriend2", "singDOWN", "down", 12, false)
	addAnimationByPrefix("boyfriend2", "singUP", "up", 12, false)
	addAnimationByPrefix("boyfriend2", "singRIGHT", "right", 12, false)
	addAnimationByPrefix("boyfriend2", "jump", "jump", 12, false)
	setScrollFactor("boyfriend2", 1, 1)
	setProperty("boyfriend2.antialiasing", false)
	scaleObject("boyfriend2", 6, 6)
	addLuaSprite("boyfriend2", true)
end

function onBeatHit()
	if getProperty("boyfriend2.animation.curAnim.name") == "idle" then
		playAnim("boyfriend2", "idle")
		updateHitbox("boyfriend2")
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == "2 Player Note" then
		if noteData == 0 then
			playAnim("boyfriend2", "singRIGHT", true)
		end
		if noteData == 1 then
			playAnim("boyfriend2", "singDOWN", true)
		end
		if noteData == 2 then
			playAnim("boyfriend2", "singUP", true)
		end
		if noteData == 3 then
			playAnim("boyfriend2", "singLEFT", true)
		end
		updateHitbox("boyfriend2")
		holdTimer = 0
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if getProperty("boyfriend2.animation.curAnim.name") ~= "idle" then
			holdTimer = holdTimer + elapsed
		else
			holdTimer = 0
		end

		if holdTimer >= stepCrochet * 0.0011 * singDuration then
			holdTimer = 0
			playAnim("boyfriend2", "idle", true)
			updateHitbox("boyfriend2")
		end

		if curStep == 1088 then
			playAnim("boyfriend2", "singUP", true)
			updateHitbox("boyfriend2")
			holdTimer = 0
		elseif curStep == 1094 then
			playAnim("boyfriend2", "singRIGHT", true)
			updateHitbox("boyfriend2")
			holdTimer = 0
		elseif curStep == 1098 then
			playAnim("boyfriend2", "singLEFT", true)
			updateHitbox("boyfriend2")
			holdTimer = 0
		elseif curStep == 1102 then
			playAnim("boyfriend2", "singDOWN", true)
			updateHitbox("boyfriend2")
			holdTimer = 0
		elseif curStep >= 1264 and curStep < 1271 then
			playAnim("boyfriend2", "singDOWN", true)
			updateHitbox("boyfriend2")
			holdTimer = 0
		elseif curStep >= 1272 and curStep < 1279 then
			playAnim("boyfriend2", "singLEFT", true)
			updateHitbox("boyfriend2")
			holdTimer = 0
		elseif curStep >= 1280 and curStep < 1287 then
			playAnim("boyfriend2", "singRIGHT", true)
			updateHitbox("boyfriend2")
			holdTimer = 0
		elseif curStep >= 1288 and curStep < 1295 then
			playAnim("boyfriend2", "singLEFT", true)
			updateHitbox("boyfriend2")
			holdTimer = 0
		end
	end
end