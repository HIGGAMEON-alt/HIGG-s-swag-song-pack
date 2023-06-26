--[[
FNF Online shit weird

makeLuaSprite('e', 'sick', 0, 0)
makeLuaSprite('e', 'good', 0, 0)
makeLuaSprite('e', 'bad', 0, 0)
makeLuaSprite('e', 'shit', 0, 0)

makeAnimatedLuaSprite('e','noteSplashes',0,0)
]]

local step = 0
local setPos = {0,0}
local lockedCamera = false
local player

function onCreate()
    json = dofile('HIGGAMEON-alt%HIGG-s-swag-song-pack/mods/VS Impostor V4/scripts/JSONLIB.lua')
    stageData_placeHolder = json.parse(getTextFromFile('stages/'..curStage..'.json'))
    stageData = stageData_placeHolder
    songPlaceHolder = json.parse(getTextFromFile('data/'..songName..'/'..songName..'-'..difficultyName..'.json'))
    SONG = songPlaceHolder.song
    player = {{'boyfriend', boyfriendName}, {'dad', dadName}, {'gf', gfName}}
    if SONG.player4 == nil then
    else
        if SONG.player4 == 'blackdk' then
        makeChar(SONG.player4, 'mom', false, 'Opponent', stageData.secondopp[1], stageData.secondopp[2], {'Opponent 2 Sing', 'Both Opponents Sing', 'Alt Animation'})
        else
        makeChar(SONG.player4, 'mom', false, 'Opponent', stageData.secondopp[1], stageData.secondopp[2], {'Opponent 2 Sing', 'Both Opponents Sing'})
        end
    end
    triggerEvent('Change Character', 'dad', 'ellie')
    triggerEvent('Change Character', 'dad', 'madgus')
    triggerEvent('Change Chracter', 'dad', 'reginald')
    triggerEvent('Change Character', 'dad', SONG.player2)
end

function onCreatePost()
    dadoffx = getProperty('dad.offset.x')
    dadoffy = getProperty('dad.offset.y')
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
if json.parse(getTextFromFile('characters/'..player[#player][2]..'.json')) == nil then
else
player[#player][2] = json.parse(getTextFromFile('characters/'..player[#player][2]..'.json'))
end
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
            playAnim(grabPlayer(n)[1],id,not grabPlayer(n, true)[2].animations[i].anim.loop)
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

local dir = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

--props goes to LEON BROTHER in the Friday Night Funkin' Moddin Community server for helping me grab the note IDs and organizing code!

function changeP2Icon(name)
runHaxeCode([[game.iconP2.changeIcon(']]..name.healthicon..[[');]])
end
function changeP1Icon(name)
runHaxeCode([[game.iconP1.changeIcon(']]..name.healthicon..[[');]])
end


function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('dad.animation.curAnim.name') == 'idle' then
    else
    changeP2Icon(json.parse(getTextFromFile('characters/'..SONG.player2..'.json')))
    end
    for i=1,#player do
        if player[i][5] == 'opponent' then
            if player[i][3] == false then
                if player[i][4] == nil then
                    playCharAnim(player[i][1], dir[direction + 1], true)
                else
                    for j=1,#player[i][4] do
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        if player[i][4][j] == 'Alt Animation' and player[i][4][j] == noteType or altAnim and player[i][4][j] == 'Alt Animation' then
                        if songName:lower() == 'double-kill' then
                        playCharAnim(player[i][1], dir[direction + 1]..'', true)
                        changeP2Icon(player[i][2])
                        setProperty('dad.offset.x', dadoffx)
                        setProperty('dad.offset.y', dadoffy)
                        else
                        playCharAnim(player[i][1], dir[direction + 1]..'-alt', true)
                        changeP2Icon(player[i][2])
                        end
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == 'Opponent 2 Sing' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], dir[direction + 1], true)
                        changeP2Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == 'Both Opponents Sing' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], dir[direction + 1], true)
                        changeP2Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] =='' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], dir[direction + 1], true)
                        changeP2Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == nil then
                        playCharAnim(player[i][1], dir[direction + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        end
                    end
                end
            end
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
    else
    changeP1Icon(json.parse(getTextFromFile('characters/'..SONG.player1..'.json')))
    end
    for i=1,#player do
        if player[i][5] == 'player' then
            if player[i][3] == true then
                if player[i][4] == nil then
                    playCharAnim(player[i][1], dir[direction + 1], true)
                else
                    for j=1,#player[i][4] do
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        if player[i][4][j] == 'Alt Animation' and player[i][4][j] == noteType or altAnim and player[i][4][j] == 'Alt Animation' then
                        playCharAnim(player[i][1], dir[direction + 1]..'-alt', true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == 'Opponent 2 Sing' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], dir[direction + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == 'Both Opponents Sing' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], dir[direction + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] =='' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], dir[direction + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == nil then
                        playCharAnim(player[i][1], dir[direction + 1], true)
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

function onBeatHit()
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
if n:lower() == 'change character' then
if v2 == 2 or v2 == 'dad' or v2 == 'opponent' then
setOnLuas('dadName', v1)
end
end
if n:lower() == 'playcharanim' then
playCharAnim(v1,v2,v3)
end
if n == 'Ellie Drop' then
setProperty('mom.alpha', 1)
playCharAnim('mom', 'enter', true)
end
end


function noteMiss(jk,id)
    for i=1,#player do
        if player[i][5] == 'player' then
            if player[i][3] == true then
            playCharAnim(player[i][1], dir[id + 1]..'miss', true)
            end
        end
    end
end

function noteMissPress(id)
    for i=1,#player do
        if player[i][5] == 'player' then
            if player[i][3] == true then
            playCharAnim(player[i][1], dir[id + 1]..'miss', true)
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
end