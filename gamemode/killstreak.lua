--[[

    Gamemode: Tourist
    Author: Ace Lord 
    Steam ID: 76561198129715226
    February 9, 2023

    Description: A simple killstreak system, collects victim frags/deaths, and rewards attacker from i = 0; i = i + 1 of every
    achievable kill to increment to their overall killstreak 

    Implementation:

    Preserve killstreak values

    DO NOT PRESERVE WHEN PLAYER SWAPS TEAMS!

--]] 

local ply = FindMetaTable("Player")
local SetPlyAttributes = {killstreak = 0, exp = 0}

function SetPlyAttributes:setupPlayerAttributes(killstreak, exp)
    setmetatable({}, SetPlyAttributes)
    self.killstreak = killstreak
    self.exp = exp
    return self
end



hook.Add("PlayerDeath", "KillstreakAdder", function(victim, inflictor, attacker)

end)
