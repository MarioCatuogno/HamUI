-------------------------------------------------------------------------------

-- CHANGES THE FORMAT OF HP/MANA TO ABSOLUTE VALUES
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()
	PlayerFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("player")))
	PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player")))

	TargetFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("target")))
	TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target")))

	FocusFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("focus")))
	FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus")))
end)

-------------------------------------------------------------------------------

-- DISABLE GROUP NUMBER FRAME
PlayerFrameGroupIndicator.Show = function() return end

-------------------------------------------------------------------------------

-- HIDE PVP ICONS FROM PLAYER/TARGET/FOCUS FRAMES
PlayerPVPIcon:SetAlpha(0)
TargetFrameTextureFramePVPIcon:SetAlpha(0)
FocusFrameTextureFramePVPIcon:SetAlpha(0)

-------------------------------------------------------------------------------

-- HIDE FLOATING DAMAGE/HEAL ON PORTRAIT PLAYER NAME
PlayerHitIndicator.Show = function() end

-------------------------------------------------------------------------------

-- SHOW BUFF/DEBUFFS ON TARGET FRAME
TargetFrame.maxBuffs = 0
TargetFrame.maxDebuffs = 5
MAX_TARGET_BUFFS = 0
MAX_TARGET_DEBUFFS = 5
TargetFrame_UpdateAuras(TargetFrame)

-------------------------------------------------------------------------------

-- HIDE PET NAME
PetName:Hide()

-------------------------------------------------------------------------------

-- HIDE COLORS BEHIND NAME
hooksecurefunc("TargetFrame_CheckFaction", function(self)
    self.nameBackground:SetVertexColor(0, 0, 0, 0);
end)

-- CLASS COLOR HP BAR
local function colour(statusbar, unit)
        local _, class, c
        if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
                _, class = UnitClass(unit)
                c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
                statusbar:SetStatusBarColor(c.r, c.g, c.b)
                --PlayerFrameHealthBar:SetStatusBarColor(0,1,0)
        end
end

hooksecurefunc("UnitFrameHealthBar_Update", colour)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
        colour(self, self.unit)
end)

-------------------------------------------------------------------------------

-- STOP RED FLASH RESTING
-hooksecurefunc("PlayerFrame_UpdateStatus", function()
-   if IsResting("player") then
-      PlayerStatusTexture:Hide()
-      PlayerRestGlow:Hide()
-      PlayerStatusGlow:Hide()
-   end
-end)
