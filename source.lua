-- ╔══════════════════════════════════════════════════════════════╗
-- ║                    ULTRA MODERN CHEAT UI                     ║
-- ║                  Premium Design with Glassmorphism          ║
-- ╚══════════════════════════════════════════════════════════════╝

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cleanup
if _G.UltraModernUI then
    _G.UltraModernUI:Destroy()
end

-- ═══════════════════════════════════════════════════════════════
-- 🎨 PREMIUM THEME - GLASSMORPHISM DARK
-- ═══════════════════════════════════════════════════════════════
local Theme = {
    -- Glass/Blur backgrounds
    Glass = Color3.fromRGB(10, 10, 15),
    GlassLight = Color3.fromRGB(20, 20, 30),
    GlassDark = Color3.fromRGB(5, 5, 10),
    
    -- Neon accents
    Neon = Color3.fromRGB(138, 43, 226),      -- Purple neon
    NeonBlue = Color3.fromRGB(0, 191, 255),   -- Cyan neon
    NeonPink = Color3.fromRGB(255, 20, 147),  -- Pink neon
    NeonGreen = Color3.fromRGB(50, 205, 50),  -- Green neon
    
    -- Gradients
    Gradient1 = Color3.fromRGB(138, 43, 226),
    Gradient2 = Color3.fromRGB(0, 191, 255),
    
    -- Text
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190),
    TextMuted = Color3.fromRGB(120, 120, 130),
    
    -- States
    Success = Color3.fromRGB(0, 255, 127),
    Warning = Color3.fromRGB(255, 215, 0),
    Error = Color3.fromRGB(255, 69, 0),
}

-- ═══════════════════════════════════════════════════════════════
-- 🔧 FUNÇÕES INTEGRADAS
-- ═══════════════════════════════════════════════════════════════
local Functions = {}
local connections = {}

function Functions.toggleAimbot(enabled)
    print("🎯 Aimbot:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleESP(enabled)
    print("👁️ ESP:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleSpeed(enabled, value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = enabled and value or 16
    end
    print("🏃 Speed:", enabled and "ENABLED" or "DISABLED")
end

function Functions.toggleFly(enabled)
    print("🛸 Fly:", enabled and "ENABLED" or "DISABLED")
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
    print("👻 Noclip:", enabled and "ENABLED" or "DISABLED")
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
    print("💡 Fullbright:", enabled and "ENABLED" or "DISABLED")
end

-- ═══════════════════════════════════════════════════════════════
-- 📋 CONFIGURAÇÃO PREMIUM
-- ═══════════════════════════════════════════════════════════════
local Categories = {
    {
        name = "COMBAT",
        icon = "⚔️",
        color = Theme.NeonPink,
        items = {
            {name = "Aimbot", desc = "Auto aim at enemies", func = Functions.toggleAimbot},
            {name = "Silent Aim", desc = "Invisible aim assistance", func = Functions.toggleAimbot},
            {name = "Triggerbot", desc = "Auto shoot when aiming", func = Functions.toggleAimbot},
            {name = "Kill Aura", desc = "Attack nearby enemies", func = Functions.toggleAimbot},
        }
    },
    {
        name = "VISUALS",
        icon = "👁️",
        color = Theme.NeonBlue,
        items = {
            {name = "Player ESP", desc = "See players through walls", func = Functions.toggleESP},
            {name = "Item ESP", desc = "Highlight items", func = Functions.toggleESP},
            {name = "Fullbright", desc = "Remove darkness", func = Functions.toggleFullbright},
            {name = "Chams", desc = "Player highlighting", func = Functions.toggleESP},
        }
    },
    {
        name = "MOVEMENT",
        icon = "🚀",
        color = Theme.NeonGreen,
        items = {
            {name = "Speed Hack", desc = "Move faster", func = function(e) Functions.toggleSpeed(e, 100) end},
            {name = "Fly Mode", desc = "Fly around the map", func = Functions.toggleFly},
            {name = "Noclip", desc = "Walk through walls", func = Functions.toggleNoclip},
            {name = "Jump Boost", desc = "Jump higher", func = Functions.toggleSpeed},
        }
    },
    {
        name = "PLAYER",
        icon = "👤",
        color = Theme.Warning,
        items = {
            {name = "God Mode", desc = "Invincibility", func = Functions.toggleAimbot},
            {name = "Infinite Health", desc = "Never die", func = Functions.toggleAimbot},
            {name = "Invisible", desc = "Hide from others", func = Functions.toggleAimbot},
            {name = "Name Spoof", desc = "Change your name", func = Functions.toggleAimbot},
        }
    },
    {
        name = "WORLD",
        icon = "🌍",
        color = Theme.Neon,
        items = {
            {name = "Teleport", desc = "Instant travel", func = Functions.toggleAimbot},
            {name = "Spawn Items", desc = "Create objects", func = Functions.toggleAimbot},
            {name = "Time Control", desc = "Change game time", func = Functions.toggleAimbot},
            {name = "Weather", desc = "Control weather", func = Functions.toggleAimbot},
        }
    },
    {
        name = "MISC",
        icon = "⚙️",
        color = Theme.Error,
        items = {
            {name = "Auto Farm", desc = "Automatic farming", func = Functions.toggleAimbot},
            {name = "Anti AFK", desc = "Stay active", func = Functions.toggleAimbot},
            {name = "Chat Spam", desc = "Spam messages", func = Functions.toggleAimbot},
            {name = "Crash Server", desc = "Lag the server", func = Functions.toggleAimbot},
        }
    }
}

-- ═══════════════════════════════════════════════════════════════
-- 🏗️ CRIAÇÃO DA UI PREMIUM
-- ═══════════════════════════════════════════════════════════════

-- ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltraModernUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Background blur effect
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 20
blurEffect.Parent = game.Lighting

-- Main container
local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Parent = screenGui
mainContainer.Size = UDim2.new(0, 1100, 0, 700)
mainContainer.Position = UDim2.new(0.5, -550, 0.5, -350)
mainContainer.BackgroundColor3 = Theme.Glass
mainContainer.BackgroundTransparency = 0.1
mainContainer.BorderSizePixel = 0

-- Glass effect corner
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainContainer

-- Gradient background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.Gradient1),
    ColorSequenceKeypoint.new(1, Theme.Gradient2)
}
gradient.Rotation = 45
gradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.8),
    NumberSequenceKeypoint.new(1, 0.9)
}
gradient.Parent = mainContainer

-- Glow effect
local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.Parent = screenGui
glow.Size = UDim2.new(0, 1140, 0, 740)
glow.Position = UDim2.new(0.5, -570, 0.5, -370)
glow.BackgroundTransparency = 1
glow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
glow.ImageColor3 = Theme.Neon
glow.ImageTransparency = 0.7
glow.ZIndex = -1

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 25)
glowCorner.Parent = glow

-- ═══════════════════════════════════════════════════════════════
-- 🎯 HEADER PREMIUM
-- ═══════════════════════════════════════════════════════════════
local header = Instance.new("Frame")
header.Name = "Header"
header.Parent = mainContainer
header.Size = UDim2.new(1, 0, 0, 80)
header.BackgroundColor3 = Theme.GlassLight
header.BackgroundTransparency = 0.3
header.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 20)
headerCorner.Parent = header

-- Header gradient
local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.Neon),
    ColorSequenceKeypoint.new(1, Theme.NeonBlue)
}
headerGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.7),
    NumberSequenceKeypoint.new(1, 0.9)
}
headerGradient.Parent = header

-- Logo/Title
local logo = Instance.new("TextLabel")
logo.Name = "Logo"
logo.Parent = header
logo.Size = UDim2.new(0, 300, 1, 0)
logo.Position = UDim2.new(0, 30, 0, 0)
logo.BackgroundTransparency = 1
logo.Text = "⚡ ULTRA CHEAT"
logo.TextColor3 = Theme.TextPrimary
logo.TextScaled = true
logo.Font = Enum.Font.GothamBold
logo.TextXAlignment = Enum.TextXAlignment.Left

-- Status indicator
local status = Instance.new("Frame")
status.Name = "Status"
status.Parent = header
status.Size = UDim2.new(0, 120, 0, 30)
status.Position = UDim2.new(1, -150, 0.5, -15)
status.BackgroundColor3 = Theme.Success
status.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 15)
statusCorner.Parent = status

local statusText = Instance.new("TextLabel")
statusText.Parent = status
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "🟢 ONLINE"
statusText.TextColor3 = Theme.TextPrimary
statusText.TextScaled = true
statusText.Font = Enum.Font.GothamBold

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
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
closeBtnCorner.CornerRadius = UDim.new(0, 20)
closeBtnCorner.Parent = closeBtn

-- ═══════════════════════════════════════════════════════════════
-- 📱 CONTENT AREA
-- ═══════════════════════════════════════════════════════════════
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Parent = mainContainer
contentArea.Size = UDim2.new(1, -40, 1, -120)
contentArea.Position = UDim2.new(0, 20, 0, 100)
contentArea.BackgroundTransparency = 1

-- Categories grid
local categoriesFrame = Instance.new("Frame")
categoriesFrame.Name = "Categories"
categoriesFrame.Parent = contentArea
categoriesFrame.Size = UDim2.new(1, 0, 1, 0)
categoriesFrame.BackgroundTransparency = 1

local gridLayout = Instance.new("UIGridLayout")
gridLayout.Parent = categoriesFrame
gridLayout.CellSize = UDim2.new(0, 340, 0, 300)
gridLayout.CellPadding = UDim2.new(0, 20, 0, 20)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ═══════════════════════════════════════════════════════════════
-- 🎴 FUNÇÃO PARA CRIAR CARDS PREMIUM
-- ═══════════════════════════════════════════════════════════════
local function createCategoryCard(category, index)
    local card = Instance.new("Frame")
    card.Name = category.name .. "Card"
    card.Parent = categoriesFrame
    card.BackgroundColor3 = Theme.GlassLight
    card.BackgroundTransparency = 0.2
    card.BorderSizePixel = 0
    card.LayoutOrder = index
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 15)
    cardCorner.Parent = card
    
    -- Card glow
    local cardGlow = Instance.new("UIStroke")
    cardGlow.Color = category.color
    cardGlow.Thickness = 2
    cardGlow.Transparency = 0.5
    cardGlow.Parent = card
    
    -- Card header
    local cardHeader = Instance.new("Frame")
    cardHeader.Name = "Header"
    cardHeader.Parent = card
    cardHeader.Size = UDim2.new(1, 0, 0, 60)
    cardHeader.BackgroundColor3 = category.color
    cardHeader.BackgroundTransparency = 0.1
    cardHeader.BorderSizePixel = 0
    
    local cardHeaderCorner = Instance.new("UICorner")
    cardHeaderCorner.CornerRadius = UDim.new(0, 15)
    cardHeaderCorner.Parent = cardHeader
    
    -- Fix bottom corners
    local headerFix = Instance.new("Frame")
    headerFix.Parent = cardHeader
    headerFix.Size = UDim2.new(1, 0, 0, 15)
    headerFix.Position = UDim2.new(0, 0, 1, -15)
    headerFix.BackgroundColor3 = category.color
    headerFix.BackgroundTransparency = 0.1
    headerFix.BorderSizePixel = 0
    
    -- Icon
    local icon = Instance.new("TextLabel")
    icon.Parent = cardHeader
    icon.Size = UDim2.new(0, 40, 0, 40)
    icon.Position = UDim2.new(0, 15, 0.5, -20)
    icon.BackgroundTransparency = 1
    icon.Text = category.icon
    icon.TextColor3 = Theme.TextPrimary
    icon.TextScaled = true
    icon.Font = Enum.Font.Gotham
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Parent = cardHeader
    title.Size = UDim2.new(1, -70, 1, 0)
    title.Position = UDim2.new(0, 60, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = category.name
    title.TextColor3 = Theme.TextPrimary
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Items container
    local itemsContainer = Instance.new("ScrollingFrame")
    itemsContainer.Name = "Items"
    itemsContainer.Parent = card
    itemsContainer.Size = UDim2.new(1, -20, 1, -80)
    itemsContainer.Position = UDim2.new(0, 10, 0, 70)
    itemsContainer.BackgroundTransparency = 1
    itemsContainer.BorderSizePixel = 0
    itemsContainer.ScrollBarThickness = 4
    itemsContainer.ScrollBarImageColor3 = category.color
    
    local itemsLayout = Instance.new("UIListLayout")
    itemsLayout.Parent = itemsContainer
    itemsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    itemsLayout.Padding = UDim.new(0, 8)
    
    -- Create items
    for i, item in ipairs(category.items) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Name = item.name
        itemFrame.Parent = itemsContainer
        itemFrame.Size = UDim2.new(1, 0, 0, 50)
        itemFrame.BackgroundColor3 = Theme.Glass
        itemFrame.BackgroundTransparency = 0.3
        itemFrame.BorderSizePixel = 0
        itemFrame.LayoutOrder = i
        
        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 10)
        itemCorner.Parent = itemFrame
        
        -- Item text
        local itemLabel = Instance.new("TextLabel")
        itemLabel.Parent = itemFrame
        itemLabel.Size = UDim2.new(1, -70, 0, 25)
        itemLabel.Position = UDim2.new(0, 15, 0, 5)
        itemLabel.BackgroundTransparency = 1
        itemLabel.Text = item.name
        itemLabel.TextColor3 = Theme.TextPrimary
        itemLabel.TextScaled = true
        itemLabel.Font = Enum.Font.GothamBold
        itemLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Item description
        local itemDesc = Instance.new("TextLabel")
        itemDesc.Parent = itemFrame
        itemDesc.Size = UDim2.new(1, -70, 0, 20)
        itemDesc.Position = UDim2.new(0, 15, 0, 25)
        itemDesc.BackgroundTransparency = 1
        itemDesc.Text = item.desc
        itemDesc.TextColor3 = Theme.TextSecondary
        itemDesc.TextScaled = true
        itemDesc.Font = Enum.Font.Gotham
        itemDesc.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Toggle switch
        local switch = Instance.new("TextButton")
        switch.Parent = itemFrame
        switch.Size = UDim2.new(0, 50, 0, 25)
        switch.Position = UDim2.new(1, -60, 0.5, -12.5)
        switch.BackgroundColor3 = Theme.GlassDark
        switch.BorderSizePixel = 0
        switch.Text = ""
        
        local switchCorner = Instance.new("UICorner")
        switchCorner.CornerRadius = UDim.new(0, 12.5)
        switchCorner.Parent = switch
        
        local knob = Instance.new("Frame")
        knob.Parent = switch
        knob.Size = UDim2.new(0, 21, 0, 21)
        knob.Position = UDim2.new(0, 2, 0.5, -10.5)
        knob.BackgroundColor3 = Theme.TextPrimary
        knob.BorderSizePixel = 0
        
        local knobCorner = Instance.new("UICorner")
        knobCorner.CornerRadius = UDim.new(0, 10.5)
        knobCorner.Parent = knob
        
        -- Switch functionality
        local isEnabled = false
        switch.MouseButton1Click:Connect(function()
            isEnabled = not isEnabled
            
            -- Animate switch
            local switchTween = TweenService:Create(switch,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = isEnabled and category.color or Theme.GlassDark}
            )
            
            local knobTween = TweenService:Create(knob,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, isEnabled and 27 or 2, 0.5, -10.5)}
            )
            
            switchTween:Play()
            knobTween:Play()
            
            -- Call function
            if item.func then
                item.func(isEnabled)
            end
        end)
        
        -- Hover effects
        itemFrame.MouseEnter:Connect(function()
            local hoverTween = TweenService:Create(itemFrame,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {BackgroundTransparency = 0.1}
            )
            hoverTween:Play()
        end)
        
        itemFrame.MouseLeave:Connect(function()
            local hoverTween = TweenService:Create(itemFrame,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {BackgroundTransparency = 0.3}
            )
            hoverTween:Play()
        end)
    end
    
    -- Update canvas size
    itemsContainer.CanvasSize = UDim2.new(0, 0, 0, itemsLayout.AbsoluteContentSize.Y + 10)
    
    return card
end

-- ═══════════════════════════════════════════════════════════════
-- 🎮 CRIAR TODAS AS CATEGORIAS
-- ═══════════════════════════════════════════════════════════════
for i, category in ipairs(Categories) do
    createCategoryCard(category, i)
end

-- ═══════════════════════════════════════════════════════════════
-- ⌨️ CONTROLES E EVENTOS
-- ═══════════════════════════════════════════════════════════════

-- Drag functionality
local dragging = false
local dragStart = nil
local startPos = nil

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainContainer.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                          startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        glow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X - 20,
                                 startPos.Y.Scale, startPos.Y.Offset + delta.Y - 20)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Close button
closeBtn.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(mainContainer,
        TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}
    )
    closeTween:Play()
    
    closeTween.Completed:Connect(function()
        screenGui.Enabled = false
    end)
end)

-- Toggle with INSERT
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
        
        if screenGui.Enabled then
            -- Entrance animation
            mainContainer.Size = UDim2.new(0, 0, 0, 0)
            mainContainer.BackgroundTransparency = 1
            
            local entranceTween = TweenService:Create(mainContainer,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 1100, 0, 700), BackgroundTransparency = 0.1}
            )
            entranceTween:Play()
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- 🚀 INICIALIZAÇÃO
-- ═══════════════════════════════════════════════════════════════

-- Save reference
_G.UltraModernUI = screenGui

-- Welcome animation
mainContainer.Size = UDim2.new(0, 0, 0, 0)
wait(0.1)

local welcomeTween = TweenService:Create(mainContainer,
    TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 1100, 0, 700)}
)
welcomeTween:Play()

-- Success message
print("╔══════════════════════════════════════════════════════════════╗")
print("║                  ⚡ ULTRA MODERN UI LOADED ⚡                ║")
print("╠══════════════════════════════════════════════════════════════╣")
print("║  🎮 Premium glassmorphism design                             ║")
print("║  🌟 Neon accents and smooth animations                      ║")
print("║  ⌨️  Press INSERT to toggle                                  ║")
print("║  🎯 6 categories with modern cards                          ║")
print("╚══════════════════════════════════════════════════════════════╝")
