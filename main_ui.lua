-- UI Completa para Roblox
-- Sistema de Menu Moderno

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Carregar Functions (apenas uma vez)
if not _G.FunctionsLoaded then
    print("🔄 Carregando Functions...")
    local Functions
    pcall(function()
        Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/Xupetyavipz/Xupetya/refs/heads/main/functions.lua"))()
    end)
    print("✅ Functions carregado:", Functions and "SUCCESS" or "FAILED")
    _G.Functions = Functions
    _G.FunctionsLoaded = true
else
    print("♻️ Usando Functions já carregado")
end
local Functions = _G.Functions

-- Fallback se Functions não carregar
if not Functions then
    print("❌ Erro ao carregar Functions, usando fallback...")
    Functions = {
        toggleAimbot = function(enabled) print("Aimbot:", enabled) end,
        toggleESP = function(enabled) print("ESP:", enabled) end,
        setWalkSpeed = function(speed) 
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
            end
        end,
        setJumpPower = function(power)
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = power
            end
        end,
        cleanup = function() print("Cleanup executado") end
    }
end

-- Configurações
local config = {
    menuKey = Enum.KeyCode.Insert,
    menuVisible = false,
    currentTab = "Home",
    settings = {
        aimbot = false,
        esp = false,
        speed = 16,
        jumpPower = 50,
        fov = 90
    }
}

-- Criar ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame principal do menu
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Adicionar cantos arredondados
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Sombra do menu
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.BorderSizePixel = 0
shadow.ZIndex = mainFrame.ZIndex - 1
shadow.Parent = mainFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- Header do menu
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Logo
local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(0, 40, 0, 40)
logo.Position = UDim2.new(0, 10, 0, 5)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://70651953090646"
logo.ScaleType = Enum.ScaleType.Fit
logo.Parent = header

-- Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 180, 1, 0)
title.Position = UDim2.new(0, 55, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Advanced Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.Parent = header

-- Botão fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 6)
closeBtnCorner.Parent = closeBtn

-- Sistema de abas
local tabContainer = Instance.new("Frame")
tabContainer.Name = "TabContainer"
tabContainer.Size = UDim2.new(0, 150, 1, -50)
tabContainer.Position = UDim2.new(0, 0, 0, 50)
tabContainer.BackgroundColor3 = Color3.fromRGB(20, 15, 25)
tabContainer.BorderSizePixel = 0
tabContainer.Parent = mainFrame

-- Lista de abas
local tabList = Instance.new("UIListLayout")
tabList.SortOrder = Enum.SortOrder.LayoutOrder
tabList.Padding = UDim.new(0, 2)
tabList.Parent = tabContainer

-- Conteúdo das abas
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -150, 1, -50)
contentFrame.Position = UDim2.new(0, 150, 0, 50)
contentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- Scroll para conteúdo
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -20, 1, -20)
scrollFrame.Position = UDim2.new(0, 10, 0, 10)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
scrollFrame.Parent = contentFrame

local contentList = Instance.new("UIListLayout")
contentList.SortOrder = Enum.SortOrder.LayoutOrder
contentList.Padding = UDim.new(0, 10)
contentList.Parent = scrollFrame

-- Função para criar abas
local function createTab(name, icon)
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(1, -10, 0, 40)
    tab.Position = UDim2.new(0, 5, 0, 0)
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tab.Text = icon .. " " .. name
    tab.TextColor3 = Color3.fromRGB(200, 200, 200)
    tab.TextSize = 14
    tab.Font = Enum.Font.Gotham
    tab.BorderSizePixel = 0
    tab.Parent = tabContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tab
    
    return tab
end

-- Criar abas com ícones personalizados
local function createTabWithIcon(name, iconId)
    local tab = Instance.new("Frame")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(1, -10, 0, 50)
    tab.Position = UDim2.new(0, 5, 0, 0)
    tab.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
    tab.BorderSizePixel = 0
    tab.Parent = tabContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tab
    
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.Position = UDim2.new(0, 10, 0.5, -12)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://" .. iconId
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Parent = tab
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -45, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(180, 160, 200)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = tab
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = tab
    
    return button, tab
end

-- Criar abas
local tabs = {}
local tabFrames = {}
local aimbotTab, aimbotFrame = createTabWithIcon("Aimbot", "75518636799674")
local visualTab, visualFrame = createTabWithIcon("Visual", "111612200954692") 
local miscTab, miscFrame = createTabWithIcon("Misc", "118260954915004")

tabs = {aimbotTab, visualTab, miscTab}
tabFrames = {aimbotFrame, visualFrame, miscFrame}

-- Função para criar elementos de UI
local function createElement(type, text, parent, callback, minValue, maxValue, defaultValue)
    local element = Instance.new("Frame")
    element.Size = UDim2.new(1, -20, 0, 35)
    element.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
    element.BorderSizePixel = 0
    element.Parent = parent
    
    local elementCorner = Instance.new("UICorner")
    elementCorner.CornerRadius = UDim.new(0, 6)
    elementCorner.Parent = element
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = element
    
    if type == "toggle" then
        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(0, 50, 0, 20)
        toggle.Position = UDim2.new(1, -60, 0.5, -10)
        toggle.BackgroundColor3 = Color3.fromRGB(120, 60, 140)
        toggle.Text = "OFF"
        toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggle.TextSize = 12
        toggle.Font = Enum.Font.GothamBold
        toggle.BorderSizePixel = 0
        toggle.Parent = element
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 10)
        toggleCorner.Parent = toggle
        
        local isEnabled = false
        toggle.MouseButton1Click:Connect(function()
            isEnabled = not isEnabled
            toggle.Text = isEnabled and "ON" or "OFF"
            toggle.BackgroundColor3 = isEnabled and Color3.fromRGB(140, 100, 200) or Color3.fromRGB(120, 60, 140)
            if callback then callback(isEnabled) end
        end)
        
    elseif type == "slider" then
        minValue = minValue or 0
        maxValue = maxValue or 100
        defaultValue = defaultValue or minValue
        
        local currentValue = defaultValue
        
        local slider = Instance.new("Frame")
        slider.Size = UDim2.new(0, 100, 0, 6)
        slider.Position = UDim2.new(1, -110, 0.5, -3)
        slider.BackgroundColor3 = Color3.fromRGB(50, 40, 60)
        slider.BorderSizePixel = 0
        slider.Parent = element
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 3)
        sliderCorner.Parent = slider
        
        local handle = Instance.new("Frame")
        handle.Size = UDim2.new(0, 12, 0, 12)
        handle.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -6, 0.5, -6)
        handle.BackgroundColor3 = Color3.fromRGB(160, 120, 200)
        handle.BorderSizePixel = 0
        handle.Parent = slider
        
        local handleCorner = Instance.new("UICorner")
        handleCorner.CornerRadius = UDim.new(0, 6)
        handleCorner.Parent = handle
        
        -- Atualizar texto inicial
        label.Text = text:gsub("%d+", tostring(currentValue))
        
        -- Sistema de drag funcional
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
                local relativePos = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                currentValue = math.floor(minValue + (maxValue - minValue) * relativePos)
                
                handle.Position = UDim2.new(relativePos, -6, 0.5, -6)
                label.Text = text:gsub("%d+", tostring(currentValue))
                
                if callback then
                    callback(currentValue)
                end
            end
        end)
        
    elseif type == "button" then
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 80, 0, 25)
        button.Position = UDim2.new(1, -90, 0.5, -12.5)
        button.BackgroundColor3 = Color3.fromRGB(140, 100, 200)
        button.Text = "Execute"
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 12
        button.Font = Enum.Font.Gotham
        button.BorderSizePixel = 0
        button.Parent = element
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 4)
        buttonCorner.Parent = button
        
        if callback then
            button.MouseButton1Click:Connect(callback)
        end
    end
    
    return element
end

-- Função para mostrar conteúdo da aba
local function showTabContent(tabName)
    -- Limpar conteúdo anterior
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    config.currentTab = tabName
    
    -- Atualizar aparência das abas
    for i, tabFrame in pairs(tabFrames) do
        if tabFrame.Name == tabName .. "Tab" then
            tabFrame.BackgroundColor3 = Color3.fromRGB(140, 100, 200)
            tabFrame:FindFirstChild("TextLabel").TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            tabFrame.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
            tabFrame:FindFirstChild("TextLabel").TextColor3 = Color3.fromRGB(180, 160, 200)
        end
    end
    
    -- Conteúdo específico de cada aba
    if tabName == "Aimbot" then
        createElement("toggle", "Enable Aimbot", scrollFrame, function(enabled)
            print("🔧 UI Toggle clicked - Aimbot:", enabled)
            if Functions and Functions.toggleAimbot then
                Functions.toggleAimbot(enabled)
            else
                print("❌ Functions.toggleAimbot not found!")
            end
        end)
        createElement("slider", "Aimbot FOV: 100", scrollFrame, function(value)
            if Functions and Functions.setAimbotFOV then Functions.setAimbotFOV(value) end
        end, 50, 360, 100)
        createElement("slider", "Smoothness: 5", scrollFrame, function(value)
            if Functions and Functions.setAimbotSmoothness then Functions.setAimbotSmoothness(value) end
        end, 1, 20, 5)
        createElement("toggle", "Silent Aim", scrollFrame, Functions.toggleSilentAim)
        createElement("toggle", "Triggerbot", scrollFrame, Functions.toggleTriggerbot)
        createElement("toggle", "Team Check", scrollFrame, function(enabled)
            if Functions then Functions.Aimbot.teamCheck = enabled end
        end)
        createElement("toggle", "Target Visible Only", scrollFrame, function(enabled)
            if Functions then Functions.Aimbot.targetVisible = enabled end
        end)
        
        -- Modo de ativação do Aimbot
        createElement("button", "Mode: Toggle", scrollFrame, function()
            -- Ciclar entre modos: Toggle -> Hold -> Always
            local modes = {"Toggle", "Hold", "Always"}
            local currentMode = Functions and Functions.Aimbot.activationMode or "Toggle"
            local currentIndex = 1
            for i, mode in ipairs(modes) do
                if mode == currentMode then currentIndex = i break end
            end
            local nextIndex = (currentIndex % #modes) + 1
            local newMode = modes[nextIndex]
            
            if Functions then Functions.Aimbot.activationMode = newMode end
            print("🎯 Aimbot Mode:", newMode)
        end)
        
    elseif tabName == "Visual" then
        createElement("toggle", "ESP Names", scrollFrame, function(enabled)
            if Functions and Functions.toggleESPNames then Functions.toggleESPNames(enabled) end
        end)
        createElement("toggle", "ESP Skeleton", scrollFrame, function(enabled)
            if Functions and Functions.toggleESPSkeleton then Functions.toggleESPSkeleton(enabled) end
        end)
        createElement("toggle", "ESP Distance", scrollFrame, function(enabled)
            if Functions and Functions.toggleESPDistance then Functions.toggleESPDistance(enabled) end
        end)
        createElement("toggle", "ESP Chams", scrollFrame, function(enabled)
            if Functions and Functions.toggleESPChams then Functions.toggleESPChams(enabled) end
        end)
        createElement("toggle", "ESP Health", scrollFrame, function(enabled)
            if Functions and Functions.toggleESPHealth then Functions.toggleESPHealth(enabled) end
        end)
        createElement("toggle", "ESP Armor", scrollFrame, function(enabled)
            if Functions and Functions.toggleESPArmor then Functions.toggleESPArmor(enabled) end
        end)
        createElement("toggle", "Team Check", scrollFrame, function(enabled)
            if Functions then Functions.Visual.teamCheck = enabled end
        end)
        createElement("slider", "ESP Distance: 1000", scrollFrame, function(value)
            if Functions and Functions.setESPDistance then Functions.setESPDistance(value) end
        end, 100, 5000, 1000)
        createElement("slider", "FOV: 90", scrollFrame, function(value)
            if Functions and Functions.setFOV then Functions.setFOV(value) end
        end, 60, 120, 90)
        createElement("toggle", "Fullbright", scrollFrame, Functions.toggleFullbright)
        
    elseif tabName == "Misc" then
        createElement("slider", "Walk Speed: 16", scrollFrame, function(value)
            if Functions and Functions.setWalkSpeed then Functions.setWalkSpeed(value) end
        end, 16, 100, 16)
        createElement("slider", "Jump Power: 50", scrollFrame, function(value)
            if Functions and Functions.setJumpPower then Functions.setJumpPower(value) end
        end, 50, 200, 50)
        createElement("toggle", "Infinite Jump", scrollFrame, Functions.toggleInfiniteJump)
        createElement("toggle", "No Clip", scrollFrame, Functions.toggleNoClip)
        createElement("toggle", "Fly", scrollFrame, Functions.toggleFly)
        createElement("button", "Reset Character", scrollFrame, Functions.resetCharacter)
        createElement("button", "Save Config", scrollFrame, Functions.saveConfig)
        createElement("button", "Load Config", scrollFrame, Functions.loadConfig)
        createElement("button", "Unload Script", scrollFrame, function()
            Functions.cleanup()
            screenGui:Destroy()
        end)
    end
    
    -- Atualizar tamanho do scroll
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
end

-- Conectar eventos das abas
for i, tab in pairs(tabs) do
    tab.MouseButton1Click:Connect(function()
        local tabNames = {"Aimbot", "Visual", "Misc"}
        showTabContent(tabNames[i])
    end)
end

-- Sistema de drag and drop
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

-- Cursor personalizado
local customCursor = Instance.new("ImageLabel")
customCursor.Name = "CustomCursor"
customCursor.Size = UDim2.new(0, 32, 0, 32)
customCursor.BackgroundTransparency = 1
customCursor.Image = "rbxassetid://140428895475044"
customCursor.ScaleType = Enum.ScaleType.Fit
customCursor.ZIndex = 1000
customCursor.Visible = false
customCursor.Parent = screenGui

-- Função para toggle do menu
local function toggleMenu()
    config.menuVisible = not config.menuVisible
    
    local targetPos = config.menuVisible and UDim2.new(0.5, -300, 0.5, -200) or UDim2.new(0.5, -300, -1, -200)
    local targetTransparency = config.menuVisible and 0 or 1
    
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        Position = targetPos
    })
    
    tween:Play()
    mainFrame.Visible = config.menuVisible
    customCursor.Visible = config.menuVisible
    
    -- Controlar cursor padrão
    UserInputService.MouseIconEnabled = not config.menuVisible
    
    if config.menuVisible then
        showTabContent("Aimbot")
    end
end

-- Atualizar posição do cursor personalizado
local cursorConnection
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and config.menuVisible then
        customCursor.Position = UDim2.new(0, input.Position.X - 16, 0, input.Position.Y - 16)
    end
end)

-- Eventos
closeBtn.MouseButton1Click:Connect(toggleMenu)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == config.menuKey then
        toggleMenu()
    end
end)

-- Inicializar
showTabContent("Aimbot")

print("✅ UI Completa carregada! Pressione INSERT para abrir/fechar o menu.")
