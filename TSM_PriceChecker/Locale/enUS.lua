-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_PriceChecker                        --
--           http://www.curse.com/addons/wow/tradeskillmaster_pricechecker        --
-- ------------------------------------------------------------------------------ --

-- TradeSkillMaster_PriceCheck Locale - enUS
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/tradeskillmaster_pricechecker/localization/

local isDebug = false
--@debug@
isDebug = true
--@end-debug@
local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster_PriceChecker", "enUS", true, isDebug)
if not L then return end

--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true)@
L["Addon Options"] = true
L["Enable use of the circle icon to make prices easier to see."] = true
L["Enable/Disable Addon"] = true
L["Enable/Disable the addon"] = true
L["General"] = true
L["None"] = true
L["Say"] = true
L["Whisper"] = true
L["Guild"] = true
L["Officer"] = true
L["Party"] = true
L["Lockout time in seconds before another command can be processed"] = true
L["Lockout Time"] = true
L["Market Source"] = true
L["Market Text"] = true
L["Market Value"] = true
L["Min Buyout Source"] = true
L["Min Buyout Text"] = true
L["Min Buyout"] = true
L["Price Check Options"] = true
L["Regional Source"] = true
L["Regional Text"] = true
L["Regional Value"] = true
L["Reply Options For Channels"] = true
L["Select a reply method"] = true
L["Select channel to reply via for guild price requests:"] = true
L["Select channel to reply via for officer price requests:"] = true
L["Select channel to reply via for party price requests:"] = true
L["Select channel to reply via for say price requests:"] = true
L["Show Brackets"] = true
L["Show Last Scanned"] = true
L["Show Copper Value"] = true
L["Shows or hides the brackets around the values in the reply."] = true
L["Shows or hides the last scanned time in the reply."] = true
L["Shows or hides the copper values in the reply."] = true
L["The text used for market price"] = true
L["The text used for min buyout price"] = true
L["The text used for regional market price"] = true
L["The trigger used at the start of a sentence for asking the price"] = true
L["The TSM source used for market prices.  Leave blank to disable including in reply."] = true
L["The TSM source used for min buyout prices.  Leave blank to disable including in reply."] = true
L["The TSM source used for regional prices (optional).  Leave blank to disable including in reply."] = true
L["Trigger"] = true
L["TSM Source Options"] = true
L["Use Raid Icon {rt2}"] = true
