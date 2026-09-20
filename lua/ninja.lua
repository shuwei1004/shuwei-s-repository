-- Initialize Global Variables
getgenv().autoopencrystals = false
getgenv().autobuyranks = false
getgenv().autobuybelts = false
getgenv().autobuy = false
getgenv().autobuyskills = false
getgenv().autosell = false
getgenv().autoswing = false
getgenv().autosellpets = false

-- Load Library
local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait

-- Create Window
local PepsisWorld =
    library:CreateWindow(
    {
        Name = "Ninja Legends",
        Themeable = {
            Info = "Updated UI"
        }
    }
)

-- // TABS SETUP //
local AutofarmTab = PepsisWorld:CreateTab({Name = "Autofarm"})
local PetsTab = PepsisWorld:CreateTab({Name = "Pets"})
local TeleportingTab = PepsisWorld:CreateTab({Name = "Teleporting"})
local PlayerTab = PepsisWorld:CreateTab({Name = "LocalPlayer"})
local MiscTab = PepsisWorld:CreateTab({Name = "Misc"})

-- // SECTIONS SETUP //
local MainSection = AutofarmTab:CreateSection({Name = "Main"})
local EggSection = PetsTab:CreateSection({Name = "Open Crystals"})
local TeleportingSection = TeleportingTab:CreateSection({Name = "Teleport To Islands"})
local PlayerSection = PlayerTab:CreateSection({Name = "Stats"})
local MiscSection = MiscTab:CreateSection({Name = "Misc"})
local MiscRightSection = MiscTab:CreateSection({Name = "Misc", Side = "Right"})

-- // PETS TAB LOGIC //
local PriceLabel = EggSection:AddLabel({Name = "Crystal Price: NaN"})
local CrystalsList = {}
local SelectedCrystal = nil

-- Populate Crystal List
for i, v in pairs(game:GetService("Workspace").mapCrystalsFolder:GetChildren()) do
    table.insert(CrystalsList, v.Name)
end
table.sort(
    CrystalsList,
    function(a, b)
        return game:GetService("ReplicatedStorage").crystalPrices[a].price.Value <
            game:GetService("ReplicatedStorage").crystalPrices[b].price.Value
    end
)

EggSection:AddDropdown(
    {
        Name = "Choose Crystal",
        List = CrystalsList,
        Callback = function(t)
            pcall(
                function()
                    local number = require(game:GetService("ReplicatedStorage").globalFunctions)
                    local Price = game:GetService("ReplicatedStorage").crystalPrices[t].price.Value
                    local PriceType = game:GetService("ReplicatedStorage").crystalPrices[t].priceType.Value
                    SelectedCrystal = t
                    PriceLabel:Set(
                        "Crystal Price: " .. tostring(number.shortenNumber(Price)) .. " " .. tostring(PriceType)
                    )
                end
            )
        end
    }
)

EggSection:AddButton(
    {
        Name = "Open Once",
        Callback = function()
            if SelectedCrystal == nil then
                return
            end
            game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", SelectedCrystal)
        end
    }
)

EggSection:AddToggle(
    {
        Name = "Auto Open Crystals",
        Callback = function(v)
            getgenv().autoopencrystals = v
            task.spawn(
                function()
                    while true do
                        if not getgenv().autoopencrystals then
                            return
                        end
                        if SelectedCrystal == nil then
                            return
                        end
                        game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer(
                            "openCrystal",
                            SelectedCrystal
                        )
                        Wait(0.5) -- Using library wait
                    end
                end
            )
        end
    }
)

-- Dynamic Pet Auto Sell Toggles
for i, v in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
    MiscRightSection:AddToggle(
        {
            Name = "AutoSell: " .. v.Name,
            Callback = function(t)
                getgenv().autosellpets = t
                task.spawn(
                    function()
                        while getgenv().autosellpets do
                            Wait(0.1)
                            for z, val in pairs(v:GetChildren()) do
                                game:GetService("ReplicatedStorage").rEvents.sellPetEvent:FireServer("sellPet", val)
                            end
                        end
                    end
                )
            end
        }
    )
end

-- // AUTOFARM TAB LOGIC //

-- Helper for loops to prevent freezing
local function createLoopToggle(section, name, callback)
    section:AddToggle(
        {
            Name = name,
            Callback = function(v)
                task.spawn(
                    function()
                        while v do
                            callback()
                            Wait(0.1) -- Small wait to prevent crash
                        end
                    end
                )
            end
        }
    )
end

-- 1. Auto Buy Ranks
local ranks = {}
for i, v in pairs(game:GetService("ReplicatedStorage").Ranks.Ground:GetChildren()) do
    table.insert(ranks, v.Name)
end

MainSection:AddToggle(
    {
        Name = "Auto Buy All Ranks",
        Callback = function(v)
            getgenv().autobuyranks = v
            task.spawn(
                function()
                    while getgenv().autobuyranks do
                        for i = 1, #ranks do
                            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("buyRank", ranks[i])
                        end
                        Wait(0.1)
                    end
                end
            )
        end
    }
)

-- 2. Auto Buy Belts
MainSection:AddToggle(
    {
        Name = "Auto Buy All Belts",
        Callback = function(v)
            getgenv().autobuybelts = v
            task.spawn(
                function()
                    while getgenv().autobuybelts do
                        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(
                            "buyAllBelts",
                            "Inner Peace Island"
                        )
                        Wait(0.5)
                    end
                end
            )
        end
    }
)

-- 3. Auto Buy Skills
MainSection:AddToggle(
    {
        Name = "Auto Buy All Skills",
        Callback = function(v)
            getgenv().autobuyskills = v
            task.spawn(
                function()
                    while getgenv().autobuyskills do
                        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(
                            "buyAllSkills",
                            "Inner Peace Island"
                        )
                        Wait(0.5)
                    end
                end
            )
        end
    }
)

-- 4. Auto Buy Swords
MainSection:AddToggle(
    {
        Name = "Auto Buy All Swords",
        Callback = function(v)
            getgenv().autobuy = v
            task.spawn(
                function()
                    while getgenv().autobuy do
                        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(
                            "buyAllSwords",
                            "Inner Peace Island"
                        )
                        Wait(0.5)
                    end
                end
            )
        end
    }
)

-- 5. Auto Sell
MainSection:AddToggle(
    {
        Name = "Auto Sell",
        Callback = function(v)
            getgenv().autosell = v
            task.spawn(
                function()
                    while getgenv().autosell do
                        game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame =
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        Wait(0.1)
                        game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame =
                            CFrame.new(0, 0, 0)
                        Wait(0.1)
                    end
                end
            )
        end
    }
)

-- 6. Auto Swing
MainSection:AddToggle(
    {
        Name = "Auto Swing",
        Callback = function(v)
            getgenv().autoswing = v
            task.spawn(
                function()
                    while getgenv().autoswing do
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:FindFirstChild("ninjitsuGain") then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                                break
                            end
                        end
                        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("swingKatana")
                        Wait()
                    end
                end
            )
        end
    }
)

-- // LOCAL PLAYER TAB LOGIC //
PlayerSection:AddSlider(
    {
        Name = "WalkSpeed",
        Value = 16,
        Min = 16,
        Max = 500,
        Callback = function(s)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
        end
    }
)

PlayerSection:AddSlider(
    {
        Name = "JumpPower",
        Value = 50,
        Min = 50,
        Max = 400,
        Callback = function(s)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
        end
    }
)

-- // TELEPORTING TAB LOGIC //
local Islandslist = {
    "Enchanted Island",
    "Astral Island",
    "Mystical Island",
    "Space Island",
    "Tundra Island",
    "Eternal Island",
    "Sandstorm",
    "Thunderstorm",
    "Ancient Inferno Island",
    "Midnight Shadow Island",
    "Mythical Souls Island",
    "Winter Wonder Island",
    "Golden Master Island",
    "Dragon Legend Island",
    "Cybernetic Legends Island",
    "Skystorm Ultraus Island",
    "Chaos Legends Island",
    "Soul Fusion Island",
    "Dark Elements Island",
    "Inner Peace Island",
    "Blazing Vortex Island"
}

TeleportingSection:AddDropdown(
    {
        Name = "Teleport To Island",
        List = Islandslist,
        Callback = function(t)
            pcall(
                function()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                        game:GetService("Workspace").islandUnlockParts[t].CFrame
                end
            )
        end
    }
)

local TrainingList = {
    "Mystical Waters",
    "Lava Pit",
    "Tornado",
    "Sword of Legends",
    "Sword of Ancients",
    "Elemental Tornado",
    "Fallen Infinity Blade",
    "Zen Master's Blade"
}

TeleportingSection:AddDropdown(
    {
        Name = "Teleport To Training Area",
        List = TrainingList,
        Callback = function(t)
            pcall(
                function()
                    local CF = nil
                    if t == "Mystical Waters" then
                        CF =
                            CFrame.new(
                            343.933624,
                            8824.41309,
                            116.454231,
                            0.296236873,
                            3.43450957e-08,
                            -0.955114484,
                            4.83460703e-08,
                            1,
                            5.09540854e-08,
                            0.955114484,
                            -6.12705122e-08,
                            0.296236873
                        )
                    elseif t == "Lava Pit" then
                        CF =
                            CFrame.new(
                            -126.416206,
                            12952.4131,
                            273.149292,
                            -0.276711583,
                            -5.23082626e-08,
                            0.960952997,
                            2.41545077e-08,
                            1,
                            6.13891586e-08,
                            -0.960952997,
                            4.01984366e-08,
                            -0.276711583
                        )
                    elseif t == "Tornado" then
                        CF =
                            CFrame.new(
                            313.673065,
                            16871.9688,
                            -14.7217541,
                            0.994922996,
                            7.48534461e-08,
                            -0.100639053,
                            -7.66444046e-08,
                            1,
                            -1.39292826e-08,
                            0.100639053,
                            2.15719833e-08,
                            0.994922996
                        )
                    elseif t == "Sword of Legends" then
                        CF =
                            CFrame.new(
                            1847.01306,
                            38.5793152,
                            -139.799545,
                            0.940122247,
                            1.6319289e-08,
                            0.340837389,
                            1.772184e-08,
                            1,
                            -9.67616387e-08,
                            -0.340837389,
                            9.70080336e-08,
                            0.940122247
                        )
                    elseif t == "Sword of Ancients" then
                        CF =
                            CFrame.new(
                            608.698364,
                            38.5796623,
                            2425.60474,
                            -0.0159091037,
                            -4.19558752e-08,
                            -0.999873459,
                            -6.51419052e-09,
                            1,
                            -4.18575361e-08,
                            0.999873459,
                            5.84745008e-09,
                            -0.0159091037
                        )
                    elseif t == "Elemental Tornado" then
                        CF =
                            CFrame.new(
                            323.196381,
                            30382.9707,
                            0.835642278,
                            -0.906975925,
                            -6.70449865e-08,
                            0.421182454,
                            -2.82923036e-08,
                            1,
                            9.82580062e-08,
                            -0.421182454,
                            7.72014275e-08,
                            -0.906975925
                        )
                    elseif t == "Fallen Infinity Blade" then
                        CF =
                            CFrame.new(
                            1883.16479,
                            66.9705124,
                            -6811.90771,
                            0.91395551,
                            -4.90655268e-08,
                            -0.405814409,
                            5.31859889e-09,
                            1,
                            -1.08928035e-07,
                            0.405814409,
                            9.73970131e-08,
                            0.91395551
                        )
                    elseif t == "Zen Master's Blade" then
                        CF = CFrame.new()
                    end

                    if CF then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF
                    end
                end
            )
        end
    }
)

-- // MISC TAB LOGIC //
MiscSection:AddButton(
    {
        Name = "Open Shop",
        Callback = function()
            game:GetService("Workspace").shopAreaCircles.shopAreaCircle19.circleInner.CFrame =
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            Wait(0.4)
            game:GetService("Workspace").shopAreaCircles.shopAreaCircle19.circleInner.CFrame = CFrame.new(0, 0, 0)
        end
    }
)

MiscSection:AddButton(
    {
        Name = "Infinite Double Jumps",
        Callback = function()
            game.Players.LocalPlayer.multiJumpCount.Value = 999999999
        end
    }
)

MiscSection:AddButton(
    {
        Name = "Unlock all Islands",
        Callback = function()
            for _, v in pairs(game:GetService("Workspace").islandUnlockParts:GetChildren()) do
                firetouchinterest(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), v, 0)
                firetouchinterest(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), v, 1)
            end
        end
    }
)

MiscSection:AddButton(
    {
        Name = "Unlock all Elements",
        Callback = function()
            local Elements = {}
            for i, v in pairs(game:GetService("ReplicatedStorage").Elements:GetChildren()) do
                table.insert(Elements, v.Name)
            end
            for i, v in pairs(Elements) do
                game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer(v)
            end
        end
    }
)

MiscSection:AddButton(
    {
        Name = "Open All Chests",
        Callback = function()
            for i = 1, #Workspace:GetChildren() do
                local v = Workspace:GetChildren()[i]
                if
                    v:FindFirstChild("Chest") and
                        (v:FindFirstChild("circleInner") and v.circleInner:FindFirstChildWhichIsA("TouchTransmitter"))
                 then
                    local Transmitter = v.circleInner:FindFirstChildWhichIsA("TouchTransmitter")
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, Transmitter.Parent, 0)
                    Wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, Transmitter.Parent, 1)
                    Wait(5)
                end
            end
        end
    }
)

MiscSection:AddButton(
    {
        Name = "Collect all Hoops",
        Callback = function()
            for i, v in pairs(game:GetService("Workspace").Hoops:GetChildren()) do
                if v:IsA("MeshPart") then
                    v.touchPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    Wait(0.25)
                    v.touchPart.CFrame = CFrame.new(0, 0, 0)
                end
            end
        end
    }
)

MiscSection:AddButton(
    {
        Name = "Turn On/Off Popups",
        Callback = function()
            local gui = game.Players.LocalPlayer.PlayerGui.statEffectsGui
            if gui.Enabled == false then
                gui.Enabled = true
                game.Players.LocalPlayer.PlayerGui.hoopGui.Enabled = true
            else
                gui.Enabled = false
                game.Players.LocalPlayer.PlayerGui.hoopGui.Enabled = false
            end
        end
    }
)