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