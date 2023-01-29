if (CLIENT) then

    CreateConVar("cl_playercolor", "0.24 0.34 0.41", {FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD},
        "The value is a Vector - so between 0-1 - not between 0-255")
    CreateConVar("cl_weaponcolor", "0.30 1.80 2.10", {FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD},
        "The value is a Vector - so between 0-1 - not between 0-255")
    CreateConVar("cl_playerskin", "0", {FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD},
        "The skin to use, if the model has any")
    CreateConVar("cl_playerbodygroups", "0", {FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD},
        "The bodygroups to use, if the model has any")

end

--[[ 

    hook.Add("SetWalkSpeed", "player", function(walk)
    walk:SetWalkSpeed(4000)
    print(walk:GetWalkSpeed())
end)  

--]]  


