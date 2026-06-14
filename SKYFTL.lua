local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Config = {
    Aimbot = false, Ragebot = false, SilenceBot = false,
    AutoCombat = false, Flight = false, VoidTeleport = false,
    ESP = false, SilentShot = false, BulletSpeed = 25
}

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local TabBar = Instance.new("Frame", MainFrame)
local ContentFrame = Instance.new("Frame", MainFrame)

MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true

TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1

local tabs = { Combat = {"Aimbot", "Ragebot", "SilenceBot", "SilentShot", "AutoCombat"}, Misc = {"Flight", "VoidTeleport", "ESP", "Slider"} }
local currentTab = "Combat"

local function renderButtons()
    ContentFrame:ClearAllChildren()
    local layout = Instance.new("UIGridLayout", ContentFrame)
    layout.CellSize = UDim2.new(0, 280, 0, 40)
    
    if currentTab == "Misc" then
        local SliderBar = Instance.new("Frame", ContentFrame)
        SliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        local SliderBtn = Instance.new("TextButton", SliderBar)
        SliderBtn.Size = UDim2.new(0, 20, 1, 0)
        SliderBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        SliderBtn.Text = ""
        
        SliderBtn.MouseButton1Click:Connect(function()
            local mousePos = UserInputService:GetMouseLocation()
            local relativeX = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            SliderBtn.Position = UDim2.new(relativeX, 0, 0, 0)
            -- 0.1 ~ 50 범위 설정
            Config.BulletSpeed = 0.1 + (relativeX * 49.9)
        end)
    end

    for _, btnName in pairs(tabs[currentTab]) do
        if btnName ~= "Slider" then
            local B = Instance.new("TextButton", ContentFrame)
            B.Text = ""
            B.BackgroundColor3 = Config[btnName] and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 40, 40)
            B.MouseButton1Click:Connect(function()
                Config[btnName] = not Config[btnName]
                B.BackgroundColor3 = Config[btnName] and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 40, 40)
            end)
        end
    end
end

for name, _ in pairs(tabs) do
    local T = Instance.new("TextButton", TabBar)
    T.Size = UDim2.new(0.5, 0, 1, 0)
    T.Position = UDim2.new(name == "Combat" and 0 or 0.5, 0, 0, 0)
    T.Text = ""
    T.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    T.MouseButton1Click:Connect(function()
        currentTab = name
        renderButtons()
    end)
end

renderButtons()
