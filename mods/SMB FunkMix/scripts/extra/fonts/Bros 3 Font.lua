function onCreatePost()
	setTextFont("timeTxt", "smb3.ttf")
	setTextSize("timeTxt", 24)
	setProperty("timeTxt.y", getProperty("timeTxt.y") - 2)
	setTextFont("botplayTxt", "smb3.ttf")
	setTextSize("botplayTxt", 24)
	setTextString("botplayTxt", string.lower(getTextString("botplayTxt")))
	setProperty("botplayTxt.x", getProperty("botplayTxt.x") - 8)
	setTextFont("scoreTxt", "smb3.ttf")
	setTextSize("scoreTxt", 16)
	setTextFont("JukeBoxText", "smb3.ttf")
	setTextFont("JukeBoxSubText", "smb3.ttf")

	if getPropertyFromClass("ClientPrefs", "timeBarType") == "Song Name" then
		setProperty("timeTxt.y", getProperty("timeTxt.y") - 2)
	end

	-- For Multiplayer Script by Super_Hugo
	setTextFont("botplayTxtP2", "smb3.ttf")
	setTextSize("botplayTxtP2", 24)
	setProperty("botplayTxtP2.x", getProperty("botplayTxtP2.x") - 8)
end