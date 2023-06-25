print("sv_creatormode.lua")

-- command has to communicate to the server because we want entities a part of the gamemode to be visible amongst all clients
util.AddNetworkString("editorscene")

net.Receive("editorscene", function(len, ply) 
    local clientCheck = net.ReadBool()
    if (clientCheck == true) then
        print("creatormode enabled tt")
        ply:PrintMessage(HUD_PRINTTALK, "CREATOR MODE ENABLED\n\n" .. " creatormode = " .. to_string(clientCheck))
    elseif (clientCheck == false) then
        print("creatormode disabled tt")
        ply:PrintMessage(HUD_PRINTTALK, "CREATOR MODE DISABLED\n\n" .. " creatormode = " .. to_string(clientCheck))
    end
end)
