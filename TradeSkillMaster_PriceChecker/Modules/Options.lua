--local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_PriceChecker") -- loads the localization table
local AceGUI = LibStub("AceGUI-3.0") -- load the AceGUI libraries
TSMPC = LibStub("AceAddon-3.0"):NewAddon("TradeSkillMaster_PriceChecker", "AceConsole-3.0")

function TSMPC:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("TradeSkillMaster_PriceCheckerDB")
end

function TSMPC:SetTrigger(info, input)
    self.db.global.Trigger = input
		print("Set trigger to ", input)
end

function TSMPC:SetEnableAddon(info, input)
		self.db.global.AddonEnabled = true
		print("TradeSkillMaster_PriceChecker is now enabled")
end

function TSMPC:GetAddonEnabled(info)
		return self.db.global.AddonEnabled
end

function TSMPC:SetDisableAddon(info, input)
		self.db.global.AddonEnabled = false
		print("TradeSkillMaster_PriceChecker is now disabled")
end

function TSMPC:SetRaidIcon(info, input)
		if TSMPC:GetRaidIcon(info) == false then
			print("Raid icon will now be used")
			self.db.global.UseRaidIcon = true
		else print("Raid icon is now disabled")
			self.db.global.UseRaidIcon = false
		end
end

function TSMPC:GetRaidIcon(info)
		return self.db.global.UseRaidIcon
end

function TSMPC:GetShowCopper(info)
		return self.db.global.ShowCopper
end

function TSMPC:SetShowCopper(info)
	if TSMPC:GetShowCopper(info) == false then
		print("Copper will now be shown")
		self.db.global.ShowCopper = true
	else print("Copper will now be hidden")
		self.db.global.ShowCopper = false
	end
end

function TSMPC:GetShowBrackets(info)
		return self.db.global.ShowBrackets
end

function TSMPC:SetShowBrackets(info)
	if TSMPC:GetShowBrackets(info) == false then
		print("Brackets will now be shown")
		self.db.global.ShowBrackets = true
	else print("Brackets will now be hidden")
		self.db.global.ShowBrackets = false
	end
end

--[[
-function TSMPC:GetShowScanned(info)
		return self.db.global.ShowScanned
end

function TSMPC:SetShowScanned(info)
	if TSMPC:GetShowScanned(info) == false then
		print("Time since last scan will now be shown")
		self.db.global.ShowScanned = true
	else print("Time since last scan will now be hidden")
		self.db.global.ShowScanned = false
	end
end
]]--

function TSMPC:SetGuildChannel(info, input)
	input = strupper(input)
	if (input == 'GUILD' or input == 'OFFICER' or input == 'WHISPER' or input == 'PARTY') then
    self.db.global.GuildChannel = input
		print("Set reply for guild messages to ", input)
	else
		print("Incorrect channel name. Guild message reply channel was not changed.")
	end
end

function TSMPC:SetPartyChannel(info, input)
	input = strupper(input)
	if (input == 'GUILD' or input == 'OFFICER' or input == 'WHISPER' or input == 'PARTY') then
    self.db.global.PartyChannel = input
		print("Set reply for Party messages to ", input)
	else
		print("Incorrect channel name. Party message reply channel was not changed.")
	end
end

function TSMPC:SetOfficerChannel(info, input)
	input = strupper(input)
	if (input == 'GUILD' or input == 'OFFICER' or input == 'WHISPER' or input == 'PARTY') then
    self.db.global.OfficerChannel = input
		print("Set reply for Officer messages to ", input)
	else
		print("Incorrect channel name. Officer message reply channel was not changed.")
	end
end

local options = {
    name = "MyAddon",
    handler = TSMPC,
    type = 'group',
    args = {
			--trigger
        trigger = {
            type = 'input',
            name = 'Trigger',
            desc = '/tsmpc trigger triggerkey',
            set = 'SetTrigger',
        },
				--AddonEnabled
				enable = {
						type = 'toggle',
						name = 'Enable Addon',
						desc = '/tsmpc enable',
						set = 'SetEnableAddon',
						get = 'GetAddonEnabled',
				},
				--AddonDisabled
				disable = {
						type = 'toggle',
						name = 'Disable Addon',
						desc = '/tsmpc disable',
						set = 'SetDisableAddon',
						get = 'GetAddonEnabled',
				},
				--UseRaidIcon
				useraidicon = {
						type = 'toggle',
						name = 'Use Raid Icon',
						desc = '/tsmpc useraidicon',
						set = 'SetRaidIcon',
						get = 'GetRaidIcon',
				},
				--ShowCopper
				showcopper = {
						type = 'toggle',
						name = 'Show Copper on prices',
						desc = '/tsmpc showcopper',
						set = 'SetShowCopper',
						get = 'GetShowCopper',
				},
				--ShowBrackets
				showbrackets = {
						type = 'toggle',
						name = 'Show brackets around prices',
						desc = '/tsmpc showbrackets',
						set = 'SetShowBrackets',
						get = 'GetShowBrackets'
				},
				--[[--ShowScanned
				showscanned = {
						type = 'toggle',
						name = 'Show when last scanned',
						desc = '/tsmpc showscanned',
						set = 'SetShowScanned',
						get = 'GetShowScanned'
				},]]--
				--GuildChannel
				guildchannel = {
						type = 'input',
						name = 'Channel to reply for guild messages',
						desc = '/tsmpc guild CHANNEL',
						set = 'SetGuildChannel',
				},
				--PartyChannel
				partychannel = {
						type = 'input',
						name = 'Channel to reply for party messages',
						desc = '/tsmpc party CHANNEL',
						set = 'SetPartyChannel',
				},
				--OfficerChannel
				officerchannel = {
						type = 'input',
						name = 'Channel to reply for officer messages',
						desc = '/tsmpc officer CHANNEL',
						set = 'SetOfficerChannel',
				},
    },
}

LibStub("AceConfig-3.0"):RegisterOptionsTable("TradeSkillMaster_PriceChecker", options, {"tsmpc"})
