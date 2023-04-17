function onEvent(n,v1)
if n == "ChangeBG" then
addLuaScript("stages/"..v1)
oldBGShit = {v2}
removeOldBG(oldBGShit[2])
removeLuaScript(oldBGShit[1])
end
end

function removeOldBG(Stuff, num)
removeLuaSprite(Stuff[num])
if getProperty(Stuff[num + 1]..".x" == nil) then
--debugPrint('works!')
else
removeOldBG(stuff, num + 1)
end
end