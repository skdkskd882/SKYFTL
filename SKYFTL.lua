local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- UI 설정: 타이틀과 버튼만 남긴 미니멀 구성
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "SkyTpFrame"
MainFrame.Size = UDim2.new(0, 140, 0, 100)
MainFrame.Position = UDim2.new(0.5, -70, 0.5, -50)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "SKY TP 전용"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local TeleBtn = Instance.new("TextButton", MainFrame)
TeleBtn.Size = UDim2.new(0.8, 0, 0.4, 0)
TeleBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
TeleBtn.Text = "보이드"
TeleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) -- OFF: 빨강
TeleBtn.Font = Enum.Font.GothamBold
TeleBtn.TextScaled = true
TeleBtn.BorderSizePixel = 0

local isActive = false
TeleBtn.MouseButton1Click:Connect(function()
    isActive = not isActive
    TeleBtn.BackgroundColor3 = isActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
end)

-- 무량대수 X자 지그재그 로직
RunService.RenderStepped:Connect(function()
    if isActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local time = tick()
        local range = 1e30 -- 무량대수급 거리
        local x = math.sin(time * 10) * range
        local z = math.cos(time * 10) * range
        hrp.CFrame = hrp.CFrame + Vector3.new(x, 0, z)
    end
end)
