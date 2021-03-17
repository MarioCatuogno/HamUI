--------------------------------------------------------------------------------
-- ACTION BAR
--------------------------------------------------------------------------------

  -- Hide Hotkeys
    for i=1, 12 do
      _G["ActionButton"..i.."HotKey"]:SetAlpha(0) -- main bar
      _G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0) -- bottom right bar
      _G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0) -- bottom left bar
      _G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0) -- right bar
      _G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(0) -- left bar
  -- Hide macro names
      _G["ActionButton"..i.."Name"]:SetAlpha(0) -- main bar
      _G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0) -- bottom right bar
      _G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0) -- bottom left bar
      _G["MultiBarRightButton"..i.."Name"]:SetAlpha(0) -- right bar
      _G["MultiBarLeftButton"..i.."Name"]:SetAlpha(0) -- left bar
    end

  -- Hide Micromenu Bar
    local loadingMenu = CreateFrame("Frame")
    loadingMenu:SetScript("OnUpdate", function(self,...)
      MicroButtonAndBagsBar:Hide()
      CharacterMicroButton:Hide()
      SpellbookMicroButton:Hide()
      TalentMicroButton:Hide()
      AchievementMicroButton:Hide()
      QuestLogMicroButton:Hide()
      GuildMicroButton:Hide()
      LFDMicroButton:Hide()
      CollectionsMicroButton:Hide()
      EJMicroButton:Hide()
      StoreMicroButton:Hide()
      StoreMicroButton:Hide()
    hooksecurefunc("UpdateMicroButtons",function(...) if StoreMicroButton then StoreMicroButton:Hide() end end)
      self:SetScript("OnUpdate",nil)
    end)

  -- Move and resize Extra Action Button
      --ExtraActionButton1:ClearAllPoints();
      --ExtraActionButton1:SetPoint("CENTER", UIParent, "CENTER", -250, -50);
      --ExtraActionButton1:SetScale(0.9);
      --ExtraActionButton1.style:SetAlpha(0);

--------------------------------------------------------------------------------
-- CAST BAR
--------------------------------------------------------------------------------

  -- Set in-game player cast bar position
    CastingBarFrame:ClearAllPoints()
    CastingBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -130)
    CastingBarFrame.SetPoint = function() end
    CastingBarFrame:SetScale(1.0)
  -- Set in-game target cast bar position
    TargetFrameSpellBar:ClearAllPoints()
    TargetFrameSpellBar:SetPoint("CENTER", TargetFrame, "TOP", -10, 10)
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
-- RAID FRAMES
--------------------------------------------------------------------------------

  -- Hide Server name
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
-- UNIT FRAMES
--------------------------------------------------------------------------------

  -- Position of Player, Target and Focus frames
    local loadingFrame = CreateFrame("Frame");
    loadingFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
    loadingFrame:SetScript("OnEvent",function()
  -- Player frame
      PlayerFrame:ClearAllPoints();
      PlayerFrame:SetPoint("CENTER", UIParent, "CENTER", -250, -145);
      PlayerFrame.maxBuffs = 0;
      PlayerFrame.maxDebuffs = 0;
      PlayerFrameFlash:Hide();
      PlayerHitIndicator:Hide();
      PlayerPVPIcon:SetAlpha(0);
      --PlayerFrame:SetUserPlaced(true);
  -- Target frame
      TargetFrame:ClearAllPoints();
      TargetFrame:SetPoint("CENTER", UIParent, "CENTER", 250, -145);
      TargetFrame.maxBuffs = 0;
      TargetFrame.maxDebuffs = 0;
      TargetFrameFlash:Hide();
      TargetFrameTextureFramePVPIcon:SetAlpha(0);
      --TargetFrame:SetUserPlaced(true);
  -- Focus Frame
      FocusFrame:ClearAllPoints();
      FocusFrame:SetPoint("CENTER", UIParent, "CENTER", 375, 290);
      FocusFrame.maxBuffs = 0;
      FocusFrame.maxDebuffs  = 0;
      FocusFrameFlash:Hide();
      FocusFrameTextureFramePVPIcon:SetAlpha(0);
  -- Pet Frame
     PetName:Hide();
    end);

  -- Hidden names background
    hooksecurefunc("TargetFrame_CheckFaction", function(self)
      if ( not UnitPlayerControlled(self.unit) and UnitIsTapped(self.unit) and not UnitIsTappedByPlayer(self.unit) and not UnitIsTappedByAllThreatList(self.unit) ) then
      self.nameBackground:SetVertexColor(0, 0, 0, 0);
        if ( self.portrait ) then
        self.portrait:SetVertexColor(0, 0, 0, 0);
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

  -- Indicators
    --PlayerFrameGroupIndicator.Show = function() return end;
    PlayerFrameGroupIndicator:Hide()
    PlayerFrameGroupIndicator:HookScript("OnShow",function(self) self:Hide() end)
