-------------------------------------------------------------------------------

-- PLAYER FRAME
local enabled = true
local bigSpellIcon = true
local hideSpellIcon = false

if enabled then
	CastingBarFrame:SetFrameStrata("BACKGROUND")
	CastingBarFrame.Border:Hide()

	CastingBarFrame:SetWidth(PlayerFrameHealthBar:GetWidth())
	CastingBarFrame:SetHeight(PlayerName:GetHeight()*1.8)
	CastingBarFrame:ClearAllPoints()
	CastingBarFrame:SetPoint("CENTER", PlayerName, "CENTER", 0, 0)
	CastingBarFrame.SetPoint = function() end

	CastingBarFrame.Text:ClearAllPoints()
	CastingBarFrame.Text:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 0)
	CastingBarFrame.Text.SetPoint = function() end

	CastingBarFrame.Border:SetWidth(CastingBarFrame:GetWidth()*1.38)
	CastingBarFrame.Border:SetHeight(CastingBarFrame:GetHeight()*3.6)
	CastingBarFrame.Border:ClearAllPoints()
	CastingBarFrame.Border:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 0)
	CastingBarFrame.Border.SetPoint = function() end
	CastingBarFrame.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")

	CastingBarFrame.Flash:SetWidth(CastingBarFrame.Border:GetWidth())
	CastingBarFrame.Flash:SetHeight(CastingBarFrame.Border:GetHeight())
	CastingBarFrame.Flash:ClearAllPoints()
	CastingBarFrame.Flash:SetPoint("CENTER", CastingBarFrame.Border, "CENTER", 0, 0)
	CastingBarFrame.Flash.SetPoint = function() end
	CastingBarFrame.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small")


	CastingBarFrame:HookScript("OnShow", function()
		PlayerName:Hide()
		PlayerStatusTexture:Hide()
		PlayerFrameBackground:Hide()
		CastingBarFrame.Text:SetFontObject(GameFontNormalSmall);
		CastingBarFrame.Text:SetVertexColor(1, 1, 1);
		if bigSpellIcon and not hideSpellIcon then
			PlayerPortrait:Hide()
			CastingBarFrame.Icon:Show()
			CastingBarFrame.Icon:ClearAllPoints()
			CastingBarFrame.Icon:SetPoint("CENTER", PlayerPortrait, "CENTER", 0, 0)
			CastingBarFrame.Icon:SetWidth(PlayerPortrait:GetWidth()*.83)
			CastingBarFrame.Icon:SetHeight(PlayerPortrait:GetHeight()*.83)
			--CastingBarFrame.Icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask");
			if (CastingBarFrame.Icon:GetTexture() == "INTERFACE\\ICONS\\thumbsdown") or (CastingBarFrame.Icon:GetTexture() == "Portrait2") then
				return
			else
				SetPortraitToTexture(CastingBarFrame.Icon, CastingBarFrame.Icon:GetTexture())
			end
			CastingBarFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end)

	CastingBarFrame:HookScript("OnHide", function()
		PlayerName:Show()
		PlayerStatusTexture:Show()
		PlayerFrameBackground:Show()
		PlayerPortrait:Show()
	end)

	if not bigSpellIcon and not hideSpellIcon then
		CastingBarFrame.Icon:Show()
		CastingBarFrame.Icon:ClearAllPoints()
		CastingBarFrame.Icon:SetPoint("LEFT", CastingBarFrame, "RIGHT", 5, 0)
		CastingBarFrame.Icon.SetPoint = function() end
	end
end

-------------------------------------------------------------------------------

-- TARGET FRAME
local enabled = true
local bigSpellIcon = true
local hideSpellIcon = false

if enabled then
	TargetFrameSpellBar:SetFrameStrata("BACKGROUND")

	TargetFrameSpellBar:ClearAllPoints()
	TargetFrameSpellBar:SetPoint("TOPLEFT",TargetFrame,"TOPLEFT",7,-22)
	TargetFrameSpellBar:SetPoint("BOTTOMRIGHT",TargetFrame,"BOTTOMRIGHT",-109.5,60)
	TargetFrameSpellBar.SetPoint = function() end

	TargetFrameSpellBar.Flash:ClearAllPoints()
	TargetFrameSpellBar.Flash:SetPoint("CENTER", TargetFrameSpellBar, "CENTER", 0, -2)
	TargetFrameSpellBar.Flash:SetWidth(TargetFrameSpellBar:GetWidth()*1.38)
	TargetFrameSpellBar.Flash:SetHeight(TargetFrameSpellBar:GetHeight()*3.6)
	TargetFrameSpellBar.Flash.SetPoint = function() end

	TargetFrameSpellBar.BorderShield:SetAlpha(0)
	TargetFrameSpellBar.Border:SetAlpha(0)

	TargetFrameSpellBar.Text:ClearAllPoints()
	TargetFrameSpellBar.Text:SetPoint("CENTER", TargetFrameSpellBar, "CENTER", 0, 0)

	TargetFrameSpellBar:HookScript("OnShow", function()
		TargetFrameTextureFrameName:Hide()
		TargetFrameNameBackground:Hide()
		if bigSpellIcon then
			TargetFramePortrait:Hide()
			TargetFrameSpellBar.Icon:ClearAllPoints()
			TargetFrameSpellBar.Icon:SetPoint("CENTER", TargetFramePortrait, "CENTER", 0, 0)
			TargetFrameSpellBar.Icon:SetWidth(TargetFramePortrait:GetWidth())
			TargetFrameSpellBar.Icon:SetHeight(TargetFramePortrait:GetHeight())
			TargetFrameSpellBar.Icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask");
		end
	end)

	TargetFrameSpellBar:HookScript("OnHide", function()
		UIFrameFadeIn(TargetFrameTextureFrameName, .2, 0, 1)
		UIFrameFadeIn(TargetFrameNameBackground, .2, 0, 1)
		TargetFramePortrait:Show()
	end)

	if hideSpellIcon then
		TargetFrameSpellBar.Icon:Hide()
	end
end
