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
AddCSLuaFile("vgui/cl_faction_selection.lua")

include("shared.lua")
include("faction_setup.lua")  
include("vgui/cl_faction_selection.lua")
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

function GM:PlayerSpawn(ply)
    if ply:IsConnected() then
        --ply:ChatPrint(ply:SendTimeConnect())
        GAMEMODE:PlayerSpawnAsSpectator(ply)
    end

    local indx, _ = getFactionName(ply)
    
    if indx ~= "Spectator" then
        function self:AllowPlayerPickup(ply)
            return true
        end
    end

    if indx == 0 then
        chosenIndependent()
    elseif indx == 1 then
        chosenResistance()
    elseif indx == 2 then
        chosenCombine()
    elseif indx == 3 then
        chosenZombies()
    elseif indx == "Spectator" then
        function self:AllowPlayerPickup(ply)
            return false
        end
        -- MAKE IT WHERE THE SPECTATOR CANNOT CONTROL WORLD ENTITIES
    end

    print("getFactionName(ply): ", getFactionName(ply))
    print("You spawn as part of the " .. team.GetName(ply:Team()) .. " faction.")

    ply:SetRunSpeed(380)
    ply:SetWalkSpeed(260)
    --ply:Give("weapon_physcannon")
    ply:SetupHands()
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
    if ply:IsConnected() == true then
        print("Initial spawn.")
    else
    --[[if player selected a team, they shall spawn into the world]]
        ply:setupTeam(math.random(0, 3))
        ply:ChatPrint(ply:IPAddress() .. ": " .. ply:Name() .. " connected.")
    end
end

util.AddNetworkString("faction_menu")

function GM:ShowSpare2(ply)
    net.Start("faction_menu")
    net.Send(ply)
end