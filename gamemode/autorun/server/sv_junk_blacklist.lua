--[[

print("sv_junk_blacklist.lua")

util.AddNetworkString("blacklistedCVar")

net.Receive("blacklistedCVar", function(len, ply)
    
end)

--]]