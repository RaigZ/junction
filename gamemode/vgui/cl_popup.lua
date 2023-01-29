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
    _GMain:SetTitle("Tourist")
    _GMain:SetSize(250, 250)
    _GMain:Center(true)
    _GMain:SetDraggable(false)
	_GMain:ShowCloseButton(false)

    -- logo
    local tourist = vgui.Create("DImage", _GMain)

    tourist:SetPos(10, 30)
    tourist:SetSize(96, 96)
    tourist:SetImage("materials/tourist.png")

    -- text
    local txt = vgui.Create("DLabel", _GMain)
    txt:SetPos(10, 80)
    txt:SetFont("HudHintTextLarge")
    txt:SetColor(Color(255, 243, 34))
    txt:SetText("CREATOR: Ace Lord\nWelcome to Tourist.\nIm not good with version \nsemantics; \n\nVERSION: ALPHA_0.5.1")
    txt:SetHeight(200)
    txt:SetWidth(200)
end