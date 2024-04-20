local BlanketObjects = require "BlanketObjects"
local HangBlanketAction = require "Actions/HangBlanketAction"

local ContextMenu = {}

---@param item InventoryItem
function ContextMenu.predicateBlanket(item)
    return BlanketObjects.SheetCurtainSprites[item:getFullType()] ~= nil
end

-- function Context.addPlaceSheetOptions()
    
-- end

-- curtainObjects = curtainObjects or {}
-- function curtainObjects.placeCurtain(character,window,bedSheet,tileset)
--     local bedSheetItem = character:getInventory():getFirstType(bedSheet)
--     if character:getInventory():RemoveOneOf(bedSheet,false) then
--         local blanketData = bedSheetItem:getModData().movableData.bedcoverData
--         local spritePick = curtainObjects.spritePick(blanketData,window)
        
--     end
-- end

function ContextMenu.onHangBlanket(player, window, blanket)
    if not player:getInventory():containsRecursive(blanket) then return end
	local square = IsoWindowFrame.isWindowFrame(window) and IsoWindowFrame.getAddSheetSquare(window, player) or window:getAddSheetSquare(player)
    --walk to window
	if square and square:isFree(false) then
		local action = ISWalkToTimedAction:new(player, square)
		if instanceof(window, "IsoDoor") then
			action:setOnComplete(ISWorldObjectContextMenu.restoreDoor, player, window, window:IsOpen())
		end
		ISTimedActionQueue.add(action)
	elseif not luautils.walkAdjWindowOrDoor(player, window:getSquare(), window, true) or instanceof(window, "IsoDoor") then
        return
	end
    --take in hands and do action
    ISWorldObjectContextMenu.equip(player, player:getPrimaryHandItem(), blanket, true, false)
    ISTimedActionQueue.add(HangBlanketAction:new(player, window, 50, blanket))
end

---@type OnFillWorldObjectContextMenu_Callback
ContextMenu.OnFillWorldObjectContextMenu = function (playerIndex, context, worldobjects, test)
    local player = getSpecificPlayer(playerIndex)
    local playerInventory = player:getInventory()
    local blankets = playerInventory:getAllEvalRecurse(ContextMenu.predicateBlanket)
    
    -- if not curtain then
    -- 	-- for _,wo in ipairs(worldobjects) do
    -- 	-- 	if wo:getType() == "IsoWindow"
    -- 	-- 	window = wo
    -- 	-- end
    -- end
    
    if blankets:isEmpty() then
        --pass
    elseif thumpableWindow ~= nil then
        if not (thumpableWindow:getSquare():getWindow(thumpableWindow:getNorth()) or thumpableWindow:HasCurtains()) then
            --TODO submenu, icons
            for i = 0, blankets:size() - 1 do
                if test == true then return true end
                local blanket = blankets:get(i)
                context:addOption(getText("ContextMenu_BO_HangBedSheet", BlanketObjects.Util.getBlanketName(blanket)), player, ContextMenu.onHangBlanket, thumpableWindow, blanket)
            end
        end
    elseif window ~= nil then
        if not (invincibleWindow or window:HasCurtains()) then
            -- local curtain2 = window:HasCurtains()
            -- curtain = curtain or curtain2
            -- if not curtain2 and playerInv:containsTypeRecurse("Sheet") then
            --     if test == true then return true end
            --     context:addOption(getText("ContextMenu_Add_sheet"), worldobjects, ISWorldObjectContextMenu.onAddSheet, window, player)
            -- end
        end
    elseif windowFrame ~= nil then
        if not IsoWindowFrame.getCurtain(windowFrame) then
            -- if test == true then return true end
            -- context:addOption(getText("ContextMenu_Add_sheet"), worldobjects, ISWorldObjectContextMenu.onAddSheet, windowFrame, player)
        end
    end
    
    if curtain ~= nil then
        
    end
end

Events.OnFillWorldObjectContextMenu.Add(ContextMenu.OnFillWorldObjectContextMenu)
