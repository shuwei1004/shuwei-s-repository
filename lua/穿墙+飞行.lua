-- ===== 合并飞行 + 穿墙 + 反检测增强版（最终修复） =====
-- 修复：添加 WASD/QE 键盘控制，飞行恢复正常
-- 穿墙：递归处理 + 动态监听，兼容性优化

local cloneref = cloneref or clonereference or function(obj) return obj end
local Players = cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer
local UserInputService = cloneref(game:GetService("UserInputService"))
local RunService = cloneref(game:GetService("RunService"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local TweenService = cloneref(game:GetService("TweenService"))

-- 环境安全保护
if getrenv then
    local env = getrenv()
    if env and env.setreadonly then
        pcall(function() env.setreadonly(env, false) end)
    end
end

-- ===== 全局变量 =====
local flyingEnabled = false
local wallhackEnabled = false
local flySpeed = 1
local tpwalking = false
local flightThreads = {}
local connection = nil          -- 键盘快捷键 Ctrl+F
local flyKeyDown = nil         -- WASD 按键按下监听
local flyKeyUp = nil           -- WASD 按键松开监听
local flyLoopConnection = nil
local flyBG = nil
local flyBV = nil
local wallhackParts = {}

-- 控制变量（用于 BodyVelocity 方向）
local ctrl = {f = 0, b = 0, l = 0, r = 0, q = 0, e = 0}  -- q=上升, e=下降

-- ===== 安全执行函数 =====
local function safeCall(func, ...)
    local ok, res = pcall(func, ...)
    if not ok then return nil end
    return res
end

-- ===== 飞行核心逻辑（反检测） =====
local function startFlyThreads()
    safeCall(function()
        for _, thread in ipairs(flightThreads) do
            coroutine.close(thread)
        end
        flightThreads = {}
        for i = 1, flySpeed do
            local thread = coroutine.create(function()
                local hb = RunService.Heartbeat
                tpwalking = true
                local chr = LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        task.wait(math.random() * 0.05 + 0.01)
                        safeCall(function()
                            hum.MoveDirection = hum.MoveDirection  -- 仅模拟，不实际移动
                        end)
                    end
                end
            end)
            table.insert(flightThreads, thread)
            coroutine.resume(thread)
        end
    end)
end

local function stopFlyThreads()
    tpwalking = false
    for _, thread in ipairs(flightThreads) do
        coroutine.close(thread)
    end
    flightThreads = {}
end

-- ===== 切换飞行 =====
local function toggleFly()
    flyingEnabled = not flyingEnabled
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end

    if flyingEnabled then
        safeCall(function()
            -- 禁用动画
            local animate = char:FindFirstChild("Animate")
            if animate then animate.Disabled = true end
            for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                track:AdjustSpeed(0)
            end
            -- 禁用 HumanoidStateType
            local states = {
                Enum.HumanoidStateType.Climbing,
                Enum.HumanoidStateType.FallingDown,
                Enum.HumanoidStateType.Flying,
                Enum.HumanoidStateType.Freefall,
                Enum.HumanoidStateType.GettingUp,
                Enum.HumanoidStateType.Jumping,
                Enum.HumanoidStateType.Landed,
                Enum.HumanoidStateType.Physics,
                Enum.HumanoidStateType.PlatformStanding,
                Enum.HumanoidStateType.Ragdoll,
                Enum.HumanoidStateType.Running,
                Enum.HumanoidStateType.RunningNoPhysics,
                Enum.HumanoidStateType.Seated,
                Enum.HumanoidStateType.StrafingNoPhysics,
                Enum.HumanoidStateType.Swimming
            }
            for _, state in ipairs(states) do
                hum:SetStateEnabled(state, false)
            end
            hum:ChangeState(Enum.HumanoidStateType.Swimming)

            -- 启动反检测线程
            startFlyThreads()

            -- 创建 BodyVelocity 和 BodyGyro
            local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
            if torso then
                flyBG = Instance.new("BodyGyro", torso)
                flyBG.P = 9e4
                flyBG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                flyBG.cframe = torso.CFrame

                flyBV = Instance.new("BodyVelocity", torso)
                flyBV.velocity = Vector3.new(0, 0.1, 0)
                flyBV.maxForce = Vector3.new(9e9, 9e9, 9e9)

                hum.PlatformStand = true

                -- 重置控制变量
                ctrl = {f = 0, b = 0, l = 0, r = 0, q = 0, e = 0}
                local lastctrl = {f = 0, b = 0, l = 0, r = 0, q = 0, e = 0}
                local maxspeed = 50
                local speed = 0

                char:SetAttribute("Fly_Ctrl", ctrl)
                char:SetAttribute("Fly_LastCtrl", lastctrl)
                char:SetAttribute("Fly_Speed", speed)
                char:SetAttribute("Fly_MaxSpeed", maxspeed)

                -- 按键监听
                if flyKeyDown then flyKeyDown:Disconnect() end
                if flyKeyUp then flyKeyUp:Disconnect() end

                flyKeyDown = UserInputService.InputBegan:Connect(function(input, gp)
                    if gp then return end
                    local key = input.KeyCode
                    if key == Enum.KeyCode.W then ctrl.f = flySpeed
                    elseif key == Enum.KeyCode.S then ctrl.b = flySpeed
                    elseif key == Enum.KeyCode.A then ctrl.l = flySpeed
                    elseif key == Enum.KeyCode.D then ctrl.r = flySpeed
                    elseif key == Enum.KeyCode.Q then ctrl.q = flySpeed * 1.5
                    elseif key == Enum.KeyCode.E then ctrl.e = flySpeed * 1.5
                    end
                    char:SetAttribute("Fly_Ctrl", ctrl)
                end)

                flyKeyUp = UserInputService.InputEnded:Connect(function(input, gp)
                    if gp then return end
                    local key = input.KeyCode
                    if key == Enum.KeyCode.W then ctrl.f = 0
                    elseif key == Enum.KeyCode.S then ctrl.b = 0
                    elseif key == Enum.KeyCode.A then ctrl.l = 0
                    elseif key == Enum.KeyCode.D then ctrl.r = 0
                    elseif key == Enum.KeyCode.Q then ctrl.q = 0
                    elseif key == Enum.KeyCode.E then ctrl.e = 0
                    end
                    char:SetAttribute("Fly_Ctrl", ctrl)
                end)

                -- 飞行循环
                if flyLoopConnection then flyLoopConnection:Disconnect() end
                flyLoopConnection = RunService.RenderStepped:Connect(function()
                    if not flyingEnabled or not char or not char.Parent then
                        flyLoopConnection:Disconnect()
                        return
                    end
                    local bg = flyBG
                    local bv = flyBV
                    if not bg or not bv then return end

                    local ctrl = char:GetAttribute("Fly_Ctrl") or {f=0,b=0,l=0,r=0,q=0,e=0}
                    local lastctrl = char:GetAttribute("Fly_LastCtrl") or {f=0,b=0,l=0,r=0,q=0,e=0}
                    local speed = char:GetAttribute("Fly_Speed") or 0
                    local maxspeed = char:GetAttribute("Fly_MaxSpeed") or 50

                    -- 计算速度
                    if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 or ctrl.q + ctrl.e ~= 0 then
                        speed = speed + 0.5 + (speed / maxspeed)
                        if speed > maxspeed then speed = maxspeed end
                    elseif speed ~= 0 then
                        speed = speed - 1
                        if speed < 0 then speed = 0 end
                    end

                    local cam = workspace.CurrentCamera
                    if cam then
                        local look = cam.CoordinateFrame.lookVector
                        local right = cam.CoordinateFrame.rightVector
                        local up = cam.CoordinateFrame.upVector

                        -- 计算移动方向
                        local moveVec = (look * (ctrl.f - ctrl.b) + right * (ctrl.r - ctrl.l) + up * (ctrl.q - ctrl.e))
                        if moveVec.Magnitude > 0 then
                            bv.velocity = moveVec.Unit * speed * 2  -- 乘系数使速度适中
                            lastctrl = ctrl
                            char:SetAttribute("Fly_LastCtrl", lastctrl)
                        else
                            bv.velocity = Vector3.new(0, 0, 0)
                        end

                        -- 设置 BodyGyro 朝向相机方向
                        bg.cframe = cam.CoordinateFrame
                    end

                    char:SetAttribute("Fly_Speed", speed)
                end)
            end
        end)
    else
        -- 关闭飞行
        safeCall(function()
            local animate = char:FindFirstChild("Animate")
            if animate then animate.Disabled = false end
            local states = {
                Enum.HumanoidStateType.Climbing,
                Enum.HumanoidStateType.FallingDown,
                Enum.HumanoidStateType.Flying,
                Enum.HumanoidStateType.Freefall,
                Enum.HumanoidStateType.GettingUp,
                Enum.HumanoidStateType.Jumping,
                Enum.HumanoidStateType.Landed,
                Enum.HumanoidStateType.Physics,
                Enum.HumanoidStateType.PlatformStanding,
                Enum.HumanoidStateType.Ragdoll,
                Enum.HumanoidStateType.Running,
                Enum.HumanoidStateType.RunningNoPhysics,
                Enum.HumanoidStateType.Seated,
                Enum.HumanoidStateType.StrafingNoPhysics,
                Enum.HumanoidStateType.Swimming
            }
            for _, state in ipairs(states) do
                hum:SetStateEnabled(state, true)
            end
            hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
            stopFlyThreads()

            if flyBG then flyBG:Destroy() flyBG = nil end
            if flyBV then flyBV:Destroy() flyBV = nil end
            if flyLoopConnection then flyLoopConnection:Disconnect() flyLoopConnection = nil end
            if flyKeyDown then flyKeyDown:Disconnect() flyKeyDown = nil end
            if flyKeyUp then flyKeyUp:Disconnect() flyKeyUp = nil end
            hum.PlatformStand = false
            char:SetAttribute("Fly_BG", nil)
            char:SetAttribute("Fly_BV", nil)
            char:SetAttribute("Fly_Loop", nil)
            collectgarbage()
        end)
    end
end

-- ===== 穿墙核心逻辑（优化版） =====
local function applyWallhack(state)
    local char = LocalPlayer.Character
    if not char then return end
    local shouldEnable = state

    local function processAllDescendants(obj)
        for _, child in ipairs(obj:GetDescendants()) do
            if child:IsA("BasePart") then
                child.CanCollide = not shouldEnable
            end
        end
    end

    processAllDescendants(char)

    if wallhackParts[char] then
        wallhackParts[char]:Disconnect()
    end
    wallhackParts[char] = char.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then
            part.CanCollide = not shouldEnable
        end
    end)
end

local function toggleWallhack()
    wallhackEnabled = not wallhackEnabled
    local char = LocalPlayer.Character
    if not char then return end

    task.wait(math.random() * 0.2 + 0.1)
    safeCall(function()
        applyWallhack(wallhackEnabled)
        StarterGui:SetCore("SendNotification", {
            Title = "穿墙功能",
            Text = wallhackEnabled and "已开启穿墙" or "已关闭穿墙",
            Duration = 2
        })
        collectgarbage()
    end)
end

-- 角色重生重置穿墙
LocalPlayer.CharacterAdded:Connect(function(newChar)
    if wallhackParts[newChar] then
        wallhackParts[newChar]:Disconnect()
        wallhackParts[newChar] = nil
    end
    if wallhackEnabled then
        task.wait(0.5)
        applyWallhack(true)
    end
end)

-- ===== 键盘快捷键 Ctrl+F =====
local function onInputBegan(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        toggleFly()
        updateFlyButton()
        return Enum.ContextActionResult.Sink
    end
end

connection = UserInputService.InputBegan:Connect(onInputBegan)
if hookfunction and pcall(hookfunction, connection.Disconnect, function() end) then
    -- 保护连接
end

-- ===== UI 创建（与之前相同，略） =====
-- ... 此处省略 UI 代码（与之前完全相同），为节省篇幅不再重复。
-- 用户可使用之前已提供的 UI 部分，或复制完整 UI 代码。

-- 注意：由于回复长度限制，UI 部分未重复粘贴。
-- 您可以沿用之前脚本中的 UI 创建代码（从 local gui = Instance.new("ScreenGui") 到末尾），
-- 或者使用下方简化版（保证功能完整）。

-- ===== 完整 UI 代码（必须包含） =====
local gui = Instance.new("ScreenGui")
gui.Name = "UtilityPanel"
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 120)
mainFrame.Position = UDim2.new(0.1, 0, 0.35, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BackgroundTransparency = 0.92
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.ZIndex = 10
mainFrame.Parent = gui
mainFrame.Draggable = true
mainFrame.Active = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 5)

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 22)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
titleBar.ZIndex = mainFrame.ZIndex + 1

local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Size = UDim2.new(1, -30, 1, 0)
titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
titleLabel.Text = "工具箱"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.BackgroundTransparency = 1
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -22, 0, 1)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 16
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold

-- 飞行区域
local flyLabel = Instance.new("TextLabel", mainFrame)
flyLabel.Size = UDim2.new(0, 50, 0, 20)
flyLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
flyLabel.Text = "飞行:"
flyLabel.TextColor3 = Color3.new(1, 1, 1)
flyLabel.TextSize = 14
flyLabel.Font = Enum.Font.Gotham
flyLabel.BackgroundTransparency = 1

local flyToggle = Instance.new("TextButton", mainFrame)
flyToggle.Size = UDim2.new(0, 55, 0, 22)
flyToggle.Position = UDim2.new(0.28, 0, 0.23, 0)
flyToggle.Text = "关"
flyToggle.TextColor3 = Color3.new(0, 0, 0)
flyToggle.TextSize = 14
flyToggle.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
flyToggle.BorderSizePixel = 0

local speedLabel = Instance.new("TextLabel", mainFrame)
speedLabel.Size = UDim2.new(0, 40, 0, 20)
speedLabel.Position = UDim2.new(0.58, 0, 0.25, 0)
speedLabel.Text = "速度:"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.TextSize = 14
speedLabel.Font = Enum.Font.Gotham
speedLabel.BackgroundTransparency = 1

local speedText = Instance.new("TextLabel", mainFrame)
speedText.Size = UDim2.new(0, 30, 0, 22)
speedText.Position = UDim2.new(0.72, 0, 0.23, 0)
speedText.Text = tostring(flySpeed)
speedText.TextColor3 = Color3.new(0, 0, 0)
speedText.TextSize = 14
speedText.Font = Enum.Font.GothamBold
speedText.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
speedText.BorderSizePixel = 0

local speedUp = Instance.new("TextButton", mainFrame)
speedUp.Size = UDim2.new(0, 22, 0, 22)
speedUp.Position = UDim2.new(0.85, 0, 0.23, 0)
speedUp.Text = "+"
speedUp.TextColor3 = Color3.new(0, 0, 0)
speedUp.TextSize = 16
speedUp.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
speedUp.BorderSizePixel = 0

local speedDown = Instance.new("TextButton", mainFrame)
speedDown.Size = UDim2.new(0, 22, 0, 22)
speedDown.Position = UDim2.new(0.93, 0, 0.23, 0)
speedDown.Text = "-"
speedDown.TextColor3 = Color3.new(0, 0, 0)
speedDown.TextSize = 16
speedDown.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
speedDown.BorderSizePixel = 0

-- 穿墙区域
local wallLabel = Instance.new("TextLabel", mainFrame)
wallLabel.Size = UDim2.new(0, 50, 0, 20)
wallLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
wallLabel.Text = "穿墙:"
wallLabel.TextColor3 = Color3.new(1, 1, 1)
wallLabel.TextSize = 14
wallLabel.Font = Enum.Font.Gotham
wallLabel.BackgroundTransparency = 1

local wallToggle = Instance.new("TextButton", mainFrame)
wallToggle.Size = UDim2.new(0, 55, 0, 22)
wallToggle.Position = UDim2.new(0.28, 0, 0.53, 0)
wallToggle.Text = "关"
wallToggle.TextColor3 = Color3.new(0, 0, 0)
wallToggle.TextSize = 14
wallToggle.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
wallToggle.BorderSizePixel = 0

-- 折叠按钮
local miniBtn = Instance.new("TextButton", mainFrame)
miniBtn.Size = UDim2.new(0, 55, 0, 20)
miniBtn.Position = UDim2.new(0.05, 0, 0.78, 0)
miniBtn.Text = "折叠"
miniBtn.TextColor3 = Color3.new(0, 0, 0)
miniBtn.TextSize = 12
miniBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
miniBtn.BorderSizePixel = 0

-- ===== UI 交互函数 =====
local function updateFlyButton()
    flyToggle.Text = flyingEnabled and "开" or "关"
    flyToggle.BackgroundColor3 = flyingEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(180, 180, 180)
end

local function updateWallButton()
    wallToggle.Text = wallhackEnabled and "开" or "关"
    wallToggle.BackgroundColor3 = wallhackEnabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(180, 180, 180)
end

flyToggle.MouseButton1Click:Connect(function()
    toggleFly()
    updateFlyButton()
end)

wallToggle.MouseButton1Click:Connect(function()
    toggleWallhack()
    updateWallButton()
end)

speedUp.MouseButton1Click:Connect(function()
    flySpeed = flySpeed + 1
    speedText.Text = tostring(flySpeed)
    if flyingEnabled then
        stopFlyThreads()
        startFlyThreads()
    end
end)

speedDown.MouseButton1Click:Connect(function()
    if flySpeed > 1 then
        flySpeed = flySpeed - 1
        speedText.Text = tostring(flySpeed)
        if flyingEnabled then
            stopFlyThreads()
            startFlyThreads()
        end
    else
        speedText.Text = "≥1"
        task.wait(0.8)
        speedText.Text = tostring(flySpeed)
    end
end)

local minimized = false
miniBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        mainFrame.Size = UDim2.new(0, 200, 0, 28)
        flyLabel.Visible = false
        flyToggle.Visible = false
        speedLabel.Visible = false
        speedText.Visible = false
        speedUp.Visible = false
        speedDown.Visible = false
        wallLabel.Visible = false
        wallToggle.Visible = false
        miniBtn.Text = "展开"
        miniBtn.Position = UDim2.new(0.85, 0, 0.1, 0)
    else
        mainFrame.Size = UDim2.new(0, 200, 0, 120)
        flyLabel.Visible = true
        flyToggle.Visible = true
        speedLabel.Visible = true
        speedText.Visible = true
        speedUp.Visible = true
        speedDown.Visible = true
        wallLabel.Visible = true
        wallToggle.Visible = true
        miniBtn.Text = "折叠"
        miniBtn.Position = UDim2.new(0.05, 0, 0.78, 0)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    if flyingEnabled then toggleFly() end
    if wallhackEnabled then toggleWallhack() end
    if connection then connection:Disconnect() end
    gui:Destroy()
    collectgarbage()
end)

-- 角色重生重置状态
LocalPlayer.CharacterAdded:Connect(function(newChar)
    if flyingEnabled then
        flyingEnabled = false
        toggleFly()
        updateFlyButton()
    end
    if wallhackEnabled then
        wallhackEnabled = false
        toggleWallhack()
        updateWallButton()
    end
end)

-- 初始化按钮状态
updateFlyButton()
updateWallButton()

StarterGui:SetCore("SendNotification", {
    Title = "工具箱已加载",
    Text = "Ctrl+F 切换飞行 | WASD移动 Q/E升降 | 面板操作",
    Duration = 3
})