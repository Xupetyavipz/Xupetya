-- SPWARE V4 - Modern Roblox Cheat Menu
-- Purple/Black Theme with Advanced Features

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- SPWARE Configuration
local SPWARE = {
    Name = "SPWARE",
    Version = "V4.0",
    Theme = {
        Primary = Color3.fromRGB(75, 0, 130),     -- Purple
        Secondary = Color3.fromRGB(17, 17, 17),   -- Dark Gray
        Surface = Color3.fromRGB(24, 24, 24),     -- Surface
        Accent = Color3.fromRGB(144, 238, 144),   -- Green Accent
        Text = Color3.fromRGB(255, 255, 255),     -- White
        TextSecondary = Color3.fromRGB(200, 200, 200)
    }
}

-- Global Variables
local GUI = nil
local MainFrame = nil
local CurrentTab = "Combat"
local CurrentSubTab = {}
local IsVisible = true

-- Feature States
local Features = {
    Combat = {
        Aimbot = {enabled = false, fov = 100, smooth = 5, silent = false, ragebot = false},
        TriggerBot = {enabled = false, delay = 0.1},
        HitboxExpander = {enabled = false, size = 10},
        OneShotKill = {enabled = false},
        NoRecoil = {enabled = false},
        NoSpread = {enabled = false},
        InfiniteAmmo = {enabled = false}
    },
    Movement = {
        BunnyHop = {enabled = false},
        StrafeHack = {enabled = false},
        SpeedHack = {enabled = false, speed = 50},
        Fly = {enabled = false, speed = 50},
        Jetpack = {enabled = false},
        NoClip = {enabled = false},
        TeleportKill = {enabled = false}
    },
    Visuals = {
        ESPPlayers = {enabled = false, box = true, skeleton = false, headDot = false},
        ESPWeapons = {enabled = false},
        ESPItems = {enabled = false},
        Chams = {enabled = false},
        Glow = {enabled = false},
        RadarHack = {enabled = false},
        CustomCrosshair = {enabled = false},
        NightVision = {enabled = false},
        FullBright = {enabled = false}
    },
    Roleplay = {
        SpawnCars = {enabled = false},
        SuperSpeedCar = {enabled = false},
        FlyCar = {enabled = false},
        BoatSpawner = {enabled = false},
        HeliSpawner = {enabled = false},
        SpawnWeapons = {enabled = false},
        DualWield = {enabled = false},
        ItemSpawner = {enabled = false},
        Morphs = {enabled = false},
        CustomClothes = {enabled = false},
        SizeChanger = {enabled = false, size = 1},
        InvisibleMode = {enabled = false},
        Godmode = {enabled = false},
        TeleportLocations = {enabled = false},
        FlyAnimated = {enabled = false},
        UnlimitedEmotes = {enabled = false},
        AutoFarmMoney = {enabled = false},
        AutoCollectItems = {enabled = false},
        TPToFriends = {enabled = false},
        UnlockAnimations = {enabled = false},
        AutoDailyRewards = {enabled = false},
        AutoBuy = {enabled = false},
        FastWorkMode = {enabled = false},
        OpenAllDoors = {enabled = false},
        TeleportAllCars = {enabled = false},
        LightControl = {enabled = false},
        WeatherChanger = {enabled = false},
        SpawnProps = {enabled = false},
        DisableGravity = {enabled = false},
        SuperJump = {enabled = false}
    },
    BloxFruits = {
        AutoFarmLevel = {enabled = false},
        AutoFarmBoss = {enabled = false},
        AutoFarmQuest = {enabled = false},
        AutoFarmFruits = {enabled = false},
        AutoFarmMastery = {enabled = false},
        AutoAimSkills = {enabled = false},
        NoCooldownSkills = {enabled = false},
        SkillSpam = {enabled = false},
        KillAura = {enabled = false},
        DamageMultiplier = {enabled = false, multiplier = 2},
        TPToSea = {enabled = false},
        TPToIsland = {enabled = false},
        TPToNPC = {enabled = false},
        TPToFruits = {enabled = false},
        ESPFruits = {enabled = false},
        AutoFruitSniper = {enabled = false},
        WalkOnWater = {enabled = false},
        AutoBuyFruits = {enabled = false},
        RaidHelper = {enabled = false}
    }
}

-- Car List
local CarList = {}
local PlayerList = {}

-- Notification System
local function ShowNotification(message)
    StarterGui:SetCore("SendNotification", {
        Title = "SPWARE";
        Text = message;
        Duration = 3;
    })
end

-- Create Main GUI
local function CreateGUI()
    -- Destroy existing GUI
    if GUI then
        GUI:Destroy()
    end
    
    -- Create ScreenGui
    GUI = Instance.new("ScreenGui")
    GUI.Name = "SPWARE_V4"
    GUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
    GUI.ResetOnSpawn = false
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = GUI
    MainFrame.BackgroundColor3 = SPWARE.Theme.Secondary
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
    MainFrame.Size = UDim2.new(0, 800, 0, 600)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    -- Add corner radius
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = MainFrame
    
    -- Add shadow effect
    local Shadow = Instance.new("Frame")
    Shadow.Name = "Shadow"
    Shadow.Parent = GUI
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 0.7
    Shadow.BorderSizePixel = 0
    Shadow.Position = UDim2.new(0.5, -405, 0.5, -295)
    Shadow.Size = UDim2.new(0, 810, 0, 610)
    Shadow.ZIndex = MainFrame.ZIndex - 1
    
    local ShadowCorner = Instance.new("UICorner")
    ShadowCorner.CornerRadius = UDim.new(0, 8)
    ShadowCorner.Parent = Shadow
    
    -- Create Title Bar
    local TitleBar = CreateTitleBar(MainFrame)
    
    -- Create Tab List
    local TabList = Instance.new("Frame")
    TabList.Name = "TabList"
    TabList.Parent = MainFrame
    TabList.BackgroundColor3 = SPWARE.Theme.Surface
    TabList.BorderSizePixel = 0
    TabList.Position = UDim2.new(0, 0, 0, 40)
    TabList.Size = UDim2.new(0, 200, 1, -40)
    
    local TabListCorner = Instance.new("UICorner")
    TabListCorner.CornerRadius = UDim.new(0, 8)
    TabListCorner.Parent = TabList
    
    -- Create Tab Buttons
    local TabButtons = {}
    for i, tab in pairs({"Combat", "Movement", "Visuals", "Roleplay", "BloxFruits"}) do
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tab
        TabButton.Parent = TabList
        TabButton.BackgroundTransparency = 1
        TabButton.Position = UDim2.new(0, 0, 0, (i - 1) * 40)
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Text = tab
        TabButton.TextColor3 = SPWARE.Theme.Text
        TabButton.TextSize = 16
        
        TabButton.MouseButton1Click:Connect(function()
            CurrentTab = tab
            -- Update tab content
        end)
        
        table.insert(TabButtons, TabButton)
    end
    
    -- Create Tab Content
    local TabContent = Instance.new("Frame")
    TabContent.Name = "TabContent"
    TabContent.Parent = MainFrame
    TabContent.BackgroundColor3 = SPWARE.Theme.Surface
    TabContent.BorderSizePixel = 0
    TabContent.Position = UDim2.new(0.25, 0, 0, 40)
    TabContent.Size = UDim2.new(0.75, 0, 1, -40)
    
    local TabContentCorner = Instance.new("UICorner")
    TabContentCorner.CornerRadius = UDim.new(0, 8)
    TabContentCorner.Parent = TabContent
    
    -- Create tab content for each tab
    for i, tab in pairs({"Combat", "Movement", "Visuals", "Roleplay", "BloxFruits"}) do
        local TabContentFrame = Instance.new("Frame")
        TabContentFrame.Name = tab
        TabContentFrame.Parent = TabContent
        TabContentFrame.BackgroundColor3 = SPWARE.Theme.Surface
        TabContentFrame.BorderSizePixel = 0
        TabContentFrame.Size = UDim2.new(1, 0, 1, 0)
        TabContentFrame.Visible = tab == CurrentTab
        
        -- Create content for each tab
        if tab == "Combat" then
            -- Combat tab content
        elseif tab == "Movement" then
            -- Movement tab content
        elseif tab == "Visuals" then
            -- Visuals tab content
        elseif tab == "Roleplay" then
            -- Roleplay tab content
        elseif tab == "BloxFruits" then
            -- BloxFruits tab content
        end
    end
    
    return MainFrame
end

-- Create Title Bar
local function CreateTitleBar(parent)
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = parent
    TitleBar.BackgroundColor3 = SPWARE.Theme.Primary
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = TitleBar
    
    -- Fix corner for bottom
    local CornerFix = Instance.new("Frame")
    CornerFix.Parent = TitleBar
    CornerFix.BackgroundColor3 = SPWARE.Theme.Primary
    CornerFix.BorderSizePixel = 0
    CornerFix.Position = UDim2.new(0, 0, 0.5, 0)
    CornerFix.Size = UDim2.new(1, 0, 0.5, 0)
    
    -- Title Text
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TitleBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = SPWARE.Name .. " " .. SPWARE.Version
    Title.TextColor3 = SPWARE.Theme.Text
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.Size = UDim2.new(0, 40, 1, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = SPWARE.Theme.Text
    CloseButton.TextSize = 16
    
    CloseButton.MouseButton1Click:Connect(function()
        IsVisible = false
        GUI.Enabled = false
    end)
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TitleBar
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
    MinimizeButton.Size = UDim2.new(0, 40, 1, 0)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = SPWARE.Theme.Text
    MinimizeButton.TextSize = 16
    
    MinimizeButton.MouseButton1Click:Connect(function()
        IsVisible = false
        GUI.Enabled = false
    end)
    
    return TitleBar
end
