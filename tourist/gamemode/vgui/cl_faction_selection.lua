--[[

    Gamemode: Tourist
    Author: Ace Lord 
    Steam ID: 76561198129715226
    January 21, 2023

--]]

print("cl_faction_selection.lua")

function fRoster() 
    _Fselect = vgui.Create("DFrame") 
end

--[[
    < Create GUI menu selection for player to decide which team they want to choose.
    < Make sure this menu is persistent for the player, so that when they respawn this menu does not prompt back.
    < This menu shall only prompt when the client presses a certain key; like ','
]]

