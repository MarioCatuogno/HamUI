--------------------------------------------------------------------------------
-- ACTION BAR
--------------------------------------------------------------------------------

local setupUiActionBar = CreateFrame("Frame");
setupUiActionBar:RegisterEvent("PLAYER_ENTERING_WORLD");
setupUiActionBar:RegisterEvent("PLAYER_LOGIN");
setupUiActionBar:RegisterEvent("ACTIONBAR_SHOWGRID");
setupUiActionBar:RegisterEvent("PET_BAR_UPDATE");
setupUiActionBar:SetScript("OnEvent",function()

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

  -- Hide Micro Menu bar popup
  function MainMenuMicroButton_AreAlertsEnabled()
    return false
  end;

end);

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
ChatFrameChannelButton:UnregisterAllEvents();

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
-- UNIT FRAMES
--------------------------------------------------------------------------------
-- Remove damage and healing text in portraits
COMBATFEEDBACK_FADEINTIME = 0 
COMBATFEEDBACK_HOLDTIME = 0 
COMBATFEEDBACK_FADEOUTTIME = 0

--------------------------------------------------------------------------------
-- TOOLTIPS
--------------------------------------------------------------------------------

-- Show Spell ID
GameTooltip:HookScript("OnTooltipSetSpell", function(self)
local name, id = self:GetSpell()
if id then
  self:AddLine("    ")
  self:AddLine("ID: " .. tostring(id), 1, 1, 1)
end
end)

--------------------------------------------------------------------------------
-- RAID AND PARTY
--------------------------------------------------------------------------------

-- Hide server in Raid Frame
hooksecurefunc("CompactUnitFrame_UpdateName",function(frame)
if frame.optionTable.displayName then
    frame.name:SetText((UnitName(frame.unit)));
    frame.name:Show()
end
end);

-- Hide group names in Raid Frame
hooksecurefunc("CompactRaidGroup_InitializeForGroup", function(frame)
frame.title:SetText("");
end);

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
C_CVar.SetCVar("floatingCombatTextCombatDamage", 1)
C_CVar.SetCVar("floatingCombatTextCombatLogPeriodicSpells", 1)
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

--------------------------------------------------------------------------------
-- VARIOUS
--------------------------------------------------------------------------------

-- Automatically sell grey icons
local sellGreyIcons = CreateFrame("Frame")
sellGreyIcons:RegisterEvent("MERCHANT_SHOW")
sellGreyIcons:SetScript("OnEvent", function()  
  local bag, slot
  for bag = 0, 4 do
    for slot = 0, GetContainerNumSlots(bag) do
      local link = GetContainerItemLink(bag, slot)
      if link and (select(3, GetItemInfo(link)) == 0) then
        UseContainerItem(bag, slot)
      end
    end
  end
end);
