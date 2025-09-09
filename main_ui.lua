-- SPWARE V2 - Advanced Roblox Cheat Menu
-- Modern Design with Full Functionality

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
    if playerGui:FindFirstChild("SPWARE_V2") then
        playerGui:FindFirstChild("SPWARE_V2"):Destroy()
    end
end)

-- Variables
local mainFrame = nil
local currentTab = "Combat"
local isVisible = true

-- Colors
local COLORS = {
    BACKGROUND = Color3.fromRGB(15, 15, 20),
    SURFACE = Color3.fromRGB(25, 25, 35),
    PRIMARY = Color3.fromRGB(138, 43, 226),
    ACCENT = Color3.fromRGB(186, 85, 211),
    SUCCESS = Color3.fromRGB(46, 204, 113),
    ERROR = Color3.fromRGB(231, 76, 60),
    TEXT = Color3.fromRGB(255, 255, 255),
    TEXT_DIM = Color3.fromRGB(170, 170, 170),
    BORDER = Color3.fromRGB(45, 45, 55)
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

-- Notification System
local function notify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
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

-- UI Creation
local function createUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SPWARE_V2"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Main Frame
    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = COLORS.BACKGROUND
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundColor3 = COLORS.PRIMARY
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header
    
    local headerBottom = Instance.new("Frame")
    headerBottom.Size = UDim2.new(1, 0, 0, 12)
    headerBottom.Position = UDim2.new(0, 0, 1, -12)
    headerBottom.BackgroundColor3 = COLORS.PRIMARY
    headerBottom.BorderSizePixel = 0
    headerBottom.Parent = header
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🔥 SPWARE V2"
    title.TextColor3 = COLORS.TEXT
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- Tabs
    local tabsFrame = Instance.new("Frame")
    tabsFrame.Name = "TabsFrame"
    tabsFrame.Size = UDim2.new(0, 150, 1, -50)
    tabsFrame.Position = UDim2.new(0, 0, 0, 50)
    tabsFrame.BackgroundColor3 = COLORS.SURFACE
    tabsFrame.BorderSizePixel = 0
    tabsFrame.Parent = mainFrame
    
    local tabsCorner = Instance.new("UICorner")
    tabsCorner.CornerRadius = UDim.new(0, 8)
    tabsCorner.Parent = tabsFrame
    
    -- Content
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -160, 1, -60)
    contentFrame.Position = UDim2.new(0, 160, 0, 60)
    contentFrame.BackgroundColor3 = COLORS.SURFACE
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = mainFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = contentFrame
    
    -- Scroll Frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -20)
    scrollFrame.Position = UDim2.new(0, 10, 0, 10)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.ScrollBarImageColor3 = COLORS.PRIMARY
    scrollFrame.Parent = contentFrame
    
    -- Tab Buttons
    local tabs = {"Combat", "Movement", "Visual", "Player", "Misc"}
    local tabButtons = {}
    
    for i, tabName in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, -10, 0, 40)
        tabButton.Position = UDim2.new(0, 5, 0, (i-1) * 45 + 10)
        tabButton.BackgroundColor3 = currentTab == tabName and COLORS.PRIMARY or COLORS.BORDER
        tabButton.Text = tabName
        tabButton.TextColor3 = COLORS.TEXT
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.GothamBold
        tabButton.BorderSizePixel = 0
        tabButton.Parent = tabsFrame
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tabButton
        
        tabButton.MouseButton1Click:Connect(function()
            currentTab = tabName
            for j, btn in ipairs(tabButtons) do
                btn.BackgroundColor3 = j == i and COLORS.PRIMARY or COLORS.BORDER
            end
            updateContent()
        end)
        
        tabButtons[i] = tabButton
    end
    
    -- Toggle Function
    local function createToggle(parent, position, text, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, -20, 0, 40)
        toggleFrame.Position = position
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
            callback(isToggled)
        end)
        
        return toggleFrame
    end
    
    -- Slider Function
    local function createSlider(parent, position, text, min, max, default, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, -20, 0, 50)
        sliderFrame.Position = position
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
        sliderButton.BackgroundColor3 = COLORS.TEXT
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
                
                callback(value)
            end
        end)
        
        return sliderFrame
    end
    
    -- Update Content Function
    function updateContent()
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        local yPos = 0
        
        if currentTab == "Combat" then
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Aimbot", function(state)
                cheats.aimbot = state
                notify("Aimbot", state and "Enabled" or "Disabled")
            end)
            yPos = yPos + 50
            
        elseif currentTab == "Movement" then
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fly", function(state)
                cheats.fly = state
                toggleFly()
                notify("Fly", state and "Enabled" or "Disabled")
            end)
            yPos = yPos + 50
            
            createSlider(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fly Speed", 10, 100, 50, function(value)
                cheats.flySpeed = value
            end)
            yPos = yPos + 60
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Noclip", function(state)
                cheats.noclip = state
                toggleNoclip()
                notify("Noclip", state and "Enabled" or "Disabled")
            end)
            yPos = yPos + 50
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Speed", function(state)
                cheats.speed = state
                updateWalkSpeed()
                notify("Speed", state and "Enabled" or "Disabled")
            end)
            yPos = yPos + 50
            
            createSlider(scrollFrame, UDim2.new(0, 0, 0, yPos), "Walk Speed", 16, 100, 16, function(value)
                cheats.walkSpeed = value
                updateWalkSpeed()
            end)
            yPos = yPos + 60
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Infinite Jump", function(state)
                cheats.infiniteJump = state
                updateJumpPower()
                notify("Infinite Jump", state and "Enabled" or "Disabled")
            end)
            yPos = yPos + 50
            
            createSlider(scrollFrame, UDim2.new(0, 0, 0, yPos), "Jump Power", 50, 200, 50, function(value)
                cheats.jumpPower = value
                updateJumpPower()
            end)
            yPos = yPos + 60
            
        elseif currentTab == "Visual" then
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "ESP", function(state)
                cheats.esp = state
                toggleESP()
                notify("ESP", state and "Enabled" or "Disabled")
            end)
            yPos = yPos + 50
            
            createToggle(scrollFrame, UDim2.new(0, 0, 0, yPos), "Fullbright", function(state)
                cheats.fullbright = state
                toggleFullbright()
                notify("Fullbright", state and "Enabled" or "Disabled")
            end)
            yPos = yPos + 50
            
        elseif currentTab == "Player" then
            local playerLabel = Instance.new("TextLabel")
            playerLabel.Size = UDim2.new(1, -20, 0, 30)
            playerLabel.Position = UDim2.new(0, 0, 0, yPos)
            playerLabel.BackgroundTransparency = 1
            playerLabel.Text = "Player: " .. player.Name
            playerLabel.TextColor3 = COLORS.TEXT
            playerLabel.TextSize = 16
            playerLabel.Font = Enum.Font.GothamBold
            playerLabel.TextXAlignment = Enum.TextXAlignment.Left
            playerLabel.Parent = scrollFrame
            yPos = yPos + 40
            
        elseif currentTab == "Misc" then
            local miscLabel = Instance.new("TextLabel")
            miscLabel.Size = UDim2.new(1, -20, 0, 30)
            miscLabel.Position = UDim2.new(0, 0, 0, yPos)
            miscLabel.BackgroundTransparency = 1
            miscLabel.Text = "Miscellaneous Features"
            miscLabel.TextColor3 = COLORS.TEXT
            miscLabel.TextSize = 16
            miscLabel.Font = Enum.Font.GothamBold
            miscLabel.TextXAlignment = Enum.TextXAlignment.Left
            miscLabel.Parent = scrollFrame
            yPos = yPos + 40
        end
        
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)
    end
    
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
    
    updateContent()
end

-- Toggle UI
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        if mainFrame then
            isVisible = not isVisible
            mainFrame.Visible = isVisible
        end
    end
end)

-- Player events
Players.PlayerAdded:Connect(function(newPlayer)
    if cheats.esp then
        wait(1)
        createESP(newPlayer)
    end
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if espObjects[leavingPlayer] then
        removeESP(leavingPlayer)
    end
end)

-- Initialize
createUI()
notify("SPWARE V2", "Loaded! Press INSERT to toggle")
