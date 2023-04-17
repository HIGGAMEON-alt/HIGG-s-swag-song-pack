local iconBop = false

function onCreatePost()
    makeLuaSprite('P2iconscale', nil, 0, 1)
    addLuaSprite('P2iconscale', false)
    setProperty('P2iconscale.visible', false)
end

function onUpdatePost(elapsed)
if dadName == 'pourage' then
    function onStepHit()
      if getProperty('healthBar.percent') > 80 and curStep % 4 == 0 then
        setProperty('P2iconscale.y', 1.4)
        setProperty('iconP2.angle', -8)
        
        doTweenAngle('AAA', 'iconP2', 1, 0.15, 'quadOut')
        doTweenY('AAEA', 'P2iconscale', 1, 0.15, 'bounceOut')
        end
   end
   if getProperty('P2iconscale.y') == 1 then
    --e
   else
    setProperty('iconP2.scale.y', getProperty('P2iconscale.y'))
end
end
end