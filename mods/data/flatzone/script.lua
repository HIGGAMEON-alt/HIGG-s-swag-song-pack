function onCreate()
    if difficultyName == 'secret' then
        setCharacterX('dad', 770)
        setCharacterY('dad', 100)

        setCharacterX('boyfriend', 100)
        setCharacterY('boyfriend', 100)

        setProperty('dad.flipX', false)
        setProperty('boyfriend.flipX', false)

        setProperty('opponentCameraOffset[0]', getProperty('opponentCameraOffset[0]') - 200)
        setProperty('boyfriendCameraOffset[0]', getProperty('boyfriendCameraOffset[0]') + 200)

        addLuaScript('custom_events/Change Notes')
        addLuaScript('custom_events/Change Splashes')
    end
end

function onBeatHit()
    if difficultyName == 'secret' then
        for i = 0, 7 do
            local key = (i % 4)
            local name = i > 3 and "defaultOpponentStrum" or "defaultPlayerStrum"
            if curBeat == 4 and not middlescroll then
                noteTweenX('move' .. i, i, _G[name .. "X" .. key], 1.2, 'back')
            end
        end
        if curBeat == 4 or curBeat == 6 or curBeat == 8 then
            triggerEvent('Change Notes', 'dad', 'notes/G&W_assets')
            triggerEvent('Change Notes', 'boyfriend', 'NOTE_assets')
            triggerEvent('Change Splashes', 'noteSplashes')
        end
        if curBeat == 5 or curBeat == 7 or curBeat == 9 then
            triggerEvent('Change Notes', 'dad', 'NOTE_assets')
            triggerEvent('Change Notes', 'boyfriend', 'notes/G&W_assets')
            triggerEvent('Change Splashes', 'notes/splashes/g&wSplashes')
        end
    end
end