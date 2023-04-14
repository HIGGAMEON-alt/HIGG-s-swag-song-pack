function onCreatePost()
setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'Jorsawsee_Loop')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'Jorsawsee_End')

makeLuaSprite('otherroom', 'stageassets/airship/backer_groung_voting', 387.3, 194.1)
setScrollFactor('otherroom', 0.8, 0.8)
addLuaSprite('otherroom')

makeLuaSprite('votingbg', 'stageassets/airship/main_bg_meeting', -315.15, 52.85)
setScrollFactor('votingbg', 0.95, 0.95)
addLuaSprite('votingbg')

makeLuaSprite('chairs', 'stageassets/airship/CHAIRS!!!!!!!!!!!!!!!', -7.9, 644.85)
addLuaSprite('chairs')

makeLuaSprite('table', 'stageassets/airship/table_voting', 209.4, 679.55)
addLuaSprite('table', true)
end