local prefix = "pixel"
local suffix = ""

function onCreate()
	if (songName == "Deep Deep Voyage" or songName == "Hop-Hop Heights" or songName == "Mushroom Plains B-Side" or songName == "Bricks and Lifts B-Side" or songName == "Lethal Lava Lair B-Side") and week ~= "funkMixDX" then
		prefix = "lostlevels"
	elseif songName == "Portal Power" then
		prefix = "mari0"
	elseif songName == "First Level" then
		prefix = "smm"
	elseif songName == "Hammered" or songName == "Tyrant" then
		prefix = "smb3"
	end
end

function onCreatePost() -- returnQuantNote
	for i = 0, getProperty("unspawnNotes.length")-1 do
		noteQuant = -1
		if noteQuant == -1 then
			quantArray = {4, 8, 12, 16, 20, 24, 32, 48, 64, 192}

			newTime = getPropertyFromGroup("unspawnNotes", i, "strumTime")

			beatTimeSeconds = 60 / curBpm -- beat in seconds
			beatTime = beatTimeSeconds * 1000 -- beat in milliseconds
			-- assumed 4 beats per measure?
			measureTime = beatTime * 4

			smallestDeviation = measureTime / quantArray[#quantArray]

			for quant = 1,#quantArray do
				-- please generate this ahead of time and put into array :)
				-- I dont think I will im scared of those
				quantTime = (measureTime / quantArray[quant])
				if (newTime + getPropertyFromClass("ClientPrefs", "noteOffset") + smallestDeviation) % quantTime < smallestDeviation * 2 then
					-- here it is, the quant, finally!
					noteQuant = quant
					break
				end
			end
		end

		-- note quants
		-- base quant notes
		if getPropertyFromGroup("unspawnNotes", i, "noteType") == "" or getPropertyFromGroup("unspawnNotes", i, "noteType") == "GF Sing" or getPropertyFromGroup("unspawnNotes", i, "noteType") == "2 Player Note" then
			setPropertyFromGroup("unspawnNotes", i, "texture", "quants/"..prefix.."/NOTE_quants"..noteQuant..suffix) -- noteQuant
		end
		if songName == "Cross Console Clash" and not getPropertyFromGroup("unspawnNotes", i, "mustPress") and (getPropertyFromGroup("unspawnNotes", i, "noteType") == "" or getPropertyFromGroup("unspawnNotes", i, "noteType") == "2 Player Note") then
			setPropertyFromGroup("unspawnNotes", i, "texture", "quants/sonic/NOTE_quants"..noteQuant..suffix) -- noteQuant
		end

		-- inherit last quant if hold note
		if getPropertyFromGroup("unspawnNotes", i, "isSustainNote") and getPropertyFromGroup("unspawnNotes", i, "prevNote") ~= nil then
			setPropertyFromGroup("unspawnNotes", i, "texture", getPropertyFromGroup("unspawnNotes", i, "prevNote.texture"))
		end

		-- Note Splashes
		if not lowQuality then
			if prefix == "lostlevels" then
				splashPrefix = "pixel"
			else
				splashPrefix = prefix
			end
			
			for j = 1,10 do
				if getPropertyFromGroup("unspawnNotes", i, "texture") == "quants/"..prefix.."/NOTE_quants"..j..suffix then
					setPropertyFromGroup("unspawnNotes", i, "noteSplashTexture", "quantSplashes/"..splashPrefix.."/"..j)
				end
			end
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if not lowQuality then
		for i = 1,10 do
			if getPropertyFromGroup("notes", id, "texture") == "quants/"..prefix.."/NOTE_quants"..i..suffix then
				setPropertyFromGroup("playerStrums", noteData, "texture", getPropertyFromGroup("notes", id, "texture"))
			end
		end
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if not lowQuality then
		for i = 1,10 do
			if getPropertyFromGroup("notes", id, "texture") == "quants/"..prefix.."/NOTE_quants"..i..suffix then
				setPropertyFromGroup("opponentStrums", noteData, "texture", getPropertyFromGroup("notes", id, "texture"))
			end
		end
	end
end