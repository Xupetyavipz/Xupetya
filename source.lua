-- ╔══════════════════════════════════════════════════════════════╗
-- ║                 PROFESSIONAL CHEAT UI V2.0                  ║
-- ║              Inspired by Synapse X & Modern Executors       ║
-- ╚══════════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cleanup
if _G.ProfessionalUI then
    _G.ProfessionalUI:Destroy()
end

-- ═══════════════════════════════════════════════════════════════
-- 🎨 PROFESSIONAL THEME
-- ═══════════════════════════════════════════════════════════════
local Theme = {
    -- Main colors
    Background = Color3.fromRGB(24, 24, 27),
    Surface = Color3.fromRGB(39, 39, 42),
    Elevated = Color3.fromRGB(52, 52, 56),
    
    -- Accent colors
    Primary = Color3.fromRGB(99, 102, 241),
    Secondary = Color3.fromRGB(168, 85, 247),
    Success = Color3.fromRGB(34, 197, 94),
    Warning = Color3.fromRGB(251, 191, 36),
    Error = Color3.fromRGB(239, 68, 68),
    
    -- Text colors
    TextPrimary = Color3.fromRGB(248, 250, 252),
    TextSecondary = Color3.fromRGB(148, 163, 184),
    TextMuted = Color3.fromRGB(100, 116, 139),
    
    -- Border and dividers
    Border = Color3.fromRGB(71, 85, 105),
    Divider = Color3.fromRGB(51, 65, 85),
}

-- ═══════════════════════════════════════════════════════════════
-- 🔧 INTEGRATED FUNCTIONS
-- ═══════════════════════════════════════════════════════════════
local Functions = {}
local connections = {}

function Functions.toggleAimbot(enabled)
    print("🎯 Aimbot:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleESP(enabled)
    print("👁️ ESP:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleSpeed(enabled, value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = enabled and (value or 100) or 16
    end
    print("🏃 Speed:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleFly(enabled)
    print("🛸 Fly:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleNoclip(enabled)
    if enabled then
        connections.noclip = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if connections.noclip then
            connections.noclip:Disconnect()
            connections.noclip = nil
        end
    end
    print("👻 Noclip:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleFullbright(enabled)
    if enabled then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
    end
    print("💡 Fullbright:", enabled and "ENABLED" or "DISABLED")
end

-- ═══════════════════════════════════════════════════════════════
-- 📋 UI CONFIGURATION
-- ═══════════════════════════════════════════════════════════════
local TabData = {
    {
        name = "Combat",
        icon = "🎯",
        color = Theme.Error,
        sections = {
            {
                title = "Aimbot",
                items = {
                    {type = "toggle", name = "Enable Aimbot", func = Functions.toggleAimbot},
                    {type = "slider", name = "FOV", min = 10, max = 360, default = 90},
                    {type = "slider", name = "Smoothness", min = 1, max = 20, default = 5},
                    {type = "dropdown", name = "Target Bone", options = {"Head", "Torso", "Random"}},
                }
            },
            {
                title = "Weapons",
                items = {
                    {type = "toggle", name = "No Recoil", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Rapid Fire", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Infinite Ammo", func = Functions.toggleAimbot},
                    {type = "slider", name = "Damage Multiplier", min = 1, max = 10, default = 1},
                }
            }
        }
    },
    {
        name = "Visuals",
        icon = "👁️",
        color = Theme.Primary,
        sections = {
            {
                title = "ESP",
                items = {
                    {type = "toggle", name = "Player ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "Item ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "Vehicle ESP", func = Functions.toggleESP},
                    {type = "slider", name = "ESP Distance", min = 100, max = 5000, default = 1000},
                }
            },
            {
                title = "World",
                items = {
                    {type = "toggle", name = "Fullbright", func = Functions.toggleFullbright},
                    {type = "toggle", name = "No Fog", func = Functions.toggleFullbright},
                    {type = "slider", name = "FOV", min = 60, max = 120, default = 70},
                    {type = "dropdown", name = "Skybox", options = {"Default", "Space", "Sunset"}},
                }
            }
        }
    },
    {
        name = "Movement",
        icon = "🏃",
        color = Theme.Success,
        sections = {
            {
                title = "Speed",
                items = {
                    {type = "toggle", name = "Speed Hack", func = function(e) Functions.toggleSpeed(e, 100) end},
                    {type = "slider", name = "Walk Speed", min = 16, max = 500, default = 100},
                    {type = "toggle", name = "Jump Boost", func = Functions.toggleSpeed},
                    {type = "slider", name = "Jump Power", min = 50, max = 500, default = 150},
                }
            },
            {
                title = "Flight",
                items = {
                    {type = "toggle", name = "Fly Mode", func = Functions.toggleFly},
                    {type = "slider", name = "Fly Speed", min = 10, max = 200, default = 50},
                    {type = "toggle", name = "Noclip", func = Functions.toggleNoclip},
                    {type = "toggle", name = "Infinite Jump", func = Functions.toggleSpeed},
                }
            }
        }
    },
    {
        name = "Player",
        icon = "👤",
        color = Theme.Warning,
        sections = {
            {
                title = "Character",
                items = {
                    {type = "toggle", name = "God Mode", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Invisible", func = Functions.toggleAimbot},
                    {type = "button", name = "Reset Character"},
                    {type = "button", name = "Respawn"},
                }
            }
        }
    },
    {
        name = "World",
        icon = "🌍",
        color = Theme.Secondary,
        sections = {
            {
                title = "Teleport",
                items = {
                    {type = "button", name = "Teleport to Spawn"},
                    {type = "button", name = "Teleport to Players"},
                    {type = "toggle", name = "Click TP", func = Functions.toggleAimbot},
                }
            }
        }
    },
    {
        name = "Misc",
        icon = "⚙️",
        color = Theme.TextSecondary,
        sections = {
            {
                title = "Automation",
                items = {
                    {type = "toggle", name = "Auto Farm", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Anti AFK", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Auto Collect", func = Functions.toggleAimbot},
                }
            }
        }
    }
}

-- ═══════════════════════════════════════════════════════════════
-- 🏗️ UI CREATION
-- ═══════════════════════════════════════════════════════════════

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ProfessionalUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 950, 0, 650)
mainFrame.Position = UDim2.new(0.5, -475, 0.5, -325)
mainFrame.BackgroundColor3 = Theme.Background
mainFrame.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Drop shadow
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Parent = screenGui
shadow.Size = UDim2.new(0, 970, 0, 670)
shadow.Position = UDim2.new(0.5, -485, 0.5, -335)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.BorderSizePixel = 0
shadow.ZIndex = -1

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- ═══════════════════════════════════════════════════════════════
-- 📱 HEADER
-- ═══════════════════════════════════════════════════════════════
local header = Instance.new("Frame")
header.Name = "Header"
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Theme.Surface
header.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Fix bottom corners
local headerFix = Instance.new("Frame")
headerFix.Parent = header
headerFix.Size = UDim2.new(1, 0, 0, 12)
headerFix.Position = UDim2.new(0, 0, 1, -12)
headerFix.BackgroundColor3 = Theme.Surface
headerFix.BorderSizePixel = 0

-- Title
local title = Instance.new("TextLabel")
title.Parent = header
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ CHEAT MENU"
title.TextColor3 = Theme.TextPrimary
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Status
local status = Instance.new("Frame")
status.Parent = header
status.Size = UDim2.new(0, 80, 0, 24)
status.Position = UDim2.new(1, -200, 0.5, -12)
status.BackgroundColor3 = Theme.Success
status.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 12)
statusCorner.Parent = status

local statusText = Instance.new("TextLabel")
statusText.Parent = status
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "ONLINE"
statusText.TextColor3 = Theme.TextPrimary
statusText.TextSize = 12
statusText.Font = Enum.Font.GothamBold

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = header
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -45, 0.5, -15)
closeBtn.BackgroundColor3 = Theme.Error
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Theme.TextPrimary
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 6)
closeBtnCorner.Parent = closeBtn

-- ═══════════════════════════════════════════════════════════════
-- 📂 SIDEBAR
-- ═══════════════════════════════════════════════════════════════
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Parent = mainFrame
sidebar.Size = UDim2.new(0, 180, 1, -60)
sidebar.Position = UDim2.new(0, 0, 0, 60)
sidebar.BackgroundColor3 = Theme.Surface
sidebar.BorderSizePixel = 0

-- Tab container
local tabContainer = Instance.new("Frame")
tabContainer.Parent = sidebar
tabContainer.Size = UDim2.new(1, -10, 1, -10)
tabContainer.Position = UDim2.new(0, 5, 0, 5)
tabContainer.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = tabContainer
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 4)

-- ═══════════════════════════════════════════════════════════════
-- 📄 CONTENT AREA
-- ═══════════════════════════════════════════════════════════════
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Parent = mainFrame
contentArea.Size = UDim2.new(1, -180, 1, -60)
contentArea.Position = UDim2.new(0, 180, 0, 60)
contentArea.BackgroundColor3 = Theme.Background
contentArea.BorderSizePixel = 0

-- Content scroll
local contentScroll = Instance.new("ScrollingFrame")
contentScroll.Parent = contentArea
contentScroll.Size = UDim2.new(1, -20, 1, -20)
contentScroll.Position = UDim2.new(0, 10, 0, 10)
contentScroll.BackgroundTransparency = 1
contentScroll.BorderSizePixel = 0
contentScroll.ScrollBarThickness = 6
contentScroll.ScrollBarImageColor3 = Theme.Primary

local contentLayout = Instance.new("UIListLayout")
contentLayout.Parent = contentScroll
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 15)

-- ═══════════════════════════════════════════════════════════════
-- 🔧 UI ELEMENT CREATORS
-- ═══════════════════════════════════════════════════════════════

local function createTab(tabData, index)
    local tab = Instance.new("TextButton")
    tab.Name = tabData.name
    tab.Parent = tabContainer
    tab.Size = UDim2.new(1, 0, 0, 45)
    tab.BackgroundColor3 = Theme.Elevated
    tab.BorderSizePixel = 0
    tab.Text = ""
    tab.LayoutOrder = index
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tab
    
    local icon = Instance.new("TextLabel")
    icon.Parent = tab
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(0, 15, 0.5, -10)
    icon.BackgroundTransparency = 1
    icon.Text = tabData.icon
    icon.TextColor3 = tabData.color
    icon.TextSize = 16
    icon.Font = Enum.Font.Gotham
    
    local label = Instance.new("TextLabel")
    label.Parent = tab
    label.Size = UDim2.new(1, -45, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = tabData.name
    label.TextColor3 = Theme.TextSecondary
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    return tab, icon, label
end

local function createSection(sectionData)
    local section = Instance.new("Frame")
    section.Name = sectionData.title
    section.Parent = contentScroll
    section.Size = UDim2.new(1, 0, 0, 0)
    section.BackgroundColor3 = Theme.Surface
    section.BorderSizePixel = 0
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 8)
    sectionCorner.Parent = section
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Parent = section
    sectionTitle.Size = UDim2.new(1, -20, 0, 40)
    sectionTitle.Position = UDim2.new(0, 10, 0, 0)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = sectionData.title
    sectionTitle.TextColor3 = Theme.TextPrimary
    sectionTitle.TextSize = 16
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local itemContainer = Instance.new("Frame")
    itemContainer.Parent = section
    itemContainer.Size = UDim2.new(1, -20, 1, -50)
    itemContainer.Position = UDim2.new(0, 10, 0, 40)
    itemContainer.BackgroundTransparency = 1
    
    local itemLayout = Instance.new("UIListLayout")
    itemLayout.Parent = itemContainer
    itemLayout.SortOrder = Enum.SortOrder.LayoutOrder
    itemLayout.Padding = UDim.new(0, 8)
    
    local totalHeight = 50
    
    for i, item in ipairs(sectionData.items) do
        if item.type == "toggle" then
            local toggle = Instance.new("Frame")
            toggle.Parent = itemContainer
            toggle.Size = UDim2.new(1, 0, 0, 35)
            toggle.BackgroundColor3 = Theme.Elevated
            toggle.BorderSizePixel = 0
            toggle.LayoutOrder = i
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggle
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Parent = toggle
            toggleLabel.Size = UDim2.new(1, -60, 1, 0)
            toggleLabel.Position = UDim2.new(0, 12, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = item.name
            toggleLabel.TextColor3 = Theme.TextPrimary
            toggleLabel.TextSize = 14
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local switch = Instance.new("TextButton")
            switch.Parent = toggle
            switch.Size = UDim2.new(0, 40, 0, 20)
            switch.Position = UDim2.new(1, -50, 0.5, -10)
            switch.BackgroundColor3 = Theme.Border
            switch.BorderSizePixel = 0
            switch.Text = ""
            
            local switchCorner = Instance.new("UICorner")
            switchCorner.CornerRadius = UDim.new(0, 10)
            switchCorner.Parent = switch
            
            local knob = Instance.new("Frame")
            knob.Parent = switch
            knob.Size = UDim2.new(0, 16, 0, 16)
            knob.Position = UDim2.new(0, 2, 0.5, -8)
            knob.BackgroundColor3 = Theme.TextPrimary
            knob.BorderSizePixel = 0
            
            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(0, 8)
            knobCorner.Parent = knob
            
            local isEnabled = false
            switch.MouseButton1Click:Connect(function()
                isEnabled = not isEnabled
                
                TweenService:Create(switch, TweenInfo.new(0.2), {
                    BackgroundColor3 = isEnabled and Theme.Primary or Theme.Border
                }):Play()
                
                TweenService:Create(knob, TweenInfo.new(0.2), {
                    Position = UDim2.new(0, isEnabled and 22 or 2, 0.5, -8)
                }):Play()
                
                if item.func then
                    item.func(isEnabled)
                end
            end)
            
            totalHeight = totalHeight + 43
        end
    end
    
    section.Size = UDim2.new(1, 0, 0, totalHeight)
    return section
end

-- ═══════════════════════════════════════════════════════════════
-- 🎮 NAVIGATION SYSTEM
-- ═══════════════════════════════════════════════════════════════
local currentTab = 1
local tabs = {}

for i, tabData in ipairs(TabData) do
    local tab, icon, label = createTab(tabData, i)
    tabs[i] = {button = tab, icon = icon, label = label, data = tabData}
    
    tab.MouseButton1Click:Connect(function()
        currentTab = i
        updateDisplay()
    end)
end

function updateDisplay()
    -- Update tabs
    for i, tab in ipairs(tabs) do
        local isActive = (i == currentTab)
        tab.button.BackgroundColor3 = isActive and Theme.Primary or Theme.Elevated
        tab.label.TextColor3 = isActive and Theme.TextPrimary or Theme.TextSecondary
    end
    
    -- Clear content
    for _, child in pairs(contentScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Create sections
    local tabData = TabData[currentTab]
    for _, sectionData in ipairs(tabData.sections) do
        createSection(sectionData)
    end
    
    -- Update scroll size
    contentScroll.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end

-- ═══════════════════════════════════════════════════════════════
-- ⌨️ CONTROLS
-- ═══════════════════════════════════════════════════════════════

-- Drag
local dragging = false
local dragStart = nil
local startPos = nil

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        shadow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X - 10,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y - 10)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Close
closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Toggle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- 🚀 INITIALIZATION
-- ═══════════════════════════════════════════════════════════════
_G.ProfessionalUI = screenGui
updateDisplay()

print("╔══════════════════════════════════════════════════════════════╗")
print("║              ⚡ PROFESSIONAL CHEAT UI LOADED ⚡              ║")
print("╠══════════════════════════════════════════════════════════════╣")
print("║  🎯 Modern executor-style design                            ║")
print("║  📱 Professional sidebar navigation                         ║")
print("║  ⚙️  Advanced toggles and controls                          ║")
print("║  ⌨️  Press INSERT to toggle                                  ║")
print("╚══════════════════════════════════════════════════════════════╝")
