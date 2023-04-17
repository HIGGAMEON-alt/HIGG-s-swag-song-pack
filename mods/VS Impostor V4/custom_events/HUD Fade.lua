function onEvent(n,v1,v2)
if n == 'HUD Fade' then
if v1 =='' then
doTweenAlpha('HUDTHINGYMAJIGeeevwrvw','camHUD', 1, 0.1, 'elapsed')
else
doTweenAlpha('HUDTHINGYMAJIGeeevwrvw','camHUD', 1 - v1, 0.1, 'elapsed')
end
end
end