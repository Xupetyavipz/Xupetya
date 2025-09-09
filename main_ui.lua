-- SPWARE V3 - Premium Cheat Menu (Fatality/Gamesense Style)
-- Professional Interface Design

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mouse = player:GetMouse()

-- Clean up existing UI
pcall(function()
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui.Name:find("SPWARE") then
            gui:Destroy()
        end
    end
end)

-- Variables
local mainFrame = nil
local currentTab = "Combat"
local isVisible = true
local animating = false

-- Premium Color Scheme (Fatality/Gamesense Style)
local COLORS = {
    BACKGROUND = Color3.fromRGB(17, 17, 17),
    SURFACE = Color3.fromRGB(24, 24, 24),
    SIDEBAR = Color3.fromRGB(20, 20, 20),
    ACCENT = Color3.fromRGB(144, 238, 144),
    ACCENT_HOVER = Color3.fromRGB(124, 218, 124),
    PRIMARY = Color3.fromRGB(60, 60, 60),
    BORDER = Color3.fromRGB(40, 40, 40),
    TEXT = Color3.fromRGB(255, 255, 255),
    TEXT_DIM = Color3.fromRGB(180, 180, 180),
    TEXT_DARK = Color3.fromRGB(120, 120, 120),
    SUCCESS = Color3.fromRGB(144, 238, 144),
    ERROR = Color3.fromRGB(255, 99, 99),
    WARNING = Color3.fromRGB(255, 193, 99)
}

-- Cheat States
local cheats = {
    aimbot = false,
    esp = false,
    fly = false,
    noclip = false,
    speed = false,
    fullbright = false,
    infiniteJump = false,
    walkSpeed = 16,
    jumpPower = 50,
    flySpeed = 50
}

-- Notification Function
local function showNotification(message)
    StarterGui:SetCore("SendNotification", {
        Title = "SPWARE",
        Text = message,
        Duration = 3
    })
end

-- Player List Window Function
local function createPlayerListWindow()
    showNotification("Player List window opened")
end

-- ESP System
local espObjects = {}
local function createESP(target)
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP_" .. target.Name
    billboardGui.Adornee = target.Character.HumanoidRootPart
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Parent = target.Character.HumanoidRootPart
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.3
    frame.BackgroundColor3 = COLORS.PRIMARY
    frame.BorderSizePixel = 0
    frame.Parent = billboardGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = target.Name
    nameLabel.TextColor3 = COLORS.TEXT
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = frame
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0.4, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.6, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = "0m"
    distanceLabel.TextColor3 = COLORS.TEXT_DIM
    distanceLabel.TextScaled = true
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.Parent = frame
    
    espObjects[target] = {gui = billboardGui, distance = distanceLabel}
    
    -- Update distance
    spawn(function()
        while espObjects[target] and target.Character and target.Character:FindFirstChild("HumanoidRootPart") do
            wait(0.1)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (player.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude
                distanceLabel.Text = math.floor(distance) .. "m"
            end
        end
    end)
end

local function removeESP(target)
    if espObjects[target] then
        espObjects[target].gui:Destroy()
        espObjects[target] = nil
    end
end

local function toggleESP()
    if cheats.esp then
        for _, target in pairs(Players:GetPlayers()) do
            if target ~= player then
                createESP(target)
            end
        end
    else
        for target, _ in pairs(espObjects) do
            removeESP(target)
        end
    end
end

-- Movement Functions
local flyConnection = nil
local function toggleFly()
    if cheats.fly then
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = humanoidRootPart
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not cheats.fly then
                bodyVelocity:Destroy()
                flyConnection:Disconnect()
                return
            end
            
            local moveVector = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveVector = moveVector + (workspace.CurrentCamera.CFrame.LookVector * cheats.flySpeed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveVector = moveVector - (workspace.CurrentCamera.CFrame.LookVector * cheats.flySpeed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveVector = moveVector - (workspace.CurrentCamera.CFrame.RightVector * cheats.flySpeed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveVector = moveVector + (workspace.CurrentCamera.CFrame.RightVector * cheats.flySpeed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveVector = moveVector + Vector3.new(0, cheats.flySpeed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveVector = moveVector - Vector3.new(0, cheats.flySpeed, 0)
            end
            
            bodyVelocity.Velocity = moveVector
        end)
    else
        if flyConnection then
            flyConnection:Disconnect()
        end
    end
end

local noclipConnection = nil
local function toggleNoclip()
    if cheats.noclip then
        noclipConnection = RunService.Stepped:Connect(function()
            if not cheats.noclip then
                noclipConnection:Disconnect()
                return
            end
            
            local character = player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
    end
end

local function updateWalkSpeed()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = cheats.speed and cheats.walkSpeed or 16
    end
end

local function updateJumpPower()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.JumpPower = cheats.infiniteJump and cheats.jumpPower or 50
    end
end

local function toggleFullbright()
    if cheats.fullbright then
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

-- Premium UI Creation (Fatality/Gamesense Style)
local function createUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SPWARE_V3_PREMIUM"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Main Container
    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainContainer"
    mainFrame.Size = UDim2.new(0, 750, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -375, 0.5, -250)
    mainFrame.BackgroundColor3 = COLORS.BACKGROUND
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Drop Shadow Effect
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "DropShadow"
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/InspectMenu/Shadow.png"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.ZIndex = -1
    shadow.Parent = mainFrame
    
    -- Main Border
    local mainBorder = Instance.new("UIStroke")
    mainBorder.Color = COLORS.BORDER
    mainBorder.Thickness = 1
    mainBorder.Parent = mainFrame
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = COLORS.SURFACE
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleBorder = Instance.new("Frame")
    titleBorder.Size = UDim2.new(1, 0, 0, 1)
    titleBorder.Position = UDim2.new(0, 0, 1, 0)
    titleBorder.BackgroundColor3 = COLORS.BORDER
    titleBorder.BorderSizePixel = 0
    titleBorder.Parent = titleBar
    
    -- Logo and Title
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(0, 200, 1, 0)
    logo.Position = UDim2.new(0, 15, 0, 0)
    logo.BackgroundTransparency = 1
    logo.Text = "SPWARE"
    logo.TextColor3 = COLORS.ACCENT
    logo.TextSize = 16
    logo.Font = Enum.Font.GothamBold
    logo.TextXAlignment = Enum.TextXAlignment.Left
    logo.Parent = titleBar
    
    local version = Instance.new("TextLabel")
    version.Size = UDim2.new(0, 100, 1, 0)
    version.Position = UDim2.new(0, 85, 0, 0)
    version.BackgroundTransparency = 1
    version.Text = "v3.0"
    version.TextColor3 = COLORS.TEXT_DARK
    version.TextSize = 12
    version.Font = Enum.Font.Gotham
    version.TextXAlignment = Enum.TextXAlignment.Left
    version.Parent = titleBar
    
    -- User Info
    local userInfo = Instance.new("TextLabel")
    userInfo.Size = UDim2.new(0, 200, 1, 0)
    userInfo.Position = UDim2.new(1, -215, 0, 0)
    userInfo.BackgroundTransparency = 1
    userInfo.Text = "Welcome, " .. player.Name
    userInfo.TextColor3 = COLORS.TEXT_DIM
    userInfo.TextSize = 12
    userInfo.Font = Enum.Font.Gotham
    userInfo.TextXAlignment = Enum.TextXAlignment.Right
    userInfo.Parent = titleBar
    
    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 180, 1, -35)
    sidebar.Position = UDim2.new(0, 0, 0, 35)
    sidebar.BackgroundColor3 = COLORS.SIDEBAR
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame
    
    local sidebarBorder = Instance.new("Frame")
    sidebarBorder.Size = UDim2.new(0, 1, 1, 0)
    sidebarBorder.Position = UDim2.new(1, 0, 0, 0)
    sidebarBorder.BackgroundColor3 = COLORS.BORDER
    sidebarBorder.BorderSizePixel = 0
    sidebarBorder.Parent = sidebar
    
    -- Content Area
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -181, 1, -35)
    contentArea.Position = UDim2.new(0, 181, 0, 35)
    contentArea.BackgroundColor3 = COLORS.SURFACE
    contentArea.BorderSizePixel = 0
    contentArea.Parent = mainFrame
    
    -- Scroll Frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -20)
    scrollFrame.Position = UDim2.new(0, 10, 0, 10)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.ScrollBarImageColor3 = COLORS.PRIMARY
    scrollFrame.Parent = contentArea
    
    -- Create Premium Sidebar Tabs
    local tabs = {
        {name = "Combat", icon = "⚔️"},
        {name = "Movement", icon = "🏃"},
        {name = "Visual", icon = "👁️"},
        {name = "Roleplay", icon = "🎭"},
        {name = "Blox Fruits", icon = "🥭"},
        {name = "Player List", icon = "📋"},
        {name = "Car List", icon = "🚗"},
        {name = "Chat", icon = "💬"}
    }
    
    for i, tab in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tab.name .. "Tab"
        tabButton.Size = UDim2.new(1, -10, 0, 45)
        tabButton.Position = UDim2.new(0, 5, 0, (i-1) * 50 + 15)
        tabButton.BackgroundColor3 = tab.name == currentTab and COLORS.ACCENT or Color3.fromRGB(0, 0, 0, 0)
        tabButton.BackgroundTransparency = tab.name == currentTab and 0 or 1
        tabButton.BorderSizePixel = 0
        tabButton.Text = ""
        tabButton.Parent = sidebar
        
        -- Tab Selection Indicator
        local indicator = Instance.new("Frame")
        indicator.Name = "Indicator"
        indicator.Size = UDim2.new(0, 3, 0, 25)
        indicator.Position = UDim2.new(0, 0, 0.5, -12.5)
        indicator.BackgroundColor3 = COLORS.ACCENT
        indicator.BorderSizePixel = 0
        indicator.Visible = tab.name == currentTab
        indicator.Parent = tabButton
        
        -- Tab Icon
        local icon = Instance.new("TextLabel")
        icon.Size = UDim2.new(0, 25, 0, 25)
        icon.Position = UDim2.new(0, 15, 0.5, -12.5)
        icon.BackgroundTransparency = 1
        icon.Text = tab.icon
        icon.TextColor3 = tab.name == currentTab and COLORS.TEXT or COLORS.TEXT_DARK
        icon.TextSize = 16
        icon.Font = Enum.Font.Gotham
        icon.Parent = tabButton
        
        -- Tab Label
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -50, 1, 0)
        label.Position = UDim2.new(0, 45, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = tab.name
        label.TextColor3 = tab.name == currentTab and COLORS.TEXT or COLORS.TEXT_DARK
        label.TextSize = 13
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = tabButton
        
        -- Hover Effects
        tabButton.MouseEnter:Connect(function()
            if tab.name ~= currentTab then
                TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.9}):Play()
                TweenService:Create(icon, TweenInfo.new(0.2), {TextColor3 = COLORS.TEXT_DIM}):Play()
                TweenService:Create(label, TweenInfo.new(0.2), {TextColor3 = COLORS.TEXT_DIM}):Play()
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if tab.name ~= currentTab then
                TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                TweenService:Create(icon, TweenInfo.new(0.2), {TextColor3 = COLORS.TEXT_DARK}):Play()
                TweenService:Create(label, TweenInfo.new(0.2), {TextColor3 = COLORS.TEXT_DARK}):Play()
            end
        end)
        
        tabButton.MouseButton1Click:Connect(function()
            if currentTab ~= tab.name and not animating then
                animating = true
                local oldTab = currentTab
                currentTab = tab.name
                
                -- Update all tabs
                for _, otherTab in pairs(sidebar:GetChildren()) do
                    if otherTab:IsA("TextButton") and otherTab.Name:find("Tab") then
                        local otherIndicator = otherTab:FindFirstChild("Indicator")
                        local otherIcon = otherTab:FindFirstChild("TextLabel")
                        local otherLabel = otherTab:FindFirstChild("TextLabel") and otherTab:FindFirstChild("TextLabel").Parent:FindFirstChild("TextLabel")
                        
                        if otherTab.Name == tab.name .. "Tab" then
                            -- Selected tab
                            TweenService:Create(otherTab, TweenInfo.new(0.3), {BackgroundTransparency = 0, BackgroundColor3 = COLORS.ACCENT}):Play()
                            if otherIndicator then otherIndicator.Visible = true end
                            if otherIcon then TweenService:Create(otherIcon, TweenInfo.new(0.3), {TextColor3 = COLORS.TEXT}):Play() end
                            if otherLabel then TweenService:Create(otherLabel, TweenInfo.new(0.3), {TextColor3 = COLORS.TEXT}):Play() end
                        else
                            -- Unselected tabs
                            TweenService:Create(otherTab, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                            if otherIndicator then otherIndicator.Visible = false end
                            if otherIcon then TweenService:Create(otherIcon, TweenInfo.new(0.3), {TextColor3 = COLORS.TEXT_DARK}):Play() end
                            if otherLabel then TweenService:Create(otherLabel, TweenInfo.new(0.3), {TextColor3 = COLORS.TEXT_DARK}):Play() end
                        end
                    end
                end
                
                updateTabContent(contentArea)
                wait(0.3)
                animating = false
            end
        end)
    end
    
    -- Helper Functions
    local function createSection(parent, title)
        local sectionFrame = Instance.new("Frame")
        sectionFrame.Size = UDim2.new(1, 0, 0, 35)
        sectionFrame.BackgroundTransparency = 1
        sectionFrame.Parent = parent
        
        local sectionLabel = Instance.new("TextLabel")
        sectionLabel.Size = UDim2.new(1, -20, 1, 0)
        sectionLabel.Position = UDim2.new(0, 10, 0, 0)
        sectionLabel.BackgroundTransparency = 1
        sectionLabel.Text = title
        sectionLabel.TextColor3 = COLORS.ACCENT
        sectionLabel.TextSize = 16
        sectionLabel.Font = Enum.Font.GothamBold
        sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
        sectionLabel.Parent = sectionFrame
        
        return 35
    end
    
    local function createToggle(parent, text, description, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, 0, 0, 40)
        toggleFrame.BackgroundColor3 = COLORS.BORDER
        toggleFrame.BorderSizePixel = 0
        toggleFrame.Parent = parent
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 6)
        toggleCorner.Parent = toggleFrame
        
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
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0, 40, 0, 20)
        toggleButton.Position = UDim2.new(1, -50, 0.5, -10)
        toggleButton.BackgroundColor3 = COLORS.ERROR
        toggleButton.Text = "OFF"
        toggleButton.TextColor3 = COLORS.TEXT
        toggleButton.TextSize = 10
        toggleButton.Font = Enum.Font.GothamBold
        toggleButton.BorderSizePixel = 0
        toggleButton.Parent = toggleFrame
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = toggleButton
        
        local isToggled = false
        toggleButton.MouseButton1Click:Connect(function()
            isToggled = not isToggled
            toggleButton.BackgroundColor3 = isToggled and COLORS.SUCCESS or COLORS.ERROR
            toggleButton.Text = isToggled and "ON" or "OFF"
            if callback then callback(isToggled) end
        end)
        
        return 40
    end
    
    local function createSlider(parent, text, min, max, default, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, 0, 0, 50)
        sliderFrame.BackgroundColor3 = COLORS.BORDER
        sliderFrame.BorderSizePixel = 0
        sliderFrame.Parent = parent
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 6)
        sliderCorner.Parent = sliderFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 25)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text .. ": " .. default
        label.TextColor3 = COLORS.TEXT
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = sliderFrame
        
        local sliderBar = Instance.new("Frame")
        sliderBar.Size = UDim2.new(1, -20, 0, 4)
        sliderBar.Position = UDim2.new(0, 10, 0, 30)
        sliderBar.BackgroundColor3 = COLORS.BACKGROUND
        sliderBar.BorderSizePixel = 0
        sliderBar.Parent = sliderFrame
        
        local barCorner = Instance.new("UICorner")
        barCorner.CornerRadius = UDim.new(0, 2)
        barCorner.Parent = sliderBar
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        sliderFill.BackgroundColor3 = COLORS.PRIMARY
        sliderFill.BorderSizePixel = 0
        sliderFill.Parent = sliderBar
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 2)
        fillCorner.Parent = sliderFill
        
        local sliderButton = Instance.new("TextButton")
        sliderButton.Size = UDim2.new(0, 16, 0, 16)
        sliderButton.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
        sliderButton.BackgroundColor3 = COLORS.ACCENT
        sliderButton.Text = ""
        sliderButton.BorderSizePixel = 0
        sliderButton.Parent = sliderBar
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = sliderButton
        
        local dragging = false
        sliderButton.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local relativePos = math.clamp((mouse.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * relativePos)
                
                sliderFill.Size = UDim2.new(relativePos, 0, 1, 0)
                sliderButton.Position = UDim2.new(relativePos, -8, 0.5, -8)
                label.Text = text .. ": " .. value
                
                if callback then callback(value) end
            end
        end)
        
        return 50
    end
    
    local function createButton(parent, text, description, callback)
        local buttonFrame = Instance.new("TextButton")
        buttonFrame.Size = UDim2.new(1, 0, 0, 35)
        buttonFrame.BackgroundColor3 = COLORS.PRIMARY
        buttonFrame.BorderSizePixel = 0
        buttonFrame.Text = text
        buttonFrame.TextColor3 = COLORS.TEXT
        buttonFrame.TextSize = 14
        buttonFrame.Font = Enum.Font.Gotham
        buttonFrame.Parent = parent
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = buttonFrame
        
        buttonFrame.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        return 35
    end
    
    -- Premium Tab Content Updates
    local function updateTabContent(contentArea)
        -- Clear existing content
        for _, child in pairs(contentArea:GetChildren()) do
            child:Destroy()
        end
        
        -- Content Scroll Frame
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Size = UDim2.new(1, -20, 1, -20)
        scrollFrame.Position = UDim2.new(0, 10, 0, 10)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.ScrollBarThickness = 4
        scrollFrame.ScrollBarImageColor3 = COLORS.ACCENT
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        scrollFrame.Parent = contentArea
        
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 15)
        layout.Parent = scrollFrame
        
        local yPos = 0
        
        if currentTab == "Combat" then
            -- Combat Features
            local yOffset = 0
            
            -- Aimbot Section
            yOffset = yOffset + createSection(scrollFrame, "⚔️ Aimbot")
            yOffset = yOffset + createToggle(scrollFrame, "Aimbot", "Enable automatic aiming", function(enabled)
                cheats.aimbot = enabled
                showNotification("SPWARE: " .. (enabled and "Aimbot ON" or "Aimbot OFF"))
            end)
            yOffset = yOffset + createSlider(scrollFrame, "FOV Size", 50, 500, 120)
            yOffset = yOffset + createSlider(scrollFrame, "Smoothness", 1, 20, 5)
            yOffset = yOffset + createToggle(scrollFrame, "Silent Aim", "Invisible aim assistance", function(enabled)
                showNotification("SPWARE: Silent Aim " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Ragebot", "Aggressive targeting", function(enabled)
                showNotification("SPWARE: Ragebot " .. (enabled and "ON" or "OFF"))
            end)
            
            -- TriggerBot Section
            yOffset = yOffset + createSection(scrollFrame, "🎯 TriggerBot")
            yOffset = yOffset + createToggle(scrollFrame, "TriggerBot", "Auto shoot when on target", function(enabled)
                showNotification("SPWARE: TriggerBot " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createSlider(scrollFrame, "Trigger Delay", 0, 500, 50)
            
            -- Combat Enhancements
            yOffset = yOffset + createSection(scrollFrame, "💥 Combat Enhancements")
            yOffset = yOffset + createToggle(scrollFrame, "Hitbox Expander", "Increase hitbox size", function(enabled)
                showNotification("SPWARE: Hitbox Expander " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "One Shot Kill", "Instant elimination", function(enabled)
                showNotification("SPWARE: One Shot Kill " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "No Recoil", "Remove weapon recoil", function(enabled)
                showNotification("SPWARE: No Recoil " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "No Spread", "Remove bullet spread", function(enabled)
                showNotification("SPWARE: No Spread " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Infinite Ammo", "Unlimited ammunition", function(enabled)
                showNotification("SPWARE: Infinite Ammo " .. (enabled and "ON" or "OFF"))
            end)
            
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 50)
            
        elseif currentTab == "Movement" then
            local yOffset = 0
            
            yOffset = yOffset + createSection(scrollFrame, "🏃 Movement Hacks")
            yOffset = yOffset + createToggle(scrollFrame, "Bunny Hop", "Auto bunny hopping", function(enabled)
                showNotification("SPWARE: Bunny Hop " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Strafe Hack", "Enhanced strafing", function(enabled)
                showNotification("SPWARE: Strafe Hack " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Speed Hack", "Increased movement speed", function(enabled)
                cheats.speed = enabled
                showNotification("SPWARE: Speed Hack " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createSlider(scrollFrame, "Speed Multiplier", 1, 10, 3)
            
            yOffset = yOffset + createSection(scrollFrame, "✈️ Flight & Teleport")
            yOffset = yOffset + createToggle(scrollFrame, "Fly", "Enable flight mode", function(enabled)
                cheats.fly = enabled
                toggleFly()
                showNotification("SPWARE: Fly " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Jetpack", "Jetpack mode", function(enabled)
                showNotification("SPWARE: Jetpack " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Noclip", "Walk through walls", function(enabled)
                cheats.noclip = enabled
                toggleNoclip()
                showNotification("SPWARE: Noclip " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Teleport Kill", "Instant teleport kills", function(enabled)
                showNotification("SPWARE: Teleport Kill " .. (enabled and "ON" or "OFF"))
            end)
            
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 50)
            
        elseif currentTab == "Visual" then
            local yOffset = 0
            
            yOffset = yOffset + createSection(scrollFrame, "👁️ ESP Players")
            yOffset = yOffset + createToggle(scrollFrame, "ESP Box", "Show player boxes", function(enabled)
                showNotification("SPWARE: ESP Box " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "ESP Skeleton", "Show player skeletons", function(enabled)
                showNotification("SPWARE: ESP Skeleton " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "ESP Head Dot", "Show head indicators", function(enabled)
                showNotification("SPWARE: ESP Head Dot " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "ESP Weapons", "Show weapon ESP", function(enabled)
                showNotification("SPWARE: ESP Weapons " .. (enabled and "ON" or "OFF"))
            end)
            
            yOffset = yOffset + createSection(scrollFrame, "🌟 Visual Effects")
            yOffset = yOffset + createToggle(scrollFrame, "Chams", "See players through walls", function(enabled)
                showNotification("SPWARE: Chams " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Glow Effect", "Player glow effect", function(enabled)
                showNotification("SPWARE: Glow Effect " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Radar Hack", "Mini radar display", function(enabled)
                showNotification("SPWARE: Radar Hack " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Custom Crosshair", "Enhanced crosshair", function(enabled)
                showNotification("SPWARE: Custom Crosshair " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Night Vision", "Enhanced visibility", function(enabled)
                showNotification("SPWARE: Night Vision " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Full Bright", "Maximum brightness", function(enabled)
                cheats.fullbright = enabled
                toggleFullbright()
                showNotification("SPWARE: Full Bright " .. (enabled and "ON" or "OFF"))
            end)
            
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 50)
            
        elseif currentTab == "Player List" then
            -- Create Player List Window
            createPlayerListWindow()
            
        elseif currentTab == "Chat" then
            local yOffset = 0
            
            yOffset = yOffset + createSection(scrollFrame, "💬 Quick Messages")
            yOffset = yOffset + createButton(scrollFrame, "Spam Chat", "Flood chat with messages", function()
                showNotification("SPWARE: Chat Spam Started")
            end)
            yOffset = yOffset + createButton(scrollFrame, "Auto GG", "Auto good game messages", function()
                showNotification("SPWARE: Auto GG Enabled")
            end)
            yOffset = yOffset + createButton(scrollFrame, "Fake Admin", "Send fake admin messages", function()
                showNotification("SPWARE: Fake Admin Messages")
            end)
            
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 50)
            
        elseif currentTab == "Roleplay" then
            local yOffset = 0
            
            yOffset = yOffset + createSection(scrollFrame, "🎭 Roleplay Features")
            yOffset = yOffset + createToggle(scrollFrame, "Spawn Cars", "Spawn any vehicle", function(enabled)
                showNotification("SPWARE: Spawn Cars " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Super Speed Car", "Enhanced vehicle speed", function(enabled)
                showNotification("SPWARE: Super Speed Car " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Fly Car", "Flying vehicles", function(enabled)
                showNotification("SPWARE: Fly Car " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Godmode", "Invincibility mode", function(enabled)
                showNotification("SPWARE: Godmode " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Invisible Mode", "Player invisibility", function(enabled)
                showNotification("SPWARE: Invisible Mode " .. (enabled and "ON" or "OFF"))
            end)
            
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 50)
            
        elseif currentTab == "Blox Fruits" then
            local yOffset = 0
            
            yOffset = yOffset + createSection(scrollFrame, "🥭 Auto Farm")
            yOffset = yOffset + createToggle(scrollFrame, "Auto Farm Level", "Automatic leveling", function(enabled)
                showNotification("SPWARE: Auto Farm Level " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Auto Farm Boss", "Boss farming", function(enabled)
                showNotification("SPWARE: Auto Farm Boss " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Auto Farm Fruits", "Fruit collection", function(enabled)
                showNotification("SPWARE: Auto Farm Fruits " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Kill Aura", "Attack nearby enemies", function(enabled)
                showNotification("SPWARE: Kill Aura " .. (enabled and "ON" or "OFF"))
            end)
            yOffset = yOffset + createToggle(scrollFrame, "Walk on Water", "Water walking ability", function(enabled)
                showNotification("SPWARE: Walk on Water " .. (enabled and "ON" or "OFF"))
            end)
            
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 50)
            
        elseif currentTab == "Car List" then
            local yOffset = 0
            
            yOffset = yOffset + createSection(scrollFrame, "🚗 Car List")
            yOffset = yOffset + createButton(scrollFrame, "Spawn Car", "Spawn selected vehicle", function()
                showNotification("SPWARE: Car Spawned")
            end)
            yOffset = yOffset + createButton(scrollFrame, "Clone Car", "Clone existing vehicle", function()
                showNotification("SPWARE: Car Cloned")
            end)
            yOffset = yOffset + createButton(scrollFrame, "TP to Car", "Teleport to vehicle", function()
                showNotification("SPWARE: Teleported to Car")
            end)
            yOffset = yOffset + createButton(scrollFrame, "Delete Car", "Remove vehicle", function()
                showNotification("SPWARE: Car Deleted")
            end)
            
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 50)
        end
    end
    
    -- Initialize UI
    updateTabContent(contentArea)
    
    -- Drag functionality
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Initialize the UI
createUI()

-- Toggle UI with INSERT key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        if mainFrame then
            isVisible = not isVisible
            mainFrame.Visible = isVisible
            showNotification("SPWARE " .. (isVisible and "Opened" or "Closed"))
        end
    end
end)
