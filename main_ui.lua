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
local currentSubTab = "Aimbot"
local playerListWindow = nil
local isPlayerListVisible = false
local selectedPlayer = nil

-- Cheat States
local cheatStates = {
    -- Combat
    aimbot = false,
    aimbotFOV = false,
    aimbotSmooth = false,
    silentAim = false,
    ragebot = false,
    triggerBot = false,
    hitboxExpander = false,
    oneShot = false,
    noRecoil = false,
    infiniteAmmo = false,
    
    -- Movement
    bunnyHop = false,
    strafeHack = false,
    speedHack = false,
    fly = false,
    noclip = false,
    teleportKill = false,
    
    -- Visuals
    espPlayers = false,
    espBox = false,
    espSkeleton = false,
    espHeadDot = false,
    espItems = false,
    espAdmin = false,
    chams = false,
    radar = false,
    crosshair = false,
    fullbright = false,
    
    -- Other states...
}

-- ESP Admin System
local adminESP = {}
local adminPlayers = {}

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

-- ESP Admin Functions
local function createAdminESP(targetPlayer)
    if adminESP[targetPlayer] then return end
    
    local character = targetPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Create RGB cycling ESP
    local espGui = Instance.new("BillboardGui")
    espGui.Name = "AdminESP"
    espGui.Adornee = humanoidRootPart
    espGui.Size = UDim2.new(0, 200, 0, 50)
    espGui.StudsOffset = Vector3.new(0, 3, 0)
    espGui.Parent = workspace
    
    local espFrame = Instance.new("Frame")
    espFrame.Size = UDim2.new(1, 0, 1, 0)
    espFrame.BackgroundTransparency = 0.3
    espFrame.BorderSizePixel = 2
    espFrame.Parent = espGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = espFrame
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = targetPlayer.Name .. " [ADMIN]"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = espFrame
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0.4, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.6, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = "0m"
    distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distanceLabel.TextScaled = true
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.Parent = espFrame
    
    adminESP[targetPlayer] = {gui = espGui, frame = espFrame, distance = distanceLabel}
    
    -- RGB Animation
    spawn(function()
        local hue = 0
        while adminESP[targetPlayer] and espFrame.Parent do
            hue = (hue + 0.01) % 1
            local color = Color3.fromHSV(hue, 1, 1)
            espFrame.BackgroundColor3 = color
            espFrame.BorderColor3 = color
            wait(0.1)
        end
    end)
    
    -- Distance Update
    spawn(function()
        while adminESP[targetPlayer] and character.Parent and humanoidRootPart.Parent do
            local distance = (player.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
            distanceLabel.Text = math.floor(distance) .. "m"
            wait(0.5)
        end
    end)
end

local function removeAdminESP(targetPlayer)
    if adminESP[targetPlayer] then
        adminESP[targetPlayer].gui:Destroy()
        adminESP[targetPlayer] = nil
    end
end

local function checkForAdmins()
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            -- Check if player is admin (you can customize this logic)
            local isAdmin = targetPlayer:GetRankInGroup(0) >= 100 or 
                           targetPlayer.Name:lower():find("admin") or
                           targetPlayer.Name:lower():find("mod") or
                           targetPlayer.Name:lower():find("owner")
            
            if isAdmin and not adminPlayers[targetPlayer] then
                adminPlayers[targetPlayer] = true
                if cheatStates.espAdmin then
                    createAdminESP(targetPlayer)
                end
            elseif not isAdmin and adminPlayers[targetPlayer] then
                adminPlayers[targetPlayer] = nil
                removeAdminESP(targetPlayer)
            end
        end
    end
end

-- Movement Functions
local function toggleFly()
    if not cheatStates.fly then return end
    
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = humanoidRootPart
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not cheatStates.fly then
            bodyVelocity:Destroy()
            connection:Disconnect()
            return
        end
        
        local camera = workspace.CurrentCamera
        local moveVector = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveVector = moveVector + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveVector = moveVector - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveVector = moveVector - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveVector = moveVector + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveVector = moveVector + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveVector = moveVector - Vector3.new(0, 1, 0)
        end
        
        bodyVelocity.Velocity = moveVector * 50
    end)
end

local function toggleNoclip()
    if not cheatStates.noclip then return end
    
    local character = player.Character
    if not character then return end
    
    local connection
    connection = RunService.Stepped:Connect(function()
        if not cheatStates.noclip then
            connection:Disconnect()
            return
        end
        
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

local function toggleSpeed()
    if not cheatStates.speedHack then return end
    
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    humanoid.WalkSpeed = cheatStates.speedHack and 100 or 16
end

-- Visual Functions
local function toggleFullbright()
    if cheatStates.fullbright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    end
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
    
    -- Sub-tab system
    local function createSubTabs(parent, tabs, callback)
        local subTabFrame = Instance.new("Frame")
        subTabFrame.Size = UDim2.new(1, 0, 0, 50)
        subTabFrame.BackgroundColor3 = COLORS.SURFACE
        subTabFrame.BorderSizePixel = 0
        subTabFrame.Parent = parent
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = subTabFrame
        
        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, 30, 0, 30)
        closeButton.Position = UDim2.new(1, -35, 0, 10)
        closeButton.BackgroundColor3 = COLORS.ERROR
        closeButton.Text = "X"
        closeButton.TextColor3 = COLORS.TEXT
        closeButton.TextSize = 16
        closeButton.Font = Enum.Font.GothamBold
        closeButton.BorderSizePixel = 0
        closeButton.Parent = subTabFrame
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 6)
        closeCorner.Parent = closeButton
        
        closeButton.MouseButton1Click:Connect(function()
            currentSubTab = tabs[1]
            callback()
        end)
        
        local buttonWidth = (1 - 0.1) / #tabs
        for i, tabName in ipairs(tabs) do
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(buttonWidth, -5, 0, 30)
            button.Position = UDim2.new((i-1) * buttonWidth, 5, 0, 10)
            button.BackgroundColor3 = currentSubTab == tabName and COLORS.ACCENT or COLORS.CARD
            button.Text = tabName
            button.TextColor3 = COLORS.TEXT
            button.TextSize = 12
            button.Font = Enum.Font.Gotham
            button.BorderSizePixel = 0
            button.Parent = subTabFrame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = button
            
            button.MouseButton1Click:Connect(function()
                currentSubTab = tabName
                callback()
            end)
            
            -- Hover effect
            button.MouseEnter:Connect(function()
                if currentSubTab ~= tabName then
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.HOVER}):Play()
                end
            end)
            
            button.MouseLeave:Connect(function()
                if currentSubTab ~= tabName then
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.CARD}):Play()
                end
            end)
        end
        
        return subTabFrame
    end

    -- Content Area with enhanced styling
    local contentFrame = createFrame(mainFrame, UDim2.new(1, -250, 1, -90), UDim2.new(0, 240, 0, 80), COLORS.CARD, 12)
    
    -- Update Function
    local function updateTabContent()
        -- Clear existing content
        for _, child in pairs(contentFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") or child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        local yOffset = 0
        local subTabFrame = nil
        
        -- Create sub-tabs based on current tab
        if currentTab == "Combat" then
            subTabFrame = createSubTabs(contentFrame, {"Aimbot", "Weapons", "Misc"}, updateTabContent)
            yOffset = 60
        elseif currentTab == "Movement" then
            subTabFrame = createSubTabs(contentFrame, {"Speed", "Flight", "Teleport"}, updateTabContent)
            yOffset = 60
        elseif currentTab == "Visuals" then
            subTabFrame = createSubTabs(contentFrame, {"ESP", "Chams", "World"}, updateTabContent)
            yOffset = 60
        elseif currentTab == "Roleplay" then
            subTabFrame = createSubTabs(contentFrame, {"Spawn", "Character", "Utilities"}, updateTabContent)
            yOffset = 60
        elseif currentTab == "Blox Fruits" then
            subTabFrame = createSubTabs(contentFrame, {"Farm", "Combat", "Teleport"}, updateTabContent)
            yOffset = 60
        end
        
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Size = UDim2.new(1, -20, 1, -20 - yOffset)
        scrollFrame.Position = UDim2.new(0, 10, 0, 10 + yOffset)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.ScrollBarThickness = 8
        scrollFrame.ScrollBarImageColor3 = COLORS.ACCENT
        scrollFrame.Parent = contentFrame
        
        local yPos = 10
        
        if currentTab == "Combat" then
            if currentSubTab == "Aimbot" then
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Aimbot", function(state)
                    cheatStates.aimbot = state
                    createNotification("Aimbot", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "FOV Circle", function(state)
                    cheatStates.aimbotFOV = state
                    createNotification("FOV", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Smooth Aim", function(state)
                    cheatStates.aimbotSmooth = state
                    createNotification("Smooth Aim", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Silent Aim", function(state)
                    cheatStates.silentAim = state
                    createNotification("Silent Aim", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Ragebot", function(state)
                    cheatStates.ragebot = state
                    createNotification("Ragebot", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
            elseif currentSubTab == "Weapons" then
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "TriggerBot", function(state)
                    cheatStates.triggerBot = state
                    createNotification("TriggerBot", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "No Recoil", function(state)
                    cheatStates.noRecoil = state
                    createNotification("No Recoil", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "No Spread", function(state)
                    createNotification("No Spread", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Infinite Ammo", function(state)
                    cheatStates.infiniteAmmo = state
                    createNotification("Infinite Ammo", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
            elseif currentSubTab == "Misc" then
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Hitbox Expander", function(state)
                    cheatStates.hitboxExpander = state
                    createNotification("Hitbox Expander", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "One Shot Kill", function(state)
                    cheatStates.oneShot = state
                    createNotification("One Shot Kill", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
            end
            
        elseif currentTab == "Movement" then
            if currentSubTab == "Speed" then
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Speed Hack", function(state)
                    cheatStates.speedHack = state
                    toggleSpeed()
                    createNotification("Speed Hack", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Bunny Hop", function(state)
                    cheatStates.bunnyHop = state
                    createNotification("Bunny Hop", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Strafe Hack", function(state)
                    cheatStates.strafeHack = state
                    createNotification("Strafe Hack", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
            elseif currentSubTab == "Flight" then
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fly", function(state)
                    cheatStates.fly = state
                    if state then toggleFly() end
                    createNotification("Fly", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Noclip", function(state)
                    cheatStates.noclip = state
                    if state then toggleNoclip() end
                    createNotification("Noclip", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
            elseif currentSubTab == "Teleport" then
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Teleport Kill", function(state)
                    cheatStates.teleportKill = state
                    createNotification("Teleport Kill", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createButton(scrollFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 0, 0, yPos), "Teleport to Spawn", function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
                        createNotification("Teleport", "Teleported to spawn!")
                    end
                end)
                yPos = yPos + 40
            end
            
        elseif currentTab == "Visuals" then
            if currentSubTab == "ESP" then
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Players", function(state)
                    cheatStates.espPlayers = state
                    createNotification("ESP Players", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Box", function(state)
                    cheatStates.espBox = state
                    createNotification("ESP Box", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Admin", function(state)
                    cheatStates.espAdmin = state
                    if state then
                        checkForAdmins()
                        for targetPlayer, _ in pairs(adminPlayers) do
                            createAdminESP(targetPlayer)
                        end
                    else
                        for targetPlayer, _ in pairs(adminESP) do
                            removeAdminESP(targetPlayer)
                        end
                    end
                    createNotification("ESP Admin", state and "RGB ESP Ativado!" or "Desativado")
                end)
                yPos = yPos + 45
                
            elseif currentSubTab == "World" then
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fullbright", function(state)
                    cheatStates.fullbright = state
                    toggleFullbright()
                    createNotification("Fullbright", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
                
                createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Custom Crosshair", function(state)
                    cheatStates.crosshair = state
                    createNotification("Crosshair", state and "Ativado" or "Desativado")
                end)
                yPos = yPos + 45
            end
            
        elseif currentTab == "Player List" then
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Show Player List", function(state)
                isPlayerListVisible = state
                if state then
                    createPlayerListWindow()
                else
                    if playerListWindow then
                        playerListWindow:Destroy()
                        playerListWindow = nil
                    end
                end
                createNotification("Player List", state and "Janela aberta!" or "Janela fechada!")
            end)
            yPos = yPos + 45
            
        end
        
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)
    end
    
    -- Player List Window Function
    local function createPlayerListWindow()
        if playerListWindow then
            playerListWindow:Destroy()
        end
        
        playerListWindow = Instance.new("ScreenGui")
        playerListWindow.Name = "PlayerListWindow"
        playerListWindow.Parent = playerGui
        
        local listFrame = createFrame(playerListWindow, UDim2.new(0, 350, 0, 500), UDim2.new(0.5, -175, 0.5, -250), COLORS.BACKGROUND, 12)
        
        -- Header
        local header = createFrame(listFrame, UDim2.new(1, 0, 0, 50), UDim2.new(0, 0, 0, 0), COLORS.PRIMARY, 12)
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -50, 1, 0)
        title.Position = UDim2.new(0, 10, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "PLAYER LIST"
        title.TextColor3 = COLORS.TEXT
        title.TextSize = 18
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = header
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0, 40, 0, 40)
        closeBtn.Position = UDim2.new(1, -45, 0, 5)
        closeBtn.BackgroundColor3 = COLORS.ERROR
        closeBtn.Text = "X"
        closeBtn.TextColor3 = COLORS.TEXT
        closeBtn.TextSize = 16
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.BorderSizePixel = 0
        closeBtn.Parent = header
        
        local closeBtnCorner = Instance.new("UICorner")
        closeBtnCorner.CornerRadius = UDim.new(0, 8)
        closeBtnCorner.Parent = closeBtn
        
        closeBtn.MouseButton1Click:Connect(function()
            isPlayerListVisible = false
            playerListWindow:Destroy()
            playerListWindow = nil
        end)
        
        -- Player List
        local playerScroll = Instance.new("ScrollingFrame")
        playerScroll.Size = UDim2.new(1, -20, 1, -120)
        playerScroll.Position = UDim2.new(0, 10, 0, 60)
        playerScroll.BackgroundTransparency = 1
        playerScroll.BorderSizePixel = 0
        playerScroll.ScrollBarThickness = 8
        playerScroll.ScrollBarImageColor3 = COLORS.ACCENT
        playerScroll.Parent = listFrame
        
        -- Troll Actions Frame
        local trollFrame = createFrame(listFrame, UDim2.new(1, -20, 0, 50), UDim2.new(0, 10, 1, -60), COLORS.SURFACE, 8)
        
        local trollLabel = Instance.new("TextLabel")
        trollLabel.Size = UDim2.new(0.3, 0, 1, 0)
        trollLabel.BackgroundTransparency = 1
        trollLabel.Text = "Selected: None"
        trollLabel.TextColor3 = COLORS.TEXT_SECONDARY
        trollLabel.TextSize = 12
        trollLabel.Font = Enum.Font.Gotham
        trollLabel.TextXAlignment = Enum.TextXAlignment.Left
        trollLabel.Parent = trollFrame
        
        local trollButtons = {"Freeze", "Fling", "Kill", "Clone"}
        for i, action in ipairs(trollButtons) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.15, -5, 0, 30)
            btn.Position = UDim2.new(0.3 + (i-1) * 0.17, 5, 0, 10)
            btn.BackgroundColor3 = COLORS.ACCENT
            btn.Text = action
            btn.TextColor3 = COLORS.TEXT
            btn.TextSize = 10
            btn.Font = Enum.Font.Gotham
            btn.BorderSizePixel = 0
            btn.Parent = trollFrame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                if selectedPlayer then
                    createNotification(action, selectedPlayer.Name .. " " .. action:lower() .. "ed!")
                else
                    createNotification("Error", "Selecione um player primeiro!")
                end
            end)
        end
        
        -- Update player list
        local function updatePlayerList()
            for _, child in pairs(playerScroll:GetChildren()) do
                if child:IsA("Frame") then
                    child:Destroy()
                end
            end
            
            local yPos = 0
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= player then
                    local playerFrame = createFrame(playerScroll, UDim2.new(1, -10, 0, 40), UDim2.new(0, 0, 0, yPos), COLORS.CARD, 6)
                    
                    local avatar = Instance.new("ImageLabel")
                    avatar.Size = UDim2.new(0, 30, 0, 30)
                    avatar.Position = UDim2.new(0, 5, 0, 5)
                    avatar.BackgroundTransparency = 1
                    avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. targetPlayer.UserId .. "&width=420&height=420&format=png"
                    avatar.Parent = playerFrame
                    
                    local avatarCorner = Instance.new("UICorner")
                    avatarCorner.CornerRadius = UDim.new(0, 15)
                    avatarCorner.Parent = avatar
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, -80, 1, 0)
                    nameLabel.Position = UDim2.new(0, 40, 0, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = targetPlayer.Name
                    nameLabel.TextColor3 = COLORS.TEXT
                    nameLabel.TextSize = 14
                    nameLabel.Font = Enum.Font.Gotham
                    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                    nameLabel.Parent = playerFrame
                    
                    local selectBtn = Instance.new("TextButton")
                    selectBtn.Size = UDim2.new(0, 60, 0, 25)
                    selectBtn.Position = UDim2.new(1, -65, 0, 7.5)
                    selectBtn.BackgroundColor3 = selectedPlayer == targetPlayer and COLORS.SUCCESS or COLORS.PRIMARY
                    selectBtn.Text = selectedPlayer == targetPlayer and "Selected" or "Select"
                    selectBtn.TextColor3 = COLORS.TEXT
                    selectBtn.TextSize = 10
                    selectBtn.Font = Enum.Font.Gotham
                    selectBtn.BorderSizePixel = 0
                    selectBtn.Parent = playerFrame
                    
                    local selectCorner = Instance.new("UICorner")
                    selectCorner.CornerRadius = UDim.new(0, 4)
                    selectCorner.Parent = selectBtn
                    
                    selectBtn.MouseButton1Click:Connect(function()
                        selectedPlayer = targetPlayer
                        trollLabel.Text = "Selected: " .. targetPlayer.Name
                        updatePlayerList()
                    end)
                    
                    yPos = yPos + 45
                end
            end
            
            playerScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
        end
        
        updatePlayerList()
        
        -- Auto-update every 5 seconds
        spawn(function()
            while playerListWindow and playerListWindow.Parent do
                wait(5)
                if playerListWindow and playerListWindow.Parent then
                    updatePlayerList()
                end
            end
        end)
        
        -- Make draggable
        local dragging = false
        local dragStart = nil
        local startPos = nil
        
        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = listFrame.Position
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                listFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end
    
    -- Initialize first tab
    updateTabContent()
    
    -- Admin ESP monitoring
    spawn(function()
        while true do
            wait(10) -- Check every 10 seconds
            if cheatStates.espAdmin then
                checkForAdmins()
            end
        end
    end)
    
    -- Player connection events
    Players.PlayerAdded:Connect(function(newPlayer)
        wait(2) -- Wait for player to load
        if cheatStates.espAdmin then
            checkForAdmins()
        end
    end)
    
    Players.PlayerRemoving:Connect(function(leavingPlayer)
        if adminESP[leavingPlayer] then
            removeAdminESP(leavingPlayer)
        end
        adminPlayers[leavingPlayer] = nil
        if selectedPlayer == leavingPlayer then
            selectedPlayer = nil
        end
    end)
end

-- Initialize the UI
createUI()

-- Toggle UI with INSERT key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        isUIVisible = not isUIVisible
        if mainFrame then
            mainFrame.Visible = isUIVisible
        end
    end
end)
            
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
