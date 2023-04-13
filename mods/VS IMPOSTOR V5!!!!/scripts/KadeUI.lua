function PsychSwitch()
    setTimeBarColors('FFFFFF', '000000');
    setProperty('kadeEngineWaterMark.y', -5000)
    setProperty('songPosTxt.y', -5000)
    setProperty('timeBarBG.scale.x', 1);
    setProperty('timeBar.scale.x', 1);
    setProperty('timeTxt.visible', true);
    for i=0,getProperty('notes.length')-1 do
    setPropertyFromGroup('notes', i, 'noteSplashDisabled', false);
    if not getPropertyFromGroup('notes',i,'mustPress') then
    setPropertyFromGroup('notes', i, 'ignoreNote', false)
    end
    if getPropertyFromGroup('notes', i, 'isSustainNote') then
    setPropertyFromGroup('notes', i, 'scale.y', getPropertyFromGroup('notes', i, 'scale.y') + 0.5)
    end
    end
    for i=0,getProperty('unspawnNotes.length')-1 do
    setPropertyFromGroup('unspawnNotes', i, 'noteSplashDisabled', false);
    if not getPropertyFromGroup('unspawnNotes',i,'mustPress') then
    setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false)
    end
    if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
    setPropertyFromGroup('unspawnNotes', i, 'scale.y', getPropertyFromGroup('unspawnNotes', i, 'scale.y') + 0.5)
    end
    end
    end
    
    function kadeSwitch()
    setProperty('kadeEngineWaterMark.y', getProperty('healthBarBG.y') + 50)
    setProperty('songPosTxt.y', getProperty('timeBarBG.y'))
    setHealthBarColors('FF0000', '66FF33');
    setTimeBarColors('00FF00', '808080');
    setProperty('timeTxt.visible', false);
    setProperty('timeBarBG.scale.x', 1.61);
    setProperty('timeBar.scale.x', 1.62);
    setProperty('songPosTxt.visible', true)
    for i=0,getProperty('notes.length')-1 do
    setPropertyFromGroup('notes', i, 'noteSplashDisabled', true);
    if getPropertyFromGroup('notes', i, 'isSustainNote') then
    setPropertyFromGroup('notes', i, 'scale.y', getPropertyFromGroup('notes', i, 'scale.y') - 0.5)
    end
    if not getPropertyFromGroup('notes',i,'mustPress') then
    setPropertyFromGroup('notes', i, 'ignoreNote', true)
    end
    end
    for i=0,getProperty('unspawnNotes.length')-1 do
    setPropertyFromGroup('unspawnNotes', i, 'noteSplashDisabled', true);
    if not getPropertyFromGroup('unspawnNotes',i,'mustPress') then
    setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
    end
    if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
    setPropertyFromGroup('unspawnNotes', i, 'scale.y', getPropertyFromGroup('unspawnNotes', i, 'scale.y') - 0.5)
    end
    end
    end
    
    function onSongStart()
    if songName:lower() == 'stargazer' or songName:lower() == 'lemon lime' or songName:lower() == 'inflorescence' or songName:lower() =='chlorophyll' then
    kadeSwitch()
    PsychSwitch()
    else
    kadeSwitch()
    end
    end

    function bfChar(e)
    debugPrint(e)
    end
    
    function onCreatePost()
    
        makeLuaText('songPosTxt', songName, 0, getProperty('timeBarBG.x') + (getProperty('timeBarBG.width') / 2) - (getProperty('songLength') * 5), -5000);
        setTextSize('songPosTxt', 16);
        setProperty('songPosTxt.borderSize', 1);
        addLuaText('songPosTxt');
    
        makeLuaText('kadeEngineWatermark', songName..' - '..difficultyFromInt(difficulty)..' | FNF Online Version '..version, 0, 4, -5000);
        setTextAlignment('kadeEngineWatermark', 'right');
        setProperty('kadeEngineWatermark.size', 16);
        setProperty('kadeEngineWatermark.borderSize', 1);
        addLuaText('kadeEngineWatermark');
        
    
        setProperty('timeBarBG.scale.x', 1);
        setProperty('timeBar.scale.x', 1);
        setProperty('timeTxt.visible', true);

        if songName:lower() == 'defeated-v5' or songName:lower() == 'finale-v5' then
        makeLuaSprite('defeatfnf', 'defeatfnf', -600, -200)
        addLuaSprite('defeatfnf', false)
        debugPrint(getProperty('defeatfnf.x'))
        scaleObject('defeatfnf', 2,2)
        setProperty('gf.visible', false)
        end
    end
    
    function onUpdate(elapsed)
    local ActualNoteId=nil
        for i=getProperty('notes.length')-1,0,-1 do
            if getPropertyFromGroup('notes',i,'mustPress')== false then
                ActualNoteId=i
                break
            end
        end
    
        if ActualNoteId~=nil then
            if not getPropertyFromGroup('notes',ActualNoteId,'mustPress') and getPropertyFromGroup('notes',ActualNoteId,'wasGoodHit') then
                if getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                    playAnim('dad', singAnimations[getPropertyFromGroup('notes',ActualNoteId,'noteData') + 1],true)
                    removeFromGroup('notes',ActualNoteId,false)
                    setProperty('vocals.volume', 1)
                elseif getPropertyFromGroup('notes',ActualNoteId,'strumTime')<=getSongPosition() +80 or getPropertyFromGroup('notes',ActualNoteId,'isSustainNote') then
                    playAnim('dad', singAnimations[getPropertyFromGroup('notes',ActualNoteId,'noteData') + 1],true)
                    removeFromGroup('notes',ActualNoteId,false)
                    setProperty('vocals.volume', 1)
                end
            end
        end
    end
    
    local difficultyArray = {'Easy', 'Normal', 'Hard'};
    function difficultyFromInt(difficulty)
        return difficultyArray[difficulty+1] --adding 1 because lua starts on 1 not 0
    end
    
function onSectionHit()
    if songName:lower() == 'defeated-v5' then
        if curSection == 73 then
            PsychSwitch()
            triggerEvent('Change Character', 'dad', 'blackv4')
            triggerEvent('Change Character', 'boyfriend', 'bf-defeat-scared')
            triggerEvent('Follow Camera Pos',getProperty('gf.x'),getProperty('gf.y'))
            setProperty('defaultCamZoom', 0.7)
        end
        if curSection == 89 then
            kadeSwitch()
            triggerEvent('Change Character', 'dad', 'black')
            triggerEvent('Change Character', 'boyfriend', 'boyfriend')
            triggerEvent('Follow Camera Pos','','')
            setProperty('defaultCamZoom', 0.9)
            --[[
            makeAnimatedLuaSprite('shit', 'characters/BF_Defeat_Scared')
            makeAnimatedLuaSprite('shit2', 'characters/black')
            ]]
        end
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
        if getProperty('boyfriend.animation.curAnim.curFrame') <= 1 then
            --e
            else
            playAnim('boyfriend', 'idle', true)
        end
        if getProperty('dad.animation.curAnim.curFrame') <= 1 then
            --e
            else
            playAnim('dad', 'idle', true)
        end
    end
end