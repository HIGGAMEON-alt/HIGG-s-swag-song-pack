local Strums_Texture = ''
local Notes_Texture = ''
local Splashes_Texture = ''
function onUpdatePost()
    if dadName == 'sexrio' or dadName == 'hardmario' then
        for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'texture', 'marloNOTE_assets');
            if not getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'texture', 'marloNOTE_assets');
            end
        end
    end
    if dadName == 'lou itch' then   
        for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'texture', 'louitchNOTE_assets');
            if not getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'texture', 'louitchNOTE_assets');
            end
        end
    end
    if dadName == 'sebastian' or dadName == 'sebguit' or dadName == 'deadsebas' then   
        for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'texture', 'sebastianNOTE_assets');
            if not getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'texture', 'sebastianNOTE_assets');
            end
        end
    end
end