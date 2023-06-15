function onEvent(name, value1, value2)
	if name == "Blaster Bro Shoot" then
		playAnim("blasterBro", "shoot", true)
		updateHitbox("blasterBro")
	end
end