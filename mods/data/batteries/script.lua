local SONG = nil
local stageData = nil
local player = nil
local json

function onCreate()
    debugPrint('e')
    songPlaceHolder = json.parse(getTextFromFile('data/'..songName..'/'..songName..'-'..difficultyName..'.json'))
    SONG = songPlaceHolder.song
    debugPrint(SONG.song)

    stageData = json.parse(getTextFromFile('stages/'..curStage..'.json'))
    --setOnLuas('stageData', stageData_placeHolder)
    player = {{'boyfriend', boyfriendName}, {'dad', dadName}, {'gf', gfName}}

    makeChar('dad', 'mom', false, 'Opponent', stageData.opponent[1] - 100, stageData.opponent[2])
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


function opponentNoteHit(id, singAnimationsection, noteType, isSustainNote)
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
                        elseif player[i][4][j] =='' and player[i][4][j] == noteType then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP2Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        elseif player[i][4][j] == nil then
                        playCharAnim(player[i][1], singAnimations[singAnimationsection + 1], true)
                        changeP1Icon(player[i][2])
------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        else
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
                        else
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

function onBeatHit()
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
if curBeat % 4 == 0 then
playCharAnim(player[i][1], 'danceRight', true)
elseif curBeat % 2 == 0 then
playCharAnim(player[i][1], 'danceLeft', true)
end
end
end
end
end

function onEvent(n,v1,v2,v3)
if n:lower() == 'playcharanim' then
playCharAnim(v1,v2,v3)
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
end



--[[ json.lua
A compact pure-Lua JSON library.
The main functions are: json.stringify, json.parse.
## json.stringify:
This expects the following to be true of any tables being encoded:
 * They only have string or number keys. Number keys must be represented as
   strings in json; this is part of the json spec.
 * They are not recursive. Such a structure cannot be specified in json.
A Lua table is considered to be an array if and only if its set of keys is a
consecutive sequence of positive integers starting at 1. Arrays are encoded like
so: `[2, 3, false, "hi"]`. Any other type of Lua table is encoded as a json
object, encoded like so: `{"key1": 2, "key2": false}`.
Because the Lua nil value cannot be a key, and as a table value is considerd
equivalent to a missing key, there is no way to express the json "null" value in
a Lua table. The only way this will output "null" is if your entire input obj is
nil itself.
An empty Lua table, {}, could be considered either a json object or array -
it's an ambiguous edge case. We choose to treat this as an object as it is the
more general type.
To be clear, none of the above considerations is a limitation of this code.
Rather, it is what we get when we completely observe the json specification for
as arbitrary a Lua object as json is capable of expressing.
## json.parse:
This function parses json, with the exception that it does not pay attention to
\u-escaped unicode code points in strings.
It is difficult for Lua to return null as a value. In order to prevent the loss
of keys with a null value in a json string, this function uses the one-off
table value json.null (which is just an empty table) to indicate null values.
This way you can check if a value is null with the conditional
`val == json.null`.
If you have control over the data and are using Lua, I would recommend just
avoiding null values in your data to begin with.
--]]


local json = {}


-- Internal functions.

local function kind_of(obj)
  if type(obj) ~= 'table' then return type(obj) end
  local i = 1
  for _ in pairs(obj) do
    if obj[i] ~= nil then i = i + 1 else return 'table' end
  end
  if i == 1 then return 'table' else return 'array' end
end

local function escape_str(s)
  local in_char  = {'\\', '"', '/', '\b', '\f', '\n', '\r', '\t'}
  local out_char = {'\\', '"', '/',  'b',  'f',  'n',  'r',  't'}
  for i, c in ipairs(in_char) do
    s = s:gsub(c, '\\' .. out_char[i])
  end
  return s
end

-- Returns pos, did_find; there are two cases:
-- 1. Delimiter found: pos = pos after leading space + delim; did_find = true.
-- 2. Delimiter not found: pos = pos after leading space;     did_find = false.
-- This throws an error if err_if_missing is true and the delim is not found.
local function skip_delim(str, pos, delim, err_if_missing)
  pos = pos + #str:match('^%s*', pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error('Expected ' .. delim .. ' near position ' .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

-- Expects the given pos to be the first character after the opening quote.
-- Returns val, pos; the returned pos is after the closing quote character.
local function parse_str_val(str, pos, val)
  val = val or ''
  local early_end_error = 'End of input found while parsing string.'
  if pos > #str then error(early_end_error) end
  local c = str:sub(pos, pos)
  if c == '"'  then return val, pos + 1 end
  if c ~= '\\' then return parse_str_val(str, pos + 1, val .. c) end
  -- We must have a \ character.
  local esc_map = {b = '\b', f = '\f', n = '\n', r = '\r', t = '\t'}
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then error(early_end_error) end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

-- Returns val, pos; the returned pos is after the number's final character.
local function parse_num_val(str, pos)
  local num_str = str:match('^-?%d+%.?%d*[eE]?[+-]?%d*', pos)
  local val = tonumber(num_str)
  if not val then error('Error parsing number at position ' .. pos .. '.') end
  return val, pos + #num_str
end


-- Public values and functions.

function json.stringify(obj, as_key)
  local s = {}  -- We'll build the string as an array of strings to be concatenated.
  local kind = kind_of(obj)  -- This is 'array' if it's an array or type(obj) otherwise.
  if kind == 'array' then
    if as_key then error('Can\'t encode array as key.') end
    s[#s + 1] = '['
    for i, val in ipairs(obj) do
      if i > 1 then s[#s + 1] = ', ' end
      s[#s + 1] = json.stringify(val)
    end
    s[#s + 1] = ']'
  elseif kind == 'table' then
    if as_key then error('Can\'t encode table as key.') end
    s[#s + 1] = '{'
    for k, v in pairs(obj) do
      if #s > 1 then s[#s + 1] = ', ' end
      s[#s + 1] = json.stringify(k, true)
      s[#s + 1] = ':'
      s[#s + 1] = json.stringify(v)
    end
    s[#s + 1] = '}'
  elseif kind == 'string' then
    return '"' .. escape_str(obj) .. '"'
  elseif kind == 'number' then
    if as_key then return '"' .. tostring(obj) .. '"' end
    return tostring(obj)
  elseif kind == 'boolean' then
    return tostring(obj)
  elseif kind == 'nil' then
    return 'null'
  else
    error('Unjsonifiable type: ' .. kind .. '.')
  end
  return table.concat(s)
end

json.null = {}  -- This is a one-off table to represent the null value.

function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then error('Reached unexpected end of input.') end
  local pos = pos + #str:match('^%s*', pos)  -- Skip whitespace.
  local first = str:sub(pos, pos)
  if first == '{' then  -- Parse an object.
    local obj, key, delim_found = {}, true, true
    pos = pos + 1
    while true do
      key, pos = json.parse(str, pos, '}')
      if key == nil then return obj, pos end
      if not delim_found then error('Comma missing between object items.') end
      pos = skip_delim(str, pos, ':', true)  -- true -> error if missing.
      obj[key], pos = json.parse(str, pos)
      pos, delim_found = skip_delim(str, pos, ',')
    end
  elseif first == '[' then  -- Parse an array.
    local arr, val, delim_found = {}, true, true
    pos = pos + 1
    while true do
      val, pos = json.parse(str, pos, ']')
      if val == nil then return arr, pos end
      if not delim_found then error('Comma missing between array items.') end
      arr[#arr + 1] = val
      pos, delim_found = skip_delim(str, pos, ',')
    end
  elseif first == '"' then  -- Parse a string.
    return parse_str_val(str, pos + 1)
  elseif first == '-' or first:match('%d') then  -- Parse a number.
    return parse_num_val(str, pos)
  elseif first == end_delim then  -- End of an object or array.
    return nil, pos + 1
  else  -- Parse true, false, or null.
    local literals = {['true'] = true, ['false'] = false, ['null'] = json.null}
    for lit_str, lit_val in pairs(literals) do
      local lit_end = pos + #lit_str - 1
      if str:sub(pos, lit_end) == lit_str then return lit_val, lit_end + 1 end
    end
    local pos_info_str = 'position ' .. pos .. ': ' .. str:sub(pos, pos + 10)
    error('Invalid json syntax starting at ' .. pos_info_str)
  end
end

return json