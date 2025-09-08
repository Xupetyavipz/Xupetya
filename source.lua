-- ╔══════════════════════════════════════════════════════════════╗
-- ║                    ROBLOX CHEAT UI - FiveM Style             ║
-- ║                      Advanced Multi-Category                 ║
-- ╚══════════════════════════════════════════════════════════════╝





-- Script totalmente independente - sem dependências externas

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mouse = player:GetMouse()

-- Evitar reload múltiplo
if _G.CheatUILoaded then
    if _G.CheatUI then _G.CheatUI:Destroy() end
    _G.CheatUILoaded = false
end

-- ═══════════════════════════════════════════════════════════════
-- 🔧 FUNÇÕES INTEGRADAS DO CHEAT
-- ═══════════════════════════════════════════════════════════════

local Functions = {}
local connections = {}

-- FPS Functions
function Functions.toggleAimbot(enabled)
    if enabled then
        print("🎯 Aimbot ativado")
        -- Implementar aimbot aqui
    else
        print("🎯 Aimbot desativado")
    end
end

function Functions.setAimbotFOV(value)
    print("🎯 Aimbot FOV definido para:", value)
end

function Functions.setAimbotSmoothness(value)
    print("🎯 Aimbot Smoothness definido para:", value)
end

function Functions.toggleSilentAim(enabled)
    print("🔇 Silent Aim:", enabled and "ON" or "OFF")
end

function Functions.toggleTriggerbot(enabled)
    print("🔫 Triggerbot:", enabled and "ON" or "OFF")
end

-- Visual Functions
function Functions.toggleBoxESP(enabled)
    print("📦 Box ESP:", enabled and "ON" or "OFF")
end

function Functions.toggleNameESP(enabled)
    print("📝 Name ESP:", enabled and "ON" or "OFF")
end

function Functions.toggleTracers(enabled)
    print("📍 Tracers:", enabled and "ON" or "OFF")
end

function Functions.toggleFullbright(enabled)
    if enabled then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
    end
    print("💡 Fullbright:", enabled and "ON" or "OFF")
end

-- Movement Functions
function Functions.toggleSuperSpeed(enabled, speed)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = enabled and speed or 16
    end
    print("🏃 Super Speed:", enabled and "ON" or "OFF")
end

function Functions.toggleSuperJump(enabled, power)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = enabled and power or 50
    end
    print("🦘 Super Jump:", enabled and "ON" or "OFF")
end

function Functions.toggleFly(enabled)
    if enabled then
        -- Implementar fly básico
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            bodyVelocity.Parent = player.Character.HumanoidRootPart
        end
    end
    print("🛸 Fly:", enabled and "ON" or "OFF")
end

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
    else
        if connections.noclip then
            connections.noclip:Disconnect()
            connections.noclip = nil
        end
    end
    print("👻 Noclip:", enabled and "ON" or "OFF")
end

-- Exportar para escopo global
_G.CheatFunctions = Functions

-- ═══════════════════════════════════════════════════════════════
-- 🎨 CONFIGURAÇÕES DE TEMA E CORES
-- ═══════════════════════════════════════════════════════════════
local Theme = {
    -- Cores principais
    Background = Color3.fromRGB(18, 18, 23),
    Secondary = Color3.fromRGB(25, 25, 32),
    Accent = Color3.fromRGB(88, 101, 242), -- Discord Blurple
    AccentHover = Color3.fromRGB(71, 82, 196),
    
    -- Cores de texto
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(181, 186, 193),
    TextMuted = Color3.fromRGB(114, 118, 125),
    
    -- Cores de status
    Success = Color3.fromRGB(67, 181, 129),
    Warning = Color3.fromRGB(250, 166, 26),
    Error = Color3.fromRGB(237, 66, 69),
    
    -- Cores das categorias
    FPS = Color3.fromRGB(255, 92, 92),      -- Vermelho
    Visual = Color3.fromRGB(92, 184, 255),   -- Azul
    Misc = Color3.fromRGB(255, 184, 92),     -- Laranja
    RP = Color3.fromRGB(184, 255, 92),       -- Verde
    Troll = Color3.fromRGB(184, 92, 255),    -- Roxo
}

-- ═══════════════════════════════════════════════════════════════
-- 📊 CONFIGURAÇÕES GLOBAIS
-- ═══════════════════════════════════════════════════════════════
local Config = {
    menuKey = Enum.KeyCode.Insert,
    menuVisible = false,
    currentCategory = "FPS",
    windowSize = UDim2.new(0, 900, 0, 600),
    
    -- Estados das funcionalidades
    FPS = {
        aimbot = false,
        silentAim = false,
        triggerbot = false,
        noRecoil = false,
        rapidFire = false,
        infiniteAmmo = false,
        wallbang = false,
        bulletTracers = false,
        hitboxExpander = false,
        killAura = false,
        oneTap = false,
        
        -- Configurações
        aimbotFOV = 100,
        aimbotSmooth = 5,
        targetBone = "Head",
        prediction = 0.1,
        gunDamage = 100,
        fireRate = 1,
    },
    
    Visual = {
        boxESP = false,
        skeletonESP = false,
        nameESP = false,
        distanceESP = false,
        healthESP = false,
        armorESP = false,
        tracers = false,
        radar = false,
        itemESP = false,
        vehicleESP = false,
        chams = false,
        fullbright = false,
        crosshair = false,
        
        -- Configurações
        espDistance = 1000,
        fov = 90,
        crosshairSize = 10,
        crosshairColor = Color3.fromRGB(255, 0, 0),
    },
    
    Misc = {
        walkSpeed = false,
        jumpPower = false,
        fly = false,
        noclip = false,
        infiniteJump = false,
        autoFarm = false,
        autoCollect = false,
        noFallDamage = false,
        infiniteStamina = false,
        antiAFK = false,
        
        -- Configurações
        speedValue = 50,
        jumpValue = 100,
        flySpeed = 50,
    },
    
    RP = {
        weaponSpawner = false,
        vehicleSpawner = false,
        objectSpawner = false,
        avatarChanger = false,
        animationPlayer = false,
        fakeMoney = false,
        
        -- Configurações
        selectedWeapon = "AK47",
        selectedVehicle = "Lambo",
        moneyAmount = 999999,
    },
    
    Troll = {
        soundSpam = false,
        screenShaker = false,
        freezePlayer = false,
        flingAll = false,
        ragdollAll = false,
        loopKill = false,
        blindEffect = false,
        serverCrasher = false,
        
        -- Configurações
        selectedTarget = nil,
        trollIntensity = 5,
    }
}

-- ═══════════════════════════════════════════════════════════════
-- 🏗️ CRIAÇÃO DA UI PRINCIPAL
-- ═══════════════════════════════════════════════════════════════

-- ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CheatUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_G.CheatUI = screenGui

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = Config.windowSize
mainFrame.Position = UDim2.new(0.5, -450, 0.5, -300)
mainFrame.BackgroundColor3 = Theme.Background
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Cantos arredondados
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Sombra
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.8
shadow.BorderSizePixel = 0
shadow.ZIndex = mainFrame.ZIndex - 1
shadow.Parent = mainFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- ═══════════════════════════════════════════════════════════════
-- 📋 HEADER COM TÍTULO E CONTROLES
-- ═══════════════════════════════════════════════════════════════

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Theme.Secondary
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Logo
local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(0, 40, 0, 40)
logo.Position = UDim2.new(0, 15, 0, 10)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://70651953090646"
logo.ScaleType = Enum.ScaleType.Fit
logo.Parent = header

-- Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 300, 1, 0)
title.Position = UDim2.new(0, 65, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ROBLOX CHEAT v2.0"
title.TextColor3 = Theme.TextPrimary
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.Parent = header

-- Subtítulo
local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Size = UDim2.new(0, 300, 0, 15)
subtitle.Position = UDim2.new(0, 65, 0, 35)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Advanced Multi-Category System"
subtitle.TextColor3 = Theme.TextSecondary
subtitle.TextSize = 12
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = header

-- Botão minimizar
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeButton"
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -75, 0, 15)
minimizeBtn.BackgroundColor3 = Theme.Warning
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Theme.TextPrimary
minimizeBtn.TextSize = 18
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeBtn

-- Botão fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 15)
closeBtn.BackgroundColor3 = Theme.Error
closeBtn.Text = "×"
closeBtn.TextColor3 = Theme.TextPrimary
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- ═══════════════════════════════════════════════════════════════
-- 🗂️ SISTEMA DE CATEGORIAS (SIDEBAR)
-- ═══════════════════════════════════════════════════════════════

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 200, 1, -60)
sidebar.Position = UDim2.new(0, 0, 0, 60)
sidebar.BackgroundColor3 = Theme.Secondary
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

-- Lista de categorias
local categoryList = Instance.new("UIListLayout")
categoryList.SortOrder = Enum.SortOrder.LayoutOrder
categoryList.Padding = UDim.new(0, 5)
categoryList.Parent = sidebar

-- Padding da sidebar
local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 10)
sidebarPadding.PaddingLeft = UDim.new(0, 10)
sidebarPadding.PaddingRight = UDim.new(0, 10)
sidebarPadding.Parent = sidebar

-- ═══════════════════════════════════════════════════════════════
-- 📄 ÁREA DE CONTEÚDO
-- ═══════════════════════════════════════════════════════════════

local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -200, 1, -60)
contentArea.Position = UDim2.new(0, 200, 0, 60)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.Parent = mainFrame

-- ScrollingFrame para conteúdo
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -20, 1, -20)
scrollFrame.Position = UDim2.new(0, 10, 0, 10)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Theme.Accent
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = contentArea

-- Layout do conteúdo
local contentLayout = Instance.new("UIListLayout")
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 10)
contentLayout.Parent = scrollFrame

-- ═══════════════════════════════════════════════════════════════
-- 🛠️ FUNÇÕES DE CRIAÇÃO DE ELEMENTOS
-- ═══════════════════════════════════════════════════════════════

-- Função para criar categoria na sidebar
local function createCategory(name, icon, color, order)
    local categoryBtn = Instance.new("TextButton")
    categoryBtn.Name = name .. "Category"
    categoryBtn.Size = UDim2.new(1, 0, 0, 45)
    categoryBtn.BackgroundColor3 = name == Config.currentCategory and color or Theme.Background
    categoryBtn.BorderSizePixel = 0
    categoryBtn.Text = ""
    categoryBtn.LayoutOrder = order
    categoryBtn.Parent = sidebar
    
    local categoryCorner = Instance.new("UICorner")
    categoryCorner.CornerRadius = UDim.new(0, 8)
    categoryCorner.Parent = categoryBtn
    
    -- Ícone
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 30, 1, 0)
    iconLabel.Position = UDim2.new(0, 10, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Theme.TextPrimary
    iconLabel.TextSize = 18
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = categoryBtn
    
    -- Nome da categoria
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -50, 1, 0)
    nameLabel.Position = UDim2.new(0, 45, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Theme.TextPrimary
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = categoryBtn
    
    return categoryBtn
end

-- Função para criar seção
local function createSection(title)
    local section = Instance.new("Frame")
    section.Name = title .. "Section"
    section.Size = UDim2.new(1, 0, 0, 40)
    section.BackgroundColor3 = Theme.Secondary
    section.BorderSizePixel = 0
    section.Parent = scrollFrame
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 8)
    sectionCorner.Parent = section
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Size = UDim2.new(1, -20, 1, 0)
    sectionTitle.Position = UDim2.new(0, 15, 0, 0)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = "▼ " .. title
    sectionTitle.TextColor3 = Theme.TextPrimary
    sectionTitle.TextSize = 16
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = section
    
    return section
end

-- Função para criar toggle
local function createToggle(text, callback, defaultState)
    local toggle = Instance.new("Frame")
    toggle.Name = text .. "Toggle"
    toggle.Size = UDim2.new(1, 0, 0, 35)
    toggle.BackgroundColor3 = Theme.Background
    toggle.BorderSizePixel = 0
    toggle.Parent = scrollFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle
    
    -- Label do toggle
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.TextPrimary
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggle
    
    -- Switch do toggle
    local switch = Instance.new("TextButton")
    switch.Size = UDim2.new(0, 50, 0, 20)
    switch.Position = UDim2.new(1, -65, 0.5, -10)
    switch.BackgroundColor3 = defaultState and Theme.Success or Theme.TextMuted
    switch.BorderSizePixel = 0
    switch.Text = ""
    switch.Parent = toggle
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(0, 10)
    switchCorner.Parent = switch
    
    -- Bolinha do switch
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = defaultState and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Theme.TextPrimary
    knob.BorderSizePixel = 0
    knob.Parent = switch
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 8)
    knobCorner.Parent = knob
    
    -- Estado atual
    local isEnabled = defaultState or false
    
    -- Evento de clique
    switch.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        
        -- Animação do switch
        local switchTween = TweenService:Create(switch, TweenInfo.new(0.2), {
            BackgroundColor3 = isEnabled and Theme.Success or Theme.TextMuted
        })
        
        local knobTween = TweenService:Create(knob, TweenInfo.new(0.2), {
            Position = isEnabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        })
        
        switchTween:Play()
        knobTween:Play()
        
        -- Callback
        if callback then
            callback(isEnabled)
        end
    end)
    
    return toggle
end

-- Função para criar slider
local function createSlider(text, min, max, default, callback)
    local slider = Instance.new("Frame")
    slider.Name = text .. "Slider"
    slider.Size = UDim2.new(1, 0, 0, 50)
    slider.BackgroundColor3 = Theme.Background
    slider.BorderSizePixel = 0
    slider.Parent = scrollFrame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 6)
    sliderCorner.Parent = slider
    
    -- Label do slider
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 15, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Theme.TextPrimary
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = slider
    
    -- Track do slider
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -30, 0, 6)
    track.Position = UDim2.new(0, 15, 0, 30)
    track.BackgroundColor3 = Theme.TextMuted
    track.BorderSizePixel = 0
    track.Parent = slider
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 3)
    trackCorner.Parent = track
    
    -- Fill do slider
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.Position = UDim2.new(0, 0, 0, 0)
    fill.BackgroundColor3 = Theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = track
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = fill
    
    -- Handle do slider
    local handle = Instance.new("TextButton")
    handle.Size = UDim2.new(0, 16, 0, 16)
    handle.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    handle.BackgroundColor3 = Theme.TextPrimary
    handle.BorderSizePixel = 0
    handle.Text = ""
    handle.Parent = track
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0, 8)
    handleCorner.Parent = handle
    
    -- Valor atual
    local currentValue = default
    
    -- Sistema de drag
    local dragging = false
    
    local function updateSlider(inputPos)
        local relativeX = math.clamp((inputPos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        currentValue = math.floor(min + (max - min) * relativeX)
        
        fill.Size = UDim2.new(relativeX, 0, 1, 0)
        handle.Position = UDim2.new(relativeX, -8, 0.5, -8)
        label.Text = text .. ": " .. currentValue
        
        if callback then
            callback(currentValue)
        end
    end
    
    handle.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    track.MouseButton1Down:Connect(function()
        updateSlider(mouse.Hit.Position)
    end)
    
    return slider
end

-- Função para criar botão
local function createButton(text, callback)
    local button = Instance.new("TextButton")
    button.Name = text .. "Button"
    button.Size = UDim2.new(1, 0, 0, 35)
    button.BackgroundColor3 = Theme.Accent
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Theme.TextPrimary
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Theme.AccentHover
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Theme.Accent
        })
        tween:Play()
    end)
    
    -- Click event
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return button
end

-- ═══════════════════════════════════════════════════════════════
-- 📂 CRIAÇÃO DAS CATEGORIAS
-- ═══════════════════════════════════════════════════════════════

-- Criar categorias na sidebar
local fpsCategory = createCategory("FPS", "🎯", Theme.FPS, 1)
local visualCategory = createCategory("Visual", "👁️", Theme.Visual, 2)
local miscCategory = createCategory("Misc", "⚙️", Theme.Misc, 3)
local rpCategory = createCategory("RP", "🎭", Theme.RP, 4)
local trollCategory = createCategory("Troll", "🤡", Theme.Troll, 5)

-- ═══════════════════════════════════════════════════════════════
-- 🎯 CONTEÚDO DA CATEGORIA FPS
-- ═══════════════════════════════════════════════════════════════
local function showFPSContent()
    -- Limpar conteúdo anterior
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child ~= contentLayout then
            child:Destroy()
        end
    end
    
    -- Seção Aimbot
    createSection("Aimbot & Targeting")
    
    createToggle("Enable Aimbot", function(enabled)
        Config.FPS.aimbot = enabled
        if Functions and Functions.toggleAimbot then
            Functions.toggleAimbot(enabled)
        end
        print("🎯 Aimbot:", enabled and "ON" or "OFF")
    end, Config.FPS.aimbot)
    
    createSlider("Aimbot FOV", 10, 360, Config.FPS.aimbotFOV, function(value)
        Config.FPS.aimbotFOV = value
        if Functions and Functions.setAimbotFOV then
            Functions.setAimbotFOV(value)
        end
        print("🎯 Aimbot FOV:", value)
    end)
    
    createSlider("Smoothness", 1, 20, Config.FPS.aimbotSmooth, function(value)
        Config.FPS.aimbotSmooth = value
        if Functions and Functions.setAimbotSmoothness then
            Functions.setAimbotSmoothness(value)
        end
        print("🎯 Smoothness:", value)
    end)
    
    createToggle("Silent Aim", function(enabled)
        Config.FPS.silentAim = enabled
        if Functions and Functions.toggleSilentAim then
            Functions.toggleSilentAim(enabled)
        end
        print("🔇 Silent Aim:", enabled and "ON" or "OFF")
    end, Config.FPS.silentAim)
    
    createToggle("Triggerbot", function(enabled)
        Config.FPS.triggerbot = enabled
        if Functions and Functions.toggleTriggerbot then
            Functions.toggleTriggerbot(enabled)
        end
        print("🔫 Triggerbot:", enabled and "ON" or "OFF")
    end, Config.FPS.triggerbot)
    
    createButton("Target Bone: " .. Config.FPS.targetBone, function()
        local bones = {"Head", "Torso", "HumanoidRootPart"}
        local currentIndex = 1
        for i, bone in ipairs(bones) do
            if bone == Config.FPS.targetBone then
                currentIndex = i
                break
            end
        end
        local nextIndex = (currentIndex % #bones) + 1
        Config.FPS.targetBone = bones[nextIndex]
        print("🎯 Target Bone:", Config.FPS.targetBone)
    end)
    
    -- Seção Weapon Mods
    createSection("Weapon Modifications")
    
    createToggle("No Recoil", function(enabled)
        Config.FPS.noRecoil = enabled
        print("🎯 No Recoil:", enabled and "ON" or "OFF")
    end, Config.FPS.noRecoil)
    
    createToggle("Rapid Fire", function(enabled)
        Config.FPS.rapidFire = enabled
        print("🔥 Rapid Fire:", enabled and "ON" or "OFF")
    end, Config.FPS.rapidFire)
    
    createToggle("Infinite Ammo", function(enabled)
        Config.FPS.infiniteAmmo = enabled
        print("♾️ Infinite Ammo:", enabled and "ON" or "OFF")
    end, Config.FPS.infiniteAmmo)
    
    createToggle("Wallbang", function(enabled)
        Config.FPS.wallbang = enabled
        print("🧱 Wallbang:", enabled and "ON" or "OFF")
    end, Config.FPS.wallbang)
    
    createToggle("Bullet Tracers", function(enabled)
        Config.FPS.bulletTracers = enabled
        print("📏 Bullet Tracers:", enabled and "ON" or "OFF")
    end, Config.FPS.bulletTracers)
    
    createSlider("Gun Damage", 1, 500, Config.FPS.gunDamage, function(value)
        Config.FPS.gunDamage = value
        print("💥 Gun Damage:", value)
    end)
    
    -- Seção Combat
    createSection("Combat Enhancement")
    
    createToggle("Hitbox Expander", function(enabled)
        Config.FPS.hitboxExpander = enabled
        print("📦 Hitbox Expander:", enabled and "ON" or "OFF")
    end, Config.FPS.hitboxExpander)
    
    createToggle("Kill Aura", function(enabled)
        Config.FPS.killAura = enabled
        print("⚔️ Kill Aura:", enabled and "ON" or "OFF")
    end, Config.FPS.killAura)
    
    createToggle("One Tap Mode", function(enabled)
        Config.FPS.oneTap = enabled
        print("💀 One Tap:", enabled and "ON" or "OFF")
    end, Config.FPS.oneTap)
    
    createSlider("Prediction", 0, 1, Config.FPS.prediction, function(value)
        Config.FPS.prediction = value / 10
        print("🔮 Prediction:", Config.FPS.prediction)
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- 👁️ CONTEÚDO DA CATEGORIA VISUAL
-- ═══════════════════════════════════════════════════════════════
local function showVisualContent()
    -- Limpar conteúdo anterior
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child ~= contentLayout then
            child:Destroy()
        end
    end
    
    -- Seção ESP
    createSection("ESP & Player Info")
    
    createToggle("Box ESP", function(enabled)
        Config.Visual.boxESP = enabled
        if Functions and Functions.toggleBoxESP then
            Functions.toggleBoxESP(enabled)
        end
        print("📦 Box ESP:", enabled and "ON" or "OFF")
    end, Config.Visual.boxESP)
    
    createToggle("Skeleton ESP", function(enabled)
        Config.Visual.skeletonESP = enabled
        if Functions and Functions.toggleSkeletonESP then
            Functions.toggleSkeletonESP(enabled)
        end
        print("🦴 Skeleton ESP:", enabled and "ON" or "OFF")
    end, Config.Visual.skeletonESP)
    
    createToggle("Name ESP", function(enabled)
        Config.Visual.nameESP = enabled
        if Functions and Functions.toggleNameESP then
            Functions.toggleNameESP(enabled)
        end
        print("📝 Name ESP:", enabled and "ON" or "OFF")
    end, Config.Visual.nameESP)
    
    createToggle("Distance ESP", function(enabled)
        Config.Visual.distanceESP = enabled
        if Functions and Functions.toggleDistanceESP then
            Functions.toggleDistanceESP(enabled)
        end
        print("📏 Distance ESP:", enabled and "ON" or "OFF")
    end, Config.Visual.distanceESP)
    
    createToggle("Health ESP", function(enabled)
        Config.Visual.healthESP = enabled
        if Functions and Functions.toggleHealthESP then
            Functions.toggleHealthESP(enabled)
        end
        print("❤️ Health ESP:", enabled and "ON" or "OFF")
    end, Config.Visual.healthESP)
    
    createToggle("Tracers", function(enabled)
        Config.Visual.tracers = enabled
        if Functions and Functions.toggleTracers then
            Functions.toggleTracers(enabled)
        end
        print("📍 Tracers:", enabled and "ON" or "OFF")
    end, Config.Visual.tracers)
    
    createSlider("ESP Distance", 100, 5000, Config.Visual.espDistance, function(value)
        Config.Visual.espDistance = value
        print("📏 ESP Distance:", value)
    end)
    
    -- Seção Visual Effects
    createSection("Visual Effects")
    
    createToggle("Chams/Glow", function(enabled)
        Config.Visual.chams = enabled
        if Functions and Functions.toggleChams then
            Functions.toggleChams(enabled)
        end
        print("✨ Chams:", enabled and "ON" or "OFF")
    end, Config.Visual.chams)
    
    createToggle("Fullbright", function(enabled)
        Config.Visual.fullbright = enabled
        if Functions and Functions.toggleFullbright then
            Functions.toggleFullbright(enabled)
        else
            -- Fallback implementation
            if enabled then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
            else
                Lighting.Brightness = 1
                Lighting.ClockTime = 12
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = true
            end
        end
        print("💡 Fullbright:", enabled and "ON" or "OFF")
    end, Config.Visual.fullbright)
    
    createToggle("Custom Crosshair", function(enabled)
        Config.Visual.crosshair = enabled
        print("🎯 Crosshair:", enabled and "ON" or "OFF")
    end, Config.Visual.crosshair)
    
    createSlider("Field of View", 60, 120, Config.Visual.fov, function(value)
        Config.Visual.fov = value
        workspace.CurrentCamera.FieldOfView = value
        print("🔍 FOV:", value)
    end)
    
    -- Seção Item ESP
    createSection("Item & Object ESP")
    
    createToggle("Item ESP", function(enabled)
        Config.Visual.itemESP = enabled
        print("🎁 Item ESP:", enabled and "ON" or "OFF")
    end, Config.Visual.itemESP)
    
    createToggle("Vehicle ESP", function(enabled)
        Config.Visual.vehicleESP = enabled
        print("🚗 Vehicle ESP:", enabled and "ON" or "OFF")
    end, Config.Visual.vehicleESP)
    
    createToggle("Radar Hack", function(enabled)
        Config.Visual.radar = enabled
        print("📡 Radar:", enabled and "ON" or "OFF")
    end, Config.Visual.radar)
end

-- ═══════════════════════════════════════════════════════════════
-- ⚙️ CONTEÚDO DA CATEGORIA MISC
-- ═══════════════════════════════════════════════════════════════
local function showMiscContent()
    -- Limpar conteúdo anterior
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child ~= contentLayout then
            child:Destroy()
        end
    end
    
    -- Seção Movement
    createSection("Movement & Physics")
    
    createToggle("Super Speed", function(enabled)
        Config.Misc.walkSpeed = enabled
        if Functions and Functions.toggleSuperSpeed then
            Functions.toggleSuperSpeed(enabled, Config.Misc.speedValue)
        else
            -- Fallback implementation
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = enabled and Config.Misc.speedValue or 16
            end
        end
        print("🏃 Super Speed:", enabled and "ON" or "OFF")
    end, Config.Misc.walkSpeed)
    
    createSlider("Speed Value", 16, 500, Config.Misc.speedValue, function(value)
        Config.Misc.speedValue = value
        if Functions and Functions.setSuperSpeed then
            Functions.setSuperSpeed(value)
        else
            -- Fallback implementation
            if Config.Misc.walkSpeed and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = value
            end
        end
        print("🏃 Speed:", value)
    end)
    
    createToggle("Super Jump", function(enabled)
        Config.Misc.jumpPower = enabled
        if Functions and Functions.toggleSuperJump then
            Functions.toggleSuperJump(enabled, Config.Misc.jumpValue)
        else
            -- Fallback implementation
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.JumpPower = enabled and Config.Misc.jumpValue or 50
            end
        end
        print("🦘 Super Jump:", enabled and "ON" or "OFF")
    end, Config.Misc.jumpPower)
    
    createSlider("Jump Power", 50, 500, Config.Misc.jumpValue, function(value)
        Config.Misc.jumpValue = value
        if Functions and Functions.setSuperJump then
            Functions.setSuperJump(value)
        else
            -- Fallback implementation
            if Config.Misc.jumpPower and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.JumpPower = value
            end
        end
        print("🦘 Jump Power:", value)
    end)
    
    createToggle("Fly Mode", function(enabled)
        Config.Misc.fly = enabled
        if Functions and Functions.toggleFly then
            Functions.toggleFly(enabled)
        end
        print("🛸 Fly:", enabled and "ON" or "OFF")
    end, Config.Misc.fly)
    
    createSlider("Fly Speed", 10, 200, Config.Misc.flySpeed, function(value)
        Config.Misc.flySpeed = value
        print("🛸 Fly Speed:", value)
    end)
    
    createToggle("Noclip", function(enabled)
        Config.Misc.noclip = enabled
        if Functions and Functions.toggleNoclip then
            Functions.toggleNoclip(enabled)
        end
        print("👻 Noclip:", enabled and "ON" or "OFF")
    end, Config.Misc.noclip)
    
    createToggle("Infinite Jump", function(enabled)
        Config.Misc.infiniteJump = enabled
        if Functions and Functions.toggleInfiniteJump then
            Functions.toggleInfiniteJump(enabled)
        end
        print("🚀 Infinite Jump:", enabled and "ON" or "OFF")
    end, Config.Misc.infiniteJump)
    
    -- Seção Automation
    createSection("Automation & Farming")
    
    createToggle("Auto Farm", function(enabled)
        Config.Misc.autoFarm = enabled
        print("🤖 Auto Farm:", enabled and "ON" or "OFF")
    end, Config.Misc.autoFarm)
    
    createToggle("Auto Collect", function(enabled)
        Config.Misc.autoCollect = enabled
        print("🧲 Auto Collect:", enabled and "ON" or "OFF")
    end, Config.Misc.autoCollect)
    
    createToggle("Anti AFK", function(enabled)
        Config.Misc.antiAFK = enabled
        print("⏰ Anti AFK:", enabled and "ON" or "OFF")
    end, Config.Misc.antiAFK)
    
    -- Seção Utilities
    createSection("Utilities")
    
    createToggle("No Fall Damage", function(enabled)
        Config.Misc.noFallDamage = enabled
        print("🛡️ No Fall Damage:", enabled and "ON" or "OFF")
    end, Config.Misc.noFallDamage)
    
    createToggle("Infinite Stamina", function(enabled)
        Config.Misc.infiniteStamina = enabled
        print("♾️ Infinite Stamina:", enabled and "ON" or "OFF")
    end, Config.Misc.infiniteStamina)
    
    createButton("Teleport to Spawn", function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
        end
        print("📍 Teleported to spawn")
    end)
    
    createButton("Reset Character", function()
        if player.Character then
            player.Character:BreakJoints()
        end
        print("🔄 Character reset")
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- 🎭 CONTEÚDO DA CATEGORIA RP
-- ═══════════════════════════════════════════════════════════════
local function showRPContent()
    -- Limpar conteúdo anterior
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child ~= contentLayout then
            child:Destroy()
        end
    end
    
    -- Seção Spawning
    createSection("Item & Vehicle Spawning")
    
    createToggle("Weapon Spawner", function(enabled)
        Config.RP.weaponSpawner = enabled
        if Functions and Functions.toggleWeaponSpawner then
            Functions.toggleWeaponSpawner(enabled)
        end
        print("🔫 Weapon Spawner:", enabled and "ON" or "OFF")
    end, Config.RP.weaponSpawner)
    
    createButton("Spawn: " .. Config.RP.selectedWeapon, function()
        local weapons = {"AK47", "M4A1", "Pistol", "Sniper", "Shotgun"}
        local currentIndex = 1
        for i, weapon in ipairs(weapons) do
            if weapon == Config.RP.selectedWeapon then
                currentIndex = i
                break
            end
        end
        local nextIndex = (currentIndex % #weapons) + 1
        Config.RP.selectedWeapon = weapons[nextIndex]
        if Functions and Functions.spawnWeapon then
            Functions.spawnWeapon(Config.RP.selectedWeapon)
        end
        print("🔫 Selected Weapon:", Config.RP.selectedWeapon)
    end)
    
    createToggle("Vehicle Spawner", function(enabled)
        Config.RP.vehicleSpawner = enabled
        if Functions and Functions.toggleVehicleSpawner then
            Functions.toggleVehicleSpawner(enabled)
        end
        print("🚗 Vehicle Spawner:", enabled and "ON" or "OFF")
    end, Config.RP.vehicleSpawner)
    
    createButton("Spawn: " .. Config.RP.selectedVehicle, function()
        local vehicles = {"Lambo", "Ferrari", "BMW", "Truck", "Bike"}
        local currentIndex = 1
        for i, vehicle in ipairs(vehicles) do
            if vehicle == Config.RP.selectedVehicle then
                currentIndex = i
                break
            end
        end
        local nextIndex = (currentIndex % #vehicles) + 1
        Config.RP.selectedVehicle = vehicles[nextIndex]
        print("🚗 Selected Vehicle:", Config.RP.selectedVehicle)
    end)
    
    -- Seção Avatar
    createSection("Avatar & Appearance")
    
    createToggle("Avatar Changer", function(enabled)
        Config.RP.avatarChanger = enabled
        print("👤 Avatar Changer:", enabled and "ON" or "OFF")
    end, Config.RP.avatarChanger)
    
    createButton("Random Avatar", function()
        print("👤 Random avatar applied")
    end)
    
    createToggle("Animation Player", function(enabled)
        Config.RP.animationPlayer = enabled
        print("💃 Animation Player:", enabled and "ON" or "OFF")
    end, Config.RP.animationPlayer)
    
    -- Seção Money & Items
    createSection("Money & Items")
    
    createToggle("Fake Money", function(enabled)
        Config.RP.fakeMoney = enabled
        print("💰 Fake Money:", enabled and "ON" or "OFF")
    end, Config.RP.fakeMoney)
    
    createSlider("Money Amount", 1000, 9999999, Config.RP.moneyAmount, function(value)
        Config.RP.moneyAmount = value
        print("💰 Money Amount:", value)
    end)
    
    createButton("Give All Tools", function()
        print("🛠️ All tools given")
    end)
    
    createButton("Spawn Objects", function()
        print("📦 Objects spawned")
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- 🤡 CONTEÚDO DA CATEGORIA TROLL
-- ═══════════════════════════════════════════════════════════════
local function showTrollContent()
    -- Limpar conteúdo anterior
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child ~= contentLayout then
            child:Destroy()
        end
    end
    
    -- Seção Audio Troll
    createSection("Audio & Visual Trolling")
    
    createToggle("Sound Spam", function(enabled)
        Config.Troll.soundSpam = enabled
        if Functions and Functions.toggleSoundSpam then
            Functions.toggleSoundSpam(enabled)
        end
        print("🔊 Sound Spam:", enabled and "ON" or "OFF")
    end, Config.Troll.soundSpam)
    
    createToggle("Screen Shaker", function(enabled)
        Config.Troll.screenShaker = enabled
        if Functions and Functions.toggleScreenShaker then
            Functions.toggleScreenShaker(enabled)
        end
        print("📳 Screen Shaker:", enabled and "ON" or "OFF")
    end, Config.Troll.screenShaker)
    
    createToggle("Blind Effect", function(enabled)
        Config.Troll.blindEffect = enabled
        if Functions and Functions.toggleBlindEffect then
            Functions.toggleBlindEffect(enabled)
        end
        print("🕶️ Blind Effect:", enabled and "ON" or "OFF")
    end, Config.Troll.blindEffect)
    
    -- Seção Player Manipulation
    createSection("Player Manipulation")
    
    createToggle("Freeze All", function(enabled)
        Config.Troll.freezePlayer = enabled
        if Functions and Functions.toggleFreezeAll then
            Functions.toggleFreezeAll(enabled)
        end
        print("🧊 Freeze All:", enabled and "ON" or "OFF")
    end, Config.Troll.freezePlayer)
    
    createToggle("Fling All", function(enabled)
        Config.Troll.flingAll = enabled
        if Functions and Functions.toggleFlingAll then
            Functions.toggleFlingAll(enabled)
        end
        print("🌪️ Fling All:", enabled and "ON" or "OFF")
    end, Config.Troll.flingAll)
    
    createToggle("Ragdoll All", function(enabled)
        Config.Troll.ragdollAll = enabled
        print("🤸 Ragdoll All:", enabled and "ON" or "OFF")
    end, Config.Troll.ragdollAll)
    
    createToggle("Loop Kill", function(enabled)
        Config.Troll.loopKill = enabled
        print("💀 Loop Kill:", enabled and "ON" or "OFF")
    end, Config.Troll.loopKill)
    
    createSlider("Troll Intensity", 1, 10, Config.Troll.trollIntensity, function(value)
        Config.Troll.trollIntensity = value
        print("🎭 Troll Intensity:", value)
    end)
    
    -- Seção Extreme Trolling
    createSection("Extreme Trolling")
    
    createButton("⚠️ Server Crasher", function()
        Config.Troll.serverCrasher = not Config.Troll.serverCrasher
        print("💥 Server Crasher:", Config.Troll.serverCrasher and "ACTIVATED" or "DEACTIVATED")
    end)
    
    createButton("Nuke Effect", function()
        print("💥 NUKE ACTIVATED!")
    end)
    
    createButton("Earthquake Mode", function()
        print("🌍 EARTHQUAKE ACTIVATED!")
    end)
    
    createButton("Map Destroyer", function()
        print("🗺️ MAP DESTRUCTION INITIATED!")
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- 🎮 SISTEMA DE NAVEGAÇÃO E EVENTOS
-- ═══════════════════════════════════════════════════════════════

-- Função para atualizar aparência das categorias
local function updateCategoryAppearance(selectedCategory)
    local categories = {
        {fpsCategory, "FPS", Theme.FPS},
        {visualCategory, "Visual", Theme.Visual},
        {miscCategory, "Misc", Theme.Misc},
        {rpCategory, "RP", Theme.RP},
        {trollCategory, "Troll", Theme.Troll}
    }
    
    for _, categoryData in pairs(categories) do
        local btn, name, color = categoryData[1], categoryData[2], categoryData[3]
        if name == selectedCategory then
            btn.BackgroundColor3 = color
        else
            btn.BackgroundColor3 = Theme.Background
        end
    end
end

-- Função para mostrar conteúdo baseado na categoria
local function showContent(category)
    Config.currentCategory = category
    updateCategoryAppearance(category)
    
    if category == "FPS" then
        showFPSContent()
    elseif category == "Visual" then
        showVisualContent()
    elseif category == "Misc" then
        showMiscContent()
    elseif category == "RP" then
        showRPContent()
    elseif category == "Troll" then
        showTrollContent()
    end
    
    -- Atualizar tamanho do scroll
    wait(0.1)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end

-- Conectar eventos das categorias
fpsCategory.MouseButton1Click:Connect(function()
    showContent("FPS")
end)

visualCategory.MouseButton1Click:Connect(function()
    showContent("Visual")
end)

miscCategory.MouseButton1Click:Connect(function()
    showContent("Misc")
end)

rpCategory.MouseButton1Click:Connect(function()
    showContent("RP")
end)

trollCategory.MouseButton1Click:Connect(function()
    showContent("Troll")
end)

-- ═══════════════════════════════════════════════════════════════
-- 🎛️ SISTEMA DE CONTROLES DA JANELA
-- ═══════════════════════════════════════════════════════════════

-- Função para toggle do menu
local function toggleMenu()
    Config.menuVisible = not Config.menuVisible
    
    if Config.menuVisible then
        mainFrame.Visible = true
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = Config.windowSize,
            Position = UDim2.new(0.5, -450, 0.5, -300)
        })
        tween:Play()
        
        -- Mostrar categoria inicial
        showContent(Config.currentCategory)
    else
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        tween:Play()
        
        tween.Completed:Connect(function()
            mainFrame.Visible = false
        end)
    end
end

-- Função para minimizar
local function minimizeMenu()
    if Config.menuVisible then
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, 300, 0, 60),
            Position = UDim2.new(0.5, -150, 0.5, -30)
        })
        tween:Play()
        
        -- Esconder conteúdo
        contentArea.Visible = false
        sidebar.Visible = false
    else
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
            Size = Config.windowSize,
            Position = UDim2.new(0.5, -450, 0.5, -300)
        })
        tween:Play()
        
        -- Mostrar conteúdo
        contentArea.Visible = true
        sidebar.Visible = true
    end
end

-- Eventos dos botões
closeBtn.MouseButton1Click:Connect(toggleMenu)
minimizeBtn.MouseButton1Click:Connect(minimizeMenu)

-- ═══════════════════════════════════════════════════════════════
-- 🖱️ SISTEMA DE DRAG & DROP
-- ═══════════════════════════════════════════════════════════════

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
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- ⌨️ SISTEMA DE HOTKEYS
-- ═══════════════════════════════════════════════════════════════

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Config.menuKey then
        toggleMenu()
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- 🚀 INICIALIZAÇÃO
-- ═══════════════════════════════════════════════════════════════

-- Marcar como carregado
_G.CheatUILoaded = true

-- Mostrar categoria inicial
updateCategoryAppearance(Config.currentCategory)

-- Mensagem de inicialização
print("╔══════════════════════════════════════════════════════════════╗")
print("║                    ROBLOX CHEAT UI v2.0                     ║")
print("║                      Successfully Loaded!                    ║")
print("╠══════════════════════════════════════════════════════════════╣")
print("║  🎯 FPS - Aimbot, Silent Aim, Triggerbot, Weapon Mods      ║")
print("║  👁️ Visual - ESP, Chams, Crosshair, FOV, Fullbright        ║")
print("║  ⚙️ Misc - Speed, Fly, Noclip, Auto Farm, Teleport         ║")
print("║  🎭 RP - Weapon/Vehicle Spawner, Avatar Changer, Money      ║")
print("║  🤡 Troll - Sound Spam, Fling, Screen Effects, Crasher     ║")
print("╠══════════════════════════════════════════════════════════════╣")
print("║  Press INSERT to open/close menu                            ║")
print("║  Drag the header to move the window                         ║")
print("║  Click minimize (-) to collapse window                      ║")
print("╚══════════════════════════════════════════════════════════════╝")

-- ═══════════════════════════════════════════════════════════════
-- ⌨️ CONTROLE DE VISIBILIDADE - TECLA INSERT
-- ═══════════════════════════════════════════════════════════════

-- Função para alternar visibilidade da UI
local function toggleUI()
    if mainFrame then
        mainFrame.Visible = not mainFrame.Visible
        if mainFrame.Visible then
            print("🎮 Cheat UI: ABERTO")
        else
            print("🎮 Cheat UI: FECHADO")
        end
    end
end

-- Conectar tecla Insert para abrir/fechar
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleUI()
    end
end)

-- Aguardar um frame e mostrar conteúdo inicial
RunService.Heartbeat:Wait()
showContent("FPS")

-- Salvar referência global para controle externo
_G.ToggleCheatUI = toggleUI
