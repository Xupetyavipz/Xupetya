-- Professional Roblox Cheat UI - FiveM Style
-- Modern Design with Purple/Black Theme

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
local toggleStates = {}
local sliderValues = {}

-- Professional Color Scheme
local COLORS = {
    BACKGROUND = Color3.fromRGB(15, 15, 15),     -- Deep Black
    SURFACE = Color3.fromRGB(25, 25, 25),        -- Dark Surface
    CARD = Color3.fromRGB(30, 30, 30),           -- Card Background
    PRIMARY = Color3.fromRGB(147, 51, 234),      -- Purple Primary
    SECONDARY = Color3.fromRGB(168, 85, 247),    -- Purple Secondary
    ACCENT = Color3.fromRGB(196, 181, 253),      -- Purple Light
    TEXT_PRIMARY = Color3.fromRGB(255, 255, 255), -- White
    TEXT_SECONDARY = Color3.fromRGB(156, 163, 175), -- Gray
    SUCCESS = Color3.fromRGB(34, 197, 94),       -- Green
    WARNING = Color3.fromRGB(251, 191, 36),      -- Yellow
    ERROR = Color3.fromRGB(239, 68, 68),         -- Red
    BORDER = Color3.fromRGB(55, 65, 81),         -- Border Gray
}

-- Notification System
local function createNotification(title, message, type)
    local color = type == "success" and COLORS.SUCCESS or type == "error" and COLORS.ERROR or COLORS.PRIMARY
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = message,
        Duration = 3
    })
end

-- Professional UI Components
local function createFrame(parent, size, position, backgroundColor, cornerRadius)
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(1, 0, 1, 0)
    frame.Position = position or UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = backgroundColor or COLORS.SURFACE
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    if cornerRadius then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, cornerRadius)
        corner.Parent = frame
    end
    
    return frame
end

local function createToggle(parent, position, text, defaultState, callback)
    local toggleFrame = createFrame(parent, UDim2.new(1, -20, 0, 35), position, COLORS.CARD, 8)
    
    -- Toggle Background
    local toggleBg = createFrame(toggleFrame, UDim2.new(0, 50, 0, 24), UDim2.new(1, -60, 0.5, -12), COLORS.SURFACE, 12)
    
    -- Toggle Circle
    local toggleCircle = createFrame(toggleBg, UDim2.new(0, 20, 0, 20), UDim2.new(0, 2, 0.5, -10), COLORS.TEXT_SECONDARY, 10)
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.TEXT_PRIMARY
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    -- State
    local isEnabled = defaultState or false
    toggleStates[text] = isEnabled
    
    local function updateToggle()
        local targetColor = isEnabled and COLORS.PRIMARY or COLORS.SURFACE
        local targetPos = isEnabled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        
        TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = targetPos}):Play()
    end
    
    updateToggle()
    
    -- Click Handler
    local clickDetector = Instance.new("TextButton")
    clickDetector.Size = UDim2.new(1, 0, 1, 0)
    clickDetector.BackgroundTransparency = 1
    clickDetector.Text = ""
    clickDetector.Parent = toggleFrame
    
    clickDetector.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        toggleStates[text] = isEnabled
        updateToggle()
        if callback then callback(isEnabled) end
    end)
    
    return toggleFrame
end

local function createSlider(parent, position, text, minVal, maxVal, defaultVal, callback)
    local sliderFrame = createFrame(parent, UDim2.new(1, -20, 0, 50), position, COLORS.CARD, 8)
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. (defaultVal or minVal)
    label.TextColor3 = COLORS.TEXT_PRIMARY
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    -- Slider Track
    local track = createFrame(sliderFrame, UDim2.new(1, -20, 0, 4), UDim2.new(0, 10, 1, -15), COLORS.SURFACE, 2)
    
    -- Slider Fill
    local fill = createFrame(track, UDim2.new(0.5, 0, 1, 0), UDim2.new(0, 0, 0, 0), COLORS.PRIMARY, 2)
    
    -- Slider Handle
    local handle = createFrame(sliderFrame, UDim2.new(0, 16, 0, 16), UDim2.new(0.5, -8, 1, -23), COLORS.TEXT_PRIMARY, 8)
    
    -- State
    local currentValue = defaultVal or minVal
    sliderValues[text] = currentValue
    
    local function updateSlider(value)
        local percentage = (value - minVal) / (maxVal - minVal)
        fill.Size = UDim2.new(percentage, 0, 1, 0)
        handle.Position = UDim2.new(percentage, -8, 1, -23)
        label.Text = text .. ": " .. math.floor(value)
        sliderValues[text] = value
        if callback then callback(value) end
    end
    
    updateSlider(currentValue)
    
    -- Drag Handler
    local dragging = false
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local trackPos = track.AbsolutePosition.X
            local trackSize = track.AbsoluteSize.X
            local mouseX = input.Position.X
            local percentage = math.clamp((mouseX - trackPos) / trackSize, 0, 1)
            local value = minVal + (maxVal - minVal) * percentage
            updateSlider(value)
        end
    end)
    
    return sliderFrame
end

local function createButton(parent, position, text, callback, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 35)
    button.Position = position
    button.BackgroundColor3 = color or COLORS.PRIMARY
    button.Text = text
    button.TextColor3 = COLORS.TEXT_PRIMARY
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 0
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Hover Effects
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.SECONDARY}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = color or COLORS.PRIMARY}):Play()
    end)
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
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
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ProfessionalCheatUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Main Container
    mainFrame = createFrame(screenGui, UDim2.new(0, 900, 0, 600), UDim2.new(0.5, -450, 0.5, -300), COLORS.BACKGROUND, 12)
    
    -- Header
    local header = createFrame(mainFrame, UDim2.new(1, 0, 0, 60), UDim2.new(0, 0, 0, 0), COLORS.SURFACE, 0)
    
    -- Logo SPWARE
    local logoImage = Instance.new("ImageLabel")
    logoImage.Size = UDim2.new(0, 40, 0, 40)
    logoImage.Position = UDim2.new(0, 80, 0, 5)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = "rbxassetid://70651953090646"
    logoImage.Parent = header
    
    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(0, 8)
    logoCorner.Parent = logoImage
    
    -- Nome SPWARE
    local spwareName = Instance.new("TextLabel")
    spwareName.Size = UDim2.new(0, 120, 0, 25)
    spwareName.Position = UDim2.new(0, 130, 0, 10)
    spwareName.BackgroundTransparency = 1
    spwareName.Text = "SPWARE"
    spwareName.TextColor3 = COLORS.ACCENT
    spwareName.TextScaled = true
    spwareName.Font = Enum.Font.GothamBold
    spwareName.TextXAlignment = Enum.TextXAlignment.Left
    spwareName.Parent = header
    
    -- Nome do usuário
    local userName = Instance.new("TextLabel")
    userName.Size = UDim2.new(0, 120, 0, 15)
    userName.Position = UDim2.new(0, 130, 0, 30)
    userName.BackgroundTransparency = 1
    userName.Text = "👋 " .. player.Name
    userName.TextColor3 = COLORS.TEXT
    userName.TextScaled = true
    userName.Font = Enum.Font.Gotham
    userName.TextXAlignment = Enum.TextXAlignment.Left
    userName.Parent = header
    
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -50, 0.5, -20)
    closeBtn.BackgroundColor3 = COLORS.ERROR
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = COLORS.TEXT_PRIMARY
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = header
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 8)
    closeBtnCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        toggleUI()
    end)
    
    -- Sidebar
    local sidebar = createFrame(mainFrame, UDim2.new(0, 200, 1, -60), UDim2.new(0, 0, 0, 60), COLORS.SURFACE, 0)
    
    -- Tab Buttons
    local tabButtons = {}
    for i, tab in ipairs(TABS) do
        local tabBtn = createFrame(sidebar, UDim2.new(1, -10, 0, 45), UDim2.new(0, 5, 0, 10 + (i-1) * 50), COLORS.CARD, 8)
        
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
        
        local tabIcon = Instance.new("ImageLabel")
        tabIcon.Size = UDim2.new(0, 20, 0, 20)
        tabIcon.Position = UDim2.new(0, 15, 0.5, -10)
        tabIcon.BackgroundTransparency = 1
        tabIcon.Image = tab.icon
        tabIcon.ImageColor3 = currentTab == tab.name and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
        tabIcon.Parent = tabBtn
        
        local tabClickBtn = Instance.new("TextButton")
        tabClickBtn.Size = UDim2.new(1, 0, 1, 0)
        tabClickBtn.BackgroundTransparency = 1
        tabClickBtn.Text = ""
        tabClickBtn.Parent = tabBtn
        
        tabClickBtn.MouseButton1Click:Connect(function()
            currentTab = tab.name
            updateTabContent()
            for j, btn in pairs(tabButtons) do
                local btnLabel = btn:FindFirstChild("TextLabel")
                local btnIcon = btn:FindFirstChild("ImageLabel")
                if btnLabel then
                    btnLabel.TextColor3 = j == i and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
                end
                if btnIcon then
                    btnIcon.ImageColor3 = j == i and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
                end
            end
        end)
        
        tabButtons[i] = tabBtn
    end
    
    -- Content Area
    local contentArea = createFrame(mainFrame, UDim2.new(1, -210, 1, -70), UDim2.new(0, 205, 0, 65), COLORS.CARD, 8)
    
    -- Scrolling Frame for Content
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
        -- Clear existing content
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
            aimbotHeader.Text = "⚔️ AIMBOT"
            aimbotHeader.TextColor3 = COLORS.PRIMARY
            aimbotHeader.TextSize = 16
            aimbotHeader.Font = Enum.Font.GothamBold
            aimbotHeader.TextXAlignment = Enum.TextXAlignment.Left
            aimbotHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Aimbot Enabled", false, function(state)
                createNotification("Aimbot", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createSlider(scrollFrame, UDim2.new(0, 0, 0, yPos), "FOV Size", 50, 500, 120, function(value)
                -- FOV logic here
            end)
            yPos = yPos + 55
            
            createSlider(scrollFrame, UDim2.new(0, 0, 0, yPos), "Smoothness", 1, 20, 5, function(value)
                -- Smoothness logic here
            end)
            yPos = yPos + 55
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Silent Aim", false, function(state)
                createNotification("Silent Aim", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Rage Bot", false, function(state)
                createNotification("Rage Bot", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            -- Combat Section
            local combatHeader = Instance.new("TextLabel")
            combatHeader.Size = UDim2.new(1, 0, 0, 30)
            combatHeader.Position = UDim2.new(0, 0, 0, yPos)
            combatHeader.BackgroundTransparency = 1
            combatHeader.Text = "🔫 COMBAT"
            combatHeader.TextColor3 = COLORS.PRIMARY
            combatHeader.TextSize = 16
            combatHeader.Font = Enum.Font.GothamBold
            combatHeader.TextXAlignment = Enum.TextXAlignment.Left
            combatHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Trigger Bot", false, function(state)
                createNotification("Trigger Bot", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Hitbox Expander", false, function(state)
                createNotification("Hitbox Expander", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "One Shot Kill", false, function(state)
                createNotification("One Shot Kill", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "No Recoil", false, function(state)
                createNotification("No Recoil", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Infinite Ammo", false, function(state)
                createNotification("Infinite Ammo", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
        elseif currentTab == "Movement" then
            local movementHeader = Instance.new("TextLabel")
            movementHeader.Size = UDim2.new(1, 0, 0, 30)
            movementHeader.Position = UDim2.new(0, 0, 0, yPos)
            movementHeader.BackgroundTransparency = 1
            movementHeader.Text = "🏃 MOVEMENT"
            movementHeader.TextColor3 = COLORS.PRIMARY
            movementHeader.TextSize = 16
            movementHeader.Font = Enum.Font.GothamBold
            movementHeader.TextXAlignment = Enum.TextXAlignment.Left
            movementHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Bunny Hop", false, function(state)
                createNotification("Bunny Hop", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Speed Hack", false, function(state)
                if state then
                    player.Character.Humanoid.WalkSpeed = 100
                else
                    player.Character.Humanoid.WalkSpeed = 16
                end
                createNotification("Speed Hack", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createSlider(scrollFrame, UDim2.new(0, 0, 0, yPos), "Speed Multiplier", 16, 500, 100, function(value)
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = value
                end
            end)
            yPos = yPos + 55
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fly / Jetpack", false, function(state)
                createNotification("Fly", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "No Clip", false, function(state)
                createNotification("No Clip", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(0, 10, 0, yPos), "Teleport Kill", function()
                createNotification("Teleport Kill", "Feature activated!", "success")
            end)
            yPos = yPos + 40
            
        elseif currentTab == "Visuals" then
            local visualsHeader = Instance.new("TextLabel")
            visualsHeader.Size = UDim2.new(1, 0, 0, 30)
            visualsHeader.Position = UDim2.new(0, 0, 0, yPos)
            visualsHeader.BackgroundTransparency = 1
            visualsHeader.Text = "👁️ VISUALS"
            visualsHeader.TextColor3 = COLORS.PRIMARY
            visualsHeader.TextSize = 16
            visualsHeader.Font = Enum.Font.GothamBold
            visualsHeader.TextXAlignment = Enum.TextXAlignment.Left
            visualsHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Players", false, function(state)
                createNotification("ESP Players", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Weapons", false, function(state)
                createNotification("ESP Weapons", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Chams / Glow", false, function(state)
                createNotification("Chams", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Radar Hack", false, function(state)
                createNotification("Radar Hack", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Full Bright", false, function(state)
                if state then
                    Lighting.Brightness = 2
                    Lighting.ClockTime = 14
                    Lighting.FogEnd = 100000
                else
                    Lighting.Brightness = 1
                    Lighting.ClockTime = 12
                    Lighting.FogEnd = 1000
                end
                createNotification("Full Bright", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
        elseif currentTab == "Roleplay" then
            local rpHeader = Instance.new("TextLabel")
            rpHeader.Size = UDim2.new(1, 0, 0, 30)
            rpHeader.Position = UDim2.new(0, 0, 0, yPos)
            rpHeader.BackgroundTransparency = 1
            rpHeader.Text = "🎭 ROLEPLAY"
            rpHeader.TextColor3 = COLORS.PRIMARY
            rpHeader.TextSize = 16
            rpHeader.Font = Enum.Font.GothamBold
            rpHeader.TextXAlignment = Enum.TextXAlignment.Left
            rpHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createButton(scrollFrame, UDim2.new(0, 10, 0, yPos), "Spawn Car", function()
                createNotification("Spawn Car", "Car spawned!", "success")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Super Speed Car", false, function(state)
                createNotification("Super Speed Car", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fly Car", false, function(state)
                createNotification("Fly Car", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Godmode", false, function(state)
                createNotification("Godmode", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(0, 10, 0, yPos), "Auto Farm Money", function()
                createNotification("Auto Farm", "Money farming started!", "success")
            end)
            yPos = yPos + 40
            
        elseif currentTab == "Blox Fruits" then
            local bfHeader = Instance.new("TextLabel")
            bfHeader.Size = UDim2.new(1, 0, 0, 30)
            bfHeader.Position = UDim2.new(0, 0, 0, yPos)
            bfHeader.BackgroundTransparency = 1
            bfHeader.Text = "🥭 BLOX FRUITS"
            bfHeader.TextColor3 = COLORS.PRIMARY
            bfHeader.TextSize = 16
            bfHeader.Font = Enum.Font.GothamBold
            bfHeader.TextXAlignment = Enum.TextXAlignment.Left
            bfHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Farm Level", false, function(state)
                createNotification("Auto Farm Level", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Farm Boss", false, function(state)
                createNotification("Auto Farm Boss", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Fruits", false, function(state)
                createNotification("ESP Fruits", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(0, 10, 0, yPos), "TP to Sea", function()
                createNotification("Teleport", "Teleported to sea!", "success")
            end)
            yPos = yPos + 40
            
        elseif currentTab == "Player List" then
            local plHeader = Instance.new("TextLabel")
            plHeader.Size = UDim2.new(1, 0, 0, 30)
            plHeader.Position = UDim2.new(0, 0, 0, yPos)
            plHeader.BackgroundTransparency = 1
            plHeader.Text = "📋 PLAYER LIST"
            plHeader.TextColor3 = COLORS.PRIMARY
            plHeader.TextSize = 16
            plHeader.Font = Enum.Font.GothamBold
            plHeader.TextXAlignment = Enum.TextXAlignment.Left
            plHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            -- Player list would go here
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= player then
                    local playerFrame = createFrame(scrollFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 0, 0, yPos), COLORS.SURFACE, 8)
                    
                    local playerLabel = Instance.new("TextLabel")
                    playerLabel.Size = UDim2.new(0.5, 0, 1, 0)
                    playerLabel.Position = UDim2.new(0, 10, 0, 0)
                    playerLabel.BackgroundTransparency = 1
                    playerLabel.Text = targetPlayer.Name
                    playerLabel.TextColor3 = COLORS.TEXT_PRIMARY
                    playerLabel.TextSize = 14
                    playerLabel.Font = Enum.Font.Gotham
                    playerLabel.TextXAlignment = Enum.TextXAlignment.Left
                    playerLabel.Parent = playerFrame
                    
                    local tpBtn = createButton(playerFrame, UDim2.new(0, 60, 0, 25), "TP", function()
                        if player.Character and targetPlayer.Character then
                            player.Character:SetPrimaryPartCFrame(targetPlayer.Character.PrimaryPart.CFrame)
                            createNotification("Teleport", "Teleported to " .. targetPlayer.Name, "success")
                        end
                    end, COLORS.SUCCESS)
                    tpBtn.Position = UDim2.new(1, -130, 0.5, -12.5)
                    
                    local trollBtn = createButton(playerFrame, UDim2.new(0, 60, 0, 25), "Troll", function()
                        createNotification("Troll", "Trolling " .. targetPlayer.Name, "success")
                    end, COLORS.WARNING)
                    trollBtn.Position = UDim2.new(1, -65, 0.5, -12.5)
                    
                    yPos = yPos + 45
                end
            end
            
        elseif currentTab == "Chat" then
            local chatHeader = Instance.new("TextLabel")
            chatHeader.Size = UDim2.new(1, 0, 0, 30)
            chatHeader.Position = UDim2.new(0, 0, 0, yPos)
            chatHeader.BackgroundTransparency = 1
            chatHeader.Text = "💬 CHAT"
            chatHeader.TextColor3 = COLORS.PRIMARY
            chatHeader.TextSize = 16
            chatHeader.Font = Enum.Font.GothamBold
            chatHeader.TextXAlignment = Enum.TextXAlignment.Left
            chatHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Chat Spam", false, function(state)
                createNotification("Chat Spam", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Reply", false, function(state)
                createNotification("Auto Reply", state and "Enabled" or "Disabled", state and "success" or "error")
            end)
            yPos = yPos + 40
            
            createButton(scrollFrame, UDim2.new(0, 10, 0, yPos), "Send Quick Message", function()
                createNotification("Chat", "Quick message sent!", "success")
            end)
            yPos = yPos + 40
        end
        
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)
    end
    
    -- Initialize first tab
    updateTabContent()
    
    -- Make draggable
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
createNotification("🔥 SPWARE Loaded", "Press INSERT to open menu!", "success")
createMainUI()
