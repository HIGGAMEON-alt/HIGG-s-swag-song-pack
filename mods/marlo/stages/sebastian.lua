function onCreate()

    --cool bar effect (i stole it lmfao)
	
	makeLuaSprite('bartop','',-200,-30)
	makeGraphic('bartop',2000,100,'000000')
	addLuaSprite('bartop',false)
    setScrollFactor('bartop',0,0)
    setObjectCamera('bartop','hud')
	
	makeLuaSprite('barbot','',-200,650)
	makeGraphic('barbot',2000,100,'000000')
	addLuaSprite('barbot',false)
    setScrollFactor('barbot',0,0)
    setObjectCamera('barbot','hud')
	
    --cool bg
	
    makeLuaSprite('bg','cool', -1300, -900);
	setLuaSpriteScrollFactor('bg', 0.3, 0.05);
	scaleObject('bg', 3, 3)
	
	makeLuaSprite('floor','sebas ground', -1600, -925);
	setLuaSpriteScrollFactor('floor', 0.96, 0.96);
	scaleObject('floor', 2.5, 2.5)
	
	addLuaSprite('bg', false);
	setProperty('bg.antialiasing', true)
	
	addLuaSprite('floor', false);
	setProperty('floor.antialiasing', false)

    -- Opponent bopping to the beat
    if getProperty('dad.animation.curAnim.name') == 'idle' then
		characterPlayAnim('dad','idle',true)
	end

    -- Player bopping to the beat
    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		characterPlayAnim('boyfriend','idle',true)
	end
	
	close(true);
	
end

