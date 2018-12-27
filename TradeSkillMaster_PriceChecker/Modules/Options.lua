local TSM = select(2, ...)
local Options = TSM:NewModule("Options")
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_PriceChecker") -- loads the localization table
local Util = TSM:GetModule("Util")
local AceGUI = LibStub("AceGUI-3.0") -- load the AceGUI libraries
local private = {}

-- ============================================================================
-- Dropdown Types
-- ============================================================================
local ReplyChannelSayDropDownBox = {["None"]=L["None"],["WHISPER"]=L["Whisper"],["SAY"]=L["Say"]}
local ReplyChannelGuildDropDownBox = {["None"]=L["None"],["WHISPER"]=L["Whisper"],["GUILD"]=L["Guild"]}
local ReplyChannelOfficerDropDownBox = {["None"]=L["None"],["WHISPER"]=L["Whisper"],["OFFICER"]=L["Officer"]}
local ReplyChannelPartyDropDownBox = {["None"]=L["None"],["WHISPER"]=L["Whisper"],["PARTY"]=L["Party"]}

-- ============================================================================
-- Module Options
-- ============================================================================
function Options:Load(container)
	local tg = AceGUI:Create("TSMTabGroup")
	tg:SetLayout("Fill")
	tg:SetFullHeight(true)
	tg:SetFullWidth(true)
	tg:SetTabs({{value=1, text=L["General"]}})
	tg:SetCallback("OnGroupSelected", function(self, _, value)
		self:ReleaseChildren()
		private:DrawGeneralSettings(self)
	end)
	container:AddChild(tg)
	tg:SelectTab(1)
end

function private:DrawGeneralSettings(container)
	local page = {
		{
		 type = "ScrollFrame",
		 layout = "list",
		 children = {
			{
				type = "InlineGroup",
				layout = "flow",
				title = L["TSM Source Options"],
				children = {
					{
					type = "EditBox",
					value = TSM.db.global["MarketSource"],
					settingInfo = { TSM.db.global, "MarketSource" },
					label = L["Market Source"],
					tooltip = L["The TSM source used for market prices.  Leave blank to disable including in reply."],
					},
					{
					type = "EditBox",
					value = TSM.db.global["MinBuyoutSource"],
					settingInfo = { TSM.db.global, "MinBuyoutSource" },
					label = L["Min Buyout Source"],
					tooltip = L["The TSM source used for min buyout prices.  Leave blank to disable including in reply."],
					},
					{
					type = "EditBox",
					value = TSM.db.global["Region"],
					settingInfo = { TSM.db.global, "Region" },
					label = L["Regional Source"],
					tooltip = L["The TSM source used for regional prices (optional).  Leave blank to disable including in reply."],
					},
				},
			},
			{
				type = "InlineGroup",
				layout = "flow",
				title = L["Price Check Options"],
				children = {
					{
					type = "EditBox",
					value = TSM.db.global["MarketText"],
					settingInfo = { TSM.db.global, "MarketText" },
					label = L["Market Text"],
					tooltip = L["The text used for market price"],
					},
					{
					type = "EditBox",
					value = TSM.db.global["MinText"],
					settingInfo = { TSM.db.global, "MinText" },
					label = L["Min Buyout Text"],
					tooltip = L["The text used for min buyout price"],
					},
					{
					type = "EditBox",
					value = TSM.db.global["RegionalText"],
					settingInfo = { TSM.db.global, "RegionalText" },
					label = L["Regional Text"],
					tooltip = L["The text used for regional market price"],
					},
					{
					type = "EditBox",
					value = TSM.db.global["Trigger"],
					settingInfo = { TSM.db.global, "Trigger" },
					label = L["Trigger"],
					tooltip = L["The trigger used at the start of a sentence for asking the price"],
					},
					{
					type = "EditBox",
					value = TSM.db.global["LockOutTime"],
					label = L["Lockout Time"],
					tooltip = L["Lockout time in seconds before another command can be processed"],
					callback = function(_,_,value)
						local value = tonumber(value)
						if type(value)=='number' then
							LockOutTime = value;
							TSM.db.global["LockOutTime"] = LockOutTime;
						end
					end,
					},
					{
					type = "CheckBox",
					value = TSM.db.global["ShowCopper"],
					settingInfo = { TSM.db.global, "ShowCopper" },
					label = L["Show Copper Value"],
					tooltip = L["Shows or hides the copper values in the reply."],
					},
					{
					type = "CheckBox",
					value = TSM.db.global["ShowBrackets"],
					settingInfo = { TSM.db.global, "ShowBrackets" },
					label = L["Show Brackets"],
					tooltip = L["Shows or hides the brackets around the values in the reply."],
					},
					{
					type = "CheckBox",
					value = TSM.db.global["ShowScanned"],
					settingInfo = { TSM.db.global, "ShowScanned" },
					label = L["Show Last Scanned"],
					tooltip = L["Shows or hides the last scanned time in the reply."],
					},
				},
			},
			{
				type = "InlineGroup",
				layout = "flow",
				title = L["Reply Options For Channels"],
				children = {
					{
					type = "Dropdown",
					multiselect = false,
					list = ReplyChannelSayDropDownBox,
					value = TSM.db.global["Channel"],
					settingInfo = { TSM.db.global, "Channel" },
					label = L["Select channel to reply via for say price requests:"],
					tooltip = L["Select a reply method"],
					},
					{
					type = "Dropdown",
					multiselect = false,
					list = ReplyChannelGuildDropDownBox,
					value = TSM.db.global["GuildChannel"],
					settingInfo = { TSM.db.global, "GuildChannel" },
					label = L["Select channel to reply via for guild price requests:"],
					tooltip = L["Select a reply method"],
					},
					{
					type = "Dropdown",
					multiselect = false,
					list = ReplyChannelOfficerDropDownBox,
					value = TSM.db.global["OfficerChannel"],
					settingInfo = { TSM.db.global, "OfficerChannel" },
					label = L["Select channel to reply via for officer price requests:"],
					tooltip = L["Select a reply method"],
					},
					{
					type = "Dropdown",
					multiselect = false,
					list = ReplyChannelPartyDropDownBox,
					value = TSM.db.global["PartyChannel"],
					settingInfo = { TSM.db.global, "PartyChannel" },
					label = L["Select channel to reply via for party price requests:"],
					tooltip = L["Select a reply method"],
					},
				},
			},
			{
				type = "InlineGroup",
				layout = "flow",
				title = L["Addon Options"],
				children = {
					{
					type = "CheckBox",
					value = TSM.db.global["AddonEnabled"],
					settingInfo = { TSM.db.global, "AddonEnabled" },
					label = L["Enable/Disable Addon"],
					tooltip = L["Enable/Disable the addon"],
					},
					{
					type = "CheckBox",
					value = TSM.db.global["UseRaidIcon"],
					settingInfo = { TSM.db.global, "UseRaidIcon" },
					label = L["Use Raid Icon {rt2}"],
					tooltip = L["Enable use of the circle icon to make prices easier to see."],
					},
				},
			},
		},
	}
}
	TSMAPI.GUI:BuildOptions(container, page)
end