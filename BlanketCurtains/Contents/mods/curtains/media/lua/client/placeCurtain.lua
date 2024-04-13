curtainObjects = curtainObjects or {}
require "BlanketObjects"
function curtainObjects.placeCurtain(character,window,bedSheet,tileset)
	local bedSheetItem = character:getInventory():getFirstType(bedSheet)
	if character:getInventory():RemoveOneOf(bedSheet,false) then
		local blanketData = bedSheetItem:getModData().movableData.bedcoverData
		local spritePick = curtainObjects.spritePick(blanketData,window)

	end
end



function curtainObjects.OnPreFillWorldObjectContextMenu(player, context, worldobjects, test)
	local window = window
	
	if not curtain then
		for _,wo in ipairs(worldobjects) do
			if wo:getType() == "IsoWindow"
				window = wo
			end
		end
	end
	if window then
	local character = getSpecificPlayer(player)
	local window_sprite = window:getTextureName()
	local inventory = character:getInventory()
		for item, tileset in pairs(BO.TilesInfo) do 
			if inventory:containsTypeRecurse(item)
				local optionCurtain = context:addOption(getText("ContextMenu_CO_PlaceCurtain",getItemNameFromFullType(item)),character,curtainObjects.placeCurtain,window,item,tileset)
			end
		end
	window:HasCurtains() = true
end