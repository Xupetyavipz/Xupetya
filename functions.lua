-- Evitar reload múltiplo
if _G.FunctionsLoaded and _G.Functions then
    print("♻️ Functions já carregado, retornando instância existente")
    return _G.Functions
end

print("🔄 Carregando Functions.lua...")

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local Functions = {}
print("📦 Functions table criado")

-- Marcar como carregado no início
_G.FunctionsLoaded = true
_G.Functions = Functions

-- Variáveis globais para controle
local connections = {}
local originalSettings = {}

-- ========================================
-- AIMBOT FUNCTIONS
-- ========================================
-- Configurações do Aimbot
Functions.Aimbot = {
    enabled = false,
    fov = 100,
    smoothness = 5,
    silentAim = false,
    triggerbot = false,
    targetVisible = true,
    teamCheck = true,
    activationMode = "Toggle", -- "Toggle", "Hold", "Always"
    activationKey = Enum.UserInputType.MouseButton2, -- RMB por padrão
    keyName = "RMB"
}

function Functions.toggleAimbot(enabled)
    Functions.Aimbot.enabled = enabled
    print("🎯 Aimbot function called:", enabled)
    
    if enabled then
        -- Configurar ativação baseada no modo
        if Functions.Aimbot.activationMode == "Always" then
            connections.aimbot = RunService.Heartbeat:Connect(function()
                Functions.performAimbot()
            end)
        elseif Functions.Aimbot.activationMode == "Hold" then
            connections.aimbotHold = UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Functions.Aimbot.activationKey then
                    connections.aimbot = RunService.Heartbeat:Connect(function()
                        Functions.performAimbot()
                    end)
                end
            end)
            connections.aimbotRelease = UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Functions.Aimbot.activationKey then
                    if connections.aimbot then
                        connections.aimbot:Disconnect()
                        connections.aimbot = nil
                    end
                end
            end)
        else -- Toggle mode
            connections.aimbotToggle = UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Functions.Aimbot.activationKey then
                    if connections.aimbot then
                        connections.aimbot:Disconnect()
                        connections.aimbot = nil
                        print("🎯 Aimbot desativado (toggle)")
                    else
                        connections.aimbot = RunService.Heartbeat:Connect(function()
                            Functions.performAimbot()
                        end)
                        print("🎯 Aimbot ativado (toggle)")
                    end
                end
            end)
        end
        print("🎯 Aimbot ativado! Modo:", Functions.Aimbot.activationMode, "Tecla:", Functions.Aimbot.keyName)
    else
        -- Desconectar todas as conexões do aimbot
        if connections.aimbot then connections.aimbot:Disconnect() connections.aimbot = nil end
        if connections.aimbotHold then connections.aimbotHold:Disconnect() connections.aimbotHold = nil end
        if connections.aimbotRelease then connections.aimbotRelease:Disconnect() connections.aimbotRelease = nil end
        if connections.aimbotToggle then connections.aimbotToggle:Disconnect() connections.aimbotToggle = nil end
        print("🎯 Aimbot desativado!")
    end
end

function Functions.performAimbot()
    if not Functions.Aimbot.enabled then return end
    
    local target = Functions.getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local targetPosition = target.Character.Head.Position
        
        if Functions.Aimbot.smoothness > 0 then
            -- Smooth aimbot
            local currentCFrame = Camera.CFrame
            local targetCFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
            Camera.CFrame = currentCFrame:Lerp(targetCFrame, 1 / Functions.Aimbot.smoothness)
        else
            -- Instant aimbot
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
        end
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

-- Função para ciclar entre modos de ativação
function Functions.cycleAimbotMode()
    local modes = {"Toggle", "Hold", "Always"}
    local currentIndex = 1
    for i, mode in ipairs(modes) do
        if mode == Functions.Aimbot.activationMode then
            currentIndex = i
            break
        end
    end
    local nextIndex = (currentIndex % #modes) + 1
    Functions.Aimbot.activationMode = modes[nextIndex]
    print("🎯 Aimbot Mode:", Functions.Aimbot.activationMode)
    
    -- Reativar aimbot se estiver ativo para aplicar novo modo
    if Functions.Aimbot.enabled then
        Functions.toggleAimbot(false)
        Functions.toggleAimbot(true)
    end
end

-- Função para definir tecla de ativação
function Functions.setAimbotKey()
    print("🔧 Pressione uma tecla para definir como ativação do aimbot...")
    
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        local keyName = ""
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            keyName = "LMB"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            keyName = "RMB"
        elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
            keyName = "MMB"
        elseif input.KeyCode ~= Enum.KeyCode.Unknown then
            keyName = input.KeyCode.Name
        else
            return
        end
        
        Functions.Aimbot.activationKey = input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType or input.KeyCode
        Functions.Aimbot.keyName = keyName
        print("🎯 Nova tecla de ativação:", keyName)
        
        -- Reativar aimbot se estiver ativo
        if Functions.Aimbot.enabled then
            Functions.toggleAimbot(false)
            Functions.toggleAimbot(true)
        end
        
        connection:Disconnect()
    end)
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
        print(" Triggerbot desativado!")
    end
end

function Functions.getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
            -- Team Check
            if Functions.Aimbot.teamCheck and targetPlayer.Team == player.Team then
                continue
            end
            
            local targetPosition = targetPlayer.Character.Head.Position
            local distance = (Camera.CFrame.Position - targetPosition).Magnitude
            
            -- Verificar FOV
            local screenPoint = Camera:WorldToViewportPoint(targetPosition)
            local centerX, centerY = Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2
            local fovDistance = math.sqrt((screenPoint.X - centerX)^2 + (screenPoint.Y - centerY)^2)
            
            if fovDistance <= Functions.Aimbot.fov and distance < shortestDistance then
                -- Verificar visibilidade se ativado
                if not Functions.Aimbot.targetVisible or Functions.isPlayerVisible(targetPlayer) then
                    closestPlayer = targetPlayer
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
    espNames = false,
    espSkeleton = false,
    espDistance = false,
    espChams = false,
    espHealth = false,
    espArmor = false,
    teamCheck = true,
    fullbright = false,
    fov = 90,
    maxDistance = 1000
}

-- ESP Individual Functions
function Functions.toggleESPNames(enabled)
    Functions.Visual.espNames = enabled
    Functions.updateAllESP()
    print("👁️ ESP Names:", enabled)
end

function Functions.toggleESPSkeleton(enabled)
    Functions.Visual.espSkeleton = enabled
    Functions.updateAllESP()
    print("🦴 ESP Skeleton:", enabled)
end

function Functions.toggleESPDistance(enabled)
    Functions.Visual.espDistance = enabled
    Functions.updateAllESP()
    print("📏 ESP Distance:", enabled)
end

function Functions.toggleESPChams(enabled)
    Functions.Visual.espChams = enabled
    Functions.updateAllESP()
    print("✨ ESP Chams:", enabled)
end

function Functions.toggleESPHealth(enabled)
    Functions.Visual.espHealth = enabled
    Functions.updateAllESP()
    print("❤️ ESP Health:", enabled)
end

function Functions.toggleESPArmor(enabled)
    Functions.Visual.espArmor = enabled
    Functions.updateAllESP()
    print("🛡️ ESP Armor:", enabled)
end

function Functions.updateAllESP()
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            Functions.createPlayerESP(otherPlayer)
        end
    end
end

function Functions.createPlayerESP(targetPlayer)
    if not targetPlayer or targetPlayer == player then return end
    
    local function addESPToCharacter(character)
        if not character then return end
        
        -- Team Check
        if Functions.Visual.teamCheck and targetPlayer.Team == player.Team then
            return
        end
        
        -- Distance Check
        local distance = 0
        if character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            distance = (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance > Functions.Visual.maxDistance then return end
        end
        
        -- Remover ESP existente
        Functions.removePlayerESP(targetPlayer)
        
        -- ESP Chams (Highlight)
        if Functions.Visual.espChams then
            local highlight = Instance.new("Highlight")
            highlight.Name = "PlayerESP"
            highlight.FillColor = Color3.fromRGB(255, 100, 100)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = character
        end
        
        -- ESP Names, Distance, Health, Armor
        local head = character:FindFirstChild("Head")
        if head and (Functions.Visual.espNames or Functions.Visual.espDistance or Functions.Visual.espHealth or Functions.Visual.espArmor) then
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "ESPInfo"
            billboardGui.Size = UDim2.new(0, 200, 0, 100)
            billboardGui.StudsOffset = Vector3.new(0, 3, 0)
            billboardGui.Adornee = head
            billboardGui.Parent = head
            
            local mainFrame = Instance.new("Frame")
            mainFrame.Size = UDim2.new(1, 0, 1, 0)
            mainFrame.BackgroundTransparency = 1
            mainFrame.Parent = billboardGui
            
            local layout = Instance.new("UIListLayout")
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            layout.Parent = mainFrame
            
            -- Nome
            if Functions.Visual.espNames then
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 0, 20)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = targetPlayer.Name
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.TextSize = 16
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.TextStrokeTransparency = 0
                nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                nameLabel.LayoutOrder = 1
                nameLabel.Parent = mainFrame
            end
            
            -- Distância
            if Functions.Visual.espDistance then
                local distanceLabel = Instance.new("TextLabel")
                distanceLabel.Size = UDim2.new(1, 0, 0, 16)
                distanceLabel.BackgroundTransparency = 1
                distanceLabel.Text = math.floor(distance) .. "m"
                distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                distanceLabel.TextSize = 14
                distanceLabel.Font = Enum.Font.Gotham
                distanceLabel.TextStrokeTransparency = 0
                distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                distanceLabel.LayoutOrder = 2
                distanceLabel.Parent = mainFrame
            end
            
            -- Vida
            if Functions.Visual.espHealth then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    local healthLabel = Instance.new("TextLabel")
                    healthLabel.Size = UDim2.new(1, 0, 0, 16)
                    healthLabel.BackgroundTransparency = 1
                    healthLabel.Text = "HP: " .. math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
                    healthLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                    healthLabel.TextSize = 12
                    healthLabel.Font = Enum.Font.Gotham
                    healthLabel.TextStrokeTransparency = 0
                    healthLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    healthLabel.LayoutOrder = 3
                    healthLabel.Parent = mainFrame
                end
            end
            
            -- Colete (simulado)
            if Functions.Visual.espArmor then
                local armorLabel = Instance.new("TextLabel")
                armorLabel.Size = UDim2.new(1, 0, 0, 16)
                armorLabel.BackgroundTransparency = 1
                armorLabel.Text = "Armor: 100/100"
                armorLabel.TextColor3 = Color3.fromRGB(100, 100, 255)
                armorLabel.TextSize = 12
                armorLabel.Font = Enum.Font.Gotham
                armorLabel.TextStrokeTransparency = 0
                armorLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                armorLabel.LayoutOrder = 4
                armorLabel.Parent = mainFrame
            end
        end
        
        -- ESP Skeleton
        if Functions.Visual.espSkeleton then
            Functions.createSkeletonESP(character)
        end
    end
    
    -- Add ESP to current character
    if targetPlayer.Character then
        addESPToCharacter(targetPlayer.Character)
    end
    
    -- Connect for respawn
    if not connections["esp_" .. targetPlayer.Name] then
        connections["esp_" .. targetPlayer.Name] = targetPlayer.CharacterAdded:Connect(addESPToCharacter)
    end
end

function Functions.createSkeletonESP(character)
    if not character then return end
    
    local function createLine(part1, part2, name)
        if not part1 or not part2 then return end
        
        local attachment1 = Instance.new("Attachment")
        attachment1.Parent = part1
        
        local attachment2 = Instance.new("Attachment")
        attachment2.Parent = part2
        
        local beam = Instance.new("Beam")
        beam.Name = "SkeletonESP_" .. name
        beam.Attachment0 = attachment1
        beam.Attachment1 = attachment2
        beam.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        beam.Width0 = 0.1
        beam.Width1 = 0.1
        beam.Parent = part1
    end
    
    -- Conectar partes do corpo
    local head = character:FindFirstChild("Head")
    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
    local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
    local leftLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftUpperLeg")
    local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")
    
    if torso then
        if head then createLine(head, torso, "HeadTorso") end
        if leftArm then createLine(torso, leftArm, "TorsoLeftArm") end
        if rightArm then createLine(torso, rightArm, "TorsoRightArm") end
        if leftLeg then createLine(torso, leftLeg, "TorsoLeftLeg") end
        if rightLeg then createLine(torso, rightLeg, "TorsoRightLeg") end
    end
end

function Functions.removePlayerESP(targetPlayer)
    if not targetPlayer then return end
    
    if targetPlayer.Character then
        -- Remove highlight
        local highlight = targetPlayer.Character:FindFirstChild("PlayerESP")
        if highlight then highlight:Destroy() end
        
        -- Remove info GUI
        local head = targetPlayer.Character:FindFirstChild("Head")
        if head then
            local infoGui = head:FindFirstChild("ESPInfo")
            if infoGui then infoGui:Destroy() end
        end
        
        -- Remove skeleton ESP
        for _, part in pairs(targetPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                for _, child in pairs(part:GetChildren()) do
                    if child:IsA("Beam") and child.Name:find("SkeletonESP") then
                        child:Destroy()
                    end
                    if child:IsA("Attachment") and child.Parent == part then
                        child:Destroy()
                    end
                end
            end
        end
    end
    
    -- Disconnect connection
    if connections["esp_" .. targetPlayer.Name] then
        connections["esp_" .. targetPlayer.Name]:Disconnect()
        connections["esp_" .. targetPlayer.Name] = nil
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
    Functions.Visual.maxDistance = distance
    Functions.updateAllESP()
    print("📏 ESP Distance set to:", distance)
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

print("✅ Functions.lua carregado completamente!")
print("🔧 Funções disponíveis:", Functions.toggleAimbot and "toggleAimbot ✓" or "toggleAimbot ❌")
return Functions
