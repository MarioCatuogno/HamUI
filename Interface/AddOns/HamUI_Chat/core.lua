-------------------------------------------------------------------------------

-- SHORTEN CHAT MESSAGES
CURRENCY_GAINED = "Currency: %s";
CURRENCY_GAINED_MULTIPLE = "Currency: %s x%d";
CURRENCY_GAINED_MULTIPLE_BONUS = "Currency: %s x%d (Bonus)";
LOOT_ITEM_BONUS_ROLL_SELF = "Loot: %s  (Bonus)";
LOOT_ITEM_BONUS_ROLL_SELF_MULTIPLE = "Loot: %sx%d (Bonus)";
LOOT_ITEM_CREATED_SELF = "Create: %s";
LOOT_ITEM_CREATED_SELF_MULTIPLE = "Create: %sx%d";
LOOT_ITEM_PUSHED_SELF = "Loot: %s";
LOOT_ITEM_PUSHED_SELF_MULTIPLE = "Loot: %sx%d";
LOOT_ITEM_REFUND = "Refund: %s";
LOOT_ITEM_REFUND_MULTIPLE = "Refund: %sx%d";
LOOT_ITEM_SELF = "Loot: %s";
LOOT_ITEM_SELF_MULTIPLE = "Loot: %sx%d";
LOOT_ITEM = "%s gets: %s";
LOOT_ITEM_BONUS_ROLL = "%s gets: %s (Bonus)";
LOOT_ITEM_BONUS_ROLL_MULTIPLE = "%s gets: %sx%d";
LOOT_ITEM_MULTIPLE = "%s gets: %sx%d";
LOOT_ITEM_PUSHED = "%s gets: %s";
LOOT_ITEM_PUSHED_MULTIPLE = "%s gets: %sx%d";
CHAT_GUILD_GET = "|Hchannel:GUILD|hG|h %s ";
CHAT_OFFICER_GET = "|Hchannel:OFFICER|hO|h %s ";
CHAT_GUILD_GET = "|Hchannel:GUILD|hG|h %s ";
CHAT_OFFICER_GET = "|Hchannel:OFFICER|hO|h %s ";
CHAT_RAID_GET = "|Hchannel:RAID|hR|h %s ";
CHAT_RAID_WARNING_GET = "RW %s ";
CHAT_RAID_LEADER_GET = "|Hchannel:RAID|hRL|h %s ";
CHAT_PARTY_GET = "|Hchannel:PARTY|hP|h %s ";
CHAT_PARTY_LEADER_GET =  "|Hchannel:PARTY|hPL|h %s ";
CHAT_PARTY_GUIDE_GET =  "|Hchannel:PARTY|hPG|h %s ";
CHAT_INSTANCE_CHAT_GET = "|Hchannel:Battleground|hI.|h %s: ";
CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:Battleground|hIL.|h %s: ";
CHAT_WHISPER_INFORM_GET = "to %s ";
CHAT_WHISPER_GET = "from %s ";
CHAT_BN_WHISPER_INFORM_GET = "to %s ";
CHAT_BN_WHISPER_GET = "from %s ";
CHAT_SAY_GET = "%s ";
CHAT_YELL_GET = "%s ";
CHAT_FLAG_AFK = "[AFK] ";
CHAT_FLAG_DND = "[DND] ";
CHAT_FLAG_GM = "[GM] ";

-------------------------------------------------------------------------------

-- EDIT-BOX (Modernists by Obble)
    for i = 1, NUM_CHAT_WINDOWS do
        local editBox = _G[('ChatFrame%d'):format(i)..'EditBox']
        editBox:HookScript('OnEditFocusLost', function(self)
            self:Hide()
        end)
         editBox:HookScript('OnEditFocusGained', function(self)
            self:Show()
        end)
    end

-------------------------------------------------------------------------------

-- POSITION OF BNET FRAME (NeavUI by Neal)
BNToastFrame:HookScript('OnShow', function(self)
    BNToastFrame:ClearAllPoints()
    BNToastFrame:SetPoint('BOTTOMLEFT', ChatFrame1EditBox, 'TOPLEFT', 0, 195)
end)

-------------------------------------------------------------------------------

-- CHAT FONT SIZE
CHAT_FONT_HEIGHTS = {
    [1] = 8,
    [2] = 10,
    [3] = 12,
    [4] = 14,
    [5] = 16,
    [6] = 18,
    [7] = 20,
}

-------------------------------------------------------------------------------

-- CHAT MOUSEOVER
CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 0.5
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
CHAT_FRAME_FADE_OUT_TIME = 0.25
CHAT_FRAME_FADE_TIME = 0.1

-------------------------------------------------------------------------------

-- TRANSPARENT CHAT
    local function StyleTheChat()
            -- Make chat windows transparent
        for i = 1, NUM_CHAT_WINDOWS do
            SetChatWindowAlpha(i, 0)
        end

            -- Style
        for _, v in pairs(CHAT_FRAMES) do
            local chat = _G[v]
            if chat and not chat.styled then
                StyleChat(chat:GetName())

                local convButton = _G[chat:GetName()..'ConversationButton']
                if convButton then
                    convButton:SetAlpha(0)
                    convButton:EnableMouse(false)
                end

                local chatMinimize = _G[chat:GetName()..'ButtonFrameMinimizeButton']
                if chatMinimize then
                    chatMinimize:SetAlpha(0)
                    chatMinimize:EnableMouse(0)
                end
                chat.styled = true
            end
        end
    end

	hooksecurefunc('FCF_OpenTemporaryWindow', StyleTheChat)
    StyleTheChat()

-------------------------------------------------------------------------------
