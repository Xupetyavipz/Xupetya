-- SPWARE V6 - Complete Roblox Cheat UI
-- Purple/Black Theme with All Features

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Variables
local SPWARE = {}
SPWARE.UI = {}
SPWARE.Settings = {
    UIVisible = false,
    PlayerListVisible = false,
    CarListVisible = false
}

-- Colors
local Colors = {
    Background = Color3.fromRGB(20, 20, 20),
    Surface = Color3.fromRGB(30, 30, 30),
    Primary = Color3.fromRGB(138, 43, 226), -- Purple
    Secondary = Color3.fromRGB(75, 0, 130), -- Dark Purple
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(200, 200, 200),
    Success = Color3.fromRGB(46, 204, 113),
    Warning = Color3.fromRGB(241, 196, 15),
    Error = Color3.fromRGB(231, 76, 60)
}

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SPWARE_V6"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
MainFrame.Size = UDim2.new(0, 800, 0, 600)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Add corner radius
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Colors.Primary
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Fix corner for title bar
local TitleFix = Instance.new("Frame")
TitleFix.Parent = TitleBar
TitleFix.BackgroundColor3 = Colors.Primary
TitleFix.BorderSizePixel = 0
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)

-- Title Text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Size = UDim2.new(1, -100, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "SPWARE V6 - Premium Cheat"
TitleText.TextColor3 = Colors.Text
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Colors.Error
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Colors.Text
CloseButton.TextSize = 18

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Colors.Warning
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Colors.Text
MinimizeButton.TextSize = 18

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 4)
MinimizeCorner.Parent = MinimizeButton

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)

-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = ContentFrame
TabContainer.BackgroundColor3 = Colors.Surface
TabContainer.BorderSizePixel = 0
TabContainer.Size = UDim2.new(0, 150, 1, 0)

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 6)
TabCorner.Parent = TabContainer

-- Tab List Layout
local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabContainer
TabListLayout.FillDirection = Enum.FillDirection.Vertical
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 2)

-- Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = ContentFrame
ContentContainer.BackgroundColor3 = Colors.Surface
ContentContainer.BorderSizePixel = 0
ContentContainer.Position = UDim2.new(0, 155, 0, 0)
ContentContainer.Size = UDim2.new(1, -155, 1, 0)

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 6)
ContentCorner.Parent = ContentContainer

-- Tabs Data
local TabsData = {
    {
        Name = "Combat",
        Icon = "⚔️",
        Content = "CombatTab"
    },
    {
        Name = "Roleplay",
        Icon = "🎭",
        Content = "RoleplayTab"
    },
    {
        Name = "Blox Fruits",
        Icon = "🥭",
        Content = "BloxFruitsTab"
    },
    {
        Name = "Player List",
        Icon = "📋",
        Content = "PlayerListTab"
    },
    {
        Name = "Chat",
        Icon = "💬",
        Content = "ChatTab"
    }
}

-- Current Tab
local CurrentTab = "Combat"

-- Create Tab Function
function CreateTab(tabData, index)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabData.Name .. "Tab"
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = (tabData.Name == CurrentTab) and Colors.Primary or Color3.fromRGB(40, 40, 40)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, -10, 0, 40)
    TabButton.Position = UDim2.new(0, 5, 0, 0)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = tabData.Icon .. " " .. tabData.Name
    TabButton.TextColor3 = Colors.Text
    TabButton.TextSize = 14
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.LayoutOrder = index

    local TabButtonCorner = Instance.new("UICorner")
    TabButtonCorner.CornerRadius = UDim.new(0, 4)
    TabButtonCorner.Parent = TabButton

    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabButton
    TabPadding.PaddingLeft = UDim.new(0, 10)

    -- Tab Click Event
    TabButton.MouseButton1Click:Connect(function()
        SwitchTab(tabData.Name)
    end)

    return TabButton
end

-- Switch Tab Function
function SwitchTab(tabName)
    CurrentTab = tabName
    
    -- Update tab buttons
    for _, child in pairs(TabContainer:GetChildren()) do
        if child:IsA("TextButton") then
            if child.Name == tabName .. "Tab" then
                child.BackgroundColor3 = Colors.Primary
            else
                child.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
        end
    end
    
    -- Update content
    for _, child in pairs(ContentContainer:GetChildren()) do
        if child:IsA("ScrollingFrame") then
            child.Visible = (child.Name == tabName .. "Content")
        end
    end
end

-- Create all tabs
for i, tabData in ipairs(TabsData) do
    CreateTab(tabData, i)
end

-- Notification System
function ShowNotification(message, color)
    color = color or Colors.Success
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Name = "Notification"
    NotificationFrame.Parent = ScreenGui
    NotificationFrame.BackgroundColor3 = color
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.Position = UDim2.new(1, -320, 0, 20)
    NotificationFrame.Size = UDim2.new(0, 300, 0, 60)
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 6)
    NotifCorner.Parent = NotificationFrame
    
    local NotifText = Instance.new("TextLabel")
    NotifText.Parent = NotificationFrame
    NotifText.BackgroundTransparency = 1
    NotifText.Size = UDim2.new(1, -20, 1, 0)
    NotifText.Position = UDim2.new(0, 10, 0, 0)
    NotifText.Font = Enum.Font.Gotham
    NotifText.Text = message
    NotifText.TextColor3 = Colors.Text
    NotifText.TextSize = 12
    NotifText.TextWrapped = true
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Animate in
    NotificationFrame:TweenPosition(
        UDim2.new(1, -320, 0, 20),
        "Out", "Quad", 0.3, true
    )
    
    -- Auto remove after 3 seconds
    game:GetService("Debris"):AddItem(NotificationFrame, 3)
    
    -- Animate out
    wait(2.5)
    NotificationFrame:TweenPosition(
        UDim2.new(1, 0, 0, 20),
        "In", "Quad", 0.3, true
    )
end
