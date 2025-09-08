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
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0.5, -150, 0.5, -200)
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
        {name = "Freeze", func = function(player) Functions.freezePlayer(player) end},
        {name = "Fling", func = function(player) Functions.flingPlayer(player) end}
    }
    
    for _, action in pairs(actions) do
        local btn = Instance.new("TextButton")
        btn.Parent = actionsFrame
        btn.Size = UDim2.new(0, 40, 0, 30)
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
                local playerBtn = Instance.new("TextButton")
                playerBtn.Parent = scrollFrame
                playerBtn.Size = UDim2.new(1, 0, 0, 30)
                playerBtn.BackgroundColor3 = Theme.Elevated
                playerBtn.BorderSizePixel = 0
                playerBtn.Text = player.Name .. " (" .. player.DisplayName .. ")"
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
    if localPlayer.Character and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        print("🚀 Teleported to " .. player.Name)
    end
end

function Functions.pullPlayer(player)
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame
        print("🎣 Pulled " .. player.Name)
    end
end

function Functions.copyOutfit(player)
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character and player.Character then
        for _, item in pairs(player.Character:GetChildren()) do
            if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") then
                local clone = item:Clone()
                clone.Parent = localPlayer.Character
            end
        end
        print("👕 Copied outfit from " .. player.Name)
    end
end

function Functions.stealItems(player)
    if player.Backpack then
        local localPlayer = game.Players.LocalPlayer
        for _, tool in pairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = localPlayer.Backpack
            end
        end
        print("💰 Stole items from " .. player.Name)
    end
end

function Functions.freezePlayer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Anchored = true
        print("🧊 Froze " .. player.Name)
    end
end

function Functions.flingPlayer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(math.random(-100, 100), 100, math.random(-100, 100))
        bodyVelocity.Parent = player.Character.HumanoidRootPart
        game:GetService("Debris"):AddItem(bodyVelocity, 1)
        print("🌪️ Flung " .. player.Name)
    end
end

-- Combat Functions
function Functions.toggleAimbot(enabled)
    _G.AimbotEnabled = enabled
    if enabled then
        spawn(function()
            local Camera = workspace.CurrentCamera
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Mouse = LocalPlayer:GetMouse()
            
            while _G.AimbotEnabled do
                local closestPlayer = nil
                local shortestDistance = math.huge
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.Head.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
                
                if closestPlayer then
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
                end
                
                wait(0.1)
            end
        end)
    end
    print("🎯 Aimbot:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleESP(enabled)
    _G.ESPEnabled = enabled
    if enabled then
        spawn(function()
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            while _G.ESPEnabled do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if not player.Character:FindFirstChild("ESP_Box") then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Name = "ESP_Box"
                            box.Parent = player.Character
                            box.Adornee = player.Character.HumanoidRootPart
                            box.Size = Vector3.new(4, 6, 1)
                            box.Color3 = Color3.new(1, 0, 0)
                            box.Transparency = 0.5
                            box.AlwaysOnTop = true
                        end
                    end
                end
                wait(1)
            end
        end)
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("ESP_Box") then
                player.Character.ESP_Box:Destroy()
            end
        end
    end
    print("👁️ ESP:", enabled and "ENABLED" or "DISABLED")
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
                    {type = "toggle", name = "Silent Aim", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Triggerbot", func = Functions.toggleAimbot},
                }
            },
            {
                title = "Weapons",
                items = {
                    {type = "toggle", name = "No Recoil", func = Functions.toggleAimbot},
                    {type = "toggle", name = "No Spread", func = Functions.toggleAimbot},
                    {type = "toggle", name = "No Sway", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Rapid Fire", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Auto Shoot", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Infinite Ammo", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Instant Reload", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Wallbang", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Bullet Tracers", func = Functions.toggleAimbot},
                }
            },
            {
                title = "Combat",
                items = {
                    {type = "toggle", name = "Hitbox Expander", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Kill Aura", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Critical Hits", func = Functions.toggleAimbot},
                    {type = "toggle", name = "One Tap Mode", func = Functions.toggleAimbot},
                    {type = "slider", name = "Gun Damage", min = 1, max = 500, default = 100},
                    {type = "toggle", name = "Explosive Bullets", func = Functions.toggleAimbot},
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
                    {type = "toggle", name = "Box ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "Skeleton ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "Name ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "Distance ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "Health Bar ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "Team Colors", func = Functions.toggleESP},
                    {type = "toggle", name = "Tracers", func = Functions.toggleESP},
                    {type = "toggle", name = "Item ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "Vehicle ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "NPC ESP", func = Functions.toggleESP},
                }
            },
            {
                title = "Graphics",
                items = {
                    {type = "toggle", name = "Chams/Glow", func = Functions.toggleESP},
                    {type = "toggle", name = "Wallhack", func = Functions.toggleESP},
                    {type = "toggle", name = "Custom Crosshair", func = Functions.toggleESP},
                    {type = "toggle", name = "Fullbright", func = Functions.toggleFullbright},
                    {type = "toggle", name = "Remove Fog", func = Functions.toggleFullbright},
                    {type = "toggle", name = "No Shadows", func = Functions.toggleFullbright},
                    {type = "toggle", name = "X-Ray", func = Functions.toggleESP},
                    {type = "slider", name = "FOV Changer", min = 60, max = 120, default = 70},
                }
            },
            {
                title = "Environment",
                items = {
                    {type = "toggle", name = "Day/Night Changer", func = Functions.toggleFullbright},
                    {type = "toggle", name = "Radar Hack", func = Functions.toggleESP},
                    {type = "toggle", name = "3D Box ESP", func = Functions.toggleESP},
                    {type = "toggle", name = "Highlight Players", func = Functions.toggleESP},
                    {type = "toggle", name = "Third Person", func = Functions.toggleESP},
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
                    {type = "toggle", name = "Give Money", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Give All Tools", func = Functions.toggleAimbot},
                }
            },
            {
                title = "Avatar",
                items = {
                    {type = "button", name = "Change Clothes"},
                    {type = "button", name = "Avatar Changer"},
                    {type = "button", name = "Copy Avatar"},
                    {type = "button", name = "Animation Player"},
                    {type = "toggle", name = "Fake Name", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Fake Rank", func = Functions.toggleAimbot},
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
                    {type = "toggle", name = "Force Emotes", func = Functions.toggleAimbot},
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
                    {type = "toggle", name = "Sound Spam", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Screen Shaker", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Camera Inverter", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Black Screen", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Blind Effect", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Screen Text Spam", func = Functions.toggleAimbot},
                }
            },
            {
                title = "Server Destruction",
                items = {
                    {type = "button", name = "Server Crasher"},
                    {type = "toggle", name = "Object Spam", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Earthquake Mode", func = Functions.toggleAimbot},
                    {type = "button", name = "Map Destroy"},
                    {type = "button", name = "Nuke Effect"},
                    {type = "toggle", name = "Voice Spam", func = Functions.toggleAimbot},
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
                    {type = "toggle", name = "Auto Farm", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Auto Collect", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Auto Respawn", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Anti AFK", func = Functions.toggleAimbot},
                    {type = "toggle", name = "Infinite Stamina", func = Functions.toggleAimbot},
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
