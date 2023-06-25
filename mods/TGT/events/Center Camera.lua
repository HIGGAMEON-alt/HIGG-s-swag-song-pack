function onEvent(name,v1,v2)
if name == "Center Camera" then
if v1 then
triggerEvent("Camera Follow Pos", getProperty('opponentCameraOffset')[1] + getProperty('dad.x') + getProperty('dad.width') +getProperty('dad.cameraPosition')[1] + getProperty('boyfriendCameraOffset')[1] + getProperty('boyfriend.x') + getProperty('boyfriend.width') - getProperty('boyfriend.cameraPosition')[1] * 0.5, getProperty('opponentCameraOffset')[2] + getProperty('dad.y') + getProperty('dad.height') +getProperty('dad.cameraPosition')[2] + getProperty('boyfriendCameraOffset')[2] + getProperty('boyfriend.y') + getProperty('boyfriend.height') - getProperty('boyfriend.cameraPosition')[2] * 0.5)
else
triggerEvent("Camera Follow Pos","","")
end
end