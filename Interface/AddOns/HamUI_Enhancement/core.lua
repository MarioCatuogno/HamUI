-------------------------------------------------------------------------------

-- AUTO REPAIR AND SELLING (by Arena Junkies)
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

        if(CanMerchantRepair()) then
                local cost = GetRepairAllCost()
                if cost > 0 then
                        local money = GetMoney()
                        if IsInGuild() then
                                local guildMoney = GetGuildBankWithdrawMoney()
                                if guildMoney > GetGuildBankMoney() then
                                        guildMoney = GetGuildBankMoney()
                                end
                                if guildMoney > cost and CanGuildBankRepair() then
                                        RepairAllItems(1)
                                        print(format("|cfff07100Repair cost covered by G-Bank: %.1fg|r", cost * 0.0001))
                                        return
                                end
                        end
                        if money > cost then
                                RepairAllItems()
                                print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
                        else
                                print("Not enough gold to cover the repair cost.")
                        end
                end
        end
end)

-------------------------------------------------------------------------------

-- SLASH COMMAND (by Arena Junkies)
SlashCmdList["READYCHECK"] = function() DoReadyCheck() end
SLASH_READYCHECK1 = '/rc'

SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = '/rl'

-------------------------------------------------------------------------------

-- eALIGN
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
				t:SetColorTexture(1, 0, 0, 0.5)
			else
				t:SetColorTexture(0, 0, 0, 0.5)
			end
			t:SetPoint('TOPLEFT', f, 'TOPLEFT', i * w - 1, 0)
			t:SetPoint('BOTTOMRIGHT', f, 'BOTTOMLEFT', i * w + 1, 0)
		end
		for i = 0, 36 do
			local t = f:CreateTexture(nil, 'BACKGROUND')
			if i == 18 then
				t:SetColorTexture(1, 0, 0, 0.5)
			else
				t:SetColorTexture(0, 0, 0, 0.5)
			end
			t:SetPoint('TOPLEFT', f, 'TOPLEFT', 0, -i * h + 1)
			t:SetPoint('BOTTOMRIGHT', f, 'TOPRIGHT', 0, -i * h - 1)
		end
	end
end

-------------------------------------------------------------------------------

-- AUTOLOOT PLUS
local frame = CreateFrame("Frame")
local epoch = 0 -- time of the last auto loot

local LOOT_DELAY = 0.3 -- constant interval that prevents rapid looting

-- loots items if auto loot is turned on xor toggle key is pressed
local function LootContents()
  -- slows method calls to once a LOOT_DELAY interval since LOOT_READY event fires twice
  if (GetTime() - epoch >= LOOT_DELAY) then
    epoch = GetTime()

    if (GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE")) then -- xor
      for i = GetNumLootItems(), 1, -1 do
        LootSlot(i)
      end

      epoch = GetTime() -- update time
    end
  end
end

-- triggering events and actions to fire
frame:RegisterEvent("LOOT_READY")
frame:SetScript("OnEvent", LootContents)
