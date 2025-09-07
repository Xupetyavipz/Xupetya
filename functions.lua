-- Functions.lua - Todas as Funcionalidades do Menu
-- Biblioteca completa de funções para Roblox


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Camera = Workspace.CurrentCamera

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local Functions = {}

-- Variáveis globais para controle
local connections = {}
local originalSettings = {}

-- ========================================
-- AIMBOT FUNCTIONS
-- ========================================

Functions.Aimbot = {
    enabled = false,
    fov = 100,
    smoothness = 5,
    targetVisible = true,
    silentAim = false,
    triggerbot = false
}

function Functions.toggleAimbot(enabled)
    Functions.Aimbot.enabled = enabled
    print("🎯 Aimbot function called:", enabled)
    
    if enabled then
        connections.aimbot = RunService.Heartbeat:Connect(function()
            if Functions.Aimbot.enabled then
                local target = Functions.getClosestPlayer()
                if target and target.Character and target.Character:FindFirstChild("Head") then
                    local targetPosition = target.Character.Head.Position
                    local camera = Camera
                    
                    if Functions.Aimbot.smoothness > 0 then
                        -- Smooth aimbot
                        local currentCFrame = camera.CFrame
                        local targetCFrame = CFrame.lookAt(camera.CFrame.Position, targetPosition)
                        camera.CFrame = currentCFrame:Lerp(targetCFrame, 1 / Functions.Aimbot.smoothness)
                    else
                        -- Instant aimbot
                        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPosition)
                    end
                end
            end
        end)
        print("🎯 Aimbot ativado!")
    else
        if connections.aimbot then
            connections.aimbot:Disconnect()
            connections.aimbot = nil
        end
        print("🎯 Aimbot desativado!")
    end
end

function Functions.setAimbotFOV(fov)
    Functions.Aimbot.fov = fov
    print("🎯 Aimbot FOV:", fov)
end

function Functions.setAimbotSmoothness(smoothness)
    Functions.Aimbot.smoothness = smoothness
    print("🎯 Aimbot Smoothness:", smoothness)
end

function Functions.toggleSilentAim(enabled)
    Functions.Aimbot.silentAim = enabled
    print("🔇 Silent Aim:", enabled and "ON" or "OFF")
end

function Functions.toggleTriggerbot(enabled)
    Functions.Aimbot.triggerbot = enabled
    
    if enabled then
        connections.triggerbot = mouse.Button1Down:Connect(function()
            if Functions.Aimbot.triggerbot then
                local target = Functions.getClosestPlayer()
                if target then
                    -- Simular clique automático
                    mouse1click()
                end
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

function Functions.getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = Functions.Aimbot.fov
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
            
            if distance < shortestDistance then
                if Functions.Aimbot.targetVisible then
                    -- Verificar se o alvo está visível
                    local raycast = Workspace:Raycast(Camera.CFrame.Position, (otherPlayer.Character.Head.Position - Camera.CFrame.Position).Unit * distance)
                    if not raycast or raycast.Instance:IsDescendantOf(otherPlayer.Character) then
                        closestPlayer = otherPlayer
                        shortestDistance = distance
                    end
                else
                    closestPlayer = otherPlayer
                    shortestDistance = distance
                end
            end
        end
    end
    
    return closestPlayer
end

-- ========================================
-- VISUAL FUNCTIONS
-- ========================================

Functions.Visual = {
    esp = false,
    espBoxes = false,
    espItems = false,
    fullbright = false,
    removeFog = false,
    chams = false,
    fov = 90,
    espDistance = 1000
}

function Functions.toggleESP(enabled)
    Functions.Visual.esp = enabled
    
    if enabled then
        -- Criar ESP para todos os jogadores
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player then
                Functions.createPlayerESP(otherPlayer)
            end
        end
        
        -- Conectar para novos jogadores
        connections.espPlayerAdded = Players.PlayerAdded:Connect(Functions.createPlayerESP)
        connections.espPlayerRemoving = Players.PlayerRemoving:Connect(Functions.removePlayerESP)
        
        print("👁️ ESP ativado!")
    else
        -- Remover ESP de todos os jogadores
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            Functions.removePlayerESP(otherPlayer)
        end
        
        if connections.espPlayerAdded then connections.espPlayerAdded:Disconnect() end
        if connections.espPlayerRemoving then connections.espPlayerRemoving:Disconnect() end
        
        print("👁️ ESP desativado!")
    end
end

function Functions.createPlayerESP(targetPlayer)
    if not targetPlayer or targetPlayer == player then return end
    
    local function addESPToCharacter(character)
        if not character then return end
        
        -- Remover ESP existente
        Functions.removePlayerESP(targetPlayer)
        
        -- Criar highlight
        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerESP"
        highlight.FillColor = Color3.fromRGB(255, 100, 100)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = character
        
        -- Criar nametag
        local head = character:FindFirstChild("Head")
        if head then
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "ESPNameTag"
            billboardGui.Size = UDim2.new(0, 200, 0, 50)
            billboardGui.StudsOffset = Vector3.new(0, 3, 0)
            billboardGui.Adornee = head
            billboardGui.Parent = head
            
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
        end
    end
    
    -- Adicionar ESP ao personagem atual
    if targetPlayer.Character then
        addESPToCharacter(targetPlayer.Character)
    end
    
    -- Conectar para quando o jogador respawnar
    if not connections["esp_" .. targetPlayer.Name] then
        connections["esp_" .. targetPlayer.Name] = targetPlayer.CharacterAdded:Connect(addESPToCharacter)
    end
end

function Functions.removePlayerESP(targetPlayer)
    if not targetPlayer then return end
    
    if targetPlayer.Character then
        local highlight = targetPlayer.Character:FindFirstChild("PlayerESP")
        if highlight then highlight:Destroy() end
        
        local head = targetPlayer.Character:FindFirstChild("Head")
        if head then
            local nameTag = head:FindFirstChild("ESPNameTag")
            if nameTag then nameTag:Destroy() end
        end
    end
    
    -- Desconectar connection do respawn
    local connectionName = "esp_" .. targetPlayer.Name
    if connections[connectionName] then
        connections[connectionName]:Disconnect()
        connections[connectionName] = nil
    end
end

function Functions.toggleESPBoxes(enabled)
    Functions.Visual.espBoxes = enabled
    print("📦 ESP Boxes:", enabled and "ON" or "OFF")
end

function Functions.toggleESPItems(enabled)
    Functions.Visual.espItems = enabled
    print("🎁 ESP Items:", enabled and "ON" or "OFF")
end

function Functions.toggleFullbright(enabled)
    Functions.Visual.fullbright = enabled
    
    if enabled then
        originalSettings.brightness = Lighting.Brightness
        originalSettings.clockTime = Lighting.ClockTime
        originalSettings.fogEnd = Lighting.FogEnd
        originalSettings.globalShadows = Lighting.GlobalShadows
        originalSettings.outdoorAmbient = Lighting.OutdoorAmbient
        
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        
        print("💡 Fullbright ativado!")
    else
        Lighting.Brightness = originalSettings.brightness or 1
        Lighting.ClockTime = originalSettings.clockTime or 12
        Lighting.FogEnd = originalSettings.fogEnd or 100000
        Lighting.GlobalShadows = originalSettings.globalShadows or true
        Lighting.OutdoorAmbient = originalSettings.outdoorAmbient or Color3.fromRGB(70, 70, 70)
        
        print("💡 Fullbright desativado!")
    end
end

function Functions.toggleRemoveFog(enabled)
    Functions.Visual.removeFog = enabled
    
    if enabled then
        Lighting.FogEnd = 100000
        print("🌫️ Fog removido!")
    else
        Lighting.FogEnd = originalSettings.fogEnd or 100000
        print("🌫️ Fog restaurado!")
    end
end

function Functions.toggleChams(enabled)
    Functions.Visual.chams = enabled
    print("✨ Chams:", enabled and "ON" or "OFF")
end

function Functions.setFOV(fov)
    Functions.Visual.fov = fov
    Camera.FieldOfView = fov
    print("🔍 FOV:", fov)
end

function Functions.setESPDistance(distance)
    Functions.Visual.espDistance = distance
    print("📏 ESP Distance:", distance)
end

-- ========================================
-- MISC FUNCTIONS
-- ========================================

Functions.Misc = {
    walkSpeed = 16,
    jumpPower = 50,
    infiniteJump = false,
    noClip = false,
    fly = false,
    flySpeed = 50
}

function Functions.setWalkSpeed(speed)
    Functions.Misc.walkSpeed = speed
    
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
    
    -- Manter velocidade para respawn
    if not connections.walkSpeed then
        connections.walkSpeed = player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").WalkSpeed = Functions.Misc.walkSpeed
        end)
    end
    
    print("🏃 Walk Speed:", speed)
end

function Functions.setJumpPower(power)
    Functions.Misc.jumpPower = power
    
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = power
    end
    
    -- Manter jump power para respawn
    if not connections.jumpPower then
        connections.jumpPower = player.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").JumpPower = Functions.Misc.jumpPower
        end)
    end
    
    print("🦘 Jump Power:", power)
end

function Functions.toggleInfiniteJump(enabled)
    Functions.Misc.infiniteJump = enabled
    
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

function Functions.toggleNoClip(enabled)
    Functions.Misc.noClip = enabled
    
    if enabled then
        connections.noClip = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
        print("👻 NoClip ativado!")
    else
        if connections.noClip then
            connections.noClip:Disconnect()
            connections.noClip = nil
        end
        
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        print("👻 NoClip desativado!")
    end
end

function Functions.toggleFly(enabled)
    Functions.Misc.fly = enabled
    
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
                    local moveVector = humanoid.MoveDirection * Functions.Misc.flySpeed
                    bodyVelocity.Velocity = Vector3.new(moveVector.X, 0, moveVector.Z)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, Functions.Misc.flySpeed, 0)
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, -Functions.Misc.flySpeed, 0)
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

function Functions.resetCharacter()
    if player.Character then
        player.Character:BreakJoints()
        print("🔄 Personagem resetado!")
    end
end

-- ========================================
-- CONFIG FUNCTIONS
-- ========================================

function Functions.saveConfig()
    local config = {
        aimbot = Functions.Aimbot,
        visual = Functions.Visual,
        misc = Functions.Misc
    }
    
    local success, result = pcall(function()
        writefile("roblox_menu_config.json", game:GetService("HttpService"):JSONEncode(config))
    end)
    
    if success then
        print("💾 Configuração salva!")
    else
        print("❌ Erro ao salvar configuração")
    end
end

function Functions.loadConfig()
    local success, result = pcall(function()
        if isfile("roblox_menu_config.json") then
            return game:GetService("HttpService"):JSONDecode(readfile("roblox_menu_config.json"))
        end
        return nil
    end)
    
    if success and result then
        Functions.Aimbot = result.aimbot or Functions.Aimbot
        Functions.Visual = result.visual or Functions.Visual
        Functions.Misc = result.misc or Functions.Misc
        print("📂 Configuração carregada!")
        return result
    else
        print("❌ Nenhuma configuração encontrada")
        return nil
    end
end

-- ========================================
-- CLEANUP FUNCTION
-- ========================================

function Functions.cleanup()
    -- Desconectar todas as conexões
    for name, connection in pairs(connections) do
        if connection then
            connection:Disconnect()
        end
    end
    connections = {}
    
    -- Restaurar configurações originais
    if originalSettings.brightness then
        Lighting.Brightness = originalSettings.brightness
        Lighting.ClockTime = originalSettings.clockTime
        Lighting.FogEnd = originalSettings.fogEnd
        Lighting.GlobalShadows = originalSettings.globalShadows
        Lighting.OutdoorAmbient = originalSettings.outdoorAmbient
    end
    
    -- Remover ESP de todos os jogadores
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        Functions.removePlayerESP(otherPlayer)
    end
    
    print("🧹 Cleanup completo!")
end

return Functions
