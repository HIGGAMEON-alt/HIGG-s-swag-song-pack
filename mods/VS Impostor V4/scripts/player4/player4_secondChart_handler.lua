local playAsOtherChart = false
-- Just as a fun bonus :)

function onCreate()
    addHaxeLibrary('Song')
    addHaxeLibrary ('Highscore')
    addHaxeLibrary('FunkinLua')
    addHaxeLibrary('StageData')
    addHaxeLibrary('SwagSong','Song')
    addHaxeLibrary('Section')
    addHaxeLibrary('SwagSection','Section')
    addHaxeLibrary('Note')
    addHaxeLibrary('Std')
    addHaxeLibrary('Math')
    addHaxeLibrary('FlxMath','flixel.math')

      local Songe=songPath
      runHaxeCode([[
        var SecondSong:SwagSong;
        SecondSong= Song.loadFromJson(']]..Songe..[[-other', ']]..Songe..[[');
        var Notedata:Array<SwagSection>=SecondSong.notes;
        for (Section in Notedata)
		{
			for (songNotes in Section.sectionNotes)
			{
              var Strum:Float =songNotes[0];
              var NoteData:Int = Std.int(songNotes[1] % 4);
              var MustHitSection= Section.mustHitSection;
              if (songNotes[1] > 3)
              {
                MustHitSection = !Section.mustHitSection;
              }
              var LastNote:Note;
              if (game.unspawnNotes.length > 0) LastNote = game.unspawnNotes[Std.int(game.unspawnNotes.length - 1)];
              else LastNote = null;
              var NewNote:Note = new Note(Strum, NoteData, LastNote);
              NewNote.mustPress = MustHitSection;
              NewNote.sustainLength = songNotes[2];
              NewNote.gfNote = false;
              NewNote.noteType = songNotes[3];
              NewNote.noteType = 'SecondJson';
              NewNote.scrollFactor.set();
              var Length:Float = NewNote.sustainLength;
              Length=Length / Conductor.stepCrochet;
              game.unspawnNotes.push(NewNote);
              var floor:Int = Math.floor(Length);
                if(floor > 0) {
                    for (susNote in 0...floor+1)
                    {
                        LastNote = game.unspawnNotes[Std.int(game.unspawnNotes.length - 1)];
                        var NewSustan:Note = new Note(Strum + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(]]..getProperty('songSpeed')..[[, 2)), NoteData, LastNote, true);
                        NewSustan.mustPress = MustHitSection;
                        NewSustan.gfNote = false;
                        NewSustan.noteType = NewNote.noteType;
                        NewSustan.noteType = 'SecondJson';
                        NewSustan.scrollFactor.set();
                        NewNote.tail.push(NewSustan);
                        NewSustan.parent = NewNote;
                        game.unspawnNotes.push(NewSustan);
                        if (NewSustan.mustPress) NewSustan.x += FlxG.width / 2;
                        else if(ClientPrefs.middleScroll) 
                        {
                            NewSustan.x += 310;
                            if(NoteData > 1) NewSustan.x += FlxG.width / 2 + 25;
                        }
                    }
                }
                if (NewNote.mustPress) NewNote.x += FlxG.width / 2;
                else if(ClientPrefs.middleScroll)
				{
					NewNote.x += 310;
					if(Notedata > 1) NewNote.x += FlxG.width / 2 + 25;
				}
            }
        }
        //game.addTextToDebug(SecondSong.song,]]..getColorFromHex('FF0000')..[[);
    ]])
end

function onCreatePost()
    if playAsOtherChart then
    for i=0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',i,'noteType')=='SecondJson' and playAsOtherChart then
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
            end
        if getPropertyFromGroup('unspawnNotes',i,'noteType')=='' then

            setPropertyFromGroup('unspawnNotes', i, 'multAlpha', 0.5)
            setPropertyFromGroup('unspawnNotes', i, 'colorSwap.hue', 0)
            setPropertyFromGroup('unspawnNotes', i, 'colorSwap.saturation', -100)
            setPropertyFromGroup('unspawnNotes', i, 'colorSwap.brightness', 0.1)
            if getPropertyFromGroup('unspawnNotes',i,'isSustainNote') and not stringEndsWith(getPropertyFromGroup('unspawnNotes',i,'animation.curAnim.name'),'end')  then
                setPropertyFromGroup('unspawnNotes',i,'scale.y',getProperty('songSpeed')*1.7)
                updateHitboxFromGroup('unspawnNotes',i)
            end
            if  getPropertyFromGroup('unspawnNotes',i,'mustPress') then
                setPropertyFromGroup('unspawnNotes', i, 'blockHit', true)
            else
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
            end
        end
    end
else
    for i=0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',i,'noteType')=='SecondJson' then
            setPropertyFromGroup('unspawnNotes', i, 'multAlpha', 0.3)
            setPropertyFromGroup('unspawnNotes', i, 'colorSwap.hue', 0)
            setPropertyFromGroup('unspawnNotes', i, 'colorSwap.saturation', -50)
            setPropertyFromGroup('unspawnNotes', i, 'colorSwap.brightness', 0)
            if getPropertyFromGroup('unspawnNotes',i,'isSustainNote') and not stringEndsWith(getPropertyFromGroup('unspawnNotes',i,'animation.curAnim.name'),'end')  then
                setPropertyFromGroup('unspawnNotes',i,'scale.y',getProperty('songSpeed')*1.7)
                updateHitboxFromGroup('unspawnNotes',i)
            end
            if  getPropertyFromGroup('unspawnNotes',i,'mustPress') then
                setPropertyFromGroup('unspawnNotes', i, 'blockHit', true)
            else
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
            end
        end
    end
end
end


local dir = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

function onUpdate(elapsed)
    local ActualNoteId=nil
    if playAsOtherChart then
        for i=getProperty('notes.length')-1,0,-1 do
            if getPropertyFromGroup('notes',i,'noteType')=='' then
                ActualNoteId=i
                break
            end
        end
    else
    for i=getProperty('notes.length')-1,0,-1 do
        if getPropertyFromGroup('notes',i,'noteType')=='SecondJson' then
            ActualNoteId=i
            break
        end
    end
end
    if ActualNoteId~=nil then
        if playAsOtherChart then
        if not getPropertyFromGroup('notes',ActualNoteId,'mustPress') and getPropertyFromGroup('notes',ActualNoteId,'wasGoodHit') then
            if getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                triggerEvent('Play Animation', dir[getPropertyFromGroup('notes',ActualNoteId,'noteData') + 1], 'dad')
                removeFromGroup('notes',ActualNoteId,false)
                setProperty('vocals.volume', 1)
            elseif getPropertyFromGroup('notes',ActualNoteId,'strumTime')<=getSongPosition() or getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                triggerEvent('Play Animation', dir[getPropertyFromGroup('notes',ActualNoteId,'noteData') + 1], 'dad')
                removeFromGroup('notes',ActualNoteId,false)
                setProperty('vocals.volume', 1)
            end
        end
        if getPropertyFromGroup('notes',ActualNoteId,'mustPress') and getPropertyFromGroup('notes',ActualNoteId,'canBeHit') then
            if getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                triggerEvent('Play Animation', dir[getPropertyFromGroup('notes',ActualNoteId,'noteData') + 1], 'boyfriend')
                removeFromGroup('notes',ActualNoteId,false)
                setProperty('vocals.volume', 1)
            elseif getPropertyFromGroup('notes',ActualNoteId,'strumTime')<=getSongPosition() or getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                triggerEvent('Play Animation', dir[getPropertyFromGroup('notes',ActualNoteId,'noteData') + 1], 'boyfriend')
                removeFromGroup('notes',ActualNoteId,false)
                setProperty('vocals.volume', 1)
            end
        end
    end
        if playAsOtherChart == false then
        if not getPropertyFromGroup('notes',ActualNoteId,'mustPress') and getPropertyFromGroup('notes',ActualNoteId,'wasGoodHit') then
            if getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                removeFromGroup('notes',ActualNoteId,false)
                setProperty('vocals.volume', 1)
            elseif getPropertyFromGroup('notes',ActualNoteId,'strumTime')<=getSongPosition() or getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                triggerEvent('Play Animation', dir[getPropertyFromGroup('notes',ActualNoteId,'noteData') + 1], 'gf')
                removeFromGroup('notes',ActualNoteId,false)
                setProperty('vocals.volume', 1)
            end
        end
        if getPropertyFromGroup('notes',ActualNoteId,'mustPress') and getPropertyFromGroup('notes',ActualNoteId,'canBeHit') then
            if getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                removeFromGroup('notes',ActualNoteId,false)
                setProperty('vocals.volume', 1)
            elseif getPropertyFromGroup('notes',ActualNoteId,'strumTime')<=getSongPosition() or getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                triggerEvent('playCharAnim', 'mom', dir[getPropertyFromGroup('notes',ActualNoteId,'noteData') + 1], true)
                removeFromGroup('notes',ActualNoteId,false)
                setProperty('vocals.volume', 1)
            end
        end
    end
    end
    end

    function goodNoteHit(id, direction)
        if getPropertyFromGroup('notes', id ,'noAnimaition') and playAsOtherChart then
        triggerEvent('playCharAnim', 'mom', dir[direction + 1], false)
        setProperty('vocals.volume', 1)
        end
    end

    function opponentNoteHit(id, direction)
        if getPropertyFromGroup('notes', id ,'noAnimaition') and playAsOtherChart then
        triggerEvent('playCharAnim', 'gf', dir[direction + 1], false)
        setProperty('vocals.volume', 1)
        end
    end