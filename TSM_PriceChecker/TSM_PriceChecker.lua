local TSM = select(2, ...)
local TSM = LibStub("AceAddon-3.0"):NewAddon(TSM,"TSM_PriceChecker", "AceConsole-3.0","AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_PriceChecker") -- loads the localization table
TSM.version = GetAddOnMetadata("TSM_PriceChecker", "Version")

--- Default the saved variables
local savedDBDefaults = {
	global = {
		["AddonEnabled"] = true,
		["UseRaidIcon"] = true,
		["ShowCopper"] = false,
		["ShowBrackets"] = true,
		["ShowScanned"] = false,
		["Trigger"] = "?",
		["TriggerLength"] = 0,
		["LockOutTime"] = 3,
		["Channel"] = "None",
		["GuildChannel"] = "WHISPER",
		["PartyChannel"] = "WHISPER",
		["OfficerChannel"] = "WHISPER",
		["Region"] = "DBRegionMarketAvg",
		["MarketSource"] = "DBMarket",
		["MinBuyoutSource"] = "DBMinBuyout",
		["MarketText"] = L["Market"],
		["MinText"] = L["Min"],
		["RegionalText"] = L["Regional"]
	},
}

-- ============================================================================
-- TSM Methods
-- ============================================================================

function TSM:OnInitialize()
	TSM.db = LibStub:GetLibrary("AceDB-3.0"):New("TSM_PriceCheckerDB", savedDBDefaults, true)
	TSM.db.global["TriggerLength"] = string.len(TSM.db.global["Trigger"])

	TSM.LastRunDelayTime = 0
	TSM.AddonDelayCheck = 0

	TSM:RegisterEvent("CHAT_MSG_GUILD")
	TSM:RegisterEvent("CHAT_MSG_WHISPER")
	TSM:RegisterEvent("CHAT_MSG_BN_WHISPER")
	TSM:RegisterEvent("CHAT_MSG_SAY")
	TSM:RegisterEvent("CHAT_MSG_PARTY")
	TSM:RegisterEvent("CHAT_MSG_PARTY_LEADER")
	TSM:RegisterEvent("CHAT_MSG_OFFICER")

	-- make easier references to all the modules
	for moduleName, module in pairs(TSM.modules) do
		TSM[moduleName] = module
	end

	TSM:RegisterModule()
end

function TSM:OnEnable()
end

function TSM:RegisterModule()
	--TSM.icons = {
		--{
		--side = "module",
		--desc = L["Price Checker"]
		--slashCommand = "pricechecker",
		--callback = "Options:Load",
		--icon = "Interface\\Icons\\ACHIEVEMENT_GUILDPERK_QUICK AND DEAD"
		--},
	--}

	TSM.moduleOptions = {callback="Options:Load"}

	--TSMAPI:NewModule(TSM)
end

-- ============================================================================
-- Event Handlers
-- ============================================================================

function TSM:CHAT_MSG_GUILD(_,MSG,Auth)
	TSM:TriggeredEvent(MSG,Auth,"Guild")
end

function TSM:CHAT_MSG_SAY(_,MSG,Auth)
	TSM:TriggeredEvent(MSG,Auth,"Say")
end

function TSM:CHAT_MSG_PARTY(_,MSG,Auth)
	TSM:TriggeredEvent(MSG,Auth,"Party")
end

function TSM:CHAT_MSG_PARTY_LEADER(_,MSG,Auth)
	TSM:TriggeredEvent(MSG,Auth,"Party")
end

function TSM:CHAT_MSG_OFFICER(_,MSG,Auth)
	TSM:TriggeredEvent(MSG,Auth,"Officer")
end

function TSM:CHAT_MSG_WHISPER(_,MSG,Auth)
	TSM:TriggeredEvent(MSG,Auth,"Whisper")
end

function TSM:CHAT_MSG_BN_WHISPER(_,message, _, _, _, _, _, _, _, _, _, _, _, presenceID)
	TSM:TriggeredEvent(message,presenceID,"BNET")
end
