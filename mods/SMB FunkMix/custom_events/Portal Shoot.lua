local bfAnimLock = 0
local ddAnimLock = 0
local wideScreen = (26 * 6) + 4

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	showBorder = getDataFromSave("playerSettings", "showBorder")

	makeAnimatedLuaSprite("verticalBridge", "ui/mari0/bridge-vertical", 96 * 6, 0)
	addAnimationByPrefix("verticalBridge", "idle", "idle0", 9, true)
	scaleObject("verticalBridge", 6, 6)
	setProperty("verticalBridge.antialiasing", false)
	setObjectCamera("verticalBridge", "hud")
	setProperty("verticalBridge.alpha", 0.9)
	setProperty("verticalBridge.visible", false)
	addLuaSprite("verticalBridge", true)

	makeAnimatedLuaSprite("horizontalBridge", "ui/mari0/bridge-horizontal", wideScreen, 64 * 6)
	addAnimationByPrefix("horizontalBridge", "idle", "idle0", 9, true)
	scaleObject("horizontalBridge", 6, 6)
	setProperty("horizontalBridge.antialiasing", false)
	setObjectCamera("horizontalBridge", "hud")
	setProperty("horizontalBridge.alpha", 0.9)
	setProperty("horizontalBridge.visible", false)
	addLuaSprite("horizontalBridge", true)

	makeAnimatedLuaSprite("horizontalBridge2", "ui/mari0/bridge-horizontal", wideScreen + getProperty("horizontalBridge.width"), 64 * 6)
	addAnimationByPrefix("horizontalBridge2", "idle", "idle0", 9, true)
	scaleObject("horizontalBridge2", 6, 6)
	setProperty("horizontalBridge2.antialiasing", false)
	setObjectCamera("horizontalBridge2", "hud")
	setProperty("horizontalBridge2.alpha", 0.9)
	setProperty("horizontalBridge2.visible", false)
	addLuaSprite("horizontalBridge2", true)

	makeAnimatedLuaSprite("horizontalBridge3", "ui/mari0/bridge-horizontal", wideScreen - getProperty("horizontalBridge.width"), 64 * 6)
	addAnimationByPrefix("horizontalBridge3", "idle", "idle0", 9, true)
	scaleObject("horizontalBridge3", 6, 6)
	setProperty("horizontalBridge3.antialiasing", false)
	setObjectCamera("horizontalBridge3", "hud")
	setProperty("horizontalBridge3.alpha", 0.9)
	setProperty("horizontalBridge3.visible", false)
	addLuaSprite("horizontalBridge3", true)

	for i = 0,getProperty("unspawnNotes.length")-1 do
		for j = 0,getProperty("eventNotes.length")-1 do
			if getPropertyFromGroup("unspawnNotes", i, "strumTime") == getPropertyFromGroup("eventNotes", j, "strumTime") and getPropertyFromGroup("eventNotes", j, "event") == "Portal Shoot" then
				if getPropertyFromGroup("eventNotes", j, "value1") == "bf" and getPropertyFromGroup("unspawnNotes", i, "mustPress") then
					setPropertyFromGroup("unspawnNotes", i, "noAnimation", true)
				elseif getPropertyFromGroup("eventNotes", j, "value1") == "dad" and not getPropertyFromGroup("unspawnNotes", i, "mustPress") then
					setPropertyFromGroup("unspawnNotes", i, "noAnimation", true)
				end
			end
		end
	end
end

function onEvent(name, value1, value2)
	if name == "Portal Shoot" then
		if value1 == "bf" then
			if getProperty("verticalBridge.visible") and value2 == "v" then
				setProperty("verticalBridge.visible", false)
			elseif getProperty("horizontalBridge.visible") and value2 == "h" then
				setProperty("horizontalBridge.visible", false)
			end
			bfAnimLock = 0.5
			playAnim("boyfriend", "shoot", true)
			setProperty("boyfriend.specialAnim", true)
			playAnim("bfParticles", "shoot", true)
			updateHitbox("bfParticles")
		elseif value1 == "dad" then
			if not getProperty("verticalBridge.visible") and value2 == "v" then
				if middlescroll then
					setProperty("verticalBridge.x", math.floor(getRandomInt(59, 120, 59)) * 6)
				else
					if funkMixCam() and showBorder then
						setProperty("verticalBridge.x", math.floor(getRandomInt(95, 160, 95)) * 6)
					else
						setProperty("verticalBridge.x", math.floor(getRandomInt(95, 160, 95)) * 6 + wideScreen/2)
					end
				end
				setProperty("verticalBridge.visible", true)
			elseif not getProperty("horizontalBridge.visible") and value2 == "h" then
				if downscroll then
					setProperty("horizontalBridge.y", math.floor(getRandomInt(7, 72, 7)) * 6)
				else
					setProperty("horizontalBridge.y", math.floor(getRandomInt(31, 96, 31)) * 6)
				end
				setProperty("horizontalBridge.visible", true)
			end
			ddAnimLock = 0.5
			playAnim("dad", "shoot", true)
			setProperty("dad.specialAnim", true)
			playAnim("mParticles", "shoot", true)
			updateHitbox("mParticles")
		end

		setProperty("horizontalBridge2.y", getProperty("horizontalBridge.y"))
		setProperty("horizontalBridge3.y", getProperty("horizontalBridge.y"))
		setProperty("horizontalBridge2.visible", getProperty("horizontalBridge.visible"))
		setProperty("horizontalBridge3.visible", getProperty("horizontalBridge.visible"))
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if getProperty("dad.animation.curAnim.name") == "shoot" and ddAnimLock > 0 then
			if getProperty("dad.animation.curAnim.curFrame") == getProperty("dad.animation.curAnim.numFrames") - 1 then
				setProperty("dad.animation.curAnim.paused", true)
			end
		end

		if getProperty("boyfriend.animation.curAnim.name") == "shoot" and bfAnimLock > 0 then
			setProperty("boyfriend.specialAnim", true)
			if getProperty("boyfriend.animation.curAnim.curFrame") == getProperty("boyfriend.animation.curAnim.numFrames") - 1 then
				setProperty("boyfriend.animation.curAnim.paused", true)
			end
		end

		if bfAnimLock > 0 then
			bfAnimLock = bfAnimLock - elapsed
			setProperty("boyfriend.specialAnim", true)
			if bfAnimLock <= 0 then
				bfAnimLock = 0
				setProperty("boyfriend.specialAnim", false)
				setProperty("boyfriend.animation.curAnim.paused", false)
				characterDance("boyfriend")
			end
		end

		if ddAnimLock > 0 then
			ddAnimLock = ddAnimLock - elapsed
			setProperty("dad.specialAnim", true)
			if ddAnimLock <= 0 then
				ddAnimLock = 0
				setProperty("dad.specialAnim", false)
				setProperty("dad.animation.curAnim.paused", false)
				characterDance("dad")
			end
		end

		if isRunning("scripts/extra/menus/Pause") then
			setProperty("horizontalBridge.animation.curAnim.paused", false)
			setProperty("horizontalBridge2.animation.curAnim.paused", false)
			setProperty("horizontalBridge3.animation.curAnim.paused", false)
			setProperty("verticalBridge.animation.curAnim.paused", false)
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("horizontalBridge.animation.curAnim.paused", true)
			setProperty("horizontalBridge2.animation.curAnim.paused", true)
			setProperty("horizontalBridge3.animation.curAnim.paused", true)
			setProperty("verticalBridge.animation.curAnim.paused", true)
		end
	end
end