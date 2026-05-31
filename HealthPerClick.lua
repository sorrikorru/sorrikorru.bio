local Lib = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local C = {
    win = Color3.fromRGB(13, 15, 20),
    sidebar = Color3.fromRGB(10, 11, 16),
    card = Color3.fromRGB(20, 22, 30),
    cardHov = Color3.fromRGB(26, 29, 40),
    item = Color3.fromRGB(17, 19, 26),
    itemHov = Color3.fromRGB(24, 27, 37),
    border = Color3.fromRGB(38, 42, 58),
    accent = Color3.fromRGB(124, 111, 247),
    accentHov = Color3.fromRGB(150, 138, 255),
    accentDim = Color3.fromRGB(80, 70, 180),
    txt = Color3.fromRGB(228, 228, 240),
    txtDim = Color3.fromRGB(110, 115, 140),
    txtMid = Color3.fromRGB(170, 172, 195),
    red = Color3.fromRGB(220, 60, 60),
    redHov = Color3.fromRGB(245, 80, 80),
    green = Color3.fromRGB(72, 199, 142),
    trackOff = Color3.fromRGB(45, 48, 65),
    white = Color3.new(1, 1, 1),
}

local function tw(obj, props, t, sty, dir)
    if not obj or not obj.Parent then return end
    TweenService:Create(obj, TweenInfo.new(t or 0.18, sty or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props):Play()
end

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
    return c
end

local function stroke(p, col, th, trans)
    local s = Instance.new("UIStroke")
    s.Color = col or C.border
    s.Thickness = th or 1
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = p
    return s
end

local function pad(p, t, b, l, r)
    local u = Instance.new("UIPadding")
    u.PaddingTop = UDim.new(0, t or 0)
    u.PaddingBottom = UDim.new(0, b or 0)
    u.PaddingLeft = UDim.new(0, l or 0)
    u.PaddingRight = UDim.new(0, r or 0)
    u.Parent = p
    return u
end

local function vlist(p, gap)
    local l = Instance.new("UIListLayout")
    l.FillDirection = Enum.FillDirection.Vertical
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Padding = UDim.new(0, gap or 0)
    l.Parent = p
    return l
end

local function label(p, text, font, size, col, xalign)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Text = text or ""
    l.Font = font or Enum.Font.Gotham
    l.TextSize = size or 13
    l.TextColor3 = col or C.txt
    l.TextXAlignment = xalign or Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.Parent = p
    return l
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "Sorrikorru"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.DisplayOrder = 999
pcall(function() Gui.Parent = game:GetService("CoreGui") end)
if not Gui.Parent then Gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local W = Instance.new("Frame")
W.Name = "Window"
W.Parent = Gui
W.AnchorPoint = Vector2.new(0, 0)
W.Size = UDim2.new(0, 680, 0, 440)
W.BackgroundColor3 = C.win
W.BorderSizePixel = 0
W.ClipsDescendants = true
W.Visible = false
corner(W, 14)
stroke(W, C.border, 1, 0.3)

task.defer(function()
    local camera = workspace.CurrentCamera
    if camera then
        local vp = camera.ViewportSize
        W.Position = UDim2.fromOffset(
            math.floor((vp.X - 680) / 2),
            math.floor((vp.Y - 440) / 2)
        )
    end
end)

local TB = Instance.new("Frame")
TB.Name = "TitleBar"
TB.Size = UDim2.new(1, 0, 0, 48)
TB.BackgroundColor3 = C.sidebar
TB.BorderSizePixel = 0
TB.ZIndex = 3
TB.Parent = W
corner(TB, 14)

local TBPatch = Instance.new("Frame")
TBPatch.Size = UDim2.new(1, 0, 0, 14)
TBPatch.Position = UDim2.new(0, 0, 1, -14)
TBPatch.BackgroundColor3 = C.sidebar
TBPatch.BorderSizePixel = 0
TBPatch.ZIndex = 3
TBPatch.Parent = TB

local TBLine = Instance.new("Frame")
TBLine.Size = UDim2.new(1, 0, 0, 1)
TBLine.Position = UDim2.new(0, 0, 1, 0)
TBLine.BackgroundColor3 = C.accent
TBLine.BackgroundTransparency = 0.5
TBLine.BorderSizePixel = 0
TBLine.ZIndex = 4
TBLine.Parent = TB

local LogoDot = Instance.new("Frame")
LogoDot.Size = UDim2.new(0, 10, 0, 10)
LogoDot.Position = UDim2.new(0, 18, 0.5, -5)
LogoDot.BackgroundColor3 = C.accent
LogoDot.BorderSizePixel = 0
LogoDot.ZIndex = 5
LogoDot.Parent = TB
corner(LogoDot, 5)

local PulseRing = Instance.new("Frame")
PulseRing.Size = UDim2.new(0, 10, 0, 10)
PulseRing.AnchorPoint = Vector2.new(0.5, 0.5)
PulseRing.Position = UDim2.new(0, 23, 0.5, 0)
PulseRing.BackgroundTransparency = 1
PulseRing.BorderSizePixel = 0
PulseRing.ZIndex = 4
PulseRing.Parent = TB
corner(PulseRing, 8)
stroke(PulseRing, C.accent, 1, 0.4)

task.spawn(function()
    while PulseRing and PulseRing.Parent do
        tw(PulseRing, {Size = UDim2.new(0, 20, 0, 20), BackgroundTransparency = 1}, 0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local ps = PulseRing:FindFirstChildOfClass("UIStroke")
        if ps then tw(ps, {Transparency = 1}, 0.9) end
        task.wait(0.9)
        PulseRing.Size = UDim2.new(0, 10, 0, 10)
        local ps2 = PulseRing:FindFirstChildOfClass("UIStroke")
        if ps2 then ps2.Transparency = 0.4 end
        task.wait(1.2)
    end
end)

local TitleLbl = label(TB, "Sorrikorru", Enum.Font.GothamBold, 14, C.txt)
TitleLbl.Position = UDim2.new(0, 38, 0, 0)
TitleLbl.Size = UDim2.new(1, -200, 1, 0)
TitleLbl.ZIndex = 5

local VerBadge = Instance.new("Frame")
VerBadge.Size = UDim2.new(0, 50, 0, 16)
VerBadge.Position = UDim2.new(0, 38 + 90, 0.5, -8)
VerBadge.BackgroundColor3 = C.accent
VerBadge.BackgroundTransparency = 0.7
VerBadge.BorderSizePixel = 0
VerBadge.ZIndex = 5
VerBadge.Parent = TB
corner(VerBadge, 4)
local VerTxt = label(VerBadge, "v.0.5", Enum.Font.GothamBold, 9, C.accent)
VerTxt.Size = UDim2.new(1, 0, 1, 0)
VerTxt.ZIndex = 6
VerTxt.TextXAlignment = Enum.TextXAlignment.Center

local function ctrlBtn(offsetX, bg, txt, tsz)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 30, 0, 20)
    b.AnchorPoint = Vector2.new(1, 0.5)
    b.Position = UDim2.new(1, offsetX, 0.5, 0)
    b.BackgroundColor3 = bg
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = tsz or 13
    b.TextColor3 = C.white
    b.AutoButtonColor = false
    b.TextXAlignment = Enum.TextXAlignment.Center
    b.TextYAlignment = Enum.TextYAlignment.Center
    b.ZIndex = 6
    b.Parent = TB
    corner(b, 6)
    return b
end

local CloseBtn = ctrlBtn(-12, C.red, "X", 12)
local MinBtn = ctrlBtn(-48, Color3.fromRGB(40, 44, 60), "_", 14)

CloseBtn.MouseEnter:Connect(function() tw(CloseBtn, {BackgroundColor3 = C.redHov}, 0.1) end)
CloseBtn.MouseLeave:Connect(function() tw(CloseBtn, {BackgroundColor3 = C.red}, 0.1) end)
MinBtn.MouseEnter:Connect(function() tw(MinBtn, {BackgroundColor3 = Color3.fromRGB(55, 60, 80)}, 0.1) end)
MinBtn.MouseLeave:Connect(function() tw(MinBtn, {BackgroundColor3 = Color3.fromRGB(40, 44, 60)}, 0.1) end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        tw(W, {Size = UDim2.new(0, 680, 0, 48)}, 0.2, Enum.EasingStyle.Quart)
    else
        tw(W, {Size = UDim2.new(0, 680, 0, 440)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    tw(W, {Size = UDim2.new(0, 680, 0, 0), BackgroundTransparency = 1}, 0.18)
    task.delay(0.2, function()
        W.Visible = false
        W.Size = UDim2.new(0, 680, 0, 440)
        W.BackgroundTransparency = 0
    end)
end)

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function ClampWindow(x, y)
    local camera = workspace.CurrentCamera
    if not camera then
        return x, y
    end

    local screen = camera.ViewportSize
    local size = W.AbsoluteSize

    x = math.clamp(x, 0, math.max(0, screen.X - size.X))
    y = math.clamp(y, 0, math.max(0, screen.Y - size.Y))

    return x, y
end

local function UpdateDrag(input)
    local delta = input.Position - dragStart

    local x = startPos.X.Offset + delta.X
    local y = startPos.Y.Offset + delta.Y

    x, y = ClampWindow(x, y)

    W.Position = UDim2.fromOffset(x, y)
end

TB.InputBegan:Connect(function(input)
    local t = input.UserInputType

    if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = W.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TB.InputChanged:Connect(function(input)
    local t = input.UserInputType

    if t == Enum.UserInputType.MouseMovement or t == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input == dragInput then
        UpdateDrag(input)
    end
end)

UIS.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode ~= Enum.KeyCode.LeftShift then return end
    if W.Visible then
        tw(W, {Size = UDim2.new(0, 680, 0, 0)}, 0.16, Enum.EasingStyle.Quart)
        task.delay(0.17, function()
            W.Visible = false
            W.Size = UDim2.new(0, 680, 0, 440)
        end)
    else
        W.Size = UDim2.new(0, 680, 0, 0)
        W.Visible = true
        tw(W, {Size = UDim2.new(0, 680, 0, 440)}, 0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end
end)

local SIDEBAR_W = 160

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, SIDEBAR_W, 1, -49)
Sidebar.Position = UDim2.new(0, 0, 0, 49)
Sidebar.BackgroundColor3 = C.sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.Parent = W

vlist(Sidebar, 2)
pad(Sidebar, 8, 8, 8, 8)

local SBorder = Instance.new("Frame")
SBorder.Size = UDim2.new(0, 1, 1, -49)
SBorder.Position = UDim2.new(0, SIDEBAR_W, 0, 49)
SBorder.BackgroundColor3 = C.border
SBorder.BorderSizePixel = 0
SBorder.BackgroundTransparency = 0.5
SBorder.Parent = W

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -(SIDEBAR_W + 1), 1, -49)
Content.Position = UDim2.new(0, SIDEBAR_W + 1, 0, 49)
Content.BackgroundColor3 = C.win
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.Parent = W

local activeSlider = nil
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        activeSlider = nil
    end
end)
UIS.InputChanged:Connect(function(i)
    if activeSlider and i.UserInputType == Enum.UserInputType.MouseMovement then
        activeSlider.update(i.Position.X)
    end
end)

local openDropdown = nil
local activePage = nil

function Lib:CreateWindow(cfg)
    cfg = cfg or {}
    TitleLbl.Text = cfg.Title or "Sorrikorru"
    if cfg.Accent then
        C.accent = cfg.Accent
        LogoDot.BackgroundColor3 = C.accent
        TBLine.BackgroundColor3 = C.accent
        VerTxt.TextColor3 = C.accent
    end
    W.Visible = true
    W.Size = UDim2.new(0, 680, 0, 0)
    tw(W, {Size = UDim2.new(0, 680, 0, 440)}, 0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    return Lib
end

function Lib:CreateTab(name, icon)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = C.accent
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.Parent = Content
    vlist(Page, 10)
    pad(Page, 16, 16, 16, 16)

    local Pill = Instance.new("Frame")
    Pill.Size = UDim2.new(1, 0, 0, 40)
    Pill.BackgroundColor3 = C.sidebar
    Pill.BackgroundTransparency = 1
    Pill.BorderSizePixel = 0
    Pill.Parent = Sidebar
    corner(Pill, 9)

    local ActiveBar = Instance.new("Frame")
    ActiveBar.Size = UDim2.new(0, 3, 0.55, 0)
    ActiveBar.AnchorPoint = Vector2.new(0, 0.5)
    ActiveBar.Position = UDim2.new(0, 0, 0.5, 0)
    ActiveBar.BackgroundColor3 = C.accent
    ActiveBar.BorderSizePixel = 0
    ActiveBar.Visible = false
    ActiveBar.Parent = Pill
    corner(ActiveBar, 2)

    local IconCircle = Instance.new("Frame")
    IconCircle.Size = UDim2.new(0, 26, 0, 26)
    IconCircle.AnchorPoint = Vector2.new(0, 0.5)
    IconCircle.Position = UDim2.new(0, 10, 0.5, 0)
    IconCircle.BackgroundColor3 = C.accent
    IconCircle.BackgroundTransparency = 0.8
    IconCircle.BorderSizePixel = 0
    IconCircle.Parent = Pill
    corner(IconCircle, 8)

    if icon then
        local IconLbl = label(IconCircle, icon, Enum.Font.GothamBold, 13, C.accent)
        IconLbl.Size = UDim2.new(1, 0, 1, 0)
        IconLbl.TextXAlignment = Enum.TextXAlignment.Center
    end

    local TabLbl = label(Pill, name, Enum.Font.Gotham, 13, C.txtDim)
    TabLbl.Position = UDim2.new(0, icon and 44 or 14, 0, 0)
    TabLbl.Size = UDim2.new(1, icon and -48 or -18, 1, 0)

    local PillBtn = Instance.new("TextButton")
    PillBtn.Size = UDim2.new(1, 0, 1, 0)
    PillBtn.BackgroundTransparency = 1
    PillBtn.Text = ""
    PillBtn.Parent = Pill

    local function activate()
        for _, ch in ipairs(Content:GetChildren()) do
            if ch:IsA("ScrollingFrame") then ch.Visible = false end
        end
        for _, ch in ipairs(Sidebar:GetChildren()) do
            if ch:IsA("Frame") then
                tw(ch, {BackgroundTransparency = 1}, 0.14)
                local bar = ch:FindFirstChild("Frame")
                if bar then bar.Visible = false end
                for _, sub in ipairs(ch:GetChildren()) do
                    if sub:IsA("TextLabel") then tw(sub, {TextColor3 = C.txtDim}, 0.14) end
                    if sub:IsA("Frame") and sub.Name == "" then
                        tw(sub, {BackgroundTransparency = 0.8}, 0.14)
                        local sl = sub:FindFirstChildOfClass("TextLabel")
                        if sl then tw(sl, {TextColor3 = C.txtDim}, 0.14) end
                    end
                end
            end
        end
        Page.Visible = true
        tw(Pill, {BackgroundTransparency = 0.88}, 0.14)
        ActiveBar.Visible = true
        tw(TabLbl, {TextColor3 = C.txt}, 0.14)
        tw(IconCircle, {BackgroundTransparency = 0.6}, 0.14)
        local ic_lbl = IconCircle:FindFirstChildOfClass("TextLabel")
        if ic_lbl then tw(ic_lbl, {TextColor3 = C.accentHov}, 0.14) end
        activePage = Page
    end

    PillBtn.MouseButton1Click:Connect(activate)
    PillBtn.MouseEnter:Connect(function()
        if Page.Visible then return end
        tw(Pill, {BackgroundTransparency = 0.93}, 0.12)
    end)
    PillBtn.MouseLeave:Connect(function()
        if Page.Visible then return end
        tw(Pill, {BackgroundTransparency = 1}, 0.12)
    end)

    if activePage == nil then activate() end

    local tabAPI = {}

    function tabAPI:CreateSection(title)
        local Sec = Instance.new("Frame")
        Sec.Size = UDim2.new(1, 0, 0, 0)
        Sec.AutomaticSize = Enum.AutomaticSize.Y
        Sec.BackgroundColor3 = C.card
        Sec.BorderSizePixel = 0
        Sec.Parent = Page
        corner(Sec, 10)
        stroke(Sec, C.border, 1, 0.45)

        local SecBar = Instance.new("Frame")
        SecBar.Size = UDim2.new(0, 3, 1, 0)
        SecBar.BackgroundColor3 = C.accent
        SecBar.BackgroundTransparency = 0.4
        SecBar.BorderSizePixel = 0
        SecBar.Parent = Sec
        corner(SecBar, 2)

        vlist(Sec, 0)
        pad(Sec, 12, 12, 16, 14)

        local order = 0

        if title and title ~= "" then
            local SHdr = Instance.new("Frame")
            SHdr.Size = UDim2.new(1, 0, 0, 24)
            SHdr.BackgroundTransparency = 1
            SHdr.LayoutOrder = order
            order = order + 1
            SHdr.Parent = Sec

            local STxt = label(SHdr, string.upper(title), Enum.Font.GothamBold, 10, C.accent)
            STxt.Size = UDim2.new(1, 0, 1, 0)
            STxt.TextTransparency = 0.1

            local SLine = Instance.new("Frame")
            SLine.Size = UDim2.new(1, 0, 0, 1)
            SLine.AnchorPoint = Vector2.new(0, 1)
            SLine.Position = UDim2.new(0, 0, 1, 0)
            SLine.BackgroundColor3 = C.border
            SLine.BorderSizePixel = 0
            SLine.BackgroundTransparency = 0.3
            SLine.Parent = SHdr
        end

        local secAPI = {}

        local function makeRow(h)
            local R = Instance.new("Frame")
            R.Size = UDim2.new(1, 0, 0, h or 44)
            R.BackgroundColor3 = C.item
            R.BackgroundTransparency = 1
            R.BorderSizePixel = 0
            R.LayoutOrder = order
            order = order + 1
            R.Parent = Sec

            local HBtn = Instance.new("TextButton")
            HBtn.Size = UDim2.new(1, 0, 1, 0)
            HBtn.BackgroundColor3 = C.itemHov
            HBtn.BackgroundTransparency = 1
            HBtn.Text = ""
            HBtn.AutoButtonColor = false
            HBtn.ZIndex = 0
            HBtn.Parent = R
            corner(HBtn, 6)

            HBtn.MouseEnter:Connect(function() tw(HBtn, {BackgroundTransparency = 0.82}, 0.1) end)
            HBtn.MouseLeave:Connect(function() tw(HBtn, {BackgroundTransparency = 1}, 0.1) end)

            return R
        end

        local function rowLabel(R, text, dim)
            local l = label(R, text, Enum.Font.Gotham, 13, dim and C.txtMid or C.txt)
            l.Position = UDim2.new(0, 6, 0, 0)
            l.Size = UDim2.new(0.55, 0, 1, 0)
            return l
        end

        function secAPI:CreateButton(text, callback)
            local R = makeRow(44)
            rowLabel(R, text)

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(0, 90, 0, 28)
            Btn.AnchorPoint = Vector2.new(1, 0.5)
            Btn.Position = UDim2.new(1, -6, 0.5, 0)
            Btn.BackgroundColor3 = C.win
            Btn.Text = "Run"
            Btn.Font = Enum.Font.GothamBold
            Btn.TextSize = 12
            Btn.TextColor3 = C.accent
            Btn.AutoButtonColor = false
            Btn.ZIndex = 2
            Btn.Parent = R
            corner(Btn, 7)
            stroke(Btn, C.accent, 1, 0.3)

            Btn.MouseEnter:Connect(function()
                tw(Btn, {BackgroundColor3 = C.accent, TextColor3 = C.white}, 0.12)
                local s = Btn:FindFirstChildOfClass("UIStroke")
                if s then tw(s, {Transparency = 0}, 0.12) end
            end)
            Btn.MouseLeave:Connect(function()
                tw(Btn, {BackgroundColor3 = C.win, TextColor3 = C.accent}, 0.12)
                local s = Btn:FindFirstChildOfClass("UIStroke")
                if s then tw(s, {Transparency = 0.3}, 0.12) end
            end)
            Btn.MouseButton1Down:Connect(function()
                tw(Btn, {Size = UDim2.new(0, 84, 0, 26)}, 0.07)
            end)
            Btn.MouseButton1Up:Connect(function()
                tw(Btn, {Size = UDim2.new(0, 90, 0, 28)}, 0.1)
            end)
            Btn.MouseButton1Click:Connect(function()
                if callback then task.spawn(pcall, callback) end
            end)
        end

        function secAPI:CreateToggle(text, default, callback)
            local state = default == true

            local R = makeRow(44)
            rowLabel(R, text)

            local Track = Instance.new("Frame")
            Track.Size = UDim2.new(0, 46, 0, 25)
            Track.AnchorPoint = Vector2.new(1, 0.5)
            Track.Position = UDim2.new(1, -6, 0.5, 0)
            Track.BackgroundColor3 = state and C.accent or C.trackOff
            Track.BorderSizePixel = 0
            Track.ZIndex = 2
            Track.Parent = R
            corner(Track, 13)

            local Thumb = Instance.new("Frame")
            Thumb.Size = UDim2.new(0, 19, 0, 19)
            Thumb.AnchorPoint = Vector2.new(0.5, 0.5)
            Thumb.Position = state and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 13, 0.5, 0)
            Thumb.BackgroundColor3 = C.white
            Thumb.BorderSizePixel = 0
            Thumb.ZIndex = 3
            Thumb.Parent = Track
            corner(Thumb, 10)
            stroke(Thumb, Color3.fromRGB(0, 0, 0), 1, 0.7)

            local HitBox = Instance.new("TextButton")
            HitBox.Size = UDim2.new(1, 0, 1, 0)
            HitBox.BackgroundTransparency = 1
            HitBox.Text = ""
            HitBox.ZIndex = 4
            HitBox.Parent = Track

            HitBox.MouseButton1Click:Connect(function()
                state = not state
                tw(Track, {BackgroundColor3 = state and C.accent or C.trackOff}, 0.18)
                tw(Thumb, {Position = state and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 13, 0.5, 0)}, 0.18, Enum.EasingStyle.Back)
                if callback then task.spawn(pcall, callback, state) end
            end)
        end

        function secAPI:CreateSlider(text, min, max, default, callback)
            min = min or 0
            max = max or 100
            local val = math.clamp(default or min, min, max)

            local R = makeRow(58)

            local Top = Instance.new("Frame")
            Top.Size = UDim2.new(1, 0, 0, 22)
            Top.BackgroundTransparency = 1
            Top.Parent = R

            local SLbl = label(Top, text, Enum.Font.Gotham, 13, C.txt)
            SLbl.Position = UDim2.new(0, 6, 0, 0)
            SLbl.Size = UDim2.new(1, -58, 1, 0)

            local ValBox = Instance.new("Frame")
            ValBox.Size = UDim2.new(0, 46, 0, 20)
            ValBox.AnchorPoint = Vector2.new(1, 0.5)
            ValBox.Position = UDim2.new(1, -6, 0.5, 0)
            ValBox.BackgroundColor3 = C.accent
            ValBox.BackgroundTransparency = 0.82
            ValBox.BorderSizePixel = 0
            ValBox.Parent = Top
            corner(ValBox, 5)

            local ValLbl = label(ValBox, tostring(val), Enum.Font.GothamBold, 11, C.accent)
            ValLbl.Size = UDim2.new(1, 0, 1, 0)
            ValLbl.TextXAlignment = Enum.TextXAlignment.Center

            local TrackBg = Instance.new("Frame")
            TrackBg.Position = UDim2.new(0, 6, 0, 28)
            TrackBg.Size = UDim2.new(1, -12, 0, 6)
            TrackBg.BackgroundColor3 = C.trackOff
            TrackBg.BorderSizePixel = 0
            TrackBg.ZIndex = 2
            TrackBg.Parent = R
            corner(TrackBg, 3)

            local pct = (val - min) / (max - min)

            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new(pct, 0, 1, 0)
            Fill.BackgroundColor3 = C.accent
            Fill.BorderSizePixel = 0
            Fill.ZIndex = 3
            Fill.Parent = TrackBg
            corner(Fill, 3)

            local Knob = Instance.new("Frame")
            Knob.Size = UDim2.new(0, 16, 0, 16)
            Knob.AnchorPoint = Vector2.new(0.5, 0.5)
            Knob.Position = UDim2.new(pct, 0, 0.5, 0)
            Knob.BackgroundColor3 = C.white
            Knob.BorderSizePixel = 0
            Knob.ZIndex = 4
            Knob.Parent = TrackBg
            corner(Knob, 8)
            stroke(Knob, C.accent, 2, 0)

            local HitBox = Instance.new("TextButton")
            HitBox.Size = UDim2.new(1, 0, 0, 22)
            HitBox.Position = UDim2.new(0, 0, 0, -8)
            HitBox.BackgroundTransparency = 1
            HitBox.Text = ""
            HitBox.ZIndex = 5
            HitBox.Parent = TrackBg

            local function updateSlider(x)
                local abs = TrackBg.AbsolutePosition
                local sz = TrackBg.AbsoluteSize
                local r = math.clamp((x - abs.X) / sz.X, 0, 1)
                local nv = math.round(min + r * (max - min))
                if nv == val then return end
                val = nv
                ValLbl.Text = tostring(val)
                tw(Fill, {Size = UDim2.new(r, 0, 1, 0)}, 0.04)
                tw(Knob, {Position = UDim2.new(r, 0, 0.5, 0)}, 0.04)
                if callback then task.spawn(pcall, callback, val) end
            end

            HitBox.MouseButton1Down:Connect(function()
                activeSlider = {update = updateSlider}
                updateSlider(UIS:GetMouseLocation().X)
                tw(Knob, {Size = UDim2.new(0, 20, 0, 20)}, 0.1, Enum.EasingStyle.Back)
            end)

            UIS.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    tw(Knob, {Size = UDim2.new(0, 16, 0, 16)}, 0.1)
                end
            end)
        end

        function secAPI:CreateDropdown(text, options, callback)
            local selected = options[1] or ""

            local R = makeRow(44)
            rowLabel(R, text)

            local DBtn = Instance.new("TextButton")
            DBtn.Size = UDim2.new(0, 140, 0, 28)
            DBtn.AnchorPoint = Vector2.new(1, 0.5)
            DBtn.Position = UDim2.new(1, -6, 0.5, 0)
            DBtn.BackgroundColor3 = C.win
            DBtn.Text = selected
            DBtn.Font = Enum.Font.Gotham
            DBtn.TextSize = 12
            DBtn.TextColor3 = C.txt
            DBtn.AutoButtonColor = false
            DBtn.TextTruncate = Enum.TextTruncate.AtEnd
            DBtn.ZIndex = 2
            DBtn.Parent = R
            corner(DBtn, 7)
            stroke(DBtn, C.border, 1, 0.3)
            pad(DBtn, 0, 0, 10, 28)

            local Chev = label(DBtn, "v", Enum.Font.GothamBold, 11, C.txtDim)
            Chev.Size = UDim2.new(0, 24, 1, 0)
            Chev.AnchorPoint = Vector2.new(1, 0)
            Chev.Position = UDim2.new(1, 0, 0, 0)
            Chev.TextXAlignment = Enum.TextXAlignment.Center
            Chev.ZIndex = 3

            local Menu = Instance.new("Frame")
            Menu.BackgroundColor3 = C.card
            Menu.BorderSizePixel = 0
            Menu.ZIndex = 100
            Menu.Visible = false
            Menu.ClipsDescendants = true
            Menu.Parent = Gui
            corner(Menu, 9)
            stroke(Menu, C.border, 1, 0.2)

            vlist(Menu, 0)

            local itemH = 32
            local totalH = #options * itemH

            for i, opt in ipairs(options) do
                local Item = Instance.new("TextButton")
                Item.Size = UDim2.new(1, 0, 0, itemH)
                Item.BackgroundColor3 = C.card
                Item.Text = opt
                Item.Font = Enum.Font.Gotham
                Item.TextSize = 13
                Item.TextColor3 = C.txt
                Item.TextXAlignment = Enum.TextXAlignment.Left
                Item.AutoButtonColor = false
                Item.ZIndex = 101
                Item.LayoutOrder = i
                Item.Parent = Menu
                pad(Item, 0, 0, 14, 0)

                if opt == selected then
                    Item.TextColor3 = C.accent
                    Item.Font = Enum.Font.GothamBold
                end

                Item.MouseEnter:Connect(function() tw(Item, {BackgroundColor3 = C.cardHov}, 0.09) end)
                Item.MouseLeave:Connect(function() tw(Item, {BackgroundColor3 = C.card}, 0.09) end)
                Item.MouseButton1Click:Connect(function()
                    selected = opt
                    DBtn.Text = opt
                    for _, ch in ipairs(Menu:GetChildren()) do
                        if ch:IsA("TextButton") then
                            ch.TextColor3 = C.txt
                            ch.Font = Enum.Font.Gotham
                        end
                    end
                    Item.TextColor3 = C.accent
                    Item.Font = Enum.Font.GothamBold
                    tw(Menu, {Size = UDim2.new(0, Menu.AbsoluteSize.X, 0, 0)}, 0.14)
                    task.delay(0.15, function() Menu.Visible = false end)
                    openDropdown = nil
                    if callback then task.spawn(pcall, callback, opt) end
                end)
            end

            local isOpen = false

            local function openMenu()
                if openDropdown and openDropdown.close then
                    openDropdown.close()
                end
                isOpen = true
                local abs = DBtn.AbsolutePosition
                local sz = DBtn.AbsoluteSize
                local mw = 160
                local mh = math.min(totalH, 200)
                Menu.Size = UDim2.new(0, mw, 0, 0)
                Menu.Position = UDim2.new(0, abs.X + sz.X - mw, 0, abs.Y + sz.Y + 4)
                Menu.Visible = true
                tw(Menu, {Size = UDim2.new(0, mw, 0, mh)}, 0.18, Enum.EasingStyle.Quart)
                tw(Chev, {Rotation = 180}, 0.18)
                openDropdown = {
                    close = function()
                        isOpen = false
                        tw(Menu, {Size = UDim2.new(0, mw, 0, 0)}, 0.14)
                        task.delay(0.15, function() Menu.Visible = false end)
                        tw(Chev, {Rotation = 0}, 0.14)
                        openDropdown = nil
                    end
                }
            end

            DBtn.MouseButton1Click:Connect(function()
                if isOpen then
                    if openDropdown then openDropdown.close() end
                else
                    openMenu()
                end
            end)
        end

        function secAPI:CreateKeybind(text, default, callback)
            local key = default or Enum.KeyCode.Unknown
            local waiting = false

            local R = makeRow(44)
            rowLabel(R, text)

            local KBtn = Instance.new("TextButton")
            KBtn.Size = UDim2.new(0, 90, 0, 28)
            KBtn.AnchorPoint = Vector2.new(1, 0.5)
            KBtn.Position = UDim2.new(1, -6, 0.5, 0)
            KBtn.BackgroundColor3 = C.win
            KBtn.Text = key == Enum.KeyCode.Unknown and "None" or tostring(key):gsub("Enum.KeyCode.", "")
            KBtn.Font = Enum.Font.GothamBold
            KBtn.TextSize = 12
            KBtn.TextColor3 = C.txtMid
            KBtn.AutoButtonColor = false
            KBtn.ZIndex = 2
            KBtn.Parent = R
            corner(KBtn, 7)
            stroke(KBtn, C.border, 1, 0.3)

            KBtn.MouseButton1Click:Connect(function()
                if waiting then return end
                waiting = true
                KBtn.Text = "..."
                KBtn.TextColor3 = C.accent
                tw(KBtn, {BackgroundColor3 = C.accentDim}, 0.1)
                local conn
                conn = UIS.InputBegan:Connect(function(inp, gp)
                    if gp then return end
                    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                    waiting = false
                    conn:Disconnect()
                    key = inp.KeyCode
                    KBtn.Text = tostring(key):gsub("Enum.KeyCode.", "")
                    KBtn.TextColor3 = C.txtMid
                    tw(KBtn, {BackgroundColor3 = C.win}, 0.1)
                    if callback then task.spawn(pcall, callback, key) end
                end)
            end)

            UIS.InputBegan:Connect(function(inp, gp)
                if gp or waiting then return end
                if inp.KeyCode == key and key ~= Enum.KeyCode.Unknown then
                    if callback then task.spawn(pcall, callback, key) end
                end
            end)
        end

        function secAPI:CreateInput(text, placeholder, callback)
            local R = makeRow(44)
            rowLabel(R, text)

            local Box = Instance.new("TextBox")
            Box.Size = UDim2.new(0, 150, 0, 28)
            Box.AnchorPoint = Vector2.new(1, 0.5)
            Box.Position = UDim2.new(1, -6, 0.5, 0)
            Box.BackgroundColor3 = C.win
            Box.PlaceholderText = placeholder or "Type here..."
            Box.PlaceholderColor3 = C.txtDim
            Box.Text = ""
            Box.Font = Enum.Font.Gotham
            Box.TextSize = 12
            Box.TextColor3 = C.txt
            Box.ClearTextOnFocus = false
            Box.ZIndex = 2
            Box.Parent = R
            corner(Box, 7)
            local bs = stroke(Box, C.border, 1, 0.3)
            pad(Box, 0, 0, 10, 8)

            Box.Focused:Connect(function()
                tw(bs, {Color = C.accent, Transparency = 0}, 0.15)
            end)
            Box.FocusLost:Connect(function(enter)
                tw(bs, {Color = C.border, Transparency = 0.3}, 0.15)
                if enter and callback then task.spawn(pcall, callback, Box.Text) end
            end)
        end

        function secAPI:CreateLabel(text)
            local R = makeRow(34)
            local Lbl = label(R, text, Enum.Font.Gotham, 12, C.txtDim)
            Lbl.Position = UDim2.new(0, 6, 0, 0)
            Lbl.Size = UDim2.new(1, -12, 1, 0)
            Lbl.TextWrapped = true
        end

        return secAPI
    end

    return tabAPI
end

local notifyQueue = {}
local NOTIFY_GAP = 8
local NOTIFY_X = -14
local NOTIFY_BASE = -14

local function restack()
    local y = NOTIFY_BASE
    for i = #notifyQueue, 1, -1 do
        local n = notifyQueue[i]
        if n.frame and n.frame.Parent then
            tw(n.frame, {Position = UDim2.new(1, NOTIFY_X, 1, y)}, 0.2, Enum.EasingStyle.Quart)
            y = y - n.height - NOTIFY_GAP
        end
    end
end

function Lib:Notify(title, message, ntype, duration)
    if type(ntype) == "number" then
        duration = ntype
        ntype = nil
    end
    ntype = ntype or "info"
    duration = duration or 4

    local typeColor = ({
        info = C.accent,
        success = C.green,
        warning = Color3.fromRGB(255, 180, 50),
        error = C.red,
    })[ntype] or C.accent

    local typeIcon = ({
        info = "i",
        success = "v",
        warning = "!",
        error = "X",
    })[ntype] or "i"

    local H = 76

    local N = Instance.new("Frame")
    N.Size = UDim2.new(0, 300, 0, H)
    N.AnchorPoint = Vector2.new(1, 1)
    N.Position = UDim2.new(1, NOTIFY_X, 1, 80)
    N.BackgroundColor3 = C.card
    N.BorderSizePixel = 0
    N.ZIndex = 200
    N.Parent = Gui
    corner(N, 12)
    stroke(N, C.border, 1, 0.2)

    local TopLine = Instance.new("Frame")
    TopLine.Size = UDim2.new(1, 0, 0, 2)
    TopLine.BackgroundColor3 = typeColor
    TopLine.BorderSizePixel = 0
    TopLine.ZIndex = 201
    TopLine.Parent = N
    corner(TopLine, 2)

    local IC = Instance.new("Frame")
    IC.Size = UDim2.new(0, 30, 0, 30)
    IC.AnchorPoint = Vector2.new(0, 0.5)
    IC.Position = UDim2.new(0, 12, 0.5, 0)
    IC.BackgroundColor3 = typeColor
    IC.BackgroundTransparency = 0.75
    IC.BorderSizePixel = 0
    IC.ZIndex = 201
    IC.Parent = N
    corner(IC, 8)

    local ILbl = label(IC, typeIcon, Enum.Font.GothamBold, 14, typeColor)
    ILbl.Size = UDim2.new(1, 0, 1, 0)
    ILbl.TextXAlignment = Enum.TextXAlignment.Center
    ILbl.ZIndex = 202

    local NT = label(N, title, Enum.Font.GothamBold, 13, C.txt)
    NT.Position = UDim2.new(0, 52, 0, 12)
    NT.Size = UDim2.new(1, -64, 0, 18)
    NT.ZIndex = 201

    local NM = label(N, message, Enum.Font.Gotham, 12, C.txtDim)
    NM.Position = UDim2.new(0, 52, 0, 32)
    NM.Size = UDim2.new(1, -64, 0, 28)
    NM.TextWrapped = true
    NM.ZIndex = 201

    local Prog = Instance.new("Frame")
    Prog.Size = UDim2.new(1, 0, 0, 2)
    Prog.AnchorPoint = Vector2.new(0, 1)
    Prog.Position = UDim2.new(0, 0, 1, 0)
    Prog.BackgroundColor3 = typeColor
    Prog.BackgroundTransparency = 0.4
    Prog.BorderSizePixel = 0
    Prog.ZIndex = 202
    Prog.Parent = N
    corner(Prog, 1)

    local entry = {frame = N, height = H}
    table.insert(notifyQueue, 1, entry)
    restack()
    tw(Prog, {Size = UDim2.new(0, 0, 0, 2)}, duration, Enum.EasingStyle.Linear)

    task.delay(duration, function()
        table.remove(notifyQueue, table.find(notifyQueue, entry) or 1)
        tw(N, {Position = UDim2.new(1, NOTIFY_X, 1, 80), BackgroundTransparency = 1}, 0.2)
        task.delay(0.22, function() N:Destroy() end)
        restack()
    end)
end

function Lib:Destroy()
    Gui:Destroy()
end

-- ТЕЛЕПОРТАЦИЯ
local activeTeleportTasks = {}
local function stopTeleportForWorld(worldName)
    if activeTeleportTasks[worldName] then
        task.cancel(activeTeleportTasks[worldName])
        activeTeleportTasks[worldName] = nil
    end
end

local function startTeleportLoop(worldName, targetPosition, getDelayFunction, isActiveFunction)
    stopTeleportForWorld(worldName)
    local taskId = task.spawn(function()
        while true do
            if not isActiveFunction() then break end
            task.wait(getDelayFunction())
            if not isActiveFunction() then break end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
            end
        end
    end)
    activeTeleportTasks[worldName] = taskId
end

-- ВКЛАДКА TELEPORT
local teleportTab = Lib:CreateTab("TELEPORT", "🌍")
local world1Section = teleportTab:CreateSection("🌲 МИР 1")
local world1Active = false
local world1Delay = 5
world1Section:CreateToggle("Активная телепортация", false, function(state)
    world1Active = state
    if state then
        startTeleportLoop("World1", Vector3.new(5140.46, 26.09, 6.52), function() return world1Delay end, function() return world1Active end)
        Lib:Notify("Мир 1", "Телепортация запущена!", "success")
    else
        stopTeleportForWorld("World1")
        Lib:Notify("Мир 1", "Телепортация остановлена.", "info")
    end
end)
world1Section:CreateSlider("Интервал (сек)", 1, 30, world1Delay, function(value)
    world1Delay = value
    if world1Active then
        stopTeleportForWorld("World1")
        startTeleportLoop("World1", Vector3.new(5140.46, 26.09, 6.52), function() return world1Delay end, function() return world1Active end)
    end
end)
world1Section:CreateButton("Телепортироваться один раз", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(5140.46, 26.09, 6.52)
        Lib:Notify("Мир 1", "Телепортация выполнена!", "info")
    end
end)

local world2Section = teleportTab:CreateSection("🏙️ МИР 2")
local world2Active = false
local world2Delay = 5
world2Section:CreateToggle("Активная телепортация", false, function(state)
    world2Active = state
    if state then
        startTeleportLoop("World2", Vector3.new(4070.87, 66.52, -107.37), function() return world2Delay end, function() return world2Active end)
        Lib:Notify("Мир 2", "Телепортация запущена!", "success")
    else
        stopTeleportForWorld("World2")
        Lib:Notify("Мир 2", "Телепортация остановлена.", "info")
    end
end)
world2Section:CreateSlider("Интервал (сек)", 1, 30, world2Delay, function(value)
    world2Delay = value
    if world2Active then
        stopTeleportForWorld("World2")
        startTeleportLoop("World2", Vector3.new(4070.87, 66.52, -107.37), function() return world2Delay end, function() return world2Active end)
    end
end)
world2Section:CreateButton("Телепортироваться один раз", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(4070.87, 66.52, -107.37)
        Lib:Notify("Мир 2", "Телепортация выполнена!", "info")
    end
end)

local world3Section = teleportTab:CreateSection("🏰 МИР 3")
local world3Active = false
local world3Delay = 5
world3Section:CreateToggle("Активная телепортация", false, function(state)
    world3Active = state
    if state then
        startTeleportLoop("World3", Vector3.new(938.97, 215.38, 701.07), function() return world3Delay end, function() return world3Active end)
        Lib:Notify("Мир 3", "Телепортация запущена!", "success")
    else
        stopTeleportForWorld("World3")
        Lib:Notify("Мир 3", "Телепортация остановлена.", "info")
    end
end)
world3Section:CreateSlider("Интервал (сек)", 1, 30, world3Delay, function(value)
    world3Delay = value
    if world3Active then
        stopTeleportForWorld("World3")
        startTeleportLoop("World3", Vector3.new(938.97, 215.38, 701.07), function() return world3Delay end, function() return world3Active end)
    end
end)
world3Section:CreateButton("Телепортироваться один раз", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(938.97, 215.38, 701.07)
        Lib:Notify("Мир 3", "Телепортация выполнена!", "info")
    end
end)

-- ВКЛАДКА HEALTH PER CLICK
local healthTab = Lib:CreateTab("HEAL CLICK", "❤️")
local healthSection = healthTab:CreateSection("ЛЕЧЕНИЕ ПО КЛИКУ")

local hpPerClick = 10
local hpActive = false
local clickConnection = nil

local function healPlayer()
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            local newHealth = math.min(humanoid.MaxHealth, humanoid.Health + hpPerClick)
            humanoid.Health = newHealth
            Lib:Notify("Лечение", "+" .. hpPerClick .. " HP", "success")
        end
    end
end

local function startHealing()
    if clickConnection then return end
    clickConnection = UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if hpActive then
                healPlayer()
            end
        end
    end)
end

local function stopHealing()
    if clickConnection then
        clickConnection:Disconnect()
        clickConnection = nil
    end
end

healthSection:CreateToggle("Включить лечение по клику", false, function(state)
    hpActive = state
    if state then
        startHealing()
        Lib:Notify("Health Per Click", "Активировано! +" .. hpPerClick .. " HP за клик", "success")
    else
        stopHealing()
        Lib:Notify("Health Per Click", "Деактивировано", "info")
    end
end)

healthSection:CreateSlider("Количество HP за клик", 1, 100, hpPerClick, function(value)
    hpPerClick = value
end)

healthSection:CreateButton("Вылечиться один раз", function()
    healPlayer()
end)

return Lib
