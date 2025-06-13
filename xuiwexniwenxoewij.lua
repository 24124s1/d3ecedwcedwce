local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StyledPlayerList"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 700)
mainFrame.Position = UDim2.new(0, 20, 0.5, -350)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.BorderSizePixel = 0
title.Text = " Player List"
title.TextColor3 = Color3.fromRGB(180, 120, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamSemibold
title.TextSize = 16
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 8)
local titlePadding = Instance.new("UIPadding", title)
titlePadding.PaddingLeft = UDim.new(0, 10)

local listFrame = Instance.new("ScrollingFrame", mainFrame)
listFrame.Position = UDim2.new(0, 0, 0, 40)
listFrame.Size = UDim2.new(1, 0, 1, -40)
listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
listFrame.ScrollBarThickness = 6
listFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
listFrame.BorderSizePixel = 0
Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 8)

local mainLayout = Instance.new("UIListLayout", listFrame)
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Padding = UDim.new(0, 10)

local function createSection(titleText)
	local sectionLabel = Instance.new("TextLabel")
	sectionLabel.Size = UDim2.new(1, -10, 0, 24)
	sectionLabel.BackgroundTransparency = 1
	sectionLabel.Text = titleText
	sectionLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
	sectionLabel.Font = Enum.Font.GothamSemibold
	sectionLabel.TextSize = 14
	sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
	sectionLabel.LayoutOrder = 0

	local container = Instance.new("Frame")
	container.BackgroundTransparency = 1
	container.Size = UDim2.new(1, -10, 0, 0)
	container.LayoutOrder = 1
	container.Name = titleText:gsub("%s", "") .. "Container"

	local layout = Instance.new("UIListLayout", container)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 8)
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		container.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y)
		listFrame.CanvasSize = UDim2.new(0, 0, 0, listFrame.CanvasSize.Y.Offset) -- Trigger canvas size recalculation
	end)

	return sectionLabel, container
end

local ctLabel, ctContainer = createSection("Counter-Terrorists")
local tLabel, tContainer = createSection("Terrorists")

ctLabel.Parent = listFrame
ctContainer.Parent = listFrame
tLabel.Parent = listFrame
tContainer.Parent = listFrame

ctLabel.LayoutOrder = 1
ctContainer.LayoutOrder = 2
tLabel.LayoutOrder = 3
tContainer.LayoutOrder = 4

local playerCards = {}
local playerStats = {}

local function createPlayerCard(plr)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 90)
	card.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	card.BorderSizePixel = 0
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
	card.Name = plr.Name

	local thumb = Instance.new("ImageLabel", card)
	thumb.Size = UDim2.new(0, 40, 0, 40)
	thumb.Position = UDim2.new(0, 8, 0, 8)
	thumb.BackgroundTransparency = 1
	thumb.ClipsDescendants = true
	thumb.ScaleType = Enum.ScaleType.Crop

	task.spawn(function()
		local content = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
		thumb.Image = content
	end)

	local name = Instance.new("TextLabel", card)
	name.Size = UDim2.new(1, -56, 0, 20)
	name.Position = UDim2.new(0, 56, 0, 8)
	name.BackgroundTransparency = 1
	name.Text = plr.Name
	name.TextColor3 = Color3.new(1, 1, 1)
	name.Font = Enum.Font.Gotham
	name.TextSize = 16
	name.TextXAlignment = Enum.TextXAlignment.Left

	local kills = Instance.new("TextLabel", card)
	kills.Size = UDim2.new(0.33, -12, 0, 16)
	kills.Position = UDim2.new(0, 56, 0, 34)
	kills.BackgroundTransparency = 1
	kills.Text = "Kills: 0"
	kills.TextColor3 = Color3.new(1, 1, 1)
	kills.Font = Enum.Font.Gotham
	kills.TextSize = 14
	kills.TextXAlignment = Enum.TextXAlignment.Left

	local deaths = Instance.new("TextLabel", card)
	deaths.Size = UDim2.new(0.33, -12, 0, 16)
	deaths.Position = UDim2.new(0.33, 0, 0, 34)
	deaths.BackgroundTransparency = 1
	deaths.Text = "Deaths: 0"
	deaths.TextColor3 = Color3.new(1, 1, 1)
	deaths.Font = Enum.Font.Gotham
	deaths.TextSize = 14
	deaths.TextXAlignment = Enum.TextXAlignment.Left

	local kd = Instance.new("TextLabel", card)
	kd.Size = UDim2.new(0.34, 0, 0, 16)
	kd.Position = UDim2.new(0.66, 0, 0, 34)
	kd.BackgroundTransparency = 1
	kd.Text = "K/D: 0"
	kd.TextColor3 = Color3.new(1, 1, 1)
	kd.Font = Enum.Font.Gotham
	kd.TextSize = 14
	kd.TextXAlignment = Enum.TextXAlignment.Left

	local hs = Instance.new("TextLabel", card)
	hs.Size = UDim2.new(0.33, -12, 0, 16)
	hs.Position = UDim2.new(0, 56, 0, 54)
	hs.BackgroundTransparency = 1
	hs.Text = "HS%: 0%"
	hs.TextColor3 = Color3.new(1, 1, 1)
	hs.Font = Enum.Font.Gotham
	hs.TextSize = 14
	hs.TextXAlignment = Enum.TextXAlignment.Left

	local health = Instance.new("TextLabel", card)
	health.Size = UDim2.new(0.33, -12, 0, 16)
	health.Position = UDim2.new(0.33, 0, 0, 54)
	health.BackgroundTransparency = 1
	health.Text = "HP: 100"
	health.TextColor3 = Color3.new(1, 1, 1)
	health.Font = Enum.Font.Gotham
	health.TextSize = 14
	health.TextXAlignment = Enum.TextXAlignment.Left

	local armor = Instance.new("TextLabel", card)
	armor.Size = UDim2.new(0.34, 0, 0, 16)
	armor.Position = UDim2.new(0.66, 0, 0, 54)
	armor.BackgroundTransparency = 1
	armor.Text = "Armor: 0"
	armor.TextColor3 = Color3.new(1, 1, 1)
	armor.Font = Enum.Font.Gotham
	armor.TextSize = 14
	armor.TextXAlignment = Enum.TextXAlignment.Left

	local mvps = Instance.new("TextLabel", card)
	mvps.Size = UDim2.new(1, -16, 0, 16)
	mvps.Position = UDim2.new(0, 8, 0, 74)
	mvps.BackgroundTransparency = 1
	mvps.Text = "MVPs: 0"
	mvps.TextColor3 = Color3.new(1, 1, 1)
	mvps.Font = Enum.Font.Gotham
	mvps.TextSize = 14
	mvps.TextXAlignment = Enum.TextXAlignment.Left

	playerStats[plr] = {
		UI = {
			Kills = kills,
			Deaths = deaths,
			KD = kd,
			HS = hs,
			Health = health,
			Armor = armor,
			MVPs = mvps,
		}
	}

	return card
end

local function updatePlayerStats(plr)
	if not playerStats[plr] then return end

	local stats = playerStats[plr]
	local status = plr:FindFirstChild("Status")
	if not status then return end

	local kills = status:FindFirstChild("Kills") and status.Kills.Value or 0
	local deaths = status:FindFirstChild("Deaths") and status.Deaths.Value or 0
	local headshots = status:FindFirstChild("Headshots") and status.Headshots.Value or 0
	local mvps = status:FindFirstChild("MVPs") and status.MVPs.Value or 0
	local health = status:FindFirstChild("Health") and status.Health.Value or 100
	local armor = status:FindFirstChild("Kevlar") and status.Kevlar.Value or 0

	local kdValue = deaths > 0 and (kills / deaths) or kills
	local hsPercent = kills > 0 and (headshots / kills) * 100 or 0

	local ui = stats.UI
	ui.Kills.Text = "Kills: "..kills
	ui.Deaths.Text = "Deaths: "..deaths
	ui.KD.Text = ("K/D: %.2f"):format(kdValue)
	ui.HS.Text = string.format("HS%%: %.0f%%", hsPercent)
	ui.Health.Text = "HP: "..health
	ui.Armor.Text = "Armor: "..armor
	ui.MVPs.Text = "MVPs: "..mvps
end

local function insertCard(plr)
	if plr == LocalPlayer then return end

	if playerCards[plr] then
		playerCards[plr]:Destroy()
		playerCards[plr] = nil
		playerStats[plr] = nil
	end

	local team = "Spectator"
	local status = plr:FindFirstChild("Status")
	if status and status:FindFirstChild("Team") then
		team = status.Team.Value
	end

	local teamLower = team:lower()
	if teamLower:find("ct") then
		local card = createPlayerCard(plr)
		playerCards[plr] = card
		card.Parent = ctContainer
		updatePlayerStats(plr)
	elseif teamLower:find("t") then
		local card = createPlayerCard(plr)
		playerCards[plr] = card
		card.Parent = tContainer
		updatePlayerStats(plr)
	end
end

local function removeCard(plr)
	if playerCards[plr] then
		playerCards[plr]:Destroy()
		playerCards[plr] = nil
		playerStats[plr] = nil
	end
end

local function watchStatus(plr)
	local function setupStatus()
		local status = plr:FindFirstChild("Status")
		if status then
			for _, statName in pairs({"Kills","Deaths","Headshots","MVPs","Health","Kevlar","Team"}) do
				local stat = status:FindFirstChild(statName)
				if stat then
					stat.Changed:Connect(function()
						insertCard(plr)
					end)
				end
			end
		end
	end
	if plr:FindFirstChild("Status") then
		setupStatus()
	else
		plr.ChildAdded:Connect(function(child)
			if child.Name == "Status" then
				setupStatus()
			end
		end)
	end
end

for _, plr in ipairs(Players:GetPlayers()) do
	insertCard(plr)
	watchStatus(plr)
end

Players.PlayerAdded:Connect(function(plr)
	insertCard(plr)
	watchStatus(plr)
end)

Players.PlayerRemoving:Connect(function(plr)
	removeCard(plr)
end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
		mainFrame.Visible = not mainFrame.Visible
	end
end)

local resizeHandle = Instance.new("Frame", mainFrame)
resizeHandle.Size = UDim2.new(0, 16, 0, 16)
resizeHandle.Position = UDim2.new(1, -16, 1, -16)
resizeHandle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
resizeHandle.BorderSizePixel = 0
Instance.new("UICorner", resizeHandle).CornerRadius = UDim.new(0, 3)

local draggingResize = false
local startInputPos, startSize

resizeHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingResize = true
		startInputPos = input.Position
		startSize = mainFrame.Size
	end
end)

resizeHandle.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingResize = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingResize and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - startInputPos
		local newWidth = math.clamp(startSize.X.Offset + delta.X, 180, 800)
		local newHeight = math.clamp(startSize.Y.Offset + delta.Y, 200, 800)
		mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
	end
end)

local function updateCanvas()
	task.wait()
	local totalHeight =
		ctLabel.AbsoluteSize.Y + ctContainer.AbsoluteSize.Y +
		tLabel.AbsoluteSize.Y + tContainer.AbsoluteSize.Y +
		(mainLayout.Padding.Offset * 3) + 20

	listFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

for _, container in pairs({ctContainer, tContainer}) do
	local layout = container:FindFirstChildOfClass("UIListLayout")
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
end

mainLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
task.spawn(updateCanvas)
