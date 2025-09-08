-- ╔══════════════════════════════════════════════════════════════╗
-- ║                    ROBLOX CHEAT UI - MODERN DESIGN           ║
-- ║                   Advanced Tab System with Sub-tabs          ║
-- ╚══════════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mouse = player:GetMouse()

-- Evitar reload múltiplo
if _G.ModernCheatUI then
    _G.ModernCheatUI:Destroy()
end

-- ═══════════════════════════════════════════════════════════════
-- 🎨 TEMA ROXO/PRETO MODERNO
-- ═══════════════════════════════════════════════════════════════
local Theme = {
    -- Cores principais
    Background = Color3.fromRGB(20, 20, 25),
    Sidebar = Color3.fromRGB(15, 15, 20),
    Content = Color3.fromRGB(25, 25, 30),
    
    -- Roxo principal
    Primary = Color3.fromRGB(139, 69, 255),    -- Roxo vibrante
    PrimaryHover = Color3.fromRGB(124, 58, 237), -- Roxo hover
    PrimaryDark = Color3.fromRGB(109, 40, 217),  -- Roxo escuro
    
    -- Texto
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(156, 163, 175),
    TextMuted = Color3.fromRGB(107, 114, 128),
    
    -- Estados
    Success = Color3.fromRGB(34, 197, 94),
    Warning = Color3.fromRGB(245, 158, 11),
    Error = Color3.fromRGB(239, 68, 68),
    
    -- Elementos UI
    Border = Color3.fromRGB(55, 65, 81),
    Hover = Color3.fromRGB(31, 41, 55),
    Active = Color3.fromRGB(139, 69, 255),
}

-- ═══════════════════════════════════════════════════════════════
-- 🔧 FUNÇÕES INTEGRADAS
-- ═══════════════════════════════════════════════════════════════
local Functions = {}
local connections = {}

-- FPS Functions
function Functions.toggleAimbot(enabled)
    print("🎯 Aimbot:", enabled and "ON" or "OFF")
end

function Functions.toggleSilentAim(enabled)
    print("🔇 Silent Aim:", enabled and "ON" or "OFF")
end

function Functions.toggleTriggerbot(enabled)
    print("🔫 Triggerbot:", enabled and "ON" or "OFF")
end

-- Visual Functions
function Functions.toggleESP(enabled)
    print("👁️ ESP:", enabled and "ON" or "OFF")
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
function Functions.toggleSpeed(enabled, value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = enabled and value or 16
    end
    print("🏃 Speed:", enabled and "ON" or "OFF")
end

function Functions.toggleJump(enabled, value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = enabled and value or 50
    end
    print("🦘 Jump:", enabled and "ON" or "OFF")
end

function Functions.toggleFly(enabled)
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

-- ═══════════════════════════════════════════════════════════════
-- 📋 CONFIGURAÇÃO DAS ABAS E SUB-ABAS
-- ═══════════════════════════════════════════════════════════════
local TabConfig = {
    {
        name = "Combat",
        icon = "🎯",
        color = Theme.Primary,
        subtabs = {
            {name = "Aimbot", items = {"Enable Aimbot", "FOV Circle", "Smoothness", "Target Bone"}},
            {name = "Weapons", items = {"No Recoil", "Rapid Fire", "Infinite Ammo", "Silent Aim"}},
            {name = "Combat", items = {"Triggerbot", "Kill Aura", "Auto Shoot", "Hitbox Expander"}}
        }
    },
    {
        name = "Visuals",
        icon = "👁️",
        color = Color3.fromRGB(59, 130, 246),
        subtabs = {
            {name = "ESP", items = {"Player ESP", "Item ESP", "Vehicle ESP", "Distance ESP"}},
            {name = "World", items = {"Fullbright", "No Fog", "Skybox Changer", "Time Changer"}},
            {name = "UI", items = {"Crosshair", "FOV Changer", "Third Person", "Camera Mods"}}
        }
    },
    {
        name = "Movement",
        icon = "🏃",
        color = Color3.fromRGB(34, 197, 94),
        subtabs = {
            {name = "Speed", items = {"Walk Speed", "Run Speed", "Swim Speed", "Climb Speed"}},
            {name = "Jump", items = {"Jump Power", "Infinite Jump", "High Jump", "Long Jump"}},
            {name = "Flight", items = {"Fly Mode", "Fly Speed", "Noclip", "Teleport"}}
        }
    },
    {
        name = "Player",
        icon = "👤",
        color = Color3.fromRGB(245, 158, 11),
        subtabs = {
            {name = "Character", items = {"God Mode", "Invisible", "Name Spoof", "Avatar Changer"}},
            {name = "Stats", items = {"Infinite Health", "Infinite Stamina", "Level Changer", "XP Multiplier"}},
            {name = "Tools", items = {"All Tools", "Tool Giver", "Backpack", "Inventory"}}
        }
    },
    {
        name = "World",
        icon = "🌍",
        color = Color3.fromRGB(168, 85, 247),
        subtabs = {
            {name = "Spawn", items = {"Vehicle Spawner", "Weapon Spawner", "Item Spawner", "NPC Spawner"}},
            {name = "Teleport", items = {"Player TP", "Location TP", "Waypoints", "TP History"}},
            {name = "Server", items = {"Server Hop", "Rejoin", "VIP Server", "Private Server"}}
        }
    },
    {
        name = "Misc",
        icon = "⚙️",
        color = Color3.fromRGB(239, 68, 68),
        subtabs = {
            {name = "Auto", items = {"Auto Farm", "Auto Collect", "Auto Click", "Auto Buy"}},
            {name = "Anti", items = {"Anti AFK", "Anti Ban", "Anti Kick", "Anti Lag"}},
            {name = "Fun", items = {"Chat Spam", "Sound Spam", "Troll Tools", "Crash Server"}}
        }
    }
}

-- ═══════════════════════════════════════════════════════════════
-- 🏗️ CRIAÇÃO DA UI PRINCIPAL
-- ═══════════════════════════════════════════════════════════════

-- ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModernCheatUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 900, 0, 600)
mainFrame.Position = UDim2.new(0.5, -450, 0.5, -300)
mainFrame.BackgroundColor3 = Theme.Background
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true

-- Corner arredondado
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Sombra
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Parent = screenGui
shadow.Size = UDim2.new(0, 920, 0, 620)
shadow.Position = UDim2.new(0.5, -460, 0.5, -310)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.8
shadow.BorderSizePixel = 0
shadow.ZIndex = -1

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- ═══════════════════════════════════════════════════════════════
-- 📱 HEADER/TÍTULO
-- ═══════════════════════════════════════════════════════════════
local header = Instance.new("Frame")
header.Name = "Header"
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Theme.Sidebar
header.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Fix para cantos inferiores
local headerFix = Instance.new("Frame")
headerFix.Parent = header
headerFix.Size = UDim2.new(1, 0, 0, 12)
headerFix.Position = UDim2.new(0, 0, 1, -12)
headerFix.BackgroundColor3 = Theme.Sidebar
headerFix.BorderSizePixel = 0

-- Logo/Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = header
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🎮 CHEAT MENU"
title.TextColor3 = Theme.TextPrimary
title.TextScaled = true
title.Font = Enum.Font.GothamBold

-- Botão fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Parent = header
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0.5, -20)
closeBtn.BackgroundColor3 = Theme.Error
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Theme.TextPrimary
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 8)
closeBtnCorner.Parent = closeBtn

-- ═══════════════════════════════════════════════════════════════
-- 📂 SIDEBAR COM ABAS PRINCIPAIS
-- ═══════════════════════════════════════════════════════════════
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Parent = mainFrame
sidebar.Size = UDim2.new(0, 200, 1, -60)
sidebar.Position = UDim2.new(0, 0, 0, 60)
sidebar.BackgroundColor3 = Theme.Sidebar
sidebar.BorderSizePixel = 0

-- Container para as abas
local tabContainer = Instance.new("Frame")
tabContainer.Name = "TabContainer"
tabContainer.Parent = sidebar
tabContainer.Size = UDim2.new(1, 0, 1, 0)
tabContainer.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = tabContainer
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 2)

-- ═══════════════════════════════════════════════════════════════
-- 📄 ÁREA DE CONTEÚDO PRINCIPAL
-- ═══════════════════════════════════════════════════════════════
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Parent = mainFrame
contentArea.Size = UDim2.new(1, -200, 1, -60)
contentArea.Position = UDim2.new(0, 200, 0, 60)
contentArea.BackgroundColor3 = Theme.Content
contentArea.BorderSizePixel = 0

-- Sub-tabs header
local subtabHeader = Instance.new("Frame")
subtabHeader.Name = "SubtabHeader"
subtabHeader.Parent = contentArea
subtabHeader.Size = UDim2.new(1, 0, 0, 50)
subtabHeader.BackgroundColor3 = Theme.Background
subtabHeader.BorderSizePixel = 0

local subtabLayout = Instance.new("UIListLayout")
subtabLayout.Parent = subtabHeader
subtabLayout.FillDirection = Enum.FillDirection.Horizontal
subtabLayout.SortOrder = Enum.SortOrder.LayoutOrder
subtabLayout.Padding = UDim.new(0, 2)

-- Conteúdo das sub-abas
local subtabContent = Instance.new("ScrollingFrame")
subtabContent.Name = "SubtabContent"
subtabContent.Parent = contentArea
subtabContent.Size = UDim2.new(1, -20, 1, -70)
subtabContent.Position = UDim2.new(0, 10, 0, 60)
subtabContent.BackgroundTransparency = 1
subtabContent.BorderSizePixel = 0
subtabContent.ScrollBarThickness = 6
subtabContent.ScrollBarImageColor3 = Theme.Primary

local contentLayout = Instance.new("UIListLayout")
contentLayout.Parent = subtabContent
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 8)

-- ═══════════════════════════════════════════════════════════════
-- 🔧 FUNÇÕES DE CRIAÇÃO DE ELEMENTOS
-- ═══════════════════════════════════════════════════════════════

-- Função para criar aba principal
local function createMainTab(config, index)
    local tab = Instance.new("TextButton")
    tab.Name = config.name .. "Tab"
    tab.Parent = tabContainer
    tab.Size = UDim2.new(1, -10, 0, 50)
    tab.Position = UDim2.new(0, 5, 0, 0)
    tab.BackgroundColor3 = Theme.Hover
    tab.BorderSizePixel = 0
    tab.Text = ""
    tab.LayoutOrder = index
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tab
    
    -- Icon
    local icon = Instance.new("TextLabel")
    icon.Parent = tab
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(0, 10, 0.5, -15)
    icon.BackgroundTransparency = 1
    icon.Text = config.icon
    icon.TextColor3 = config.color
    icon.TextScaled = true
    icon.Font = Enum.Font.Gotham
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Parent = tab
    label.Size = UDim2.new(1, -50, 1, 0)
    label.Position = UDim2.new(0, 45, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = config.name
    label.TextColor3 = Theme.TextSecondary
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    return tab, icon, label
end

-- Função para criar sub-aba
local function createSubTab(name, index)
    local subtab = Instance.new("TextButton")
    subtab.Name = name .. "Subtab"
    subtab.Parent = subtabHeader
    subtab.Size = UDim2.new(0, 120, 1, -10)
    subtab.Position = UDim2.new(0, 5, 0, 5)
    subtab.BackgroundColor3 = Theme.Hover
    subtab.BorderSizePixel = 0
    subtab.Text = name
    subtab.TextColor3 = Theme.TextSecondary
    subtab.TextScaled = true
    subtab.Font = Enum.Font.Gotham
    subtab.LayoutOrder = index
    
    local subtabCorner = Instance.new("UICorner")
    subtabCorner.CornerRadius = UDim.new(0, 6)
    subtabCorner.Parent = subtab
    
    return subtab
end

-- Função para criar toggle
local function createToggle(text, callback)
    local toggle = Instance.new("Frame")
    toggle.Name = text .. "Toggle"
    toggle.Parent = subtabContent
    toggle.Size = UDim2.new(1, 0, 0, 40)
    toggle.BackgroundColor3 = Theme.Background
    toggle.BorderSizePixel = 0
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggle
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Parent = toggle
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.TextPrimary
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Switch
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
        
        local switchTween = TweenService:Create(switch, 
            TweenInfo.new(0.2, Enum.EasingStyle.Quad), 
            {BackgroundColor3 = isEnabled and Theme.Primary or Theme.Border}
        )
        
        local knobTween = TweenService:Create(knob,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {Position = UDim2.new(0, isEnabled and 22 or 2, 0.5, -8)}
        )
        
        switchTween:Play()
        knobTween:Play()
        
        if callback then
            callback(isEnabled)
        end
    end)
    
    return toggle
end

-- ═══════════════════════════════════════════════════════════════
-- 🎮 SISTEMA DE NAVEGAÇÃO
-- ═══════════════════════════════════════════════════════════════
local currentTab = 1
local currentSubtab = 1
local tabs = {}
local subtabs = {}

-- Criar todas as abas principais
for i, config in ipairs(TabConfig) do
    local tab, icon, label = createMainTab(config, i)
    tabs[i] = {button = tab, icon = icon, label = label, config = config}
    
    tab.MouseButton1Click:Connect(function()
        currentTab = i
        currentSubtab = 1
        updateTabDisplay()
        updateSubtabDisplay()
        updateContent()
    end)
end

-- Função para atualizar display das abas
function updateTabDisplay()
    for i, tab in ipairs(tabs) do
        local isActive = (i == currentTab)
        tab.button.BackgroundColor3 = isActive and Theme.Primary or Theme.Hover
        tab.label.TextColor3 = isActive and Theme.TextPrimary or Theme.TextSecondary
        tab.icon.TextColor3 = isActive and Theme.TextPrimary or tab.config.color
    end
end

-- Função para atualizar sub-abas
function updateSubtabDisplay()
    -- Limpar sub-abas existentes
    for _, child in pairs(subtabHeader:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    subtabs = {}
    local config = TabConfig[currentTab]
    
    -- Criar novas sub-abas
    for i, subtabConfig in ipairs(config.subtabs) do
        local subtab = createSubTab(subtabConfig.name, i)
        subtabs[i] = {button = subtab, config = subtabConfig}
        
        subtab.MouseButton1Click:Connect(function()
            currentSubtab = i
            updateSubtabColors()
            updateContent()
        end)
    end
    
    updateSubtabColors()
end

-- Função para atualizar cores das sub-abas
function updateSubtabColors()
    for i, subtab in ipairs(subtabs) do
        local isActive = (i == currentSubtab)
        subtab.button.BackgroundColor3 = isActive and Theme.Primary or Theme.Hover
        subtab.button.TextColor3 = isActive and Theme.TextPrimary or Theme.TextSecondary
    end
end

-- Função para atualizar conteúdo
function updateContent()
    -- Limpar conteúdo existente
    for _, child in pairs(subtabContent:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local config = TabConfig[currentTab]
    local subtabConfig = config.subtabs[currentSubtab]
    
    -- Criar toggles para os itens
    for _, item in ipairs(subtabConfig.items) do
        createToggle(item, function(enabled)
            print("🎮", item .. ":", enabled and "ON" or "OFF")
            
            -- Conectar às funções reais
            if item:find("Speed") then
                Functions.toggleSpeed(enabled, 100)
            elseif item:find("Jump") then
                Functions.toggleJump(enabled, 100)
            elseif item:find("Fly") then
                Functions.toggleFly(enabled)
            elseif item:find("Noclip") then
                Functions.toggleNoclip(enabled)
            elseif item:find("Fullbright") then
                Functions.toggleFullbright(enabled)
            elseif item:find("ESP") then
                Functions.toggleESP(enabled)
            elseif item:find("Aimbot") then
                Functions.toggleAimbot(enabled)
            end
        end)
    end
    
    -- Atualizar tamanho do scroll
    subtabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
end

-- ═══════════════════════════════════════════════════════════════
-- ⌨️ CONTROLES E EVENTOS
-- ═══════════════════════════════════════════════════════════════

-- Drag & Drop
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

-- Botão fechar
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Toggle com INSERT
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
        shadow.Visible = mainFrame.Visible
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- 🚀 INICIALIZAÇÃO
-- ═══════════════════════════════════════════════════════════════

-- Salvar referência global
_G.ModernCheatUI = screenGui

-- Inicializar display
updateTabDisplay()
updateSubtabDisplay()
updateContent()

-- Mensagem de sucesso
print("╔══════════════════════════════════════════════════════════════╗")
print("║                   🎮 MODERN CHEAT UI LOADED                  ║")
print("╠══════════════════════════════════════════════════════════════╣")
print("║  Press INSERT to toggle menu                                 ║")
print("║  Modern tab system with sub-tabs                             ║")
print("║  Purple/Black theme                                          ║")
print("╚══════════════════════════════════════════════════════════════╝")
