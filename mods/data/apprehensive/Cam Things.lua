function onMoveCamera(focus)
    if focus == 'dad' then
        setProperty('defaultCamZoom', 0.85)
    elseif focus == 'boyfriend' then
        setProperty('defaultCamZoom', 1.1)
    end
end
