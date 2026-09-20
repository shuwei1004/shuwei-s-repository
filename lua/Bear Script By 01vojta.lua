workspace.Camera.FieldOfView = 100
-- For Music
local sound = game.Workspace:FindFirstChild("Music")

if sound then
    -- Function to check if a sound effect already exists
    local function findEffect(className)
        for _, effect in ipairs(sound:GetChildren()) do
            if effect:IsA(className) then
                return effect
            end
        end
        return nil
    end

    -- Add DistortionSoundEffect if not present
    local distort = findEffect("DistortionSoundEffect")
    if not distort then
        distort = Instance.new("DistortionSoundEffect")
        distort.Parent = sound
        distort.Enabled = true
        distort.Level = 0
    end

    -- Add EqualizerSoundEffect if not present
    local eq = findEffect("EqualizerSoundEffect")
    if not eq then
        eq = Instance.new("EqualizerSoundEffect")
        eq.Parent = sound
        eq.Enabled = true
        eq.HighGain = 0
        eq.LowGain = 0
        eq.MidGain = 0
    end

    -- Add PitchShiftSoundEffect if not present
    local pitchShift = findEffect("PitchShiftSoundEffect")
    if not pitchShift then
        pitchShift = Instance.new("PitchShiftSoundEffect")
        pitchShift.Parent = sound
        pitchShift.Enabled = true
        pitchShift.Octave = 1
        pitchShift.Priority = 0
    end

    -- Add ReverbSoundEffect if not present
    local reverbEffect = findEffect("ReverbSoundEffect")
    if not reverbEffect then
        reverbEffect = Instance.new("ReverbSoundEffect")
        reverbEffect.Parent = sound
        reverbEffect.Enabled = false
        reverbEffect.DecayTime = 0.1
        reverbEffect.Density = 0
        reverbEffect.DryLevel = 0
        reverbEffect.WetLevel = 0
    end
end



-- Check if the sound instance exists
    if not sound then
     warn("No sound instance named 'Music' found in Workspace!")
     return
    end

Lighting = game:GetService("Lighting")
-- 100000


-- Bear anniversary lobby theme ost id: rbxassetid://13508905498

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()


local Window = Rayfield:CreateWindow({
    Name = "Bear [Alpha] GUI | 01vojta",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by 01vojta",
    Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
 
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "ConfigOne"
    },
 
    Discord = {
       Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })
 
 Rayfield:Notify({
    Title = "Yessir!!!",
    Content = "Script has been loaded successfully!",
    Duration = 3,
    Image = "check",
 })

local Tab = Window:CreateTab("Main", "menu")

 local Section = Tab:CreateSection("Scripts")

 local Button = Tab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        print("Bear [Alpha] GUI: Infinite Yield Executed✔")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Dex Explorer",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
        print("Bear [Alpha] GUI: Dex Explorer Executed✔")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Emote GUI [R15 Only]",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
        print("Bear [Alpha] GUI: Emote GUI Excuted✔")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Zephyr [Another Bear Alpha Script GUI]",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Unknownlodfc/idk/main/Zephyr%20%7C%20Bear%20%5BALPHA%5D"))()
        print("Bear [Alpha] GUI: Zephyr Loaded✔")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "OP Fling Gui",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/4nYEdANe"))()
        print("Bear [Alpha] GUI: Fling GUI Loaded✔")
    end,
 })

 local Divider = Tab:CreateDivider()

 local Section = Tab:CreateSection("Main Stuff")

 local Button = Tab:CreateButton({
    Name = "Fullbright",
    Callback = function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        print("Bear [Alpha] GUI: Fullbright Activated✔")
    end,
 })


 local Button = Tab:CreateButton({
    Name = "Revert Lighting",
    Callback = function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 0
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 120
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        print("Bear [Alpha] GUI: Fullbright Reverted✔")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Spectator Lighting",
    Callback = function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 0
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        print("Bear [Alpha] GUI: Fullbright Activated✔")
    end,
 })
 
 local Slider = Tab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 250},
    Increment = 1,
    Suffix = "Walkspeed",
    CurrentValue = 16,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end,
 })

  local Slider = Tab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 500},
    Increment = 1,
    Suffix = "JumpPower",
    CurrentValue = 50,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Reset Walkspeed",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        print("Bear [Alpha] GUI: Walkspeed Reset✔")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Reset Bear Walkspeed",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 18
        print("Bear [Alpha] GUI: Bear Walkspeed Reset✔")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Infinite Stamina [Hold Q to run.]",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/01vojta/Roblox-Scripts/refs/heads/main/ShiftToRunScript.lua"))()
        print("Bear [Alpha] GUI: Hold 'Q' To Run❗")
    end,
 })

 local Divider = Tab:CreateDivider()
 local Section = Tab:CreateSection("ESP")

 local Button = Tab:CreateButton({
    Name = "ESP",
    Callback = function()
-- ESP Script start
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local function removeHighlightFromCharacter(character)
    local existingHighlight = character:FindFirstChildOfClass("Highlight")
    if existingHighlight then
        existingHighlight:Destroy()
    end
end

local function addHighlightToCharacter(character)
    local player = Players:GetPlayerFromCharacter(character)
    if player then
        if player.Team and player.Team.Name == "Bear" then
            local torso = character:FindFirstChild("Torso")
            if torso then
                removeHighlightFromCharacter(torso)
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Red for Bear team
                highlight.Parent = torso
                highlight.Name = "BearHighlight"
                torso.Transparency = 0 -- Set torso transparency to 0
            else
                removeHighlightFromCharacter(character)
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Red for Bear team
                highlight.Parent = character
                highlight.Name = "BearHighlight"
            end
        else
            removeHighlightFromCharacter(character)
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(14, 100, 255) -- Blue for others
            highlight.Parent = character
        end
    end
end

local function addHighlightToAllPlayers()
    local players = Players:GetPlayers()
    for i, player in players do
        local character = player.Character
        if character then
            addHighlightToCharacter(character)
        end
    end
end

-- Add highlight to all existing player characters
addHighlightToAllPlayers()

-- Listen for new player characters being added
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(addHighlightToCharacter)
end)

-- Update highlights every 5 seconds
while true do
    task.wait(5)
    addHighlightToAllPlayers()
end


-- End To the esp script

        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "ESP Activated",
            Duration = 6.5,
            Image = "rewind",
         })
        print("Bear [Alpha] GUI: ESP Activated!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Name ESP",
    Callback = function()
--Name Esp Start
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local function createBillboardGui(character)
    local head = character:FindFirstChild("Head")
    if head then
        -- Remove existing BillboardGui if it exists
        local existingGui = head:FindFirstChild("BearESP")
        if existingGui then
            existingGui:Destroy()
        end

        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "BearESP"
        billboardGui.AlwaysOnTop = true
        billboardGui.MaxDistance = 9999999999999
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.Adornee = head
        billboardGui.Parent = head

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = character.Name -- Set the text to the character's name
        textLabel.Parent = billboardGui

        local player = Players:GetPlayerFromCharacter(character)
        if player then
            if player.Team == Teams:FindFirstChild("Bear") then
                textLabel.TextColor3 = Color3.new(255, 0, 0) -- Red color
            else
                textLabel.TextColor3 = Color3.new(255, 255, 255) -- White color
            end
        end
    end
end

local function addBillboardGuiToAllPlayers()
    local players = Players:GetPlayers()
    for i, player in players do
        local character = player.Character
        if character then
            createBillboardGui(character)
        end
    end
end

-- Add BillboardGui to all existing player characters
addBillboardGuiToAllPlayers()

-- Listen for new player characters being added
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(createBillboardGui)
end)

-- Update BillboardGui every 5 seconds
while true do
    task.wait(5)
    addBillboardGuiToAllPlayers()
end
--Name ESP End

        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Name ESP Activated",
            Duration = 6.5,
            Image = "rewind",
         })
        print("Bear [Alpha] GUI: Name ESP Activated!")
    end,
 })

 local Divider = Tab:CreateDivider()
 local Section = Tab:CreateSection("Misc")
 local Button = Tab:CreateButton({
    Name = "Disable Cutscene Guis",
    Callback = function()
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

if not PlayerGui then return end

local function MuteSoundsInGui(gui)
    for _, sound in ipairs(gui:GetDescendants()) do
        if sound:IsA("Sound") then
            sound.Volume = 0
        end
    end
end

local function CheckForCutscene()
    local cutscene = PlayerGui:FindFirstChild("Cutscene")
    local cutsceneDeluxe = PlayerGui:FindFirstChild("CutsceneDeluxe")
    
    if cutscene then
        MuteSoundsInGui(cutscene)
        cutscene.Enabled = false  -- Disable the Cutscene GUI
    end
    
    if cutsceneDeluxe then
        MuteSoundsInGui(cutsceneDeluxe)
        cutsceneDeluxe.Enabled = false  -- Disable the CutsceneDeluxe GUI
    end
end

-- Initial check
CheckForCutscene()

-- Listen for new GUI elements being added
PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "Cutscene" or child.Name == "CutsceneDeluxe" then
        MuteSoundsInGui(child)
        child.Enabled = false  -- Disable the GUI when added
    end
end)

-- Periodically check every 2 seconds
task.spawn(function()
    while true do
        CheckForCutscene()
        task.wait(2)
    end
end)

    end,
 })

 local Tab = Window:CreateTab("Puzzles", "puzzle")

 local Section = Tab:CreateSection("This highlights all the puzzles [You need to click it again every new round]")

 local Button = Tab:CreateButton({
    Name = "Puzzle ESP",
    Callback = function()
        -- Puzzle ESP Start
        local function addHighlight(object)
            local highlight = Instance.new("Highlight")
            highlight.Adornee = object
            highlight.FillColor = Color3.new(1, 1, 0) -- Yellow color
            highlight.Parent = object
        end
        
        -- Check for PuzzleBin and Puzzle | Cheese
        local puzzleBin = workspace:FindFirstChild("PuzzleBin")
        if puzzleBin then
            local puzzleCheese = puzzleBin:FindFirstChild("Puzzle | Cheese")
            if puzzleCheese then
                print("Puzzle | Cheese folder found inside PuzzleBin.")
                addHighlight(puzzleCheese)
        
                -- Check for a part named "Cheese" inside "Puzzle | Cheese"
                local cheesePart = puzzleCheese:FindFirstChild("Cheese")
                if cheesePart then
                    print("Part named 'Cheese' found inside Puzzle | Cheese.")
                    addHighlight(cheesePart)
                else
                    print("Part named 'Cheese' not found inside Puzzle | Cheese.")
                end
            else
                print("Puzzle | Cheese folder not found inside PuzzleBin.")
            end
        
            -- Check for Memory group inside PuzzleBin
            local decorCheese = puzzleBin:FindFirstChild("DecorCheese")
            if decorCheese then
                print("DecorCheese group found inside PuzzleBin.")
                addHighlight(decorCheese)
            else
                print("DecorCheese group not found inside PuzzleBin.")
            end

                        -- Check for Memory group inside PuzzleBin
                        local memoryGroup = puzzleBin:FindFirstChild("Memory")
                        if memoryGroup then
                            print("Memory group found inside PuzzleBin.")
                            addHighlight(memoryGroup)
                        else
                            print("Memory group not found inside PuzzleBin.")
                        end
        
            -- Check for CheeseAltar group inside PuzzleBin
            local cheeseAltarGroup = puzzleBin:FindFirstChild("CheeseAltar")
            if cheeseAltarGroup then
                print("CheeseAltar group found inside PuzzleBin.")
                addHighlight(cheeseAltarGroup)
            else
                print("CheeseAltar group not found inside PuzzleBin.")
            end
        
            local colorCodeGroup = puzzleBin:FindFirstChild("ColorCode")
            if colorCodeGroup then
                print("ColorCode group found inside PuzzleBin.")
                addHighlight(colorCodeGroup)
            else
                print("ColorCode group not found inside PuzzleBin.")
            end
        
            -- Check for Wire group inside PuzzleBin
            local wireGroup = puzzleBin:FindFirstChild("Wire")
            if wireGroup then
                print("Wire group found inside PuzzleBin.")
                addHighlight(wireGroup)
            else
                print("Wire group not found inside PuzzleBin.")
            end
        
            -- Check for all groups named "Wire" inside PuzzleBin
            local foundWires = false
            for _, child in puzzleBin:GetChildren() do
                if child.Name == "Wire" then
                    print("Group named 'Wire' found inside PuzzleBin.")
                    addHighlight(child)
                    foundWires = true
                end
            end
            if not foundWires then
                print("No group named 'Wire' found inside PuzzleBin.")
            end
        else
            print("PuzzleBin folder not found.")
        end
        
        -- Check for _Entities inside Map
        local mapGroup = workspace:FindFirstChild("Map")
        if mapGroup then
            local entitiesFolder = mapGroup:FindFirstChild("_Entities")
            if entitiesFolder then
                print("_Entities folder found inside Map.")
        
                -- Check for Cheese group inside _Entities
                local cheeseGroup = entitiesFolder:FindFirstChild("Cheese")
                if cheeseGroup then
                    print("Cheese group found inside _Entities.")
                    addHighlight(cheeseGroup)
                else
                    print("Cheese group not found inside _Entities.")
                end
            else
                print("_Entities folder not found inside Map.")
            end
    
            -- Check for VSH group inside Map
            local vshGroup = entitiesFolder:FindFirstChild("VHS")
            if vshGroup then
                print("VHS group found inside Map.")
                addHighlight(vshGroup)
            else
                print("VHS group not found inside Map.")
            end
        else
            print("Map group not found.")
        end

        -- Puzzle Esp End

        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Puzzle ESP Activated",
            Duration = 6.5,
            Image = "puzzle",
         })
        print("Bear [Alpha] GUI: Puzzle ESP Activated!")
    end,
 })


 local Button = Tab:CreateButton({
    Name = "Show Color Code [Only works if a round is happening]",
    Callback = function()
    --Show Color Code Script Start
    local puzzleBin = workspace:FindFirstChild("PuzzleBin")
    if puzzleBin then
        local colorCodeGroup = puzzleBin:FindFirstChild("ColorCode")
        if colorCodeGroup then
            local cluePart = colorCodeGroup:FindFirstChild("Clue")
            if cluePart then
                local surfaceGui = cluePart:FindFirstChild("Note")
                if surfaceGui and surfaceGui:IsA("SurfaceGui") then
                    local frame = surfaceGui:FindFirstChildOfClass("Frame")
                    if frame then
                        local screenGui = Instance.new("ScreenGui")
                        screenGui.Name = "ColorRevealGui"
                        screenGui.ResetOnSpawn = false
                        screenGui.IgnoreGuiInset = true
                        
                        local mainFrame = Instance.new("Frame")
                        mainFrame.Name = "Main"
                        mainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
                        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                        mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                        mainFrame.BackgroundColor3 = Color3.fromRGB(36, 27, 66)
                        mainFrame.BackgroundTransparency = 0.7
                        mainFrame.Parent = screenGui
    
                        local corner = Instance.new("UICorner")
                        corner.Parent = mainFrame
    
                        local CloseButton = Instance.new("ImageButton")
                        CloseButton.Name = "Close"
                        CloseButton.Size = UDim2.new(0, 50, 0, 50)
                        CloseButton.Position = UDim2.new(1, 0, 0, 0)
                        CloseButton.AnchorPoint = Vector2.new(1, 0)
                        CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        CloseButton.BackgroundTransparency = 1
                        CloseButton.Image = "rbxassetid://13207238741"
                        CloseButton.Parent = mainFrame
                        CloseButton.MouseButton1Click:Connect(function()
                            screenGui:Destroy()
                        end)
                        
                        local clonedFrame = frame:Clone()
                        clonedFrame.Parent = mainFrame
                        
                        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
                    else
                        warn("Frame not found inside SurfaceGui 'Note'.")
                    end
                else
                    warn("SurfaceGui 'Note' not found or is not a SurfaceGui.")
                end
            else
                warn("Part 'Clue' not found inside ColorCode group.")
            end
        else
            warn("ColorCode group not found inside PuzzleBin.")
        end
    else
        warn("PuzzleBin folder not found.")
    end
    
    --Show Color Code Script End
    end,
 })

 local Tab = Window:CreateTab("Fun", "ferris-wheel")

 local Button = Tab:CreateButton({
    Name = "Make Spob have a :3 face ",
    Callback = function()
    -- Get the player and their head
local player = game.Players.LocalPlayer
local head = player.Character.Head

-- Check if the player is in the "Bear" team
if player.Team.Name == "Bear" then
    -- Check if the head has a decal
    local decal = head:FindFirstChild("Decal")
    if decal then
        -- Change the decal's Texture ID
        decal.Texture = "rbxassetid://109891608761602"
        --- rbxassetid://18371796935
    end
end
    end,
 })

 local Input = Tab:CreateInput({
    Name = "Custom Bear Image",
    CurrentValue = "9180622670",
    PlaceholderText = "Put valid ImageId Here",
    RemoveTextAfterFocusLost = true,
    Flag = "Input1",
    Callback = function(Text1)

        local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local SkibidiText = "rbxassetid://" .. Text1  -- Replace with the correct asset ID or URL

local bearTeam = Teams:FindFirstChild("Bear")
if bearTeam then
	for _, player in Players:GetPlayers() do
		if player.Team == bearTeam then
			local character = player.Character or player.CharacterAdded:Wait()
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				-- Check for the existing BillboardGui
				local billboardGui = humanoidRootPart:FindFirstChildOfClass("BillboardGui")
				if billboardGui then
					local idleImage = billboardGui:FindFirstChild("Idle")
					local walk1Image = billboardGui:FindFirstChild("Walk1")
					local walk2Image = billboardGui:FindFirstChild("Walk2")
					if idleImage and walk1Image and walk2Image then
						idleImage.Image = SkibidiText
						walk1Image.Image = SkibidiText
						walk2Image.Image = SkibidiText
						print("Updated all ImageLabels for player:", player.Name)
					else
						print("Missing one or more ImageLabels for player:", player.Name)
					end
				else
					print("No BillboardGui found for player:", player.Name)
				end
				
				-- Check for the BillboardGui named "SkinGui"
				local skinGui = humanoidRootPart:FindFirstChild("SkinGui")
				if skinGui then
					local idleImage = skinGui:FindFirstChild("Idle")
					local walk1Image = skinGui:FindFirstChild("Walk1")
					local walk2Image = skinGui:FindFirstChild("Walk2")
					if idleImage and walk1Image and walk2Image then
						idleImage.Image = SkibidiText
						walk1Image.Image = SkibidiText
						walk2Image.Image = SkibidiText
						print("Updated all ImageLabels in SkinGui for player:", player.Name)
					else
						print("Missing one or more ImageLabels in SkinGui for player:", player.Name)
					end
				else
					print("No SkinGui found for player:", player.Name)
				end
			else
				print("No HumanoidRootPart found for player:", player.Name)
			end
		end
	end
else
	print("Bear team not found")
end


    end,
 })


 --Fun Tab End
 local Tab = Window:CreateTab("Music", "music")
 local Section = Tab:CreateSection("Music Main")

 local Button = Tab:CreateButton({
    Name = "Remove Reverb.",
    Callback = function()
        local SoundService = game:GetService("SoundService")
        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Add Back Reverb.",
    Callback = function()
        local SoundService = game:GetService("SoundService")
        SoundService.AmbientReverb = Enum.ReverbType.Hangar
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Mute Music [Temporary. Every Round Resets]",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Muted✔",
            Duration = 6.5,
            Image = "volume-off",
         })
    end,
 })


 local Slider = Tab:CreateSlider({
    Name = "Volume",
    Range = {0, 2},
    Increment = 0.1,
    Suffix = "Volume",
    CurrentValue = 1,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(v)
        local M = workspace.Music
        M.Volume = v

    end,
 })

 local Section = Tab:CreateSection("My favorite songs [This Only Works In Bear and only you can hear these songs.]")
 local Divider = Tab:CreateDivider()
 local Section = Tab:CreateSection("Jugsta [Handpicked Favs]")

 local Button = Tab:CreateButton({
    Name = "Jugsta - Treasury",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://16190761193"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Deja Vus 2",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://15689442404"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Skeletons",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://15689450026"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Get Away",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://18841887862"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })
 
 local Button = Tab:CreateButton({
    Name = "Jugsta - Rampage (Sped Up)",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://15689453751"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Rampage",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://15689441013"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Ouuu",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://15689442874"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Cash Up (Prod. Hitsko)",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://16190758325"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Japan",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://14884822465"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Lose Yourself",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://14884817551"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Runaway",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://16662827317"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Jugsta - Batman",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://14884822914"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Divider = Tab:CreateDivider()
 local Section = Tab:CreateSection("Random Brainrot Stuff lmao")

 local Button = Tab:CreateButton({
    Name = "Bullet - Skibidi fanum tax (Prod. yakside)",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://16190757458"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "GoofyAhhTate - Rizzlers and Moggers",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://18841888491"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "GoofyAhhTate - PLUH",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://16662827543"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "GoofyAhhTate - For The Rizzlers",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://18841891795"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Bullet - FIRE IN THE HOLE",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://16662832129"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Bullet - FIRE IN THE HOLE (Cursed Version)",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://16662835028"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Divider = Tab:CreateDivider()
 local Section = Tab:CreateSection("Goated Songs")

 local Button = Tab:CreateButton({
    Name = "d3r - Love Bomb",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://18841888868"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "d3r - No Escape",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://18841891575"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "HR - WASSA (Ins)",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://17422207260"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Sukoyomi - ◡‿◡ Girlfriend",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://16190781665"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "SAKU - GTA (Nightcore)",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://14366981664"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "nMisaki - Russian Angel 2 (In Cosmos)",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://15689447739"
        M.PlaybackSpeed = 1
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Cheedaman - [BEAR] RUN IT BACK, THE ANNIVERSARY TRACK",
    Callback = function()
        local M = workspace.Music
        M.SoundId = "rbxassetid://13508905498"
        M.PlaybackSpeed = 1.05
        M.TimePosition = 0
        M.Playing = true
        M.Looped = true
        
        
        Rayfield:Notify({
            Title = "Bear [Alpha] GUI",
            Content = "Music Loaded✔",
            Duration = 6.5,
            Image = "music",
         })
    end,
 })

 local Divider = Tab:CreateDivider()
 local Section = Tab:CreateSection("Bypassed Audios [Coming Soon cuz 99.9% of them are deleted 😭]")

 local Tab = Window:CreateTab("Custom Songs", "music")

local Section = Tab:CreateSection("CUSTOM MUSIC HOLY MOLY!!!!")
local Label = Tab:CreateLabel("How to use: Go inside your exploit workspace folder and create a folder named 'Music' (Exactly like that or it wont work) and you put your music files here.", "activity")
   local Label = Tab:CreateLabel("And do not forget to put the full music file name with exetnsion! Example: music.mp3", "file")

    local Button = Tab:CreateButton({
        Name = "Remove Reverb.",
        Callback = function()
            local SoundService = game:GetService("SoundService")
            SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        end,
     })
    
     local Button = Tab:CreateButton({
        Name = "Add Back Reverb.",
        Callback = function()
            local SoundService = game:GetService("SoundService")
            SoundService.AmbientReverb = Enum.ReverbType.Hangar
        end,
     })
    
     local Button = Tab:CreateButton({
        Name = "Mute Music [Temporary. Every Round Resets]",
        Callback = function()
            local M = workspace.Music
            M.SoundId = "rbxassetid://"
            M.PlaybackSpeed = 1
            M.TimePosition = 0
            M.Playing = true
            M.Looped = true
            
            
            Rayfield:Notify({
                Title = "Bear [Alpha] GUI",
                Content = "Music Muted✔",
                Duration = 6.5,
                Image = "volume-off",
             })
        end,
     })
    
    
     local Slider = Tab:CreateSlider({
        Name = "Volume",
        Range = {0, 2},
        Increment = 0.1,
        Suffix = "Volume",
        CurrentValue = 1,
        Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(v)
            local M = workspace.Music
            M.Volume = v
    
        end,
     })

    local Input = Tab:CreateInput({
           Name = "Enter Song File Name",
           PlaceholderText = "song.mp3/wav/ogg",
           RemoveTextAfterFocus = false,
           Callback = function(text)
            local musicFolderPath = "Music"

            -- Check if the "Music" folder exists
            if not isfolder(musicFolderPath) then
                warn("Folder not found: " .. musicFolderPath)
                return
            end
            
            local fileName = text -- Get the filename from the TextBox
            local filePath = musicFolderPath .. "/" .. fileName
            
            -- Check if the file exists before playing
            if isfile(filePath) then
                sound.SoundId = getcustomasset(filePath) -- Set the SoundId to the custom asset
                sound.Volume = 1
                sound.TimePosition = 0
                sound:Play() -- Play the sound
                print("Playing: " .. filePath)
            else
                warn("File not found: " .. filePath)
            end
            
           end
       })

       local Section = Tab:CreateSection("Music Settings") 

       local Input = Tab:CreateInput({
        Name = "Playback Speed",
        CurrentValue = "",
        PlaceholderText = "1",
        RemoveTextAfterFocusLost = false,
        Flag = "Input1",
        Callback = function(Text)
            local M = workspace.Music
            M.PlaybackSpeed = Text
        end,
     })

       local Slider = Tab:CreateSlider({
        Name = "Playback Speed",
        Range = {0, 12},
        Increment = 0.01,
        Suffix = "Amount",
        CurrentValue = 1,
        Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(v)
            local M = workspace.Music
            M.PlaybackSpeed = v
    
        end,
     })

       local Divider = Tab:CreateDivider()
       local Section = Tab:CreateSection("Distortion") 

       local Input = Tab:CreateInput({
        Name = "Distortion",
        CurrentValue = "",
        PlaceholderText = "0",
        RemoveTextAfterFocusLost = false,
        Flag = "Input1",
        Callback = function(Text)
            local M = workspace.Music.DistortionSoundEffect
            M.Level = Text
        end,
     })

       local Slider = Tab:CreateSlider({
        Name = "Distortion",
        Range = {0, 1},
        Increment = 0.01,
        Suffix = "Amount",
        CurrentValue = 0,
        Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(v)
            local M = workspace.Music.DistortionSoundEffect
            M.Level = v
    
        end,
     })

     local Section = Tab:CreateSection("Equalizer") 

     local Input = Tab:CreateInput({
        Name = "High Gain",
        CurrentValue = "",
        PlaceholderText = "0",
        RemoveTextAfterFocusLost = false,
        Flag = "Input1",
        Callback = function(Text)
            local M = workspace.Music.EqualizerSoundEffect
            M.HighGain = Text
        end,
     })

     local Slider = Tab:CreateSlider({
        Name = "High Gain",
        Range = {0, 10},
        Increment = 0.01,
        Suffix = "Amount",
        CurrentValue = 0,
        Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(v)
            local M = workspace.Music.EqualizerSoundEffect
            M.HighGain = v
    
        end,
     })

     local Input = Tab:CreateInput({
        Name = "Low Gain (Bass)",
        CurrentValue = "",
        PlaceholderText = "0",
        RemoveTextAfterFocusLost = false,
        Flag = "Input1",
        Callback = function(Text)
            local M = workspace.Music.EqualizerSoundEffect
            M.LowGain = Text
        end,
     })

     local Slider = Tab:CreateSlider({
        Name = "Low Gain (Bass)",
        Range = {0, 10},
        Increment = 0.01,
        Suffix = "Amount",
        CurrentValue = 0,
        Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(v)
            local M = workspace.Music.EqualizerSoundEffect
            M.LowGain = v
    
        end,
     })

     local Input = Tab:CreateInput({
        Name = "Mid Gain",
        CurrentValue = "",
        PlaceholderText = "0",
        RemoveTextAfterFocusLost = false,
        Flag = "Input1",
        Callback = function(Text)
            local M = workspace.Music.EqualizerSoundEffect
            M.MidGain = Text
        end,
     })

     local Slider = Tab:CreateSlider({
        Name = "Mid Gain",
        Range = {0, 10},
        Increment = 0.01,
        Suffix = "Amount",
        CurrentValue = 0,
        Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(v)
            local M = workspace.Music.EqualizerSoundEffect
            M.MidGain = v
    
        end,
     })

     local Section = Tab:CreateSection("Pitch")

     local Input = Tab:CreateInput({
        Name = "Pitch",
        CurrentValue = "",
        PlaceholderText = "0",
        RemoveTextAfterFocusLost = false,
        Flag = "Input1",
        Callback = function(Text)
            local M = workspace.Music.PitchShiftSoundEffect
            M.Octave = Text
        end,
     })
     
     local Slider = Tab:CreateSlider({
        Name = "Pitch",
        Range = {0, 12},
        Increment = 0.01,
        Suffix = "Amount",
        CurrentValue = 1,
        Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(v)
            local M = workspace.Music.PitchShiftSoundEffect
            M.Octave = v
    
        end,
     })

     local Input = Tab:CreateInput({
        Name = "Priority",
        CurrentValue = "",
        PlaceholderText = "0",
        RemoveTextAfterFocusLost = false,
        Flag = "Input1",
        Callback = function(Text)
            local M = workspace.Music.PitchShiftSoundEffect
            M.Priority = Text
        end,
     })

     local Slider = Tab:CreateSlider({
        Name = "Priority",
        Range = {0, 5},
        Increment = 0.01,
        Suffix = "Amount",
        CurrentValue = 0,
        Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(v)
            local M = workspace.Music.PitchShiftSoundEffect
            M.Priority = v
    
        end,
     })

     
      

       local Section = Tab:CreateSection("Visualizers") 

       local Button = Tab:CreateButton({
        Name = "FOV Visualizer",
        Callback = function()


    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")

    local player = Players.LocalPlayer
    local camera = workspace.CurrentCamera

-- Reference your sound instance in the workspace.
    local sound = workspace:WaitForChild("Music")

-- Configuration variables
local BASE_FOV = 90           -- Default Field of View.
local MAX_EXTRA_FOV = 120      -- Maximum additional FOV.
local TWEEN_TIME = 0.1        -- Tween duration.
local SCALING_FACTOR = 35      -- Factor to scale bass value (adjust as needed).

-- Function to get a value representing bass
    local function getBassValue()
    local spectrumData
    local success = pcall(function()
        spectrumData = sound:GetSpectrumData()
    end)
    
    if not success or not spectrumData or #spectrumData == 0 then
        -- Fallback to overall loudness if spectrum data is unavailable.
        return sound.PlaybackLoudness
    end

    -- Use the first 20% of bins (bass frequencies)
    local bassCount = math.max(1, math.floor(#spectrumData * 0.2))
    local bassSum = 0
    for i = 1, bassCount do
        bassSum = bassSum + spectrumData[i]
    end
    local averageBass = bassSum / bassCount
    return averageBass
end

-- Function to update the camera's FOV based on bass data.
local function updateCameraFOV()
    local bassValue = getBassValue()
    -- Calculate additional FOV based on the bass value.
    local additionalFOV = math.clamp(bassValue / SCALING_FACTOR, 0, MAX_EXTRA_FOV)
    local targetFOV = BASE_FOV + additionalFOV

    local tween = TweenService:Create(
        camera, 
        TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 
        {FieldOfView = targetFOV}
    )
    tween:Play()
end

-- Update every frame.
RunService.RenderStepped:Connect(function()
    updateCameraFOV()
end)
        end,
})


 local Tab = Window:CreateTab("Chat", "message-circle")

 local Section = Tab:CreateSection("This thingy is for fast typing idk. If u click a button it sends a message on da button")
local Label = Tab:CreateLabel("I think some messages could get u banned. Im not responsible if u get banned. Also i recommend to use a modern chat anti-ban script", "message-circle-dashed")

 local Button = Tab:CreateButton({
    Name = "Why target???",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Why target???")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Hi",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Hi")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Bye bye 🤫🧏‍♂️",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Bye bye 🤫🧏‍♂️")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "...",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("...")
    end,
 })
 
 local Button = Tab:CreateButton({
    Name = "GET JUKED!!!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("GET JUKED!!!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "😭🙏",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("😭🙏")
    end,
 })


 local Button = Tab:CreateButton({
    Name = "targeter?",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Why target???")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "What did i do to you bro??",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("What did i do to you bro??")
    end,
 })

  local Button = Tab:CreateButton({
    Name = "BRO-",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("BRO-")
    end,
 })

    local Button = Tab:CreateButton({
    Name = "Why teamers bro...",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Why teamers bro...")
    end,
 })

    local Button = Tab:CreateButton({
    Name = "Teamer!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Teamer!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Leave me alone please... 😓😓😥",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Leave me alone please... 😓😓😥")
    end,
 })

    local Button = Tab:CreateButton({
    Name = "Yo bear wanna get freaky together?",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Yo bear wanna get freaky together?")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "STOP CHASING ME!!! CHASE SOMEONE ELSE!!!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("STOP CHASING ME!!! CHASE SOMEONE ELSE!!!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Yo chill... CHILL CHILL CHILL!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Yo chill... CHILL CHILL CHILL!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Bro chill",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Bro chill")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Chill out!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Chill out!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "STOP CHASING ME!!!!!!!!!!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("STOP CHASING ME!!!!!!!!!!")
    end,
 })


 local Button = Tab:CreateButton({
    Name = "AHHHHHHHHHHHHHHH!!!!!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("AHHHHHHHHHHHHHHH!!!!!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "STOP!!!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("STOP!!!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Hahaha cant get me!!! 😜",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Hahaha cant get me!!! 😜")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "This bear sucks lol",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("This bear sucks lol")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "The hell is that reach bro",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("The hell is that reach bro")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Have mercy pls",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Have mercy pls")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "No stop 😭🙏",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("No stop 😭🙏")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Wait!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Wait!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Wait... Let me talk.",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Wait... Let me talk.")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "I just wanna say something!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("I just wanna say something!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Let me say something.",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Let me say something.")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Well well well...",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Well well well...")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "NOOB!!!",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("NOOB!!!")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Skibidi Sigma",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("Skibidi Sigma")
    end,
 })

 local Button = Tab:CreateButton({
    Name = "This is like Ohio",
    Callback = function(Chat)
	local TextChatService = game:GetService("TextChatService")
    TextChatService.TextChannels.RBXGeneral:SendAsync("This is like Ohio")
    end,
 })
