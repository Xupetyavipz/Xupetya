-- Professional Roblox Cheat UI - SPWARE
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
    BACKGROUND = Color3.fromRGB(15, 15, 15),
    SURFACE = Color3.fromRGB(25, 25, 25),
    CARD = Color3.fromRGB(30, 30, 30),
    PRIMARY = Color3.fromRGB(147, 51, 234),
    SECONDARY = Color3.fromRGB(168, 85, 247),
    ACCENT = Color3.fromRGB(196, 181, 253),
    TEXT = Color3.fromRGB(255, 255, 255),
    TEXT_SECONDARY = Color3.fromRGB(156, 163, 175),
    SUCCESS = Color3.fromRGB(34, 197, 94),
    WARNING = Color3.fromRGB(251, 191, 36),
    ERROR = Color3.fromRGB(239, 68, 68),
    BORDER = Color3.fromRGB(55, 65, 81),
}

-- Notification System
local function createNotification(title, message, type)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = message,
        Duration = 3
    })
end

-- UI Components
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
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.SECONDARY}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.PRIMARY}):Play()
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
    
    local toggleButton = createFrame(toggleFrame, UDim2.new(0, 40, 0, 20), UDim2.new(1, -50, 0.5, -10), COLORS.BORDER, 10)
    
    local toggleCircle = createFrame(toggleButton, UDim2.new(0, 16, 0, 16), UDim2.new(0, 2, 0, 2), COLORS.TEXT_SECONDARY, 8)
    
    local isToggled = false
    toggleStates[text] = false
    
    local clickButton = Instance.new("TextButton")
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.BackgroundTransparency = 1
    clickButton.Text = ""
    clickButton.Parent = toggleFrame
    
    clickButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        toggleStates[text] = isToggled
        
        if isToggled then
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.PRIMARY}):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0, 2), BackgroundColor3 = COLORS.TEXT}):Play()
        else
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.BORDER}):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = COLORS.TEXT_SECONDARY}):Play()
        end
        
        if callback then
            callback(isToggled)
        end
    end)
    
    return toggleFrame
end

local function createSlider(parent, position, text, minVal, maxVal, defaultVal, callback)
    local sliderFrame = createFrame(parent, UDim2.new(1, -20, 0, 60), position, COLORS.CARD, 6)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. defaultVal
    label.TextColor3 = COLORS.TEXT
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    local sliderTrack = createFrame(sliderFrame, UDim2.new(1, -20, 0, 6), UDim2.new(0, 10, 0, 35), COLORS.BORDER, 3)
    local sliderFill = createFrame(sliderTrack, UDim2.new(0.5, 0, 1, 0), UDim2.new(0, 0, 0, 0), COLORS.PRIMARY, 3)
    local sliderHandle = createFrame(sliderTrack, UDim2.new(0, 16, 0, 16), UDim2.new(0.5, -8, 0.5, -8), COLORS.TEXT, 8)
    
    sliderValues[text] = defaultVal
    
    local dragging = false
    
    sliderHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local trackPos = sliderTrack.AbsolutePosition.X
            local trackSize = sliderTrack.AbsoluteSize.X
            local relativePos = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
            
            local value = math.floor(minVal + (maxVal - minVal) * relativePos)
            sliderValues[text] = value
            label.Text = text .. ": " .. value
            
            sliderFill.Size = UDim2.new(relativePos, 0, 1, 0)
            sliderHandle.Position = UDim2.new(relativePos, -8, 0.5, -8)
            
            if callback then
                callback(value)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return sliderFrame
end

-- Tab Configuration
local TABS = {
    {name = "Combat", icon = "⚔️"},
    {name = "Movement", icon = "🏃"},
    {name = "Visuals", icon = "👁️"},
    {name = "Roleplay", icon = "🎭"},
    {name = "Blox Fruits", icon = "🍎"},
    {name = "Player List", icon = "👥"},
    {name = "Chat", icon = "💬"}
}

-- Main UI Creation
local function createMainUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SPWARECheatUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Main Container
    mainFrame = createFrame(screenGui, UDim2.new(0, 900, 0, 600), UDim2.new(0.5, -450, 0.5, -300), COLORS.BACKGROUND, 12)
    
    -- Header
    local header = createFrame(mainFrame, UDim2.new(1, 0, 0, 60), UDim2.new(0, 0, 0, 0), COLORS.SURFACE, 0)
    
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
    
    -- SPWARE Logo
    local logoImage = Instance.new("ImageLabel")
    logoImage.Size = UDim2.new(0, 30, 0, 30)
    logoImage.Position = UDim2.new(0, 65, 0, 15)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = "rbxassetid://70651953090646"
    logoImage.Parent = header
    
    -- SPWARE Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 150, 0, 25)
    title.Position = UDim2.new(0, 105, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "SPWARE"
    title.TextColor3 = COLORS.ACCENT
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- User Name
    local userName = Instance.new("TextLabel")
    userName.Size = UDim2.new(0, 150, 0, 15)
    userName.Position = UDim2.new(0, 105, 0, 35)
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
        
        local tabIcon = Instance.new("TextLabel")
        tabIcon.Size = UDim2.new(0, 30, 1, 0)
        tabIcon.Position = UDim2.new(0, 10, 0, 0)
        tabIcon.BackgroundTransparency = 1
        tabIcon.Text = tab.icon
        tabIcon.TextColor3 = currentTab == tab.name and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
        tabIcon.TextSize = 16
        tabIcon.Font = Enum.Font.Gotham
        tabIcon.Parent = tabBtn
        
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
            for j, btn in pairs(tabButtons) do
                local btnIcon = btn:FindFirstChild("TextLabel")
                local btnLabel = btn:GetChildren()[2]
                if btnIcon then
                    btnIcon.TextColor3 = j == i and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
                end
                if btnLabel then
                    btnLabel.TextColor3 = j == i and COLORS.PRIMARY or COLORS.TEXT_SECONDARY
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
            -- Aimbot Section
            local aimbotHeader = Instance.new("TextLabel")
            aimbotHeader.Size = UDim2.new(1, 0, 0, 30)
            aimbotHeader.Position = UDim2.new(0, 0, 0, yPos)
            aimbotHeader.BackgroundTransparency = 1
            aimbotHeader.Text = "🎯 AIMBOT"
            aimbotHeader.TextColor3 = COLORS.ACCENT
            aimbotHeader.TextSize = 16
            aimbotHeader.Font = Enum.Font.GothamBold
            aimbotHeader.TextXAlignment = Enum.TextXAlignment.Left
            aimbotHeader.Parent = scrollFrame
            yPos = yPos + 35
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Aimbot", function(state)
                createNotification("Aimbot", state and "Ativado" or "Desativado", "success")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Silent Aim", function(state)
                createNotification("Silent Aim", state and "Ativado" or "Desativado", "success")
            end)
            yPos = yPos + 45
            
            createSlider(scrollFrame, UDim2.new(0, 0, 0, yPos), "FOV", 10, 360, 90, function(value)
                createNotification("FOV", "Definido para " .. value, "success")
            end)
            yPos = yPos + 65
            
        elseif currentTab == "Movement" then
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Super Speed", function(state)
                if state then
                    player.Character.Humanoid.WalkSpeed = 100
                else
                    player.Character.Humanoid.WalkSpeed = 16
                end
                createNotification("Speed", state and "Ativado" or "Desativado", "success")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Super Jump", function(state)
                if state then
                    player.Character.Humanoid.JumpPower = 100
                else
                    player.Character.Humanoid.JumpPower = 50
                end
                createNotification("Jump", state and "Ativado" or "Desativado", "success")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fly", function(state)
                createNotification("Fly", state and "Ativado" or "Desativado", "success")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Visuals" then
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
                createNotification("Fullbright", state and "Ativado" or "Desativado", "success")
            end)
            yPos = yPos + 45
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP Players", function(state)
                createNotification("ESP", state and "Ativado" or "Desativado", "success")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Roleplay" then
            createButton(scrollFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 0, 0, yPos), "🎭 Animations", function()
                createNotification("Roleplay", "Menu de animações aberto!", "success")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Blox Fruits" then
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Auto Farm", function(state)
                createNotification("Auto Farm", state and "Ativado" or "Desativado", "success")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Player List" then
            createButton(scrollFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 0, 0, yPos), "👥 Refresh Players", function()
                createNotification("Players", "Lista atualizada!", "success")
            end)
            yPos = yPos + 45
            
        elseif currentTab == "Chat" then
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Chat Spam", function(state)
                createNotification("Chat", state and "Ativado" or "Desativado", "success")
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
createNotification("🔥 SPWARE Loaded", "Press INSERT to open menu!", "success")
createMainUI()
