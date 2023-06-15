function onCreatePost()
	if not middlescroll then
		for i = 0,math.max(getProperty("opponentStrums.length")-1,getProperty("playerStrums.length")-1) do
			iPos = getPropertyFromGroup("opponentStrums", i, "x")
			jPos = getPropertyFromGroup("playerStrums", i, "x")
			setPropertyFromGroup("opponentStrums", i, "x", jPos)
			setPropertyFromGroup("playerStrums", i, "x", iPos)
		end
	end
end