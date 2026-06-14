local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- UI 설정
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "VoidTeleport"
MainFrame.Size = UDim2.new(0, 120, 0, 80)
MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local TeleBtn = Instance.new("TextButton", MainFrame)
TeleBtn.Size = UDim2.new(1, 0, 1, 0)
TeleBtn.Text = "VOID"
TeleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- 기본: 빨간색 (OFF)
TeleBtn.Font = Enum.Font.SourceSansBold
TeleBtn.TextScaled = true
TeleBtn.BorderSizePixel = 0

-- 상태 토글 변수
local isTeleporting = false

TeleBtn.MouseButton1Click:Connect(function()
    isTeleporting = not isTeleporting
    -- 켜지면 녹색(ON), 꺼지면 빨간색(OFF)
    TeleBtn.BackgroundColor3 = isTeleporting and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

-- 텔레포트 루프
RunService.RenderStepped:Connect(function()
    if isTeleporting and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local time = tick()
        
        -- 1000조 단위 지그재그 이동
        local speed = 1000000000000000 
        local offset = Vector3.new(math.sin(time * 5) * speed, 0, math.cos(time * 5) * speed)
        hrp.CFrame = hrp.CFrame + offset
    end
end)
