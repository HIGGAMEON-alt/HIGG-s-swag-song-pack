--[[
FNFOnline shit is weird fr fr
how to make it detect image to download

makeLuaSprite('','sick',0,0)
makeLuaSprite('','good',0,0)
makeLuaSprite('','bad',0,0)
makeLuaSprite('','shit',0,0)

makeLuaSprite('','Sussy!/sick',0,0)
makeLuaSprite('','Sussy!/good',0,0)
makeLuaSprite('','Sussy!/bad',0,0)
makeLuaSprite('','Sussy!/shit',0,0)
]]

local keyPress = {'left','down','up','right'}
local showThemParts

function PsychSwitch()
    setProperty('ratingsData[0].image', 'Sussy!/sick')
    setProperty('ratingsData[1].image', 'Sussy!/good')
    setProperty('ratingsData[2].image', 'Sussy!/bad')
    setProperty('ratingsData[3].image', 'Sussy!/shit')
    if songName:lower() == 'stargazer' or songName:lower() == 'lemon lime' or songName:lower() == 'inflorescence' or songName:lower() =='chlorophyll' then
    else
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
    end
    
    function kadeSwitch()
    setProperty('ratingsData[0].image', 'sick')
    setProperty('ratingsData[1].image', 'good')
    setProperty('ratingsData[2].image', 'bad')
    setProperty('ratingsData[3].image', 'shit')
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
    if songName:lower() == 'defeated-v5' then
    removeLuaSprite('1w')
    removeLuaSprite('w')
    end
    if songName:lower() == 'stargazer' or songName:lower() == 'lemon lime' or songName:lower() == 'inflorescence' or songName:lower() =='chlorophyll' or songName:lower() == 'defeated-v5' then
    precacheImage('Sussy!/bad')
    precacheImage('Sussy!/good')
    precacheImage('Sussy!/shit')
    precacheImage('Sussy!/sick')
    if songName:lower() == 'defeated-v5' then
    else
    setProperty('ratingsData[0].image', 'Sussy!/sick')
    setProperty('ratingsData[1].image', 'Sussy!/good')
    setProperty('ratingsData[2].image', 'Sussy!/bad')
    setProperty('ratingsData[3].image', 'Sussy!/shit')
    end
    end
    if songName:lower() == 'stargazer' or songName:lower() == 'lemon lime' or songName:lower() == 'inflorescence' or songName:lower() =='chlorophyll' then
    --eh
    else
    kadeSwitch()
    end
    end
    
    function onCreatePost()
        if songName:lower() == 'stargazer' or songName:lower() == 'lemon lime' or songName:lower() == 'inflorescence' or songName:lower() =='chlorophyll' then
        else
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
        end
        if songName:lower() == 'sussus-moogus-v5' or songName:lower() == 'actin-sus' or songName == 'boiling-point-v5' then
        makeLuaSprite('bg', 'stageback', -600, -200)
        addLuaSprite('bg')
        setObjectOrder('bg', getObjectOrder('gf')-1)
        end
        if songName:lower() == 'stargazer' or songName:lower() == 'lemon lime' or songName:lower() == 'inflorescence' or songName:lower() =='chlorophyll' then
        makeAnimatedLuaSprite('skeld', 'O2Background', -700, -200)
        addLuaSprite('skeld', false)
        setProperty('gf.visible', false)
        --scaleObject('defeatfnf', 2,2)
        end
        if songName:lower() == 'defeated-v5' or songName:lower() == 'finale-v5' then
        makeLuaSprite('defeatfnf', 'defeatfnf', -600, -200)
        addLuaSprite('defeatfnf', false)
        scaleObject('defeatfnf', 2,2)
        setProperty('gf.visible', false)
        precacheImage('Sussy!/bad')
        precacheImage('Sussy!/good')
        precacheImage('Sussy!/shit')
        precacheImage('Sussy!/sick')
        end
        if songName:lower() == 'defeated-v5' then
        precacheImage('characters/BF_Defeat_Scared')
        precacheImage('characters/black')
        makeLuaSprite('1w','characters/black',0,0)
        addLuaSprite('1w', false)
        setProperty('1w.alpha', 0.01)
        makeAnimatedLuaSprite('defeatthing', 'defeat', -450, -150)
        addAnimationByPrefix('defeatthing', 'bop', 'defeat', 24, false)
        setGraphicSize('defeatthing', getProperty('defeatthing.width') * 1.3)
        setProperty('defeatthing.alpha', 0.001)
        setScrollFactor('defeatthing', 0.8, 0.8)
        addLuaSprite('defeatthing')
        setProperty('defeathing.alpha', 0,001)
        scaleObject('defeatthing', 1.3, 1.3)
        screenCenter('defeatthing', 'XY')
        makeLuaSprite('bodies2', 'lol thing', -640, 50)
        setScrollFactor('bodies2', 0.9, 0.9)
        setProperty('bodies2.alpha', 0,001)
        addLuaSprite('bodies2')
        setGraphicSize('bodies2', getProperty('bodies2.width') * 1.3)
        makeLuaSprite('bodies', 'deadBG', -806, 450)
        setScrollFactor('bodies', 0.9,0.9)
        setProperty('bodies.alpha', 0.001)
        addLuaSprite('bodies')
        setGraphicSize('bodies', getProperty('bodies.width') * 0.4)
        showThemParts = {'defeatthing', 'bodies', 'bodies2'}

        makeLuaSprite('w','characters/BF_Defeat_Scared',0,0)
        addLuaSprite('w', false)
        setProperty('w.alpha', 0.01)
        end
    end
    
    function onUpdate(elapsed)
        if songName:lower() == 'stargazer' or songName:lower() == 'lemon lime' or songName:lower() == 'inflorescence' or songName:lower() =='chlorophyll' or dadName:lower() == 'blackv4' then
        else
            local inputAmazing=nil
            local sustainFuckUp=nil
            local ActualNoteId=nil
            for a=getProperty('notes.length')-1,0,-1 do
                if getPropertyFromGroup('notes',a,'mustPress') then
                    inputAmazing=a
                    break
                end
            end
            for e=getProperty('notes.length')-1,0,-1 do
                if getPropertyFromGroup('notes',e,'mustPress')== true and getPropertyFromGroup('notes',e,'isSustainNote') then
                    sustainFuckUp=e
                    break
                end
            end
                for i=getProperty('notes.length')-1,0,-1 do
                    if getPropertyFromGroup('notes',i,'mustPress')== false then
                        ActualNoteId=i
                        break
                    end
                end
                
                if sustainFuckUp~=nil then
                if getPropertyFromGroup('notes',sustainFuckUp,'strumTime')<=getSongPosition() +100 and keyPressed(keyPress[getPropertyFromGroup('notes',sustainFuckUp,'noteData') + 1])then
                playAnim('boyfriend', singAnimations[getPropertyFromGroup('notes',sustainFuckUp,'noteData') + 1],true)
                removeFromGroup('notes',sustainFuckUp,false)
                setProperty('health', getProperty('health') + 0.005)
                end
                end

                if getPropertyFromGroup('notes',inputAmazing,'strumTime')<=getSongPosition() - 25 then
                    --playAnim('boyfriend', ''..singAnimations[getPropertyFromGroup('notes',inputAmazing,'noteData') + 1]..'miss',true)
                    setPropertyFromGroup('notes', inputAmazing, 'blockHit', true)
                    setPropertyFromGroup('notes', inputAmazing, 'alpha', 0)
                    setProperty('health', getProperty('health') - 0.01) 
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
            triggerEvent('Camera Follow Pos',getProperty('gf.x') + 260,getProperty('gf.y') + 300)
            setProperty('defaultCamZoom', 0.5)
            setProperty('defeatfnf.alpha', 0)
            for i=1,#showThemParts do
            setProperty(''..showThemParts[i]..'.alpha',1)
            end
        end
        if curSection == 89 then
            kadeSwitch()
            triggerEvent('Change Character', 'dad', 'black')
            triggerEvent('Change Character', 'boyfriend', 'boyfriend')
            triggerEvent('Camera Follow Pos','','')
            setProperty('defaultCamZoom', 0.9)
            setProperty('defeatfnf.alpha', 1)
            for i=1,#showThemParts do
            removeLuaSprite(showThemParts[i], true)
            end
            --[[
            makeAnimatedLuaSprite('shit', 'characters/BF_Defeat_Scared')
            makeAnimatedLuaSprite('shit2', 'characters/black')
            ]]
        end
    end
end

function onBeatHit()
    if songName:lower() == 'stargazer' or songName:lower() == 'lemon lime' or songName:lower() == 'inflorescence' or songName:lower() =='chlorophyll' then
    else
    if songName:lower() == 'defeated-v5' then
    objectPlayAnimation('defeatthing', 'bop')
    end
    if curBeat % 2 == 0 then
        if getProperty('boyfriend.animation.curAnim.curFrame') <= 1 then
            --e
            else
            playAnim('boyfriend', 'idle', true)
        
        if dadName == 'black' or dadName == 'blackv4' then
            if getProperty('dad.animation.curAnim') == 'idle' then
            --wow
            end
        else
                if getProperty('dad.animation.curAnim.curFrame') >= 6 then
                    --playAnim('dad', 'idle', true)
                    else
                    --e
                end
            end
        end
    end
end
end