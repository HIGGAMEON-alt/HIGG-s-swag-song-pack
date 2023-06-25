function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Dark Note' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
			setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true)
			setPropertyFromGroup('unspawnNotes', i, 'texture', "DARKNOTE_assets")
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', "DARKnoteSplashes")
		end
	end
end