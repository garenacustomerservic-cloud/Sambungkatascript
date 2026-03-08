-- [[ Gwi-Ma: MASTER SCRIPT FIX ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Status = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 10, 0)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -80, 0.5, -100)
MainFrame.Size = UDim2.new(0, 160, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "GWIMAX PANEL"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1

Status.Parent = MainFrame
Status.Text = "SYNCING..."
Status.TextColor3 = Color3.fromRGB(0, 255, 0)
Status.Position = UDim2.new(0, 0, 0.8, 0)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.BackgroundTransparency = 1

-- FUNGSI TOMBOL (Gue taro di sini biar kelihatan biarpun DB error)
local function MakeBtn(txt, pos, color)
    local b = Instance.new("TextButton")
    b.Parent = MainFrame
    b.Text = txt
    b.Size = UDim2.new(0.8, 0, 0, 35)
    b.Position = pos
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    return b
end

local AutoBtn = MakeBtn("SOLVE", UDim2.new(0.1, 0, 0.25, 0), Color3.fromRGB(0, 50, 0))
local FixBtn = MakeBtn("FIX ERROR", UDim2.new(0.1, 0, 0.5, 0), Color3.fromRGB(50, 0, 0))

-- LOAD DATA
local raw = "https://raw.githubusercontent.com/garenacustomerservic-cloud/Sambungkatascript/main/brain.lua"
local success, result = pcall(function() return loadstring(game:HttpGet(raw))() end)

if success and type(result) == "table" then
    Status.Text = "DB: ONLINE"
else
    Status.Text = "DB: FAILED (CHECK RAW)"
    Status.TextColor3 = Color3.new(1,0,0)
end
