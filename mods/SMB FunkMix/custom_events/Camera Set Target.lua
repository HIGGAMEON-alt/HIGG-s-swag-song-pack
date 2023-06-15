function onEvent(name, value1, value2)
	if name == "Camera Set Target" then
		if value1 == "" then
			triggerEvent("Camera Follow Pos", "", "")
		else
			triggerEvent("Camera Follow Pos", 0, 0)
			cameraSetTarget(value1)
		end
	end
end