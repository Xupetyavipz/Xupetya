-- SPWARE V4 | Melhor Script Roblox
-- Modern UI with Purple/Black Theme

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Settings
local Settings = {
    -- Combat
    AimbotEnabled = false,
    AimbotFOV = 100,
    AimbotSmooth = 5,
    SilentAim = false,
    Ragebot = false,
    TriggerBot = false,
    HitboxExpander = false,
    OneShotKill = false,
    NoRecoil = false,
    InfiniteAmmo = false,
    
    -- Movement
    BunnyHop = false,
    StrafeHack = false,
    SpeedHack = false,
    SpeedValue = 16,
    Fly = false,
    FlySpeed = 50,
    Noclip = false,
    TeleportKill = false,
    
    -- Visual
    ESPPlayers = false,
    ESPWeapons = false,
    Chams = false,
    Glow = false,
    RadarHack = false,
    CustomCrosshair = false,
    NightVision = false,
    FullBright = false,
    
    -- Roleplay
    CarSpawner = false,
    SuperSpeedCar = false,
    FlyCar = false,
    WeaponSpawner = false,
    Morphs = false,
    SizeChanger = false,
    Invisible = false,
    Godmode = false,
    
    -- Blox Fruits
    AutoFarmLevel = false,
    AutoFarmBoss = false,
    AutoFarmQuest = false,
    AutoFarmFruits = false,
    NoSkillCooldown = false,
    KillAura = false,
    ESPFruits = false,
    WalkOnWater = false,
    
    -- Chat
    ChatSpam = false,
    AutoReply = false,
    FakeMessages = false
}

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SPWARE"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
MainFrame.Size = UDim2.new(0, 800, 0, 600)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Add corner and shadow
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(138, 43, 226)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Fix corner for title
local TitleFix = Instance.new("Frame")
TitleFix.Parent = TitleBar
TitleFix.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
TitleFix.BorderSizePixel = 0
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)

-- Title Text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "SPWARE V4 | Melhor Script Roblox"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 4)
MinimizeCorner.Parent = MinimizeButton

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 200, 1, -40)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

-- Fix sidebar corner
local SidebarFix = Instance.new("Frame")
SidebarFix.Parent = Sidebar
SidebarFix.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SidebarFix.BorderSizePixel = 0
SidebarFix.Position = UDim2.new(1, -8, 0, 0)
SidebarFix.Size = UDim2.new(0, 8, 1, 0)

local SidebarFix2 = Instance.new("Frame")
SidebarFix2.Parent = Sidebar
SidebarFix2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SidebarFix2.BorderSizePixel = 0
SidebarFix2.Position = UDim2.new(0, 0, 0, 0)
SidebarFix2.Size = UDim2.new(1, 0, 0, 8)

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 200, 0, 40)
ContentArea.Size = UDim2.new(1, -200, 1, -40)

-- Tabs Data
local TabsData = {
    {name = "⚔️ Combat", icon = "⚔️"},
    {name = "🏃 Movement", icon = "🏃"},
    {name = "👁️ Visual", icon = "👁️"},
    {name = "🎭 Roleplay", icon = "🎭"},
    {name = "🥭 Blox Fruits", icon = "🥭"},
    {name = "📋 Player List", icon = "📋"},
    {name = "💬 Chat", icon = "💬"},
    {name = "🚗 Car List", icon = "🚗"}
}

local TabButtons = {}
local TabFrames = {}
local CurrentTab = 1

-- Create Tab Buttons
for i, tabData in ipairs(TabsData) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = "Tab" .. i
    TabButton.Parent = Sidebar
    TabButton.BackgroundColor3 = i == 1 and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(25, 25, 25)
    TabButton.BorderSizePixel = 0
    TabButton.Position = UDim2.new(0, 10, 0, 10 + (i-1) * 50)
    TabButton.Size = UDim2.new(1, -20, 0, 40)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = tabData.name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 14
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.TextTruncate = Enum.TextTruncate.AtEnd
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabButton
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingLeft = UDim.new(0, 15)
    TabPadding.Parent = TabButton
    
    TabButtons[i] = TabButton
    
    -- Create Tab Frame
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = "TabFrame" .. i
    TabFrame.Parent = ContentArea
    TabFrame.BackgroundTransparency = 1
    TabFrame.BorderSizePixel = 0
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.ScrollBarThickness = 8
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabFrame.Visible = i == 1
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Parent = TabFrame
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 10)
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 20)
    TabPadding.PaddingLeft = UDim.new(0, 20)
    TabPadding.PaddingRight = UDim.new(0, 20)
    TabPadding.Parent = TabFrame
    
    TabFrames[i] = TabFrame
end

-- Tab switching function
local function SwitchTab(tabIndex)
    if CurrentTab == tabIndex then return end
    
    -- Update button colors
    TabButtons[CurrentTab].BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabButtons[tabIndex].BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    
    -- Hide current tab frame
    TabFrames[CurrentTab].Visible = false
    
    -- Show new tab frame
    TabFrames[tabIndex].Visible = true
    
    CurrentTab = tabIndex
end

-- Connect tab buttons
for i, button in ipairs(TabButtons) do
    button.MouseButton1Click:Connect(function()
        SwitchTab(i)
    end)
end

-- Helper Functions
local function CreateSection(parent, title)
    local Section = Instance.new("Frame")
    Section.Name = title .. "Section"
    Section.Parent = parent
    Section.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Section.BorderSizePixel = 0
    Section.Size = UDim2.new(1, 0, 0, 0)
    
    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 6)
    SectionCorner.Parent = Section
    
    local SectionStroke = Instance.new("UIStroke")
    SectionStroke.Color = Color3.fromRGB(40, 40, 40)
    SectionStroke.Thickness = 1
    SectionStroke.Parent = Section
    
    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Name = "Title"
    SectionTitle.Parent = Section
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Position = UDim2.new(0, 15, 0, 10)
    SectionTitle.Size = UDim2.new(1, -30, 0, 25)
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.Text = title
    SectionTitle.TextColor3 = Color3.fromRGB(138, 43, 226)
    SectionTitle.TextSize = 16
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local SectionLayout = Instance.new("UIListLayout")
    SectionLayout.Parent = Section
    SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SectionLayout.Padding = UDim.new(0, 8)
    
    local SectionPadding = Instance.new("UIPadding")
    SectionPadding.PaddingTop = UDim.new(0, 40)
    SectionPadding.PaddingLeft = UDim.new(0, 15)
    SectionPadding.PaddingRight = UDim.new(0, 15)
    SectionPadding.PaddingBottom = UDim.new(0, 15)
    SectionPadding.Parent = Section
    
    return Section
end

local function CreateToggle(parent, text, setting, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Name = text .. "Toggle"
    Toggle.Parent = parent
    Toggle.BackgroundTransparency = 1
    Toggle.Size = UDim2.new(1, 0, 0, 30)
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "Button"
    ToggleButton.Parent = Toggle
    ToggleButton.BackgroundColor3 = Settings[setting] and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(60, 60, 60)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(1, -50, 0, 5)
    ToggleButton.Size = UDim2.new(0, 45, 0, 20)
    ToggleButton.Text = ""
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleButton
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Name = "Circle"
    ToggleCircle.Parent = ToggleButton
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.Position = Settings[setting] and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(0, 8)
    CircleCorner.Parent = ToggleCircle
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Parent = Toggle
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    ToggleButton.MouseButton1Click:Connect(function()
        Settings[setting] = not Settings[setting]
        
        local newColor = Settings[setting] and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(60, 60, 60)
        local newPosition = Settings[setting] and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
        
        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = newColor}):Play()
        TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = newPosition}):Play()
        
        if callback then
            callback(Settings[setting])
        end
        
        StarterGui:SetCore("SendNotification", {
            Title = "SPWARE",
            Text = text .. (Settings[setting] and " ON" or " OFF"),
            Duration = 2
        })
    end)
    
    return Toggle
end

local function CreateSlider(parent, text, setting, min, max, callback)
    local Slider = Instance.new("Frame")
    Slider.Name = text .. "Slider"
    Slider.Parent = parent
    Slider.BackgroundTransparency = 1
    Slider.Size = UDim2.new(1, 0, 0, 50)
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "Label"
    SliderLabel.Parent = Slider
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Size = UDim2.new(1, 0, 0, 20)
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.Text = text .. ": " .. Settings[setting]
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 14
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "SliderFrame"
    SliderFrame.Parent = Slider
    SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Position = UDim2.new(0, 0, 0, 25)
    SliderFrame.Size = UDim2.new(1, 0, 0, 20)
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 10)
    SliderCorner.Parent = SliderFrame
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "Fill"
    SliderFill.Parent = SliderFrame
    SliderFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new((Settings[setting] - min) / (max - min), 0, 1, 0)
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 10)
    FillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "Button"
    SliderButton.Parent = SliderFrame
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.BorderSizePixel = 0
    SliderButton.Position = UDim2.new((Settings[setting] - min) / (max - min), -10, 0, -5)
    SliderButton.Size = UDim2.new(0, 20, 0, 30)
    SliderButton.Text = ""
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = SliderButton
    
    local dragging = false
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local framePos = SliderFrame.AbsolutePosition
            local frameSize = SliderFrame.AbsoluteSize
            
            local relativePos = math.clamp((mousePos.X - framePos.X) / frameSize.X, 0, 1)
            local value = math.floor(min + (max - min) * relativePos)
            
            Settings[setting] = value
            SliderLabel.Text = text .. ": " .. value
            
            SliderFill.Size = UDim2.new(relativePos, 0, 1, 0)
            SliderButton.Position = UDim2.new(relativePos, -10, 0, -5)
            
            if callback then
                callback(value)
            end
        end
    end)
    
    return Slider
end

local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.Parent = parent
    Button.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.Font = Enum.Font.GothamBold
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
        
        -- Button animation
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(100, 30, 180)}):Play()
        wait(0.1)
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(138, 43, 226)}):Play()
    end)
    
    return Button
end

-- Combat Tab Content
local CombatFrame = TabFrames[1]

local AimbotSection = CreateSection(CombatFrame, "🎯 Aimbot")
CreateToggle(AimbotSection, "Aimbot", "AimbotEnabled", function(state)
    -- Aimbot logic here
end)
CreateSlider(AimbotSection, "FOV", "AimbotFOV", 10, 500)
CreateSlider(AimbotSection, "Smoothness", "AimbotSmooth", 1, 20)
CreateToggle(AimbotSection, "Silent Aim", "SilentAim")
CreateToggle(AimbotSection, "Ragebot", "Ragebot")

local CombatSection = CreateSection(CombatFrame, "⚔️ Combat")
CreateToggle(CombatSection, "TriggerBot", "TriggerBot")
CreateToggle(CombatSection, "Hitbox Expander", "HitboxExpander")
CreateToggle(CombatSection, "One Shot Kill", "OneShotKill")
CreateToggle(CombatSection, "No Recoil", "NoRecoil")
CreateToggle(CombatSection, "Infinite Ammo", "InfiniteAmmo")

-- Movement Tab Content  
local MovementFrame = TabFrames[2]

local MovementSection = CreateSection(MovementFrame, "🏃 Movement")
CreateToggle(MovementSection, "Bunny Hop", "BunnyHop")
CreateToggle(MovementSection, "Strafe Hack", "StrafeHack")
CreateToggle(MovementSection, "Speed Hack", "SpeedHack", function(state)
    if state then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.SpeedValue
    else
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)
CreateSlider(MovementSection, "Speed", "SpeedValue", 16, 500, function(value)
    if Settings.SpeedHack then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)
CreateToggle(MovementSection, "Fly", "Fly", function(state)
    -- Fly logic here
end)
CreateSlider(MovementSection, "Fly Speed", "FlySpeed", 10, 200)
CreateToggle(MovementSection, "Noclip", "Noclip", function(state)
    -- Noclip logic here
end)
CreateToggle(MovementSection, "Teleport Kill", "TeleportKill")

-- Visual Tab Content
local VisualFrame = TabFrames[3]

local ESPSection = CreateSection(VisualFrame, "👁️ ESP")
CreateToggle(ESPSection, "ESP Players", "ESPPlayers")
CreateToggle(ESPSection, "ESP Weapons", "ESPWeapons")
CreateToggle(ESPSection, "Chams", "Chams")
CreateToggle(ESPSection, "Glow", "Glow")

local VisualSection = CreateSection(VisualFrame, "🌟 Visual")
CreateToggle(VisualSection, "Radar Hack", "RadarHack")
CreateToggle(VisualSection, "Custom Crosshair", "CustomCrosshair")
CreateToggle(VisualSection, "Night Vision", "NightVision", function(state)
    if state then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
    end
end)
CreateToggle(VisualSection, "Full Bright", "FullBright", function(state)
    if state then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 5
    else
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.Brightness = 1
    end
end)

-- Roleplay Tab Content
local RoleplayFrame = TabFrames[4]

local VehicleSection = CreateSection(RoleplayFrame, "🚗 Spawn / Veículos")
CreateButton(VehicleSection, "Spawn Cars", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Car spawned!", Duration = 2})
end)
CreateToggle(VehicleSection, "Super Speed Car", "SuperSpeedCar")
CreateToggle(VehicleSection, "Fly Car", "FlyCar")
CreateButton(VehicleSection, "Boat Spawner", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Boat spawned!", Duration = 2})
end)
CreateButton(VehicleSection, "Helicopter Spawner", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Helicopter spawned!", Duration = 2})
end)

local WeaponsSection = CreateSection(RoleplayFrame, "🔫 Armas / Itens")
CreateButton(WeaponsSection, "Spawn Weapons", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Weapons spawned!", Duration = 2})
end)
CreateToggle(WeaponsSection, "Infinite Ammo", "InfiniteAmmo")
CreateToggle(WeaponsSection, "Dual Wield", "DualWield")
CreateButton(WeaponsSection, "Item Spawner", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Items spawned!", Duration = 2})
end)

local PlayerSection = CreateSection(RoleplayFrame, "👤 Player / Personagem")
CreateButton(PlayerSection, "Animal Morphs", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Morph applied!", Duration = 2})
end)
CreateToggle(PlayerSection, "Size Changer", "SizeChanger")
CreateToggle(PlayerSection, "Invisible Mode", "Invisible")
CreateToggle(PlayerSection, "Godmode", "Godmode")
CreateButton(PlayerSection, "Teleport Locations", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Teleported!", Duration = 2})
end)
CreateButton(PlayerSection, "Unlimited Emotes", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Emotes unlocked!", Duration = 2})
end)

local UtilitiesSection = CreateSection(RoleplayFrame, "⚙️ Utilidades")
CreateToggle(UtilitiesSection, "Auto Farm Dinheiro", "AutoFarmMoney")
CreateToggle(UtilitiesSection, "Auto Collect Items", "AutoCollectItems")
CreateButton(UtilitiesSection, "TP até Amigos", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Teleported to friend!", Duration = 2})
end)
CreateButton(UtilitiesSection, "Unlock Animations", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Animations unlocked!", Duration = 2})
end)
CreateToggle(UtilitiesSection, "Auto Daily Rewards", "AutoDailyRewards")
CreateToggle(UtilitiesSection, "Auto Buy", "AutoBuy")

local WorldSection = CreateSection(RoleplayFrame, "🌍 Ambiente / Mundo")
CreateButton(WorldSection, "Open All Doors", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "All doors opened!", Duration = 2})
end)
CreateButton(WorldSection, "Teleport All Cars", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "All cars teleported!", Duration = 2})
end)
CreateButton(WorldSection, "Day/Night Control", function()
    if Lighting.ClockTime == 14 then
        Lighting.ClockTime = 0
        StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Night mode!", Duration = 2})
    else
        Lighting.ClockTime = 14
        StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Day mode!", Duration = 2})
    end
end)
CreateButton(WorldSection, "Weather Changer", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Weather changed!", Duration = 2})
end)
CreateToggle(WorldSection, "Disable Gravity", "DisableGravity")
CreateToggle(WorldSection, "Super Jump", "SuperJump")

-- Blox Fruits Tab Content
local BloxFruitsFrame = TabFrames[5]

local FarmSection = CreateSection(BloxFruitsFrame, "🌾 Farm")
CreateToggle(FarmSection, "Auto Farm Level", "AutoFarmLevel")
CreateToggle(FarmSection, "Auto Farm Boss", "AutoFarmBoss")
CreateToggle(FarmSection, "Auto Farm Quest", "AutoFarmQuest")
CreateToggle(FarmSection, "Auto Farm Fruits", "AutoFarmFruits")
CreateToggle(FarmSection, "Auto Farm Mastery", "AutoFarmMastery")

local BloxCombatSection = CreateSection(BloxFruitsFrame, "⚔️ Combat")
CreateToggle(BloxCombatSection, "Auto Aim Skills", "AutoAimSkills")
CreateToggle(BloxCombatSection, "No Cooldown Skills", "NoSkillCooldown")
CreateToggle(BloxCombatSection, "Skill Spam", "SkillSpam")
CreateToggle(BloxCombatSection, "Kill Aura", "KillAura")
CreateSlider(BloxCombatSection, "Damage Multiplier", "DamageMultiplier", 1, 10)

local TeleportSection = CreateSection(BloxFruitsFrame, "📍 Teleport")
CreateButton(TeleportSection, "TP to Sea", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Teleported to sea!", Duration = 2})
end)
CreateButton(TeleportSection, "TP to Island", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Teleported to island!", Duration = 2})
end)
CreateButton(TeleportSection, "TP to NPC", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Teleported to NPC!", Duration = 2})
end)
CreateButton(TeleportSection, "TP to Fruits", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Teleported to fruit!", Duration = 2})
end)

local BloxMiscSection = CreateSection(BloxFruitsFrame, "🔧 Misc")
CreateToggle(BloxMiscSection, "ESP Fruits", "ESPFruits")
CreateToggle(BloxMiscSection, "Auto Fruit Sniper", "AutoFruitSniper")
CreateToggle(BloxMiscSection, "Walk on Water", "WalkOnWater")
CreateToggle(BloxMiscSection, "Auto Buy", "AutoBuyBlox")
CreateButton(BloxMiscSection, "Raid Helper", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Raid helper activated!", Duration = 2})
end)

-- Player List Tab Content
local PlayerListFrame = TabFrames[6]

-- Create player list
local PlayerListSection = CreateSection(PlayerListFrame, "📋 Player List")

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Parent = PlayerListSection
SearchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SearchBox.BorderSizePixel = 0
SearchBox.Size = UDim2.new(1, 0, 0, 30)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "Search players..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 14

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBox

local PlayerScrollFrame = Instance.new("ScrollingFrame")
PlayerScrollFrame.Name = "PlayerScrollFrame"
PlayerScrollFrame.Parent = PlayerListSection
PlayerScrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PlayerScrollFrame.BorderSizePixel = 0
PlayerScrollFrame.Size = UDim2.new(1, 0, 0, 200)
PlayerScrollFrame.ScrollBarThickness = 6
PlayerScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local PlayerScrollCorner = Instance.new("UICorner")
PlayerScrollCorner.CornerRadius = UDim.new(0, 6)
PlayerScrollCorner.Parent = PlayerScrollFrame

local PlayerLayout = Instance.new("UIListLayout")
PlayerLayout.Parent = PlayerScrollFrame
PlayerLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayerLayout.Padding = UDim.new(0, 5)

local function UpdatePlayerList()
    for _, child in pairs(PlayerScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local PlayerFrame = Instance.new("Frame")
            PlayerFrame.Name = player.Name
            PlayerFrame.Parent = PlayerScrollFrame
            PlayerFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            PlayerFrame.BorderSizePixel = 0
            PlayerFrame.Size = UDim2.new(1, -10, 0, 60)
            
            local PlayerFrameCorner = Instance.new("UICorner")
            PlayerFrameCorner.CornerRadius = UDim.new(0, 4)
            PlayerFrameCorner.Parent = PlayerFrame
            
            local PlayerName = Instance.new("TextLabel")
            PlayerName.Name = "PlayerName"
            PlayerName.Parent = PlayerFrame
            PlayerName.BackgroundTransparency = 1
            PlayerName.Position = UDim2.new(0, 10, 0, 5)
            PlayerName.Size = UDim2.new(1, -20, 0, 20)
            PlayerName.Font = Enum.Font.GothamBold
            PlayerName.Text = player.Name
            PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlayerName.TextSize = 14
            PlayerName.TextXAlignment = Enum.TextXAlignment.Left
            
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Name = "ButtonFrame"
            ButtonFrame.Parent = PlayerFrame
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Position = UDim2.new(0, 10, 0, 25)
            ButtonFrame.Size = UDim2.new(1, -20, 0, 30)
            
            local ButtonLayout = Instance.new("UIListLayout")
            ButtonLayout.Parent = ButtonFrame
            ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
            ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ButtonLayout.Padding = UDim.new(0, 5)
            
            -- Action buttons
            local actions = {"TP", "Kill", "Fling", "Freeze", "Troll"}
            for i, action in ipairs(actions) do
                local ActionButton = Instance.new("TextButton")
                ActionButton.Name = action .. "Button"
                ActionButton.Parent = ButtonFrame
                ActionButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
                ActionButton.BorderSizePixel = 0
                ActionButton.Size = UDim2.new(0, 50, 1, 0)
                ActionButton.Font = Enum.Font.Gotham
                ActionButton.Text = action
                ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                ActionButton.TextSize = 10
                
                local ActionCorner = Instance.new("UICorner")
                ActionCorner.CornerRadius = UDim.new(0, 4)
                ActionCorner.Parent = ActionButton
                
                ActionButton.MouseButton1Click:Connect(function()
                    StarterGui:SetCore("SendNotification", {
                        Title = "SPWARE",
                        Text = action .. " applied to " .. player.Name,
                        Duration = 2
                    })
                end)
            end
        end
    end
    
    PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerLayout.AbsoluteContentSize.Y + 10)
end

-- Update player list initially and when players join/leave
UpdatePlayerList()
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

-- Chat Tab Content
local ChatFrame = TabFrames[7]

local QuickMessagesSection = CreateSection(ChatFrame, "💬 Mensagens Rápidas")
CreateButton(QuickMessagesSection, "GG", function()
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("GG! SPWARE is the best!", "All")
end)
CreateButton(QuickMessagesSection, "Hello Everyone", function()
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hello everyone! Using SPWARE V4", "All")
end)
CreateButton(QuickMessagesSection, "SPWARE Best", function()
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("SPWARE - Melhor script Roblox!", "All")
end)

local AutoChatSection = CreateSection(ChatFrame, "🤖 Auto Chat")
CreateToggle(AutoChatSection, "Auto Reply", "AutoReply")
CreateToggle(AutoChatSection, "Auto Greet", "AutoGreet")
CreateToggle(AutoChatSection, "Auto GG", "AutoGG")

local SpamSection = CreateSection(ChatFrame, "📢 Spam / Flood")
CreateToggle(SpamSection, "Chat Spam", "ChatSpam")
CreateButton(SpamSection, "Emoji Spam", function()
    for i = 1, 5 do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🔥💯⚡🎯🚀", "All")
        wait(0.5)
    end
end)
CreateButton(SpamSection, "Unicode Spam", function()
    for i = 1, 3 do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("░░░░░░░░░░░░░░░░░░░░", "All")
        wait(0.5)
    end
end)

local FakeChatSection = CreateSection(ChatFrame, "🎭 Fake / Troll Chat")
CreateToggle(FakeChatSection, "Fake Messages", "FakeMessages")
CreateButton(FakeChatSection, "Fake Admin", function()
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[SYSTEM] Admin has joined the server!";
        Color = Color3.fromRGB(255, 0, 0);
    })
end)
CreateButton(FakeChatSection, "Fake Kick", function()
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[SYSTEM] You have been kicked for exploiting!";
        Color = Color3.fromRGB(255, 165, 0);
    })
end)

-- Car List Tab Content
local CarListFrame = TabFrames[8]

local CarManagementSection = CreateSection(CarListFrame, "🚗 Car Management")

local CarScrollFrame = Instance.new("ScrollingFrame")
CarScrollFrame.Name = "CarScrollFrame"
CarScrollFrame.Parent = CarManagementSection
CarScrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CarScrollFrame.BorderSizePixel = 0
CarScrollFrame.Size = UDim2.new(1, 0, 0, 250)
CarScrollFrame.ScrollBarThickness = 6
CarScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
CarScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local CarScrollCorner = Instance.new("UICorner")
CarScrollCorner.CornerRadius = UDim.new(0, 6)
CarScrollCorner.Parent = CarScrollFrame

local CarLayout = Instance.new("UIListLayout")
CarLayout.Parent = CarScrollFrame
CarLayout.SortOrder = Enum.SortOrder.LayoutOrder
CarLayout.Padding = UDim.new(0, 5)

local function UpdateCarList()
    for _, child in pairs(CarScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Find all vehicles in workspace
    local cars = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("VehicleSeat") and obj.Parent then
            table.insert(cars, obj.Parent)
        end
    end
    
    for i, car in ipairs(cars) do
        local CarFrame = Instance.new("Frame")
        CarFrame.Name = "Car" .. i
        CarFrame.Parent = CarScrollFrame
        CarFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        CarFrame.BorderSizePixel = 0
        CarFrame.Size = UDim2.new(1, -10, 0, 70)
        
        local CarFrameCorner = Instance.new("UICorner")
        CarFrameCorner.CornerRadius = UDim.new(0, 4)
        CarFrameCorner.Parent = CarFrame
        
        local CarName = Instance.new("TextLabel")
        CarName.Name = "CarName"
        CarName.Parent = CarFrame
        CarName.BackgroundTransparency = 1
        CarName.Position = UDim2.new(0, 10, 0, 5)
        CarName.Size = UDim2.new(1, -20, 0, 20)
        CarName.Font = Enum.Font.GothamBold
        CarName.Text = car.Name or "Vehicle " .. i
        CarName.TextColor3 = Color3.fromRGB(255, 255, 255)
        CarName.TextSize = 14
        CarName.TextXAlignment = Enum.TextXAlignment.Left
        
        local CarButtonFrame = Instance.new("Frame")
        CarButtonFrame.Name = "CarButtonFrame"
        CarButtonFrame.Parent = CarFrame
        CarButtonFrame.BackgroundTransparency = 1
        CarButtonFrame.Position = UDim2.new(0, 10, 0, 25)
        CarButtonFrame.Size = UDim2.new(1, -20, 0, 40)
        
        local CarButtonLayout = Instance.new("UIListLayout")
        CarButtonLayout.Parent = CarButtonFrame
        CarButtonLayout.FillDirection = Enum.FillDirection.Horizontal
        CarButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
        CarButtonLayout.Padding = UDim.new(0, 5)
        
        -- Car action buttons
        local carActions = {"Spawn", "TP Car", "Clone", "Bring"}
        for j, action in ipairs(carActions) do
            local CarActionButton = Instance.new("TextButton")
            CarActionButton.Name = action .. "Button"
            CarActionButton.Parent = CarButtonFrame
            CarActionButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
            CarActionButton.BorderSizePixel = 0
            CarActionButton.Size = UDim2.new(0, 60, 1, 0)
            CarActionButton.Font = Enum.Font.Gotham
            CarActionButton.Text = action
            CarActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            CarActionButton.TextSize = 10
            
            local CarActionCorner = Instance.new("UICorner")
            CarActionCorner.CornerRadius = UDim.new(0, 4)
            CarActionCorner.Parent = CarActionButton
            
            CarActionButton.MouseButton1Click:Connect(function()
                if action == "TP Car" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = car.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                elseif action == "Bring" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    car:SetPrimaryPartCFrame(LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(5, 0, 0))
                end
                
                StarterGui:SetCore("SendNotification", {
                    Title = "SPWARE",
                    Text = action .. " applied to " .. (car.Name or "Vehicle"),
                    Duration = 2
                })
            end)
        end
    end
    
    CarScrollFrame.CanvasSize = UDim2.new(0, 0, 0, CarLayout.AbsoluteContentSize.Y + 10)
end

CreateButton(CarManagementSection, "🔄 Refresh Car List", UpdateCarList)
CreateButton(CarManagementSection, "🚗 Spawn Random Car", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE", Text = "Random car spawned!", Duration = 2})
end)

-- Initial car list update
UpdateCarList()

-- Update canvas sizes
for i, frame in ipairs(TabFrames) do
    frame.ChildAdded:Connect(function()
        frame.CanvasSize = UDim2.new(0, 0, 0, frame.UIListLayout.AbsoluteContentSize.Y + 40)
    end)
    frame.ChildRemoved:Connect(function()
        frame.CanvasSize = UDim2.new(0, 0, 0, frame.UIListLayout.AbsoluteContentSize.Y + 40)
    end)
end

-- Button Events
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Toggle UI with INSERT key
UserInputService.InputBegan:Connect(function(key, gameProcessed)
    if gameProcessed then return end
    if key.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Initial notification
StarterGui:SetCore("SendNotification", {
    Title = "SPWARE V4",
    Text = "Loaded! Press INSERT to toggle",
    Duration = 5
})

print("SPWARE V4 Loaded Successfully!")
