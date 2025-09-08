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

-- Tab Configuration
local TABS = {
    {name = "Combat", icon = "rbxassetid://75518636799674"},
    {name = "Movement", icon = "rbxassetid://102270380454487"},
    {name = "Visuals", icon = "rbxassetid://77345366725078"},
    {name = "Roleplay", icon = "rbxassetid://111612200954692"},
    {name = "Blox Fruits", icon = "rbxassetid://111612200954692"},
    {name = "Player List", icon = "rbxassetid://122767272714113"},
    {name = "Chat", icon = "rbxassetid://118260954915004"}
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
    
    -- Sidebar with enhanced styling
    local sidebar = createFrame(mainFrame, UDim2.new(0, 220, 1, -80), UDim2.new(0, 10, 0, 75), COLORS.CARD, 12)
    
    -- Sidebar border accent
    local sidebarBorder = Instance.new("Frame")
    sidebarBorder.Size = UDim2.new(0, 2, 1, 0)
    sidebarBorder.Position = UDim2.new(1, -2, 0, 0)
    sidebarBorder.BackgroundColor3 = COLORS.PRIMARY
    sidebarBorder.BorderSizePixel = 0
    sidebarBorder.Parent = sidebar
    
    local tabButtons = {}
    
    for i, tab in pairs(TABS) do
        local tabBtn = createFrame(sidebar, UDim2.new(1, -15, 0, 55), UDim2.new(0, 8, 0, 8 + (i-1) * 60), COLORS.SURFACE, 8)
        
        -- Tab hover effect
        local tabHover = Instance.new("TextButton")
        tabHover.Size = UDim2.new(1, 0, 1, 0)
        tabHover.BackgroundTransparency = 1
        tabHover.Text = ""
        tabHover.Parent = tabBtn
        
        tabHover.MouseEnter:Connect(function()
            if currentTab ~= tab.name then
                TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.BORDER}):Play()
            end
        end)
        
        tabHover.MouseLeave:Connect(function()
            if currentTab ~= tab.name then
                TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.SURFACE}):Play()
            end
        end)
        
        -- Custom icon only
        local tabIcon = Instance.new("ImageLabel")
        tabIcon.Size = UDim2.new(0, 28, 0, 28)
        tabIcon.Position = UDim2.new(0, 11, 0.5, -14)
        tabIcon.BackgroundTransparency = 1
        tabIcon.Image = tab.icon
        tabIcon.ImageColor3 = currentTab == tab.name and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
        tabIcon.Parent = tabBtn
        
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Size = UDim2.new(1, -55, 1, 0)
        tabLabel.Position = UDim2.new(0, 45, 0, 0)
        tabLabel.BackgroundTransparency = 1
        tabLabel.Text = tab.name
        tabLabel.TextColor3 = currentTab == tab.name and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
        tabLabel.TextSize = 15
        tabLabel.Font = Enum.Font.GothamBold
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
    
    -- Content Area with enhanced styling
    local contentArea = createFrame(mainFrame, UDim2.new(1, -250, 1, -90), UDim2.new(0, 240, 0, 80), COLORS.CARD, 12)
    
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
            -- Aimbot Section
            local aimbotHeader = Instance.new("TextLabel")
            aimbotHeader.Size = UDim2.new(1, 0, 0, 30)
            aimbotHeader.Position = UDim2.new(0, 0, 0, yPos)
            aimbotHeader.BackgroundTransparency = 1
            aimbotHeader.Text = "AIMBOT"
            aimbotHeader.TextColor3 = COLORS.ACCENT
            aimbotHeader.TextSize = 16
            aimbotHeader.Font = Enum.Font.GothamBold
            aimbotHeader.TextXAlignment = Enum.TextXAlignment.Left
            aimbotHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Aimbot", function(state)
                createNotification("Aimbot", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "FOV Circle", function(state)
                createNotification("FOV", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Smooth Aim", function(state)
                createNotification("Smooth Aim", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Silent Aim", function(state)
                createNotification("Silent Aim", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Ragebot", function(state)
                createNotification("Ragebot", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 50
            
            -- Combat Section
            local combatHeader = Instance.new("TextLabel")
            combatHeader.Size = UDim2.new(1, 0, 0, 30)
            combatHeader.Position = UDim2.new(0, 0, 0, yPos)
            combatHeader.BackgroundTransparency = 1
            combatHeader.Text = "COMBAT"
            combatHeader.TextColor3 = COLORS.ACCENT
            combatHeader.TextSize = 16
            combatHeader.Font = Enum.Font.GothamBold
            combatHeader.TextXAlignment = Enum.TextXAlignment.Left
            combatHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "TriggerBot", function(state)
                createNotification("TriggerBot", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Hitbox Expander", function(state)
                createNotification("Hitbox Expander", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "One Shot Kill", function(state)
                createNotification("One Shot Kill", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "No Recoil", function(state)
                createNotification("No Recoil", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "No Spread", function(state)
                createNotification("No Spread", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Infinite Ammo", function(state)
                createNotification("Infinite Ammo", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Movement" then
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 30)
            header.Position = UDim2.new(0, 0, 0, yPos)
            header.BackgroundTransparency = 1
            header.Text = "MOVEMENT"
            header.TextColor3 = COLORS.ACCENT
            header.TextSize = 16
            header.Font = Enum.Font.GothamBold
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Bunny Hop", function(state)
                createNotification("Bunny Hop", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Strafe Hack", function(state)
                createNotification("Strafe Hack", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Speed Hack", function(state)
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = state and 100 or 16
                end
                createNotification("Speed Hack", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fly / Jetpack", function(state)
                createNotification("Fly", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "No Clip", function(state)
                createNotification("No Clip", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Teleport Kill", function(state)
                createNotification("Teleport Kill", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Visuals" then
            local header = Instance.new("TextLabel")
            header.Size = UDim2.new(1, 0, 0, 30)
            header.Position = UDim2.new(0, 0, 0, yPos)
            header.BackgroundTransparency = 1
            header.Text = "VISUALS"
            header.TextColor3 = COLORS.ACCENT
            header.TextSize = 16
            header.Font = Enum.Font.GothamBold
            header.TextXAlignment = Enum.TextXAlignment.Left
            header.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Players (Box)", function(state)
                createNotification("ESP Box", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Skeleton", function(state)
                createNotification("ESP Skeleton", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Head Dot", function(state)
                createNotification("ESP Head Dot", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Armas / Itens", function(state)
                createNotification("ESP Items", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Chams / Glow", function(state)
                createNotification("Chams", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Radar Hack", function(state)
                createNotification("Radar", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Custom Crosshair", function(state)
                createNotification("Crosshair", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Night Vision", function(state)
                if state then
                    Lighting.Brightness = 2
                    Lighting.ClockTime = 14
                    Lighting.FogEnd = 100000
                else
                    Lighting.Brightness = 1
                    Lighting.ClockTime = 12
                    Lighting.FogEnd = 500
                end
                createNotification("Night Vision", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Roleplay" then
            -- Spawn/Veículos Section
            local spawnHeader = Instance.new("TextLabel")
            spawnHeader.Size = UDim2.new(1, 0, 0, 30)
            spawnHeader.Position = UDim2.new(0, 0, 0, yPos)
            spawnHeader.BackgroundTransparency = 1
            spawnHeader.Text = "SPAWN / VEÍCULOS"
            spawnHeader.TextColor3 = COLORS.ACCENT
            spawnHeader.TextSize = 16
            spawnHeader.Font = Enum.Font.GothamBold
            spawnHeader.TextXAlignment = Enum.TextXAlignment.Left
            spawnHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Spawn Cars", function()
                createNotification("Spawn", "Carros spawned!")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Super Speed Car", function(state)
                createNotification("Car Speed", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fly Car / Hover Car", function(state)
                createNotification("Flying Car", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Boat / Helicopter Spawner", function()
                createNotification("Spawn", "Veículos aquáticos/aéreos!")
            end)
            yPos = yPos + 50
            
            -- Armas/Itens Section
            local weaponHeader = Instance.new("TextLabel")
            weaponHeader.Size = UDim2.new(1, 0, 0, 30)
            weaponHeader.Position = UDim2.new(0, 0, 0, yPos)
            weaponHeader.BackgroundTransparency = 1
            weaponHeader.Text = "ARMAS / ITENS"
            weaponHeader.TextColor3 = COLORS.ACCENT
            weaponHeader.TextSize = 16
            weaponHeader.Font = Enum.Font.GothamBold
            weaponHeader.TextXAlignment = Enum.TextXAlignment.Left
            weaponHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Spawn Weapons", function()
                createNotification("Weapons", "Armas spawned!")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Infinite Ammo", function(state)
                createNotification("Infinite Ammo", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Dual Wield", function(state)
                createNotification("Dual Wield", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Item Spawner", function()
                createNotification("Items", "Comidas, móveis, props!")
            end)
            yPos = yPos + 50
            
            -- Player/Personagem Section
            local playerHeader = Instance.new("TextLabel")
            playerHeader.Size = UDim2.new(1, 0, 0, 30)
            playerHeader.Position = UDim2.new(0, 0, 0, yPos)
            playerHeader.BackgroundTransparency = 1
            playerHeader.Text = "PLAYER / PERSONAGEM"
            playerHeader.TextColor3 = COLORS.ACCENT
            playerHeader.TextSize = 16
            playerHeader.Font = Enum.Font.GothamBold
            playerHeader.TextXAlignment = Enum.TextXAlignment.Left
            playerHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Morphs Menu", function()
                createNotification("Morphs", "Animais, objetos, NPCs!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Custom Clothes", function()
                createNotification("Clothes", "Roupas customizadas!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Size Changer", function()
                createNotification("Size", "Gigante/Mini mode!")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Invisible Mode", function(state)
                createNotification("Invisible", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Godmode", function(state)
                createNotification("Godmode", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Blox Fruits" then
            -- Farm Section
            local farmHeader = Instance.new("TextLabel")
            farmHeader.Size = UDim2.new(1, 0, 0, 30)
            farmHeader.Position = UDim2.new(0, 0, 0, yPos)
            farmHeader.BackgroundTransparency = 1
            farmHeader.Text = "FARM"
            farmHeader.TextColor3 = COLORS.ACCENT
            farmHeader.TextSize = 16
            farmHeader.Font = Enum.Font.GothamBold
            farmHeader.TextXAlignment = Enum.TextXAlignment.Left
            farmHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Farm Level", function(state)
                createNotification("Auto Farm Level", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Farm Boss", function(state)
                createNotification("Auto Farm Boss", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Farm Quest", function(state)
                createNotification("Auto Farm Quest", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Farm Fruits", function(state)
                createNotification("Auto Farm Fruits", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Farm Mastery", function(state)
                createNotification("Auto Farm Mastery", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 50
            
            -- Combat Section
            local combatHeader = Instance.new("TextLabel")
            combatHeader.Size = UDim2.new(1, 0, 0, 30)
            combatHeader.Position = UDim2.new(0, 0, 0, yPos)
            combatHeader.BackgroundTransparency = 1
            combatHeader.Text = "COMBAT"
            combatHeader.TextColor3 = COLORS.ACCENT
            combatHeader.TextSize = 16
            combatHeader.Font = Enum.Font.GothamBold
            combatHeader.TextXAlignment = Enum.TextXAlignment.Left
            combatHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Aim Skills", function(state)
                createNotification("Auto Aim Skills", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "No Cooldown Skills", function(state)
                createNotification("No Cooldown", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Skill Spam", function(state)
                createNotification("Skill Spam", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Kill Aura", function(state)
                createNotification("Kill Aura", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Damage Multiplier", function(state)
                createNotification("Damage Multiplier", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 50
            
            -- Teleport Section
            local tpHeader = Instance.new("TextLabel")
            tpHeader.Size = UDim2.new(1, 0, 0, 30)
            tpHeader.Position = UDim2.new(0, 0, 0, yPos)
            tpHeader.BackgroundTransparency = 1
            tpHeader.Text = "TELEPORT"
            tpHeader.TextColor3 = COLORS.ACCENT
            tpHeader.TextSize = 16
            tpHeader.Font = Enum.Font.GothamBold
            tpHeader.TextXAlignment = Enum.TextXAlignment.Left
            tpHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "TP to Sea", function()
                createNotification("Teleport", "Teleported to Sea!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "TP to Island", function()
                createNotification("Teleport", "Island menu!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "TP to NPC", function()
                createNotification("Teleport", "NPC menu!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "TP to Fruits", function()
                createNotification("Teleport", "Fruit locations!")
            end)
            yPos = yPos + 50
            
            -- Misc Section
            local miscHeader = Instance.new("TextLabel")
            miscHeader.Size = UDim2.new(1, 0, 0, 30)
            miscHeader.Position = UDim2.new(0, 0, 0, yPos)
            miscHeader.BackgroundTransparency = 1
            miscHeader.Text = "MISC"
            miscHeader.TextColor3 = COLORS.ACCENT
            miscHeader.TextSize = 16
            miscHeader.Font = Enum.Font.GothamBold
            miscHeader.TextXAlignment = Enum.TextXAlignment.Left
            miscHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Fruits", function(state)
                createNotification("ESP Fruits", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Fruit Sniper", function(state)
                createNotification("Fruit Sniper", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Walk on Water", function(state)
                createNotification("Walk on Water", state and "Ativado" or "Desativado")
            end)
            yPos = yPos + 45
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Auto Buy Menu", function()
                createNotification("Auto Buy", "Frutas, Espadas, Habilidades!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Raid Helper", function()
                createNotification("Raid Helper", "Assistente de raids!")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Player List" then
            -- Interface Section
            local interfaceHeader = Instance.new("TextLabel")
            interfaceHeader.Size = UDim2.new(1, 0, 0, 30)
            interfaceHeader.Position = UDim2.new(0, 0, 0, yPos)
            interfaceHeader.BackgroundTransparency = 1
            interfaceHeader.Text = "INTERFACE"
            interfaceHeader.TextColor3 = COLORS.ACCENT
            interfaceHeader.TextSize = 16
            interfaceHeader.Font = Enum.Font.GothamBold
            interfaceHeader.TextXAlignment = Enum.TextXAlignment.Left
            interfaceHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Refresh Player List", function()
                createNotification("Players", "Lista atualizada!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Search Players", function()
                createNotification("Search", "Busca por nome!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Filter Options", function()
                createNotification("Filter", "Distância, time, admin!")
            end)
            yPos = yPos + 50
            
            -- Ações Gerais Section
            local actionsHeader = Instance.new("TextLabel")
            actionsHeader.Size = UDim2.new(1, 0, 0, 30)
            actionsHeader.Position = UDim2.new(0, 0, 0, yPos)
            actionsHeader.BackgroundTransparency = 1
            actionsHeader.Text = "AÇÕES GERAIS"
            actionsHeader.TextColor3 = COLORS.ACCENT
            actionsHeader.TextSize = 16
            actionsHeader.Font = Enum.Font.GothamBold
            actionsHeader.TextXAlignment = Enum.TextXAlignment.Left
            actionsHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Teleport to Player", function()
                createNotification("Teleport", "TP para player!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Swap Position", function()
                createNotification("Swap", "Trocar lugar!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Spectate Player", function()
                createNotification("Spectate", "Observando player!")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Highlight Player", function(state)
                createNotification("Highlight", state and "ESP individual ativo!" or "ESP desativado!")
            end)
            yPos = yPos + 50
            
            -- Troll/Diversão Section
            local trollHeader = Instance.new("TextLabel")
            trollHeader.Size = UDim2.new(1, 0, 0, 30)
            trollHeader.Position = UDim2.new(0, 0, 0, yPos)
            trollHeader.BackgroundTransparency = 1
            trollHeader.Text = "TROLL / DIVERSÃO"
            trollHeader.TextColor3 = COLORS.ACCENT
            trollHeader.TextSize = 16
            trollHeader.Font = Enum.Font.GothamBold
            trollHeader.TextXAlignment = Enum.TextXAlignment.Left
            trollHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Freeze Player", function()
                createNotification("Freeze", "Player congelado!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Fling Player", function()
                createNotification("Fling", "Player arremessado!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Kill Player", function()
                createNotification("Kill", "Player eliminado!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Clone Player", function()
                createNotification("Clone", "Cópias falsas criadas!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Spin Player", function()
                createNotification("Spin", "Player girando!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Giant/Mini Mode", function()
                createNotification("Size", "Tamanho alterado!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Force Emote", function()
                createNotification("Emote", "Emote forçado!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Sound Spam", function()
                createNotification("Sound", "Som spammado!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Fake Arrest", function()
                createNotification("Arrest", "Fake algemado!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Troll Pack", function()
                createNotification("Troll Pack", "Combo de trolls!")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Chat" then
            -- Mensagens Rápidas Section
            local quickHeader = Instance.new("TextLabel")
            quickHeader.Size = UDim2.new(1, 0, 0, 30)
            quickHeader.Position = UDim2.new(0, 0, 0, yPos)
            quickHeader.BackgroundTransparency = 1
            quickHeader.Text = "MENSAGENS RÁPIDAS"
            quickHeader.TextColor3 = COLORS.ACCENT
            quickHeader.TextSize = 16
            quickHeader.Font = Enum.Font.GothamBold
            quickHeader.TextXAlignment = Enum.TextXAlignment.Left
            quickHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Quick Messages", function()
                createNotification("Quick", "Frases prontas!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Keybind Macros", function()
                createNotification("Macros", "Frases em teclas!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Random Messages", function()
                createNotification("Random", "Mensagens aleatórias!")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Scheduled Messages", function(state)
                createNotification("Schedule", state and "Mensagens agendadas!" or "Desativado!")
            end)
            yPos = yPos + 50
            
            -- Auto Chat Section
            local autoHeader = Instance.new("TextLabel")
            autoHeader.Size = UDim2.new(1, 0, 0, 30)
            autoHeader.Position = UDim2.new(0, 0, 0, yPos)
            autoHeader.BackgroundTransparency = 1
            autoHeader.Text = "AUTO CHAT"
            autoHeader.TextColor3 = COLORS.ACCENT
            autoHeader.TextSize = 16
            autoHeader.Font = Enum.Font.GothamBold
            autoHeader.TextXAlignment = Enum.TextXAlignment.Left
            autoHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Reply", function(state)
                createNotification("Auto Reply", state and "Respostas automáticas!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Smart Reply", function(state)
                createNotification("Smart Reply", state and "Respostas inteligentes!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Greet", function(state)
                createNotification("Auto Greet", state and "Cumprimentar novos players!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto GG / WP", function(state)
                createNotification("Auto GG", state and "GG automático!" or "Desativado!")
            end)
            yPos = yPos + 50
            
            -- Spam/Flood Section
            local spamHeader = Instance.new("TextLabel")
            spamHeader.Size = UDim2.new(1, 0, 0, 30)
            spamHeader.Position = UDim2.new(0, 0, 0, yPos)
            spamHeader.BackgroundTransparency = 1
            spamHeader.Text = "SPAM / FLOOD"
            spamHeader.TextColor3 = COLORS.ACCENT
            spamHeader.TextSize = 16
            spamHeader.Font = Enum.Font.GothamBold
            spamHeader.TextXAlignment = Enum.TextXAlignment.Left
            spamHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Normal Spam", function(state)
                createNotification("Normal Spam", state and "Spam ativado!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Wave Spam", function(state)
                createNotification("Wave Spam", state and "Frases em loop!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Emoji Spam", function(state)
                createNotification("Emoji Spam", state and "Emojis spammados!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Random Caps Spam", function(state)
                createNotification("Caps Spam", state and "CAPS ALEATÓRIAS!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Unicode Spam", function(state)
                createNotification("Unicode Spam", state and "Unicode spammado!" or "Desativado!")
            end)
            yPos = yPos + 50
            
            -- Fake/Troll Chat Section
            local fakeHeader = Instance.new("TextLabel")
            fakeHeader.Size = UDim2.new(1, 0, 0, 30)
            fakeHeader.Position = UDim2.new(0, 0, 0, yPos)
            fakeHeader.BackgroundTransparency = 1
            fakeHeader.Text = "FAKE / TROLL CHAT"
            fakeHeader.TextColor3 = COLORS.ACCENT
            fakeHeader.TextSize = 16
            fakeHeader.Font = Enum.Font.GothamBold
            fakeHeader.TextXAlignment = Enum.TextXAlignment.Left
            fakeHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Fake Chat Messages", function()
                createNotification("Fake Chat", "Mensagens falsas!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Fake System Messages", function()
                createNotification("Fake System", "Servidor reiniciando!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Fake Admin Commands", function()
                createNotification("Fake Admin", "/kick /ban fake!")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Fake Whisper", function()
                createNotification("Fake Whisper", "Mensagem privada fake!")
            end)
            yPos = yPos + 50
            
            -- Logs & Filtros Section
            local logsHeader = Instance.new("TextLabel")
            logsHeader.Size = UDim2.new(1, 0, 0, 30)
            logsHeader.Position = UDim2.new(0, 0, 0, yPos)
            logsHeader.BackgroundTransparency = 1
            logsHeader.Text = "LOGS & FILTROS"
            logsHeader.TextColor3 = COLORS.ACCENT
            logsHeader.TextSize = 16
            logsHeader.Font = Enum.Font.GothamBold
            logsHeader.TextXAlignment = Enum.TextXAlignment.Left
            logsHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Chat Logger", function(state)
                createNotification("Chat Logger", state and "Salvando chat!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Search Messages", function()
                createNotification("Search", "Buscar mensagens!")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Highlight Words", function(state)
                createNotification("Highlight", state and "Destacar palavras!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Mute Player", function()
                createNotification("Mute", "Player silenciado!")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Filter", function(state)
                createNotification("Auto Filter", state and "Filtro de palavras!" or "Desativado!")
            end)
            yPos = yPos + 50
            
            -- Extras Section
            local extrasHeader = Instance.new("TextLabel")
            extrasHeader.Size = UDim2.new(1, 0, 0, 30)
            extrasHeader.Position = UDim2.new(0, 0, 0, yPos)
            extrasHeader.BackgroundTransparency = 1
            extrasHeader.Text = "EXTRAS"
            extrasHeader.TextColor3 = COLORS.ACCENT
            extrasHeader.TextSize = 16
            extrasHeader.Font = Enum.Font.GothamBold
            extrasHeader.TextXAlignment = Enum.TextXAlignment.Left
            extrasHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Translator", function(state)
                createNotification("Translator", state and "Tradução em tempo real!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Text Effects", function()
                createNotification("Text Effects", "Arco-íris, glitch, fade!")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Typing Simulator", function(state)
                createNotification("Typing", state and "Delay entre letras!" or "Desativado!")
            end)
            yPos = yPos + 45
            
            createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Voice Line Chat", function()
                createNotification("Voice Lines", "Callouts pré-configurados!")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Team Chat Toggle", function(state)
                createNotification("Team Chat", state and "Global/Team toggle!" or "Desativado!")
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
