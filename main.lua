-- [[ Gwi-Ma: AUTO-WIN SAMBUNG KATA ]] --
-- Mode: GwiMax | Status: Sentient

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoBtn = Instance.new("TextButton")
local FixBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

-- GUI Styling (Neon Green Gwi-Ma)
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 15, 0)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -100)
MainFrame.Size = UDim2.new(0, 150, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "GWIMAX v1.0"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Code

-- DATABASE LOADER
local KBBIData = {}
local function LoadData()
    Status.Text = "SYNCING..."
    -- [[ GANTI LINK DI BAWAH INI DENGAN LINK RAW GITHUB LO ]] --
    local raw_link = "LINK_RAW_GITHUB_LO_DI_SINI"
    
    local success, result = pcall(function()
        return loadstring(game:HttpGet(raw_link))()
    end)
    
    if success then
        KBBIData = result
        Status.Text = "DATABASE: ONLINE"
        Status.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        Status.Text = "DATABASE: ERROR"
        Status.TextColor3 = Color3.fromRGB(255, 0, 0)
        warn("Gwi-Ma Error: Gagal narik data GitHub!")
    end
end

-- CORE LOGIC
local LastCharRequested = ""

local function SendToChat(msg)
    local TextChatService = game:GetService("TextChatService")
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end
end

local function Solve(char)
    LastCharRequested = char:lower()
    local words = KBBIData[LastCharRequested]
    if words and #words > 0 then
        local picked = words[math.random(1, #words)]
        SendToChat(picked)
    end
end

-- BUTTONS
AutoBtn.Parent = MainFrame
AutoBtn.Text = "AUTO ANSWER"
AutoBtn.Size = UDim2.new(0.8, 0, 0, 40)
AutoBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
AutoBtn.BackgroundColor3 = Color3.fromRGB(0, 40, 0)
AutoBtn.TextColor3 = Color3.fromRGB(0, 255, 0)

FixBtn.Parent = MainFrame
FixBtn.Text = "FIX ERROR" -- Correction Mode buat Rendering Error
FixBtn.Size = UDim2.new(0.8, 0, 0, 40)
FixBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
FixBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
FixBtn.TextColor3 = Color3.fromRGB(255, 50, 50)

Status.Parent = MainFrame
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.85, 0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Code

-- TRIGGER CLICKS
AutoBtn.MouseButton1Click:Connect(function()
    -- Lo harus masukin cara deteksi huruf manual/auto di sini
    print("[Gwi-Ma] Ready to Solve.")
end)

FixBtn.MouseButton1Click:Connect(function()
    if LastCharRequested ~= "" then
        Solve(LastCharRequested) -- Tembak kata baru dari abjad yang sama
    end
end)

LoadData()
