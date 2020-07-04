--------------------------------------------------------------------------------
-- TOOLTIP
--------------------------------------------------------------------------------
-- Set in-game tooltip position
-- hooksecurefunc("GameTooltip_SetDefaultAnchor", function (tooltip, parent)
--  tooltip:SetOwner(parent, "ANCHOR_NONE");
--  tooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 10, 100);
-- end)
 --------------------------------------------------------------------------------
-- RAID
--------------------------------------------------------------------------------
-- Hide server from raid frames
-- hooksecurefunc("CompactUnitFrame_UpdateName",function(frame)
--   frame.name:SetText(GetUnitName(frame.unit,true):match("[^-]+"))
-- end)
--hooksecurefunc("CompactUnitFrame_UpdateName",function(frame)
--  if frame and not frame:IsForbidden() then
--    local frame_name = frame:GetName()
--    if frame_name and frame_name:match("^CompactRaidFrame%d") and frame.unit and frame.name then
--      local unit_name = GetUnitName(frame.unit,true)
--      if unit_name then
--        frame.name:SetText(unit_name:match("[^-]+"))
--      end
--    end
--  end
--end)
--hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
--  if ShouldShowName(frame) then
--      if frame.optionTable.colorNameBySelection then
--          frame.name:SetText(GetUnitName(frame.unit))
--      end
--  end
--end)
--------------------------------------------------------------------------------
-- HIDE FRAMES
--------------------------------------------------------------------------------
---- Create a new frame OnUpdate
-- local Frame = CreateFrame("Frame")
--  Frame:SetScript("OnUpdate", function(self,...)
---- Hide flashing for Player, Target and Focus frames
--   PlayerFrameFlash:Hide()
--   TargetFrameFlash:Hide()
--   FocusFrameFlash:Hide()
---- Hide loss of control frames
--   LossOfControlFrame:Hide()
---- Hide target of target frames
--   TargetFrameToTTextureFrameName:Hide()
--   FocusFrameToTTextureFrameName:Hide()
---- Hide minimap zoom-in/zoom-out buttons
--   MinimapZoomIn:Hide()
--   MinimapZoomOut:Hide()
---- Hide group indicator
--   PlayerFrameGroupIndicator:Hide()
---- Hide pet name
--   PetName:Hide()
---- Hide player hit indicator
--   PlayerHitIndicator:Hide()
---- Hide PVP icons
--   PlayerPVPIcon:Hide()
--   TargetFrameTextureFramePVPIcon:Hide()
--   FocusFrameTextureFramePVPIcon:Hide()
---- Hide micromenu bar
--   MicroButtonAndBagsBar:Hide()
--   CharacterMicroButton:Hide()
--   SpellbookMicroButton:Hide()
--   TalentMicroButton:Hide()
--   AchievementMicroButton:Hide()
--   QuestLogMicroButton:Hide()
--   GuildMicroButton:Hide()
--   LFDMicroButton:Hide()
--   CollectionsMicroButton:Hide()
--   EJMicroButton:Hide()
--   StoreMicroButton:Hide()
--   hooksecurefunc("UpdateMicroButtons",function(...) if StoreMicroButton then StoreMicroButton:Hide() end end)
--  self:SetScript("OnUpdate",nil)
-- end)
-- Fix LUA errors
--  if not AchievementMicroButton_Update then
--   AchievementMicroButton_Update = function() end
--  end
-- Hide micromenu alerts
--  function MainMenuMicroButton_AreAlertsEffectivelyEnabled()
--   return false;
--return g_microButtonAlertsEnabled and not next(g_visibleExternalAlerts);
--  end

-- Hide names background for frames
-- hooksecurefunc("TargetFrame_CheckFaction", function(self)
--  self.nameBackground:SetVertexColor(0, 0, 0, 0);
-- end)
-- Class colour frames
-- local function colour(statusbar, unit)
--  local _, class, c
--   if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit
--   and UnitClass(unit) then
--    _, class = UnitClass(unit)
--    c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
--    statusbar:SetStatusBarColor(c.r, c.g, c.b)
--   end
--  end
-- hooksecurefunc("UnitFrameHealthBar_Update", colour)
-- hooksecurefunc("HealthBar_OnValueChanged", function(self)
--  colour(self, self.unit)
-- end)
--------------------------------------------------------------------------------
-- MINIMAP
--------------------------------------------------------------------------------
---- Enable zoom-in/zoom-out with mouse wheel
-- Minimap:EnableMouseWheel(true)
-- Minimap:SetScript('OnMouseWheel', function(self, delta)
--  if delta > 0 then
--   Minimap_ZoomIn()
--  else
--   Minimap_ZoomOut()
--  end
-- end)
--------------------------------------------------------------------------------
-- CAST BAR
--------------------------------------------------------------------------------
-- Set in-game player cast bar position
 CastingBarFrame:ClearAllPoints()
 CastingBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -300)
 CastingBarFrame.SetPoint = function() end
 CastingBarFrame:SetScale(1.0)
-- Set in-game target cast bar position
 TargetFrameSpellBar:ClearAllPoints()
 TargetFrameSpellBar:SetPoint("CENTER", TargetFrame, "TOP", -10, 10)
 TargetFrameSpellBar.SetPoint = function() end
 TargetFrameSpellBar:SetScale(1.0)
-- Hide hotkeys
 for i=1, 12 do
   _G["ActionButton"..i.."HotKey"]:SetAlpha(0) -- main bar
   _G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0) -- bottom right bar
   _G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0) -- bottom left bar
   _G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0) -- right bar
   _G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(0) -- left bar
 end
-- Hide macro names
 for i=1, 12 do
   _G["ActionButton"..i.."Name"]:SetAlpha(0) -- main bar
   _G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0) -- bottom right bar
   _G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0) -- bottom left bar
   _G["MultiBarRightButton"..i.."Name"]:SetAlpha(0) -- right bar
   _G["MultiBarLeftButton"..i.."Name"]:SetAlpha(0) -- left bar
 end
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
 CHAT_TAB_SHOW_DELAY = 0
 CHAT_TAB_HIDE_DELAY = 0
 CHAT_FRAME_FADE_TIME = 0
 CHAT_FRAME_FADE_OUT_TIME = 0
-- Configure more font sizes
 CHAT_FONT_HEIGHTS = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}
-- Chat mousover
 CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
 CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
 CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 0.5
 CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
--------------------------------------------------------------------------------
-- COMBAT TEXT
--------------------------------------------------------------------------------
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
