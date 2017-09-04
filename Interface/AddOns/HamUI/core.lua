--------------------------------------------------------------------------------
-- TOOLTIP
--------------------------------------------------------------------------------
-- Set in-game tooltip position
 hooksecurefunc("GameTooltip_SetDefaultAnchor", function (tooltip, parent)
  tooltip:SetOwner(parent, "ANCHOR_NONE");
  tooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 10, 40);
 end)
--------------------------------------------------------------------------------
-- HIDE FRAMES
--------------------------------------------------------------------------------
-- Create a new frame OnUpdate
 local Frame = CreateFrame("Frame")
  Frame:SetScript("OnUpdate", function(self,...)
-- Hide flashing for Player, Target and Focus frames
   PlayerFrameFlash:Hide()
   TargetFrameFlash:Hide()
   FocusFrameFlash:Hide()
-- Hide loss of control frames
   LossOfControlFrame:Hide()
-- Hide target of target frames
   TargetFrameToTTextureFrameName:Hide()
   FocusFrameToTTextureFrameName:Hide()
-- Hide minimap zoom-in/zoom-out buttons
   MinimapZoomIn:Hide()
   MinimapZoomOut:Hide()
-- Hide group indicator
   PlayerFrameGroupIndicator:Hide()
-- Hide pet name
   PetName:Hide()
-- Hide player hit indicator
   PlayerHitIndicator:Hide()
-- Hide PVP icons
   PlayerPVPIcon:Hide()
   TargetFrameTextureFramePVPIcon:Hide()
   FocusFrameTextureFramePVPIcon:Hide()
  self:SetScript("OnUpdate",nil)
 end)
--------------------------------------------------------------------------------
-- TARGET FRAMES
--------------------------------------------------------------------------------
-- Set in-game player frame position
 PlayerFrame:ClearAllPoints()
 PlayerFrame:SetPoint("RIGHT", UIParent, "CENTER", -190, -95)
 PlayerFrame.SetPoint = function() end
-- Set in-game target frame position
 TargetFrame:ClearAllPoints()
 TargetFrame:SetPoint("RIGHT", UIParent, "CENTER", 420, -95)
 TargetFrame.SetPoint = function()end
-- Set number of buffs/debuffs for target frame
 TargetFrame.maxBuffs = 0
 TargetFrame.maxDebuffs = 5
 MAX_TARGET_BUFFS = 0
 MAX_TARGET_DEBUFFS = 5
 TargetFrame_UpdateAuras(TargetFrame)
-- Hide names background for frames
 hooksecurefunc("TargetFrame_CheckFaction", function(self)
  self.nameBackground:SetVertexColor(0, 0, 0, 0);
 end)
-- Class colour frames
 local function colour(statusbar, unit)
  local _, class, c
   if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit
   and UnitClass(unit) then
    _, class = UnitClass(unit)
    c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
    statusbar:SetStatusBarColor(c.r, c.g, c.b)
   end
  end
 hooksecurefunc("UnitFrameHealthBar_Update", colour)
 hooksecurefunc("HealthBar_OnValueChanged", function(self)
  colour(self, self.unit)
 end)
--------------------------------------------------------------------------------
-- MINIMAP
--------------------------------------------------------------------------------
-- Enable zoom-in/zoom-out with mouse wheel
 Minimap:EnableMouseWheel(true)
 Minimap:SetScript('OnMouseWheel', function(self, delta)
  if delta > 0 then
   Minimap_ZoomIn()
  else
   Minimap_ZoomOut()
  end
 end)
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
