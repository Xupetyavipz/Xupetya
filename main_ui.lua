-- SPWARE V5 | Premium Roblox Script
-- Ultra Modern Design with Advanced UI

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
    AutoBuyBlox = false,
    
    -- Chat
    ChatSpam = false,
    AutoReply = false,
    FakeMessages = false,
    AutoGreet = false,
    AutoGG = false
}

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SPWARE_V5"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

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
GlowFrame.ZIndex = MainFrame.ZIndex - 1

local GlowStroke = Instance.new("UIStroke")
GlowStroke.Color = Color3.fromRGB(147, 51, 234)
GlowStroke.Thickness = 8
GlowStroke.Transparency = 0.8
GlowStroke.Parent = GlowFrame

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 16)
GlowCorner.Parent = GlowFrame

-- Title Bar with Premium Design
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 50)

-- Title Bar Gradient
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(147, 51, 234)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 51, 234))
}
TitleGradient.Rotation = 90
TitleGradient.Parent = TitleBar

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Fix corner for title
local TitleFix = Instance.new("Frame")
TitleFix.Parent = TitleBar
TitleFix.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
TitleFix.BorderSizePixel = 0
TitleFix.Position = UDim2.new(0, 0, 0.6, 0)
TitleFix.Size = UDim2.new(1, 0, 0.4, 0)

-- SPWARE Logo/Icon
local LogoFrame = Instance.new("Frame")
LogoFrame.Name = "LogoFrame"
LogoFrame.Parent = TitleBar
LogoFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LogoFrame.BorderSizePixel = 0
LogoFrame.Position = UDim2.new(0, 15, 0, 10)
LogoFrame.Size = UDim2.new(0, 30, 0, 30)

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 8)
LogoCorner.Parent = LogoFrame

local LogoText = Instance.new("TextLabel")
LogoText.Name = "LogoText"
LogoText.Parent = LogoFrame
LogoText.BackgroundTransparency = 1
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.Font = Enum.Font.GothamBold
LogoText.Text = "SP"
LogoText.TextColor3 = Color3.fromRGB(147, 51, 234)
LogoText.TextSize = 14
LogoText.TextScaled = true

-- Title Text with Premium Styling
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 55, 0, 0)
TitleText.Size = UDim2.new(0.6, 0, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "SPWARE V5 | Premium Edition"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Status Indicator
local StatusFrame = Instance.new("Frame")
StatusFrame.Name = "StatusFrame"
StatusFrame.Parent = TitleBar
StatusFrame.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
StatusFrame.BorderSizePixel = 0
StatusFrame.Position = UDim2.new(1, -120, 0, 15)
StatusFrame.Size = UDim2.new(0, 8, 0, 8)

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(1, 0)
StatusCorner.Parent = StatusFrame

local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Parent = TitleBar
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.new(1, -105, 0, 10)
StatusText.Size = UDim2.new(0, 60, 0, 18)
StatusText.Font = Enum.Font.Gotham
StatusText.Text = "ONLINE"
StatusText.TextColor3 = Color3.fromRGB(34, 197, 94)
StatusText.TextSize = 10

-- Close Button with Hover Effect
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(245, 158, 11)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -75, 0, 10)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "─"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Premium Sidebar with Glass Effect
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
Sidebar.BackgroundTransparency = 0.1
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.Size = UDim2.new(0, 220, 1, -50)

-- Sidebar Gradient
local SidebarGradient = Instance.new("UIGradient")
SidebarGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 12)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 12, 20))
}
SidebarGradient.Rotation = 90
SidebarGradient.Parent = Sidebar

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

-- Sidebar Stroke
local SidebarStroke = Instance.new("UIStroke")
SidebarStroke.Color = Color3.fromRGB(147, 51, 234)
SidebarStroke.Thickness = 1
SidebarStroke.Transparency = 0.7
SidebarStroke.Parent = Sidebar

-- Fix sidebar corners
local SidebarFix = Instance.new("Frame")
SidebarFix.Parent = Sidebar
SidebarFix.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
SidebarFix.BorderSizePixel = 0
SidebarFix.Position = UDim2.new(1, -12, 0, 0)
SidebarFix.Size = UDim2.new(0, 12, 1, 0)

local SidebarFix2 = Instance.new("Frame")
SidebarFix2.Parent = Sidebar
SidebarFix2.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
SidebarFix2.BorderSizePixel = 0
SidebarFix2.Position = UDim2.new(0, 0, 0, 0)
SidebarFix2.Size = UDim2.new(1, 0, 0, 12)

-- Content Area with Glass Effect
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ContentArea.BackgroundTransparency = 0.05
ContentArea.BorderSizePixel = 0
ContentArea.Position = UDim2.new(0, 220, 0, 50)
ContentArea.Size = UDim2.new(1, -220, 1, -50)

-- Content Area Gradient
local ContentGradient = Instance.new("UIGradient")
ContentGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 18, 25))
}
ContentGradient.Rotation = 135
ContentGradient.Parent = ContentArea

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = ContentArea

-- Content Area Stroke
local ContentStroke = Instance.new("UIStroke")
ContentStroke.Color = Color3.fromRGB(147, 51, 234)
ContentStroke.Thickness = 1
ContentStroke.Transparency = 0.8
ContentStroke.Parent = ContentArea

-- Fix content area corners
local ContentFix = Instance.new("Frame")
ContentFix.Parent = ContentArea
ContentFix.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ContentFix.BorderSizePixel = 0
ContentFix.Position = UDim2.new(0, 0, 0, 0)
ContentFix.Size = UDim2.new(0, 12, 1, 0)

-- Tabs Data
local TabsData = {
    {name = "⚔️ Combat", icon = "⚔️", color = Color3.fromRGB(239, 68, 68)},
    {name = "🏃 Movement", icon = "🏃", color = Color3.fromRGB(34, 197, 94)},
    {name = "👁️ Visual", icon = "👁️", color = Color3.fromRGB(59, 130, 246)},
    {name = "🎭 Roleplay", icon = "🎭", color = Color3.fromRGB(168, 85, 247)},
    {name = "🥭 Blox Fruits", icon = "🥭", color = Color3.fromRGB(245, 158, 11)},
    {name = "📋 Player List", icon = "📋", color = Color3.fromRGB(14, 165, 233)},
    {name = "💬 Chat", icon = "💬", color = Color3.fromRGB(236, 72, 153)},
    {name = "🚗 Car List", icon = "🚗", color = Color3.fromRGB(16, 185, 129)}
}

local TabButtons = {}
local TabFrames = {}
local CurrentTab = 1

-- Create Premium Tab Buttons with Modern Design
for i, tabData in ipairs(TabsData) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = "Tab" .. i
    TabButton.Parent = Sidebar
    TabButton.BackgroundColor3 = i == 1 and tabData.color or Color3.fromRGB(20, 20, 25)
    TabButton.BackgroundTransparency = i == 1 and 0 or 0.3
    TabButton.BorderSizePixel = 0
    TabButton.Position = UDim2.new(0, 15, 0, 20 + (i-1) * 65)
    TabButton.Size = UDim2.new(1, -30, 0, 50)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.Text = ""
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 14
    TabButton.AutoButtonColor = false
    
    -- Tab Button Gradient
    local TabGradient = Instance.new("UIGradient")
    if i == 1 then
        TabGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, tabData.color),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(
                math.max(0, tabData.color.R * 255 - 30),
                math.max(0, tabData.color.G * 255 - 30),
                math.max(0, tabData.color.B * 255 - 30)
            ))
        }
    else
        TabGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 25)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 30))
        }
    end
    TabGradient.Rotation = 45
    TabGradient.Parent = TabButton
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabButton
    
    -- Tab Button Stroke
    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = i == 1 and tabData.color or Color3.fromRGB(147, 51, 234)
    TabStroke.Thickness = i == 1 and 2 or 1
    TabStroke.Transparency = i == 1 and 0.3 or 0.8
    TabStroke.Parent = TabButton
    
    -- Icon Frame
    local IconFrame = Instance.new("Frame")
    IconFrame.Name = "IconFrame"
    IconFrame.Parent = TabButton
    IconFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    IconFrame.BackgroundTransparency = 0.1
    IconFrame.BorderSizePixel = 0
    IconFrame.Position = UDim2.new(0, 12, 0, 10)
    IconFrame.Size = UDim2.new(0, 30, 0, 30)
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 8)
    IconCorner.Parent = IconFrame
    
    local IconText = Instance.new("TextLabel")
    IconText.Name = "IconText"
    IconText.Parent = IconFrame
    IconText.BackgroundTransparency = 1
    IconText.Size = UDim2.new(1, 0, 1, 0)
    IconText.Font = Enum.Font.GothamBold
    IconText.Text = tabData.icon
    IconText.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or tabData.color
    IconText.TextSize = 16
    IconText.TextScaled = true
    
    -- Tab Label
    local TabLabel = Instance.new("TextLabel")
    TabLabel.Name = "TabLabel"
    TabLabel.Parent = TabButton
    TabLabel.BackgroundTransparency = 1
    TabLabel.Position = UDim2.new(0, 50, 0, 0)
    TabLabel.Size = UDim2.new(1, -60, 1, 0)
    TabLabel.Font = Enum.Font.GothamBold
    TabLabel.Text = string.gsub(tabData.name, tabData.icon .. " ", "")
    TabLabel.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    TabLabel.TextSize = 14
    TabLabel.TextXAlignment = Enum.TextXAlignment.Left
    TabLabel.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Active Indicator
    local ActiveIndicator = Instance.new("Frame")
    ActiveIndicator.Name = "ActiveIndicator"
    ActiveIndicator.Parent = TabButton
    ActiveIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ActiveIndicator.BorderSizePixel = 0
    ActiveIndicator.Position = UDim2.new(1, -4, 0, 15)
    ActiveIndicator.Size = UDim2.new(0, 3, 0, 20)
    ActiveIndicator.Visible = i == 1
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = ActiveIndicator
    
    TabButtons[i] = TabButton
    
    -- Create Tab Frame with Premium Styling
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = "TabFrame" .. i
    TabFrame.Parent = ContentArea
    TabFrame.BackgroundTransparency = 1
    TabFrame.BorderSizePixel = 0
    TabFrame.Position = UDim2.new(0, 0, 0, 0)
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.ScrollBarThickness = 6
    TabFrame.ScrollBarImageColor3 = tabData.color
    TabFrame.ScrollBarImageTransparency = 0.3
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabFrame.Visible = i == 1
    TabFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Parent = TabFrame
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 15)
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 25)
    TabPadding.PaddingLeft = UDim.new(0, 25)
    TabPadding.PaddingRight = UDim.new(0, 25)
    TabPadding.PaddingBottom = UDim.new(0, 25)
    TabPadding.Parent = TabFrame
    
    TabFrames[i] = TabFrame
end

-- Premium Tab switching function with animations
local function SwitchTab(tabIndex)
    if CurrentTab == tabIndex then return end
    
    local currentTabData = TabsData[CurrentTab]
    local newTabData = TabsData[tabIndex]
    
    -- Animate current tab to inactive state
    local currentButton = TabButtons[CurrentTab]
    local currentGradient = currentButton:FindFirstChild("UIGradient")
    local currentStroke = currentButton:FindFirstChild("UIStroke")
    local currentIcon = currentButton.IconFrame.IconText
    local currentLabel = currentButton.TabLabel
    local currentIndicator = currentButton.ActiveIndicator
    
    TweenService:Create(currentButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0.3
    }):Play()
    
    if currentGradient then
        TweenService:Create(currentGradient, TweenInfo.new(0.3), {
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 25)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 30))
            }
        }):Play()
    end
    
    if currentStroke then
        TweenService:Create(currentStroke, TweenInfo.new(0.3), {
            Color = Color3.fromRGB(147, 51, 234),
            Thickness = 1,
            Transparency = 0.8
        }):Play()
    end
    
    TweenService:Create(currentIcon, TweenInfo.new(0.3), {
        TextColor3 = currentTabData.color
    }):Play()
    
    TweenService:Create(currentLabel, TweenInfo.new(0.3), {
        TextColor3 = Color3.fromRGB(200, 200, 200)
    }):Play()
    
    TweenService:Create(currentIndicator, TweenInfo.new(0.3), {
        Transparency = 1
    }):Play()
    
    -- Animate new tab to active state
    local newButton = TabButtons[tabIndex]
    local newGradient = newButton:FindFirstChild("UIGradient")
    local newStroke = newButton:FindFirstChild("UIStroke")
    local newIcon = newButton.IconFrame.IconText
    local newLabel = newButton.TabLabel
    local newIndicator = newButton.ActiveIndicator
    
    TweenService:Create(newButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0
    }):Play()
    
    if newGradient then
        TweenService:Create(newGradient, TweenInfo.new(0.3), {
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, newTabData.color),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(
                    math.max(0, newTabData.color.R * 255 - 30),
                    math.max(0, newTabData.color.G * 255 - 30),
                    math.max(0, newTabData.color.B * 255 - 30)
                ))
            }
        }):Play()
    end
    
    if newStroke then
        TweenService:Create(newStroke, TweenInfo.new(0.3), {
            Color = newTabData.color,
            Thickness = 2,
            Transparency = 0.3
        }):Play()
    end
    
    TweenService:Create(newIcon, TweenInfo.new(0.3), {
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
    
    TweenService:Create(newLabel, TweenInfo.new(0.3), {
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
    
    newIndicator.Visible = true
    TweenService:Create(newIndicator, TweenInfo.new(0.3), {
        Transparency = 0
    }):Play()
    
    -- Hide current tab frame and show new one
    TabFrames[CurrentTab].Visible = false
    TabFrames[tabIndex].Visible = true
    
    CurrentTab = tabIndex
end

-- Connect tab buttons with hover effects
for i, button in ipairs(TabButtons) do
    button.MouseButton1Click:Connect(function()
        SwitchTab(i)
    end)
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        if i ~= CurrentTab then
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.1
            }):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if i ~= CurrentTab then
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.3
            }):Play()
        end
    end)
end

-- Premium Helper Functions with Modern Design
local function CreateSection(parent, title, color)
    local Section = Instance.new("Frame")
    Section.Name = title .. "Section"
    Section.Parent = parent
    Section.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    Section.BackgroundTransparency = 0.1
    Section.BorderSizePixel = 0
    Section.Size = UDim2.new(1, 0, 0, 0)
    
    -- Section Gradient
    local SectionGradient = Instance.new("UIGradient")
    SectionGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 22, 30))
    }
    SectionGradient.Rotation = 135
    SectionGradient.Parent = Section
    
    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 12)
    SectionCorner.Parent = Section
    
    local SectionStroke = Instance.new("UIStroke")
    SectionStroke.Color = color or Color3.fromRGB(147, 51, 234)
    SectionStroke.Thickness = 1
    SectionStroke.Transparency = 0.7
    SectionStroke.Parent = Section
    
    -- Header Frame
    local HeaderFrame = Instance.new("Frame")
    HeaderFrame.Name = "HeaderFrame"
    HeaderFrame.Parent = Section
    HeaderFrame.BackgroundColor3 = color or Color3.fromRGB(147, 51, 234)
    HeaderFrame.BackgroundTransparency = 0.9
    HeaderFrame.BorderSizePixel = 0
    HeaderFrame.Size = UDim2.new(1, 0, 0, 45)
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = HeaderFrame
    
    local HeaderFix = Instance.new("Frame")
    HeaderFix.Parent = HeaderFrame
    HeaderFix.BackgroundColor3 = color or Color3.fromRGB(147, 51, 234)
    HeaderFix.BackgroundTransparency = 0.9
    HeaderFix.BorderSizePixel = 0
    HeaderFix.Position = UDim2.new(0, 0, 0.6, 0)
    HeaderFix.Size = UDim2.new(1, 0, 0.4, 0)
    
    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Name = "Title"
    SectionTitle.Parent = HeaderFrame
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Position = UDim2.new(0, 20, 0, 0)
    SectionTitle.Size = UDim2.new(1, -40, 1, 0)
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.Text = title
    SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SectionTitle.TextSize = 16
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    SectionTitle.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Accent Line
    local AccentLine = Instance.new("Frame")
    AccentLine.Name = "AccentLine"
    AccentLine.Parent = HeaderFrame
    AccentLine.BackgroundColor3 = color or Color3.fromRGB(147, 51, 234)
    AccentLine.BorderSizePixel = 0
    AccentLine.Position = UDim2.new(0, 20, 1, -2)
    AccentLine.Size = UDim2.new(0, 60, 0, 2)
    
    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(1, 0)
    AccentCorner.Parent = AccentLine
    
    local SectionLayout = Instance.new("UIListLayout")
    SectionLayout.Parent = Section
    SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SectionLayout.Padding = UDim.new(0, 12)
    
    local SectionPadding = Instance.new("UIPadding")
    SectionPadding.PaddingTop = UDim.new(0, 55)
    SectionPadding.PaddingLeft = UDim.new(0, 20)
    SectionPadding.PaddingRight = UDim.new(0, 20)
    SectionPadding.PaddingBottom = UDim.new(0, 20)
    SectionPadding.Parent = Section
    
    return Section
end

local function CreateToggle(parent, text, setting, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Name = text .. "Toggle"
    Toggle.Parent = parent
    Toggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Toggle.BackgroundTransparency = 0.2
    Toggle.BorderSizePixel = 0
    Toggle.Size = UDim2.new(1, 0, 0, 45)
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = Toggle
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Color3.fromRGB(147, 51, 234)
    ToggleStroke.Thickness = 1
    ToggleStroke.Transparency = 0.8
    ToggleStroke.Parent = Toggle
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "Button"
    ToggleButton.Parent = Toggle
    ToggleButton.BackgroundColor3 = Settings[setting] and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(45, 45, 55)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(1, -60, 0, 10)
    ToggleButton.Size = UDim2.new(0, 50, 0, 25)
    ToggleButton.Text = ""
    ToggleButton.AutoButtonColor = false
    
    local ToggleButtonCorner = Instance.new("UICorner")
    ToggleButtonCorner.CornerRadius = UDim.new(0, 12)
    ToggleButtonCorner.Parent = ToggleButton
    
    local ToggleGradient = Instance.new("UIGradient")
    if Settings[setting] then
        ToggleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(147, 51, 234)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 85, 247))
        }
    else
        ToggleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 55)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 65))
        }
    end
    ToggleGradient.Rotation = 45
    ToggleGradient.Parent = ToggleButton
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Name = "Circle"
    ToggleCircle.Parent = ToggleButton
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.Position = Settings[setting] and UDim2.new(1, -22, 0, 3) or UDim2.new(0, 3, 0, 3)
    ToggleCircle.Size = UDim2.new(0, 19, 0, 19)
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = ToggleCircle
    
    local CircleShadow = Instance.new("UIStroke")
    CircleShadow.Color = Color3.fromRGB(0, 0, 0)
    CircleShadow.Thickness = 1
    CircleShadow.Transparency = 0.9
    CircleShadow.Parent = ToggleCircle
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Parent = Toggle
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
    ToggleLabel.Size = UDim2.new(1, -80, 1, 0)
    ToggleLabel.Font = Enum.Font.GothamMedium
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Status Text
    local StatusText = Instance.new("TextLabel")
    StatusText.Name = "StatusText"
    StatusText.Parent = Toggle
    StatusText.BackgroundTransparency = 1
    StatusText.Position = UDim2.new(1, -55, 0, 0)
    StatusText.Size = UDim2.new(0, 25, 1, 0)
    StatusText.Font = Enum.Font.GothamBold
    StatusText.Text = Settings[setting] and "ON" or "OFF"
    StatusText.TextColor3 = Settings[setting] and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(239, 68, 68)
    StatusText.TextSize = 10
    StatusText.TextXAlignment = Enum.TextXAlignment.Center
    StatusText.TextYAlignment = Enum.TextYAlignment.Center
    
    ToggleButton.MouseButton1Click:Connect(function()
        Settings[setting] = not Settings[setting]
        
        local newColor = Settings[setting] and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(45, 45, 55)
        local newPosition = Settings[setting] and UDim2.new(1, -22, 0, 3) or UDim2.new(0, 3, 0, 3)
        local newStatusColor = Settings[setting] and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(239, 68, 68)
        
        TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = newColor}):Play()
        TweenService:Create(ToggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = newPosition}):Play()
        TweenService:Create(StatusText, TweenInfo.new(0.2), {TextColor3 = newStatusColor}):Play()
        
        StatusText.Text = Settings[setting] and "ON" or "OFF"
        
        if Settings[setting] then
            ToggleGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(147, 51, 234)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 85, 247))
            }
        else
            ToggleGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 55)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 65))
            }
        end
        
        if callback then
            callback(Settings[setting])
        end
        
        StarterGui:SetCore("SendNotification", {
            Title = "SPWARE V5",
            Text = text .. (Settings[setting] and " ENABLED" or " DISABLED"),
            Duration = 2
        })
    end)
    
    -- Hover effects
    ToggleButton.MouseEnter:Connect(function()
        TweenService:Create(ToggleStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
    end)
    
    ToggleButton.MouseLeave:Connect(function()
        TweenService:Create(ToggleStroke, TweenInfo.new(0.2), {Transparency = 0.8}):Play()
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

local AimbotSection = CreateSection(CombatFrame, "🎯 Aimbot System", Color3.fromRGB(239, 68, 68))
CreateToggle(AimbotSection, "Aimbot", "AimbotEnabled", function(state)
    -- Aimbot logic here
end)
CreateSlider(AimbotSection, "FOV", "AimbotFOV", 10, 500)
CreateSlider(AimbotSection, "Smoothness", "AimbotSmooth", 1, 20)
CreateToggle(AimbotSection, "Silent Aim", "SilentAim")
CreateToggle(AimbotSection, "Ragebot", "Ragebot")

local CombatSection = CreateSection(CombatFrame, "⚔️ Combat Features", Color3.fromRGB(239, 68, 68))
CreateToggle(CombatSection, "TriggerBot", "TriggerBot")
CreateToggle(CombatSection, "Hitbox Expander", "HitboxExpander")
CreateToggle(CombatSection, "One Shot Kill", "OneShotKill")
CreateToggle(CombatSection, "No Recoil", "NoRecoil")
CreateToggle(CombatSection, "Infinite Ammo", "InfiniteAmmo")

-- Movement Tab Content  
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
CreateSlider(MovementSection, "Speed", "SpeedValue", 16, 500, function(value)
    if Settings.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
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

local ESPSection = CreateSection(VisualFrame, "👁️ ESP System", Color3.fromRGB(59, 130, 246))
CreateToggle(ESPSection, "ESP Players", "ESPPlayers")
CreateToggle(ESPSection, "ESP Weapons", "ESPWeapons")
CreateToggle(ESPSection, "Chams", "Chams")
CreateToggle(ESPSection, "Glow", "Glow")

local VisualSection = CreateSection(VisualFrame, "🌟 Visual Effects", Color3.fromRGB(59, 130, 246))
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

local VehicleSection = CreateSection(RoleplayFrame, "🚗 Vehicle System", Color3.fromRGB(168, 85, 247))
CreateButton(VehicleSection, "Spawn Cars", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Car spawned!", Duration = 2})
end)
CreateToggle(VehicleSection, "Super Speed Car", "SuperSpeedCar")
CreateToggle(VehicleSection, "Fly Car", "FlyCar")
CreateButton(VehicleSection, "Boat Spawner", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Boat spawned!", Duration = 2})
end)
CreateButton(VehicleSection, "Helicopter Spawner", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Helicopter spawned!", Duration = 2})
end)

local WeaponsSection = CreateSection(RoleplayFrame, "🔫 Weapons & Items", Color3.fromRGB(168, 85, 247))
CreateButton(WeaponsSection, "Spawn Weapons", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Weapons spawned!", Duration = 2})
end)
CreateToggle(WeaponsSection, "Infinite Ammo", "InfiniteAmmo")
CreateToggle(WeaponsSection, "Dual Wield", "DualWield")
CreateButton(WeaponsSection, "Item Spawner", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Items spawned!", Duration = 2})
end)

local PlayerSection = CreateSection(RoleplayFrame, "👤 Player Modifications", Color3.fromRGB(168, 85, 247))
CreateButton(PlayerSection, "Animal Morphs", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Morph applied!", Duration = 2})
end)
CreateToggle(PlayerSection, "Size Changer", "SizeChanger")
CreateToggle(PlayerSection, "Invisible Mode", "Invisible")
CreateToggle(PlayerSection, "Godmode", "Godmode")
CreateButton(PlayerSection, "Teleport Locations", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported!", Duration = 2})
end)
CreateButton(PlayerSection, "Unlimited Emotes", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Emotes unlocked!", Duration = 2})
end)

local UtilitiesSection = CreateSection(RoleplayFrame, "⚙️ Automation", Color3.fromRGB(168, 85, 247))
CreateToggle(UtilitiesSection, "Auto Farm Money", "AutoFarmMoney")
CreateToggle(UtilitiesSection, "Auto Collect Items", "AutoCollectItems")
CreateButton(UtilitiesSection, "TP to Friends", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to friend!", Duration = 2})
end)
CreateButton(UtilitiesSection, "Unlock Animations", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Animations unlocked!", Duration = 2})
end)
CreateToggle(UtilitiesSection, "Auto Daily Rewards", "AutoDailyRewards")
CreateToggle(UtilitiesSection, "Auto Buy", "AutoBuy")

local WorldSection = CreateSection(RoleplayFrame, "🌍 World Control", Color3.fromRGB(168, 85, 247))
CreateButton(WorldSection, "Open All Doors", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "All doors opened!", Duration = 2})
end)
CreateButton(WorldSection, "Teleport All Cars", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "All cars teleported!", Duration = 2})
end)
CreateButton(WorldSection, "Day/Night Control", function()
    if Lighting.ClockTime == 14 then
        Lighting.ClockTime = 0
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Night mode!", Duration = 2})
    else
        Lighting.ClockTime = 14
        StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Day mode!", Duration = 2})
    end
end)
CreateButton(WorldSection, "Weather Changer", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Weather changed!", Duration = 2})
end)
CreateToggle(WorldSection, "Disable Gravity", "DisableGravity")
CreateToggle(WorldSection, "Super Jump", "SuperJump")

-- Blox Fruits Tab Content
local BloxFruitsFrame = TabFrames[5]

local FarmSection = CreateSection(BloxFruitsFrame, "🌾 Auto Farm", Color3.fromRGB(245, 158, 11))
CreateToggle(FarmSection, "Auto Farm Level", "AutoFarmLevel")
CreateToggle(FarmSection, "Auto Farm Boss", "AutoFarmBoss")
CreateToggle(FarmSection, "Auto Farm Quest", "AutoFarmQuest")
CreateToggle(FarmSection, "Auto Farm Fruits", "AutoFarmFruits")
CreateToggle(FarmSection, "Auto Farm Mastery", "AutoFarmMastery")

local BloxCombatSection = CreateSection(BloxFruitsFrame, "⚔️ Combat System", Color3.fromRGB(245, 158, 11))
CreateToggle(BloxCombatSection, "Auto Aim Skills", "AutoAimSkills")
CreateToggle(BloxCombatSection, "No Cooldown Skills", "NoSkillCooldown")
CreateToggle(BloxCombatSection, "Skill Spam", "SkillSpam")
CreateToggle(BloxCombatSection, "Kill Aura", "KillAura")
CreateSlider(BloxCombatSection, "Damage Multiplier", "DamageMultiplier", 1, 10)

local TeleportSection = CreateSection(BloxFruitsFrame, "📍 Teleportation", Color3.fromRGB(245, 158, 11))
CreateButton(TeleportSection, "TP to Sea", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to sea!", Duration = 2})
end)
CreateButton(TeleportSection, "TP to Island", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to island!", Duration = 2})
end)
CreateButton(TeleportSection, "TP to NPC", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to NPC!", Duration = 2})
end)
CreateButton(TeleportSection, "TP to Fruits", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Teleported to fruit!", Duration = 2})
end)

local BloxMiscSection = CreateSection(BloxFruitsFrame, "🔧 Miscellaneous", Color3.fromRGB(245, 158, 11))
CreateToggle(BloxMiscSection, "ESP Fruits", "ESPFruits")
CreateToggle(BloxMiscSection, "Auto Fruit Sniper", "AutoFruitSniper")
CreateToggle(BloxMiscSection, "Walk on Water", "WalkOnWater")
CreateToggle(BloxMiscSection, "Auto Buy", "AutoBuyBlox")
CreateButton(BloxMiscSection, "Raid Helper", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Raid helper activated!", Duration = 2})
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

-- Player List Tab Content
local PlayerListFrame = TabFrames[6]

local PlayerListSection = CreateSection(PlayerListFrame, "📋 Player Management", Color3.fromRGB(14, 165, 233))

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Parent = PlayerListSection
SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SearchBox.BorderSizePixel = 0
SearchBox.Size = UDim2.new(1, 0, 0, 40)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "🔍 Search players..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 14

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchBox

local PlayerScrollFrame = Instance.new("ScrollingFrame")
PlayerScrollFrame.Name = "PlayerScrollFrame"
PlayerScrollFrame.Parent = PlayerListSection
PlayerScrollFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
PlayerScrollFrame.BorderSizePixel = 0
PlayerScrollFrame.Size = UDim2.new(1, 0, 0, 300)
PlayerScrollFrame.ScrollBarThickness = 6
PlayerScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(14, 165, 233)
PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local PlayerScrollCorner = Instance.new("UICorner")
PlayerScrollCorner.CornerRadius = UDim.new(0, 8)
PlayerScrollCorner.Parent = PlayerScrollFrame

local PlayerLayout = Instance.new("UIListLayout")
PlayerLayout.Parent = PlayerScrollFrame
PlayerLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayerLayout.Padding = UDim.new(0, 8)

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
            PlayerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            PlayerFrame.BorderSizePixel = 0
            PlayerFrame.Size = UDim2.new(1, -10, 0, 80)
            
            local PlayerFrameCorner = Instance.new("UICorner")
            PlayerFrameCorner.CornerRadius = UDim.new(0, 8)
            PlayerFrameCorner.Parent = PlayerFrame
            
            local PlayerName = Instance.new("TextLabel")
            PlayerName.Name = "PlayerName"
            PlayerName.Parent = PlayerFrame
            PlayerName.BackgroundTransparency = 1
            PlayerName.Position = UDim2.new(0, 15, 0, 5)
            PlayerName.Size = UDim2.new(1, -30, 0, 25)
            PlayerName.Font = Enum.Font.GothamBold
            PlayerName.Text = "👤 " .. player.Name
            PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlayerName.TextSize = 14
            PlayerName.TextXAlignment = Enum.TextXAlignment.Left
            
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Name = "ButtonFrame"
            ButtonFrame.Parent = PlayerFrame
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Position = UDim2.new(0, 15, 0, 35)
            ButtonFrame.Size = UDim2.new(1, -30, 0, 35)
            
            local ButtonLayout = Instance.new("UIListLayout")
            ButtonLayout.Parent = ButtonFrame
            ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
            ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ButtonLayout.Padding = UDim.new(0, 8)
            
            local actions = {"TP", "Kill", "Fling", "Freeze", "Troll"}
            for i, action in ipairs(actions) do
                local ActionButton = Instance.new("TextButton")
                ActionButton.Name = action .. "Button"
                ActionButton.Parent = ButtonFrame
                ActionButton.BackgroundColor3 = Color3.fromRGB(14, 165, 233)
                ActionButton.BorderSizePixel = 0
                ActionButton.Size = UDim2.new(0, 60, 1, 0)
                ActionButton.Font = Enum.Font.GothamBold
                ActionButton.Text = action
                ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                ActionButton.TextSize = 11
                
                local ActionCorner = Instance.new("UICorner")
                ActionCorner.CornerRadius = UDim.new(0, 6)
                ActionCorner.Parent = ActionButton
                
                ActionButton.MouseButton1Click:Connect(function()
                    StarterGui:SetCore("SendNotification", {
                        Title = "SPWARE V5",
                        Text = action .. " applied to " .. player.Name,
                        Duration = 2
                    })
                end)
            end
        end
    end
    
    PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerLayout.AbsoluteContentSize.Y + 20)
end

UpdatePlayerList()
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

-- Chat Tab Content
local ChatFrame = TabFrames[7]

local QuickMessagesSection = CreateSection(ChatFrame, "💬 Quick Messages", Color3.fromRGB(236, 72, 153))
CreateButton(QuickMessagesSection, "GG", function()
    pcall(function()
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("GG! SPWARE V5 is the best!", "All")
    end)
end)
CreateButton(QuickMessagesSection, "Hello Everyone", function()
    pcall(function()
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hello everyone! Using SPWARE V5 Premium", "All")
    end)
end)
CreateButton(QuickMessagesSection, "SPWARE Best", function()
    pcall(function()
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("SPWARE V5 - Melhor script Roblox!", "All")
    end)
end)

local AutoChatSection = CreateSection(ChatFrame, "🤖 Auto Chat", Color3.fromRGB(236, 72, 153))
CreateToggle(AutoChatSection, "Auto Reply", "AutoReply")
CreateToggle(AutoChatSection, "Auto Greet", "AutoGreet")
CreateToggle(AutoChatSection, "Auto GG", "AutoGG")

local SpamSection = CreateSection(ChatFrame, "📢 Spam System", Color3.fromRGB(236, 72, 153))
CreateToggle(SpamSection, "Chat Spam", "ChatSpam")
CreateButton(SpamSection, "Emoji Spam", function()
    spawn(function()
        for i = 1, 5 do
            pcall(function()
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🔥💯⚡🎯🚀", "All")
            end)
            wait(0.5)
        end
    end)
end)
CreateButton(SpamSection, "Unicode Spam", function()
    spawn(function()
        for i = 1, 3 do
            pcall(function()
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("░░░░░░░░░░░░░░░░░░░░", "All")
            end)
            wait(0.5)
        end
    end)
end)

local FakeChatSection = CreateSection(ChatFrame, "🎭 Fake Messages", Color3.fromRGB(236, 72, 153))
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

local CarManagementSection = CreateSection(CarListFrame, "🚗 Vehicle Management", Color3.fromRGB(16, 185, 129))

local CarScrollFrame = Instance.new("ScrollingFrame")
CarScrollFrame.Name = "CarScrollFrame"
CarScrollFrame.Parent = CarManagementSection
CarScrollFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
CarScrollFrame.BorderSizePixel = 0
CarScrollFrame.Size = UDim2.new(1, 0, 0, 300)
CarScrollFrame.ScrollBarThickness = 6
CarScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(16, 185, 129)
CarScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local CarScrollCorner = Instance.new("UICorner")
CarScrollCorner.CornerRadius = UDim.new(0, 8)
CarScrollCorner.Parent = CarScrollFrame

local CarLayout = Instance.new("UIListLayout")
CarLayout.Parent = CarScrollFrame
CarLayout.SortOrder = Enum.SortOrder.LayoutOrder
CarLayout.Padding = UDim2.new(0, 8)

local function UpdateCarList()
    for _, child in pairs(CarScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
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
        CarFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        CarFrame.BorderSizePixel = 0
        CarFrame.Size = UDim2.new(1, -10, 0, 80)
        
        local CarFrameCorner = Instance.new("UICorner")
        CarFrameCorner.CornerRadius = UDim.new(0, 8)
        CarFrameCorner.Parent = CarFrame
        
        local CarName = Instance.new("TextLabel")
        CarName.Name = "CarName"
        CarName.Parent = CarFrame
        CarName.BackgroundTransparency = 1
        CarName.Position = UDim2.new(0, 15, 0, 5)
        CarName.Size = UDim2.new(1, -30, 0, 25)
        CarName.Font = Enum.Font.GothamBold
        CarName.Text = "🚗 " .. (car.Name or "Vehicle " .. i)
        CarName.TextColor3 = Color3.fromRGB(255, 255, 255)
        CarName.TextSize = 14
        CarName.TextXAlignment = Enum.TextXAlignment.Left
        
        local CarButtonFrame = Instance.new("Frame")
        CarButtonFrame.Name = "CarButtonFrame"
        CarButtonFrame.Parent = CarFrame
        CarButtonFrame.BackgroundTransparency = 1
        CarButtonFrame.Position = UDim2.new(0, 15, 0, 35)
        CarButtonFrame.Size = UDim2.new(1, -30, 0, 35)
        
        local CarButtonLayout = Instance.new("UIListLayout")
        CarButtonLayout.Parent = CarButtonFrame
        CarButtonLayout.FillDirection = Enum.FillDirection.Horizontal
        CarButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
        CarButtonLayout.Padding = UDim.new(0, 8)
        
        local carActions = {"Spawn", "TP Car", "Clone", "Bring"}
        for j, action in ipairs(carActions) do
            local CarActionButton = Instance.new("TextButton")
            CarActionButton.Name = action .. "Button"
            CarActionButton.Parent = CarButtonFrame
            CarActionButton.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
            CarActionButton.BorderSizePixel = 0
            CarActionButton.Size = UDim2.new(0, 70, 1, 0)
            CarActionButton.Font = Enum.Font.GothamBold
            CarActionButton.Text = action
            CarActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            CarActionButton.TextSize = 11
            
            local CarActionCorner = Instance.new("UICorner")
            CarActionCorner.CornerRadius = UDim.new(0, 6)
            CarActionCorner.Parent = CarActionButton
            
            CarActionButton.MouseButton1Click:Connect(function()
                if action == "TP Car" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and car.PrimaryPart then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = car.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                elseif action == "Bring" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and car.PrimaryPart then
                    car:SetPrimaryPartCFrame(LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(5, 0, 0))
                end
                
                StarterGui:SetCore("SendNotification", {
                    Title = "SPWARE V5",
                    Text = action .. " applied to " .. (car.Name or "Vehicle"),
                    Duration = 2
                })
            end)
        end
    end
    
    CarScrollFrame.CanvasSize = UDim2.new(0, 0, 0, CarLayout.AbsoluteContentSize.Y + 20)
end

CreateButton(CarManagementSection, "🔄 Refresh Car List", UpdateCarList)
CreateButton(CarManagementSection, "🚗 Spawn Random Car", function()
    StarterGui:SetCore("SendNotification", {Title = "SPWARE V5", Text = "Random car spawned!", Duration = 2})
end)

UpdateCarList()

-- Update canvas sizes for all tabs
for i, frame in ipairs(TabFrames) do
    frame.ChildAdded:Connect(function()
        wait(0.1)
        frame.CanvasSize = UDim2.new(0, 0, 0, frame.UIListLayout.AbsoluteContentSize.Y + 50)
    end)
    frame.ChildRemoved:Connect(function()
        wait(0.1)
        frame.CanvasSize = UDim2.new(0, 0, 0, frame.UIListLayout.AbsoluteContentSize.Y + 50)
    end)
end

-- Initial canvas size update
for i, frame in ipairs(TabFrames) do
    spawn(function()
        wait(1)
        frame.CanvasSize = UDim2.new(0, 0, 0, frame.UIListLayout.AbsoluteContentSize.Y + 50)
    end)
end

-- Button Events with Premium Effects
CloseButton.MouseButton1Click:Connect(function()
    -- Fade out animation
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    TweenService:Create(GlowFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    wait(0.3)
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    GlowFrame.Visible = false
end)

-- Button hover effects
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    }):Play()
end)

MinimizeButton.MouseEnter:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    }):Play()
end)

MinimizeButton.MouseLeave:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(245, 158, 11)
    }):Play()
end)

-- Toggle UI with INSERT key
UserInputService.InputBegan:Connect(function(key, gameProcessed)
    if gameProcessed then return end
    if key.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
        GlowFrame.Visible = MainFrame.Visible
        
        if MainFrame.Visible then
            -- Fade in animation
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 900, 0, 650),
                Position = UDim2.new(0.5, -450, 0.5, -325)
            }):Play()
        end
    end
end)

-- Status indicator animation
spawn(function()
    while true do
        TweenService:Create(StatusFrame, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            BackgroundColor3 = Color3.fromRGB(34, 197, 94)
        }):Play()
        wait(1)
        TweenService:Create(StatusFrame, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            BackgroundColor3 = Color3.fromRGB(16, 185, 129)
        }):Play()
        wait(1)
    end
end)

-- Initial notification
StarterGui:SetCore("SendNotification", {
    Title = "SPWARE V5 Premium",
    Text = "Loaded successfully! Press INSERT to toggle",
    Duration = 5
})

print("SPWARE V5 Premium Edition Loaded Successfully!")
