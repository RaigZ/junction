--[[----------------------------------------------------------------------------
    playerAttributes.lua

    Steam ID: 76561198129715226
    February 9, 2023
--]]----------------------------------------------------------------------------

--[[
    Description: A simple killstreak system, collects victim frags/deaths, and rewards attacker from i = 0; i = i + 1 of every
    achievable kill to increment to their overall killstreak 

    Implementation:
    Preserve killstreak values
    DO NOT PRESERVE WHEN PLAYER SWAPS TEAMS!
--]] 

--[[ 
    > When player spawns, set player attributes
    > When player gets killed, reset player attributes
    > When players kills, killstreak + 1 and exp + 5    

--]]

local ply = FindMetaTable("Player")

function ply:EnumerationSave()
    self:SetPData("Killstreak", self:GetNWInt("Killstreak"))
    --self.SetPData("XP", self:GetNWInt("XP"))
end

function ply:EnumerationLoad()
    if self:GetPData("Killstreak") == nil then -- ks does not exist, set it
        self:SetPData("Killstreak", 0) -- Writes player data into SQL database
        self:SetNWInt("Killstreak", 0) -- Sets network integer to 0 
    else
        self:SetNWInt("Killstreak", self:GetPData("Killstreak")) -- Keep the selected GetPData on the labeled Killstreak key      
    end
    --[[
    if self:GetPData("XP") == nil then
        self:SetPData("XP", 0)
        self:SetNWInt("XP", 0)
    else -- do not modify database, just reassign nwint to what it retreives from database
        self:SetNWInt("XP", self:GetPData("XP"))
    end
    --]]
end
