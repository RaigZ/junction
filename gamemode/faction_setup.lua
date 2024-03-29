--[[----------------------------------------------------------------------------    
    faction_setup.lua

    January 7, 2023

    ADDONS USED AND CREDITS: 
        PARAKEET'S PILL PACK ADDON -->  https://steamcommunity.com/sharedfiles/filedetails/?id=950845673
--]]----------------------------------------------------------------------------

local ply = FindMetaTable("Player")

local teams = {}

-- Xen
teams[0] = {
    name = "Xen",
    totalfrags = 0,
    special_unit = {"the_GMan", "the_Dude"}, -- the_GMan
    color = Vector(1.0, 1.0, 1.0),
    --weapons = {} 
}

--Resistance...
teams[1] = {
    name = "Resistance",
    totalfrags = 0,
    special_unit = {"gordon", "barney", "alyx", "eli"}, -- Gordon, Barney, Alyx, Eli
    color = Vector(0, 0, 1.0),
    --weapons = {} 
}

--Combine...
teams[2] = {
    name = "Combine",
    totalfrags = 0,
    special_unit = {"breen"}, -- Breen 
    color = Vector(1.0, 0, 0),
    --weapons = {} 
}

--Zombies... 
teams[3] = {
    name = "Zombies",
    totalfrags = 0,
    special_unit = {"p_zomb", "zombine"}, -- Poison Zombie!? Zombine!!!???
    color = Vector(1.0, 0, 0),
    --weapons = {} 
}

---------------------------------------------------------
--[[
    DATE: January 7, 2023

    DESCRIPTION: Chooses specific factions with specific 
    units associated with factions.
    
    RETURNS: randomUnit 
    
    ;a string model name
--]]
---------------------------------------------------------

-- make faction setup PLAYER SPECIFIC (refer to the invoking player)

function ply:chosenXen() 
    randomXenUnitArg = {
        "hl1agrunt",
        "hl1bullsquid",
        "hl1vort",
        "hl1houndeye"
    }
    local randomUnit = randomXenUnitArg[math.random(1, 4)]
    self:ConCommand("pk_pill_apply" .. " " .. randomUnit)
    self:SetPData("Killstreak", 0)
    return randomUnit
end

function ply:chosenResistance() 
    randomResistanceUnitArg = {
        "rebel_m",
        "medic_m",
        "rebel_f",
        "medic_f"
    }
    local randomUnit = randomResistanceUnitArg[math.random(1, 4)]
    self:ConCommand("pk_pill_apply" .. " " .. randomUnit)
    self:SetPData("Killstreak", 0)
    return randomUnit
end

function ply:chosenCombine()
    randomCombineUnitArg = {
        "csoldier", 
        "csoldier_shotgunner", 
        "csoldier_elite"
    }  
    local randomUnit = randomCombineUnitArg[math.random(1, 3)]
    self:ConCommand("pk_pill_apply" .. " " .. randomUnit)
    self:SetPData("Killstreak", 0)
    return randomUnit
end

function ply:chosenZombies() 
    randomZombieUnitArg = {
        "zombie_fast",
        "headcrab_fast",
        "headcrab",
        "zombie"
    }
    local randomUnit = randomZombieUnitArg[math.random(1, 4)]
    self:ConCommand("pk_pill_apply " .. " " .. randomUnit)
    self:SetPData("Killstreak", 0)
    return randomUnit
end

---------------------------------------------------------
--[[
    AUTHOR: Ace_Lord
    STEAM_ID:76561198129715226
    DATE: January 7, 2023

    DESCRIPTION: Template team setup; team transition 
    phases that collects model name of unique units. 
--]]
---------------------------------------------------------

--[[

function ply:setupTeam(teamValue)
    if (not teams[teamValue]) then 
        return 
    else
        --self:SetTeam(teamValue)
        self:SetPlayerColor(teams[teamValue].color)
        
        if(teams[teamValue].name == "Xen") then
            --print("Xen")
            indep_model = chosenXen()
            print("MODEL: ", indep_model)
        elseif(teams[teamValue].name == "Resistance") then
            --print("Resistance")
            resist_model = chosenResistance()
            print("MODEL: ", resist_model)
        elseif(teams[teamValue].name == "Combine") then
            --print("Combine")
            comb_model = chosenCombine()
            print("MODEL: ", comb_model)
        elseif(teams[teamValue].name == "Zombies") then
            --print("Zombies")
            zomb_model = chosenZombies()
            print("MODEL: ", zomb_model)
        end
    end
end

--]]