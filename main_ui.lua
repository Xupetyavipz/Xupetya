-- SPWARE - Professional Roblox Cheat UI
-- Modern FiveM Style Design

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Global Variables
local mainFrame = nil
local isUIVisible = false
local currentTab = "Combat"

-- Premium Color Scheme - Purple/Black Theme
local COLORS = {
    BACKGROUND = Color3.fromRGB(8, 8, 12),        -- Deep Black
    SURFACE = Color3.fromRGB(16, 16, 20),         -- Dark Surface
    CARD = Color3.fromRGB(22, 22, 28),            -- Card Background
    PRIMARY = Color3.fromRGB(139, 69, 255),       -- Vibrant Purple
    SECONDARY = Color3.fromRGB(124, 58, 237),     -- Purple Secondary
    ACCENT = Color3.fromRGB(168, 85, 247),        -- Purple Light
    HOVER = Color3.fromRGB(196, 181, 253),        -- Purple Hover
    TEXT = Color3.fromRGB(255, 255, 255),         -- Pure White
    TEXT_SECONDARY = Color3.fromRGB(156, 163, 175), -- Gray Text
    SUCCESS = Color3.fromRGB(34, 197, 94),        -- Green
    ERROR = Color3.fromRGB(239, 68, 68),          -- Red
    BORDER = Color3.fromRGB(55, 48, 163),         -- Purple Border
    GLOW = Color3.fromRGB(79, 70, 229),           -- Purple Glow
}

-- Notification System
local function createNotification(title, message)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = message,
        Duration = 3
    })
end

-- UI Components
local function createFrame(parent, size, position, color, radius)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = color
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    if radius then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius)
        corner.Parent = frame
    end
    
    return frame
end

local function createButton(parent, size, position, text, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = COLORS.PRIMARY
    button.Text = text
    button.TextColor3 = COLORS.TEXT
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 0
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- Enhanced hover effects
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            BackgroundColor3 = COLORS.HOVER,
            Size = UDim2.new(size.X.Scale, size.X.Offset + 4, size.Y.Scale, size.Y.Offset + 2)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            BackgroundColor3 = COLORS.PRIMARY,
            Size = size
        }):Play()
    end)
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
end

local function createToggle(parent, position, text, callback)
    local toggleFrame = createFrame(parent, UDim2.new(1, -20, 0, 40), position, COLORS.CARD, 6)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.TEXT
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local toggleBg = createFrame(toggleFrame, UDim2.new(0, 40, 0, 20), UDim2.new(1, -50, 0.5, -10), COLORS.BORDER, 10)
    local toggleCircle = createFrame(toggleBg, UDim2.new(0, 16, 0, 16), UDim2.new(0, 2, 0, 2), COLORS.TEXT_SECONDARY, 8)
    
    local isToggled = false
    
    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.Parent = toggleFrame
    
    clickBtn.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        
        if isToggled then
            TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.PRIMARY}):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                Position = UDim2.new(1, -18, 0, 2),
                BackgroundColor3 = COLORS.TEXT
            }):Play()
        else
            TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.BORDER}):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 2, 0, 2),
                BackgroundColor3 = COLORS.TEXT_SECONDARY
            }):Play()
        end
        
        if callback then
            callback(isToggled)
        end
    end)
    
    return toggleFrame
end

-- Tab Configuration with Custom Icons
local TABS = {
    {name = "Combat", icon = "rbxassetid://75518636799674", emoji = "⚔️"},
    {name = "Movement", icon = "rbxassetid://102270380454487", emoji = "🏃"},
    {name = "Visuals", icon = "rbxassetid://77345366725078", emoji = "👁️"},
    {name = "Roleplay", icon = "rbxassetid://111612200954692", emoji = "🎭"},
    {name = "Blox Fruits", icon = "rbxassetid://111612200954692", emoji = "🍎"},
    {name = "Player List", icon = "rbxassetid://122767272714113", emoji = "👥"},
    {name = "Chat", icon = "rbxassetid://118260954915004", emoji = "💬"}
}

-- Main UI Creation
local function createMainUI()
    -- Clean up existing UI
    local existing = playerGui:FindFirstChild("SPWARECheatUI")
    if existing then
        existing:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SPWARECheatUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Main Container with Shadow Effect
    mainFrame = createFrame(screenGui, UDim2.new(0, 950, 0, 650), UDim2.new(0.5, -475, 0.5, -325), COLORS.BACKGROUND, 16)
    
    -- Add shadow/glow effect
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Position = UDim2.new(0, -20, 0, -20)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    shadow.ImageColor3 = COLORS.GLOW
    shadow.ImageTransparency = 0.7
    shadow.ZIndex = -1
    shadow.Parent = mainFrame
    
    -- Header with Gradient Effect
    local header = createFrame(mainFrame, UDim2.new(1, 0, 0, 70), UDim2.new(0, 0, 0, 0), COLORS.SURFACE, 16)
    
    -- Header gradient overlay
    local headerGradient = Instance.new("Frame")
    headerGradient.Size = UDim2.new(1, 0, 1, 0)
    headerGradient.BackgroundColor3 = COLORS.PRIMARY
    headerGradient.BackgroundTransparency = 0.9
    headerGradient.BorderSizePixel = 0
    headerGradient.Parent = header
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = headerGradient
    
    -- User Avatar
    local userImage = Instance.new("ImageLabel")
    userImage.Size = UDim2.new(0, 40, 0, 40)
    userImage.Position = UDim2.new(0, 15, 0, 10)
    userImage.BackgroundTransparency = 1
    userImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
    userImage.Parent = header
    
    local userCorner = Instance.new("UICorner")
    userCorner.CornerRadius = UDim.new(0, 20)
    userCorner.Parent = userImage
    
    -- SPWARE Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 150, 0, 30)
    title.Position = UDim2.new(0, 65, 0, 15)
    title.BackgroundTransparency = 1
    title.Text = "SPWARE"
    title.TextColor3 = COLORS.ACCENT
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- User Name
    local userName = Instance.new("TextLabel")
    userName.Size = UDim2.new(0, 150, 0, 15)
    userName.Position = UDim2.new(0, 220, 0, 20)
    userName.BackgroundTransparency = 1
    userName.Text = "👋 " .. player.Name
    userName.TextColor3 = COLORS.TEXT_SECONDARY
    userName.TextSize = 12
    userName.Font = Enum.Font.Gotham
    userName.TextXAlignment = Enum.TextXAlignment.Left
    userName.Parent = header
    
    -- Close Button
    local closeBtn = createButton(header, UDim2.new(0, 40, 0, 40), UDim2.new(1, -50, 0.5, -20), "✕", function()
        toggleUI()
    end)
    closeBtn.BackgroundColor3 = COLORS.ERROR
    
    -- Sidebar
    local sidebar = createFrame(mainFrame, UDim2.new(0, 200, 1, -70), UDim2.new(0, 5, 0, 65), COLORS.CARD, 8)
    
    local tabButtons = {}
    
    for i, tab in pairs(TABS) do
        local tabBtn = createFrame(sidebar, UDim2.new(1, -10, 0, 50), UDim2.new(0, 5, 0, 5 + (i-1) * 55), COLORS.SURFACE, 6)
        
        -- Try custom icon first, fallback to emoji
        local tabIcon = Instance.new("ImageLabel")
        tabIcon.Size = UDim2.new(0, 24, 0, 24)
        tabIcon.Position = UDim2.new(0, 13, 0.5, -12)
        tabIcon.BackgroundTransparency = 1
        tabIcon.Image = tab.icon
        tabIcon.ImageColor3 = currentTab == tab.name and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
        tabIcon.Parent = tabBtn
        
        -- Fallback emoji if image fails to load
        local fallbackIcon = Instance.new("TextLabel")
        fallbackIcon.Size = UDim2.new(0, 30, 1, 0)
        fallbackIcon.Position = UDim2.new(0, 10, 0, 0)
        fallbackIcon.BackgroundTransparency = 1
        fallbackIcon.Text = tab.emoji
        fallbackIcon.TextColor3 = currentTab == tab.name and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
        fallbackIcon.TextSize = 16
        fallbackIcon.Font = Enum.Font.Gotham
        fallbackIcon.Visible = false
        fallbackIcon.Parent = tabBtn
        
        -- Show fallback if image fails
        spawn(function()
            wait(1)
            if tabIcon.Image == "" or not tabIcon.IsLoaded then
                tabIcon.Visible = false
                fallbackIcon.Visible = true
            end
        end)
        
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Size = UDim2.new(1, -50, 1, 0)
        tabLabel.Position = UDim2.new(0, 40, 0, 0)
        tabLabel.BackgroundTransparency = 1
        tabLabel.Text = tab.name
        tabLabel.TextColor3 = currentTab == tab.name and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
        tabLabel.TextSize = 14
        tabLabel.Font = Enum.Font.Gotham
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        tabLabel.Parent = tabBtn
        
        local tabClickBtn = Instance.new("TextButton")
        tabClickBtn.Size = UDim2.new(1, 0, 1, 0)
        tabClickBtn.BackgroundTransparency = 1
        tabClickBtn.Text = ""
        tabClickBtn.Parent = tabBtn
        
        tabClickBtn.MouseButton1Click:Connect(function()
            currentTab = tab.name
            updateTabContent()
            
            -- Update tab colors
            for j, button in pairs(tabButtons) do
                local icon = button:FindFirstChild("TextLabel")
                local label = button:GetChildren()[2]
                
                if icon and icon:IsA("TextLabel") then
                    icon.TextColor3 = j == i and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
                end
                if label and label:IsA("TextLabel") and label ~= icon then
                    label.TextColor3 = j == i and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
                end
            end
        end)
        
        tabButtons[i] = tabBtn
    end
    
    -- Content Area
    local contentArea = createFrame(mainFrame, UDim2.new(1, -210, 1, -70), UDim2.new(0, 205, 0, 65), COLORS.CARD, 8)
    
    -- Scrolling Frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -20)
    scrollFrame.Position = UDim2.new(0, 10, 0, 10)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.ScrollBarImageColor3 = COLORS.PRIMARY
    scrollFrame.Parent = contentArea
    
    -- Content Update Function
    function updateTabContent()
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child:Destroy()
            end
        end
        
        local yPos = 0
        
        if currentTab == "Combat" then
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 30)
            header.Position = UDim2.new(0, 0, 0, yPos)
            header.BackgroundTransparency = 1
            header.Text = "🎯 COMBAT"
            header.TextColor3 = COLORS.ACCENT
            header.TextSize = 16
            header.Font = Enum.Font.GothamBold
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Aimbot", function(state)
                createNotification("Aimbot", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Silent Aim", function(state)
                createNotification("Silent Aim", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Trigger Bot", function(state)
                createNotification("Trigger Bot", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Movement" then
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 30)
            header.Position = UDim2.new(0, 0, 0, yPos)
            header.BackgroundTransparency = 1
            header.Text = "🏃 MOVEMENT"
            header.TextColor3 = COLORS.ACCENT
            header.TextSize = 16
            header.Font = Enum.Font.GothamBold
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Super Speed", function(state)
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = state and 100 or 16
                end
                createNotification("Speed", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Super Jump", function(state)
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.JumpPower = state and 100 or 50
                end
                createNotification("Jump", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fly", function(state)
                createNotification("Fly", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Visuals" then
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 30)
            header.Position = UDim2.new(0, 0, 0, yPos)
            header.BackgroundTransparency = 1
            header.Text = "👁️ VISUALS"
            header.TextColor3 = COLORS.ACCENT
            header.TextSize = 16
            header.Font = Enum.Font.GothamBold
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fullbright", function(state)
                if state then
                    Lighting.Brightness = 2
                    Lighting.ClockTime = 14
                    Lighting.FogEnd = 100000
                else
                    Lighting.Brightness = 1
                    Lighting.ClockTime = 12
                    Lighting.FogEnd = 500
                end
                createNotification("Fullbright", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Players", function(state)
                createNotification("ESP", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Roleplay" then
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 30)
            header.Position = UDim2.new(0, 0, 0, yPos)
            header.BackgroundTransparency = 1
            header.Text = "🎭 ROLEPLAY"
            header.TextColor3 = COLORS.ACCENT
            header.TextSize = 16
            header.Font = Enum.Font.GothamBold
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 0, 0, yPos), "🎭 Animations", function()
                createNotification("Roleplay", "Menu de animações!")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Blox Fruits" then
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 30)
            header.Position = UDim2.new(0, 0, 0, yPos)
            header.BackgroundTransparency = 1
            header.Text = "🍎 BLOX FRUITS"
            header.TextColor3 = COLORS.ACCENT
            header.TextSize = 16
            header.Font = Enum.Font.GothamBold
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Farm", function(state)
                createNotification("Auto Farm", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Player List" then
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 30)
            header.Position = UDim2.new(0, 0, 0, yPos)
            header.BackgroundTransparency = 1
            header.Text = "👥 PLAYER LIST"
            header.TextColor3 = COLORS.ACCENT
            header.TextSize = 16
            header.Font = Enum.Font.GothamBold
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 0, 0, yPos), "👥 Refresh Players", function()
                createNotification("Players", "Lista atualizada!")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Chat" then
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 30)
            header.Position = UDim2.new(0, 0, 0, yPos)
            header.BackgroundTransparency = 1
            header.Text = "💬 CHAT"
            header.TextColor3 = COLORS.ACCENT
            header.TextSize = 16
            header.Font = Enum.Font.GothamBold
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Chat Spam", function(state)
                createNotification("Chat", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
        end
        
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)
    end
    
    -- Initialize first tab
    updateTabContent()
    
    -- Make window draggable
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
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    isUIVisible = true
end

-- Toggle UI Function
function toggleUI()
    if mainFrame then
        isUIVisible = not isUIVisible
        mainFrame.Visible = isUIVisible
    end
end

-- Keybind Handler
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        toggleUI()
    end
end)

-- Initialize
createNotification("🔥 SPWARE Loaded", "Press INSERT to open menu!")
createMainUI()
