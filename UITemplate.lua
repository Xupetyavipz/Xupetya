-- 🎨 SPWARE UI TEMPLATE - Clean Base UI for Future Projects
-- Created by: Spware Team
-- Version: 2.0
-- Description: Professional UI template with modern glass design

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- 🎨 MODERN THEME SYSTEM
local Theme = {
    Primary = Color3.fromRGB(15, 15, 20),
    Secondary = Color3.fromRGB(25, 25, 35),
    Glass = Color3.fromRGB(35, 35, 50),
    Accent = Color3.fromRGB(100, 150, 255),
    AccentGlow = Color3.fromRGB(120, 180, 255),
    Success = Color3.fromRGB(100, 255, 150),
    Warning = Color3.fromRGB(255, 180, 100),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 200),
    Stroke = Color3.fromRGB(60, 60, 80)
}

-- 📱 CREATE MAIN SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpwareUI"
ScreenGui.Parent = Player.PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 🖱️ CUSTOM CURSOR SYSTEM
local CustomCursor = Instance.new("ImageLabel")
CustomCursor.Name = "CustomCursor"
CustomCursor.Parent = ScreenGui
CustomCursor.BackgroundTransparency = 1
CustomCursor.Size = UDim2.new(0, 32, 0, 32)
CustomCursor.Image = "rbxassetid://8560915132"
CustomCursor.ImageColor3 = Theme.Accent
CustomCursor.ZIndex = 1000
CustomCursor.Visible = true

-- Update cursor position
local function updateCursor()
    local mouse = Player:GetMouse()
    CustomCursor.Position = UDim2.new(0, mouse.X - 16, 0, mouse.Y - 16)
end

-- Connect cursor movement
local cursorConnection = UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        updateCursor()
    end
end)

-- 🌟 MAIN CONTAINER WITH GLASS EFFECT
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Parent = ScreenGui
MainContainer.BackgroundColor3 = Theme.Primary
MainContainer.BackgroundTransparency = 0.1
MainContainer.BorderSizePixel = 0
MainContainer.Position = UDim2.new(0.5, -600, 0.5, -350)
MainContainer.Size = UDim2.new(0, 1200, 0, 700)
MainContainer.Active = true
MainContainer.Draggable = true
MainContainer.ZIndex = 1

-- Glass effect corner
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainContainer

-- Premium glow stroke
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.AccentGlow
MainStroke.Thickness = 2
MainStroke.Transparency = 0.4
MainStroke.Parent = MainContainer

-- Glass gradient
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.Primary),
    ColorSequenceKeypoint.new(0.5, Theme.Glass),
    ColorSequenceKeypoint.new(1, Theme.Secondary)
}
MainGradient.Rotation = 135
MainGradient.Parent = MainContainer

-- 🎯 PROFESSIONAL HEADER
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainContainer
Header.BackgroundColor3 = Theme.Secondary
Header.BackgroundTransparency = 0.2
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 60)
Header.ZIndex = 2

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local HeaderStroke = Instance.new("UIStroke")
HeaderStroke.Color = Theme.Stroke
HeaderStroke.Thickness = 1
HeaderStroke.Transparency = 0.6
HeaderStroke.Parent = Header

-- Title with premium styling
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "SPWARE ULTIMATE"
Title.TextColor3 = Theme.Text
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3

-- Version badge
local VersionBadge = Instance.new("Frame")
VersionBadge.Name = "VersionBadge"
VersionBadge.Parent = Header
VersionBadge.BackgroundColor3 = Theme.Accent
VersionBadge.BackgroundTransparency = 0.2
VersionBadge.BorderSizePixel = 0
VersionBadge.Position = UDim2.new(0, 220, 0.3, 0)
VersionBadge.Size = UDim2.new(0, 60, 0, 25)
VersionBadge.ZIndex = 3

local BadgeCorner = Instance.new("UICorner")
BadgeCorner.CornerRadius = UDim.new(0, 12)
BadgeCorner.Parent = VersionBadge

local VersionText = Instance.new("TextLabel")
VersionText.Parent = VersionBadge
VersionText.BackgroundTransparency = 1
VersionText.Size = UDim2.new(1, 0, 1, 0)
VersionText.Font = Enum.Font.GothamBold
VersionText.Text = "v2.5"
VersionText.TextColor3 = Theme.Text
VersionText.TextSize = 12
VersionText.ZIndex = 4

-- Close button with hover effect
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = Header
CloseButton.BackgroundColor3 = Theme.Warning
CloseButton.BackgroundTransparency = 0.8
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -50, 0.2, 0)
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Theme.Text
CloseButton.TextSize = 18
CloseButton.ZIndex = 3

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- 🎯 PROFESSIONAL SIDEBAR NAVIGATION
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainContainer
Sidebar.BackgroundColor3 = Theme.Secondary
Sidebar.BackgroundTransparency = 0.15
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 60)
Sidebar.Size = UDim2.new(0, 250, 1, -60)
Sidebar.ZIndex = 2

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 0)
SidebarCorner.Parent = Sidebar

local SidebarStroke = Instance.new("UIStroke")
SidebarStroke.Color = Theme.Stroke
SidebarStroke.Thickness = 1
SidebarStroke.Transparency = 0.8
SidebarStroke.Parent = Sidebar

local NavLayout = Instance.new("UIListLayout")
NavLayout.Parent = Sidebar
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Padding = UDim.new(0, 10)

local NavPadding = Instance.new("UIPadding")
NavPadding.PaddingTop = UDim.new(0, 20)
NavPadding.PaddingLeft = UDim.new(0, 15)
NavPadding.PaddingRight = UDim.new(0, 15)
NavPadding.Parent = Sidebar

-- 📱 MAIN CONTENT AREA
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainContainer
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.Position = UDim2.new(0, 250, 0, 60)
ContentArea.Size = UDim2.new(1, -250, 1, -60)
ContentArea.ZIndex = 2

-- Content area styling
local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = ContentArea

-- 🔧 UI COMPONENT CREATION FUNCTIONS
local function createToggle(parent, text, defaultValue, callback)
    local ToggleContainer = Instance.new("Frame")
    ToggleContainer.Name = text .. "Toggle"
    ToggleContainer.Parent = parent
    ToggleContainer.BackgroundColor3 = Theme.Glass
    ToggleContainer.BackgroundTransparency = 0.3
    ToggleContainer.BorderSizePixel = 0
    ToggleContainer.Size = UDim2.new(1, -20, 0, 60)
    ToggleContainer.ZIndex = 4
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 12)
    ToggleCorner.Parent = ToggleContainer
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Theme.Stroke
    ToggleStroke.Thickness = 1
    ToggleStroke.Transparency = 0.6
    ToggleStroke.Parent = ToggleContainer
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Parent = ToggleContainer
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 20, 0, 0)
    ToggleLabel.Size = UDim2.new(1, -120, 1, 0)
    ToggleLabel.Font = Enum.Font.GothamMedium
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Theme.Text
    ToggleLabel.TextSize = 16
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.ZIndex = 5
    
    local ToggleSwitch = Instance.new("Frame")
    ToggleSwitch.Parent = ToggleContainer
    ToggleSwitch.BackgroundColor3 = defaultValue and Theme.Success or Theme.TextSecondary
    ToggleSwitch.BackgroundTransparency = 0.2
    ToggleSwitch.BorderSizePixel = 0
    ToggleSwitch.Position = UDim2.new(1, -80, 0.25, 0)
    ToggleSwitch.Size = UDim2.new(0, 60, 0, 30)
    ToggleSwitch.ZIndex = 5
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = ToggleSwitch
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Parent = ToggleSwitch
    ToggleButton.BackgroundColor3 = Theme.Text
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = defaultValue and UDim2.new(1, -28, 0.1, 0) or UDim2.new(0, 2, 0.1, 0)
    ToggleButton.Size = UDim2.new(0, 24, 0, 24)
    ToggleButton.Text = ""
    ToggleButton.ZIndex = 6
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(1, 0)
    ButtonCorner.Parent = ToggleButton
    
    local isEnabled = defaultValue
    ToggleButton.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        
        TweenService:Create(ToggleSwitch, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            BackgroundColor3 = isEnabled and Theme.Success or Theme.TextSecondary
        }):Play()
        
        TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            Position = isEnabled and UDim2.new(1, -28, 0.1, 0) or UDim2.new(0, 2, 0.1, 0)
        }):Play()
        
        if callback then callback(isEnabled) end
    end)
    
    return ToggleContainer
end

local function createSlider(parent, text, minVal, maxVal, defaultVal, callback)
    local SliderContainer = Instance.new("Frame")
    SliderContainer.Name = text .. "Slider"
    SliderContainer.Parent = parent
    SliderContainer.BackgroundColor3 = Theme.Glass
    SliderContainer.BackgroundTransparency = 0.3
    SliderContainer.BorderSizePixel = 0
    SliderContainer.Size = UDim2.new(1, -20, 0, 100)
    SliderContainer.ZIndex = 4
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 12)
    SliderCorner.Parent = SliderContainer
    
    local SliderStroke = Instance.new("UIStroke")
    SliderStroke.Color = Theme.Stroke
    SliderStroke.Thickness = 1
    SliderStroke.Transparency = 0.6
    SliderStroke.Parent = SliderContainer
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Parent = SliderContainer
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Position = UDim2.new(0, 20, 0, 10)
    SliderLabel.Size = UDim2.new(1, -40, 0, 30)
    SliderLabel.Font = Enum.Font.GothamMedium
    SliderLabel.Text = text .. ": " .. defaultVal
    SliderLabel.TextColor3 = Theme.Text
    SliderLabel.TextSize = 16
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.ZIndex = 5
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Parent = SliderContainer
    SliderTrack.BackgroundColor3 = Theme.TextSecondary
    SliderTrack.BackgroundTransparency = 0.4
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Position = UDim2.new(0, 20, 0, 50)
    SliderTrack.Size = UDim2.new(1, -40, 0, 8)
    SliderTrack.ZIndex = 5
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Parent = SliderTrack
    SliderFill.BackgroundColor3 = Theme.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    SliderFill.ZIndex = 6
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = SliderFill
    
    local SliderHandle = Instance.new("TextButton")
    SliderHandle.Parent = SliderTrack
    SliderHandle.BackgroundColor3 = Theme.Text
    SliderHandle.BorderSizePixel = 0
    SliderHandle.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -8, 0.5, -8)
    SliderHandle.Size = UDim2.new(0, 16, 0, 16)
    SliderHandle.Text = ""
    SliderHandle.ZIndex = 7
    
    local HandleCorner = Instance.new("UICorner")
    HandleCorner.CornerRadius = UDim.new(1, 0)
    HandleCorner.Parent = SliderHandle
    
    local currentValue = defaultVal
    local dragging = false
    
    SliderHandle.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = Player:GetMouse()
            local relativeX = math.clamp((mouse.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
            currentValue = math.floor(minVal + (maxVal - minVal) * relativeX)
            
            SliderLabel.Text = text .. ": " .. currentValue
            SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            SliderHandle.Position = UDim2.new(relativeX, -8, 0.5, -8)
            
            if callback then callback(currentValue) end
        end
    end)
    
    return SliderContainer
end

-- WINDOW CONTROLS & ANIMATIONS
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
        BackgroundColor3 = Color3.fromRGB(255, 100, 100),
        Size = UDim2.new(0, 32, 0, 32)
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
        BackgroundColor3 = Theme.Glass,
        Size = UDim2.new(0, 30, 0, 30)
    }):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    -- Restore default cursor when closing menu
    UserInputService.MouseIconEnabled = true
    CustomCursor.Visible = false
    if cursorConnection then
        cursorConnection:Disconnect()
    end
    
    TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    wait(0.3)
    ScreenGui:Destroy()
end)

-- 🎨 EXAMPLE USAGE (Remove this section for clean template)
--[[
-- Example: Create a toggle
createToggle(ContentArea, "Example Toggle", false, function(enabled)
    print("Toggle:", enabled)
end)

-- Example: Create a slider  
createSlider(ContentArea, "Example Slider", 1, 100, 50, function(value)
    print("Slider:", value)
end)
--]]

print("🎨 Spware UI Template Loaded Successfully!")
