local disableLyrics = false
local colorLyrics = nil
local textLyrics = ''
local hideHud = false

local number1 = nil
local number2 = nil
local startLeters = 0
local allTextLeters = 0
local textValue2Preview = ''
local bordersEnabled = false
local LyricsInExecutation = false

function onUpdate()
    for eventNotes = 0,getProperty('eventNotes.length')-1 do
        if (getPropertyFromGroup('eventNotes',eventNotes,'strumTime') - getSongPosition()) < 350 and getPropertyFromGroup('eventNotes',eventNotes,'event') == 'Lyrics' and LyricsInExecutation == false then
            textValue2Preview = getPropertyFromGroup('eventNotes',eventNotes,'value2')
            if string.find(string.lower(textValue2Preview),',borders:false') == nil then
                makeLuaSprite('blackBorderLyrics1',nil,0,-170)
                makeLuaSprite('blackBorderLyrics2',nil,0,720)
                for blackBorders = 1,2 do
                    makeGraphic('blackBorderLyrics'..blackBorders,screenWidth,170,'000000')
                    if string.find(string.lower(textValue2Preview),',cinematic:true') == nil then
                        setObjectCamera('blackBorderLyrics'..blackBorders,'other')
                        addLuaSprite('blackBorderLyrics'..blackBorders,true)
                    else
                        setObjectCamera('blackBorderLyrics'..blackBorders,'hud')
                        addLuaSprite('blackBorderLyrics'..blackBorders,false)
                    end
                end
                doTweenY('comeBlack1','blackBorderLyrics1',0,1,'quartOut')
                doTweenY('comeBlack2','blackBorderLyrics2',screenHeight - 170,1,'quartOut')
                bordersEnabled = true
            else
                if bordersEnabled == true then
                    backBorders()
                    bordersEnabled = false
                end
            end
            LyricsInExecutation = true
        end
    end
    if disableLyrics == true then
        setProperty('LyricsWow.alpha',getProperty('LyricsWow.alpha') - 0.05)
        if getProperty('LyricsWow.alpha') <= 0 then
            removeLuaText('LyricsWow',false)
            if bordersEnabled == false then
                LyricsInExecutation = false
            end
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Lyrics' then
        textLyrics = v1
        number1,number2 = string.find(string.lower(v1),'--0x',0,true)
        startLeters,allTextLeters = string.find(v1,v1,0,true)
        if number1 ~= nil and number2 ~= number1 + 4 then
            colorLyrics = string.sub(v1,number2 + 1,allTextLeters)
            textLyrics = string.sub(v1,startLeters,allTextLeters - 10)
        else
            colorLyrics = 'FFFFFF'
        end
        if string.find(string.lower(v2),'hidehud:true',0,true) ~= nil then
            hideHud = true
            doTweenAlpha('hudAlphaEvent','camHUD',0,0.4,'linear')
        end
        makeLuaText('LyricsWow',textLyrics,1280,0,600)
        setTextColor('LyricsWow',colorLyrics)

        setProperty('LyricsWow.scale.x',1.5)
        setProperty('LyricsWow.scale.y',1.5)
        setObjectCamera('LyricsWow','other')
        addLuaText('LyricsWow',true)
        setProperty('LyricsWow.alpha',1)
        --setProperty('LyricsWow.antialiasing',false)
        if getPropertyFromClass('PlayState','isPixelStage') == true then

            setTextFont('LyricsWow','sonic-1-hud-font.ttf')
            setProperty('LyricsWow.scale.x',2.2)
            setProperty('LyricsWow.scale.y',2)
        end
        if string.find(string.lower(v2),',borders:true') ~= nil then
            setTextBorder('LyricsWow',0,'000000')
            setObjectOrder('LyricsWow',getObjectOrder('blackBorderLyrics2') + 1)
        else
            setTextBorder('LyricsWow',1,'000000')
        end
        runTimer('removeLyricsEvent',tonumber(v2))
        runTimer('removeLyricsBars',tonumber(v2) + 2)
        disableLyrics = false

    elseif name == 'Close Lyrics' and LyricsInExecutation == true then
        disableLyrics = true
        number1 = nil
        number2 = nil
        backBorders()
        LyricsInExecutation = false
        if hideHud == true then
            doTweenAlpha('hudAlphaEvent','camHUD',1,0.6,'linear')
            hideHud = false
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'removeLyricsEvent' then
        disableLyrics = true
    end
end
function backBorders()
    doTweenY('backBlack1','blackBorderLyrics1',-170,2,'quartOut')
    doTweenY('backBlack2','blackBorderLyrics2',screenHeight,2,'quartOut')
end
function onTweenCompleted(tag)
    if string.find(tag,'blackBlack') ~= nil then
        for blackBorders = 1,2 do
            if tag == 'backBlack'..blackBorders then
                removeLuaSprite('blackBorderLyrics'..blackBorders,false)
            end
        end
    end
end
