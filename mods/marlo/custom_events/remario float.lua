e = 0

function onEvent(elapsed)
    e = e + elapsed
setProperty('dad.y' + math.sin(e) * -5)
end