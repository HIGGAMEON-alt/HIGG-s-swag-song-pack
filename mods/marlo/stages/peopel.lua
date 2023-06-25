function onCreate()

	makeAnimatedLuaSprite('boo','crowdpeoples',-420, 400)
    addAnimationByPrefix('boo','bitches crouds','bitches crouds',24,false)
    setScrollFactor('boo', 0.8, 0.8)
	
	makeLuaSprite('bg', 'peoples background', -2000, -1500)
	setScrollFactor('bg', 0.6, 1)
	scaleObject('bg', 4, 4)

	addLuaSprite('bg', false)
	setProperty('bg.antialiasing',false)	
	addLuaSprite('boo', false)
	setProperty('boo.antialiasing',true)
end

function onBeatHit()
    if curBeat% 2 == 0 then
	
		objectPlayAnimation('boo', 'bitches crouds', false);
	
	end
end