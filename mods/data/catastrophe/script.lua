
function onUpdate(onStepHit)
    if curStep == 0 then
        --setObjectOrder('woemn',getObjectOrder('woemn') - 1)
        --setObjectOrder('GFBG2',getObjectOrder('GFBG2') - 1)
        setTextColor('scoreTxt','160053')

        precacheImage('HE IS BLACK')
        precacheImage('Blood1')
        precacheImage('Blood2')
        precacheImage('Blood3')
        precacheImage('Blood4')
        precacheImage('ahh')
        precacheImage('yayy')
        precacheImage('noway')
        precacheImage('cryaboutit')

        makeLuaSprite('HE IS BLACK', 'HE IS BLACK', 0, 0);
		addLuaSprite('HE IS BLACK', true);
		setObjectCamera('HE IS BLACK', 'camGame');
        setProperty('HE IS BLACK.alpha', 0.0);

        makeLuaSprite('ahh', 'Blood1', 0, 0);
		addLuaSprite('ahh', true);
		setObjectCamera('ahh', 'other');
        setProperty('ahh.alpha', 0.0);

        makeLuaSprite('yayy', 'Blood2', 0, 0);
		addLuaSprite('yayy', true);
		setObjectCamera('yayy', 'other');
        setProperty('yayy.alpha', 0.0);

        makeLuaSprite('noway', 'Blood3', 0, 0);
		addLuaSprite('noway', true);
		setObjectCamera('noway', 'other');
        setProperty('noway.alpha', 0.0);

        makeLuaSprite('cryaboutit', 'Blood4', 0, 0);
		addLuaSprite('cryaboutit', true);
		setObjectCamera('cryaboutit', 'other');
        setProperty('cryaboutit.alpha', 0.0);

		makeLuaSprite('boom', 'boom', 0, 0);
		addLuaSprite('boom', true);
		doTweenColor('hello', 'boom', 'FFFFFFFF', 0.5, 'quartIn');
		setObjectCamera('boom', 'other');

        setProperty("boom.visible",false)


    elseif curStep == 810 then
        setProperty('HE IS BLACK.alpha', 1);
        doTweenAlpha('ahh2', 'ahh', 1, 0.001, 'linear');
    elseif curStep == 824 then
        doTweenAlpha('ahh3', 'ahh', 0, 1.5, 'linear');

    elseif curStep == 875 then
        doTweenAlpha('yayy', 'yayy', 1, 0.001, 'linear');
    elseif curStep == 890 then
        doTweenAlpha('yayy2', 'yayy', 0, 1.5, 'linear');

    elseif curStep == 938 then
        doTweenAlpha('noway', 'noway', 1, 0.001, 'linear');
    elseif curStep == 955 then
        doTweenAlpha('noway2', 'noway', 0, 1.5, 'linear');

    elseif curStep == 1003 then
        doTweenAlpha('cryaboutit', 'cryaboutit', 1, 0.001, 'linear');
    elseif curStep == 1056 then
        doTweenAlpha('cryaboutit2', 'cryaboutit', 0, 2, 'linear');
    elseif curStep == 1085 then
        --setProperty('cryaboutit.alpha', 0.0);
    elseif curStep == 1092 then 
        doTweenAlpha('HE IS BLACK', 'HE IS BLACK', 0, 0.001, 'linear');
    elseif curStep == 1829 then
        doTweenAlpha('byebye2', 'dad', 0, 2.5, linear); 
        doTweenAlpha('byebye3', 'gf', 0, 2.5, linear); 
        doTweenAlpha('byebye32', 'GFBG2', 0, 2.5, linear); 
        doTweenAlpha('byebye4', 'man', 0, 2.5, linear); 
        doTweenAlpha('byebye5', 'woemn', 0, 2.5, linear); 
	elseif curStep == 1861 then
	    doTweenAlpha('byebye1', 'boyfriend', 0, 2.5, linear); 
end
end