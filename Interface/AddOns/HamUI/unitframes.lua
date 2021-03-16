--------------------------------------------------------------------------------
-- TARGET FRAMES
--------------------------------------------------------------------------------
-- Set in-game player frame position
PlayerFrame:ClearAllPoints()
PlayerFrame:SetPoint("RIGHT", UIParent, "CENTER", -190, -95)
PlayerFrame.SetPoint = function() end
-- Set in-game target frame position
TargetFrame:ClearAllPoints()
TargetFrame:SetPoint("LEFT", UIParent, "CENTER", 190, -95)
TargetFrame.SetPoint = function()end
-- Remove buffs and debuffs from player and target frames
FocusFrame.maxBuffs = 0
FocusFrame.maxDebuffs  = 0
TargetFrame.maxBuffs = 0
TargetFrame.maxDebuffs = 0
PlayerFrame.maxBuffs = 0
PlayerFrame.maxDebuffs = 0
