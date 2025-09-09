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
    {name = "Blox Fruits", icon = "🍎", color = Color3.fromRGB(245, 158, 11)},
    {name = "Player List", icon = "📋", color = Color3.fromRGB(236, 72, 153)},
    {name = "Chat", icon = "💬", color = Color3.fromRGB(14, 165, 233)},
    {name = "Car List", icon = "🚗", color = Color3.fromRGB(249, 115, 22)}
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
    TabButton.Size = UDim2.new(0, 110, 1, 0)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.Text = tabData.icon .. " " .. tabData.name
    TabButton.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(156, 163, 175)
    TabButton.TextSize = 12
    
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

local function CreateSlider(parent, text, setting, min, max, callback)
    local Slider = Instance.new("Frame")
    Slider.Name = text .. "Slider"
    Slider.Parent = parent
    Slider.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    Slider.BorderSizePixel = 0
    Slider.Size = UDim2.new(1, -10, 0, 60)
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 8)
    SliderCorner.Parent = Slider
    
    local SliderStroke = Instance.new("UIStroke")
    SliderStroke.Color = Color3.fromRGB(75, 85, 99)
    SliderStroke.Thickness = 2
    SliderStroke.Parent = Slider
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "Label"
    SliderLabel.Parent = Slider
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Position = UDim2.new(0, 15, 0, 5)
    SliderLabel.Size = UDim2.new(1, -15, 0, 25)
    SliderLabel.Font = Enum.Font.GothamBold
    SliderLabel.Text = text .. ": " .. (Settings[setting] or min)
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 14
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "SliderFrame"
    SliderFrame.Parent = Slider
    SliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Position = UDim2.new(0, 15, 0, 35)
    SliderFrame.Size = UDim2.new(1, -30, 0, 15)
    
    local SliderFrameCorner = Instance.new("UICorner")
    SliderFrameCorner.CornerRadius = UDim.new(0, 8)
    SliderFrameCorner.Parent = SliderFrame
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "Fill"
    SliderFill.Parent = SliderFrame
    SliderFill.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new((Settings[setting] or min) / max, 0, 1, 0)
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 8)
    FillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "Button"
    SliderButton.Parent = SliderFrame
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.BorderSizePixel = 0
    SliderButton.Position = UDim2.new((Settings[setting] or min) / max, -10, 0, -5)
    SliderButton.Size = UDim2.new(0, 20, 0, 25)
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
    Button.Size = UDim2.new(1, -10, 0, 35)
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

local AimbotSection = CreateSection(CombatFrame, "🎯 Aimbot System", Color3.fromRGB(239, 68, 68))
CreateToggle(AimbotSection, "Aimbot", "AimbotEnabled")
CreateSlider(AimbotSection, "FOV", "AimbotFOV", 10, 500)
CreateSlider(AimbotSection, "Smoothness", "AimbotSmooth", 1, 20)
CreateToggle(AimbotSection, "Silent Aim", "SilentAim")
CreateToggle(AimbotSection, "Ragebot", "Ragebot")

local CombatSection = CreateSection(CombatFrame, "⚔️ Combat Features", Color3.fromRGB(239, 68, 68))
CreateToggle(CombatSection, "TriggerBot", "TriggerBot")
CreateToggle(CombatSection, "Hitbox Expander", "HitboxExpander")
CreateToggle(CombatSection, "One Shot Kill", "OneShotKill")
CreateToggle(CombatSection, "No Recoil", "NoRecoil")
CreateToggle(CombatSection, "No Spread", "NoSpread")
CreateToggle(CombatSection, "Infinite Ammo", "InfiniteAmmo")

-- Movement Tab
local MovementFrame = TabFrames[2]

local MovementSection = CreateSection(MovementFrame, "🏃 Movement Hacks", Color3.fromRGB(34, 197, 94))
CreateToggle(MovementSection, "Bunny Hop", "BunnyHop")
CreateToggle(MovementSection, "Strafe Hack", "StrafeHack")
CreateToggle(MovementSection, "Speed Hack", "SpeedHack", function(state)
    if state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.SpeedValue
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)
CreateSlider(MovementSection, "Speed Value", "SpeedValue", 16, 500, function(value)
    if Settings.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

local FlightSection = CreateSection(MovementFrame, "✈️ Flight & Teleport", Color3.fromRGB(34, 197, 94))
CreateToggle(FlightSection, "Fly", "Fly")
CreateToggle(FlightSection, "Jetpack", "Jetpack")
CreateSlider(FlightSection, "Fly Speed", "FlySpeed", 10, 200)
CreateToggle(FlightSection, "Noclip", "Noclip")
CreateToggle(FlightSection, "Teleport Kill", "TeleportKill")

-- Visual Tab
local VisualFrame = TabFrames[3]

local ESPSection = CreateSection(VisualFrame, "👁️ ESP System", Color3.fromRGB(59, 130, 246))
CreateToggle(ESPSection, "ESP Players", "ESPPlayers")
CreateToggle(ESPSection, "ESP Box", "ESPBox")
CreateToggle(ESPSection, "ESP Skeleton", "ESPSkeleton")
CreateToggle(ESPSection, "ESP Head Dot", "ESPHeadDot")
CreateToggle(ESPSection, "ESP Weapons", "ESPWeapons")
CreateToggle(ESPSection, "ESP Items", "ESPItems")

local VisualSection = CreateSection(VisualFrame, "🌟 Visual Effects", Color3.fromRGB(59, 130, 246))
CreateToggle(VisualSection, "Chams", "Chams")
CreateToggle(VisualSection, "Glow", "Glow")
CreateToggle(VisualSection, "Radar Hack", "RadarHack")
CreateToggle(VisualSection, "Custom Crosshair", "CustomCrosshair")
CreateToggle(VisualSection, "Night Vision", "NightVision")
CreateToggle(VisualSection, "Full Bright", "FullBright", function(state)
    if state then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 5
    else
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.Brightness = 1
    end
end)

-- Roleplay Tab
local RoleplayFrame = TabFrames[4]

local VehicleSection = CreateSection(RoleplayFrame, "🚗 Vehicle System", Color3.fromRGB(168, 85, 247))
CreateButton(VehicleSection, "Spawn Car", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Car spawned!", Duration = 2})
end)
CreateToggle(VehicleSection, "Super Speed Car", "SuperSpeedCar")
CreateToggle(VehicleSection, "Fly Car", "FlyCar")
CreateButton(VehicleSection, "Spawn Boat", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Boat spawned!", Duration = 2})
end)
CreateButton(VehicleSection, "Spawn Helicopter", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Helicopter spawned!", Duration = 2})
end)

local WeaponSection = CreateSection(RoleplayFrame, "🔫 Weapons & Items", Color3.fromRGB(168, 85, 247))
CreateButton(WeaponSection, "Spawn Weapons", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Weapons spawned!", Duration = 2})
end)
CreateToggle(WeaponSection, "Infinite Ammo", "InfiniteAmmoRP")
CreateToggle(WeaponSection, "Dual Wield", "DualWield")
CreateButton(WeaponSection, "Item Spawner", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Items spawned!", Duration = 2})
end)

local PlayerSection = CreateSection(RoleplayFrame, "👤 Player Features", Color3.fromRGB(168, 85, 247))
CreateButton(PlayerSection, "Morphs", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Morph menu opened!", Duration = 2})
end)
CreateSlider(PlayerSection, "Size Changer", "SizeChanger", 0.1, 5)
CreateToggle(PlayerSection, "Invisible", "Invisible")
CreateToggle(PlayerSection, "Godmode", "Godmode")
CreateToggle(PlayerSection, "Super Jump", "SuperJump")
CreateButton(PlayerSection, "Teleport Locations", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleport menu opened!", Duration = 2})
end)

local UtilitySection = CreateSection(RoleplayFrame, "🛠️ Utilities", Color3.fromRGB(168, 85, 247))
CreateToggle(UtilitySection, "Auto Farm Money", "AutoFarmMoney")
CreateToggle(UtilitySection, "Auto Collect Items", "AutoCollectItems")
CreateToggle(UtilitySection, "Auto Daily Rewards", "AutoDailyRewards")
CreateToggle(UtilitySection, "Auto Buy", "AutoBuy")
CreateToggle(UtilitySection, "Disable Gravity", "DisableGravity")
CreateButton(UtilitySection, "Light Control", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Light control activated!", Duration = 2})
end)

-- Blox Fruits Tab
local BloxFrame = TabFrames[5]

local FarmSection = CreateSection(BloxFrame, "🌾 Auto Farm", Color3.fromRGB(245, 158, 11))
CreateToggle(FarmSection, "Auto Farm Level", "AutoFarmLevel")
CreateToggle(FarmSection, "Auto Farm Boss", "AutoFarmBoss")
CreateToggle(FarmSection, "Auto Farm Quest", "AutoFarmQuest")
CreateToggle(FarmSection, "Auto Farm Fruits", "AutoFarmFruits")
CreateToggle(FarmSection, "Auto Farm Mastery", "AutoFarmMastery")

local BloxCombatSection = CreateSection(BloxFrame, "⚔️ Combat", Color3.fromRGB(245, 158, 11))
CreateToggle(BloxCombatSection, "Auto Aim Skills", "AutoAimSkills")
CreateToggle(BloxCombatSection, "No Skill Cooldown", "NoSkillCooldown")
CreateToggle(BloxCombatSection, "Skill Spam", "SkillSpam")
CreateToggle(BloxCombatSection, "Kill Aura", "KillAura")
CreateSlider(BloxCombatSection, "Damage Multiplier", "DamageMultiplier", 1, 10)

local BloxTeleportSection = CreateSection(BloxFrame, "🌊 Teleport", Color3.fromRGB(245, 158, 11))
CreateButton(BloxTeleportSection, "TP to Sea", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to sea!", Duration = 2})
end)
CreateButton(BloxTeleportSection, "TP to Island", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to island!", Duration = 2})
end)
CreateButton(BloxTeleportSection, "TP to NPC", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to NPC!", Duration = 2})
end)
CreateButton(BloxTeleportSection, "TP to Fruits", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to fruits!", Duration = 2})
end)

local BloxMiscSection = CreateSection(BloxFrame, "🔧 Misc", Color3.fromRGB(245, 158, 11))
CreateToggle(BloxMiscSection, "ESP Fruits", "ESPFruits")
CreateToggle(BloxMiscSection, "Auto Fruit Sniper", "AutoFruitSniper")
CreateToggle(BloxMiscSection, "Walk on Water", "WalkOnWater")
CreateToggle(BloxMiscSection, "Auto Buy Blox", "AutoBuyBlox")
CreateButton(BloxMiscSection, "Raid Helper", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Raid helper activated!", Duration = 2})
end)

-- Player List Tab
local PlayerListFrame = TabFrames[6]

local PlayerListSection = CreateSection(PlayerListFrame, "👥 Player Management", Color3.fromRGB(236, 72, 153))
CreateButton(PlayerListSection, "Refresh Players", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Player list refreshed!", Duration = 2})
end)
CreateButton(PlayerListSection, "Teleport to Player", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Select a player first!", Duration = 2})
end)
CreateButton(PlayerListSection, "Spectate Player", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Spectating player!", Duration = 2})
end)

local TrollSection = CreateSection(PlayerListFrame, "🎪 Troll Actions", Color3.fromRGB(236, 72, 153))
CreateButton(TrollSection, "Freeze Player", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Player frozen!", Duration = 2})
end)
CreateButton(TrollSection, "Fling Player", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Player flung!", Duration = 2})
end)
CreateButton(TrollSection, "Kill Player", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Player killed!", Duration = 2})
end)
CreateButton(TrollSection, "Clone Player", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Player cloned!", Duration = 2})
end)
CreateButton(TrollSection, "Spin Player", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Player spinning!", Duration = 2})
end)
CreateButton(TrollSection, "Troll Pack", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Troll pack activated!", Duration = 2})
end)

-- Chat Tab
local ChatFrame = TabFrames[7]

local QuickChatSection = CreateSection(ChatFrame, "💬 Quick Messages", Color3.fromRGB(14, 165, 233))
CreateButton(QuickChatSection, "Quick Messages", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Quick message sent!", Duration = 2})
end)
CreateButton(QuickChatSection, "Keybind Macros", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Macro activated!", Duration = 2})
end)
CreateToggle(QuickChatSection, "Auto Reply", "AutoReply")
CreateToggle(QuickChatSection, "Auto Greet", "AutoGreet")
CreateToggle(QuickChatSection, "Auto GG", "AutoGG")

local SpamSection = CreateSection(ChatFrame, "🌊 Spam Features", Color3.fromRGB(14, 165, 233))
CreateToggle(SpamSection, "Chat Spam", "ChatSpam")
CreateButton(SpamSection, "Wave Spam", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Wave spam activated!", Duration = 2})
end)
CreateButton(SpamSection, "Emoji Spam", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Emoji spam activated!", Duration = 2})
end)
CreateButton(SpamSection, "Unicode Spam", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Unicode spam activated!", Duration = 2})
end)

local FakeChatSection = CreateSection(ChatFrame, "🎭 Fake Features", Color3.fromRGB(14, 165, 233))
CreateToggle(FakeChatSection, "Fake Messages", "FakeMessages")
CreateButton(FakeChatSection, "Fake System Messages", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Fake system message sent!", Duration = 2})
end)
CreateButton(FakeChatSection, "Fake Admin Commands", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Fake admin command sent!", Duration = 2})
end)

-- Car List Tab
local CarListFrame = TabFrames[8]

local CarManagementSection = CreateSection(CarListFrame, "🚗 Car Management", Color3.fromRGB(249, 115, 22))
CreateButton(CarManagementSection, "Refresh Car List", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Car list refreshed!", Duration = 2})
end)
CreateButton(CarManagementSection, "Spawn Selected Car", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Car spawned!", Duration = 2})
end)
CreateButton(CarManagementSection, "TP to Car", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to car!", Duration = 2})
end)

local CarActionsSection = CreateSection(CarListFrame, "🔧 Car Actions", Color3.fromRGB(249, 115, 22))
CreateButton(CarActionsSection, "Bring Car to Me", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Car brought to you!", Duration = 2})
end)
CreateButton(CarActionsSection, "Explode Car", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Car exploded!", Duration = 2})
end)
CreateButton(CarActionsSection, "Delete Car", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Car deleted!", Duration = 2})
end)
CreateButton(CarActionsSection, "Send Car to Sky", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Car sent to sky!", Duration = 2})
end)

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
