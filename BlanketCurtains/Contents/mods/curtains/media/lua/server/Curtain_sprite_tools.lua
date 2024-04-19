-- curtainObjects = curtainObjects or {}


-- function curtainObjects.OnObjectAdded(isoObject)
-- 	local color = blanketData.bedcoverData.colourName
-- 	for state,dir in pairs(curtainObjects.vanillaTiles) do
-- 		for _,sprite in pairs(dir) do
-- 			if sprite == getSprite(isoObject:getTextureName()) then
-- 				isoObject:setSprite(curtainObjects.tilesInfo.color.state.dir)
-- 				isoObject:transmitUpdatedSpriteToServer()
-- 				break
-- 			else break end
			
-- 		end
-- 	end
-- end

-- if not isServer() then
--     Events.OnObjectAdded.Add(SpriteUtil.OnObjectAdded)
-- end