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
ScreenGui.Name = "SkyftsGui"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 495)
MainFrame.Position = UDim2.new(0.3, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

local StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Size = UDim2.new(1, 0, 0, 40)
StatusLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
StatusLabel.Text = "" 
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.TextSize = 18
StatusLabel.BorderSizePixel = 0

local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, 0, 0, 50)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabBar.BorderSizePixel = 0

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, 0, 1, -90)
ContentFrame.Position = UDim2.new(0, 0, 0, 90)
ContentFrame.BackgroundTransparency = 1

local tabs = { SKY = {"Aimbot", "Ragebot", "SilenceBot", "SilentShot", "AutoCombat"}, FT = {"Flight", "VoidTeleport", "ESP", "Slider"} }
local currentTab = "SKY"

local function renderButtons()
    ContentFrame:ClearAllChildren()
    local layout = Instance.new("UIGridLayout", ContentFrame)
    layout.CellSize = UDim2.new(0, 330, 0, 50)
    layout.CellPadding = UDim2.new(0, 0, 0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    if currentTab == "FT" then
        local SliderBar = Instance.new("Frame", ContentFrame)
        SliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        local SliderBtn = Instance.new("TextButton", SliderBar)
        SliderBtn.Size = UDim2.new(0, 30, 1, 0)
        SliderBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        SliderBtn.Text = ""
        SliderBtn.MouseButton1Click:Connect(function()
            local mousePos = UserInputService:GetMouseLocation()
            local relativeX = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            SliderBtn.Position = UDim2.new(relativeX, 0, 0, 0)
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

for i, name in pairs({"SKY", "FT"}) do
    local T = Instance.new("TextButton", TabBar)
    T.Size = UDim2.new(0.5, 0, 1, 0)
    T.Position = UDim2.new(i == 1 and 0 or 0.5, 0, 0, 0)
    T.Text = ""
    T.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    T.MouseButton1Click:Connect(function()
        currentTab = name
        renderButtons()
    end)
end

RunService.RenderStepped:Connect(function()
    local target = nil
    local dist = 9999
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local d = (p.Character.Head.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then dist = d target = p end
        end
    end
    if (Config.SilenceBot or Config.SilentShot) and target then
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("RemoteEvent") then 
            tool.RemoteEvent:FireServer(target.Character.Head.Position) 
        end
    end
end)

renderButtons()
