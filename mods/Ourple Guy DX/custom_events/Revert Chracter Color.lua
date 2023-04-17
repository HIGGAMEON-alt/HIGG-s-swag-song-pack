function onEvent(n, v1, v2)
if n == 'Revert Character Color' then
if v1 == 'boyfriend' then
doTweenColor('bf'..v2, 'boyfriend', 16777215, v2, 'quadOut')
end
if v1 == 'dad' then
doTweenColor('dad'..v2, 'dad', 16777215, v2, 'quadOut')
end
if v1 == 'gf' then
doTweenColor('gf'..v2, 'gf', 16777215, v2, 'quadOut')
end
if v1 == 'all' then
doTweenColor('EEEBF'..v2, 'boyfriend', 16777215, v2, 'quadOut')
doTweenColor('EEEDAD'..v2, 'dad', 16777215, v2, 'quadOut')
doTweenColor('EEEGF'..v2, 'gf', 16777215, v2, 'quadOut')
end
end
end