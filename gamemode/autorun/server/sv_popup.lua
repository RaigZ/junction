--[[----------------------------------------------------------------------------
    sv_popup.lua

    STEAM_ID: 76561198129715226
    January 7, 2023

--]]---------------------------------------------------------------------------- 

local _P = FindMetaTable("Player")

function _P:SendTimeConnect()
    return self:TimeConnected()
end
