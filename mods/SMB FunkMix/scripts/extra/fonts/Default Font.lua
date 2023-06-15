function onCreatePost()
	setTextFont("timeTxt", "smb1.ttf")
	setTextSize("timeTxt", 24)
	setTextFont("botplayTxt", "smb1.ttf")
	setTextSize("botplayTxt", 24)
	setProperty("botplayTxt.x", getProperty("botplayTxt.x") - 8)
	setTextFont("scoreTxt", "smb1.ttf")
	setTextSize("scoreTxt", 16)
	setTextFont("JukeBoxText", "smb1.ttf")
	setTextFont("JukeBoxSubText", "smb1.ttf")

	if getPropertyFromClass("ClientPrefs", "timeBarType") == "Song Name" then
		setProperty("timeTxt.y", getProperty("timeTxt.y") - 2)
	end

	-- For Multiplayer Script by Super_Hugo
	setTextFont("botplayTxtP2", "smb1.ttf")
	setTextSize("botplayTxtP2", 24)
	setProperty("botplayTxtP2.x", getProperty("botplayTxtP2.x") - 8)
end