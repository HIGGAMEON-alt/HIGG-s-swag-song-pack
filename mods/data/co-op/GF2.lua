local danceDirection = true
local otherAnim = false

function onCreate()
	makeAnimatedLuaSprite("gf2", "characters/gf", 720, 156)
	addAnimationByIndices("gf2", "danceRight", "dancing", "0, 1, 2, 3", 12)
	addAnimationByIndices("gf2", "danceLeft", "dancing", "4, 5, 6, 7", 12)
	addAnimationByPrefix("gf2", "sad", "miss", 12, false)
	addAnimationByPrefix("gf2", "hey", "hey", 12, false)
	setScrollFactor("gf2", 1, 1)
	setProperty("gf2.antialiasing", false)
	scaleObject("gf2", 6, 6)
	addLuaSprite("gf2", false)
end

function onCreatePost()
	playAnim("gf2", "danceRight", true)
	updateHitbox("gf2")
end

function onBeatHit()
	if otherAnim == false then
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

function onEvent(name, value1, value2)
	if name == "Hey!" and value1 ~= "" and value1 ~= "BF" then
		otherAnim = true
		playAnim("gf2", "hey")
		updateHitbox("gf2")
	end
end