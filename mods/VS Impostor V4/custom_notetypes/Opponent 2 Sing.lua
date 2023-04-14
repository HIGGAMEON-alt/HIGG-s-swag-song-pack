function onCreate()
    --Iterate over all notes
    for i = 0, getProperty('unspawnNotes.length')-1 do
    --Check if the note is an Instakill Note
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Opponent 2 Sing' then
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
        end
    end
    --debugPrint('Script started!')
end