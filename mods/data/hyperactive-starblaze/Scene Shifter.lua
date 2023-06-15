-- Scene Shift Events
transitionList = {"noon", "day", "preset", "sunset", "night", "midnight"}
local object = nil
local toAnim = nil
local shifting = false

function indexOf(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end

function onEvent(name, value1, value2)
	if name == "Scene Shift" then
		curAnim = getProperty(value1..".animation.curAnim.name")
		curFrame = getProperty(value1..".animation.curAnim.curFrame")
		object = value1
		toAnim = value2
		increment = 1
		if indexOf(transitionList, value2) < indexOf(transitionList, curAnim) then
			increment = -1
		end

		if curAnim ~= toAnim then
			shifting = true
		else
			shifting = false
		end

		if shifting then
			for i = indexOf(transitionList, curAnim)+increment,indexOf(transitionList, value2),increment do
				newAnim = transitionList[i]
				curAnim = newAnim
				break
			end
		end
	end
end

function onUpdate(elapsed)
	if shifting then
		if curFrame ~= getProperty(object..".animation.curAnim.curFrame") then
			curFrame = getProperty(object..".animation.curAnim.curFrame")
			playAnim(object, newAnim, true)
			updateHitbox(object)
			setProperty(object..".animation.curAnim.curFrame", curFrame)
			triggerEvent("Scene Shift", object, toAnim)
		end
	end
end