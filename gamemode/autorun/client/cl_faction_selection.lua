--[[
    cl_faction_selection.lua

    Gamemode: Tourist
    Author: Ace Lord 
    Steam ID: 76561198129715226
    January 21, 2023

--]]

--print("cl_faction_selection.lua")


if CLIENT then
    net.Receive("faction_menu", function()
        if not _Fselect then
            local _Fselect = vgui.Create("DFrame")
            
            _Fselect:SetTitle("Faction Roster")
            _Fselect:SetSize(200, 450)
            _Fselect:SetPos(580, 100)
            _Fselect:SetDraggable(true)
	        _Fselect:ShowCloseButton(true)
            _Fselect:MakePopup()

            --faction associated buttons
            local independent = vgui.Create("DColorButton", _Fselect)
            independent:SetPos(8, 30)
            independent:SetSize(70, 15)
            independent:SetText(" Independent")

            local resistance = vgui.Create("DColorButton", _Fselect)
            resistance:SetPos(8, 60)
            resistance:SetSize(70, 15)
            resistance:SetText(" Resistance")
            resistance:SetColor(Color(0, 0, 255), true) 

            local combine = vgui.Create("DColorButton", _Fselect)
            combine:SetPos(8, 90)
            combine:SetSize(70, 15)
            combine:SetText(" Combine")
            combine:SetColor(Color(255, 0, 0), true) 
            
            local zombie = vgui.Create("DColorButton", _Fselect)
            zombie:SetPos(8, 120)
            zombie:SetSize(70, 15)
            zombie:SetText(" Zombie")
            zombie:SetColor(Color(0, 0, 0), true) 

            local icon = vgui.Create("DModelPanel", _Fselect)
            icon:SetSize(100, 100)
            icon:SetPos(100, 30)
            icon:SetModel(LocalPlayer():GetModel())
            icon:SetFOV(50)
            icon:SetCamPos(icon:GetCamPos() / 2 + Vector(50, 50, 40))

            xRotate = 0
            function icon:LayoutEntity(ent)
                xRotate = xRotate + 4
                --print(xRotate)
                if xRotate == 4096 then xRotate = 0 end
                ent:SetAngles(Angle(0, xRotate, 0)) 
            end
            function icon:EntityGetPlayerColor() return Vector(1, 1, 0) end
            -- start each r, g, b with random value for DColorButton SetColor method arguments
--[[
            AUTHOR: Ace Lord
            Steam ID: 76561198129715226
            1/29/2023

            DESCRIPTION: Transition colors of GUI buttons for
            DFrame _Fselect (faction roster)

            sw = switches
--]]

            local _r = math.random(0, 255)
            local _g = math.random(0, 255)
            local _b = math.random(0, 255)
            
            local r_notRand = 0
            local g_notRand = 0 
            local b_notRand = 0

            local red_sw = false
            local gre_sw = false
            local blu_sw = false

            if not timer.Exists("rainbowText") then 
                timer.Create("rainbowText", 0.00001, 0, function() 
                    --print(timer.RepsLeft("rainbowText"))

                    --r
                    if _r == 255 then
                        red_sw = true
                    elseif _r == 0 then
                        red_sw = false
                    end
                    
                    if red_sw == true then
                        _r = _r - 1
                        r_notRand = r_notRand - 1
                    else 
                        _r = _r + 1
                        r_notRand = r_notRand + 1
                    end

                    --g
                    if _g == 255 then
                        gre_sw = true
                    elseif _g == 0 then
                        gre_sw = false
                    end

                    if gre_sw == true then
                        _g = _g - 1
                        g_notRand = g_notRand - 1
                    else 
                        _g = _g + 1
                        g_notRand = g_notRand + 1
                    end

                    --b
                    if _b == 255 then
                        blu_sw = false
                    elseif _b == 0 then
                        blu_sw = true
                    end

                    if blu_sw == true then
                        _b = _b + 1
                        b_notRand = b_notRand - 1
                    else
                        _b = _b - 1
                        b_notRand = b_notRand + 1
                    end

--[[
                    red = tostring(_r)
                    gre = tostring(_g)
                    blu = tostring(_b)
                    --print("indp: r, g, b: ", red, gre, blu)
                    chat.AddText("indp: r, g, b: ", red, ", ", gre, ", ", blu)
--]]                
                    local randomizedColor = Color(_r, _g, _b)

                    independent:SetColor(randomizedColor, true)
                    resistance:SetColor(Color(0, 0, b_notRand), true)
                    combine:SetColor(Color(r_notRand, 0, 0), true)
                    zombie:SetColor(Color(0, g_notRand, 0), true)
                end)
            else
                --timer.Start("rainbowText")
            end 
 
            function _Fselect:OnClose() 
                timer.Remove("rainbowText")
            end

            -- other junk below for actually choosing the faction

            independent.DoClick = function()
                net.Start("faction_change")
                net.WriteInt(0, 4)
                net.SendToServer()
                chat.AddText("Independent faction chosen.")
            end
            resistance.DoClick = function()
                net.Start("faction_change")
                net.WriteInt(1, 4)
                net.SendToServer()
                chat.AddText("Resistance faction chosen.")
            end
            combine.DoClick = function()
                net.Start("faction_change")
                net.WriteInt(2, 4)
                net.SendToServer()
                chat.AddText("Combine faction chosen.")
            end
            zombie.DoClick = function() 
                net.Start("faction_change")
                net.WriteInt(3, 4)
                net.SendToServer()
                chat.AddText("Zombie faction chosen.")
            end
        end  
    end)
end

--[[
    ::Tasks::
   ✓ < Create GUI menu selection for player to decide which team they want to choose.
   ✓ < Make sure this menu is persistent for the player, so that when they respawn this menu does not prompt back.
   - < This menu shall only prompt when the client presses a certain key; like ',', (Make my own CONVAR command and set this key to be the prompt
that may let the player to select a team)
   ✓ < make player respawn
   - << Make a cooldown timer so player cannot select team so fast
   - << Close mechanism, that if the faction roster is open AND the user presses f4, let the faction roster close
]]

