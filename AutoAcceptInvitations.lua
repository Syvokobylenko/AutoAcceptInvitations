local AutoAI = {}

_G.AutoAI = AutoAI

AutoAI.ToggleStatus = true
AutoAI.Option2 = false

function AutoAI.OnLoad(this)
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("SAVE_VARIABLES")
	this:RegisterEvent("PARTY_INVITE_REQUEST")
	SaveVariablesPerCharacter("AutoAI_SavedStatus")
end

function AutoAI.OnEvent(event)
	if event == "VARIABLES_LOADED" then
		AutoAI.ToggleStatus = AutoAI_SavedStatus
	elseif event == "SAVE_VARIABLES" then
		AutoAI_SavedStatus = AutoAI.ToggleStatus
	elseif event == "PARTY_INVITE_REQUEST" and AutoAI.ToggleStatus then
		AcceptGroup()
	end
end

function AutoAI.MenuOnShow(this)
	AutoAI.Toggle(AutoAI.ToggleStatus)

	local info = {}
	
    info = {}
    info.text = "AutoAcceptInvitations"
    info.isTitle = 1
	UIDropDownMenu_AddButton( info, 1 )
end

function AutoAI.ButtonOnClick(this,key)
    if not IsShiftKeyDown() then
        if key == "LBUTTON" then
            AutoAI.Toggle(not AutoAI.ToggleStatus)
		else
			ToggleDropDownMenu(AutoAI_Menu)
        end
    end
end

function AutoAI.ButtonOnEnter(this)
	GameTooltip:SetOwner(this, "ANCHOR_LEFT", 4, 0)
	GameTooltip:SetText("AutoAcceptInvitations", 1, 1, 1)
	GameTooltip:AddLine(UI_MINIMAPBUTTON_MOVE, 0, 0.75, 0.95)
	GameTooltip:Show()
end

function AutoAI.ButtonOnLeave(this)
    GameTooltip:Hide()
end

function AutoAI.Toggle(enable)
    AutoAI.ToggleStatus = enable
	if AutoAI.ToggleStatus then
		DEFAULT_CHAT_FRAME:AddMessage("AutoAI started");
		AutoAI_Button:UnlockPushed()
	else
		DEFAULT_CHAT_FRAME:AddMessage("AutoAI stopped");
        AutoAI_Button:LockPushed()
    end
end
