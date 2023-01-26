--[[

    Gamemode: Tourist
    Author: Ace Lord 
    Steam ID: 76561198129715226
    January 21, 2023

--]]

if CLIENT then
counter = 0
hook.Add("KeyPress", "key_esc", function(ply, key)
	if  key == IN_USE then
		_GMain:Close()
		_GMain:SetDeleteOnClose()
		hook.Remove("KeyPress", "key_esc")
	else
		while counter>=0 do		
			counter = counter + 1		
			if counter == 100 then
				_GMain:Close()
				break	
			end
		hook.Remove("KeyPress", "key_esc")	
		end			
	end	
end) 
		
 --Frame		
_GMain = vgui.Create("DFrame")				
_GMain:SetTitle("Tourist")
_GMain:SetSize(250, 250)
_GMain:Center(true)
_GMain:SetDraggable(false)


--logo
local tourist = vgui.Create("DImage", _GMain)		

tourist:SetPos(10, 30)
tourist:SetSize(96, 96)
tourist:SetImage("materials/tourist.png") 

--text
local txt = vgui.Create("DLabel", _GMain)
txt:SetPos(10, 80)		
txt:SetFont("HudHintTextLarge")
txt:SetColor(Color(255, 243, 34))
txt:SetText("CREATOR: Ace Lord\nWelcome to Tourist.\nIm not good with version \nsemantics; \n\nVERSION: ALPHA_0.5.1")
txt:SetHeight(200)
txt:SetWidth(200)
end