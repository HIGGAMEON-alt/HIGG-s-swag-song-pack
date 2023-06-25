function onCreate()
	--agonmus
	makeLuaSprite('newelec', 'newelec', 25, 100);
	setScrollFactor('newelec', 0.9, 0.9);
	scaleObject('newelec', 1.6, 1.6);


	makeLuaSprite('blurelec', 'blurelec', -300, 400);
	setScrollFactor('blurelec', 1.4, 1.4);
	scaleObject('blurelec', 1.6, 1.6);


	makeLuaSprite('lightingelec', 'lightingelec', 25, 100);
	setScrollFactor('lightingelec', 0.9, 0.9);
	scaleObject('lightingelec', 1.6, 1.6);
	
-- sprites that only load if Low Quality is turned off
	if not lowQuality then
	
	end 

	addLuaSprite('newelec', false)
	addLuaSprite('blurelec', true)
	addLuaSprite('lightingelec', true)
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end