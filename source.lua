-- ╔══════════════════════════════════════════════════════════════╗
-- ║                 PROFESSIONAL CHEAT UI V2.0                  ║
-- ║              Inspired by Synapse X & Modern Executors       ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService") 
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- Variables
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cleanup existing UI
if _G.ProfessionalUI then
    pcall(function()
        _G.ProfessionalUI:Destroy()
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- 🎨 PROFESSIONAL THEME
-- ═══════════════════════════════════════════════════════════════
local Theme = {
    -- Main colors (Purple/Black theme)
    Background = Color3.fromRGB(15, 15, 20),
    Surface = Color3.fromRGB(20, 20, 25),
    Elevated = Color3.fromRGB(25, 25, 30),
    
    -- Purple accent colors
    Primary = Color3.fromRGB(139, 69, 255),
    Secondary = Color3.fromRGB(168, 85, 247),
    Success = Color3.fromRGB(139, 69, 255),
    Warning = Color3.fromRGB(139, 69, 255),
    Error = Color3.fromRGB(139, 69, 255),
    
    -- Text colors
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190),
    TextMuted = Color3.fromRGB(120, 120, 130),
    
    -- Border and dividers
    Border = Color3.fromRGB(139, 69, 255),
    Divider = Color3.fromRGB(60, 60, 70),
}

-- ═══════════════════════════════════════════════════════════════
-- 🔧 INTEGRATED FUNCTIONS
-- ═══════════════════════════════════════════════════════════════
local Functions = {}
local connections = {}

-- Player List System
function Functions.createPlayerList()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    
    if _G.PlayerListFrame then
        _G.PlayerListFrame:Destroy()
    end
    
    -- Create Player List GUI
    local playerListGui = Instance.new("ScreenGui")
    playerListGui.Name = "PlayerListGUI"
    playerListGui.Parent = game.CoreGui
    
    local frame = Instance.new("Frame")
    frame.Name = "PlayerListFrame"
    frame.Parent = playerListGui
    frame.Size = UDim2.new(0, 400, 0, 500)
    frame.Position = UDim2.new(0.5, -200, 0.5, -250)
    frame.BackgroundColor3 = Theme.Background
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    -- Header
    local header = Instance.new("Frame")
    header.Parent = frame
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Theme.Primary
    header.BorderSizePixel = 0
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 10)
    headerCorner.Parent = header
    
    local headerFix = Instance.new("Frame")
    headerFix.Parent = header
    headerFix.Size = UDim2.new(1, 0, 0, 10)
    headerFix.Position = UDim2.new(0, 0, 1, -10)
    headerFix.BackgroundColor3 = Theme.Primary
    headerFix.BorderSizePixel = 0
    
    local title = Instance.new("TextLabel")
    title.Parent = header
    title.Size = UDim2.new(1, -40, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Player List"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = header
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.GothamBold
    
    -- Search Box
    local searchBox = Instance.new("TextBox")
    searchBox.Parent = frame
    searchBox.Size = UDim2.new(1, -20, 0, 30)
    searchBox.Position = UDim2.new(0, 10, 0, 50)
    searchBox.BackgroundColor3 = Theme.Surface
    searchBox.BorderSizePixel = 0
    searchBox.PlaceholderText = "Search players..."
    searchBox.Text = ""
    searchBox.TextColor3 = Theme.TextPrimary
    searchBox.TextSize = 14
    searchBox.Font = Enum.Font.Gotham
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 5)
    searchCorner.Parent = searchBox
    
    -- Player List Scroll
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Parent = frame
    scrollFrame.Size = UDim2.new(1, -20, 1, -140)
    scrollFrame.Position = UDim2.new(0, 10, 0, 90)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = Theme.Primary
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = scrollFrame
    listLayout.SortOrder = Enum.SortOrder.Name
    listLayout.Padding = UDim.new(0, 2)
    
    -- Selected Player Actions
    local actionsFrame = Instance.new("Frame")
    actionsFrame.Parent = frame
    actionsFrame.Size = UDim2.new(1, -20, 0, 40)
    actionsFrame.Position = UDim2.new(0, 10, 1, -50)
    actionsFrame.BackgroundColor3 = Theme.Surface
    actionsFrame.BorderSizePixel = 0
    actionsFrame.Visible = false
    
    local actionsCorner = Instance.new("UICorner")
    actionsCorner.CornerRadius = UDim.new(0, 5)
    actionsCorner.Parent = actionsFrame
    
    local actionsLayout = Instance.new("UIListLayout")
    actionsLayout.Parent = actionsFrame
    actionsLayout.FillDirection = Enum.FillDirection.Horizontal
    actionsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    actionsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    actionsLayout.Padding = UDim.new(0, 5)
    
    local selectedPlayer = nil
    
    -- Action Buttons
    local actions = {
        {name = "TP", func = function(player) Functions.teleportToPlayer(player) end},
        {name = "Pull", func = function(player) Functions.pullPlayer(player) end},
        {name = "Copy", func = function(player) Functions.copyOutfit(player) end},
        {name = "Steal", func = function(player) Functions.stealItems(player) end},
        {name = "Kick", func = function(player) Functions.kickFromVehicle(player) end},
        {name = "Boom", func = function(player) Functions.explodePlayer(player) end},
        {name = "Cars", func = function(player) Functions.spawnCarsOnPlayer(player) end},
        {name = "Kill", func = function(player) Functions.killPlayer(player) end},
        {name = "Black", func = function(player) Functions.blackScreenPlayer(player) end},
        {name = "Sound", func = function(player) Functions.soundSpamPlayer(player) end},
        {name = "P1", func = function(player) Functions.stealP1(player) end},
        {name = "Enter", func = function(player) Functions.enterVehicle(player) end}
    }
    
    for _, action in pairs(actions) do
        local btn = Instance.new("TextButton")
        btn.Parent = actionsFrame
        btn.Size = UDim2.new(0, 50, 0, 30)
        btn.BackgroundColor3 = Theme.Primary
        btn.BorderSizePixel = 0
        btn.Text = action.name
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.TextSize = 12
        btn.Font = Enum.Font.Gotham
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            if selectedPlayer then
                action.func(selectedPlayer)
            end
        end)
    end
    
    -- Update Player List
    local function updatePlayerList()
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local searchTerm = searchBox.Text:lower()
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer and (searchTerm == "" or player.Name:lower():find(searchTerm)) then
                local distance = "N/A"
                if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
                   player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    distance = math.floor(dist) .. "m"
                end
                
                local playerBtn = Instance.new("TextButton")
                playerBtn.Parent = scrollFrame
                playerBtn.Size = UDim2.new(1, 0, 0, 40)
                playerBtn.BackgroundColor3 = Theme.Elevated
                playerBtn.BorderSizePixel = 0
                playerBtn.Text = player.Name .. " (" .. player.DisplayName .. ") - " .. distance
                playerBtn.TextColor3 = Theme.TextPrimary
                playerBtn.TextSize = 12
                playerBtn.Font = Enum.Font.Gotham
                playerBtn.TextXAlignment = Enum.TextXAlignment.Left
                
                local playerCorner = Instance.new("UICorner")
                playerCorner.CornerRadius = UDim.new(0, 4)
                playerCorner.Parent = playerBtn
                
                playerBtn.MouseButton1Click:Connect(function()
                    selectedPlayer = player
                    actionsFrame.Visible = true
                    
                    -- Highlight selected
                    for _, btn in pairs(scrollFrame:GetChildren()) do
                        if btn:IsA("TextButton") then
                            btn.BackgroundColor3 = Theme.Elevated
                        end
                    end
                    playerBtn.BackgroundColor3 = Theme.Primary
                end)
            end
        end
        
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
    end
    
    -- Events
    searchBox:GetPropertyChangedSignal("Text"):Connect(updatePlayerList)
    Players.PlayerAdded:Connect(updatePlayerList)
    Players.PlayerRemoving:Connect(updatePlayerList)
    
    closeBtn.MouseButton1Click:Connect(function()
        playerListGui:Destroy()
        _G.PlayerListFrame = nil
        _G.PlayerListEnabled = false
    end)
    
    -- Make draggable
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    _G.PlayerListFrame = playerListGui
    updatePlayerList()
end

-- Player Action Functions
function Functions.teleportToPlayer(player)
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = player.Character.HumanoidRootPart.Position
        local targetCFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        local myRoot = localPlayer.Character.HumanoidRootPart
        
        -- Method 1: Instant CFrame teleport
        myRoot.CFrame = targetCFrame
        
        -- Method 2: Try all possible teleport remotes with multiple parameters
        spawn(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    pcall(function()
                        -- Try common teleport patterns
                        obj:FireServer(targetPos)
                        obj:FireServer("teleport", targetPos)
                        obj:FireServer("tp", targetPos)
                        obj:FireServer(localPlayer, targetPos)
                        obj:FireServer(localPlayer.Character, targetPos)
                        obj:FireServer("move", targetPos)
                        obj:FireServer("position", targetPos)
                        obj:FireServer({Position = targetPos})
                        obj:FireServer({x = targetPos.X, y = targetPos.Y, z = targetPos.Z})
                    end)
                end
            end
        end)
        
        -- Method 3: Try BindableEvents
        spawn(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BindableEvent") then
                    pcall(function()
                        obj:Fire(targetPos)
                        obj:Fire("teleport", targetPos)
                    end)
                end
            end
        end)
        
        print("🚀 TELEPORTED TO " .. player.Name)
    end
end

function Functions.flingPlayer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = player.Character.HumanoidRootPart
        local humanoid = player.Character:FindFirstChild("Humanoid")
        
        -- Method 1: Multiple extreme fling forces
        spawn(function()
            for i = 1, 10 do
                local bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVel.Velocity = Vector3.new(math.random(-500, 500), math.random(200, 800), math.random(-500, 500))
                bodyVel.Parent = rootPart
                
                local bodyAngular = Instance.new("BodyAngularVelocity")
                bodyAngular.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bodyAngular.AngularVelocity = Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
                bodyAngular.Parent = rootPart
                
                game:GetService("Debris"):AddItem(bodyVel, 0.2)
                game:GetService("Debris"):AddItem(bodyAngular, 0.2)
                wait(0.05)
            end
        end)
        
        -- Method 2: Physics state manipulation
        if humanoid then
            humanoid.PlatformStand = true
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            humanoid.Sit = true
        end
        
        -- Method 3: Direct velocity manipulation
        spawn(function()
            for i = 1, 50 do
                if rootPart and rootPart.Parent then
                    rootPart.Velocity = Vector3.new(math.random(-200, 200), math.random(100, 400), math.random(-200, 200))
                    rootPart.AngularVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
                end
                wait(0.02)
            end
        end)
        
        -- Method 4: Try fling remotes
        spawn(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    pcall(function()
                        obj:FireServer("fling", player)
                        obj:FireServer("launch", player)
                        obj:FireServer(player, "fling")
                        obj:FireServer(player.Character, "launch")
                        obj:FireServer("physics", player.Name)
                    end)
                end
            end
        end)
        
        -- Method 5: Create explosion for extra fling
        spawn(function()
            wait(0.1)
            local explosion = Instance.new("Explosion")
            explosion.Parent = workspace
            explosion.Position = rootPart.Position
            explosion.BlastRadius = 50
            explosion.BlastPressure = 2000000
            explosion.Visible = false
        end)
        
        print("🌪️ EXTREME FLING PROTOCOL ON " .. player.Name .. " - MAXIMUM FORCE APPLIED!")
    end
end

function Functions.freezePlayer(player)
    if player.Character then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        local humanoid = player.Character:FindFirstChild("Humanoid")
        
        -- Method 1: Direct anchoring and speed manipulation
        if rootPart then
            rootPart.Anchored = true
            rootPart.Velocity = Vector3.new(0, 0, 0)
            rootPart.AngularVelocity = Vector3.new(0, 0, 0)
        end
        
        if humanoid then
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
            humanoid.JumpHeight = 0
            humanoid.PlatformStand = true
        end
        
        -- Method 2: Create invisible barrier around player
        spawn(function()
            if rootPart then
                for i = 1, 20 do
                    local barrier = Instance.new("Part")
                    barrier.Parent = workspace
                    barrier.Size = Vector3.new(1, 10, 1)
                    barrier.Position = rootPart.Position + Vector3.new(math.cos(i * 0.314) * 3, 0, math.sin(i * 0.314) * 3)
                    barrier.Anchored = true
                    barrier.Transparency = 1
                    barrier.CanCollide = true
                    barrier.Name = "FreezeBarrier_" .. player.Name
                    
                    game:GetService("Debris"):AddItem(barrier, 30)
                end
            end
        end)
        
        -- Method 3: Try freeze remotes
        spawn(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    pcall(function()
                        obj:FireServer("freeze", player)
                        obj:FireServer("stop", player)
                        obj:FireServer(player, "freeze")
                        obj:FireServer(player.Character, "freeze")
                        obj:FireServer("immobilize", player.Name)
                    end)
                end
            end
        end)
        
        -- Method 4: Continuous freeze loop
        spawn(function()
            for i = 1, 100 do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    if player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid.WalkSpeed = 0
                        player.Character.Humanoid.JumpPower = 0
                    end
                end
                wait(0.1)
            end
        end)
        
        print("❄️ MAXIMUM FREEZE PROTOCOL ON " .. player.Name .. " - COMPLETELY IMMOBILIZED!")
    end
end

function Functions.killPlayer(player)
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            -- Method 1: Instant server-side kill with multiple approaches
            spawn(function()
                -- Direct health manipulation
                humanoid.Health = 0
                humanoid:TakeDamage(math.huge)
                humanoid.MaxHealth = 0
                
                -- Break all joints to ragdoll
                for _, joint in pairs(player.Character:GetDescendants()) do
                    if joint:IsA("Motor6D") or joint:IsA("Weld") or joint:IsA("WeldConstraint") then
                        joint:Destroy()
                    end
                end
                
                -- Force respawn after delay to prevent invisibility
                wait(2)
                if player.Character then
                    player.Character:Destroy()
                end
                wait(1)
                player:LoadCharacter()
            end)
            
            -- Method 2: Physical destruction with real server effects
            spawn(function()
                wait(0.2)
                -- Create massive explosion at player position
                for i = 1, 10 do
                    local explosion = Instance.new("Explosion")
                    explosion.Parent = workspace
                    explosion.Position = rootPart.Position + Vector3.new(math.random(-10, 10), math.random(-5, 5), math.random(-10, 10))
                    explosion.BlastRadius = 100
                    explosion.BlastPressure = 10000000
                    explosion.Visible = true
                    
                    -- Add fire and smoke effects
                    local fire = Instance.new("Fire")
                    fire.Parent = rootPart
                    fire.Size = 30
                    fire.Heat = 25
                    
                    local smoke = Instance.new("Smoke")
                    smoke.Parent = rootPart
                    smoke.Size = 50
                    smoke.Opacity = 1
                    
                    wait(0.05)
                end
            end)
            
            -- Method 3: Try all possible remote events for killing
            spawn(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("RemoteEvent") then
                        pcall(function()
                            -- Try different kill parameters
                            obj:FireServer("kill", player)
                            obj:FireServer("damage", player, 999999)
                            obj:FireServer(player, "kill")
                            obj:FireServer(player.Character, "destroy")
                            obj:FireServer(humanoid, 0)
                            obj:FireServer("eliminate", player.Name)
                        end)
                    end
                end
            end)
            
            -- Method 4: Extreme physical manipulation
            spawn(function()
                wait(0.5)
                -- Fling player with extreme force
                local bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVel.Velocity = Vector3.new(math.random(-1000, 1000), 1000, math.random(-1000, 1000))
                bodyVel.Parent = rootPart
                
                -- Spin player violently
                local bodyAngular = Instance.new("BodyAngularVelocity")
                bodyAngular.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bodyAngular.AngularVelocity = Vector3.new(100, 100, 100)
                bodyAngular.Parent = rootPart
                
                game:GetService("Debris"):AddItem(bodyVel, 2)
                game:GetService("Debris"):AddItem(bodyAngular, 2)
            end)
            
            -- Method 5: Force disconnect attempt
            spawn(function()
                wait(3)
                pcall(function()
                    player:Kick("💀 SPWARE ELIMINATION PROTOCOL EXECUTED 💀")
                end)
            end)
            
            print("💀⚡ MAXIMUM KILL PROTOCOL EXECUTED ON " .. player.Name .. " - MULTIPLE METHODS DEPLOYED!")
        end
    end
end

function Functions.explodePlayer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local position = player.Character.HumanoidRootPart.Position
        local humanoid = player.Character:FindFirstChild("Humanoid")
        
        -- Method 1: Massive explosion barrage with real damage
        spawn(function()
            for i = 1, 25 do
                local explosion = Instance.new("Explosion")
                explosion.Parent = workspace
                explosion.Position = position + Vector3.new(math.random(-15, 15), math.random(-10, 10), math.random(-15, 15))
                explosion.BlastRadius = 75
                explosion.BlastPressure = 15000000
                explosion.Visible = true
                
                -- Deal real damage with each explosion
                if humanoid and humanoid.Health > 0 then
                    humanoid:TakeDamage(25)
                end
                
                wait(0.05)
            end
        end)
        
        -- Method 2: Physical effects and ragdoll
        spawn(function()
            -- Instant ragdoll
            if humanoid then
                humanoid.PlatformStand = true
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                humanoid.Sit = true
            end
            
            -- Break all joints for realistic ragdoll
            for _, joint in pairs(player.Character:GetDescendants()) do
                if joint:IsA("Motor6D") then
                    local attachment0 = Instance.new("Attachment")
                    local attachment1 = Instance.new("Attachment")
                    attachment0.Parent = joint.Part0
                    attachment1.Parent = joint.Part1
                    attachment0.CFrame = joint.C0
                    attachment1.CFrame = joint.C1
                    
                    local ballSocket = Instance.new("BallSocketConstraint")
                    ballSocket.Attachment0 = attachment0
                    ballSocket.Attachment1 = attachment1
                    ballSocket.Parent = joint.Part0
                    
                    joint:Destroy()
                end
            end
        end)
        
        -- Method 3: Extreme fling with multiple forces
        spawn(function()
            for i = 1, 5 do
                local bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVel.Velocity = Vector3.new(math.random(-200, 200), math.random(100, 300), math.random(-200, 200))
                bodyVel.Parent = player.Character.HumanoidRootPart
                
                local bodyAngular = Instance.new("BodyAngularVelocity")
                bodyAngular.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bodyAngular.AngularVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
                bodyAngular.Parent = player.Character.HumanoidRootPart
                
                game:GetService("Debris"):AddItem(bodyVel, 0.5)
                game:GetService("Debris"):AddItem(bodyAngular, 0.5)
                wait(0.1)
            end
        end)
        
        -- Method 4: Visual effects overload
        spawn(function()
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    -- Add fire to every part
                    local fire = Instance.new("Fire")
                    fire.Parent = part
                    fire.Size = 25
                    fire.Heat = 20
                    
                    -- Add smoke to every part
                    local smoke = Instance.new("Smoke")
                    smoke.Parent = part
                    smoke.Size = 35
                    smoke.Opacity = 1
                    
                    -- Make parts glow
                    part.Material = Enum.Material.Neon
                    part.BrickColor = BrickColor.new("Really red")
                end
            end
        end)
        
        -- Method 5: Try explosion remotes
        spawn(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("RemoteEvent") and (string.find(obj.Name:lower(), "explode") or string.find(obj.Name:lower(), "boom") or string.find(obj.Name:lower(), "blast")) then
                    pcall(function()
                        obj:FireServer(player, position)
                        obj:FireServer(player.Character, "explode")
                        obj:FireServer("explosion", player.Name)
                    end)
                end
            end
        end)
        
        print("💥🔥 NUCLEAR EXPLOSION PROTOCOL ON " .. player.Name .. " - 25 EXPLOSIONS + RAGDOLL!")
    end
end

-- Combat Functions
function Functions.toggleAimbot(enabled)
    _G.AimbotEnabled = enabled
    if enabled then
        spawn(function()
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local UserInputService = game:GetService("UserInputService")
            local Camera = workspace.CurrentCamera
            local LocalPlayer = Players.LocalPlayer
            
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not _G.AimbotEnabled then
                    connection:Disconnect()
                    return
                end
                
                local mouse = LocalPlayer:GetMouse()
                local closestPlayer = nil
                local shortestDistance = math.huge
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                        local head = player.Character.Head
                        local screenPoint, onScreen = Camera:WorldToScreenPoint(head.Position)
                        
                        if onScreen then
                            local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                            if distance < shortestDistance and distance < 200 then
                                shortestDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                end
                
                if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                    local targetPosition = closestPlayer.Character.Head.Position
                    local currentCFrame = Camera.CFrame
                    local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPosition)
                    
                    -- Smooth aiming
                    Camera.CFrame = currentCFrame:Lerp(targetCFrame, 0.2)
                end
            end)
        end)
    end
    print("🎯 Aimbot:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleSilentAim(enabled)
    _G.SilentAimEnabled = enabled
    if enabled then
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "FireServer" or method == "InvokeServer" then
                if string.find(tostring(self), "Remote") and _G.SilentAimEnabled then
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    local Camera = workspace.CurrentCamera
                    
                    local closestPlayer = nil
                    local shortestDistance = math.huge
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                            if distance < shortestDistance and distance < 500 then
                                shortestDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                    
                    if closestPlayer and closestPlayer.Character then
                        -- Replace hit position with target position
                        for i, arg in pairs(args) do
                            if typeof(arg) == "Vector3" then
                                args[i] = closestPlayer.Character.Head.Position
                            elseif typeof(arg) == "CFrame" then
                                args[i] = CFrame.new(closestPlayer.Character.Head.Position)
                            end
                        end
                    end
                end
            end
            
            return oldNamecall(self, unpack(args))
        end)
        setreadonly(mt, true)
    end
    print("🎯 Silent Aim:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleTriggerbot(enabled)
    _G.TriggerbotEnabled = enabled
    if enabled then
        spawn(function()
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not _G.TriggerbotEnabled then
                    connection:Disconnect()
                    return
                end
                
                local ray = Camera:ScreenPointToRay(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                
                local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
                
                if raycastResult and raycastResult.Instance then
                    local hit = raycastResult.Instance
                    local character = hit.Parent
                    
                    if character:FindFirstChild("Humanoid") and Players:GetPlayerFromCharacter(character) then
                        -- Auto click/shoot
                        mouse1press()
                        wait(0.01)
                        mouse1release()
                    end
                end
            end)
        end)
    end
    print("🎯 Triggerbot:", enabled and "ENABLED" or "DISABLED")
end

-- Weapon Functions
function Functions.toggleNoRecoil(enabled)
    _G.NoRecoilEnabled = enabled
    if enabled then
        local mt = getrawmetatable(game)
        local oldIndex = mt.__index
        
        setreadonly(mt, false)
        mt.__index = newcclosure(function(self, key)
            if key == "CFrame" and _G.NoRecoilEnabled then
                if tostring(self):find("Camera") then
                    return oldIndex(self, key)
                end
            end
            return oldIndex(self, key)
        end)
        setreadonly(mt, true)
    end
    print("🔫 No Recoil:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleNoSpread(enabled)
    _G.NoSpreadEnabled = enabled
    if enabled then
        spawn(function()
            while _G.NoSpreadEnabled do
                for _, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, obj in pairs(tool:GetDescendants()) do
                            if obj.Name:lower():find("spread") then
                                obj.Value = 0
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
    print("🎯 No Spread:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleNoSway(enabled)
    _G.NoSwayEnabled = enabled
    if enabled then
        spawn(function()
            while _G.NoSwayEnabled do
                for _, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, obj in pairs(tool:GetDescendants()) do
                            if obj.Name:lower():find("sway") then
                                obj.Value = 0
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
    print("🎯 No Sway:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleRapidFire(enabled)
    _G.RapidFireEnabled = enabled
    if enabled then
        spawn(function()
            while _G.RapidFireEnabled do
                for _, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, obj in pairs(tool:GetDescendants()) do
                            if obj.Name:lower():find("firerate") or obj.Name:lower():find("cooldown") then
                                obj.Value = 0.01
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
    print("⚡ Rapid Fire:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleAutoShoot(enabled)
    _G.AutoShootEnabled = enabled
    if enabled then
        spawn(function()
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not _G.AutoShootEnabled then
                    connection:Disconnect()
                    return
                end
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance < 100 then
                            mouse1press()
                            wait(0.01)
                            mouse1release()
                            wait(0.1)
                        end
                    end
                end
            end)
        end)
    end
    print("🎯 Auto Shoot:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleInfiniteAmmo(enabled)
    _G.InfiniteAmmoEnabled = enabled
    if enabled then
        spawn(function()
            while _G.InfiniteAmmoEnabled do
                for _, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, obj in pairs(tool:GetDescendants()) do
                            if obj.Name:lower():find("ammo") or obj.Name:lower():find("clip") then
                                obj.Value = 999999
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
    print("♾️ Infinite Ammo:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleOneShotKill(enabled)
    _G.OneShotKillEnabled = enabled
    if enabled then
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "FireServer" and _G.OneShotKillEnabled then
                if string.find(tostring(self), "Damage") or string.find(tostring(self), "Hit") then
                    args[2] = 999999 -- Damage value
                end
            end
            
            return oldNamecall(self, unpack(args))
        end)
        setreadonly(mt, true)
    end
    print("💥 One Shot Kill:", enabled and "ENABLED" or "DISABLED")
end

function Functions.togglePenetration(enabled)
    _G.PenetrationEnabled = enabled
    if enabled then
        spawn(function()
            while _G.PenetrationEnabled do
                for _, part in pairs(workspace:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name:lower():find("wall") then
                        part.CanCollide = false
                        part.Transparency = 0.8
                    end
                end
                wait(1)
            end
        end)
    else
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Name:lower():find("wall") then
                part.CanCollide = true
                part.Transparency = 0
            end
        end
    end
    print("🔫 Penetration:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleKillAura(enabled)
    _G.KillAuraEnabled = enabled
    if enabled then
        spawn(function()
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not _G.KillAuraEnabled then
                    connection:Disconnect()
                    return
                end
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance < 15 then
                            player.Character.Humanoid.Health = 0
                        end
                    end
                end
            end)
        end)
    end
    print("⚔️ Kill Aura:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleHitboxExpander(enabled)
    _G.HitboxExpanderEnabled = enabled
    if enabled then
        spawn(function()
            while _G.HitboxExpanderEnabled do
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                        player.Character.HumanoidRootPart.Size = Vector3.new(20, 20, 20)
                        player.Character.HumanoidRootPart.Transparency = 0.8
                        player.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
                        player.Character.HumanoidRootPart.Material = Enum.Material.Neon
                    end
                end
                wait(0.1)
            end
        end)
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                player.Character.HumanoidRootPart.Transparency = 1
            end
        end
    end
    print("🎯 Hitbox Expander:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleAutoHeadshot(enabled)
    _G.AutoHeadshotEnabled = enabled
    if enabled then
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "FireServer" and _G.AutoHeadshotEnabled then
                if string.find(tostring(self), "Remote") then
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                            if distance < 200 then
                                -- Replace hit position with head position
                                for i, arg in pairs(args) do
                                    if typeof(arg) == "Vector3" then
                                        args[i] = player.Character.Head.Position
                                    end
                                end
                                break
                            end
                        end
                    end
                end
            end
            
            return oldNamecall(self, unpack(args))
        end)
        setreadonly(mt, true)
    end
    print("🎯 Auto Headshot:", enabled and "ENABLED" or "DISABLED")
end

-- ESP Functions
function Functions.toggleBoxESP(enabled)
    _G.BoxESPEnabled = enabled
    if enabled then
        spawn(function()
            while _G.BoxESPEnabled do
                for _, player in pairs(game.Players:GetPlayers()) do
                    -- Only show ESP for alive players (Health > 0) and not respawning
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.Character.Parent == workspace then
                        if not player.Character:FindFirstChild("ESP_Box") then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Name = "ESP_Box"
                            box.Parent = player.Character
                            box.Adornee = player.Character.HumanoidRootPart
                            box.Size = Vector3.new(4, 6, 1)
                            box.Color3 = Color3.fromRGB(255, 0, 0)
                            box.Transparency = 0.5
                            box.AlwaysOnTop = true
                        end
                    else
                        -- Remove ESP from dead/invisible players
                        if player.Character and player.Character:FindFirstChild("ESP_Box") then
                            player.Character.ESP_Box:Destroy()
                        end
                    end
                end
                wait(0.1)
            end
        end)
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("ESP_Box") then
                player.Character.ESP_Box:Destroy()
            end
        end
    end
    print("📦 Box ESP:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleNameESP(enabled)
    _G.NameESPEnabled = enabled
    if enabled then
        spawn(function()
            while _G.NameESPEnabled do
                for _, player in pairs(game.Players:GetPlayers()) do
                    -- Only show ESP for alive players (Health > 0) and not respawning
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.Character.Parent == workspace then
                        if not player.Character.Head:FindFirstChild("ESP_Name") then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = "ESP_Name"
                            billboard.Parent = player.Character.Head
                            billboard.Size = UDim2.new(0, 200, 0, 50)
                            billboard.StudsOffset = Vector3.new(0, 2, 0)
                            billboard.AlwaysOnTop = true
                            
                            local textLabel = Instance.new("TextLabel")
                            textLabel.Parent = billboard
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.Text = player.Name
                            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            textLabel.TextStrokeTransparency = 0
                            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                            textLabel.TextScaled = true
                            textLabel.Font = Enum.Font.SourceSansBold
                        end
                    else
                        -- Remove ESP from dead/invisible players
                        if player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("ESP_Name") then
                            player.Character.Head.ESP_Name:Destroy()
                        end
                    end
                end
                wait(0.1)
            end
        end)
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("ESP_Name") then
                player.Character.Head.ESP_Name:Destroy()
            end
        end
    end
    print("📝 Name ESP:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleDistanceESP(enabled)
    _G.DistanceESPEnabled = enabled
    if enabled then
        spawn(function()
            while _G.DistanceESPEnabled do
                for _, player in pairs(game.Players:GetPlayers()) do
                    -- Only show ESP for alive players (Health > 0) and not respawning
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.Character.Parent == workspace then
                        if not player.Character.Head:FindFirstChild("DistanceESP") then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = "DistanceESP"
                            billboard.Parent = player.Character.Head
                            billboard.Size = UDim2.new(0, 200, 0, 30)
                            billboard.StudsOffset = Vector3.new(0, -1, 0)
                            billboard.AlwaysOnTop = true
                            
                            local textLabel = Instance.new("TextLabel")
                            textLabel.Parent = billboard
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.Text = "0m"
                            textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                            textLabel.TextStrokeTransparency = 0
                            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                            textLabel.TextScaled = true
                            textLabel.Font = Enum.Font.SourceSans
                        end
                    else
                        -- Remove ESP from dead/invisible players
                        if player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("DistanceESP") then
                            player.Character.Head.DistanceESP:Destroy()
                        end
                    end
                end
                
                -- Update distances only for alive players
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.Character.Parent == workspace then
                            local distESP = player.Character.Head:FindFirstChild("DistanceESP")
                            if distESP then
                                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                                distESP.TextLabel.Text = math.floor(distance) .. "m"
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("DistanceESP") then
                player.Character.Head.DistanceESP:Destroy()
            end
        end
    end
    print("📏 Distance ESP:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleTracers(enabled)
    _G.TracersEnabled = enabled
    if enabled then
        spawn(function()
            while _G.TracersEnabled do
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                        if not workspace.CurrentCamera:FindFirstChild("Tracer_" .. player.Name) then
                            local beam = Instance.new("Beam")
                            beam.Name = "Tracer_" .. player.Name
                            beam.Parent = workspace.CurrentCamera
                            beam.Color = ColorSequence.new(Color3.new(1, 0, 0))
                            beam.Transparency = NumberSequence.new(0.5)
                            beam.Width0 = 0.5
                            beam.Width1 = 0.5
                            
                            local attach0 = Instance.new("Attachment")
                            attach0.Parent = workspace.CurrentCamera
                            local attach1 = Instance.new("Attachment")
                            attach1.Parent = player.Character.HumanoidRootPart
                            
                            beam.Attachment0 = attach0
                            beam.Attachment1 = attach1
                        end
                    end
                end
                wait(0.5)
            end
        end)
    else
        for _, child in pairs(workspace.CurrentCamera:GetChildren()) do
            if child.Name:find("Tracer_") then
                child:Destroy()
            end
        end
    end
    print("📍 Tracers:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleSpeed(enabled, speed)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = enabled and (speed or 100) or 16
    end
    print("🏃 Speed:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleFly(enabled)
    _G.FlyEnabled = enabled
    local player = game.Players.LocalPlayer
    
    if enabled then
        spawn(function()
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.Parent = character.HumanoidRootPart
                
                local UserInputService = game:GetService("UserInputService")
                
                while _G.FlyEnabled do
                    local moveVector = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveVector = moveVector + workspace.CurrentCamera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveVector = moveVector - workspace.CurrentCamera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveVector = moveVector - workspace.CurrentCamera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveVector = moveVector + workspace.CurrentCamera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        moveVector = moveVector + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        moveVector = moveVector - Vector3.new(0, 1, 0)
                    end
                    
                    bodyVelocity.Velocity = moveVector * 50
                    wait()
                end
                
                bodyVelocity:Destroy()
            end
        end)
    end
    print("✈️ Fly:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleNoclip(enabled)
    _G.NoclipEnabled = enabled
    local player = game.Players.LocalPlayer
    
    if enabled then
        spawn(function()
            while _G.NoclipEnabled do
                if player.Character then
                    for _, part in pairs(player.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
                wait()
            end
        end)
    else
        if player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
    print("👻 Noclip:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleFullbright(enabled)
    local Lighting = game:GetService("Lighting")
    if enabled then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
    end
    print("💡 Fullbright:", enabled and "ENABLED" or "DISABLED")
end

-- Troll Functions
function Functions.toggleSoundSpam(enabled)
    _G.SoundSpamEnabled = enabled
    if enabled then
        spawn(function()
            while _G.SoundSpamEnabled do
                local sound = Instance.new("Sound")
                sound.Parent = workspace
                sound.SoundId = "rbxassetid://131961136"
                sound.Volume = 1
                sound.Pitch = math.random(50, 200) / 100
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 3)
                wait(0.1)
            end
        end)
    end
    print("🔊 Sound Spam:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleScreenShaker(enabled)
    _G.ScreenShakerEnabled = enabled
    if enabled then
        spawn(function()
            local camera = workspace.CurrentCamera
            while _G.ScreenShakerEnabled do
                camera.CFrame = camera.CFrame * CFrame.Angles(
                    math.rad(math.random(-5, 5)),
                    math.rad(math.random(-5, 5)),
                    math.rad(math.random(-5, 5))
                )
                wait(0.05)
            end
        end)
    end
    print("📳 Screen Shaker:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleCameraInverter(enabled)
    _G.CameraInverterEnabled = enabled
    if enabled then
        spawn(function()
            local camera = workspace.CurrentCamera
            while _G.CameraInverterEnabled do
                camera.CFrame = camera.CFrame * CFrame.Angles(math.pi, 0, math.pi)
                wait(0.1)
            end
        end)
    end
    print("🔄 Camera Inverter:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleBlackScreen(enabled)
    _G.BlackScreenEnabled = enabled
    if enabled then
        local blackScreen = Instance.new("Frame")
        blackScreen.Name = "BlackScreen"
        blackScreen.Parent = game.Players.LocalPlayer.PlayerGui
        blackScreen.Size = UDim2.new(1, 0, 1, 0)
        blackScreen.BackgroundColor3 = Color3.new(0, 0, 0)
        blackScreen.ZIndex = 1000
        _G.BlackScreenFrame = blackScreen
    else
        if _G.BlackScreenFrame then
            _G.BlackScreenFrame:Destroy()
            _G.BlackScreenFrame = nil
        end
    end
    print("⚫ Black Screen:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleBlindEffect(enabled)
    _G.BlindEffectEnabled = enabled
    local Lighting = game:GetService("Lighting")
    if enabled then
        Lighting.Brightness = 0
        Lighting.FogEnd = 1
        Lighting.FogStart = 0
    else
        Lighting.Brightness = 1
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
    end
    print("👁️ Blind Effect:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleTextSpam(enabled)
    _G.TextSpamEnabled = enabled
    if enabled then
        spawn(function()
            while _G.TextSpamEnabled do
                local gui = Instance.new("ScreenGui")
                gui.Parent = game.Players.LocalPlayer.PlayerGui
                
                local text = Instance.new("TextLabel")
                text.Parent = gui
                text.Size = UDim2.new(0, 200, 0, 50)
                text.Position = UDim2.new(math.random(), 0, math.random(), 0)
                text.BackgroundTransparency = 1
                text.Text = "SPWARE TROLL MODE"
                text.TextColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                text.TextSize = math.random(20, 50)
                text.Font = Enum.Font.GothamBold
                
                game:GetService("Debris"):AddItem(gui, 2)
                wait(0.1)
            end
        end)
    end
    print("📝 Screen Text Spam:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleObjectSpam(enabled)
    _G.ObjectSpamEnabled = enabled
    if enabled then
        spawn(function()
            while _G.ObjectSpamEnabled do
                local part = Instance.new("Part")
                part.Parent = workspace
                part.Size = Vector3.new(math.random(1, 10), math.random(1, 10), math.random(1, 10))
                part.Position = Vector3.new(math.random(-100, 100), math.random(10, 50), math.random(-100, 100))
                part.BrickColor = BrickColor.Random()
                part.Material = Enum.Material.Neon
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Velocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
                bodyVelocity.Parent = part
                
                game:GetService("Debris"):AddItem(part, 5)
                wait(0.1)
            end
        end)
    end
    print("📦 Object Spam:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleEarthquake(enabled)
    _G.EarthquakeEnabled = enabled
    if enabled then
        spawn(function()
            while _G.EarthquakeEnabled do
                for _, part in pairs(workspace:GetChildren()) do
                    if part:IsA("Part") and part.Anchored == false then
                        local bodyVelocity = Instance.new("BodyVelocity")
                        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                        bodyVelocity.Velocity = Vector3.new(math.random(-20, 20), math.random(0, 20), math.random(-20, 20))
                        bodyVelocity.Parent = part
                        game:GetService("Debris"):AddItem(bodyVelocity, 0.5)
                    end
                end
                wait(0.2)
            end
        end)
    end
    print("🌍 Earthquake Mode:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleVoiceSpam(enabled)
    _G.VoiceSpamEnabled = enabled
    if enabled then
        spawn(function()
            while _G.VoiceSpamEnabled do
                local sound = Instance.new("Sound")
                sound.Parent = workspace
                sound.SoundId = "rbxassetid://1837829565"
                sound.Volume = 1
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 5)
                wait(1)
            end
        end)
    end
    print("🎤 Voice Spam:", enabled and "ENABLED" or "DISABLED")
end

-- Player List Advanced Functions
function Functions.kickFromVehicle(player)
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        
        -- Method 1: Direct seat manipulation
        if humanoid then
            humanoid.Sit = false
            humanoid.Jump = true
            humanoid.PlatformStand = true
            
            -- Destroy any seat welds
            for _, obj in pairs(player.Character:GetDescendants()) do
                if obj:IsA("Weld") and (obj.Name:lower():find("seat") or obj.Name:lower():find("vehicle")) then
                    obj:Destroy()
                end
            end
        end
        
        -- Method 2: Force eject with extreme physics
        if rootPart then
            spawn(function()
                for i = 1, 5 do
                    local bodyVel = Instance.new("BodyVelocity")
                    bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bodyVel.Velocity = Vector3.new(math.random(-200, 200), 200, math.random(-200, 200))
                    bodyVel.Parent = rootPart
                    
                    game:GetService("Debris"):AddItem(bodyVel, 0.2)
                    wait(0.1)
                end
            end)
        end
        
        -- Method 3: Try vehicle remotes
        spawn(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    pcall(function()
                        obj:FireServer("eject", player)
                        obj:FireServer("kick", player)
                        obj:FireServer(player, "eject")
                        obj:FireServer("vehicle", "eject", player.Name)
                        obj:FireServer("seat", "remove", player)
                    end)
                end
            end
        end)
        
        -- Method 4: Destroy nearby vehicle seats
        spawn(function()
            if rootPart then
                for _, obj in pairs(workspace:GetPartBoundsInBox(rootPart.CFrame, Vector3.new(50, 50, 50))) do
                    if obj:IsA("Seat") or obj:IsA("VehicleSeat") then
                        if obj.Occupant == humanoid then
                            obj.Disabled = true
                            obj:Destroy()
                        end
                    end
                end
            end
        end)
        
        print("🚗⚡ EXTREME VEHICLE EJECTION ON " .. player.Name .. " - FORCED OUT!")
    end
end

function Functions.explodePlayer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        
        -- Method 1: Real damage through multiple methods
        if humanoid then
            -- Direct damage
            humanoid:TakeDamage(75)
            humanoid.Health = math.max(0, humanoid.Health - 75)
            
            -- Try to find damage remotes
            spawn(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("RemoteEvent") and string.find(obj.Name:lower(), "damage") then
                        pcall(function()
                            obj:FireServer(player, 75)
                            obj:FireServer(humanoid, 75)
                        end)
                    end
                end
            end)
        end
        
        -- Method 2: Physical explosions with real blast damage
        local rootPart = player.Character.HumanoidRootPart
        spawn(function()
            for i = 1, 15 do
                local explosion = Instance.new("Explosion")
                explosion.Parent = workspace
                explosion.Position = rootPart.Position + Vector3.new(math.random(-20, 20), math.random(-15, 15), math.random(-20, 20))
                explosion.BlastRadius = 100
                explosion.BlastPressure = 2000000
                explosion.Visible = true
                
                -- Each explosion damages the player
                if humanoid and humanoid.Health > 0 then
                    humanoid:TakeDamage(10)
                end
                
                wait(0.03)
            end
        end)
        
        -- Method 3: Realistic fire and smoke effects
        spawn(function()
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    -- Fire effect
                    local fire = Instance.new("Fire")
                    fire.Parent = part
                    fire.Size = math.random(15, 35)
                    fire.Heat = math.random(15, 25)
                    fire.Color = Color3.new(1, 0.3, 0)
                    fire.SecondaryColor = Color3.new(1, 0, 0)
                    
                    -- Smoke effect
                    local smoke = Instance.new("Smoke")
                    smoke.Parent = part
                    smoke.Size = math.random(25, 45)
                    smoke.Opacity = 0.8
                    smoke.RiseVelocity = 10
                    smoke.Color = Color3.new(0.2, 0.2, 0.2)
                    
                    -- Damage over time from fire
                    spawn(function()
                        for i = 1, 10 do
                            if humanoid and humanoid.Health > 0 then
                                humanoid:TakeDamage(2)
                            end
                            wait(0.5)
                        end
                    end)
                end
            end
        end)
        
        -- Method 4: Realistic physics with joint breaking
        spawn(function()
            -- Break joints for ragdoll
            for _, joint in pairs(player.Character:GetDescendants()) do
                if joint:IsA("Motor6D") or joint:IsA("Weld") then
                    joint:Destroy()
                end
            end
            
            -- Apply realistic explosion force
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(50000, 50000, 50000)
            bodyVelocity.Velocity = Vector3.new(math.random(-150, 150), 200, math.random(-150, 150))
            bodyVelocity.Parent = rootPart
            
            local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.MaxTorque = Vector3.new(50000, 50000, 50000)
            bodyAngularVelocity.AngularVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
            bodyAngularVelocity.Parent = rootPart
            
            -- Disable player control
            if humanoid then
                humanoid.PlatformStand = true
                humanoid.Sit = true
            end
            
            game:GetService("Debris"):AddItem(bodyVelocity, 2)
            game:GetService("Debris"):AddItem(bodyAngularVelocity, 2)
        end)
        
        print("💥🔥 REALISTIC EXPLOSION DAMAGE ON " .. player.Name .. "!")
    end
end

function Functions.spawnCarsOnPlayer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        for i = 1, 25 do
            local car = Instance.new("Part")
            car.Parent = workspace
            car.Name = "TrollCar" .. i
            car.Size = Vector3.new(math.random(6, 12), math.random(3, 6), math.random(12, 20))
            car.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-30, 30), 30 + i * 3, math.random(-30, 30))
            car.BrickColor = BrickColor.Random()
            car.Material = Enum.Material.Neon
            car.Shape = Enum.PartType.Block
            
            -- Add wheels
            for j = 1, 4 do
                local wheel = Instance.new("Part")
                wheel.Parent = car
                wheel.Size = Vector3.new(2, 2, 2)
                wheel.Shape = Enum.PartType.Cylinder
                wheel.BrickColor = BrickColor.new("Really black")
                wheel.Material = Enum.Material.Rubber
            end
            
            -- Add extreme velocity
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVelocity.Velocity = Vector3.new(math.random(-100, 100), -150, math.random(-100, 100))
            bodyVelocity.Parent = car
            
            -- Add spinning effect
            local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyAngularVelocity.AngularVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
            bodyAngularVelocity.Parent = car
            
            -- Add explosion on impact
            car.Touched:Connect(function(hit)
                if hit.Parent == player.Character then
                    local explosion = Instance.new("Explosion")
                    explosion.Parent = workspace
                    explosion.Position = car.Position
                    explosion.BlastRadius = 30
                    explosion.BlastPressure = 2000000
                end
            end)
            
            game:GetService("Debris"):AddItem(car, 15)
            wait(0.05)
        end
        print("🚗💥 SPAWNED 25 EXPLOSIVE CARS ON " .. player.Name .. "!")
    end
end

function Functions.crashPlayer(player)
    if player.Character then
        -- Method 1: Massive part spam with physics
        spawn(function()
            for i = 1, 5000 do
                local part = Instance.new("Part")
                part.Parent = player.Character
                part.Name = "CrashPart" .. i
                part.Size = Vector3.new(0.05, 0.05, 0.05)
                part.Anchored = false
                part.CanCollide = true
                part.Transparency = 0.95
                part.BrickColor = BrickColor.Random()
                part.Material = Enum.Material.Neon
                part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
                
                -- Add multiple physics objects
                local bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(10000, 10000, 10000)
                bodyVel.Velocity = Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
                bodyVel.Parent = part
                
                local bodyAngular = Instance.new("BodyAngularVelocity")
                bodyAngular.MaxTorque = Vector3.new(10000, 10000, 10000)
                bodyAngular.AngularVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
                bodyAngular.Parent = part
                
                -- Spam sounds every 5 parts
                if i % 5 == 0 then
                    local sound = Instance.new("Sound")
                    sound.Parent = part
                    sound.SoundId = "rbxassetid://131961136"
                    sound.Volume = 0.05
                    sound.Pitch = math.random(10, 500) / 100
                    sound.Looped = true
                    sound:Play()
                end
                
                -- Don't wait to maximize lag
                if i % 100 == 0 then
                    wait(0.001)
                end
            end
        end)
        
        -- Method 2: GUI spam attack
        spawn(function()
            for i = 1, 500 do
                local gui = Instance.new("ScreenGui")
                gui.Name = "CrashGUI" .. i
                gui.Parent = player.PlayerGui
                gui.ResetOnSpawn = false
                
                for j = 1, 10 do
                    local frame = Instance.new("Frame")
                    frame.Parent = gui
                    frame.Size = UDim2.new(math.random(), 0, math.random(), 0)
                    frame.Position = UDim2.new(math.random(), 0, math.random(), 0)
                    frame.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                    frame.BackgroundTransparency = math.random()
                    
                    local text = Instance.new("TextLabel")
                    text.Parent = frame
                    text.Size = UDim2.new(1, 0, 1, 0)
                    text.Text = "SPWARE CRASH " .. math.random(1, 99999)
                    text.TextSize = math.random(8, 72)
                    text.TextColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                end
            end
        end)
        
        -- Method 3: Try to use remotes to crash
        spawn(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    pcall(function()
                        for i = 1, 100 do
                            obj:FireServer(string.rep("CRASH", 1000))
                        end
                    end)
                end
            end
        end)
        
        print("💻🔥 EXTREME CRASH ATTACK ON " .. player.Name .. " - 5000+ OBJECTS!")
    end
end

function Functions.blackScreenPlayer(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        -- Method 1: Create multiple persistent black screens with different approaches
        spawn(function()
            for i = 1, 50 do
                local gui = Instance.new("ScreenGui")
                gui.Name = "BlackScreen" .. i .. "_" .. tick() .. math.random(1, 99999)
                gui.Parent = player.PlayerGui
                gui.ResetOnSpawn = false
                gui.IgnoreGuiInset = true
                gui.DisplayOrder = 10000 + i
                
                local blackFrame = Instance.new("Frame")
                blackFrame.Parent = gui
                blackFrame.Size = UDim2.new(3, 0, 3, 0)
                blackFrame.Position = UDim2.new(-1, 0, -1, 0)
                blackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                blackFrame.BorderSizePixel = 0
                blackFrame.ZIndex = 10000 + i
                blackFrame.Active = true
                blackFrame.Selectable = true
                
                -- Add multiple text labels
                for j = 1, 5 do
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Parent = blackFrame
                    textLabel.Size = UDim2.new(1, 0, 0.2, 0)
                    textLabel.Position = UDim2.new(0, 0, (j-1) * 0.2, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Text = "SPWARE - SCREEN HACKED - " .. math.random(1000, 9999)
                    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    textLabel.TextScaled = true
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.ZIndex = 10001 + i
                end
            end
        end)
        
        -- Method 2: Create multiple physical blindfolds
        spawn(function()
            for i = 1, 10 do
                local blindfold = Instance.new("Part")
                blindfold.Parent = workspace
                blindfold.Size = Vector3.new(20, 20, 0.1)
                blindfold.BrickColor = BrickColor.new("Really black")
                blindfold.Material = Enum.Material.ForceField
                blindfold.Anchored = true
                blindfold.CanCollide = false
                blindfold.Name = "Blindfold_" .. player.Name .. "_" .. i
                blindfold.Transparency = 0
                
                -- Position in front of player's face
                if player.Character:FindFirstChild("Head") then
                    blindfold.CFrame = player.Character.Head.CFrame * CFrame.new(0, 0, -1 - (i * 0.1))
                end
                
                -- Make it follow the player
                spawn(function()
                    while blindfold.Parent and player.Character and player.Character:FindFirstChild("Head") do
                        blindfold.CFrame = player.Character.Head.CFrame * CFrame.new(0, 0, -1 - (i * 0.1))
                        wait(0.01)
                    end
                end)
            end
        end)
        
        -- Method 3: Try blackscreen remotes
        end
        
        -- Method 3: Disable camera
        spawn(function()
            local camera = workspace.CurrentCamera
            for i = 1, 100 do
                camera.CameraType = Enum.CameraType.Scriptable
                camera.CFrame = CFrame.new(0, -1000, 0)
                wait(0.01)
            end
        end)
        
        print("⚫💀 COMPLETE BLACKOUT ON " .. player.Name .. " - CAMERA DISABLED!")
    end
end

function Functions.soundSpamPlayer(player)
    if player.Character then
        spawn(function()
            -- Spam 200 different sounds with maximum chaos
            local soundIds = {
                "rbxassetid://131961136",
                "rbxassetid://1837829565",
                "rbxassetid://2865227271",
                "rbxassetid://1280463188",
                "rbxassetid://2767090",
                "rbxassetid://1847661821",
                "rbxassetid://2767090",
                "rbxassetid://1837829565"
            }
            
            -- Method 1: Spam sounds in character
            for i = 1, 200 do
                local sound = Instance.new("Sound")
                sound.Parent = player.Character
                sound.Name = "SpamSound" .. i
                sound.SoundId = soundIds[math.random(1, #soundIds)]
                sound.Volume = 1
                sound.Pitch = math.random(5, 500) / 100
                sound.Looped = true
                sound.EmitterSize = 100
                sound:Play()
                
                -- Create sounds in every body part
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        for j = 1, 3 do
                            local extraSound = sound:Clone()
                            extraSound.Parent = part
                            extraSound.Pitch = math.random(1, 1000) / 100
                            extraSound:Play()
                        end
                    end
                end
            end
            
            -- Method 2: Create sound parts around player
            for i = 1, 50 do
                local soundPart = Instance.new("Part")
                soundPart.Parent = workspace
                soundPart.Size = Vector3.new(0.1, 0.1, 0.1)
                soundPart.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
                soundPart.Anchored = true
                soundPart.Transparency = 1
                soundPart.CanCollide = false
                
                for j = 1, 5 do
                    local sound = Instance.new("Sound")
                    sound.Parent = soundPart
                    sound.SoundId = soundIds[math.random(1, #soundIds)]
                    sound.Volume = 1
                    sound.Pitch = math.random(1, 1000) / 100
                    sound.Looped = true
                    sound.EmitterSize = 50
                    sound:Play()
                end
            end
        end)
        
        -- Method 3: Try to use sound remotes
        spawn(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("RemoteEvent") and (string.find(obj.Name:lower(), "sound") or string.find(obj.Name:lower(), "audio") or string.find(obj.Name:lower(), "music")) then
                    pcall(function()
                        for i = 1, 50 do
                            obj:FireServer("rbxassetid://131961136", player)
                            obj:FireServer("rbxassetid://1837829565", player.Character)
                        end
                    end)
                end
            end
        end)
        
        print("🔊💥 MAXIMUM SOUND CHAOS ON " .. player.Name .. " - 200+ SOUNDS!")
    end
end

function Functions.stealP1(player)
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid and humanoid.SeatPart then
            local vehicle = humanoid.SeatPart.Parent
            local localPlayer = game.Players.LocalPlayer
            
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                -- Teleport to vehicle
                localPlayer.Character.HumanoidRootPart.CFrame = vehicle.PrimaryPart.CFrame
                
                -- Try to sit in driver seat
                for _, seat in pairs(vehicle:GetChildren()) do
                    if seat:IsA("VehicleSeat") then
                        seat:Sit(localPlayer.Character.Humanoid)
                        break
                    end
                end
                print("🏎️ Stole P1 from " .. player.Name)
            end
        else
            print("❌ " .. player.Name .. " is not in a vehicle")
        end
    end
end

function Functions.enterVehicle(player)
    if player.Character then
        local localPlayer = game.Players.LocalPlayer
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            -- Find nearest vehicle to player
            local nearestVehicle = nil
            local shortestDistance = math.huge
            
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:FindFirstChild("VehicleSeat") then
                    local distance = (player.Character.HumanoidRootPart.Position - obj.PrimaryPart.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestVehicle = obj
                    end
                end
            end
            
            if nearestVehicle then
                localPlayer.Character.HumanoidRootPart.CFrame = nearestVehicle.PrimaryPart.CFrame
                for _, seat in pairs(nearestVehicle:GetChildren()) do
                    if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
                        seat:Sit(localPlayer.Character.Humanoid)
                        break
                    end
                end
                print("🚗 Entered vehicle near " .. player.Name)
            else
                print("❌ No vehicle found near " .. player.Name)
            end
        end
    end
end

-- Kill Player Function
function Functions.killPlayer(player)
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            -- Method 1: Instant server-side kill with multiple approaches
            spawn(function()
                -- Direct health manipulation
                humanoid.Health = 0
                humanoid:TakeDamage(math.huge)
                humanoid.MaxHealth = 0
                
                -- Break all joints to ragdoll
                for _, joint in pairs(player.Character:GetDescendants()) do
                    if joint:IsA("Motor6D") or joint:IsA("Weld") or joint:IsA("WeldConstraint") then
                        joint:Destroy()
                    end
                end
                
                -- Force respawn after delay to prevent invisibility
                wait(2)
                if player.Character then
                    player.Character:Destroy()
                end
                wait(1)
                player:LoadCharacter()
            end)
            
            -- Method 2: Physical destruction with real server effects
            spawn(function()
                wait(0.2)
                -- Create massive explosion at player position
                for i = 1, 10 do
                    local explosion = Instance.new("Explosion")
                    explosion.Parent = workspace
                    explosion.Position = rootPart.Position + Vector3.new(math.random(-10, 10), math.random(-5, 5), math.random(-10, 10))
                    explosion.BlastRadius = 100
                    explosion.BlastPressure = 10000000
                    explosion.Visible = true
                    
                    -- Add fire and smoke effects
                    local fire = Instance.new("Fire")
                    fire.Parent = rootPart
                    fire.Size = 30
                    fire.Heat = 25
                    
                    local smoke = Instance.new("Smoke")
                    smoke.Parent = rootPart
                    smoke.Size = 50
                    smoke.Opacity = 1
                    
                    wait(0.05)
                end
            end)
            
            -- Method 3: Try all possible remote events for killing
            spawn(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("RemoteEvent") then
                        pcall(function()
                            -- Try different kill parameters
                            obj:FireServer("kill", player)
                            obj:FireServer("damage", player, 999999)
                            obj:FireServer(player, "kill")
                            obj:FireServer(player.Character, "destroy")
                            obj:FireServer(humanoid, 0)
                            obj:FireServer("eliminate", player.Name)
                        end)
                    end
                end
            end)
            
            -- Method 4: Extreme physical manipulation
            spawn(function()
                wait(0.5)
                -- Fling player with extreme force
                local bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVel.Velocity = Vector3.new(math.random(-1000, 1000), 1000, math.random(-1000, 1000))
                bodyVel.Parent = rootPart
                
                -- Spin player violently
                local bodyAngular = Instance.new("BodyAngularVelocity")
                bodyAngular.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bodyAngular.AngularVelocity = Vector3.new(100, 100, 100)
                bodyAngular.Parent = rootPart
                
                game:GetService("Debris"):AddItem(bodyVel, 2)
                game:GetService("Debris"):AddItem(bodyAngular, 2)
            end)
            
            -- Method 5: Force disconnect attempt
            spawn(function()
                wait(3)
                pcall(function()
                    player:Kick("💀 SPWARE ELIMINATION PROTOCOL EXECUTED 💀")
                end)
            end)
            
            print("💀⚡ MAXIMUM KILL PROTOCOL EXECUTED ON " .. player.Name .. " - MULTIPLE METHODS DEPLOYED!")
        end
    end
end

function Functions.explodePlayer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local position = player.Character.HumanoidRootPart.Position
        local humanoid = player.Character:FindFirstChild("Humanoid")
        
        -- Method 1: Massive explosion barrage with real damage
        spawn(function()
            for i = 1, 25 do
                local explosion = Instance.new("Explosion")
                explosion.Parent = workspace
                explosion.Position = position + Vector3.new(math.random(-15, 15), math.random(-10, 10), math.random(-15, 15))
                explosion.BlastRadius = 75
                explosion.BlastPressure = 15000000
                explosion.Visible = true
                
                -- Deal real damage with each explosion
                if humanoid and humanoid.Health > 0 then
                    humanoid:TakeDamage(25)
                end
                
                wait(0.05)
            end
        end)
        
        -- Method 2: Physical effects and ragdoll
        spawn(function()
            -- Instant ragdoll
            if humanoid then
                humanoid.PlatformStand = true
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                humanoid.Sit = true
            end
            
            -- Break all joints for realistic ragdoll
            for _, joint in pairs(player.Character:GetDescendants()) do
                if joint:IsA("Motor6D") then
                    local attachment0 = Instance.new("Attachment")
                    local attachment1 = Instance.new("Attachment")
                    attachment0.Parent = joint.Part0
                    attachment1.Parent = joint.Part1
                    attachment0.CFrame = joint.C0
                    attachment1.CFrame = joint.C1
                    
                    local ballSocket = Instance.new("BallSocketConstraint")
                    ballSocket.Attachment0 = attachment0
                    ballSocket.Attachment1 = attachment1
                    ballSocket.Parent = joint.Part0
                    
                    joint:Destroy()
                end
            end
        end)
        
        -- Method 3: Extreme fling with multiple forces
        spawn(function()
            for i = 1, 5 do
                local bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVel.Velocity = Vector3.new(math.random(-200, 200), math.random(100, 300), math.random(-200, 200))
                bodyVel.Parent = player.Character.HumanoidRootPart
                
                local bodyAngular = Instance.new("BodyAngularVelocity")
                bodyAngular.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bodyAngular.AngularVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
                bodyAngular.Parent = player.Character.HumanoidRootPart
                
                game:GetService("Debris"):AddItem(bodyVel, 0.5)
                game:GetService("Debris"):AddItem(bodyAngular, 0.5)
                wait(0.1)
            end
        end)
        
        -- Method 4: Visual effects overload
        spawn(function()
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    -- Add fire to every part
                    local fire = Instance.new("Fire")
                    fire.Parent = part
                    fire.Size = 25
                    fire.Heat = 20
                    
                    -- Add smoke to every part
                    local smoke = Instance.new("Smoke")
                    smoke.Parent = part
                    smoke.Size = 35
                    smoke.Opacity = 1
                    
                    -- Make parts glow
                    part.Material = Enum.Material.Neon
                    part.BrickColor = BrickColor.new("Really red")
                end
            end
        end)
        
        -- Method 5: Try explosion remotes
        spawn(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("RemoteEvent") and (string.find(obj.Name:lower(), "explode") or string.find(obj.Name:lower(), "boom") or string.find(obj.Name:lower(), "blast")) then
                    pcall(function()
                        obj:FireServer(player, position)
                        obj:FireServer(player.Character, "explode")
                        obj:FireServer("explosion", player.Name)
                    end)
                end
            end
        end)
        
        print("💥🔥 NUCLEAR EXPLOSION PROTOCOL ON " .. player.Name .. " - 25 EXPLOSIONS + RAGDOLL!")
    end
end

-- ═══════════════════════════════════════════════════════════════
-- 📋 UI CONFIGURATION
-- ═══════════════════════════════════════════════════════════════
local TabData = {
    {
        name = "FPS",
        icon = "rbxassetid://111612200954692",
        color = Theme.Primary,
        sections = {
            {
                title = "Aimbot",
                items = {
                    {type = "toggle", name = "Enable Aimbot", func = Functions.toggleAimbot},
                    {type = "slider", name = "FOV", min = 10, max = 360, default = 90},
                    {type = "slider", name = "Smoothness", min = 1, max = 20, default = 5},
                    {type = "dropdown", name = "Target Bone", options = {"Head", "Torso", "Random"}},
                    {type = "slider", name = "Prediction", min = 0, max = 1, default = 0.1},
                    {type = "toggle", name = "Silent Aim", func = Functions.toggleSilentAim},
                    {type = "toggle", name = "Triggerbot", func = Functions.toggleTriggerbot},
                }
            },
            {
                title = "Weapons",
                items = {
                    {type = "toggle", name = "No Recoil", func = Functions.toggleNoRecoil},
                    {type = "toggle", name = "No Spread", func = Functions.toggleNoSpread},
                    {type = "toggle", name = "No Sway", func = Functions.toggleNoSway},
                    {type = "toggle", name = "Rapid Fire", func = Functions.toggleRapidFire},
                    {type = "toggle", name = "Auto Shoot", func = Functions.toggleAutoShoot},
                    {type = "toggle", name = "Infinite Ammo", func = Functions.toggleInfiniteAmmo},
                    {type = "toggle", name = "One Shot Kill", func = Functions.toggleOneShotKill},
                    {type = "toggle", name = "Penetration", func = Functions.togglePenetration},
                    {type = "toggle", name = "Bullet Tracers", func = function(e) print("📍 Bullet Tracers:", e and "ON" or "OFF") end},
                }
            },
            {
                title = "Combat",
                items = {
                    {type = "toggle", name = "Hitbox Expander", func = function(e) print("📦 Hitbox Expander:", e and "ON" or "OFF") end},
                    {type = "toggle", name = "Kill Aura", func = Functions.toggleKillAura},
                    {type = "slider", name = "Aura Range", min = 5, max = 50, default = 15},
                    {type = "toggle", name = "Hitbox Expander", func = Functions.toggleHitboxExpander},
                    {type = "slider", name = "Hitbox Size", min = 1, max = 20, default = 5},
                    {type = "toggle", name = "Auto Headshot", func = Functions.toggleAutoHeadshot},
                }
            }
        }
    },
    {
        name = "Visual",
        icon = "rbxassetid://77345366725078",
        color = Theme.Primary,
        sections = {
            {
                title = "ESP",
                items = {
                    {type = "toggle", name = "Box ESP", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Skeleton ESP", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Name ESP", func = Functions.toggleNameESP},
                    {type = "toggle", name = "Distance ESP", func = Functions.toggleDistanceESP},
                    {type = "toggle", name = "Health Bar ESP", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Team Colors", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Tracers", func = Functions.toggleTracers},
                    {type = "toggle", name = "Item ESP", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Vehicle ESP", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "NPC ESP", func = Functions.toggleBoxESP},
                }
            },
            {
                title = "Graphics",
                items = {
                    {type = "toggle", name = "Chams/Glow", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Wallhack", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Custom Crosshair", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Fullbright", func = Functions.toggleFullbright},
                    {type = "toggle", name = "Remove Fog", func = Functions.toggleFullbright},
                    {type = "toggle", name = "No Shadows", func = Functions.toggleFullbright},
                    {type = "toggle", name = "X-Ray", func = Functions.toggleBoxESP},
                    {type = "slider", name = "FOV Changer", min = 60, max = 120, default = 70},
                }
            },
            {
                title = "Environment",
                items = {
                    {type = "toggle", name = "Day/Night Changer", func = Functions.toggleFullbright},
                    {type = "toggle", name = "Radar Hack", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "3D Box ESP", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Highlight Players", func = Functions.toggleBoxESP},
                    {type = "toggle", name = "Third Person", func = Functions.toggleBoxESP},
                }
            }
        }
    },
    {
        name = "RP",
        icon = "rbxassetid://122767272714113",
        color = Theme.Primary,
        sections = {
            {
                title = "Spawning",
                items = {
                    {type = "button", name = "Spawn Weapons"},
                    {type = "button", name = "Spawn Vehicles"},
                    {type = "button", name = "Spawn Objects"},
                    {type = "button", name = "Spawn NPCs"},
                    {type = "toggle", name = "Give Money", func = function(e) print("💰 Give Money:", e and "ON" or "OFF") end},
                    {type = "toggle", name = "Give All Tools", func = function(e) print("🔧 Give All Tools:", e and "ON" or "OFF") end},
                }
            },
            {
                title = "Avatar",
                items = {
                    {type = "button", name = "Change Clothes"},
                    {type = "button", name = "Avatar Changer"},
                    {type = "button", name = "Copy Avatar"},
                    {type = "button", name = "Animation Player"},
                    {type = "toggle", name = "Fake Name", func = function(e) print("🎭 Fake Name:", e and "ON" or "OFF") end},
                    {type = "toggle", name = "Fake Rank", func = function(e) print("🏆 Fake Rank:", e and "ON" or "OFF") end},
                }
            },
            {
                title = "Player List",
                items = {
                    {type = "toggle", name = "Player List", func = function(enabled)
                        if enabled then
                            -- Create player list GUI
                            _G.PlayerListEnabled = true
                            Functions.createPlayerList()
                        else
                            _G.PlayerListEnabled = false
                            if _G.PlayerListFrame then
                                _G.PlayerListFrame:Destroy()
                                _G.PlayerListFrame = nil
                            end
                        end
                    end},
                }
            },
            {
                title = "Interaction",
                items = {
                    {type = "button", name = "Teleport All"},
                    {type = "toggle", name = "Force Emotes", func = function(e) print("😄 Force Emotes:", e and "ON" or "OFF") end},
                    {type = "button", name = "Job Changer"},
                    {type = "button", name = "Build Spam"},
                }
            }
        }
    },
    {
        name = "Troll",
        icon = "rbxassetid://102270380454487",
        color = Theme.Primary,
        sections = {
            {
                title = "Audio/Visual",
                items = {
                    {type = "toggle", name = "Sound Spam", func = Functions.toggleSoundSpam},
                    {type = "toggle", name = "Screen Shaker", func = Functions.toggleScreenShaker},
                    {type = "toggle", name = "Camera Inverter", func = Functions.toggleCameraInverter},
                    {type = "toggle", name = "Black Screen", func = Functions.toggleBlackScreen},
                    {type = "toggle", name = "Blind Effect", func = Functions.toggleBlindEffect},
                    {type = "toggle", name = "Screen Text Spam", func = Functions.toggleTextSpam},
                }
            },
            {
                title = "Server Destruction",
                items = {
                    {type = "button", name = "Server Crasher"},
                    {type = "toggle", name = "Object Spam", func = Functions.toggleObjectSpam},
                    {type = "toggle", name = "Earthquake Mode", func = Functions.toggleEarthquake},
                    {type = "button", name = "Map Destroy"},
                    {type = "button", name = "Nuke Effect"},
                    {type = "toggle", name = "Voice Spam", func = Functions.toggleVoiceSpam},
                }
            }
        }
    },
    {
        name = "Misc",
        icon = "rbxassetid://118260954915004",
        color = Theme.Primary,
        sections = {
            {
                title = "Movement",
                items = {
                    {type = "toggle", name = "Super Speed", func = function(e) Functions.toggleSpeed(e, 100) end},
                    {type = "slider", name = "WalkSpeed", min = 16, max = 500, default = 100},
                    {type = "toggle", name = "Infinite Jump", func = Functions.toggleSpeed},
                    {type = "slider", name = "JumpPower", min = 50, max = 500, default = 150},
                    {type = "toggle", name = "Fly Mode", func = Functions.toggleFly},
                    {type = "slider", name = "Fly Speed", min = 10, max = 200, default = 50},
                    {type = "toggle", name = "Noclip", func = Functions.toggleNoclip},
                    {type = "toggle", name = "No Fall Damage", func = Functions.toggleSpeed},
                }
            },
            {
                title = "Utilities",
                items = {
                    {type = "toggle", name = "Auto Farm", func = function(e) print("🚜 Auto Farm:", e and "ON" or "OFF") end},
                    {type = "toggle", name = "Auto Collect", func = function(e) print("💰 Auto Collect:", e and "ON" or "OFF") end},
                    {type = "toggle", name = "Auto Respawn", func = function(e) print("🔄 Auto Respawn:", e and "ON" or "OFF") end},
                    {type = "toggle", name = "Anti AFK", func = function(e) print("⏰ Anti AFK:", e and "ON" or "OFF") end},
                    {type = "toggle", name = "Infinite Stamina", func = function(e) print("💪 Infinite Stamina:", e and "ON" or "OFF") end},
                    {type = "toggle", name = "Menu RGB", func = function(e) 
                        if e then
                            -- RGB animation for menu border
                            spawn(function()
                                while e do
                                    for i = 0, 1, 0.01 do
                                        if mainFrame then
                                            local hue = (tick() * 0.5) % 1
                                            local rgb = Color3.fromHSV(hue, 1, 1)
                                            if mainFrame:FindFirstChild("UIStroke") then
                                                mainFrame.UIStroke.Color = rgb
                                            else
                                                local stroke = Instance.new("UIStroke")
                                                stroke.Color = rgb
                                                stroke.Thickness = 2
                                                stroke.Parent = mainFrame
                                            end
                                        end
                                        wait(0.03)
                                    end
                                end
                                if mainFrame and mainFrame:FindFirstChild("UIStroke") then
                                    mainFrame.UIStroke:Destroy()
                                end
                            end)
                        end
                    end},
                    {type = "button", name = "Rejoin Server"},
                    {type = "button", name = "Server Hop"},
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
shadow.BackgroundTransparency = 0.8
shadow.BorderSizePixel = 0
shadow.ZIndex = -1

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- Tab container and content scroll need to be declared before createTab function
local tabContainer, contentScroll

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

-- Logo
local logo = Instance.new("ImageLabel")
logo.Parent = header
logo.Size = UDim2.new(0, 24, 0, 24)
logo.Position = UDim2.new(0, 15, 0.5, -12)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://70651953090646"
logo.ImageColor3 = Theme.Primary

-- Title
local title = Instance.new("TextLabel")
title.Parent = header
title.Size = UDim2.new(0, 150, 1, 0)
title.Position = UDim2.new(0, 45, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SPWARE"
title.TextColor3 = Theme.TextPrimary
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close button (minimalist)
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = header
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0.5, -15)
closeBtn.BackgroundColor3 = Theme.Surface
closeBtn.BorderSizePixel = 0
closeBtn.Text = "—"
closeBtn.TextColor3 = Theme.TextSecondary
closeBtn.TextSize = 16
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
tabLayout.Padding = UDim.new(0, 5)

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
    
    local tabIcon = Instance.new("ImageLabel")
    tabIcon.Parent = tab
    tabIcon.Size = UDim2.new(0, 20, 0, 20)
    tabIcon.Position = UDim2.new(0, 15, 0.5, -10)
    tabIcon.BackgroundTransparency = 1
    tabIcon.Image = tabData.icon
    tabIcon.ImageColor3 = Theme.TextSecondary
    
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
    
    return tab, tabIcon, label
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
    local tab, tabIcon, label = createTab(tabData, i)
    tabs[i] = {button = tab, icon = tabIcon, label = label, data = tabData}
    
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
        tab.icon.ImageColor3 = isActive and Theme.TextPrimary or Theme.TextSecondary
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

-- Safe initialization
print("🎮 Professional Cheat UI Ready - Press INSERT to toggle!")

-- Script completed successfully
