-------------------------------------------------------------------------------

-- REMOVE REALM NAMES FROM BLIZZARD RAID FRAMES
hooksecurefunc("CompactUnitFrame_UpdateName",function(frame)
	frame.name:SetText(GetUnitName(frame.unit,true):match("[^-]+"))
end)

-------------------------------------------------------------------------------
