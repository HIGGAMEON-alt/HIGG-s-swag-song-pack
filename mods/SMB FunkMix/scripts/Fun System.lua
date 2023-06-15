function onCreate()
	initSaveData("funValues", "funkmixadvance")
	
	-- Fun Value (Editable through Save File Only)
	if getDataFromSave("funValues", "fun") == "fun" then
		setDataFromSave("funValues", "fun", getRandomInt(1,100))
		flushSaveData("funValues")
	end

	-- Bore Value (Editable through Save File Only)
	if getDataFromSave("funValues", "bore") == "bore" then
		if getDataFromSave("funValues", "fun") == 66 then
			setDataFromSave("funValues", "bore", getRandomBool(10))
			flushSaveData("funValues")
		end
	end
end