local danceDirection = true
local otherAnim = false

function onCreate()
	makeAnimatedLuaSprite("gf2", "characters/gf-captured", 606, 150)
	addAnimationByIndices("gf2", "danceRight", "dancing", "0, 1, 2, 3, 4", 12)
	addAnimationByIndices("gf2", "danceLeft", "dancing", "5, 6, 7, 8, 9", 12)
	addAnimationByPrefix("gf2", "sad", "miss", 12, false)
	setScrollFactor("gf2", 1, 1)
	setProperty("gf2.antialiasing", false)
	scaleObject("gf2", 6, 6)
	addLuaSprite("gf2", false)
	setObjectOrder("gf2", getObjectOrder("cage") - 1)
end

function onCreatePost()
	playAnim("gf2", "danceRight", true)
	updateHitbox("gf2")
end

function onBeatHit()
	if otherAnim == false then
		if danceDirection then
			danceDirection = false
			playAnim("gf2", "danceLeft", true)
		else
			danceDirection = true
			playAnim("gf2", "danceRight", true)
		end
		updateHitbox("gf2")
	end
end

function onCountdownTick(swagCounter)
	if swagCounter <= 4 then
		if danceDirection then
			danceDirection = false
			playAnim("gf2", "danceLeft")
		else
			danceDirection = true
			playAnim("gf2", "danceRight")
		end
		updateHitbox("gf2")
	end
end 

function noteMissPress(i)
	for i = 0,3 do
		otherAnim = true
		playAnim("gf2", "sad", true)
		updateHitbox("gf2")
	end
end

function onUpdate()
	if getProperty("gf2.animation.curAnim.finished") then
		otherAnim = false
	end
end