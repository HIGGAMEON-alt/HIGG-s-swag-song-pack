function onEvent(n,v1,v2)


	if n == 'Flash Camera' then

	   makeLuaSprite('flash', '', 0, 0);
        makeGraphic('flash',1280,720,'ffffff')
	      addLuaSprite('flash', true);
	      setLuaSpriteScrollFactor('flash',0,0)
	      setProperty('flash.scale.x',2)
	      setProperty('flash.scale.y',2)
	      setProperty('flash.alpha',0)
		setProperty('flash.alpha',1)
		makeLuaSprite('flash2', '', 0, 0);
        makeGraphic('flash2',1280,720,'ffffff')
	      addLuaSprite('flash2', true);
	      setLuaSpriteScrollFactor('flash2',0,0)
	      setProperty('flash2.scale.x',2)
	      setProperty('flash2.scale.y',2)
	      setProperty('flash2.alpha',0)
		setProperty('flash2.alpha',0.5)
		setBlendMode('flash2', 'ADD')
		doTweenAlpha('flTw','flash',0,v1,'linear')
		doTweenAlpha('flTw2','flash2',0,v1,'linear')
		setObjectCamera('flash', 'other')
		setObjectCamera('flash2', 'other')
	end



end