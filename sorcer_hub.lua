-- ============ CONFIGURAÇÕES PADRÃO ============
local DELAY_ENTRE_COMPRAS    = 2.0
local DELAY_COLETA_DINHEIRO  = 5.0
local DELAY_APOS_TELEPORTE   = 1.0
local DELAY_REINICIO         = 3.0
local MAX_TENTATIVAS         = 3
-- ===============================================

local SPAWN = CFrame.new(-107.92, 29.42, 723.68)
local PLATAFORMA_DINHEIRO = CFrame.new(-109.59, 29.83, 740.80)

local ITENS = {
    {nome = "DROPPER 2", valor = 125, pos = CFrame.new(-99.40, 29.43, 757.49)},
    {nome = "DROPPER 3", valor = 750, pos = CFrame.new(-108.88, 29.43, 756.94)},
    {nome = "DROPPER 4", valor = 1500, pos = CFrame.new(-117.80, 29.43, 757.73)},
    {nome = "DROPPER 5", valor = 3250, pos = CFrame.new(-128.18, 29.43, 756.54)},
    {nome = "PAREDE 1", valor = 75, pos = CFrame.new(-146.32, 29.43, 759.44)},
    {nome = "PRIMEIRO ANDAR", valor = 4000, pos = CFrame.new(-146.17, 29.43, 753.14)},
    {nome = "TRANSPORTADOR", valor = 700, pos = CFrame.new(-110.75, 50.24, 747.65)},
    {nome = "GRANDE DROPPER", valor = 5000, pos = CFrame.new(-101.79, 50.24, 752.90)},
    {nome = "GRANDE DROPPER 2", valor = 17500, pos = CFrame.new(-111.32, 50.24, 752.85)},
    {nome = "GRANDE DROPPER 3", valor = 40000, pos = CFrame.new(-118.61, 50.24, 753.41)},
    {nome = "PAREDE 2", valor = 4500, pos = CFrame.new(-85.29, 50.24, 763.76)},
    {nome = "SEGUNDO ANDAR", valor = 100000, pos = CFrame.new(-91.02, 50.24, 764.32)},
    {nome = "MEGA DROPPER", valor = 35000, pos = CFrame.new(-117.64, 66.18, 740.15)},
    {nome = "MEGA DROPPER 2", valor = 125000, pos = CFrame.new(-107.47, 66.20, 739.09)},
    {nome = "3.1", valor = 25000, pos = CFrame.new(-115.76, 66.18, 750.55)},
    {nome = "3.2", valor = 500000, pos = CFrame.new(-105.34, 66.18, 748.71)},
    {nome = "3.3", valor = 15000, pos = CFrame.new(-98.07, 66.18, 761.80)},
    {nome = "3.4", valor = 20000, pos = CFrame.new(-91.30, 66.18, 761.81)},
    {nome = "3.5", valor = 3000000, pos = CFrame.new(-127.74, 66.18, 758.87)},
    {nome = "3.6", valor = 3000, pos = CFrame.new(-126.40, 66.18, 735.37)},
    {nome = "2.1", valor = 6000, pos = CFrame.new(-125.20, 50.24, 733.67)},
    {nome = "2.2", valor = 500, pos = CFrame.new(-99.55, 50.24, 741.20)},
    {nome = "2.3", valor = 7500, pos = CFrame.new(-110.30, 50.24, 738.20)},
    {nome = "2.4", valor = 13750, pos = CFrame.new(-101.86, 50.24, 737.96)},
    {nome = "2.5", valor = 31250, pos = CFrame.new(-94.13, 50.24, 737.18)},
    {nome = "2.6", valor = 37500, pos = CFrame.new(-85.03, 50.24, 735.69)},
    {nome = "1.1", valor = 250, pos = CFrame.new(-98.61, 29.43, 713.54)},
    {nome = "1.2", valor = 1500, pos = CFrame.new(-89.73, 29.43, 720.10)},
    {nome = "1.3", valor = 125, pos = CFrame.new(-90.60, 29.42, 741.72)},
    {nome = "1.4", valor = 225, pos = CFrame.new(-86.61, 29.43, 732.38)},
    {nome = "1.5", valor = 750, pos = CFrame.new(-86.12, 29.43, 741.33)},
    {nome = "1.6", valor = 2500, pos = CFrame.new(-86.09, 29.43, 751.48)},
}

-- ============ BOSSES ============
local BOSSES = {
    {nome = "Toji", displayNome = "GOTAS (Toji)", pos = CFrame.new(39.46, -77.25, 75.68)},
}

-- ============ ESTADO GLOBAL ============
local cicloAtual = 0
local scriptRodando = true
local reiniciarManual = false
local bossRodando = false
local abaAtual = "tycoon" -- "tycoon" ou "boss"

-- ============ SERVICES ============
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Remove GUI antiga
if playerGui:FindFirstChild("SorcerHub") then playerGui.SorcerHub:Destroy() end

-- ============ GUI PRINCIPAL ============
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SorcerHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Frame principal
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 380, 0, 640)
mainFrame.Position = UDim2.new(0, 16, 0.5, -320)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(80, 60, 200)
mainStroke.Thickness = 1.5

-- ===== BARRA DE TÍTULO =====
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 16, 50)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)
local titleFix = Instance.new("Frame", titleBar)
titleFix.Size = UDim2.new(1, 0, 0, 12)
titleFix.Position = UDim2.new(0, 0, 1, -12)
titleFix.BackgroundColor3 = Color3.fromRGB(20, 16, 50)
titleFix.BorderSizePixel = 0

local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Text = "⚡ SORCER HUB"
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(180, 160, 255)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Text = "—"
minBtn.Size = UDim2.new(0, 30, 0, 24)
minBtn.Position = UDim2.new(1, -36, 0.5, -12)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 80)
minBtn.TextColor3 = Color3.fromRGB(200, 180, 255)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- ===== MENU LATERAL =====
local sideMenu = Instance.new("Frame", mainFrame)
sideMenu.Size = UDim2.new(0, 70, 1, -44)
sideMenu.Position = UDim2.new(0, 0, 0, 42)
sideMenu.BackgroundColor3 = Color3.fromRGB(14, 11, 32)
sideMenu.BorderSizePixel = 0
local sideCorner = Instance.new("UICorner", sideMenu)
sideCorner.CornerRadius = UDim.new(0, 10)
-- Fix corner top right
local sideFix = Instance.new("Frame", sideMenu)
sideFix.Size = UDim2.new(0, 10, 1, 0)
sideFix.Position = UDim2.new(1, -10, 0, 0)
sideFix.BackgroundColor3 = Color3.fromRGB(14, 11, 32)
sideFix.BorderSizePixel = 0

local sideLayout = Instance.new("UIListLayout", sideMenu)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Padding = UDim.new(0, 4)
local sidePad = Instance.new("UIPadding", sideMenu)
sidePad.PaddingTop = UDim.new(0, 8)
sidePad.PaddingLeft = UDim.new(0, 6)
sidePad.PaddingRight = UDim.new(0, 6)

local function makeSideBtn(icon, label, order)
    local btn = Instance.new("TextButton", sideMenu)
    btn.Size = UDim2.new(1, 0, 0, 58)
    btn.BackgroundColor3 = Color3.fromRGB(25, 20, 55)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.LayoutOrder = order
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local ico = Instance.new("TextLabel", btn)
    ico.Text = icon
    ico.Size = UDim2.new(1, 0, 0, 26)
    ico.Position = UDim2.new(0, 0, 0, 8)
    ico.BackgroundTransparency = 1
    ico.TextColor3 = Color3.fromRGB(180, 160, 255)
    ico.TextSize = 20
    ico.Font = Enum.Font.GothamBold
    ico.TextXAlignment = Enum.TextXAlignment.Center

    local lbl2 = Instance.new("TextLabel", btn)
    lbl2.Text = label
    lbl2.Size = UDim2.new(1, 0, 0, 14)
    lbl2.Position = UDim2.new(0, 0, 0, 36)
    lbl2.BackgroundTransparency = 1
    lbl2.TextColor3 = Color3.fromRGB(140, 120, 200)
    lbl2.TextSize = 9
    lbl2.Font = Enum.Font.GothamBold
    lbl2.TextXAlignment = Enum.TextXAlignment.Center

    return btn, ico, lbl2
end

local btnTycoon, icoTycoon, lblTycoon = makeSideBtn("🏪", "TYCOON", 1)
local btnBoss, icoBoss, lblBoss = makeSideBtn("⚔️", "BOSS", 2)

local function setActiveTab(tab)
    if tab == "tycoon" then
        btnTycoon.BackgroundColor3 = Color3.fromRGB(60, 40, 140)
        icoTycoon.TextColor3 = Color3.fromRGB(220, 200, 255)
        btnBoss.BackgroundColor3 = Color3.fromRGB(25, 20, 55)
        icoBoss.TextColor3 = Color3.fromRGB(180, 160, 255)
    else
        btnBoss.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
        icoBoss.TextColor3 = Color3.fromRGB(255, 160, 160)
        btnTycoon.BackgroundColor3 = Color3.fromRGB(25, 20, 55)
        icoTycoon.TextColor3 = Color3.fromRGB(180, 160, 255)
    end
end
setActiveTab("tycoon")

-- ===== ÁREA DE CONTEÚDO =====
local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size = UDim2.new(1, -78, 1, -46)
contentArea.Position = UDim2.new(0, 74, 0, 44)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.ClipsDescendants = true

-- =============================
-- ABA TYCOON
-- =============================
local tycoonPage = Instance.new("ScrollingFrame", contentArea)
tycoonPage.Size = UDim2.new(1, 0, 1, 0)
tycoonPage.BackgroundTransparency = 1
tycoonPage.ScrollBarThickness = 2
tycoonPage.ScrollBarImageColor3 = Color3.fromRGB(80, 60, 180)
tycoonPage.CanvasSize = UDim2.new(0, 0, 0, 0)
tycoonPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
tycoonPage.BorderSizePixel = 0
local tLayout = Instance.new("UIListLayout", tycoonPage)
tLayout.SortOrder = Enum.SortOrder.LayoutOrder
tLayout.Padding = UDim.new(0, 6)
local tPad = Instance.new("UIPadding", tycoonPage)
tPad.PaddingBottom = UDim.new(0, 8)
tPad.PaddingRight = UDim.new(0, 4)

-- helpers para tycoon page
local function tbox(order, h)
    local f = Instance.new("Frame", tycoonPage)
    f.Size = UDim2.new(1, 0, 0, h)
    f.BackgroundColor3 = Color3.fromRGB(18, 14, 40)
    f.BorderSizePixel = 0
    f.LayoutOrder = order
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    return f
end
local function tsectionTitle(text, order)
    local t = Instance.new("TextLabel", tycoonPage)
    t.Text = text
    t.Size = UDim2.new(1, 0, 0, 14)
    t.BackgroundTransparency = 1
    t.TextColor3 = Color3.fromRGB(100, 80, 180)
    t.TextSize = 10
    t.Font = Enum.Font.GothamBold
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.LayoutOrder = order
    return t
end
local function tlbl(parent, text, color, size, font, x, y, w, h)
    local l = Instance.new("TextLabel", parent)
    l.Text = text
    l.Size = UDim2.new(w or 1, -12, 0, h or 16)
    l.Position = UDim2.new(0, x or 8, 0, y or 6)
    l.BackgroundTransparency = 1
    l.TextColor3 = color
    l.TextSize = size or 11
    l.Font = font or Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextWrapped = true
    return l
end

-- STATUS
tsectionTitle("  STATUS", 1)
local statusBox = tbox(2, 52)
tlbl(statusBox, "STATUS", Color3.fromRGB(100,80,180), 10, Enum.Font.GothamBold)
local statusLabel = tlbl(statusBox, "⏳ Aguardando início...", Color3.fromRGB(220,210,255), 12, Enum.Font.Gotham, 8, 22, 1, 24)

-- PROGRESSO
tsectionTitle("  PROGRESSO", 3)
local progBox = tbox(4, 72)
tlbl(progBox, "CICLOS COMPLETOS", Color3.fromRGB(100,80,180), 10, Enum.Font.GothamBold, 8, 6)
local cicloLabel = tlbl(progBox, "0 ciclos", Color3.fromRGB(180,140,255), 14, Enum.Font.GothamBold, 8, 20)
tlbl(progBox, "CICLO ATUAL", Color3.fromRGB(100,80,180), 10, Enum.Font.GothamBold, 8, 40)
local progressLabel = tlbl(progBox, "0 / "..#ITENS.." itens", Color3.fromRGB(220,210,255), 11, Enum.Font.Gotham, 8, 54)
local barBg = Instance.new("Frame", progBox)
barBg.Size = UDim2.new(1, -16, 0, 6)
barBg.Position = UDim2.new(0, 8, 0, 62)
barBg.BackgroundColor3 = Color3.fromRGB(35,28,70)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)
local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(120,80,255)
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

-- SALDO
tsectionTitle("  SALDO", 5)
local saldoBox = tbox(6, 72)
tlbl(saldoBox, "SALDO ATUAL", Color3.fromRGB(100,80,180), 10, Enum.Font.GothamBold, 8, 6)
local saldoLabel = tlbl(saldoBox, "R$ 0", Color3.fromRGB(100,255,160), 15, Enum.Font.GothamBold, 8, 20)
tlbl(saldoBox, "PRÓXIMA COMPRA", Color3.fromRGB(100,80,180), 10, Enum.Font.GothamBold, 8, 42)
local proximaLabel = tlbl(saldoBox, "—", Color3.fromRGB(255,200,100), 11, Enum.Font.Gotham, 8, 56)

-- TENTATIVAS
tsectionTitle("  TENTATIVAS", 7)
local tentBox = tbox(8, 44)
tlbl(tentBox, "TENTATIVA ATUAL", Color3.fromRGB(100,80,180), 10, Enum.Font.GothamBold)
local tentLabel = tlbl(tentBox, "0 / "..MAX_TENTATIVAS, Color3.fromRGB(100,255,160), 14, Enum.Font.GothamBold, 8, 22)

-- CONTROLES
tsectionTitle("  CONTROLES", 9)
local ctrlBox = tbox(10, 44)
local btnReiniciar = Instance.new("TextButton", ctrlBox)
btnReiniciar.Size = UDim2.new(0.48, 0, 0, 28)
btnReiniciar.Position = UDim2.new(0, 8, 0.5, -14)
btnReiniciar.BackgroundColor3 = Color3.fromRGB(60, 40, 140)
btnReiniciar.TextColor3 = Color3.fromRGB(200, 180, 255)
btnReiniciar.Text = "🔄 REINICIAR"
btnReiniciar.TextSize = 11
btnReiniciar.Font = Enum.Font.GothamBold
btnReiniciar.BorderSizePixel = 0
Instance.new("UICorner", btnReiniciar).CornerRadius = UDim.new(0, 6)

local btnParar = Instance.new("TextButton", ctrlBox)
btnParar.Size = UDim2.new(0.44, 0, 0, 28)
btnParar.Position = UDim2.new(0.54, 0, 0.5, -14)
btnParar.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
btnParar.TextColor3 = Color3.fromRGB(255, 180, 180)
btnParar.Text = "⏹ PARAR"
btnParar.TextSize = 11
btnParar.Font = Enum.Font.GothamBold
btnParar.BorderSizePixel = 0
Instance.new("UICorner", btnParar).CornerRadius = UDim.new(0, 6)

-- DELAYS
tsectionTitle("  ⚙️ DELAYS", 11)
local cfgBox = tbox(12, 178)
tlbl(cfgBox, "Arraste para ajustar em tempo real", Color3.fromRGB(100,80,180), 10, Enum.Font.GothamBold)

local function makeSlider(parent, labelText, default, minV, maxV, yOff, onChange)
    local valLabel = Instance.new("TextLabel", parent)
    valLabel.Size = UDim2.new(1, -12, 0, 14)
    valLabel.Position = UDim2.new(0, 8, 0, yOff)
    valLabel.BackgroundTransparency = 1
    valLabel.TextColor3 = Color3.fromRGB(200,190,240)
    valLabel.TextSize = 11
    valLabel.Font = Enum.Font.Gotham
    valLabel.TextXAlignment = Enum.TextXAlignment.Left
    valLabel.Text = labelText .. ": " .. default .. "s"

    local track = Instance.new("Frame", parent)
    track.Size = UDim2.new(1, -16, 0, 6)
    track.Position = UDim2.new(0, 8, 0, yOff + 18)
    track.BackgroundColor3 = Color3.fromRGB(35,28,70)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", track)
    fill.BackgroundColor3 = Color3.fromRGB(120,80,255)
    fill.BorderSizePixel = 0
    local initRel = (default - minV) / (maxV - minV)
    fill.Size = UDim2.new(initRel, 0, 1, 0)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local handle = Instance.new("TextButton", track)
    handle.Size = UDim2.new(0, 14, 0, 14)
    handle.Position = UDim2.new(initRel, -7, 0.5, -7)
    handle.BackgroundColor3 = Color3.fromRGB(180,140,255)
    handle.Text = ""
    handle.BorderSizePixel = 0
    Instance.new("UICorner", handle).CornerRadius = UDim.new(1, 0)

    local btnMinus = Instance.new("TextButton", parent)
    btnMinus.Size = UDim2.new(0, 20, 0, 20)
    btnMinus.Position = UDim2.new(0, 8, 0, yOff + 30)
    btnMinus.BackgroundColor3 = Color3.fromRGB(40,30,80)
    btnMinus.TextColor3 = Color3.fromRGB(200,180,255)
    btnMinus.Text = "-"
    btnMinus.TextSize = 14
    btnMinus.Font = Enum.Font.GothamBold
    btnMinus.BorderSizePixel = 0
    Instance.new("UICorner", btnMinus).CornerRadius = UDim.new(0, 4)

    local btnPlus = Instance.new("TextButton", parent)
    btnPlus.Size = UDim2.new(0, 20, 0, 20)
    btnPlus.Position = UDim2.new(1, -28, 0, yOff + 30)
    btnPlus.BackgroundColor3 = Color3.fromRGB(40,30,80)
    btnPlus.TextColor3 = Color3.fromRGB(200,180,255)
    btnPlus.Text = "+"
    btnPlus.TextSize = 14
    btnPlus.Font = Enum.Font.GothamBold
    btnPlus.BorderSizePixel = 0
    Instance.new("UICorner", btnPlus).CornerRadius = UDim.new(0, 4)

    local currentVal = default
    local draggingSlider = false

    local function updateSlider(val)
        val = math.clamp(math.floor(val * 10) / 10, minV, maxV)
        currentVal = val
        local rel = (val - minV) / (maxV - minV)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        handle.Position = UDim2.new(rel, -7, 0.5, -7)
        valLabel.Text = labelText .. ": " .. val .. "s"
        onChange(val)
    end

    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = true end
    end)
    handle.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end
    end)
    UIS.InputChanged:Connect(function(inp)
        if draggingSlider and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((inp.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            updateSlider(minV + rel * (maxV - minV))
        end
    end)
    btnMinus.MouseButton1Click:Connect(function() updateSlider(currentVal - 0.1) end)
    btnPlus.MouseButton1Click:Connect(function() updateSlider(currentVal + 0.1) end)
end

makeSlider(cfgBox, "Entre Compras",  DELAY_ENTRE_COMPRAS,   0.1, 5.0,  20,  function(v) DELAY_ENTRE_COMPRAS = v end)
makeSlider(cfgBox, "Coleta $",       DELAY_COLETA_DINHEIRO, 1.0, 15.0, 72,  function(v) DELAY_COLETA_DINHEIRO = v end)
makeSlider(cfgBox, "Pós Teleporte",  DELAY_APOS_TELEPORTE,  0.1, 3.0,  124, function(v) DELAY_APOS_TELEPORTE = v end)

-- LOG TYCOON
tsectionTitle("  LOG", 13)
local logBox = tbox(14, 110)
local logScroll = Instance.new("ScrollingFrame", logBox)
logScroll.Size = UDim2.new(1, -8, 1, -10)
logScroll.Position = UDim2.new(0, 4, 0, 6)
logScroll.BackgroundTransparency = 1
logScroll.ScrollBarThickness = 2
logScroll.ScrollBarImageColor3 = Color3.fromRGB(80,60,180)
logScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
logScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
logScroll.BorderSizePixel = 0
local logLayout = Instance.new("UIListLayout", logScroll)
logLayout.SortOrder = Enum.SortOrder.LayoutOrder
logLayout.Padding = UDim.new(0, 2)
local logPad = Instance.new("UIPadding", logScroll)
logPad.PaddingLeft = UDim.new(0, 4)

-- =============================
-- ABA BOSS
-- =============================
local bossPage = Instance.new("ScrollingFrame", contentArea)
bossPage.Size = UDim2.new(1, 0, 1, 0)
bossPage.BackgroundTransparency = 1
bossPage.ScrollBarThickness = 2
bossPage.ScrollBarImageColor3 = Color3.fromRGB(180, 60, 60)
bossPage.CanvasSize = UDim2.new(0, 0, 0, 0)
bossPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
bossPage.BorderSizePixel = 0
bossPage.Visible = false
local bLayout = Instance.new("UIListLayout", bossPage)
bLayout.SortOrder = Enum.SortOrder.LayoutOrder
bLayout.Padding = UDim.new(0, 6)
local bPad = Instance.new("UIPadding", bossPage)
bPad.PaddingBottom = UDim.new(0, 8)
bPad.PaddingRight = UDim.new(0, 4)

local function bbox(order, h)
    local f = Instance.new("Frame", bossPage)
    f.Size = UDim2.new(1, 0, 0, h)
    f.BackgroundColor3 = Color3.fromRGB(22, 10, 10)
    f.BorderSizePixel = 0
    f.LayoutOrder = order
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    return f
end
local function bsectionTitle(text, order)
    local t = Instance.new("TextLabel", bossPage)
    t.Text = text
    t.Size = UDim2.new(1, 0, 0, 14)
    t.BackgroundTransparency = 1
    t.TextColor3 = Color3.fromRGB(200, 80, 80)
    t.TextSize = 10
    t.Font = Enum.Font.GothamBold
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.LayoutOrder = order
    return t
end
local function blbl(parent, text, color, size, font, x, y, w, h)
    local l = Instance.new("TextLabel", parent)
    l.Text = text
    l.Size = UDim2.new(w or 1, -12, 0, h or 16)
    l.Position = UDim2.new(0, x or 8, 0, y or 6)
    l.BackgroundTransparency = 1
    l.TextColor3 = color
    l.TextSize = size or 11
    l.Font = font or Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextWrapped = true
    return l
end

-- STATUS BOSS
bsectionTitle("  ⚔️ STATUS BOSS", 1)
local bossStatusBox = bbox(2, 52)
blbl(bossStatusBox, "STATUS", Color3.fromRGB(200,80,80), 10, Enum.Font.GothamBold)
local bossStatusLabel = blbl(bossStatusBox, "⏳ Aguardando início...", Color3.fromRGB(255,200,200), 12, Enum.Font.Gotham, 8, 22, 1, 24)

-- BOSS ATUAL
bsectionTitle("  🎯 BOSS ALVO", 3)
local bossAlvoBox = bbox(4, 60)
blbl(bossAlvoBox, "BOSS", Color3.fromRGB(200,80,80), 10, Enum.Font.GothamBold, 8, 6)
local bossNomeLabel = blbl(bossAlvoBox, "GOTAS (Toji)", Color3.fromRGB(255,120,120), 16, Enum.Font.GothamBold, 8, 20)
blbl(bossAlvoBox, "X: 39.46  Y: -77.25  Z: 75.68", Color3.fromRGB(180,140,140), 10, Enum.Font.Code, 8, 42)

-- STATS
bsectionTitle("  📊 ESTATÍSTICAS", 5)
local bossStatsBox = bbox(6, 72)
blbl(bossStatsBox, "KILLS", Color3.fromRGB(200,80,80), 10, Enum.Font.GothamBold, 8, 6)
local bossKillsLabel = blbl(bossStatsBox, "0 kills", Color3.fromRGB(255,120,120), 16, Enum.Font.GothamBold, 8, 20)
blbl(bossStatsBox, "TEMPO DE FARM", Color3.fromRGB(200,80,80), 10, Enum.Font.GothamBold, 8, 42)
local bossTempoLabel = blbl(bossStatsBox, "00:00:00", Color3.fromRGB(255,200,200), 11, Enum.Font.Code, 8, 56)

-- CONTROLES BOSS
bsectionTitle("  🎮 CONTROLES", 7)
local bossCtrlBox = bbox(8, 54)

local btnBossStart = Instance.new("TextButton", bossCtrlBox)
btnBossStart.Size = UDim2.new(1, -16, 0, 34)
btnBossStart.Position = UDim2.new(0, 8, 0.5, -17)
btnBossStart.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
btnBossStart.TextColor3 = Color3.fromRGB(255, 200, 200)
btnBossStart.Text = "⚔️ INICIAR BOSS FARM"
btnBossStart.TextSize = 13
btnBossStart.Font = Enum.Font.GothamBold
btnBossStart.BorderSizePixel = 0
Instance.new("UICorner", btnBossStart).CornerRadius = UDim.new(0, 8)

-- DELAY BOSS
bsectionTitle("  ⚙️ CONFIGURAÇÕES", 9)
local bossCfgBox = bbox(10, 60)
blbl(bossCfgBox, "DELAY ENTRE ATAQUES", Color3.fromRGB(200,80,80), 10, Enum.Font.GothamBold, 8, 6)

local DELAY_ATAQUE = 0.1
local bossDelayVal = blbl(bossCfgBox, "0.1s", Color3.fromRGB(255,200,200), 12, Enum.Font.GothamBold, 8, 22)

local bossTrack = Instance.new("Frame", bossCfgBox)
bossTrack.Size = UDim2.new(1, -16, 0, 6)
bossTrack.Position = UDim2.new(0, 8, 0, 40)
bossTrack.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
bossTrack.BorderSizePixel = 0
Instance.new("UICorner", bossTrack).CornerRadius = UDim.new(1, 0)
local bossTrackFill = Instance.new("Frame", bossTrack)
bossTrackFill.Size = UDim2.new(0.05, 0, 1, 0)
bossTrackFill.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
bossTrackFill.BorderSizePixel = 0
Instance.new("UICorner", bossTrackFill).CornerRadius = UDim.new(1, 0)

-- LOG BOSS
bsectionTitle("  📋 LOG", 11)
local bossLogBox = bbox(12, 110)
local bossLogScroll = Instance.new("ScrollingFrame", bossLogBox)
bossLogScroll.Size = UDim2.new(1, -8, 1, -10)
bossLogScroll.Position = UDim2.new(0, 4, 0, 6)
bossLogScroll.BackgroundTransparency = 1
bossLogScroll.ScrollBarThickness = 2
bossLogScroll.ScrollBarImageColor3 = Color3.fromRGB(180,60,60)
bossLogScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
bossLogScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
bossLogScroll.BorderSizePixel = 0
local bossLogLayout = Instance.new("UIListLayout", bossLogScroll)
bossLogLayout.SortOrder = Enum.SortOrder.LayoutOrder
bossLogLayout.Padding = UDim.new(0, 2)

-- ===== FUNÇÕES GUI =====
local logCount = 0
local function addLog(msg)
    logCount += 1
    local line = Instance.new("TextLabel", logScroll)
    line.Text = msg
    line.Size = UDim2.new(1, -8, 0, 14)
    line.BackgroundTransparency = 1
    line.TextColor3 = Color3.fromRGB(180,170,220)
    line.TextSize = 10
    line.Font = Enum.Font.Code
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.TextWrapped = true
    line.AutomaticSize = Enum.AutomaticSize.Y
    line.LayoutOrder = logCount
    task.defer(function()
        logScroll.CanvasPosition = Vector2.new(0, logScroll.AbsoluteCanvasSize.Y)
    end)
end

local bossLogCount = 0
local function addBossLog(msg)
    bossLogCount += 1
    local line = Instance.new("TextLabel", bossLogScroll)
    line.Text = msg
    line.Size = UDim2.new(1, -8, 0, 14)
    line.BackgroundTransparency = 1
    line.TextColor3 = Color3.fromRGB(220,170,170)
    line.TextSize = 10
    line.Font = Enum.Font.Code
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.TextWrapped = true
    line.AutomaticSize = Enum.AutomaticSize.Y
    line.LayoutOrder = bossLogCount
    task.defer(function()
        bossLogScroll.CanvasPosition = Vector2.new(0, bossLogScroll.AbsoluteCanvasSize.Y)
    end)
end

local function setStatus(msg) statusLabel.Text = msg end
local function setSaldo(val) saldoLabel.Text = "R$ " .. tostring(val) end
local function setProxima(nome, valor)
    proximaLabel.Text = nome ~= "—" and (nome .. "  (R$ " .. tostring(valor) .. ")") or "—"
end
local function setProgresso(atual, total)
    progressLabel.Text = atual .. " / " .. total .. " itens"
    barFill.Size = UDim2.new(atual / math.max(total,1), 0, 1, 0)
end
local function setTentativas(atual, max)
    tentLabel.Text = atual .. " / " .. max
    tentLabel.TextColor3 = atual >= max and Color3.fromRGB(255,80,80)
        or atual > 0 and Color3.fromRGB(255,200,80)
        or Color3.fromRGB(100,255,160)
end
local function setCiclo(n)
    cicloLabel.Text = n == 0 and "0 ciclos" or (n == 1 and "1 ciclo completo" or n .. " ciclos completos")
end

-- ===== NAVEGAÇÃO ABAS =====
btnTycoon.MouseButton1Click:Connect(function()
    abaAtual = "tycoon"
    tycoonPage.Visible = true
    bossPage.Visible = false
    setActiveTab("tycoon")
end)

btnBoss.MouseButton1Click:Connect(function()
    abaAtual = "boss"
    tycoonPage.Visible = false
    bossPage.Visible = true
    setActiveTab("boss")
end)

-- ===== ARRASTAR =====
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = i.Position; startPos = mainFrame.Position
    end
end)
titleBar.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
    end
end)

-- ===== MINIMIZAR =====
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    sideMenu.Visible = not minimized
    contentArea.Visible = not minimized
    mainFrame.Size = minimized and UDim2.new(0,380,0,40) or UDim2.new(0,380,0,640)
    minBtn.Text = minimized and "+" or "—"
end)

-- ===== CONTROLES TYCOON =====
btnReiniciar.MouseButton1Click:Connect(function()
    reiniciarManual = true
    addLog("🔄 Reinício manual solicitado...")
end)

btnParar.MouseButton1Click:Connect(function()
    scriptRodando = false
    setStatus("⏹ Script parado pelo usuário")
    addLog("⏹ Script parado manualmente")
    btnParar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btnParar.Text = "⏹ PARADO"
end)

-- ===== LÓGICA TYCOON =====
local function getSaldo()
    local ok, res = pcall(function()
        if player and player:FindFirstChild("leaderstats") then
            for _, stat in pairs(player.leaderstats:GetChildren()) do
                if stat:IsA("NumberValue") or stat:IsA("IntValue") then return stat.Value end
            end
        end
        return 0
    end)
    return ok and res or 0
end

local function teleportar(cframe)
    return pcall(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = cframe
        end
    end)
end

local function coletarDinheiro()
    setStatus("💰 Coletando dinheiro...")
    addLog("💰 Indo para plataforma de $")
    teleportar(PLATAFORMA_DINHEIRO)
    task.wait(DELAY_APOS_TELEPORTE)
    task.wait(DELAY_COLETA_DINHEIRO)
    setSaldo(getSaldo())
end

local function comprarItem(item, tentativa)
    setStatus(string.format("🔍 [%d/%d] %s", tentativa, MAX_TENTATIVAS, item.nome))
    addLog(string.format("→ [%d/%d] %s (R$%d)", tentativa, MAX_TENTATIVAS, item.nome, item.valor))
    local saldoAntes = getSaldo()
    setSaldo(saldoAntes)
    if not teleportar(item.pos) then addLog("❌ Erro ao teleportar") return false end
    task.wait(DELAY_APOS_TELEPORTE)
    task.wait(DELAY_ENTRE_COMPRAS)
    local saldoDepois = getSaldo()
    setSaldo(saldoDepois)
    if saldoDepois < saldoAntes then
        addLog("✅ Comprado: " .. item.nome)
        return true
    else
        addLog("⚠ Não comprou: " .. item.nome)
        return false
    end
end

local function runCiclo()
    local total = #ITENS
    local compradosCount = 0
    reiniciarManual = false
    barFill.BackgroundColor3 = Color3.fromRGB(120,80,255)
    teleportar(SPAWN)
    task.wait(DELAY_APOS_TELEPORTE)

    for idx, item in ipairs(ITENS) do
        if not scriptRodando then return end
        if reiniciarManual then addLog("🔄 Reiniciando ciclo agora...") return end

        if idx + 1 <= total then
            setProxima(ITENS[idx+1].nome, ITENS[idx+1].valor)
        else
            setProxima("—", 0)
        end

        setProgresso(idx - 1, total)
        addLog(string.format("--- Item %d/%d: %s (R$%d) ---", idx, total, item.nome, item.valor))

        local saldoAtual = getSaldo()
        setSaldo(saldoAtual)

        if saldoAtual >= item.valor then
            addLog("💡 Saldo ok! Indo direto comprar...")
        else
            addLog("⏳ Saldo insuficiente, coletando primeiro...")
            coletarDinheiro()
        end

        local comprado = false
        local tentativas = 0

        while not comprado and tentativas < MAX_TENTATIVAS do
            if not scriptRodando or reiniciarManual then break end
            tentativas += 1
            setTentativas(tentativas, MAX_TENTATIVAS)
            local ok, result = pcall(comprarItem, item, tentativas)
            if ok and result then
                comprado = true
                compradosCount += 1
            else
                if not ok then addLog("❌ Erro: " .. tostring(result)) end
                if tentativas < MAX_TENTATIVAS then coletarDinheiro() end
            end
        end

        if not comprado and not reiniciarManual then
            setStatus("⏭️ Pulando: " .. item.nome)
            addLog("⏭ Pulado após " .. MAX_TENTATIVAS .. " tentativas")
        end

        setProgresso(idx, total)
        setTentativas(0, MAX_TENTATIVAS)
        task.wait(DELAY_ENTRE_COMPRAS)
    end

    if scriptRodando and not reiniciarManual then
        cicloAtual += 1
        setCiclo(cicloAtual)
        barFill.BackgroundColor3 = Color3.fromRGB(80,255,140)
        setStatus("✅ Ciclo " .. cicloAtual .. " completo! Reiniciando em " .. DELAY_REINICIO .. "s...")
        addLog("=== CICLO " .. cicloAtual .. " COMPLETO | " .. compradosCount .. "/" .. total .. " comprados ===")
        task.wait(DELAY_REINICIO)
    end
end

-- ===== LÓGICA BOSS FARM =====
local bossKills = 0
local bossStartTime = nil

local function formatTempo(segundos)
    local h = math.floor(segundos / 3600)
    local m = math.floor((segundos % 3600) / 60)
    local s = math.floor(segundos % 60)
    return string.format("%02d:%02d:%02d", h, m, s)
end

-- Atualiza timer do boss
task.spawn(function()
    while true do
        task.wait(1)
        if bossRodando and bossStartTime then
            local elapsed = os.time() - bossStartTime
            bossTempoLabel.Text = formatTempo(elapsed)
        end
    end
end)

local function atacarBoss(boss)
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end

    -- Tenta atacar clicando nas tools/habilidades equipadas
    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("Handle") then
        local args = {[1] = tool.Handle.CFrame}
        pcall(function()
            tool.RemoteEvent:FireServer(table.unpack(args))
        end)
    end

    -- Simula clique do mouse para ativar ataques automáticos
    local VIM = game:GetService("VirtualInputManager")
    if VIM then
        pcall(function() VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0) end)
        task.wait(0.05)
        pcall(function() VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0) end)
    end
end

local function runBossFarm()
    local boss = BOSSES[1]
    bossStartTime = os.time()

    addBossLog("=== BOSS FARM INICIADO ===")
    addBossLog("🎯 Alvo: " .. (boss.displayNome or boss.nome))

    while bossRodando do
        -- Teleporta para o boss
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = boss.pos
        end

        task.wait(0.3)

        -- Verifica se o boss existe no workspace
        local bossEncontrado = false
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj.Name:lower():find(boss.nome:lower()) then
                bossEncontrado = true
                local bossHum = obj:FindFirstChildOfClass("Humanoid")
                if bossHum and bossHum.Health > 0 then
                    bossStatusLabel.Text = "⚔️ Atacando " .. boss.nome .. "..."
                    -- Fica perto e ataca
                    local bossRoot = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                    if bossRoot then
                        local targetCF = bossRoot.CFrame * CFrame.new(0, 0, 5)
                        if char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = targetCF
                        end
                    end
                    atacarBoss(boss)
                    task.wait(DELAY_ATAQUE)
                else
                    -- Boss morreu!
                    bossKills += 1
                    bossKillsLabel.Text = bossKills .. (bossKills == 1 and " kill" or " kills")
                    addBossLog("💀 " .. boss.nome .. " morto! Total: " .. bossKills)
                    bossStatusLabel.Text = "✅ Kill #" .. bossKills .. "! Respawnando..."
                    task.wait(3) -- Aguarda respawn do boss
                end
                break
            end
        end

        if not bossEncontrado then
            bossStatusLabel.Text = "🔍 Procurando " .. boss.nome .. "..."
            addBossLog("🔍 Boss não encontrado, aguardando spawn...")
            task.wait(2)
        end

        task.wait(DELAY_ATAQUE)
    end
end

-- Botão Boss Start/Stop
local bossAtivo = false
btnBossStart.MouseButton1Click:Connect(function()
    bossAtivo = not bossAtivo
    if bossAtivo then
        bossRodando = true
        btnBossStart.Text = "⏹ PARAR BOSS FARM"
        btnBossStart.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        addBossLog("▶ Boss Farm iniciado!")
        task.spawn(runBossFarm)
    else
        bossRodando = false
        btnBossStart.Text = "⚔️ INICIAR BOSS FARM"
        btnBossStart.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
        bossStatusLabel.Text = "⏹ Farm parado"
        addBossLog("⏹ Boss Farm parado manualmente")
    end
end)

-- ===== MAIN TYCOON =====
local function main()
    addLog("=== SORCER TYCOON HUB INICIADO ===")
    setStatus("🚀 Iniciando...")
    while scriptRodando do
        runCiclo()
        if scriptRodando then
            addLog("🔄 Iniciando novo ciclo...")
            setProgresso(0, #ITENS)
        end
    end
end

if player.Character then
    task.spawn(main)
else
    player.CharacterAdded:Connect(function() task.spawn(main) end)
end
