function onCreate()
	for i = 0,getProperty("unspawnNotes.length")-1 do
		if getPropertyFromGroup("unspawnNotes", i, "noteType") == "" and week == "funkMixDX" then
			setPropertyFromGroup("unspawnNotes", i, "texture", "pixel/NOTE_assets")
		end
	end
end

function onCreatePost()
	for i = 0,math.max(getProperty("opponentStrums.length"),getProperty("playerStrums.length"))-1 do
		if week == "funkMixDX" then
			setPropertyFromGroup("playerStrums", i, "texture", "pixel/NOTE_assets")
			setPropertyFromGroup("opponentStrums", i, "texture", "pixel/NOTE_assets")
		end
	end
end