-- ╔══════════════════════════════════════════════════════════════╗
-- ║                    ROBLOX CHEAT FUNCTIONS                    ║
-- ║                   Advanced Implementation                    ║
-- ╚══════════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local mouse = player:GetMouse()

-- Evitar reload múltiplo
if _G.CheatFunctionsLoaded then
    print("♻️ Functions já carregado")
    return _G.CheatFunctions
end

local Functions = {}
local connections = {}
local originalSettings = {}

-- ═══════════════════════════════════════════════════════════════
-- 🎯 FPS FUNCTIONS - AIMBOT & COMBAT
-- ═══════════════════════════════════════════════════════════════

-- Configurações do Aimbot
local AimbotConfig = {
    enabled = false,
    fov = 100,
    smoothness = 5,
    targetBone = "Head",
    prediction = 0.1,
    teamCheck = true,
    visibleOnly = true,
    currentTarget = nil
}

-- Função para obter o jogador mais próximo
function Functions.getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild(AimbotConfig.targetBone) then
            -- Team check
            if AimbotConfig.teamCheck and targetPlayer.Team == player.Team then
                continue
            end
            
            local targetPart = targetPlayer.Character[AimbotConfig.targetBone]
            local screenPoint, onScreen = camera:WorldToViewportPoint(targetPart.Position)
            
            if onScreen then
                local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                
                if distance <= AimbotConfig.fov and distance < shortestDistance then
                    -- Visibility check
                    if not AimbotConfig.visibleOnly or Functions.isPlayerVisible(targetPlayer) then
                        closestPlayer = targetPlayer
                        shortestDistance = distance
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

-- Função para verificar visibilidade
function Functions.isPlayerVisible(targetPlayer)
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild(AimbotConfig.targetBone) then
        return false
    end
    
    local targetPart = targetPlayer.Character[AimbotConfig.targetBone]
    local ray = workspace:Raycast(camera.CFrame.Position, (targetPart.Position - camera.CFrame.Position).Unit * 1000)
    
    if ray then
        local hitPart = ray.Instance
        return hitPart:IsDescendantOf(targetPlayer.Character)
    end
    
    return true
end

-- Aimbot principal
function Functions.performAimbot()
    if not AimbotConfig.enabled then return end
    
    local target = Functions.getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild(AimbotConfig.targetBone) then
        local targetPart = target.Character[AimbotConfig.targetBone]
        local targetPosition = targetPart.Position
        
        -- Prediction
        if AimbotConfig.prediction > 0 and targetPart.Parent:FindFirstChild("Humanoid") then
            local velocity = targetPart.Parent.HumanoidRootPart.Velocity
            targetPosition = targetPosition + (velocity * AimbotConfig.prediction)
        end
        
        -- Smooth aimbot
        if AimbotConfig.smoothness > 0 then
            local currentCFrame = camera.CFrame
            local targetCFrame = CFrame.lookAt(camera.CFrame.Position, targetPosition)
            camera.CFrame = currentCFrame:Lerp(targetCFrame, 1 / AimbotConfig.smoothness)
        else
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPosition)
        end
        
        AimbotConfig.currentTarget = target
    else
        AimbotConfig.currentTarget = nil
    end
end

-- Toggle Aimbot
function Functions.toggleAimbot(enabled)
    AimbotConfig.enabled = enabled
    
    if enabled then
        connections.aimbot = RunService.Heartbeat:Connect(Functions.performAimbot)
        print("🎯 Aimbot ativado!")
    else
        if connections.aimbot then
            connections.aimbot:Disconnect()
            connections.aimbot = nil
        end
        print("🎯 Aimbot desativado!")
    end
end

-- Configurar FOV do Aimbot
function Functions.setAimbotFOV(fov)
    AimbotConfig.fov = fov
end

-- Configurar suavidade
function Functions.setAimbotSmoothness(smoothness)
    AimbotConfig.smoothness = smoothness
end

-- Silent Aim
function Functions.toggleSilentAim(enabled)
    if enabled then
        connections.silentAim = RunService.Heartbeat:Connect(function()
            local target = Functions.getClosestPlayer()
            if target and target.Character then
                -- Implementar silent aim aqui
                print("🔇 Silent aim targeting:", target.Name)
            end
        end)
        print("🔇 Silent Aim ativado!")
    else
        if connections.silentAim then
            connections.silentAim:Disconnect()
            connections.silentAim = nil
        end
        print("🔇 Silent Aim desativado!")
    end
end

-- Triggerbot
function Functions.toggleTriggerbot(enabled)
    if enabled then
        connections.triggerbot = RunService.Heartbeat:Connect(function()
            if AimbotConfig.currentTarget then
                -- Simular clique automático
                mouse1click()
            end
        end)
        print("🔫 Triggerbot ativado!")
    else
        if connections.triggerbot then
            connections.triggerbot:Disconnect()
            connections.triggerbot = nil
        end
        print("🔫 Triggerbot desativado!")
    end
end

-- ═══════════════════════════════════════════════════════════════
-- 👁️ VISUAL FUNCTIONS - ESP & EFFECTS
-- ═══════════════════════════════════════════════════════════════

local ESPObjects = {}

-- Função para criar ESP
function Functions.createESP(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    
    -- Remover ESP existente
    Functions.removeESP(targetPlayer)
    
    local character = targetPlayer.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Criar folder para organizar ESP
    local espFolder = Instance.new("Folder")
    espFolder.Name = "ESP_" .. targetPlayer.Name
    espFolder.Parent = character
    
    -- Box ESP
    local boxESP = Instance.new("BoxHandleAdornment")
    boxESP.Name = "BoxESP"
    boxESP.Adornee = humanoidRootPart
    boxESP.Size = humanoidRootPart.Size + Vector3.new(1, 3, 1)
    boxESP.Color3 = Color3.fromRGB(255, 0, 0)
    boxESP.Transparency = 0.7
    boxESP.AlwaysOnTop = true
    boxESP.ZIndex = 1
    boxESP.Parent = espFolder
    
    -- Name ESP
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "NameESP"
    billboardGui.Adornee = character:FindFirstChild("Head")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = espFolder
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = targetPlayer.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 16
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Parent = billboardGui
    
    -- Distance ESP
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distanceLabel.TextSize = 14
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distanceLabel.Parent = billboardGui
    
    -- Health ESP
    local healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(0, 4, 1, 0)
    healthBar.Position = UDim2.new(0, -10, 0, 0)
    healthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = billboardGui
    
    -- Tracers
    local tracer = Instance.new("Beam")
    tracer.Name = "Tracer"
    tracer.Width0 = 0.1
    tracer.Width1 = 0.1
    tracer.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    tracer.Transparency = NumberSequence.new(0.5)
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = camera
    local attachment2 = Instance.new("Attachment")
    attachment2.Parent = humanoidRootPart
    
    tracer.Attachment0 = attachment1
    tracer.Attachment1 = attachment2
    tracer.Parent = espFolder
    
    -- Chams/Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "Chams"
    highlight.Adornee = character
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = espFolder
    
    -- Atualizar distância
    connections["esp_" .. targetPlayer.Name] = RunService.Heartbeat:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and humanoidRootPart then
            local distance = (player.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
            distanceLabel.Text = math.floor(distance) .. "m"
            
            -- Atualizar health bar
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                local healthPercent = humanoid.Health / humanoid.MaxHealth
                healthBar.Size = UDim2.new(0, 4, healthPercent, 0)
                healthBar.Position = UDim2.new(0, -10, 1 - healthPercent, 0)
                healthBar.BackgroundColor3 = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
            end
        end
    end)
    
    ESPObjects[targetPlayer.Name] = espFolder
end

-- Remover ESP
function Functions.removeESP(targetPlayer)
    if ESPObjects[targetPlayer.Name] then
        ESPObjects[targetPlayer.Name]:Destroy()
        ESPObjects[targetPlayer.Name] = nil
    end
    
    if connections["esp_" .. targetPlayer.Name] then
        connections["esp_" .. targetPlayer.Name]:Disconnect()
        connections["esp_" .. targetPlayer.Name] = nil
    end
end

-- Toggle Box ESP
function Functions.toggleBoxESP(enabled)
    if enabled then
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= player then
                Functions.createESP(targetPlayer)
            end
        end
        
        connections.espPlayerAdded = Players.PlayerAdded:Connect(function(targetPlayer)
            targetPlayer.CharacterAdded:Connect(function()
                wait(1)
                Functions.createESP(targetPlayer)
            end)
        end)
        
        print("📦 Box ESP ativado!")
    else
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            Functions.removeESP(targetPlayer)
        end
        
        if connections.espPlayerAdded then
            connections.espPlayerAdded:Disconnect()
            connections.espPlayerAdded = nil
        end
        
        print("📦 Box ESP desativado!")
    end
end

-- Toggle Chams
function Functions.toggleChams(enabled)
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local espFolder = targetPlayer.Character:FindFirstChild("ESP_" .. targetPlayer.Name)
            if espFolder then
                local chams = espFolder:FindFirstChild("Chams")
                if chams then
                    chams.Enabled = enabled
                end
            end
        end
    end
    print("✨ Chams:", enabled and "ON" or "OFF")
end

-- Toggle Fullbright
function Functions.toggleFullbright(enabled)
    if enabled then
        originalSettings.brightness = Lighting.Brightness
        originalSettings.clockTime = Lighting.ClockTime
        originalSettings.fogEnd = Lighting.FogEnd
        originalSettings.globalShadows = Lighting.GlobalShadows
        
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        
        print("💡 Fullbright ativado!")
    else
        Lighting.Brightness = originalSettings.brightness or 1
        Lighting.ClockTime = originalSettings.clockTime or 12
        Lighting.FogEnd = originalSettings.fogEnd or 100000
        Lighting.GlobalShadows = originalSettings.globalShadows ~= nil and originalSettings.globalShadows or true
        
        print("💡 Fullbright desativado!")
    end
end

-- ═══════════════════════════════════════════════════════════════
-- ⚙️ MISC FUNCTIONS - MOVEMENT & UTILITIES
-- ═══════════════════════════════════════════════════════════════

-- Super Speed
function Functions.toggleSuperSpeed(enabled, speed)
    if enabled then
        connections.superSpeed = RunService.Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = speed or 50
            end
        end)
        
        connections.superSpeedRespawn = player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").WalkSpeed = speed or 50
        end)
        
        print("🏃 Super Speed ativado:", speed or 50)
    else
        if connections.superSpeed then
            connections.superSpeed:Disconnect()
            connections.superSpeed = nil
        end
        if connections.superSpeedRespawn then
            connections.superSpeedRespawn:Disconnect()
            connections.superSpeedRespawn = nil
        end
        
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
        
        print("🏃 Super Speed desativado!")
    end
end

-- Fly
function Functions.toggleFly(enabled, speed)
    if enabled then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            bodyVelocity.Parent = player.Character.HumanoidRootPart
        end
        
        connections.fly = RunService.Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    local moveVector = humanoid.MoveDirection * (speed or 50)
                    bodyVelocity.Velocity = Vector3.new(moveVector.X, 0, moveVector.Z)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, speed or 50, 0)
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, -(speed or 50), 0)
                    end
                end
            end
        end)
        
        print("🛸 Fly ativado!")
    else
        if connections.fly then
            connections.fly:Disconnect()
            connections.fly = nil
        end
        
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local bodyVelocity = player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
        end
        
        print("🛸 Fly desativado!")
    end
end

-- Noclip
function Functions.toggleNoclip(enabled)
    if enabled then
        connections.noclip = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
        print("👻 Noclip ativado!")
    else
        if connections.noclip then
            connections.noclip:Disconnect()
            connections.noclip = nil
        end
        
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        print("👻 Noclip desativado!")
    end
end

-- Infinite Jump
function Functions.toggleInfiniteJump(enabled)
    if enabled then
        connections.infiniteJump = UserInputService.JumpRequest:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        print("🚀 Infinite Jump ativado!")
    else
        if connections.infiniteJump then
            connections.infiniteJump:Disconnect()
            connections.infiniteJump = nil
        end
        print("🚀 Infinite Jump desativado!")
    end
end

-- ═══════════════════════════════════════════════════════════════
-- 🎭 RP FUNCTIONS - ROLEPLAY & SPAWNING
-- ═══════════════════════════════════════════════════════════════

-- Spawn Weapon (exemplo básico)
function Functions.spawnWeapon(weaponName)
    local tool = Instance.new("Tool")
    tool.Name = weaponName
    tool.RequiresHandle = true
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 4, 0.2)
    handle.Material = Enum.Material.Metal
    handle.BrickColor = BrickColor.new("Really black")
    handle.Parent = tool
    
    tool.Parent = player.Backpack
    print("🔫 Weapon spawned:", weaponName)
end

-- Teleport to Player
function Functions.teleportToPlayer(targetPlayerName)
    local targetPlayer = Players:FindFirstChild(targetPlayerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            print("📍 Teleported to:", targetPlayerName)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════
-- 🤡 TROLL FUNCTIONS - TROLLING & EFFECTS
-- ═══════════════════════════════════════════════════════════════

-- Fling All Players
function Functions.flingAllPlayers(enabled)
    if enabled then
        connections.flingAll = RunService.Heartbeat:Connect(function()
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                    bodyVelocity.Velocity = Vector3.new(math.random(-50, 50), 50, math.random(-50, 50))
                    bodyVelocity.Parent = targetPlayer.Character.HumanoidRootPart
                    
                    game:GetService("Debris"):AddItem(bodyVelocity, 0.1)
                end
            end
        end)
        print("🌪️ Fling All ativado!")
    else
        if connections.flingAll then
            connections.flingAll:Disconnect()
            connections.flingAll = nil
        end
        print("🌪️ Fling All desativado!")
    end
end

-- Sound Spam
function Functions.toggleSoundSpam(enabled)
    if enabled then
        connections.soundSpam = RunService.Heartbeat:Connect(function()
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://131961136" -- Exemplo de som
            sound.Volume = 1
            sound.Parent = workspace
            sound:Play()
            
            game:GetService("Debris"):AddItem(sound, 1)
        end)
        print("🔊 Sound Spam ativado!")
    else
        if connections.soundSpam then
            connections.soundSpam:Disconnect()
            connections.soundSpam = nil
        end
        print("🔊 Sound Spam desativado!")
    end
end

-- ═══════════════════════════════════════════════════════════════
-- 🧹 CLEANUP & UTILITIES
-- ═══════════════════════════════════════════════════════════════

-- Cleanup function
function Functions.cleanup()
    -- Desconectar todas as conexões
    for name, connection in pairs(connections) do
        if connection then
            connection:Disconnect()
        end
    end
    connections = {}
    
    -- Remover todos os ESPs
    for playerName, espFolder in pairs(ESPObjects) do
        if espFolder then
            espFolder:Destroy()
        end
    end
    ESPObjects = {}
    
    -- Restaurar configurações originais
    if originalSettings.brightness then
        Lighting.Brightness = originalSettings.brightness
        Lighting.ClockTime = originalSettings.clockTime
        Lighting.FogEnd = originalSettings.fogEnd
        Lighting.GlobalShadows = originalSettings.globalShadows
    end
    
    -- Restaurar velocidade e jump power
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
        player.Character.Humanoid.JumpPower = 50
    end
    
    print("🧹 Cleanup completo!")
end

-- ═══════════════════════════════════════════════════════════════
-- 🚀 INICIALIZAÇÃO
-- ═══════════════════════════════════════════════════════════════

-- Marcar como carregado
_G.CheatFunctionsLoaded = true
_G.CheatFunctions = Functions

print("╔══════════════════════════════════════════════════════════════╗")
print("║                 CHEAT FUNCTIONS LOADED                      ║")
print("║                    Ready for Action!                        ║")
print("╚══════════════════════════════════════════════════════════════╝")

return Functions
