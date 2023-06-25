print("cl_creatormode.lua")

if (!ConVarExists("creatormode")) then
    print("CREATORMODE GENERATED.")
    concommand.Add("creatormode", function(ply)
        if( ply:IsAdmin() and ply.creatorCheck == nil or ply.creatorCheck == false) then
            ply.creatorCheck = true
            ply:PrintMessage(HUD_PRINTTALK, "CREATORMODE enabled.")
            if team.GetName(ply:Team() != "Spectator") then
                GAMEMODE:PlayerSpawnAsSpectator(ply)
                hook.Call("SpectateNoClip", nil, ply, desiredState)
            end
            net.Start("editorscene")
            net.WriteBool(ply.creatorCheck)
            net.SendToServer()
        elseif(ply:IsAdmin() and ply.creatorCheck == true) then -- if player is admin and creator check is true, disable it
            ply.creatorCheck = false
            net.Start("editorscene")
            net.WriteBool(ply.creatorCheck)
            net.SendToServer()
            ply:PrintMessage(HUD_PRINTTALK, "CREATORMODE disabled.")
        else
            ply:PrintMessage(HUD_PRINTTALK, "You cannot access creatormode, this is for superadmins." .. "Creator check: " .. to_string(ply.creatorCheck))
        end
    end)
end