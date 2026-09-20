-- 穿墙脚本（黑白风格UI）
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 1. 创建主UI容器
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "WallhackGui"
MainGui.Parent = PlayerGui
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGui.ResetOnSpawn = false

-- 2. 创建主面板
local MainFrame = Instance.new("Frame")
MainFrame.Parent = MainGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- 白色背景
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0) -- 黑色边框
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0) -- 屏幕左侧中间位置
MainFrame.Size = UDim2.new(0, 180, 0, 80) -- 面板尺寸
MainFrame.Draggable = true -- 支持拖动
MainFrame.Active = true

-- 3. 创建功能按钮与文本
-- 标题文本
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- 黑色背景
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文字
TitleLabel.Size = UDim2.new(1, 0, 0, 25)
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.Text = "穿墙功能 V1"
TitleLabel.TextSize = 16

-- 开启/关闭穿墙按钮
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.Name = "ToggleWallhack"
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- 浅灰背景
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0) -- 黑色文字
ToggleButton.Position = UDim2.new(0.05, 0, 0.35, 0)
ToggleButton.Size = UDim2.new(0.9, 0, 0, 25)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = "开启穿墙"
ToggleButton.TextSize = 14

-- 折叠/展开按钮
local MiniButton = Instance.new("TextButton")
MiniButton.Parent = MainFrame
MiniButton.Name = "Minimize"
MiniButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150) -- 中灰背景
MiniButton.TextColor3 = Color3.fromRGB(0, 0, 0) -- 黑色文字
MiniButton.Position = UDim2.new(0.05, 0, 0.75, 0)
MiniButton.Size = UDim2.new(0.42, 0, 0, 20)
MiniButton.Font = Enum.Font.SourceSans
MiniButton.Text = "折叠"
MiniButton.TextSize = 12

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Name = "Close"
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- 黑色背景
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文字
CloseButton.Position = UDim2.new(0.53, 0, 0.75, 0)
CloseButton.Size = UDim2.new(0.42, 0, 0, 20)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "关闭"
CloseButton.TextSize = 12

-- 4. 穿墙核心逻辑变量
local isWallhackOn = false -- 穿墙状态
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- 5. 角色加载监听（重生后重新绑定）
LocalPlayer.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    -- 重生后自动关闭穿墙（避免异常）
    if isWallhackOn then
        toggleWallhack()
    end
end)

-- 6. 穿墙功能核心函数
local function toggleWallhack()
    isWallhackOn = not isWallhackOn
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso") -- 兼容R6/R15
    
    if isWallhackOn then
        -- 开启穿墙：禁用碰撞 + 提示
        ToggleButton.Text = "关闭穿墙"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100) -- 红色提示
        
        -- 禁用角色所有碰撞体
        if rootPart then rootPart.CanCollide = false end
        if torso then torso.CanCollide = false end
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Name ~= "Torso" and part.Name ~= "UpperTorso" then
                part.CanCollide = false
            end
        end
        
        -- 发送开启通知
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "穿墙功能",
            Text = "已开启穿墙，注意场景兼容性",
            Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
            Duration = 3
        })
    else
        -- 关闭穿墙：恢复碰撞 + 提示
        ToggleButton.Text = "开启穿墙"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- 恢复浅灰
        
        -- 恢复角色所有碰撞体
        if rootPart then rootPart.CanCollide = true end
        if torso then torso.CanCollide = true end
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        
        -- 发送关闭通知
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "穿墙功能",
            Text = "已关闭穿墙",
            Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
            Duration = 3
        })
    end
end

-- 7. UI按钮事件绑定
-- 开启/关闭穿墙
ToggleButton.MouseButton1Click:Connect(toggleWallhack)

-- 折叠/展开面板
MiniButton.MouseButton1Click:Connect(function()
    local isMinimized = MiniButton.Text == "展开"
    if isMinimized then
        -- 展开：恢复面板尺寸和显示
        MainFrame.Size = UDim2.new(0, 180, 0, 80)
        ToggleButton.Visible = true
        MiniButton.Text = "折叠"
    else
        -- 折叠：缩小面板，隐藏功能按钮
        MainFrame.Size = UDim2.new(0, 180, 0, 25)
        ToggleButton.Visible = false
        MiniButton.Text = "展开"
    end
end)

-- 关闭面板
CloseButton.MouseButton1Click:Connect(function()
    MainGui:Destroy() -- 彻底删除UI
    -- 关闭穿墙（避免残留）
    if isWallhackOn then
        toggleWallhack()
    end
end)

-- 8. 初始通知
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "穿墙UI已加载",
    Text = "点击面板按钮使用功能",
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
    Duration = 4
})