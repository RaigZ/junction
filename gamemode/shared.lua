GM.Name = " Junction"
GM.Author = "RaigZ"
GM.Email = "ragirzebari123@gmail.com"
GM.Website = "N/A"

function GM:CreateTeams()
    team.SetUp(0, "Xen", Color(255, 255, 255), true)            -- Xen:              BROWN
    team.SetUp(1, "Resistance", Color(0, 0, 255), true)         -- Resistance:       BLUE
    team.SetUp(2, "Combine", Color(255, 0, 0), true)            -- Combine:          RED
    team.SetUp(3, "Zombies", Color(0, 255, 0), true)            -- Zombies:          GREEN
end

hook.Add("Initialize", "Start01", function()
    print("INITIALIZE SETUP...")
end)

