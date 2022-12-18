--------------------------------------------------------------------------------
-- ACTION BAR AND POWER BAR
--------------------------------------------------------------------------------

-- Hide various frames out of combat
MainMenuBar:SetAlpha(0)
MonkStaggerBar:SetAlpha(0)
MonkHarmonyBarFrame:SetAlpha(0)

EventRegistry:RegisterCallback("PLAYER_REGEN_DISABLED", function() 
  MainMenuBar:SetAlpha(1)
  MonkStaggerBar:SetAlpha(1)
  MonkStaggerBar:ClearAllPoints()
  MonkStaggerBar:SetScale(1.1)
  MonkStaggerBar:SetPoint("CENTER",UIParent,"CENTER", 0, -170)
  MonkHarmonyBarFrame:SetAlpha(1)
  MonkHarmonyBarFrame:ClearAllPoints()
  MonkHarmonyBarFrame:SetScale(1.0)
  MonkHarmonyBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -190)
end)

EventRegistry:RegisterCallback("PLAYER_REGEN_ENABLED", function() 
  MainMenuBar:SetAlpha(0)
  MainMenuBar:SetScript("OnShow", function() MainMenuBar:Hide() end)
  MonkStaggerBar:SetAlpha(0)
  MonkStaggerBar:SetScript("OnShow", function() MonkStaggerBar:Hide() end)
  MonkHarmonyBarFrame:SetAlpha(0)
  MonkHarmonyBarFrame:SetScript("OnShow", function() MonkStaggerBar:Hide() end)
end)

-- Hide GCD blik
hooksecurefunc("CooldownFrame_Set", function(self, start, duration, enable, forceShowDrawEdge, modRate)
	if enable and enable ~= 0 and start > 0 and duration <= 1.5 then
		CooldownFrame_Clear(self)
	end
end)

--------------------------------------------------------------------------------
-- CHAT
--------------------------------------------------------------------------------

-- Chat style
local STRING_STYLE  = "%s|| "
local CHANNEL_STYLE = "%d"
local PLAYER_STYLE  = "%s"

-- Lines to scroll on mousewheel
local NUM_LINES_TO_SCROLL = 3

-- Reduce overlay animation
CHAT_TAB_SHOW_DELAY = 0.1
CHAT_TAB_HIDE_DELAY = 0.1
CHAT_FRAME_FADE_TIME = 0.1
CHAT_FRAME_FADE_OUT_TIME = 0.1

-- Configure more font sizes
CHAT_FONT_HEIGHTS = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}

-- Chat mousover
CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 0.5
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0

-- Hide Chat Frame Channel button
ChatFrameChannelButton:SetAlpha(0);
ChatFrameChannelButton:EnableMouse(false);

--------------------------------------------------------------------------------
-- COMMANDS
--------------------------------------------------------------------------------

-- Create new commands
SlashCmdList["READYCHECK"] = function() DoReadyCheck() end
SLASH_READYCHECK1 = '/rc'
SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = '/rl'
SlashCmdList["CHECKROLE"] = function() InitiateRolePoll() end
SLASH_CHECKROLE1 = '/cr'

--------------------------------------------------------------------------------
-- MAP
--------------------------------------------------------------------------------

-- Enlarge Minimap
Minimap:SetScale(1.1)

--------------------------------------------------------------------------------
-- UNIT FRAMES
--------------------------------------------------------------------------------
-- Remove damage and healing text in portraits
COMBATFEEDBACK_FADEINTIME = 0 
COMBATFEEDBACK_HOLDTIME = 0 
COMBATFEEDBACK_FADEOUTTIME = 0

-- Remove buffs/debuffs from target frame
TargetFrame.maxBuffs = 0;
TargetFrame.maxDebuffs = 5;

-- Hide Reputation background for target and focus frames
TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetTexture(nil)
FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetTexture(nil)

---- Hide resource bar under Player Frame
--local ResourceBarPosition = CreateFrame("Frame")
--    ResourceBarPosition:RegisterEvent("PLAYER_LOGIN")
--    ResourceBarPosition:RegisterEvent("PLAYER_ENTERING_WORLD")
--
--    ResourceBarPosition:SetScript("OnEvent", function(self, event, ...)
--
--        -- Monk Chi points bar
--        MonkHarmonyBarFrame:ClearAllPoints()
--        MonkHarmonyBarFrame:SetScale(1.0)
--        MonkHarmonyBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -190)
--
--        -- Monk Stagger bar
--        MonkStaggerBar:ClearAllPoints()
--        MonkStaggerBar:SetScale(1.1)
--        MonkStaggerBar:SetPoint("CENTER",UIParent,"CENTER", 0, -170)
--
--end)

-- Hide Reputation/XP bar
StatusTrackingBarManager:UnregisterAllEvents()
StatusTrackingBarManager:SetScript("OnShow", function() StatusTrackingBarManager:Hide() end)
StatusTrackingBarManager:Hide()

--------------------------------------------------------------------------------
-- TOOLTIPS
--------------------------------------------------------------------------------

-- Show Spell ID
local TooltipInfo, TooltipProcessor, TooltipUtil = C_TooltipInfo, TooltipDataProcessor, TooltipUtil

local function CheckForbidden(tooltip)
    return tooltip:IsForbidden()
end

local function AddLine(tooltip, id, type)
    if not tooltip and id then return end

    tooltip:AddLine(" ")
    tooltip:AddLine(type.."ID: ".."|cffFFFFCF"..id.."|r", 1, 1, 1)
end

local function ItemID(tooltip, data)
    if CheckForbidden(tooltip) then return end

    -- Get id
    local itemID = data.id
    -- Add line
    AddLine(tooltip, itemID, "Item")
end

local function SpellID(tooltip, data, newHook)
    if CheckForbidden(tooltip) then return end

    -- Get id
    local spellID = data.id
    -- Add line
    AddLine(tooltip, spellID, "Spell")
end

local function AuraID(tooltip, data)
    if CheckForbidden(tooltip) then return end

    -- Get id
    local auraID = data.id
    -- Add line
    AddLine(tooltip, auraID, "Aura")
end

local function UnitID(tooltip, data)
    if CheckForbidden(tooltip) then return end

    -- Assign values otherwise data will be nil
    TooltipUtil.SurfaceArgs(data)
    -- Get guid
    local unitUID = data.guid
    -- Extract id from guid
    local unitID = select(6, strsplit("-", unitUID))
    -- Check if id exists, this will be false on players
    if not unitID then return end
    -- Add line
    AddLine(tooltip, unitID, "Unit")
end

-- Register callbacks
if TooltipDataProcessor then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, ItemID)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, SpellID)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.UnitAura, AuraID)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, UnitID)
end

--------------------------------------------------------------------------------
-- RAID AND PARTY
--------------------------------------------------------------------------------

-- Hide Realm name from Raid frames
hooksecurefunc("CompactUnitFrame_UpdateName",function(frame)
  if frame and not frame:IsForbidden() then
    local frame_name = frame:GetName()
    if frame_name and frame_name:match("^CompactRaidFrame%d") and frame.unit and frame.name then
      local unit_name = GetUnitName(frame.unit,true)
      if unit_name then
        frame.name:SetText(unit_name:match("[^-]+"))
      end
    end
  end
end)

--------------------------------------------------------------------------------
-- VARIOUS
--------------------------------------------------------------------------------

-- Hide Pet action bar
PetActionBar:SetAlpha(0)
PetActionBar:Hide()
PetActionBar:HookScript("OnShow",function(self) self:Hide() end)

-- Hide Micro Menu bar
MicroButtonAndBagsBar:Hide()
MicroButtonAndBagsBar:HookScript("OnShow",function(self) self:Hide() end)
CharacterMicroButton:Hide()
CharacterMicroButton:HookScript("OnShow",function(self) self:Hide() end)
SpellbookMicroButton:Hide()
SpellbookMicroButton:HookScript("OnShow",function(self) self:Hide() end)
TalentMicroButton:Hide()
TalentMicroButton:HookScript("OnShow",function(self) self:Hide() end)
AchievementMicroButton:Hide()
AchievementMicroButton:HookScript("OnShow",function(self) self:Hide() end)
QuestLogMicroButton:Hide()
QuestLogMicroButton:HookScript("OnShow",function(self) self:Hide() end)
GuildMicroButton:Hide()
GuildMicroButton:HookScript("OnShow",function(self) self:Hide() end)
LFDMicroButton:Hide()
LFDMicroButton:HookScript("OnShow",function(self) self:Hide() end)
CollectionsMicroButton:Hide()
CollectionsMicroButton:HookScript("OnShow",function(self) self:Hide() end)
EJMicroButton:Hide()
EJMicroButton:HookScript("OnShow",function(self) self:Hide() end)
StoreMicroButton:Hide()
StoreMicroButton:HookScript("OnShow",function(self) self:Hide() end)

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------

-- Set Variables
local setupUiVariables = CreateFrame("Frame")
setupUiVariables:RegisterEvent("PLAYER_LOGIN")
setupUiVariables:RegisterEvent("PLAYER_ENTERING_WORLD")
setupUiVariables:SetScript("OnEvent",function(self, event, ...)

-- Action Bar
C_CVar.SetCVar("lockActionBar", 1)

-- Combat
C_CVar.SetCVar("autoSelfCast", 1)
C_CVar.SetCVar("floatingCombatTextCombatHealing", 1)
C_CVar.SetCVar("floatingCombatTextCombatDamage", 0)
C_CVar.SetCVar("floatingCombatTextCombatLogPeriodicSpells", 0)
C_CVar.SetCVar("floatingCombatTextPetMeleeDamage", 0)
C_CVar.SetCVar("floatingCombatTextPetSpellDamage", 0)

-- Chat
C_CVar.SetCVar("colorChatNamesByClass", 1)
C_CVar.SetCVar("guildMemberNotify", 1)
C_CVar.SetCVar("profanityFilter", 0)
C_CVar.SetCVar("spamFilter", 1)
C_CVar.SetCVar("chatMouseScroll", 1)

-- Floating Combat Text
C_CVar.SetCVar("enableFloatingCombatText", 0)
C_CVar.SetCVar("floatingCombatTextCombatDamageDirectionalScale", 0)
C_CVar.SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 0)
C_CVar.SetCVar("floatingCombatTextLowManaHealth", 0)
C_CVar.SetCVar("floatingCombatTextReactives", 0)

-- Graphics
C_CVar.SetCVar("renderscale", 0.999)
C_CVar.SetCVar("ResampleAlwaysSharpen", 1)

-- Nameplate
C_CVar.SetCVar('nameplateMaxDistance', 60)
C_CVar.SetCVar('nameplateOccludedAlphaMult',0.3)
C_CVar.SetCVar('NameplatePersonalShowAlways',0)
C_CVar.SetCVar('nameplateSelectedScale',1.4)
C_CVar.SetCVar('nameplateShowSelf',1)
C_CVar.SetCVar('nameplateTargetBehindMaxDistance',15)
C_CVar.SetCVar('nameplateTargetRadialPosition',0)
C_CVar.SetCVar("nameplateMotion", 1)
C_CVar.SetCVar("nameplateShowEnemies", 1)
C_CVar.SetCVar("nameplateShowEnemyPets", 1)
C_CVar.SetCVar("nameplateShowEnemyTotems", 1)
C_CVar.SetCVar("nameplateShowOnlyNames", 0)

-- Unit Frames
C_CVar.SetCVar("showTargetOfTarget", 0)
C_CVar.SetCVar("UnitNameEnemyGuardianName", 1)
C_CVar.SetCVar("UnitNameEnemyPetName", 1)
C_CVar.SetCVar("UnitNameEnemyPlayerName", 1)
C_CVar.SetCVar("UnitNameEnemyTotemName", 1)
C_CVar.SetCVar("UnitNameFriendlyGuardianName", 0)
C_CVar.SetCVar("UnitNameFriendlyPetName", 0)
C_CVar.SetCVar("UnitNameFriendlySpecialNPCName", 1)
C_CVar.SetCVar("UnitNameFriendlyTotemName", 0)
C_CVar.SetCVar("UnitNameGuildTitle", 0)
C_CVar.SetCVar("UnitNameInteractiveNPC", 0)
C_CVar.SetCVar("UnitNameNPC", 0)
C_CVar.SetCVar("UnitNameOwn", 0)
C_CVar.SetCVar("UnitNamePlayerGuild", 0)
C_CVar.SetCVar("UnitNamePlayerPVPTitle", 0)

-- Raid and Party frames
C_CVar.SetCVar("findYourselfInRaid", 1)
C_CVar.SetCVar("findYourselfInRaidOnlyInCombat", 1) 
C_CVar.SetCVar("useCompactPartyFrames", 1)
C_CVar.SetCVar("raidFramesDisplayAggroHighlight", 1)
C_CVar.SetCVar("raidFramesDisplayClassColor", 1)
C_CVar.SetCVar("raidFramesDisplayOnlyDispellableDebuffs", 1)
C_CVar.SetCVar("raidFramesDisplayHealthText", 0)
C_CVar.SetCVar("raidOptionDisplayMainTankAndAssist", 0)
C_CVar.SetCVar("raidOptionDisplayPets", 0)
C_CVar.SetCVar("raidFramesDisplayPowerBars", 0)
C_CVar.SetCVar("raidOptionKeepGroupsTogether", 1)

-- Toast
C_CVar.SetCVar("showToastBroadcast", 0)
C_CVar.SetCVar("showToastFriendRequest", 1)
C_CVar.SetCVar("showToastOffline", 0)
C_CVar.SetCVar("showToastOnline", 0)
C_CVar.SetCVar("showToastWindow", 0)

-- Minimap
C_CVar.SetCVar("minimapInsideZoom", 2)

-- Various
C_CVar.SetCVar("alwaysCompareItems", 1)
C_CVar.SetCVar("autoClearAFK", 1)
C_CVar.SetCVar("autoDismountFlying", 0)
C_CVar.SetCVar("autoLootDefault", 1)
C_CVar.SetCVar("cursorSizePreferred", 0)
C_CVar.SetCVar("lootUnderMouse", 0)
C_CVar.SetCVar("maxFPS", 60)
C_CVar.SetCVar("maxFPSBk", 8)
C_CVar.SetCVar("movieSubtitle", 1)
C_CVar.SetCVar("screenEdgeFlash", 0)
C_CVar.SetCVar("showTutorials", 0)
C_CVar.SetCVar("synchronizeBindings", 1)
C_CVar.SetCVar("synchronizeConfig", 1)
C_CVar.SetCVar("synchronizeMacros", 1)
C_CVar.SetCVar("synchronizeSettings", 1)

end);
