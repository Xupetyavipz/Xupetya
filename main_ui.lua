-- Roblox Cheat UI - Menu Simples
-- Cores: Roxo e Preto com personalização de foto do usuário

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variáveis globais
local currentUserImage = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
local mainFrame = nil
local isUIVisible = false

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
    
    -- Status
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0, 200, 0, 20)
    status.Position = UDim2.new(0, 80, 0, 40)
    status.BackgroundTransparency = 1
    status.Text = "✅ Cheat Ativo"
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
        toggleUI()
    end
end)

-- Inicializar
createNotification("🎮 Cheat Carregado", "Pressione INSERT para abrir o menu!", COLORS.ACCENT)
createMainUI()
