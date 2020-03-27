local TSM = select(2, ...)
local EventDetection = TSM:NewModule("EventDetection","AceEvent-3.0")
local Util = TSM:GetModule("Util")

function Util:Process(message, recipient, channel)
	if TSM.db.global["AddonEnabled"] == false then return end

	local AddonEnabled = TSM.db.global["AddonEnabled"] --- check it
	local GuildChannel = TSM.db.global["GuildChannel"] --- Only used for guild channel

	if Util:StartsWith(message, TSM.db.global["Trigger"]) == false then
		return
	end

	--- Price Get --
	local itemString  = Util:TrimString(string.sub(message, TSM.db.global["TriggerLength"]+1)) -- sub the item
	local itemCountIndex, endPos, itemCount, restOfString = string.find(itemString, '(%d+)')

	if itemCount == nil or itemCountIndex > 1 then
		itemCount = 1
	else
		itemCount = tonumber(itemCount)
		if itemCount < 1 then
			itemCount = 1
		end
	end

	local itemID  = TSM_API.ToItemString(itemString)
	local itemID  = TSM_API.ToItemString(itemString)
	if itemID == nil or itemID == nill then
		Util:SendMessage("No such item {Skull} ", recipient, channel)
		return
	end

	local priceMarket = TSM_API.GetCustomPriceValue(TSM.db.global["MarketSource"], itemID)
	local priceMin = TSM_API.GetCustomPriceValue(TSM.db.global["MinBuyoutSource"], itemID)
	--Trying GetCustomPriceValue, though I'm not certain it's wise to allow modified prices here.
	--local priceRegion = TSMAPI:GetItemValue(itemID, TSM.db.global["Region"])
	local priceRegion = TSM_API.GetCustomPriceValue(TSM.db.global["Region"], itemID)

	if priceMarket == nill then
		priceMarket = TSM_API.GetCustomPriceValue(TSM.db.global["MarketSource"], itemID)
	end
	if priceMin == nill then
		priceMin = TSM_API.GetCustomPriceValue(TSM.db.global["MinBuyoutSource"], itemID)
	end
	if priceRegion == nill then
		priceRegion = TSM_API.GetCustomPriceValue(TSM.db.global["Region"], itemID)
	end

	if itemID == nill then
	end

	if itemID == nill then
		return
	end

	-----------------------------------------------------------------

	if priceMarket == nil and priceMin == nil and priceRegion == null then
		Util:SendMessage("Not seen in any scans", recipient, channel)
		return
	end

	if Util:LastRunCheck() == "Yes" then
		local message = ""

		if priceMin ~= nil then
			message = Util:ValuesFor(priceMin, TSM.db.global["MinText"], itemCount)
		end

		if priceMarket ~= nil then
			message = message .. Util:ValuesFor(priceMarket, TSM.db.global["MarketText"], itemCount)
		end

		if priceRegion ~= nil then
			message = message .. Util:ValuesFor(priceRegion, TSM.db.global["RegionalText"], itemCount)
		end

		--[[if TSM.db.global["ShowScanned"] then
			message = message .."Scanned: "..TimeLastScannedMinutes.." Mins Ago"
		end]]--
		Util:SendMessage(message, recipient, channel)

		TSM.LastRunDelayTime = time() --- gets the current time
	else
		return
	end
end
