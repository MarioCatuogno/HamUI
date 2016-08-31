-------------------------------------------------------------------------------

-- DISABLE DAMAGE/HEALING SPAM IN COMBAT FLOATING TEXT (by Arena Junkies)
LoadAddOn("Blizzard_CombatText")

COMBAT_TEXT_TYPE_INFO["PERIODIC_HEAL"] = {var = nil, show = nil}
COMBAT_TEXT_TYPE_INFO["HEAL_CRIT"] = {var = nil, show = nil}
COMBAT_TEXT_TYPE_INFO["HEAL"] = {var = nil, show = nil}
COMBAT_TEXT_TYPE_INFO["PERIODIC_HEAL_ABSORB"] = {var = nil, show = nil}
COMBAT_TEXT_TYPE_INFO["HEAL_CRIT_ABSORB"] = {var = nil, show = nil}
COMBAT_TEXT_TYPE_INFO["HEAL_ABSORB"] = {var = nil, show = nil}

COMBAT_TEXT_TYPE_INFO["DAMAGE_CRIT"] = {var = nil, show = nil}
COMBAT_TEXT_TYPE_INFO["DAMAGE"] = {var = nil, show = nil}
COMBAT_TEXT_TYPE_INFO["SPELL_DAMAGE_CRIT"] = {var = nil, show = nil}
COMBAT_TEXT_TYPE_INFO["SPELL_DAMAGE"] = {var = nil, show = nil}

-------------------------------------------------------------------------------

-- MINIMAP

-- Minimap Position
MinimapCluster:SetScale(1.0)
MinimapCluster:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -10, -10)
MinimapZoneText:SetPoint("TOPLEFT","MinimapZoneTextButton","TOPLEFT", 5, 0)
MinimapZoneText:SetFont(STANDARD_TEXT_FONT, 12, "THINOUTLINE")

-- Hide Objects
MinimapZoomIn:Hide()			-- Zoom In Button
MinimapZoomOut:Hide()			-- Zoom Out Button
MiniMapWorldMapButton:Hide()	-- World Map Button
MinimapNorthTag:SetTexture()	-- North Compass Pointer

-- Enable Mouse Wheel Scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, direction)
local zoom, maxZoom = self:GetZoom() + direction, self:GetZoomLevels()
	self:SetZoom(zoom >= maxZoom and maxZoom or zoom <= 0 and 0 or zoom)
end)

-------------------------------------------------------------------------------

-- OBJECTIVE TRACKER FRAME
        -- Set height of the objective tracker frame
    local otfheight = 450

        -- Set width of the objective tracker frame
    local otfwidth = 188

        -- Set font size of objective titles
    local titlesize = 13

-------------------------------------------------------------------------------

-- TOOLTIP POSITION
hooksecurefunc("GameTooltip_SetDefaultAnchor", function (tooltip, parent)
	tooltip:SetOwner(parent, "ANCHOR_NONE");
	tooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 10, 40);
end)

-------------------------------------------------------------------------------

-- BUFFS POSITION
BuffFrame:ClearAllPoints()
BuffFrame:SetParent(UIParent)
BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -200, -3.5)

-------------------------------------------------------------------------------

-- OPEN ALL

local deletedelay, t = 0.5, 0
local takingOnlyCash = false
local button, button2, waitForMail, doNothing, openAll, openAllCash, openMail, lastopened, stopOpening, mail_checker, needsToWait, copper_to_pretty_money, total_cash, get_total_cash
local baseInboxFrame_OnClick
function doNothing() end

function openAll()
	if GetInboxNumItems() == 0 then return end
	button:SetScript("OnClick", nil)
	button2:SetScript("OnClick", nil)
	baseInboxFrame_OnClick = InboxFrame_OnClick
	InboxFrame_OnClick = doNothing
	button:RegisterEvent("UI_ERROR_MESSAGE")
	openMail(GetInboxNumItems())
end
function openAllCash()
	takingOnlyCash = true
	openAll()
end
function openMail(index)
	if not InboxFrame:IsVisible() then return end
	if index == 0 then return stopOpening("Reached the end.") end
	local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(index)
	if not takingOnlyCash then
		if money > 0 or (numItems and numItems > 0) and COD <= 0 then
			AutoLootMailItem(index)
			needsToWait = true
		end
	elseif money > 0 then
		TakeInboxMoney(index)
		needsToWait = true
		if total_cash then total_cash = total_cash - money end
	end
	local items = GetInboxNumItems()
	if (numItems and numItems > 0) or (items > 1 and index <= items) then
		lastopened = index
		button:SetScript("OnUpdate", waitForMail)
	else
		stopOpening("All done.")
	end
end
function waitForMail(this, arg1)
	t = t + arg1
	if (not needsToWait) or (t > deletedelay) then
		if not InboxFrame:IsVisible() then return end
		t = 0
		needsToWait = false
		button:SetScript("OnUpdate", nil)

		local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(lastopened)
		if money > 0 or ((not takingOnlyCash) and COD <= 0 and numItems and (numItems > 0)) then
			--The lastopened index inbox item still contains stuff we want
			openMail(lastopened)
		else
			openMail(lastopened - 1)
		end
	end
end
function stopOpening(msg, ...)
	button:SetScript("OnUpdate", nil)
	button:SetScript("OnClick", openAll)
	button2:SetScript("OnClick", openAllCash)
	if baseInboxFrame_OnClick then
		InboxFrame_OnClick = baseInboxFrame_OnClick
	end
	button:UnregisterEvent("UI_ERROR_MESSAGE")
	takingOnlyCash = false
	total_cash = nil
	needsToWait = false
	if msg then DEFAULT_CHAT_FRAME:AddMessage("OpenAll: "..msg, ...) end

	mail_checker:Show()
end
local function makeButton(id, text, w, h, x, y)
	local button = CreateFrame("Button", id, InboxFrame, "UIPanelButtonTemplate")
	button:SetWidth(w)
	button:SetHeight(h)
	button:SetPoint("CENTER", InboxFrame, "TOP", x, y)
	button:SetText(text)
	return button
end
button = makeButton("OpenAllButton", "All", 60, 25, -50, -40)
button:SetScript("OnClick", openAll)
button:SetScript("OnEvent", function(this, event, error_msg)
	if event == "UI_ERROR_MESSAGE" then
		if error_msg == ERR_INV_FULL then
			return stopOpening("Stopped, inventory is full.")
		end
		if error_msg == ERR_ITEM_MAX_COUNT then
			openMail(lastopened - 1)
		end
	end
end)
button:SetScript("OnHide", function(this)
	if needsToWait then
		stopOpening("Need a mailbox.")
	end
end)
button2 = makeButton("OpenAllButton2", "Cash", 60, 25, 20, -40)
button2:SetScript("OnClick", openAllCash)

function get_total_cash()
	local index
	if not total_cash then
		total_cash = 0
		for index=0, GetInboxNumItems() do
			total_cash = total_cash + select(5, GetInboxHeaderInfo(index))
		end
	end
	return total_cash
end

function copper_to_pretty_money(c)
	if c > 10000 then
		return ("%d|cffffd700g|r%d|cffc7c7cfs|r%d|cffeda55fc|r"):format(c/10000, (c/100)%100, c%100)
	elseif c > 100 then
		return ("%d|cffc7c7cfs|r%d|cffeda55fc|r"):format((c/100)%100, c%100)
	else
		return ("%d|cffeda55fc|r"):format(c%100)
	end
end

button:SetScript("OnEnter", function()
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	GameTooltip:AddLine(string.format("%d messages", GetInboxNumItems()), 1, 1, 1)
	GameTooltip:AddLine(copper_to_pretty_money(get_total_cash()), 1, 1, 1)
	GameTooltip:Show()
end)
button:SetScript("OnLeave", function() GameTooltip:Hide() end)

button2:SetScript("OnEnter", function()
	GameTooltip:SetOwner(button2, "ANCHOR_RIGHT")
	GameTooltip:AddLine(copper_to_pretty_money(get_total_cash()), 1, 1, 1)
	GameTooltip:Show()
end)
button2:SetScript("OnLeave", function() GameTooltip:Hide() end)

mail_checker = CreateFrame("Frame")
mail_checker:Hide()
mail_checker:SetScript("OnShow", function(this)
	this:RegisterEvent("MAIL_INBOX_UPDATE")
	CheckInbox()
end)
mail_checker:SetScript("OnHide", function(this)
	if select(2, GetInboxNumItems()) > 0 then
		MiniMapMailFrame:Show()
	else
		MiniMapMailFrame:Hide()
	end
end)
mail_checker:SetScript("OnEvent", function(this, event, ...)
	if event == "MAIL_INBOX_UPDATE" then
		this:Hide()
		this:UnregisterEvent("MAIL_INBOX_UPDATE")
	end
end)

-------------------------------------------------------------------------------

-- HIDE ORDER HALL BAR

local b = OrderHallCommandBar
b:UnregisterAllEvents()
b:HookScript("OnShow", b.Hide)
b:Hide()
