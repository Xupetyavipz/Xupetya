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
