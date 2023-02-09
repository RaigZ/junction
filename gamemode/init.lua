--[[

    Gamemode: Tourist
    Author: Ace Lord 
    Steam ID: 76561198129715226
    January 7, 2023

--]]

-- AddCSLuaFile() == files downloaded by the client
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("faction_setup.lua")
AddCSLuaFile("vgui/cl_popup.lua")
AddCSLuaFile("autorun/client/cl_faction_selection.lua")

include("shared.lua")
include("faction_setup.lua")  
include("autorun/client/cl_faction_selection.lua")
include("vgui/cl_popup.lua")
include("autorun/server/sv_popup.lua")

-- Similar functionality as team.GetName(ply:Team()), only difference is taking the team index 
function getFactionName(ply) 
    for k, v in pairs({"Independent", "Resistance", "Combine", "Zombies"}) do
        if v == team.GetName(ply:Team()) then
            return (k - 1), v
        end   
        if team.GetName(ply:Team()) == "Spectator" then
            return "Spectator"
        end
    end
end

_spectatorDesignator = true

function GM:PlayerSpawn(ply)
    if ply:IsConnected() and _spectatorDesignator == true then
        print("_spectatorDesignator: ", _spectatorDesignator)
        --ply:ChatPrint(ply:SendTimeConnect())
        print("Choose a faction to exit Spectator.")
        GAMEMODE:PlayerSpawnAsSpectator(ply)
    end
    
    local indx, _ = getFactionName(ply)
    
--[[
    if indx ~= "Spectator" then
        function self:AllowPlayerPickup(ply)
            return true
        end
    else
        function self:AllowPlayerPickup(ply)
            return false
        end
    end
--]]

    if indx == 0 then
        ply:Spectate(OBS_MODE_NONE)
        chosenIndependent()
    elseif indx == 1 then
        ply:Spectate(OBS_MODE_NONE)
        chosenResistance()
    elseif indx == 2 then
        ply:Spectate(OBS_MODE_NONE)
        chosenCombine()
    elseif indx == 3 then
        ply:Spectate(OBS_MODE_NONE)
        chosenZombies()
    elseif indx == "Spectator" then
        -- MAKE IT WHERE THE SPECTATOR CANNOT CONTROL WORLD ENTITIES
    end

    print("getFactionName(ply): ", getFactionName(ply))
    print("You spawn as part of the " .. team.GetName(ply:Team()) .. " faction.")

    ply:SetRunSpeed(380)
    ply:SetWalkSpeed(260)
    --ply:Give("weapon_physcannon")
    --ply:SetupHands()
end 

function GM:PlayerConnect(name, ip)
    print("Welcome to Tourist " .. name .. "!\n")
end

--[[
function GM:PlayerDisconnected(ply)
    GAMEMODE:PlayerSpawnAsSpectator(ply)
end
--]]

function GM:PreGamemodeLoaded()
end

function GM:PlayerInitialSpawn(ply)
    if ply:IsConnected() then
        --print("Initial spawn.")
        --ply:setupTeam(math.random(0, 3))
        ply:ChatPrint(ply:IPAddress() .. ": " .. ply:Name() .. " connected.")
    end
end

util.AddNetworkString("faction_menu")
util.AddNetworkString("faction_change")

net.Receive("faction_change", function(len, ply)
    local change_indx = net.ReadInt(4)
    _spectatorDesignator = false
    print("_spectatorDesignator: ", _spectatorDesignator)
    ply:SetTeam(change_indx)
    ply:Spawn()
    --print("Message received.\n\n\n\n")
end)

function GM:PlayerUse(ply, ent)
    if _spectatorDesignator == true then
        return false    
    end
    return
end

function GM:ShowSpare2(ply)
    net.Start("faction_menu")
    net.Send(ply)
end