local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Config = {
    Aimbot = false, KillAura = false, Flight = false, Noclip = false,
    GodMode = false, AutoFarm = false, InfiniteJump = false, SpeedHack = false
}

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 495)
MainFrame.Position = UDim2.new(0.3, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, 0, 0, 50)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabBar.BorderSizePixel = 0

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, 0, 1, -50)
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.BackgroundTransparency = 1

local features = {"Aimbot", "KillAura", "Flight", "Noclip", "GodMode", "AutoFarm", "InfiniteJump", "SpeedHack"}

local layout = Instance.new("UIGridLayout", ContentFrame)
layout.CellSize = UDim2.new(0, 330, 0, 45)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

for _, name in pairs(features) do
    local B = Instance.new("TextButton", ContentFrame)
    B.Text = name -- 기능 이름 추가
    B.TextColor3 = Color3.fromRGB(255, 255, 255)
    B.Font = Enum.Font.SourceSansBold
    B.TextScaled = true
    B.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    B.BorderSizePixel = 0
    B.MouseButton1Click:Connect(function()
        Config[name] = not Config[name]
        B.BackgroundColor3 = Config[name] and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 40, 40)
    end)
end

RunService.RenderStepped:Connect(function()
    if Config.Noclip and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
    if Config.SpeedHack and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = 66
    end
    if Config.Aimbot then
        local target = nil
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                target = p
                break
            end
        end
        if target then
            local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("RemoteEvent") then
                tool.RemoteEvent:FireServer(target.Character.Head.Position)
            end
        end
    end
end)
