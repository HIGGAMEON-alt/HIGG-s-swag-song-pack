function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Bullet Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'BOTHSING' then
			-- setPropertyFromGroup('unspawnNotes', i, 'texture', 'AXENOTES'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.0475); --died
		end
	end
end


function goodNoteHit(id, direction, noteType, isSustainNote)

    if noteType == 'BOTHSING' then
        if goodNoteHit and direction == 0 then
            triggerEvent('Play Animation', 'singLEFT', 'gf')
        end
        if goodNoteHit and direction == 1 then
            triggerEvent('Play Animation', 'singDOWN', 'gf')
        end
        if goodNoteHit and direction == 2 then
            triggerEvent('Play Animation', 'singUP', 'gf')
        end
        if goodNoteHit and direction == 3 then
            triggerEvent('Play Animation', 'singRIGHT', 'gf')
        end
    end
   
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
	-- Works the same as goodNoteHit, but for Opponent's notes being hit
 if noteType == 'BOTHSING' then
        if opponentNoteHit and direction == 0 then
            triggerEvent('Play Animation', 'singLEFT', 'gf')
        end
        if opponentNoteHit and direction == 1 then
            triggerEvent('Play Animation', 'singDOWN', 'gf')
        end
        if opponentNoteHit and direction == 2 then
            triggerEvent('Play Animation', 'singUP', 'gf')
        end
        if opponentNoteHit and direction == 3 then
            triggerEvent('Play Animation', 'singRIGHT', 'gf')
        end
    end
end

--debugPrint('Script started!')
function onUpdate(elapsed)
    
end