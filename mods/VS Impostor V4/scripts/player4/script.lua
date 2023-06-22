--[[
FNFOnline shit is weird fr fr
how to make it detect image to download

makeLuaSprite('','sick',0,0)
makeLuaSprite('','good',0,0)
makeLuaSprite('','bad',0,0)
makeLuaSprite('','shit',0,0)

makeAnimatedLuaSprite('','noteSplashes',0,0)
makeAnimatedLuaSprite('','characters/bf_legs',0,0)
makeAnimatedLuaSprite('','characters/blacklegs',0,0)
]]

local step = 0
local setPos = {0,0}
local lockedCamera = false
local SONG = nil
local stageData = nil
local secondopp = false
local player = nil
local songPlaceHolder
local realCamZoomie
local json

function onCreatePost()
    realCamZoomie = true
    curZoom = getProperty('defaultCamZoom')
    --setPropertyFromClass('ClientPrefs', 'camZooms', false)
    json = dofile('HIGGAMEON-alt%HIGG-s-swag-song-pack/mods/VS Impostor V4/scripts/JSONLIB.lua')
    songPlaceHolder = json.parse(getTextFromFile('data/'..songName..'/'..songName..'-'..difficultyName..'.json'))
    SONG = songPlaceHolder.song
    SONGOTHERCHECK = runHaxeCode([=[
      return [Song.loadFromJson(PlayState.SONG.song + '-other', PlayState.SONG.song)];
    ]=])[1]

    if SONGOTHERCHECK == nil then
    else
    addLuaScript('scripts/player4/player4_secondChart_handler')
    end
    --[[SONG = runHaxeCode([=[
      return [Song.loadFromJson(Highscore.formatSong(PlayState.SONG.song, PlayState.storyDifficulty), Paths.formatToSongPath(PlayState.SONG.song))];
    ]=])[1]]
    addHaxeLibrary('FunkinLua')
    addHaxeLibrary('StageData')
    stageData = json.parse(getTextFromFile('stages/'..curStage..'.json'))
    --setOnLuas('stageData', stageData_placeHolder)
    player = {{'boyfriend', boyfriendName}, {'dad', dadName}, {'gf', gfName}}
    --player[1][2] = json.parse(getTextFromFile('characters/'..player[1][2]..'.json'))
    --player[2][2] = json.parse(getTextFromFile('characters/'..player[2][2]..'.json'))
    --player[3][2] = json.parse(getTextFromFile('characters/'..player[3][2]..'.json'))
    --[[
    addCharacterToList('reginald')
    addCharacterToList('ellie')
    addCharacterToList('madgus')
    addCharacterToList('biddle')
    addCharacterToList('blackdk')
    ]]
    if SONG.player4 == nil then
    secondopp = false
    else
        secondopp = true
        makeChar('blackdk', 'mom', false, 'Opponent', stageData.secondopp[1], stageData.secondopp[2], {'Opponent 2 Sing', 'Both Opponents Sing'})
    end
end

--[[
TUTORIAL!
The first variable is the character .json name so we can
grab the chracter information.

The second variable is the property name so you dont have
to use the Json name as the variable

the second variable is bool if it's a player or not

The third variable is if we grab the notes from the opponent strum, player strum, or both.
you can set is as one of the following : [opponent,player,both]

the firth variable is x position

the sixth variable is the y position

and the seventh variable are the notes you want it to set to for it to hit, leave it blank to
hit all notes
]]

function addToList(variable, whatToAdd)
variable[#variable + 1] = whatToAdd
end

--[[
takeStrumsFrom
Player
Opponent
Both
]]

function makeChar(JsonFileName,name,isPlayer,takeStrumsFrom,x,y, strictNotes)
addToList(player,{name,JsonFileName, x, y})
player[#player][2] = json.parse(getTextFromFile('characters/'..player[#player][2]..'.json'))
player[#player][3] = isPlayer
if strictNotes == nil then
player[#player][4] = nil
else
player[#player][4] = strictNotes
end
player[#player][5] = takeStrumsFrom:lower()
makeAnimatedLuaSprite(player[#player][1], player[#player][2].image, x, y)
for i=1,#player[#player][2].animations do
addAnimationByPrefix(player[#player][1], player[#player][2].animations[i].anim, player[#player][2].animations[i].name, player[#player][2].animations[i].fps, false)
if player[#player][2].animations[i].anim == 'idle' then
player[#player][6] = true
end
if player[#player][2].animations[i].anim == 'danceLeft' then
player[#player][6] = false
end
end
if player[#player][3] then
setProperty(player[#player][1]..'.flipX', not player[#player][2].flip_x)
else
setProperty(player[#player][1]..'.flipX', player[#player][2].flip_x)
end
addLuaSprite(player[#player][1])
setProperty(player[#player][1]..'.antialiasing', not player[#player][2].no_antialiasing)
setObjectOrder(player[#player][1], getObjectOrder('dadGroup') + 1)
scaleObject(player[#player][1], player[#player][2].scale, player[#player][2].scale)
if player[#player][6] then
playCharAnim(player[#player][1], 'idle', true)
else
playCharAnim(player[#player][1], 'danceLeft', true)
end
end

function grabPlayer(tag, jsonorName)
for i=1,#player do
if player[i][1] == tag then
local hereYouGo = player[i]
return hereYouGo
end
end
end

function playCharAnim(n,id,forced)
    for i=1,#grabPlayer(n, true)[2].animations do
        if grabPlayer(n, true)[2].animations[i].anim == id then
            playAnim(grabPlayer(n)[1],id, not grabPlayer(n, true)[2].animations[i].anim.loop)
            end
        if getProperty(''..grabPlayer(n)[1]..'.offset.x') == grabPlayer(n, true)[2].animations[i].offsets[1] - grabPlayer(n, true)[2].position[1] and getProperty(grabPlayer(n)[1]..'.offset.y') == grabPlayer(n, true)[2].animations[i].offsets[2] - grabPlayer(n, true)[2].position[2] then
        else
        if grabPlayer(n, true)[2].animations[i].anim == getProperty(grabPlayer(n)[1]..'.animation.curAnim.name') then
        anim = i
        setProperty(grabPlayer(n)[1]..'.offset.x', grabPlayer(n, true)[2].animations[anim].offsets[1] - grabPlayer(n, true)[2].position[1])
        setProperty(grabPlayer(n)[1]..'.offset.y', grabPlayer(n, true)[2].animations[anim].offsets[2] - grabPlayer(n, true)[2].position[2])
        end
    end
    end
end

--props goes to LEON BROTHER in the Friday Night Funkin' Moddin Community server for helping me grab the note IDs and organizing code!

function changeP2Icon(name)
runHaxeCode([[game.iconP2.changeIcon(']]..name.healthicon..[[');]])
end
function changeP1Icon(name)
runHaxeCode([[game.iconP1.changeIcon(']]..name.healthicon..[[');]])
end


function opponentNoteHit(id, singAnimationsection, noteType, isSustainNote)
    setProperty('camZooming', true)
    if songName == 'double-kill' and altAnim then
    local dadFrame = getProperty('dad.animation.curAnim.curFrame')
    playCharAnim('mom', singAnimations[singAnimationsection + 1], true)
    changeP2Icon(grabPlayer('mom')[2])
    playAnim('dad', 'idle', true)
    setProperty('dad.animation.curAnim.curFrame', dadFrame)
    end
    if getProperty('dad.animation.curAnim.name') == 'idle' then
    else
    changeP2Icon(json.parse(getTextFromFile('characters/'..SONG.player2..'.json')))
    end
    for i=1,#player do
        if player[i][5] == 'opponent' then
            if player[i][3] == false then
                if player[i][4] == nil then
                    playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                else
                    for j=1,#player[i][4] do
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        if player[i][4][j] == 'Alt Animation' and player[i][4][j] == noteType or altAnim and player[i][4][j] == 'Alt Animation' then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1]..'-alt', true)
                        changeP2Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == 'Opponent 2 Sing' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP2Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == 'Both Opponents Sing' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP2Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] =='' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP2Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == nil then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        end
                    end
                end
            end
        end
    end
end

function goodNoteHit(id, singAnimationsection, noteType, isSustainNote)
    setProperty('camZooming', true)
    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
    else
    changeP1Icon(json.parse(getTextFromFile('characters/'..SONG.player1..'.json')))
    end
    for i=1,#player do
        if player[i][5] == 'player' then
            if player[i][3] == true then
                if player[i][4] == nil then
                    playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                else
                    for j=1,#player[i][4] do
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        if player[i][4][j] == 'Alt Animation' and player[i][4][j] == noteType or altAnim and player[i][4][j] == 'Alt Animation' then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1]..'-alt', true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == 'Opponent 2 Sing' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == 'Both Opponents Sing' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] =='' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == nil then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                    end
                end
                end
            end
        end
    end
end


--there, no more props :smiling_imp: 

--[[
setOnLuas function made by 💜 Rodney, Imaginative Person 💙 on the Psych Server!
Be sure to check out their scripts, they're useful!
]]
function setOnLuas(varName, valueInput)
    if not setOnLuas_init then --makes the var holder
        setOnLuas_init = true
        runHaxeCode('setVar("setOnLuas_varHolder", null);')
    end
    setProperty('setOnLuas_varHolder', {varName, valueInput}) --sets the temp shit
    --actually set the whatever
    runHaxeCode("game.setOnLuas(getVar('setOnLuas_varHolder')[0], getVar('setOnLuas_varHolder')[1]);")
    setProperty('setOnLuas_varHolder', nil) --go away DIE DIE DIE!!!!!!!!
    --if its onCreate then it doesnt work because the lua file wouldn't be in the luaArray yet
    if _G[varName] == nil then _G[varName] = valueInput end
end

function onBeatHit()
    if camTwist then
        if curBeat % 2 == 0 then
            twistShit = twistAmount
        else
            twistShit = 0-twistAmount
        end
        setProperty('camHUD.angle', twistCrap * camTwistIntensity2)
        setProperty('camGame.angle', twistCrap * camTwistIntensity2)
        doTweenAngle('beatTwistHUD3', 'camHUD', twistCrap * camTwistIntensity, getPropertyFromClass('Conductor', 'stepCrochet') * 0.001, 'circout')
        doTweenX('beatTwistHUD4', 'camHUD', 0-twistCrap * camTwistIntensity, getPropertyFromClass('Conductor', 'stepCrochet') * 0.001, 'linear')
        doTweenAngle('beatTwistGame3', 'camGame', twistCrap * camTwistIntensity, getPropertyFromClass('Conductor', 'stepCrochet') * 0.001, 'circout')
        doTweenX('beatTwistGame4', 'camGame', 0-twistCrap * camTwistIntensity, getPropertyFromClass('Conductor', 'stepCrochet') * 0.001, 'linear')
    end
if step == 0 then
step = 1
end
if step == 1 then
step = 0
end
for i=1,#player do
if player[i][6] then
if curBeat % 2 == 0 then
if getProperty(player[i][1]..'.animation.curAnim.finished') then
playCharAnim(player[i][1], 'idle', true)
end
end
end
if player[i][6] == false then
if getProperty(player[i][1]..'.animation.curAnim.finished') then
if curBeat % 2 == 0 then
playCharAnim(player[i][1], 'danceLeft', true)
else
playCharAnim(player[i][1], 'danceRight', true)
end
end
end
end
end

function onEvent(n,v1,v2,v3)
    if n == 'Camera Twist' then
        camTwist = true
        camTwistIntensity = tonumber(value1)
        camTwistIntensity2 = tonumber(value2)
        if v1 == nil or v1 == '' then camTwistIntensity = 0 end
        if v2 == nil or v2 == '' then camTwistIntensity2 = 0 end
        if camTwistIntensity2 == 0 then
            camTwist = false
            cancelTween('beatTwistGame4')
            cancelTween('beatTwistHUD4')
            doTweenX('beatTwistHUD3', 'camHUD', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
            doTweenX('beatTwistGame3', 'camGame.scroll', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
            doTweenAngle('beatTwistHUD2', 'camHUD', 0, 1, 'sineinout')
            doTweenAngle('beatTwistGame2', 'camGame', 0, 1, 'sineinout')
            doTweenY('beatTwistHUD', 'camHUD', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
            doTweenY('beatTwistGame', 'camGame.scroll', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
        end
    end
    if n == 'Alter Camera Bop' then
        camBopIntensity = tonumber(value1)
        camBopInterval = tonumber(value2)
        if v1 == nil or v1 == '' then camBopIntensity = 1 end
        if v2 == nil or v2 == '' then camBopInterval = 4 end
        beatStep()
    end
    if n == 'Add Camera Zoom' then
        if realCamZoomie and curZoom < 1.35 then
            local camZoom = tonumber(v1)
            local hudZoom = tonumber(v2)
            if v1 == nil or v1 == '' then camZoom = 0.015 end
            if v2 == nil or v2 == '' then hudZoom = 0.03 end
            curZoom = curZoom + camZoom
            setProperty('camHUD.zoom', getProperty('camHUD.zoom') + hudZoom)
        end
    end
    if n == 'Camera Follow Pos' then -- mid focus, not in original mod but funni !!
        if v1 == 'mid' or v1 == 'middle' then
            cameraSetTarget('boyfriend')
            local boyCamPos = {getProperty('camFollow.x'), getProperty('camFollow.y')}
            cameraSetTarget('dad')
            local dadCamPos = {getProperty('camFollow.x'), getProperty('camFollow.y')}
            local midCamPos = {(boyCamPos[1] + dadCamPos[1]) / 2, (boyCamPos[2] + dadCamPos[2]) / 2}
            setProperty('camFollow.x', midCamPos[1])
            setProperty('camFollow.y', midCamPos[2])
            setProperty('isCameraOnForcedPos', true)
        end
    end
    if n == 'Extra Cam Zoom' then
        extraZoom = tonumber(v1) or 0
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - oldExtra + extraZoom)
    end
if n:lower() == 'change character' then
if v2 == 2 or v2 == 'dad' or v2 == 'opponent' then
setOnLuas('dadName', v1)
end
end
if n == 'Ellie Drop' then
setProperty('mom.visible', true)
playCharAnim('mom', 'enter', true)
end
if n:lower() == 'playcharanim' then
playCharAnim(v1,v2,v3)
end
if n:lower() == 'cam lock in voting time' then
    lockedCamera = true
if v1:lower() == 'in' then
    zoom = 1.25
if v2:lower() == 'dad' then
    setPos[1] = 460
    setPos[2] = 700
    runHaxeCode([[
        FlxG.camera.focusOn(camFollowPos.getPosition());
    ]])
    else
        setPos[1] = 1460
        setPos[2] = 700
        runHaxeCode([[
            FlxG.camera.focusOn(camFollowPos.getPosition());
        ]])
    end
end
if v1:lower() == 'close' then
    zoom = 1.25
    if v2:lower() == 'dad' then
        setPos[1] = 480
        setPos[2] = 680
        runHaxeCode([[
            FlxG.camera.focusOn(camFollowPos.getPosition());
        ]])
        else
            setPos[1] = 1450
            setPos[2] = 680
            runHaxeCode([[
				FlxG.camera.focusOn(camFollowPos.getPosition());
            ]])
        end
    end
else
    setPos[1] = 960
    setPos[2] = 540
    zoom = 0.7
runHaxeCode([[
    FlxG.camera.focusOn(camFollowPos.getPosition());
]])
end
end

function onUpdate(elapsed)
if getProperty('dad.animation.curAnim.finished') then
playAnim('dad', 'idle')
end
if lockedCamera then
setProperty('camFollow.x', setPos[1])
setProperty('camFollow.y', setPos[2])
setProperty('camFollowPos.x', setPos[1])
setProperty('camFollowPos.y', setPos[2])
setProperty('defaultCamZoom', zoom)
setProperty('camGame.zoom', zoom)
end
end


function noteMiss(jk,id)
    for i=1,#player do
        if player[i][5] == 'player' then
            if player[i][3] == true then
            playCharAnim(player[i][1], singAnimations[id + 1]..'miss', true)
            end
        end
    end
end

function noteMissPress(id)
    for i=1,#player do
        if player[i][5] == 'player' then
            if player[i][3] == true then
            playCharAnim(player[i][1], singAnimations[id + 1]..'miss', true)
            end
        end
    end
end

function onCountdownTick(tick)
if tick == 2 then
for i=1,#player do
playCharAnim(player[i][1], 'idle', true)
end
end
if tick == 3 and songName:lower() == 'defeat' then
triggerEvent('Change Character', 'dad', 'dad')
triggerEvent('Change Character', 'dad', 'black')
end
end

--[[
camtwist specificaly
I STOLE THIS SHIT FROM THE PSYCH SERVER!!!!!
From KaiTwi[excluding tag bitch]

Message link : https://discord.com/channels/922849922175340586/1080396283208028160/1080396283208028160
]]

local realCamZoomie = true
local camBopIntensity = 1
local camBopInterval = 4
-- uses onStepHit, meaning it can hit smaller than beats. 0.25 is one step

local camTwistIntensity = 0
local camTwistIntensity2 = 3
local camTwist = false
local twistAmount = 1
local twistCrap = 1
local extraZoom = 0
-- gotta stay pg somehow

curZoom = 1

local noPreZoom = { -- probably should have made a preZoom var instead... maybe later
    ['sussus-moogus'] = true,
    ['sabotage'] = true,
    ['meltdown'] = true,
    ['sussus-toogus'] = true,
    ['lights-down'] = true,
    ['reactor'] = true,
    ['ejected'] = true,
    ['sauces moogus'] = true,
    defeat = true,
    ['top-10'] = true
}


function onDestroy()
    setPropertyFromClass('ClientPrefs', 'camZooms', realCamZoomie)
end

function onStepHit()
    beatStep()
    if camTwist then
        if curStep % 4 == 0 then
            doTweenY('beatTwistHUD', 'camHUD', -6 * camTwistIntensity2, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'circout')
            doTweenY('beatTwistGame', 'camGame.scroll', 12, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
        elseif curStep % 4 == 2 then
            doTweenY('beatTwistHUD', 'camHUD', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
            doTweenY('beatTwistGame', 'camGame.scroll', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
        end
    end
end

function beatStep()
    if curStep % (camBopInterval * 4) == 0 and getProperty('camZooming') then
        onEvent('Add Camera Zoom', 0.015 * getProperty('camZoomingMult') * camBopIntensity, 0.03 * getProperty('camZoomingMult') * camBopIntensity)
    end
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end

function lerp(from,to,i)
	return from+(to-from)*i
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function onUpdate(elapsed)
    setPropertyFromClass('flixel.FlxG', 'camera.zoom', curZoom)
end

function onUpdatePost(elapsed)
    if getProperty('camZooming') then
        curZoom = lerp(getProperty('defaultCamZoom') + extraZoom, curZoom, boundTo(1-(elapsed * 3.125 * getProperty('camZoomingDecay') * playbackRate), 0, 1))
        setPropertyFromClass('flixel.FlxG', 'camera.zoom', curZoom)
    end
end