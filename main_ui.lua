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
    
    -- Removed close button as requested
    
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
            currentSubTab = nil -- Reset sub-tab when switching main tabs
            updateTabContent()
            
            -- Update tab colors
            for j, otherTabBtn in pairs(tabButtons) do
                local otherIcon = otherTabBtn:FindFirstChild("ImageLabel")
                local otherLabel = otherTabBtn:FindFirstChild("TextLabel")
                
                if otherIcon then
                    otherIcon.ImageColor3 = (j == i) and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
                end
                if otherLabel then
                    otherLabel.TextColor3 = (j == i) and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
                end
                
                -- Update background color
                otherTabBtn.BackgroundColor3 = (j == i) and COLORS.BORDER or COLORS.SURFACE
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
        
        -- Removed close button for sub-tabs as requested
        
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
            if not currentSubTab then currentSubTab = "Aimbot" end
            subTabFrame = createSubTabs(contentFrame, {"Aimbot", "Weapons", "Misc"}, updateTabContent)
            yOffset = 60
        elseif currentTab == "Movement" then
            if not currentSubTab then currentSubTab = "Speed" end
            subTabFrame = createSubTabs(contentFrame, {"Speed", "Flight", "Teleport"}, updateTabContent)
            yOffset = 60
        elseif currentTab == "Visuals" then
            if not currentSubTab then currentSubTab = "ESP" end
            subTabFrame = createSubTabs(contentFrame, {"ESP", "Chams", "World"}, updateTabContent)
            yOffset = 60
        elseif currentTab == "Roleplay" then
            if not currentSubTab then currentSubTab = "Spawn" end
            subTabFrame = createSubTabs(contentFrame, {"Spawn", "Character", "Utilities"}, updateTabContent)
            yOffset = 60
        elseif currentTab == "Blox Fruits" then
            if not currentSubTab then currentSubTab = "Farm" end
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

-- Toggle UI Function
local function toggleUI()
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
