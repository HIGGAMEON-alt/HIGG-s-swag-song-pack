function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'louitchnotes' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'louitchNOTE_assets'); --Change texture
		end
	end
end