function onCreate()
	setProperty("boyfriend.danceEveryNumBeats", 3)
	setProperty("dad.danceEveryNumBeats", 3)
	setProperty("gf.danceEveryNumBeats", 3)
end

function onBeatHit()
	if curBeat >= 192 then
		setProperty("boyfriend.danceEveryNumBeats", 2)
		setProperty("dad.danceEveryNumBeats", 2)
		setProperty("gf.danceEveryNumBeats", 2)
	else
		setProperty("boyfriend.danceEveryNumBeats", 3)
		setProperty("dad.danceEveryNumBeats", 3)
		setProperty("gf.danceEveryNumBeats", 3)
	end
end