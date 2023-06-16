--[[----------------------------------------------------------------------------
    init.lua

    January 7, 2023
--]]---------------------------------------------------------------------------- 

-- AddCSLuaFile() == files downloaded by the client
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("faction_setup.lua")
AddCSLuaFile("vgui/cl_popup.lua")
AddCSLuaFile("autorun/client/cl_faction_selection.lua")
AddCSLuaFile("autorun/server/playerAttributes.lua")

include("shared.lua")
include("faction_setup.lua")
include("autorun/client/cl_faction_selection.lua")
include("vgui/cl_popup.lua")
include("autorun/server/sv_popup.lua")
include("autorun/server/playerAttributes.lua")

--[[----------------------------------------------------------------------------
            DESCRIPTION: None

--]]----------------------------------------------------------------------------
function GM:PreGamemodeLoaded()
end

--[[----------------------------------------------------------------------------
            DESCRIPTION: Initialize player enumeration (database) and
            communicate with network strings by fetching from SQL database
            and sending it to invoked player

--]]----------------------------------------------------------------------------
function GM:PlayerInitialSpawn(ply)
    ply:EnumerationLoad()
    ply:SetNWInt("Killstreak", ply:GetNWInt("Killstreak"))
    print(ply:Nick() .. "'s killstreak is " .. ply:GetNWInt("Killstreak"))
    --[[
    if ply:IsConnected() then
        -- print("Initial spawn.")
        -- ply:setupTeam(math.random(0, 3))
        ply:ChatPrint(ply:IPAddress() .. ": " .. ply:Name() .. " connected.")
    end
    --]]
end

--[[----------------------------------------------------------------------------
            DESCRIPTION: -- Similar functionality as team.GetName(ply:Team()), 
            only difference is taking the team index 
--]]----------------------------------------------------------------------------
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

--[[----------------------------------------------------------------------------
            DESCRIPTION: -- Player Spawn checks if player is spectator and
            performs the getFactionName function to help view the key and value
            of the faction
--]]----------------------------------------------------------------------------

function GM:PlayerSpawn(ply)
    if (ply._spectatorDesignator == false) then
    else
        ply._spectatorDesignator = true
        if ply:IsConnected() and ply._spectatorDesignator == true then
            ply:PrintMessage(HUD_PRINTCONSOLE, "_spectatorDesignator: " .. tostring(ply._spectatorDesignator))
            -- ply:ChatPrint(ply:SendTimeConnect())
            ply:PrintMessage(HUD_PRINTCONSOLE, "Choose a faction to exit Spectator.")
            GAMEMODE:PlayerSpawnAsSpectator(ply)
            hook.Add("PlayerNoClip", "SpectateNoClip", function(ply, desiredState)
                return false
            end)
        end 
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
    --[[ 
        PROBLEM: 
        Anytime a player spawns, the indx is not bound to 1 player, it is bound to all players    
    ]]
    
    if type(indx) == "number" then
        local model = nil
        ply:Spectate(OBS_MODE_NONE)
        hook.Add("CanPlayerSuicide", "DisallowSpectatorSuicide", function(ply)
            return true
        end)

        if indx == 0 then
            model = ply:chosenIndependent()
            ply:SetModel("models/player/postal2_dude.mdl")
        elseif indx == 1 then
            model = ply:chosenResistance()
            ply:SetModel("models/player/Group03/male_01.mdl")
        elseif indx == 2 then
            model = ply:chosenCombine()
            ply:SetModel("models/player/combine_super_soldier.mdl")
        elseif indx == 3 then
            model = ply:chosenZombies()
            ply:SetModel("models/player/zombie_classic.mdl")
        end
        ply:PrintMessage(HUD_PRINTCONSOLE, "Model: " .. model)
    elseif indx == "Spectator" then
        hook.Add("CanPlayerSuicide", "DisallowSpectatorSuicide", function(ply)
            return false
        end)
        ply:SetModel("models/player/skeleton.mdl")
    end

    ---[[
    playerTeamCount = 0
    for k, v in ipairs(team.GetPlayers(indx)) do
        playerTeamCount = playerTeamCount + 1
    end
    print("Current players in " .. team.GetName(ply:Team()) .. ": " .. playerTeamCount)
    ---]]

    --PrintTable(team.GetPlayers(indx))
    ply:PrintMessage(HUD_PRINTCONSOLE, "getFactionName(ply): " .. getFactionName(ply))
    ply:PrintMessage(HUD_PRINTTALK, "You spawn as part of the " .. team.GetName(ply:Team()) .. " faction.")

    ply:SetRunSpeed(380)
    ply:SetWalkSpeed(260)
    -- ply:Give("weapon_physcannon")
    -- ply:SetupHands()
end

function GM:PlayerConnect(name, ip)
    print("Welcome to junction " .. name .. "!\n")
end


function GM:PlayerDisconnected(ply)
    ply:SetPData("Killstreak", 0)
    --ply:EnumerationSave()
    --GAMEMODE:PlayerSpawnAsSpectator(ply)
end

--[[----------------------------------------------------------------------------
            DESCRIPTION: Player death that modifies enumeration (database) and
            the network string value by fetching from database and reset the
            "Killstreak" key to default 0 for the victim
--]]----------------------------------------------------------------------------
hook.Add("PlayerDeath", "KillstreakAdder", function(victim, inflictor, attacker)
    if (victim == attacker) then
        victim:SetPData("Killstreak", 0) 
    elseif (victim != attacker) then
        attacker:SetPData("Killstreak", attacker:GetPData("Killstreak") + 1) 
    end
    print(victim:GetName() .. "'s killstreak: ", victim:GetPData("Killstreak"))
    print(attacker:GetName() .. "'s killstreak: ", attacker:GetPData("Killstreak"))
end)

util.AddNetworkString("faction_menu")
util.AddNetworkString("faction_change")

net.Receive("faction_change", function(len, ply)
    local change_indx = net.ReadInt(4)
    ply._spectatorDesignator = false
    ply:PrintMessage(HUD_PRINTTALK, "_spectatorDesignator: " .. tostring(ply._spectatorDesignator))
    ply:SetTeam(change_indx)
    ply:Spawn()
    -- print("Message received.\n\n\n\n")
end)

--[[----------------------------------------------------------------------------
            DESCRIPTION: Spectator dependent, decides for where the player 
            shall engage with the world entities either the _spectatorDesignator
            was true, we shall see it be false, else if the player is a
            non-spectator, they shall interact with the world.
--]]----------------------------------------------------------------------------
function GM:PlayerUse(ply, ent)
    if ply._spectatorDesignator == true then
        return false
    end
    return true
end

--[[----------------------------------------------------------------------------
            DESCRIPTION: Simplistic F4 menu
--]]----------------------------------------------------------------------------
function GM:ShowSpare2(ply)
    net.Start("faction_menu")
    net.Send(ply)
end

--[[----------------------------------------------------------------------------
    >> Make timer for when player dies, prompt player team class selection    


--]]----------------------------------------------------------------------------