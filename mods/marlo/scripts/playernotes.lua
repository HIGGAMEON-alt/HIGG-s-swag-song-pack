local Strums_Texture = ''
local Notes_Texture = ''
local Splashes_Texture = ''
function onUpdatePost()

if boyfriendName == 'bf pixel art' then
    for i = 0, getProperty('playerStrums.length')-1 do
    setPropertyFromGroup('playerStrums', i, 'texture', 'retroNOTE_assets');
        if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing' or 'normal') then
            setPropertyFromGroup('notes', i, 'texture', 'retroNOTE_assets');
        end
    end
end
if boyfriendName == 'blomie marlo' then
    for i = 0, getProperty('playerStrums.length')-1 do
    setPropertyFromGroup('playerStrums', i, 'texture', 'marloNOTE_assets');
        if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing' or 'normal') then
            setPropertyFromGroup('notes', i, 'texture', 'marloNOTE_assets');
        end
    end
end
if boyfriendName == 'louitch' then
    for i = 0, getProperty('playerStrums.length')-1 do
    setPropertyFromGroup('playerStrums', i, 'texture', 'louitchNOTE_assets');
        if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing' or 'normal') then
            setPropertyFromGroup('notes', i, 'texture', 'louitchNOTE_assets');
        end
    end
end
end