local ddHold = false
local bfHold = false
local bfHoldTimer = 0
local ddHoldTimer = 0

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if curStep >= 1104 and curStep < 1111 then
			playAnim("dad", "singRIGHT", true)
			setProperty("dad.specialAnim", true)
			ddHold = true
			ddHoldTimer = 0
		elseif curStep >= 1112 and curStep < 1119 then
			playAnim("dad", "singLEFT", true)
			setProperty("dad.specialAnim", true)
			ddHoldTimer = 0
		elseif curStep >= 1120 and curStep < 1127 then
			playAnim("dad", "singUP", true)
			setProperty("dad.specialAnim", true)
			ddHoldTimer = 0
		elseif curStep >= 1128 and curStep < 1135 then
			playAnim("dad", "singRIGHT", true)
			setProperty("dad.specialAnim", true)
			ddHoldTimer = 0
		elseif curStep >= 1136 and curStep < 1143 then
			playAnim("boyfriend", "singRIGHT", true)
			setProperty("boyfriend.specialAnim", true)
			bfHold = true
			bfHoldTimer = 0
		elseif curStep >= 1144 and curStep < 1151 then
			playAnim("boyfriend", "singLEFT", true)
			setProperty("boyfriend.specialAnim", true)
			bfHoldTimer = 0
		elseif curStep >= 1152 and curStep < 1159 then
			playAnim("boyfriend", "singUP", true)
			setProperty("boyfriend.specialAnim", true)
			bfHoldTimer = 0
		elseif curStep >= 1160 and curStep < 1167 then
			playAnim("boyfriend", "singRIGHT", true)
			setProperty("boyfriend.specialAnim", true)
			bfHoldTimer = 0
		elseif curStep >= 1168 then
			bfHold = false
		end

		if ddHold or ddHoldTimer > 0 then
			ddHoldTimer = ddHoldTimer + elapsed
			if getProperty("dad.animation.curAnim.curFrame") == getProperty("dad.animation.curAnim.numFrames") - 1 then
				setProperty("dad.animation.curAnim.paused", true)
			end
		end
	
		if ddHoldTimer >= stepCrochet * 0.0011 * 4 then
			ddHold = false
			ddHoldTimer = 0
			setProperty("dad.specialAnim", false)
			setProperty("boyfriend.animation.curAnim.paused", false)
			characterDance("dad")
		end

		if bfHold or bfHoldTimer > 0 then
			bfHoldTimer = bfHoldTimer + elapsed
			if getProperty("boyfriend.animation.curAnim.curFrame") == getProperty("boyfriend.animation.curAnim.numFrames") - 1 then
				setProperty("boyfriend.animation.curAnim.paused", true)
			end
		end
	
		if bfHoldTimer >= stepCrochet * 0.0011 * 4 then
			bfHold = false
			bfHoldTimer = 0
			setProperty("boyfriend.specialAnim", false)
			setProperty("boyfriend.animation.curAnim.paused", false)
			characterDance("dad")
		end
	end
end