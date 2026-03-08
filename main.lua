-- [[ Gwi-Ma: MASTER SCRIPT SAMBUNG KATA ]] --
-- GitHub: garenacustomerservic-cloud
-- Theme: Neon Green Gwi-Max Edition

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoBtn = Instance.new("TextButton")
local FixBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")
local Corner = Instance.new("UICorner")

-- UI SETUP
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 15, 0)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -100)
MainFrame.Size = UDim2.new(0, 160, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true

Corner.CornerRadius = UDim3.new(0, 8)
Corner.Parent = MainFrame

Title.Parent = MainFrame
Title.Text = "GWIMAX v1.0"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Code
Title.TextSize = 18

-- DATABASE SYSTEM
local KBBIData = {}
local LastUsedChar = ""

local function LoadDatabase()
    Status.Text = "SYNCING..."
    -- LINK RAW KE DATABASE BRAIN.LUA LO
    local raw_link = "https://raw.githubusercontent.com/garenacustomerservic-cloud/Sambungkatascript/main/brain.lua"
    
    local success, result = pcall(function()
        return loadstring(game:HttpGet(raw_link))()
    end)
    
    if success and type(result) == "table" then
        KBBIData = result
        Status.Text = "ONLINE"
        Status.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        Status.Text = "OFFLINE/ERR"
        Status.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end

-- CHAT ENGINE
local function SendChat(msg)
    local TextChatService = game:GetService("TextChatService")
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end
end

local function Solve(char)
    if not char or char == "" then return end
    LastUsedChar = char:lower()
    local words = KBBIData[LastUsedChar]
    
    if words and #words > 0 then
        local picked = words[math.random(1, #words)]
        SendChat(picked)
    else
        warn("[Gwi-Ma] Abjad '"..char.."' tidak ada di database!")
    end
end

-- UI BUTTONS
local function CreateButton(name, text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = MainFrame
    btn.Text = text
    btn.Size = UDim2.new(0.8, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim3.new(0, 5)
    btnCorner.Parent = btn
    return btn
end

local AutoBtn = CreateButton("AutoBtn", "SOLVE NEXT", UDim2.new(0.1, 0, 0.25, 0), Color3.fromRGB(0, 60, 0))
local FixBtn = CreateButton("FixBtn", "FIX ERROR", UDim2.new(0.1, 0, 0.5, 0), Color3.fromRGB(80, 0, 0))

Status.Parent = MainFrame
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.8, 0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Code
Status.TextSize = 12

-- EVENTS
AutoBtn.MouseButton1Click:Connect(function()
    -- Masukkan huruf target secara manual via Prompt atau scan UI
    -- Contoh: Solve("a")
    print("[Gwi-Ma] Solve Triggered")
end)

FixBtn.MouseButton1Click:Connect(function()
    -- CORRECTION MODE: Jika visual error, tekan ini untuk ganti kata di abjad yang sama
    if LastUsedChar ~= "" then
        Solve(LastUsedChar)
    end
end)

LoadDatabase()
