function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Pori' then
			setPropertyFromGroup('unspawnNotes', i, 'fieldIndex', 1)
		end
	end
end