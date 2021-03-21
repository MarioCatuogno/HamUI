--------------------------------------------------------------------------------
-- ACTION BAR
--------------------------------------------------------------------------------

  -- Hide Hotkeys and Macro
  for i=1, 12 do

    _G["ActionButton"..i.."HotKey"]:SetAlpha(0) -- main bar
    _G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0) -- bottom right bar
    _G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0) -- bottom left bar
    _G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0) -- right bar
    _G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(0) -- left bar

    _G["ActionButton"..i.."Name"]:SetAlpha(0) -- main bar
    _G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0) -- bottom right bar
    _G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0) -- bottom left bar
    _G["MultiBarRightButton"..i.."Name"]:SetAlpha(0) -- right bar
    _G["MultiBarLeftButton"..i.."Name"]:SetAlpha(0) -- left bar

  end;

-- Micro Menu bar
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

-- Main Menu bar
  local b1 = MainMenuBarArtFrameBackground b1:UnregisterAllEvents() b1:SetScript("OnShow", b1.Hide) b1:Hide();
  local b2 = ActionBarUpButton b2:UnregisterAllEvents() b2:SetScript("OnShow", b2.Hide) b2:Hide();
  local b3 = ActionBarDownButton b3:UnregisterAllEvents() b3:SetScript("OnShow", b3.Hide) b3:Hide();
  local b4 = StatusTrackingBarManager b4:UnregisterAllEvents() b4:SetScript("OnShow", b4.Hide) b4:Hide();

  MainMenuBarArtFrame.LeftEndCap:Hide();
  MainMenuBarArtFrame.RightEndCap:Hide();
  MainMenuBarArtFrame.PageNumber:Hide();
  SlidingActionBarTexture0:SetAlpha(0);
  SlidingActionBarTexture1:SetAlpha(0);
  StanceBarLeft:SetAlpha(0);
  StanceBarRight:SetAlpha(0);
  StanceButton1NormalTexture2:SetAlpha(0);

-- Extra Action button
  ExtraActionButton1:ClearAllPoints();
  ExtraActionButton1:SetPoint("TOP", UIParent, "TOP", 0, -100);
  ExtraActionButton1:SetScale(0.9);
  ExtraActionButton1.style:SetAlpha(0);
  ExtraActionButton1.style:Hide();

-- Zone Ability button
  ZoneAbilityFrame:ClearAllPoints();
  ZoneAbilityFrame:SetPoint("TOP", UIParent, "TOP", 0, -100);
  ZoneAbilityFrame:SetScale(0.9);
  ZoneAbilityFrame.Style:SetAlpha(0);
  ZoneAbilityFrame.Style:Hide();

--------------------------------------------------------------------------------
-- ALIGN
--------------------------------------------------------------------------------

-- Align (eAlign)
  SLASH_EA1 = "/align"
  local f
  SlashCmdList["EA"] = function()
    if f then
      f:Hide()
      f = nil    
    else
      f = CreateFrame('Frame', nil, UIParent) 
      f:SetAllPoints(UIParent)
      local w = GetScreenWidth() / 64
      local h = GetScreenHeight() / 36
      for i = 0, 64 do
        local t = f:CreateTexture(nil, 'BACKGROUND')
        if i == 32 then
          t:SetColorTexture(1, 1, 0, 0.5)
        else
          t:SetColorTexture(1, 1, 1, 0.15)
        end
        t:SetPoint('TOPLEFT', f, 'TOPLEFT', i * w - 1, 0)
        t:SetPoint('BOTTOMRIGHT', f, 'BOTTOMLEFT', i * w + 1, 0)
      end
      for i = 0, 36 do
        local t = f:CreateTexture(nil, 'BACKGROUND')
        if i == 18 then
          t:SetColorTexture(1, 1, 0, 0.5)
        else
          t:SetColorTexture(1, 1, 1, 0.15)
        end
        t:SetPoint('TOPLEFT', f, 'TOPLEFT', 0, -i * h + 1)
        t:SetPoint('BOTTOMRIGHT', f, 'TOPRIGHT', 0, -i * h - 1)
      end  
    end
  end

--------------------------------------------------------------------------------
-- CAST BAR
--------------------------------------------------------------------------------

-- Set in-game player cast bar position
  CastingBarFrame:ClearAllPoints()
  CastingBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -240)
  CastingBarFrame:SetFrameStrata("LOW")
  CastingBarFrame.SetPoint = function() end
  CastingBarFrame:SetScale(1.0)

-- Set in-game target cast bar position
  TargetFrameSpellBar:ClearAllPoints()
  TargetFrameSpellBar:SetPoint("CENTER", TargetFrame, "TOP", -10, 10)
  TargetFrameSpellBar:SetFrameStrata("LOW")
  TargetFrameSpellBar.SetPoint = function() end
  TargetFrameSpellBar:SetScale(1.0)

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

-- Position Chat frame
  ChatFrame1:ClearAllPoints();
  ChatFrame1:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 10, 10);
  ChatFrame1:SetWidth(150);
  ChatFrame1:SetHeight(121);

  local function DoNothing() end
    ChatFrame1.ClearAllPoints = DoNothing
    ChatFrame1.SetPoint = DoNothing
  ;

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
-- TOOLTIPS
--------------------------------------------------------------------------------

-- Set in-game tooltip position
  hooksecurefunc("GameTooltip_SetDefaultAnchor", function (tooltip, parent)
  tooltip:SetOwner(parent, "ANCHOR_NONE");
  tooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -40, 60);
  end)

-- Show Spell ID
  GameTooltip:HookScript("OnTooltipSetSpell", function(self)
    local name, id = self:GetSpell()
    if id then
      self:AddLine("    ")
      self:AddLine("ID: " .. tostring(id), 1, 1, 1)
    end
  end)

--------------------------------------------------------------------------------
-- UNIT FRAMES
--------------------------------------------------------------------------------

-- Remove damage and healing text in portraits
  COMBATFEEDBACK_FADEINTIME = 0 
  COMBATFEEDBACK_HOLDTIME = 0 
  COMBATFEEDBACK_FADEOUTTIME = 0

-- Position of Player, Target and Focus frames
  local loadingFrame = CreateFrame("Frame");
    loadingFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
    loadingFrame:SetScript("OnEvent",function()

-- Player frame
    PlayerFrame:ClearAllPoints();
    PlayerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0);
    PlayerFrame.maxBuffs = 0;
    PlayerFrame.maxDebuffs = 0;
    PlayerFrameFlash:Hide();
    PlayerHitIndicator:Hide();
    PlayerPVPIcon:SetAlpha(0);
    PlayerFrameRoleIcon:SetAlpha(0);
    PlayerLeaderIcon:SetAlpha(0);
    PlayerRestIcon:Hide();
    PlayerFrame:SetUserPlaced(true);

-- Fade In/Out Player frame
    PlayerFrame:SetAlpha(0)
    PlayerFrame:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
    PlayerFrame:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

-- Target frame
    TargetFrame:ClearAllPoints();
    TargetFrame:SetPoint("CENTER", UIParent, "CENTER", 250, -145);
    TargetFrame.maxBuffs = 0;
    TargetFrame.maxDebuffs = 0;
    TargetFrameFlash:Hide();
    TargetFrameTextureFramePVPIcon:SetAlpha(0);
    TargetFrameTextureFramePrestigeBadge:SetAlpha(0);
    TargetFrameTextureFramePrestigePortrait:SetAlpha(0);
    TargetFrameTextureFrameLeaderIcon:SetAlpha(0);
    TargetFrame:SetUserPlaced(true);

-- Focus Frame
    FocusFrame:ClearAllPoints();
    FocusFrame:SetPoint("CENTER", UIParent, "CENTER", 375, 290);
    FocusFrame.maxBuffs = 0;
    FocusFrame.maxDebuffs  = 0;
    FocusFrameFlash:Hide();
    FocusFrameTextureFramePVPIcon:SetAlpha(0);
    FocusFrame:SetUserPlaced(true);

-- Pet Frame
    PetFrame:ClearAllPoints();
    PetFrame:Hide();
    PetFrame:HookScript("OnShow",function(self) self:Hide() end)

  end);

-- Rest
  hooksecurefunc("PlayerFrame_UpdateStatus", function()
    if IsResting("player") then
      PlayerStatusTexture:Hide()
      PlayerRestGlow:Hide()
      PlayerStatusGlow:Hide()
    elseif PlayerFrame.inCombat then
      PlayerStatusTexture:Hide()
      PlayerAttackGlow:Hide()
      PlayerStatusGlow:Hide()
    end
  end)

-- Hidden names background
  hooksecurefunc("TargetFrame_CheckFaction", function(self)
    if ( not UnitPlayerControlled(self.unit)) then
    self.nameBackground:SetVertexColor(0, 0, 0, 0);
      if ( self.portrait ) then
      self.portrait:SetVertexColor(1.0, 1.0, 1.0, 1.0);
      end
  else
    self.nameBackground:SetVertexColor(0, 0, 0, 0);
      if ( self.portrait ) then
      self.portrait:SetVertexColor(1.0, 1.0, 1.0);
      end
    end
  end)

-- Colored health bar
  local function colour(statusbar, unit)
    local _, class, c
    if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
    _, class = UnitClass(unit)
    c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
    statusbar:SetStatusBarColor(c.r, c.g, c.b)
    end
  end
  hooksecurefunc("UnitFrameHealthBar_Update", colour)
  hooksecurefunc("HealthBar_OnValueChanged", function(self)
    colour(self, self.unit)
  end)

-- Class icon portrait
  hooksecurefunc("UnitFramePortrait_Update",function(self)
    if self.portrait then
      if UnitIsPlayer(self.unit) then                
        local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
          if t then
            self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
            self.portrait:SetTexCoord(unpack(t))
          end
      else
          self.portrait:SetTexCoord(0,1,0,1)
          end
      end
  end)

-- Power Bar
  ComboPointPlayerFrame:Hide()
  ComboPointPlayerFrame:HookScript("OnShow",function(self) self:Hide() end)
  MageArcaneChargesFrame:Hide()
  MageArcaneChargesFrame:HookScript("OnShow",function(self) self:Hide() end)
  MonkHarmonyBarFrame:Hide()
  MonkHarmonyBarFrame:HookScript("OnShow",function(self) self:Hide() end)
  PaladinPowerBarFrame:Hide()
  PaladinPowerBarFrame:HookScript("OnShow",function(self) self:Hide() end)
  PriestBarFrame:Hide()
  PriestBarFrame:HookScript("OnShow",function(self) self:Hide() end)
  RuneFrame:Hide()
  RuneFrame:HookScript("OnShow",function(self) self:Hide() end)
  WarlockPowerFrame:Hide()
  WarlockPowerFrame:HookScript("OnShow",function(self) self:Hide() end)

--------------------------------------------------------------------------------
-- RAID AND PARTY
--------------------------------------------------------------------------------

-- Hide server in Raid Frame
hooksecurefunc("CompactUnitFrame_UpdateName",function(frame)
  if frame.optionTable.displayName then
  frame.name:SetText(GetUnitName(frame.unit,true):match("[^-]+"))
  --frame.name:Show()
  else frame.name:Hide() end
end);

-- Hide group names in Raid Frame
hooksecurefunc("CompactRaidGroup_InitializeForGroup", function(frame)
  frame.title:SetText("");
end);

-- Indicators
PlayerFrameGroupIndicator:Hide()
PlayerFrameGroupIndicator:HookScript("OnShow",function(self) self:Hide() end)

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------

-- Set Variables
  local varShow = CreateFrame("Frame")
    varShow:RegisterEvent("PLAYER_LOGIN")
    varShow:SetScript("OnEvent",function(self, event, ...)

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

    -- Unit Frames
      C_CVar.SetCVar("showTargetOfTarget", 1)

    -- Raid and Party frames
      C_CVar.SetCVar("useCompactPartyFrames", 1)
      C_CVar.SetCVar("raidFramesDisplayAggroHighlight", 1)
      C_CVar.SetCVar("raidFramesDisplayClassColor", 1)
      C_CVar.SetCVar("raidFramesDisplayOnlyDispellableDebuffs", 1)
      C_CVar.SetCVar("raidFramesDisplayHealthText", 0)
      C_CVar.SetCVar("raidFramesDisplayPowerBars", 0)
      C_CVar.SetCVar("raidOptionKeepGroupsTogether", 1)

    -- Various
      C_CVar.SetCVar("autoLootDefault", 1)
      C_CVar.SetCVar("lootUnderMouse", 0)
      C_CVar.SetCVar("cursorSizePreferred", 0)
      C_CVar.SetCVar("showTutorials", 0)
      C_CVar.SetCVar("movieSubtitle", 1)
      C_CVar.SetCVar("screenEdgeFlash", 0)
      C_CVar.SetCVar("autoClearAFK", 0)
      C_CVar.SetCVar("autoDismountFlying", 0)
      C_CVar.SetCVar("synchronizeBindings", 1)
      C_CVar.SetCVar("synchronizeConfig", 1)
      C_CVar.SetCVar("synchronizeMacros", 1)
      C_CVar.SetCVar("synchronizeSettings", 1)

    -- Nameplates
      C_CVar.SetCVar('NameplatePersonalShowAlways',1)
      C_CVar.SetCVar('nameplateShowSelf',1)
      C_CVar.SetCVar("nameplateShowAll", 1)
      C_CVar.SetCVar("nameplateShowOnlyNames", 0)
      C_CVar.SetCVar("nameplateMotion", 1)
      C_CVar.SetCVar("UnitNameNPC", 0)
      C_CVar.SetCVar("UnitNameInteractiveNPC", 0)
      C_CVar.SetCVar("UnitNameFriendlyTotemName", 0)
      C_CVar.SetCVar("UnitNameFriendlyGuardianName", 0)
      C_CVar.SetCVar("UnitNameFriendlyPetName", 0)
      C_CVar.SetCVar("UnitNamePlayerPVPTitle", 0)
      C_CVar.SetCVar("UnitNamePlayerGuild", 0)
      C_CVar.SetCVar("UnitNameGuildTitle", 0)
      C_CVar.SetCVar("UnitNameOwn", 0)
      C_CVar.SetCVar("UnitNameEnemyPlayerName", 1)
      C_CVar.SetCVar("UnitNameEnemyPetName", 1)
      C_CVar.SetCVar("UnitNameEnemyGuardianName", 1)
      C_CVar.SetCVar("UnitNameEnemyTotemName", 1)
      C_CVar.SetCVar("UnitNameFriendlySpecialNPCName", 1)

  end);

--------------------------------------------------------------------------------
-- VARIOUS
--------------------------------------------------------------------------------

-- Automatically sell grey icons
  local g = CreateFrame("Frame")
  g:RegisterEvent("MERCHANT_SHOW")
  g:SetScript("OnEvent", function()  
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
