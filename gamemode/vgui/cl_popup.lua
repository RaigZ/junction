--[[----------------------------------------------------------------------------
    cl_popup.lua 
    
    Steam ID: 76561198129715226
    January 7, 2023
--]]----------------------------------------------------------------------------

if CLIENT then
    hook.Add("KeyPress", "key_esc", function(ply, key)
        if _GMain:SetDeleteOnClose() then
        end
		
        if key == IN_USE or key == IN_FORWARD 
		or key == IN_BACK or key == IN_JUMP 
		or key == IN_MOVELEFT or key == IN_MOVERIGHT then
            _GMain:Close()
        end
    end)


    --[[
        Creates GUI DFrame showcasing a popup of 
        the gamemode, author, and information
        regarding version semantics.
    --]]

    -- Frame		
    _GMain = vgui.Create("DFrame")
    _GMain:SetTitle("Junction")
    _GMain:SetSize(250, 250)
    _GMain:Center(true)
    _GMain:SetDraggable(false)
	_GMain:ShowCloseButton(false)

    -- logo
    local junction = vgui.Create("DImage", _GMain)

    junction:SetPos(10, 30)
    junction:SetSize(96, 96)
    junction:SetImage("materials/junction.png")

    -- text
    local txt = vgui.Create("DLabel", _GMain)
    txt:SetPos(10, 80)
    txt:SetFont("HudHintTextLarge")
    txt:SetColor(Color(255, 243, 34))
    txt:SetText("CREATOR: RaigZ\nWelcome to Junction.\nIm not good with version \nsemantics; \n\nVERSION: ALPHA_0.6.1")
    txt:SetHeight(200)
    txt:SetWidth(200)
end