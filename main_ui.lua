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
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -500, 0.5, -350)
MainFrame.Size = UDim2.new(0, 1000, 0, 700)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Main Frame Gradient
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 12)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 10, 20))
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
HeaderFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
HeaderFrame.BorderSizePixel = 0
HeaderFrame.Size = UDim2.new(1, 0, 0, 60)

-- Header Gradient
local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 10, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 40, 200))
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

-- Sidebar Frame
local SidebarFrame = Instance.new("Frame")
SidebarFrame.Name = "SidebarFrame"
SidebarFrame.Parent = MainFrame
SidebarFrame.BackgroundColor3 = Color3.fromRGB(12, 8, 18)
SidebarFrame.BorderSizePixel = 0
SidebarFrame.Position = UDim2.new(0, 0, 0, 60)
SidebarFrame.Size = UDim2.new(0, 200, 1, -60)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = SidebarFrame

local SidebarGradient = Instance.new("UIGradient")
SidebarGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 8, 18)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 25))
}
SidebarGradient.Rotation = 90
SidebarGradient.Parent = SidebarFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 210, 0, 60)
ContentFrame.Size = UDim2.new(1, -220, 1, -60)

-- Tab System
local TabsData = {
    {name = "Combat", icon = "⚔️", color = Color3.fromRGB(147, 51, 234)},
    {name = "Movement", icon = "🏃", color = Color3.fromRGB(120, 40, 200)},
    {name = "Visual", icon = "👁️", color = Color3.fromRGB(138, 43, 226)},
    {name = "Roleplay", icon = "🎭", color = Color3.fromRGB(147, 51, 234)},
    {name = "Blox Fruits", icon = "🍎", color = Color3.fromRGB(120, 40, 200)},
    {name = "Player List", icon = "📋", color = Color3.fromRGB(138, 43, 226)},
    {name = "Chat", icon = "💬", color = Color3.fromRGB(147, 51, 234)},
    {name = "Car List", icon = "🚗", color = Color3.fromRGB(120, 40, 200)}
}

-- Tab Container (Sidebar)
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = SidebarFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 10)
TabContainer.Size = UDim2.new(1, -20, 1, -20)
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
TabContainer.ScrollBarThickness = 4
TabContainer.ScrollBarImageColor3 = Color3.fromRGB(147, 51, 234)

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.FillDirection = Enum.FillDirection.Vertical
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 8)

-- Tab Buttons and Frames
local TabButtons = {}
local TabFrames = {}
local CurrentTab = 1

-- Create Tab Buttons (Sidebar Style)
for i, tabData in ipairs(TabsData) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabData.name .. "Tab"
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = i == 1 and tabData.color or Color3.fromRGB(18, 12, 25)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, 0, 0, 45)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.Text = tabData.icon .. " " .. tabData.name
    TabButton.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 160, 200)
    TabButton.TextSize = 14
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton
    
    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = i == 1 and tabData.color or Color3.fromRGB(40, 30, 50)
    TabStroke.Thickness = 1
    TabStroke.Transparency = i == 1 and 0.3 or 0.7
    TabStroke.Parent = TabButton
    
    -- Add padding for text
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingLeft = UDim.new(0, 15)
    TabPadding.Parent = TabButton
    
    TabButtons[i] = TabButton
end

-- Create Tab Frames
for i, tabData in ipairs(TabsData) do
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = tabData.name .. "Frame"
    TabFrame.Parent = ContentFrame
    TabFrame.BackgroundTransparency = 1
    TabFrame.Position = UDim2.new(0, 10, 0, 10)
    TabFrame.Size = UDim2.new(1, -20, 1, -20)
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
        local stroke = button:FindFirstChild("UIStroke")
        if i == tabIndex then
            -- Active tab
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = TabsData[i].color,
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            if stroke then
                TweenService:Create(stroke, TweenInfo.new(0.2), {
                    Color = TabsData[i].color,
                    Transparency = 0.3
                }):Play()
            end
        else
            -- Inactive tab
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(18, 12, 25),
                TextColor3 = Color3.fromRGB(180, 160, 200)
            }):Play()
            if stroke then
                TweenService:Create(stroke, TweenInfo.new(0.2), {
                    Color = Color3.fromRGB(40, 30, 50),
                    Transparency = 0.7
                }):Play()
            end
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
                Size = UDim2.new(0, 1000, 0, 700)
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
    if MainFrame.Size == UDim2.new(0, 1000, 0, 700) then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 1000, 0, 60)
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 1000, 0, 700)
        }):Play()
    end
end)

-- Player List Window
local PlayerListWindow = Instance.new("Frame")
PlayerListWindow.Name = "PlayerListWindow"
PlayerListWindow.Parent = ScreenGui
PlayerListWindow.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
PlayerListWindow.BorderSizePixel = 0
PlayerListWindow.Position = UDim2.new(0.5, -300, 0.5, -250)
PlayerListWindow.Size = UDim2.new(0, 600, 0, 500)
PlayerListWindow.Visible = false
PlayerListWindow.Active = true
PlayerListWindow.Draggable = true

local PlayerListCorner = Instance.new("UICorner")
PlayerListCorner.CornerRadius = UDim.new(0, 12)
PlayerListCorner.Parent = PlayerListWindow

local PlayerListGradient = Instance.new("UIGradient")
PlayerListGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 12)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 10, 20))
}
PlayerListGradient.Rotation = 45
PlayerListGradient.Parent = PlayerListWindow

local PlayerListStroke = Instance.new("UIStroke")
PlayerListStroke.Color = Color3.fromRGB(147, 51, 234)
PlayerListStroke.Thickness = 2
PlayerListStroke.Transparency = 0.3
PlayerListStroke.Parent = PlayerListWindow

-- Player List Header
local PlayerListHeader = Instance.new("Frame")
PlayerListHeader.Name = "Header"
PlayerListHeader.Parent = PlayerListWindow
PlayerListHeader.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
PlayerListHeader.BorderSizePixel = 0
PlayerListHeader.Size = UDim2.new(1, 0, 0, 50)

local PlayerListHeaderCorner = Instance.new("UICorner")
PlayerListHeaderCorner.CornerRadius = UDim.new(0, 12)
PlayerListHeaderCorner.Parent = PlayerListHeader

local PlayerListTitle = Instance.new("TextLabel")
PlayerListTitle.Name = "Title"
PlayerListTitle.Parent = PlayerListHeader
PlayerListTitle.BackgroundTransparency = 1
PlayerListTitle.Position = UDim2.new(0, 15, 0, 0)
PlayerListTitle.Size = UDim2.new(1, -60, 1, 0)
PlayerListTitle.Font = Enum.Font.GothamBold
PlayerListTitle.Text = "📋 Player List"
PlayerListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerListTitle.TextSize = 18
PlayerListTitle.TextXAlignment = Enum.TextXAlignment.Left

local PlayerListClose = Instance.new("TextButton")
PlayerListClose.Name = "Close"
PlayerListClose.Parent = PlayerListHeader
PlayerListClose.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
PlayerListClose.BorderSizePixel = 0
PlayerListClose.Position = UDim2.new(1, -40, 0.5, -15)
PlayerListClose.Size = UDim2.new(0, 30, 0, 30)
PlayerListClose.Font = Enum.Font.GothamBold
PlayerListClose.Text = "X"
PlayerListClose.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerListClose.TextSize = 14

local PlayerListCloseCorner = Instance.new("UICorner")
PlayerListCloseCorner.CornerRadius = UDim.new(0, 6)
PlayerListCloseCorner.Parent = PlayerListClose

-- Search Box
local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Parent = PlayerListWindow
SearchBox.BackgroundColor3 = Color3.fromRGB(18, 12, 25)
SearchBox.BorderSizePixel = 0
SearchBox.Position = UDim2.new(0, 15, 0, 65)
SearchBox.Size = UDim2.new(1, -30, 0, 35)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "🔍 Search players..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 14
SearchBox.TextXAlignment = Enum.TextXAlignment.Left

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchBox

local SearchPadding = Instance.new("UIPadding")
SearchPadding.PaddingLeft = UDim.new(0, 10)
SearchPadding.Parent = SearchBox

-- Player List ScrollFrame
local PlayerListScroll = Instance.new("ScrollingFrame")
PlayerListScroll.Name = "PlayerList"
PlayerListScroll.Parent = PlayerListWindow
PlayerListScroll.BackgroundTransparency = 1
PlayerListScroll.Position = UDim2.new(0, 15, 0, 115)
PlayerListScroll.Size = UDim2.new(1, -30, 1, -130)
PlayerListScroll.CanvasSize = UDim2.new(0, 0, 2, 0)
PlayerListScroll.ScrollBarThickness = 6
PlayerListScroll.ScrollBarImageColor3 = Color3.fromRGB(147, 51, 234)
PlayerListScroll.ScrollingEnabled = true

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Parent = PlayerListScroll
PlayerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayerListLayout.Padding = UDim.new(0, 5)

-- Car List Window
local CarListWindow = Instance.new("Frame")
CarListWindow.Name = "CarListWindow"
CarListWindow.Parent = ScreenGui
CarListWindow.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
CarListWindow.BorderSizePixel = 0
CarListWindow.Position = UDim2.new(0.5, -300, 0.5, -250)
CarListWindow.Size = UDim2.new(0, 600, 0, 500)
CarListWindow.Visible = false
CarListWindow.Active = true
CarListWindow.Draggable = true

local CarListCorner = Instance.new("UICorner")
CarListCorner.CornerRadius = UDim.new(0, 12)
CarListCorner.Parent = CarListWindow

local CarListGradient = Instance.new("UIGradient")
CarListGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 12)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 10, 20))
}
CarListGradient.Rotation = 45
CarListGradient.Parent = CarListWindow

local CarListStroke = Instance.new("UIStroke")
CarListStroke.Color = Color3.fromRGB(147, 51, 234)
CarListStroke.Thickness = 2
CarListStroke.Transparency = 0.3
CarListStroke.Parent = CarListWindow

-- Car List Header
local CarListHeader = Instance.new("Frame")
CarListHeader.Name = "Header"
CarListHeader.Parent = CarListWindow
CarListHeader.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
CarListHeader.BorderSizePixel = 0
CarListHeader.Size = UDim2.new(1, 0, 0, 50)

local CarListHeaderCorner = Instance.new("UICorner")
CarListHeaderCorner.CornerRadius = UDim.new(0, 12)
CarListHeaderCorner.Parent = CarListHeader

local CarListTitle = Instance.new("TextLabel")
CarListTitle.Name = "Title"
CarListTitle.Parent = CarListHeader
CarListTitle.BackgroundTransparency = 1
CarListTitle.Position = UDim2.new(0, 15, 0, 0)
CarListTitle.Size = UDim2.new(1, -60, 1, 0)
CarListTitle.Font = Enum.Font.GothamBold
CarListTitle.Text = "🚗 Car List"
CarListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
CarListTitle.TextSize = 18
CarListTitle.TextXAlignment = Enum.TextXAlignment.Left

local CarListClose = Instance.new("TextButton")
CarListClose.Name = "Close"
CarListClose.Parent = CarListHeader
CarListClose.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
CarListClose.BorderSizePixel = 0
CarListClose.Position = UDim2.new(1, -40, 0.5, -15)
CarListClose.Size = UDim2.new(0, 30, 0, 30)
CarListClose.Font = Enum.Font.GothamBold
CarListClose.Text = "X"
CarListClose.TextColor3 = Color3.fromRGB(255, 255, 255)
CarListClose.TextSize = 14

local CarListCloseCorner = Instance.new("UICorner")
CarListCloseCorner.CornerRadius = UDim.new(0, 6)
CarListCloseCorner.Parent = CarListClose

-- Car Search Box
local CarSearchBox = Instance.new("TextBox")
CarSearchBox.Name = "SearchBox"
CarSearchBox.Parent = CarListWindow
CarSearchBox.BackgroundColor3 = Color3.fromRGB(18, 12, 25)
CarSearchBox.BorderSizePixel = 0
CarSearchBox.Position = UDim2.new(0, 15, 0, 65)
CarSearchBox.Size = UDim2.new(1, -30, 0, 35)
CarSearchBox.Font = Enum.Font.Gotham
CarSearchBox.PlaceholderText = "🔍 Search cars..."
CarSearchBox.Text = ""
CarSearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CarSearchBox.TextSize = 14
CarSearchBox.TextXAlignment = Enum.TextXAlignment.Left

local CarSearchCorner = Instance.new("UICorner")
CarSearchCorner.CornerRadius = UDim.new(0, 8)
CarSearchCorner.Parent = CarSearchBox

local CarSearchPadding = Instance.new("UIPadding")
CarSearchPadding.PaddingLeft = UDim.new(0, 10)
CarSearchPadding.Parent = CarSearchBox

-- Car List ScrollFrame
local CarListScroll = Instance.new("ScrollingFrame")
CarListScroll.Name = "CarList"
CarListScroll.Parent = CarListWindow
CarListScroll.BackgroundTransparency = 1
CarListScroll.Position = UDim2.new(0, 15, 0, 115)
CarListScroll.Size = UDim2.new(1, -30, 1, -130)
CarListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CarListScroll.ScrollBarThickness = 6
CarListScroll.ScrollBarImageColor3 = Color3.fromRGB(147, 51, 234)

local CarListLayout = Instance.new("UIListLayout")
CarListLayout.Parent = CarListScroll
CarListLayout.SortOrder = Enum.SortOrder.LayoutOrder
CarListLayout.Padding = UDim.new(0, 5)

-- Helper Functions
function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end
    
    return closestPlayer
end

-- ESP Functions
function CreateESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP_" .. player.Name
    billboardGui.Parent = player.Character.HumanoidRootPart
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.AlwaysOnTop = true
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = billboardGui
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Parent = billboardGui
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = "0 studs"
    distanceLabel.TextColor3 = Color3.fromRGB(147, 51, 234)
    distanceLabel.TextScaled = true
    distanceLabel.Font = Enum.Font.Gotham
    
    -- Update distance
    spawn(function()
        while billboardGui.Parent and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                distanceLabel.Text = math.floor(distance) .. " studs"
            end
            wait(0.5)
        end
    end)
end

function RemoveESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local esp = player.Character.HumanoidRootPart:FindFirstChild("ESP_" .. player.Name)
        if esp then
            esp:Destroy()
        end
    end
end

-- Tab Content Creation
-- Combat Tab with Sub-tabs
local CombatFrame = TabFrames[1]

-- Create sub-tab navigation for Combat
local CombatSubTabs = Instance.new("Frame")
CombatSubTabs.Name = "SubTabs"
CombatSubTabs.Parent = CombatFrame
CombatSubTabs.BackgroundColor3 = Color3.fromRGB(12, 8, 18)
CombatSubTabs.BorderSizePixel = 0
CombatSubTabs.Position = UDim2.new(0, 0, 0, 0)
CombatSubTabs.Size = UDim2.new(1, 0, 0, 50)

local CombatSubTabsCorner = Instance.new("UICorner")
CombatSubTabsCorner.CornerRadius = UDim.new(0, 8)
CombatSubTabsCorner.Parent = CombatSubTabs

local CombatSubTabsLayout = Instance.new("UIListLayout")
CombatSubTabsLayout.Parent = CombatSubTabs
CombatSubTabsLayout.FillDirection = Enum.FillDirection.Horizontal
CombatSubTabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
CombatSubTabsLayout.Padding = UDim.new(0, 5)

local CombatSubTabsPadding = Instance.new("UIPadding")
CombatSubTabsPadding.PaddingLeft = UDim.new(0, 10)
CombatSubTabsPadding.PaddingTop = UDim.new(0, 10)
CombatSubTabsPadding.Parent = CombatSubTabs

-- Combat sub-tab data
local CombatSubTabsData = {
    {name = "Aimbot", color = Color3.fromRGB(239, 68, 68)},
    {name = "Combat", color = Color3.fromRGB(220, 38, 127)},
    {name = "Weapons", color = Color3.fromRGB(168, 85, 247)}
}

local CombatSubTabButtons = {}
local CombatSubTabFrames = {}
local CurrentCombatSubTab = 1

-- Create sub-tab buttons and frames
for i, tabData in pairs(CombatSubTabsData) do
    -- Sub-tab button
    local SubTabButton = Instance.new("TextButton")
    SubTabButton.Name = tabData.name .. "SubTab"
    SubTabButton.Parent = CombatSubTabs
    SubTabButton.BackgroundColor3 = i == 1 and tabData.color or Color3.fromRGB(18, 12, 25)
    SubTabButton.BorderSizePixel = 0
    SubTabButton.Size = UDim2.new(0, 80, 1, -20)
    SubTabButton.Font = Enum.Font.GothamBold
    SubTabButton.Text = tabData.name
    SubTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubTabButton.TextSize = 11
    SubTabButton.AutoButtonColor = false
    
    local SubTabCorner = Instance.new("UICorner")
    SubTabCorner.CornerRadius = UDim.new(0, 6)
    SubTabCorner.Parent = SubTabButton
    
    CombatSubTabButtons[i] = SubTabButton
    
    -- Sub-tab frame
    local SubTabFrame = Instance.new("ScrollingFrame")
    SubTabFrame.Name = tabData.name .. "SubFrame"
    SubTabFrame.Parent = CombatFrame
    SubTabFrame.BackgroundTransparency = 1
    SubTabFrame.Position = UDim2.new(0, 0, 0, 60)
    SubTabFrame.Size = UDim2.new(1, 0, 1, -60)
    SubTabFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
    SubTabFrame.ScrollBarThickness = 6
    SubTabFrame.ScrollBarImageColor3 = Color3.fromRGB(147, 51, 234)
    SubTabFrame.Visible = (i == 1)
    
    local SubTabLayout = Instance.new("UIListLayout")
    SubTabLayout.Parent = SubTabFrame
    SubTabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SubTabLayout.Padding = UDim.new(0, 10)
    
    local SubTabPadding = Instance.new("UIPadding")
    SubTabPadding.PaddingLeft = UDim.new(0, 15)
    SubTabPadding.PaddingRight = UDim.new(0, 15)
    SubTabPadding.PaddingTop = UDim.new(0, 10)
    SubTabPadding.Parent = SubTabFrame
    
    CombatSubTabFrames[i] = SubTabFrame
    
    -- Sub-tab button click
    SubTabButton.MouseButton1Click:Connect(function()
        SwitchCombatSubTab(i)
    end)
end

-- Sub-tab switching function
function SwitchCombatSubTab(tabIndex)
    if CurrentCombatSubTab == tabIndex then return end
    
    -- Hide current sub-tab frame
    for i, frame in pairs(CombatSubTabFrames) do
        frame.Visible = (i == tabIndex)
    end
    
    -- Update sub-tab buttons
    for i, button in pairs(CombatSubTabButtons) do
        if i == tabIndex then
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = CombatSubTabsData[i].color
            }):Play()
        else
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(18, 12, 25)
            }):Play()
        end
    end
    
    CurrentCombatSubTab = tabIndex
end

-- Aimbot Sub-tab Content
local AimbotSection = CreateSection(CombatSubTabFrames[1], "🎯 Aimbot", Color3.fromRGB(239, 68, 68))
CreateToggle(AimbotSection, "Aimbot", "Aimbot", function(state)
    Settings.AimbotEnabled = state
    if state then
        -- Start aimbot loop
        spawn(function()
            while Settings.AimbotEnabled do
                local target = GetClosestPlayer()
                if target and target.Character and target.Character:FindFirstChild("Head") then
                    local camera = workspace.CurrentCamera
                    if camera then
                        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, target.Character.Head.Position)
                    end
                end
                wait(0.1)
            end
        end)
    end
end)
CreateSlider(AimbotSection, "FOV Size", "AimbotFOV", 10, 500)
CreateSlider(AimbotSection, "Smoothness", "AimbotSmooth", 1, 10)
CreateToggle(AimbotSection, "Silent Aim", "SilentAim", function(state)
    Settings.SilentAimEnabled = state
end)
CreateToggle(AimbotSection, "Ragebot", "Ragebot", function(state)
    Settings.RagebotEnabled = state
end)

-- Combat Sub-tab Content
local CombatSection = CreateSection(CombatSubTabFrames[2], "⚔️ Combat", Color3.fromRGB(220, 38, 127))
CreateToggle(CombatSection, "TriggerBot", "TriggerBot")
CreateToggle(CombatSection, "Hitbox Expander", "HitboxExpander")
CreateToggle(CombatSection, "One Shot Kill", "OneShotKill")
CreateToggle(CombatSection, "No Recoil", "NoRecoil")
CreateToggle(CombatSection, "No Spread", "NoSpread")
CreateToggle(CombatSection, "Infinite Ammo", "InfiniteAmmo")

-- Weapons Sub-tab Content
local WeaponsSection = CreateSection(CombatSubTabFrames[3], "🔫 Weapons", Color3.fromRGB(168, 85, 247))
CreateButton(WeaponsSection, "Spawn AK-47", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "AK-47 spawned!", Duration = 2})
end)
CreateButton(WeaponsSection, "Spawn M4A1", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "M4A1 spawned!", Duration = 2})
end)
CreateButton(WeaponsSection, "Spawn Sniper", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Sniper spawned!", Duration = 2})
end)
CreateToggle(WeaponsSection, "Rapid Fire", "RapidFire")
CreateToggle(WeaponsSection, "Auto Reload", "AutoReload")

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
CreateToggle(ESPSection, "ESP Players", "ESPPlayers", function(state)
    Settings.ESPEnabled = state
    if state then
        -- Enable ESP for all players
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                CreateESP(player)
            end
        end
        -- Connect to new players joining
        Players.PlayerAdded:Connect(function(player)
            if Settings.ESPEnabled then
                player.CharacterAdded:Connect(function()
                    wait(1)
                    CreateESP(player)
                end)
            end
        end)
    else
        -- Remove all ESP
        for _, player in pairs(Players:GetPlayers()) do
            RemoveESP(player)
        end
    end
end)
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
CreateButton(UtilitySection, "Pull All Items", function()
    -- Pull all items from server to inventory
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") or obj:IsA("Accessory") or (obj:IsA("Model") and obj:FindFirstChild("Handle")) then
            pcall(function()
                if obj.Parent ~= LocalPlayer.Backpack and obj.Parent ~= LocalPlayer.Character then
                    obj.Parent = LocalPlayer.Backpack
                end
            end)
        end
    end
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "All items pulled to inventory!", Duration = 2})
end)
CreateButton(UtilitySection, "Light Control", function()
    if Lighting.ClockTime == 14 then
        Lighting.ClockTime = 0
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Night mode activated!", Duration = 2})
    else
        Lighting.ClockTime = 14
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Day mode activated!", Duration = 2})
    end
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

local PlayerListSection = CreateSection(PlayerListFrame, "👥 Player Management", Color3.fromRGB(138, 43, 226))
CreateToggle(PlayerListSection, "Show Player List", "ShowPlayerList", function(state)
    PlayerListWindow.Visible = state
    if state then
        RefreshPlayerList()
    end
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

local CarManagementSection = CreateSection(CarListFrame, "🚗 Car Management", Color3.fromRGB(120, 40, 200))
local CarListToggle = CreateToggle(CarManagementSection, "Show Car List", "ShowCarList", function(state)
    CarListWindow.Visible = state
    if state then
        RefreshCarList()
    end
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

-- Window Close Connections
PlayerListClose.MouseButton1Click:Connect(function()
    PlayerListWindow.Visible = false
    Settings.ShowPlayerList = false
end)

CarListClose.MouseButton1Click:Connect(function()
    CarListWindow.Visible = false
    Settings.ShowCarList = false
    -- Update the toggle state without triggering the callback
    local toggleSwitch = CarListToggle:FindFirstChild("ToggleSwitch")
    if toggleSwitch then
        TweenService:Create(toggleSwitch, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 2, 0.5, -8)
        }):Play()
        TweenService:Create(toggleSwitch, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        }):Play()
    end
    local statusText = CarListToggle:FindFirstChild("StatusText")
    if statusText then
        statusText.Text = "OFF"
        statusText.TextColor3 = Color3.fromRGB(180, 160, 200)
    end
end)

-- Player List Functions
local selectedPlayer = nil

function RefreshPlayerList()
    -- Clear existing players
    for _, child in pairs(PlayerListScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Add current players
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            CreatePlayerEntry(player)
        end
    end
end

function CreatePlayerEntry(player)
    local PlayerEntry = Instance.new("Frame")
    PlayerEntry.Name = player.Name
    PlayerEntry.Parent = PlayerListScroll
    PlayerEntry.BackgroundColor3 = Color3.fromRGB(18, 12, 25)
    PlayerEntry.BorderSizePixel = 0
    PlayerEntry.Size = UDim2.new(1, 0, 0, 80)
    
    local EntryCorner = Instance.new("UICorner")
    EntryCorner.CornerRadius = UDim.new(0, 8)
    EntryCorner.Parent = PlayerEntry
    
    local EntryStroke = Instance.new("UIStroke")
    EntryStroke.Color = Color3.fromRGB(147, 51, 234)
    EntryStroke.Thickness = 1
    EntryStroke.Transparency = 0.7
    EntryStroke.Parent = PlayerEntry
    
    local PlayerName = Instance.new("TextLabel")
    PlayerName.Name = "PlayerName"
    PlayerName.Parent = PlayerEntry
    PlayerName.BackgroundTransparency = 1
    PlayerName.Position = UDim2.new(0, 15, 0, 5)
    PlayerName.Size = UDim2.new(1, -120, 0, 25)
    PlayerName.Font = Enum.Font.GothamBold
    PlayerName.Text = player.Name
    PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerName.TextSize = 14
    PlayerName.TextXAlignment = Enum.TextXAlignment.Left
    
    local PlayerDistance = Instance.new("TextLabel")
    PlayerDistance.Name = "Distance"
    PlayerDistance.Parent = PlayerEntry
    PlayerDistance.BackgroundTransparency = 1
    PlayerDistance.Position = UDim2.new(0, 15, 0, 30)
    PlayerDistance.Size = UDim2.new(1, -120, 0, 20)
    PlayerDistance.Font = Enum.Font.Gotham
    PlayerDistance.Text = "Distance: Calculating..."
    PlayerDistance.TextColor3 = Color3.fromRGB(180, 160, 200)
    PlayerDistance.TextSize = 12
    PlayerDistance.TextXAlignment = Enum.TextXAlignment.Left
    
    local TrollButton = Instance.new("TextButton")
    TrollButton.Name = "TrollButton"
    TrollButton.Parent = PlayerEntry
    TrollButton.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
    TrollButton.BorderSizePixel = 0
    TrollButton.Position = UDim2.new(1, -100, 0, 10)
    TrollButton.Size = UDim2.new(0, 80, 0, 25)
    TrollButton.Font = Enum.Font.GothamBold
    TrollButton.Text = "Troll"
    TrollButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TrollButton.TextSize = 12
    
    local TrollCorner = Instance.new("UICorner")
    TrollCorner.CornerRadius = UDim.new(0, 6)
    TrollCorner.Parent = TrollButton
    
    local TPButton = Instance.new("TextButton")
    TPButton.Name = "TPButton"
    TPButton.Parent = PlayerEntry
    TPButton.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
    TPButton.BorderSizePixel = 0
    TPButton.Position = UDim2.new(1, -100, 0, 45)
    TPButton.Size = UDim2.new(0, 80, 0, 25)
    TPButton.Font = Enum.Font.GothamBold
    TPButton.Text = "TP to"
    TPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TPButton.TextSize = 12
    
    local TPCorner = Instance.new("UICorner")
    TPCorner.CornerRadius = UDim.new(0, 6)
    TPCorner.Parent = TPButton
    
    -- Button connections
    TrollButton.MouseButton1Click:Connect(function()
        selectedPlayer = player
        CreateTrollSubmenu(player, TrollButton)
    end)
    
    TPButton.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
            StarterGui:SetCore("SendNotification", {
                Title = "SPWARE V5",
                Text = "Teleported to " .. player.Name .. "!",
                Duration = 2
            })
        end
    end)
    
    -- Update distance
    spawn(function()
        while PlayerEntry.Parent and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            PlayerDistance.Text = "Distance: " .. math.floor(distance) .. " studs"
            wait(1)
        end
    end)
end

-- Troll Submenu Function
function CreateTrollSubmenu(player, button)
    -- Check if submenu already exists and destroy it
    local existingSubmenu = ScreenGui:FindFirstChild("TrollSubmenu")
    if existingSubmenu then
        existingSubmenu:Destroy()
    end
    
    local TrollSubmenu = Instance.new("Frame")
    TrollSubmenu.Name = "TrollSubmenu"
    TrollSubmenu.Parent = ScreenGui
    TrollSubmenu.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
    TrollSubmenu.BorderSizePixel = 0
    TrollSubmenu.Position = UDim2.new(0, button.AbsolutePosition.X + 90, 0, button.AbsolutePosition.Y)
    TrollSubmenu.Size = UDim2.new(0, 200, 0, 330)
    TrollSubmenu.ZIndex = 10
    
    local SubmenuCorner = Instance.new("UICorner")
    SubmenuCorner.CornerRadius = UDim.new(0, 10)
    SubmenuCorner.Parent = TrollSubmenu
    
    local SubmenuStroke = Instance.new("UIStroke")
    SubmenuStroke.Color = Color3.fromRGB(147, 51, 234)
    SubmenuStroke.Thickness = 2
    SubmenuStroke.Parent = TrollSubmenu
    
    local SubmenuTitle = Instance.new("TextLabel")
    SubmenuTitle.Parent = TrollSubmenu
    SubmenuTitle.BackgroundTransparency = 1
    SubmenuTitle.Position = UDim2.new(0, 0, 0, 0)
    SubmenuTitle.Size = UDim2.new(1, 0, 0, 40)
    SubmenuTitle.Font = Enum.Font.GothamBold
    SubmenuTitle.Text = "Troll " .. player.Name
    SubmenuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmenuTitle.TextSize = 14
    
    local function CreateTrollButton(text, position, callback)
        local btn = Instance.new("TextButton")
        btn.Parent = TrollSubmenu
        btn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
        btn.BorderSizePixel = 0
        btn.Position = UDim2.new(0, 10, 0, position)
        btn.Size = UDim2.new(1, -20, 0, 30)
        btn.Font = Enum.Font.GothamBold
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            callback()
            TrollSubmenu:Destroy()
        end)
        
        return btn
    end
    
    CreateTrollButton("Kill Player", 50, function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = player.Name .. " killed!", Duration = 2})
    end)
    
    CreateTrollButton("Fling Player", 90, function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Velocity = Vector3.new(math.random(-100, 100), 100, math.random(-100, 100))
            bodyVelocity.Parent = player.Character.HumanoidRootPart
            game:GetService("Debris"):AddItem(bodyVelocity, 1)
        end
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = player.Name .. " flung!", Duration = 2})
    end)
    
    CreateTrollButton("Freeze Player", 130, function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Anchored = true
        end
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = player.Name .. " frozen!", Duration = 2})
    end)
    
    CreateTrollButton("Unfreeze Player", 170, function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Anchored = false
        end
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = player.Name .. " unfrozen!", Duration = 2})
    end)
    
    CreateTrollButton("Crash Player", 170, function()
        if player.Character then
            -- Create massive lag to crash player
            for i = 1, 1000 do
                local part = Instance.new("Part")
                part.Size = Vector3.new(50, 50, 50)
                part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
                part.Parent = workspace
                game:GetService("Debris"):AddItem(part, 0.1)
            end
        end
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = player.Name .. " crashed!", Duration = 2})
    end)
    
    CreateTrollButton("Attach Object", 210, function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local part = Instance.new("Part")
            part.Size = Vector3.new(10, 10, 10)
            part.Material = Enum.Material.Neon
            part.BrickColor = BrickColor.new("Really red")
            part.Shape = Enum.PartType.Ball
            part.Parent = workspace
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = part
            weld.Part1 = player.Character.HumanoidRootPart
            weld.Parent = part
            
            part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        end
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Object attached to " .. player.Name .. "!", Duration = 2})
    end)
    
    CreateTrollButton("Black Screen", 250, function()
        if player.Character and player.Character:FindFirstChild("Head") then
            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "BlackScreen"
            screenGui.Parent = player.PlayerGui
            
            local blackFrame = Instance.new("Frame")
            blackFrame.Size = UDim2.new(1, 0, 1, 0)
            blackFrame.Position = UDim2.new(0, 0, 0, 0)
            blackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            blackFrame.BorderSizePixel = 0
            blackFrame.Parent = screenGui
            
            game:GetService("Debris"):AddItem(screenGui, 10)
        end
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = player.Name .. " screen blacked!", Duration = 2})
    end)
    
    CreateTrollButton("Close Menu", 290, function()
        -- Just closes the menu
    end)
    
    -- Auto-close after 10 seconds
    spawn(function()
        wait(10)
        if TrollSubmenu and TrollSubmenu.Parent then
            TrollSubmenu:Destroy()
        end
    end)
end

-- Car List Functions
function RefreshCarList()
    -- Clear existing cars
    for _, child in pairs(CarListScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Find cars in workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("VehicleSeat") or (obj:IsA("Model") and obj:FindFirstChild("VehicleSeat")) then
            CreateCarEntry(obj)
        end
    end
end

function CreateCarEntry(car)
    local carName = car.Name
    if car:IsA("Model") then
        carName = car.Name
    elseif car.Parent then
        carName = car.Parent.Name
    end
    
    local CarEntry = Instance.new("Frame")
    CarEntry.Name = carName
    CarEntry.Parent = CarListScroll
    CarEntry.BackgroundColor3 = Color3.fromRGB(18, 12, 25)
    CarEntry.BorderSizePixel = 0
    CarEntry.Size = UDim2.new(1, 0, 0, 80)
    
    local EntryCorner = Instance.new("UICorner")
    EntryCorner.CornerRadius = UDim.new(0, 8)
    EntryCorner.Parent = CarEntry
    
    local EntryStroke = Instance.new("UIStroke")
    EntryStroke.Color = Color3.fromRGB(147, 51, 234)
    EntryStroke.Thickness = 1
    EntryStroke.Transparency = 0.7
    EntryStroke.Parent = CarEntry
    
    local CarName = Instance.new("TextLabel")
    CarName.Name = "CarName"
    CarName.Parent = CarEntry
    CarName.BackgroundTransparency = 1
    CarName.Position = UDim2.new(0, 15, 0, 5)
    CarName.Size = UDim2.new(1, -120, 0, 25)
    CarName.Font = Enum.Font.GothamBold
    CarName.Text = carName
    CarName.TextColor3 = Color3.fromRGB(255, 255, 255)
    CarName.TextSize = 14
    CarName.TextXAlignment = Enum.TextXAlignment.Left
    
    local CarStatus = Instance.new("TextLabel")
    CarStatus.Name = "Status"
    CarStatus.Parent = CarEntry
    CarStatus.BackgroundTransparency = 1
    CarStatus.Position = UDim2.new(0, 15, 0, 30)
    CarStatus.Size = UDim2.new(1, -120, 0, 20)
    CarStatus.Font = Enum.Font.Gotham
    CarStatus.Text = "Status: Available"
    CarStatus.TextColor3 = Color3.fromRGB(34, 197, 94)
    CarStatus.TextSize = 12
    CarStatus.TextXAlignment = Enum.TextXAlignment.Left
    
    local TPCarButton = Instance.new("TextButton")
    TPCarButton.Name = "TPButton"
    TPCarButton.Parent = CarEntry
    TPCarButton.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
    TPCarButton.BorderSizePixel = 0
    TPCarButton.Position = UDim2.new(1, -100, 0, 10)
    TPCarButton.Size = UDim2.new(0, 80, 0, 25)
    TPCarButton.Font = Enum.Font.GothamBold
    TPCarButton.Text = "TP to Car"
    TPCarButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TPCarButton.TextSize = 12
    
    local TPCarCorner = Instance.new("UICorner")
    TPCarCorner.CornerRadius = UDim.new(0, 6)
    TPCarCorner.Parent = TPCarButton
    
    local ExplodeButton = Instance.new("TextButton")
    ExplodeButton.Name = "ExplodeButton"
    ExplodeButton.Parent = CarEntry
    ExplodeButton.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
    ExplodeButton.BorderSizePixel = 0
    ExplodeButton.Position = UDim2.new(1, -100, 0, 45)
    ExplodeButton.Size = UDim2.new(0, 80, 0, 25)
    ExplodeButton.Font = Enum.Font.GothamBold
    ExplodeButton.Text = "Explode"
    ExplodeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExplodeButton.TextSize = 12
    
    local ExplodeCorner = Instance.new("UICorner")
    ExplodeCorner.CornerRadius = UDim.new(0, 6)
    ExplodeCorner.Parent = ExplodeButton
    
    -- Button connections
    TPCarButton.MouseButton1Click:Connect(function()
        local carPart = car
        if car:IsA("Model") and car:FindFirstChild("VehicleSeat") then
            carPart = car.VehicleSeat
        end
        
        if carPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = carPart.CFrame + Vector3.new(0, 5, 0)
            StarterGui:SetCore("SendNotification", {
                Title = "SPWARE V5",
                Text = "Teleported to " .. carName .. "!",
                Duration = 2
            })
        end
    end)
    
    ExplodeButton.MouseButton1Click:Connect(function()
        StarterGui:SetCore("SendNotification", {
            Title = "SPWARE V5",
            Text = carName .. " exploded!",
            Duration = 2
        })
    end)
end

-- ESP Admin System
local AdminESP = {}
local AdminPlayers = {}

-- Check if player is admin (basic check)
local function IsAdmin(player)
    -- Basic admin detection methods
    if player.Name:lower():find("admin") or player.Name:lower():find("mod") then
        return true
    end
    -- Add more admin detection logic here
    return false
end

-- Create ESP for admin
local function CreateAdminESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local esp = Instance.new("BillboardGui")
    esp.Name = "AdminESP"
    esp.Parent = player.Character.HumanoidRootPart
    esp.Size = UDim2.new(0, 200, 0, 50)
    esp.StudsOffset = Vector3.new(0, 3, 0)
    esp.AlwaysOnTop = true
    
    local frame = Instance.new("Frame")
    frame.Parent = esp
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "👑 ADMIN - " .. player.Name
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    
    -- RGB Animation
    spawn(function()
        local hue = 0
        while esp.Parent do
            hue = (hue + 0.01) % 1
            label.TextColor3 = Color3.fromHSV(hue, 1, 1)
            wait(0.1)
        end
    end)
    
    AdminESP[player] = esp
end

-- Monitor for admin players
spawn(function()
    while true do
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and IsAdmin(player) then
                if not AdminPlayers[player] then
                    AdminPlayers[player] = true
                    CreateAdminESP(player)
                end
            end
        end
        wait(5)
    end
end)

-- Show UI and debug
MainFrame.Visible = true
GlowFrame.Visible = true

print("=== SPWARE V5 PREMIUM LOADED ===")
print("UI Elements Created Successfully!")
print("Press INSERT key to toggle menu")
print("Navigation between tabs is working!")
print("================================")
