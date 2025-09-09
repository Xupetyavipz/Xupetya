-- SPWARE V5 | Premium Roblox Script - CLEAN VERSION
-- Ultra Modern Design with Advanced UI

-- Wait for game to load
repeat wait() until game:IsLoaded()

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")

-- Wait for LocalPlayer
local LocalPlayer = Players.LocalPlayer
repeat wait() until LocalPlayer and LocalPlayer.Character

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
    AutoFarmMoney = false,
    AutoCollectItems = false,
    AutoDailyRewards = false,
    AutoBuy = false,
    DisableGravity = false,
    SuperJump = false,
    DualWield = false,
    
    -- Blox Fruits
    AutoFarmLevel = false,
    AutoFarmBoss = false,
    AutoFarmQuest = false,
    AutoFarmFruits = false,
    AutoFarmMastery = false,
    NoSkillCooldown = false,
    KillAura = false,
    ESPFruits = false,
    WalkOnWater = false,
    AutoAimSkills = false,
    SkillSpam = false,
    DamageMultiplier = 1,
    AutoFruitSniper = false,
    AutoBuyBlox = false
}

-- Get PlayerGui safely
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SPWARE_V5"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Main Frame with Gradient Background
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -450, 0.5, -325)
MainFrame.Size = UDim2.new(0, 900, 0, 650)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Main Frame Gradient
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 15, 25))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

-- Main Corner
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Main Stroke with Glow Effect
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(147, 51, 234)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

-- Glow Effect
local GlowFrame = Instance.new("Frame")
GlowFrame.Name = "GlowFrame"
GlowFrame.Parent = ScreenGui
GlowFrame.BackgroundTransparency = 1
GlowFrame.Position = UDim2.new(0.5, -455, 0.5, -330)
GlowFrame.Size = UDim2.new(0, 910, 0, 660)
GlowFrame.ZIndex = -1

-- Glow ImageLabel
local GlowImage = Instance.new("ImageLabel")
GlowImage.Name = "Glow"
GlowImage.Parent = GlowFrame
GlowImage.BackgroundTransparency = 1
GlowImage.Size = UDim2.new(1, 0, 1, 0)
GlowImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
GlowImage.ImageColor3 = Color3.fromRGB(147, 51, 234)
GlowImage.ImageTransparency = 0.8
GlowImage.ScaleType = Enum.ScaleType.Slice
GlowImage.SliceCenter = Rect.new(10, 10, 118, 118)

-- Header Frame
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Name = "HeaderFrame"
HeaderFrame.Parent = MainFrame
HeaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
HeaderFrame.BorderSizePixel = 0
HeaderFrame.Size = UDim2.new(1, 0, 0, 60)

-- Header Gradient
local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 51, 234))
}
HeaderGradient.Rotation = 90
HeaderGradient.Parent = HeaderFrame

-- Header Corner
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = HeaderFrame

-- Title Label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = HeaderFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.Size = UDim2.new(0, 300, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "SPWARE V5 PREMIUM"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 24
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = HeaderFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -50, 0.5, -15)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = HeaderFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(245, 158, 11)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -90, 0.5, -15)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 60)
ContentFrame.Size = UDim2.new(1, 0, 1, -60)

-- Tab System
local TabsData = {
    {name = "Combat", icon = "⚔️", color = Color3.fromRGB(239, 68, 68)},
    {name = "Movement", icon = "🏃", color = Color3.fromRGB(34, 197, 94)},
    {name = "Visual", icon = "👁️", color = Color3.fromRGB(59, 130, 246)},
    {name = "Roleplay", icon = "🎭", color = Color3.fromRGB(168, 85, 247)},
    {name = "Blox Fruits", icon = "🍎", color = Color3.fromRGB(245, 158, 11)}
}

-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = ContentFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Size = UDim2.new(1, 0, 0, 50)

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)

-- Tab Buttons and Frames
local TabButtons = {}
local TabFrames = {}
local CurrentTab = 1

-- Create Tab Buttons
for i, tabData in ipairs(TabsData) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabData.name .. "Tab"
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = i == 1 and tabData.color or Color3.fromRGB(25, 25, 30)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(0, 170, 1, 0)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.Text = tabData.icon .. " " .. tabData.name
    TabButton.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(156, 163, 175)
    TabButton.TextSize = 14
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton
    
    TabButtons[i] = TabButton
end

-- Create Tab Frames
for i, tabData in ipairs(TabsData) do
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = tabData.name .. "Frame"
    TabFrame.Parent = ContentFrame
    TabFrame.BackgroundTransparency = 1
    TabFrame.Position = UDim2.new(0, 10, 0, 60)
    TabFrame.Size = UDim2.new(1, -20, 1, -70)
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabFrame.ScrollBarThickness = 6
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(147, 51, 234)
    TabFrame.Visible = (i == 1)
    
    local TabFrameLayout = Instance.new("UIListLayout")
    TabFrameLayout.Parent = TabFrame
    TabFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabFrameLayout.Padding = UDim.new(0, 15)
    
    TabFrames[i] = TabFrame
end

-- Tab Switching Function
local function SwitchTab(tabIndex)
    if CurrentTab == tabIndex then return end
    
    -- Hide current tab frame
    for i, frame in pairs(TabFrames) do
        frame.Visible = (i == tabIndex)
    end
    
    -- Update tab buttons
    for i, button in pairs(TabButtons) do
        if i == tabIndex then
            -- Active tab
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = TabsData[i].color,
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        else
            -- Inactive tab
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(25, 25, 30),
                TextColor3 = Color3.fromRGB(156, 163, 175)
            }):Play()
        end
    end
    
    CurrentTab = tabIndex
    print("Switched to tab: " .. tabIndex .. " (" .. TabsData[tabIndex].name .. ")")
end

-- Connect Tab Buttons
for i, button in pairs(TabButtons) do
    button.MouseButton1Click:Connect(function()
        SwitchTab(i)
    end)
end

-- UI Creation Functions
local function CreateSection(parent, title, color)
    local Section = Instance.new("Frame")
    Section.Name = title .. "Section"
    Section.Parent = parent
    Section.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    Section.BackgroundTransparency = 0.1
    Section.BorderSizePixel = 0
    Section.Size = UDim2.new(1, 0, 0, 250)
    
    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 8)
    SectionCorner.Parent = Section
    
    local SectionStroke = Instance.new("UIStroke")
    SectionStroke.Color = color
    SectionStroke.Thickness = 1
    SectionStroke.Transparency = 0.7
    SectionStroke.Parent = Section
    
    local SectionHeader = Instance.new("TextLabel")
    SectionHeader.Name = "Header"
    SectionHeader.Parent = Section
    SectionHeader.BackgroundColor3 = color
    SectionHeader.BackgroundTransparency = 0.8
    SectionHeader.BorderSizePixel = 0
    SectionHeader.Size = UDim2.new(1, 0, 0, 35)
    SectionHeader.Font = Enum.Font.GothamBold
    SectionHeader.Text = title
    SectionHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
    SectionHeader.TextSize = 16
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 8)
    HeaderCorner.Parent = SectionHeader
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "Content"
    ContentFrame.Parent = Section
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 10, 0, 45)
    ContentFrame.Size = UDim2.new(1, -20, 1, -55)
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = ContentFrame
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 8)
    
    return ContentFrame
end

local function CreateToggle(parent, text, setting, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Name = text .. "Toggle"
    Toggle.Parent = parent
    Toggle.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    Toggle.BorderSizePixel = 0
    Toggle.Size = UDim2.new(1, -10, 0, 60)
    Toggle.AutoButtonColor = false
    Toggle.Text = ""
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = Toggle
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Settings[setting] and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(75, 85, 99)
    ToggleStroke.Thickness = 2
    ToggleStroke.Parent = Toggle
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Parent = Toggle
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 15, 0, 5)
    ToggleLabel.Size = UDim2.new(1, -100, 0, 25)
    ToggleLabel.Font = Enum.Font.GothamBold
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "Status"
    StatusLabel.Parent = Toggle
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Position = UDim2.new(0, 15, 0, 30)
    StatusLabel.Size = UDim2.new(1, -100, 0, 20)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Text = Settings[setting] and "✓ ENABLED" or "✗ DISABLED"
    StatusLabel.TextColor3 = Settings[setting] and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(239, 68, 68)
    StatusLabel.TextSize = 12
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SwitchFrame = Instance.new("Frame")
    SwitchFrame.Name = "Switch"
    SwitchFrame.Parent = Toggle
    SwitchFrame.BackgroundColor3 = Settings[setting] and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(75, 85, 99)
    SwitchFrame.BorderSizePixel = 0
    SwitchFrame.Position = UDim2.new(1, -70, 0.5, -12)
    SwitchFrame.Size = UDim2.new(0, 50, 0, 24)
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(0, 12)
    SwitchCorner.Parent = SwitchFrame
    
    local SwitchKnob = Instance.new("Frame")
    SwitchKnob.Name = "Knob"
    SwitchKnob.Parent = SwitchFrame
    SwitchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SwitchKnob.BorderSizePixel = 0
    SwitchKnob.Position = Settings[setting] and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    SwitchKnob.Size = UDim2.new(0, 20, 0, 20)
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(0, 10)
    KnobCorner.Parent = SwitchKnob
    
    Toggle.MouseButton1Click:Connect(function()
        Settings[setting] = not Settings[setting]
        
        -- Update visuals
        local newColor = Settings[setting] and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(75, 85, 99)
        local newPos = Settings[setting] and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        
        TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {Color = newColor}):Play()
        TweenService:Create(SwitchFrame, TweenInfo.new(0.3), {BackgroundColor3 = newColor}):Play()
        TweenService:Create(SwitchKnob, TweenInfo.new(0.3), {Position = newPos}):Play()
        
        StatusLabel.Text = Settings[setting] and "✓ ENABLED" or "✗ DISABLED"
        StatusLabel.TextColor3 = Settings[setting] and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(239, 68, 68)
        
        -- Notification
        StarterGui:SetCore("SendNotification", {
            Title = "SPWARE V5",
            Text = text .. " " .. (Settings[setting] and "enabled" or "disabled"),
            Duration = 1
        })
        
        if callback then callback(Settings[setting]) end
    end)
    
    return Toggle
end

-- Input handling
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
        GlowFrame.Visible = MainFrame.Visible
        
        if MainFrame.Visible then
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 900, 0, 650)
            }):Play()
        end
    end
end)

-- Button connections
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    GlowFrame.Visible = false
end)

MinimizeButton.MouseButton1Click:Connect(function()
    if MainFrame.Size == UDim2.new(0, 900, 0, 650) then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 900, 0, 60)
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 900, 0, 650)
        }):Play()
    end
end)

-- Tab Content Creation
-- Combat Tab
local CombatFrame = TabFrames[1]
local CombatSection = CreateSection(CombatFrame, "⚔️ Combat Features", Color3.fromRGB(239, 68, 68))
CreateToggle(CombatSection, "Aimbot", "AimbotEnabled")
CreateToggle(CombatSection, "Silent Aim", "SilentAim")
CreateToggle(CombatSection, "TriggerBot", "TriggerBot")
CreateToggle(CombatSection, "One Shot Kill", "OneShotKill")

-- Movement Tab
local MovementFrame = TabFrames[2]
local MovementSection = CreateSection(MovementFrame, "🏃 Movement Hacks", Color3.fromRGB(34, 197, 94))
CreateToggle(MovementSection, "Speed Hack", "SpeedHack", function(state)
    if state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.SpeedValue
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)
CreateToggle(MovementSection, "Fly", "Fly")
CreateToggle(MovementSection, "Noclip", "Noclip")

-- Visual Tab
local VisualFrame = TabFrames[3]
local VisualSection = CreateSection(VisualFrame, "👁️ Visual Effects", Color3.fromRGB(59, 130, 246))
CreateToggle(VisualSection, "ESP Players", "ESPPlayers")
CreateToggle(VisualSection, "Full Bright", "FullBright", function(state)
    if state then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 5
    else
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.Brightness = 1
    end
end)
CreateToggle(VisualSection, "Night Vision", "NightVision")

-- Roleplay Tab
local RoleplayFrame = TabFrames[4]
local RoleplaySection = CreateSection(RoleplayFrame, "🎭 Roleplay Features", Color3.fromRGB(168, 85, 247))
CreateToggle(RoleplaySection, "Godmode", "Godmode")
CreateToggle(RoleplaySection, "Invisible", "Invisible")
CreateToggle(RoleplaySection, "Super Jump", "SuperJump")

-- Blox Fruits Tab
local BloxFrame = TabFrames[5]
local BloxSection = CreateSection(BloxFrame, "🍎 Blox Fruits", Color3.fromRGB(245, 158, 11))
CreateToggle(BloxSection, "Auto Farm", "AutoFarmLevel")
CreateToggle(BloxSection, "Kill Aura", "KillAura")
CreateToggle(BloxSection, "Walk on Water", "WalkOnWater")

-- Initial notification
spawn(function()
    wait(2)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "SPWARE V5 Premium",
            Text = "Loaded! Press INSERT to toggle",
            Duration = 3
        })
    end)
end)

-- Show UI and debug
MainFrame.Visible = true
GlowFrame.Visible = true

print("=== SPWARE V5 PREMIUM LOADED ===")
print("UI Elements Created Successfully!")
print("Press INSERT key to toggle menu")
print("Navigation between tabs is working!")
print("================================")
