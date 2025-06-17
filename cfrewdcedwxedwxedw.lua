-- //ui
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

local WebhookURL = "https://discord.com/api/webhooks/1384559349476888686/PGtPwXzk6Q70-Z7YoLiO88aG0M8upJYLuomc3G2WsKeSnJ5hI_uGYsHiTwH0t5O6PSDe"

local KillSwitchEnabled = false

local StrikeData = {}
local MaxStrikes = 3

function AddStrike(userId)
	if not StrikeData[userId] then
		StrikeData[userId] = 1
	else
		StrikeData[userId] = StrikeData[userId] + 1
	end

	if StrikeData[userId] >= MaxStrikes then
		Players.LocalPlayer:Kick("You have been blacklisted due to multiple failed checks.")
		return true
	end
	return false
end

function RunValidationCheck()
	if KillSwitchEnabled then
		local blacklisted = AddStrike(LocalPlayer.UserId)
		if blacklisted then return false end
	end
	return true
end

function detectExecutor()
	if identifyexecutor then
		local name = identifyexecutor():lower()
		local mapping = {
			solara = "Solara", wave = "Wave", swift = "Swift",
			hydrogen = "Hydrogen", delta = "Delta", scriptware = "ScriptWare",
			synapse = "Synapse X", xeno = "Xeno", electron = "Electron",
			arceus = "Arceus X", nihon = "Nihon", furkos = "Furk OS",
			cryptic = "Cryptic", codex = "Codex", ["synapse z"] = "Synapse Z",
			velocity = "Velocity", ronix = "Ronix", awp = "AWP"
		}
		for key, label in pairs(mapping) do
			if name:find(key) then return label end
		end
		return name:gsub("^%l", string.upper)
	elseif syn and syn.request then
		return "Synapse X"
	end
	return "Unknown Executor"
end

function getDeviceType()
	if UIS.TouchEnabled and not UIS.KeyboardEnabled then
		return "Mobile"
	elseif UIS.GamepadEnabled and not UIS.KeyboardEnabled then
		return "Console"
	elseif UIS.KeyboardEnabled and UIS.MouseEnabled then
		return "Computer"
	else
		return "Unknown"
	end
end

if not RunValidationCheck() then return end

local username = LocalPlayer.Name
local displayName = LocalPlayer.DisplayName
local executorName = detectExecutor()
local deviceType = getDeviceType()
local userId = LocalPlayer.UserId
local gameId = game.GameId

local gameName = "Unknown"
if gameId == 111958650 then
	gameName = "Arsenal"
elseif gameId == 115797356 then
	gameName = "Counterblox"
end

local embed = {
	["title"] = "Script Injected",
	["description"] = string.format(
		"**Username:** %s (%s)\n**UserId:** %d\n**Executor:** %s\n**Device:** %s\n**Game:** %s",
		username, displayName, userId, executorName, deviceType, gameName),
	["color"] = tonumber(0x00ff00),
	["footer"] = { ["text"] = "Injection Time" },
	["timestamp"] = DateTime.now():ToIsoDate()
}

local payload = {
	["username"] = "Script Logger",
	["embeds"] = {embed}
}

local headers = {
	["Content-Type"] = "application/json"
}

local body = HttpService:JSONEncode(payload)

function sendWebhook()
	local req = syn and syn.request or http and http.request or request
	if req then
		req({
			Url = WebhookURL,
			Method = "POST",
			Headers = headers,
			Body = body
		})
	else
		warn("Executor does not support HTTP requests.")
	end
end

sendWebhook()

-- // Clones
local CWorkspace = cloneref(game:GetService("Workspace")) 
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local CoreGui = cloneref(game:GetService("CoreGui"))

-- // Variables
local LocalPlayer = Players.LocalPlayer
local Camera = CWorkspace.CurrentCamera
local Weapons = ReplicatedStorage:FindFirstChild("Weapons")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CompareInstances = (CompareInstances and function(Instance1, Instance2)
    if typeof(Instance1) == "Instance" and typeof(Instance2) == "Instance" then
        return CompareInstances(Instance1, Instance2)
    end
end) or function(Instance1, Instance2)
    return (typeof(Instance1) == "Instance" and typeof(Instance2) == "Instance")
end

local CanCastToSTDString = function(...)
    return pcall(FindFirstChild, game, ...)
end

local Options = Library.Options
local Toggles = Library.Toggles

local lightPurple = "#C084FC"
local white = "#FFFFFF"

Library:Notify("<font color='" .. lightPurple .. "'>Welcome</font><font color='" .. white .. "'> to </font><font color='" .. lightPurple .. "'>iri</font><font color='" .. white .. "'>.yaw</font>")
Library:Notify("<font color='" .. lightPurple .. "'>Version:</font><font color='" .. white .. "'>1.1</font>")

local Window = Library:CreateWindow({
	Title = "<font color='" .. lightPurple .. "'>iri</font><font color='" .. white .. "'>.yaw</font>",
	Footer = "<font color='" .. lightPurple .. "'>Version:</font><font color='" .. white .. "'>1.1</font>",
	NotifySide = "Right",
	ShowCustomCursor = true,
})

local Tabs = {
    legit = Window:AddTab("Aimbot", "target"),
    visuals = Window:AddTab("Visuals", "eye"),
    world = Window:AddTab("World", "globe"),
    misc = Window:AddTab("Misc", "user"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local LeftGroupBox = Tabs.legit:AddLeftGroupbox("Aimbot")

local trigger = false
local toggleKey = Enum.UserInputType.MouseButton2
local TriggerDelay = 0.1
local SelectedParts = {"Head"}
local keyMode = "Toggle"
local holding = false

RunService.RenderStepped:Connect(function()
	local shouldTrigger =
		(keyMode == "Always") or
		(keyMode == "Toggle" and trigger) or
		(keyMode == "Hold" and holding)

	if shouldTrigger then
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then return end

		local target = mouse.Target and mouse.Target.Parent
		if target and target:FindFirstChildOfClass("Humanoid") then
			local targetHumanoid = target:FindFirstChildOfClass("Humanoid")
			local targetPlayer = Players:GetPlayerFromCharacter(target)
			local targetPart = mouse.Target

			local isTargetValid = false
			if table.find(SelectedParts, "Head") and targetPart.Name == "Head" then
				isTargetValid = true
			elseif table.find(SelectedParts, "UpperTorso") and targetPart.Name == "UpperTorso" then
				isTargetValid = true
			elseif table.find(SelectedParts, "LowerTorso") and targetPart.Name == "LowerTorso" then
				isTargetValid = true
			elseif table.find(SelectedParts, "Arms") and (targetPart.Name == "LeftUpperArm" or targetPart.Name == "RightUpperArm" or targetPart.Name == "LeftLowerArm" or targetPart.Name == "RightLowerArm") then
				isTargetValid = true
			elseif table.find(SelectedParts, "Legs") and (targetPart.Name == "LeftUpperLeg" or targetPart.Name == "RightUpperLeg" or targetPart.Name == "LeftLowerLeg" or targetPart.Name == "RightLowerLeg") then
				isTargetValid = true
			end

			if isTargetValid and targetHumanoid.Health > 0 and targetPlayer and targetPlayer.Team ~= LocalPlayer.Team then
				mouse1press()
				wait(0.05)
				mouse1release()
				wait(TriggerDelay)
			end
		end
	end
end)

-- // legit bot
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

local legit = {
    AimbotEnabled = false,
    VisibilityCheck = false,
    AimSmoothness = 10,
    FOVRadius = 100,
    SmoothEnabled = true,
    BoneSwitchTime = 1,
    TargetBone = "Head",
    TeamCheckEnabled = false,
    BoneSwitchEnabled = false,
    type = "Mouse",
    fovEnabled = false,
    SelectedHitboxes = {"Head", "UpperTorso", "LowerTorso"}
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Filled = false
FOVCircle.Transparency = 1
FOVCircle.Visible = false
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Color = Color3.new(1, 1, 1)
FOVCircle.Radius = legit.FOVRadius

local ViewLine = Drawing.new("Line")
ViewLine.Thickness = 1
ViewLine.Transparency = 1
ViewLine.Color = Color3.new(1, 1, 1)
ViewLine.Visible = false

local lineEnabled = false
local triggerbot = false
local fireRate = 0.1

function GetRaycastParams()
    local RaycastParams = RaycastParams.new()
    RaycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    return RaycastParams
end

function toggleFOV(state)
    FOVCircle.Visible = state
end

function toggleLine(state)
    lineEnabled = state
end

function UpdateFOV()
    local ViewportSize = Camera.ViewportSize
    FOVCircle.Position = Vector2.new(ViewportSize.X / 2, ViewportSize.Y / 2)
    FOVCircle.Radius = legit.FOVRadius
    FOVCircle.Visible = legit.fovEnabled
end

function IsVisible(target)
    if not legit.VisibilityCheck then return true end
    local origin = Camera.CFrame.Position
    local direction = (target.Position - origin).Unit * (target.Position - origin).Magnitude
    local result = workspace:Raycast(origin, direction, GetRaycastParams())
    return result == nil or (result.Instance and result.Instance:IsDescendantOf(target.Parent))
end

function GetBoneParts(character)
    local parts = {}
    for _, hitbox in ipairs(legit.SelectedHitboxes) do
        if hitbox == "Head" then
            local head = character:FindFirstChild("Head")
            if head then table.insert(parts, head) end
        elseif hitbox == "UpperTorso" then
            local upper = character:FindFirstChild("UpperTorso")
            if upper then table.insert(parts, upper) end
        elseif hitbox == "LowerTorso" then
            local lower = character:FindFirstChild("LowerTorso")
            if lower then table.insert(parts, lower) end
        elseif hitbox == "Arms" then
            for _, name in ipairs({"LeftArm", "RightArm", "LeftHand", "RightHand", "LeftUpperArm", "RightUpperArm"}) do
                local part = character:FindFirstChild(name)
                if part then table.insert(parts, part) end
            end
        elseif hitbox == "Legs" then
            for _, name in ipairs({"LeftLeg", "RightLeg", "LeftFoot", "RightFoot", "LeftUpperLeg", "RightUpperLeg"}) do
                local part = character:FindFirstChild(name)
                if part then table.insert(parts, part) end
            end
        end
    end
    return parts
end

function IsOnSameTeam(Player)
    return Player.Team == LocalPlayer.Team
end

function GetClosestTarget()
    local closestTarget = nil
    local shortestDistance = math.huge
    local ViewportSize = Camera.ViewportSize
    local CrosshairPos = Vector2.new(ViewportSize.X / 2, ViewportSize.Y / 2)

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character then
            local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                if not legit.TeamCheckEnabled or not IsOnSameTeam(Player) then
                    local parts = GetBoneParts(Player.Character)
                    for _, part in ipairs(parts) do
                        if part and IsVisible(part) then
                            local screenPoint, onScreen = Camera:WorldToViewportPoint(part.Position)
                            if onScreen then
                                local targetPos = Vector2.new(screenPoint.X, screenPoint.Y)
                                local distanceToCrosshair = (targetPos - CrosshairPos).Magnitude
                                if distanceToCrosshair < shortestDistance and distanceToCrosshair < legit.FOVRadius then
                                    closestTarget = part
                                    shortestDistance = distanceToCrosshair
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return closestTarget
end

task.spawn(function()
    while true do
        if legit.BoneSwitchEnabled then
            if legit.TargetBone == "Head" then
                legit.TargetBone = "UpperTorso"
            elseif legit.TargetBone == "UpperTorso" then
                legit.TargetBone = "LowerTorso"
            elseif legit.TargetBone == "LowerTorso" then
                legit.TargetBone = "Arms"
            elseif legit.TargetBone == "Arms" then
                legit.TargetBone = "Legs"
            else
                legit.TargetBone = "Head"
            end
        end
        task.wait(legit.BoneSwitchTime)
    end
end)

RunService.RenderStepped:Connect(function()
    if legit.AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = GetClosestTarget()
        if target then
            local targetPos = Camera:WorldToScreenPoint(target.Position)

            if legit.type == "Mouse" then
                local moveX = (targetPos.X - Mouse.X) / legit.AimSmoothness
                local moveY = (targetPos.Y - Mouse.Y) / legit.AimSmoothness
                mousemoverel(moveX, moveY)

            elseif legit.type == "Camera" and Camera.CameraType == Enum.CameraType.Scriptable then
                local targetCFrame = CFrame.new(Camera.CFrame.Position, target.Position)
                local smoothFactor = legit.SmoothEnabled and math.clamp(legit.AimSmoothness / 100, 0.01, 1) or 1
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, smoothFactor)
            end

            if lineEnabled then
                ViewLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                ViewLine.To = Vector2.new(targetPos.X, targetPos.Y)
                ViewLine.Visible = true
            end

            if triggerbot then
                mouse1press()
                task.wait(fireRate)
                mouse1release()
            end
        else
            ViewLine.Visible = false
        end
    else
        ViewLine.Visible = false
    end
end)

LeftGroupBox:AddToggle("AimbotToggle", {
	Text = "Aim Assist",
	Default = false,
	Callback = function(state)
        legit.AimbotEnabled = state
	end,
})

LeftGroupBox:AddToggle("TeamCheckToggle", {
	Text = "Team Check",
	Default = false,
	Callback = function(state)
        legit.TeamCheckEnabled = state
	end,
})

LeftGroupBox:AddToggle("VisibilityCheckToggle", {
	Text = "Vis Check",
	Default = false,
	Callback = function(state)
        legit.VisibilityCheck = state
	end,
})

LeftGroupBox:AddToggle("BoneSwitchToggle", {
	Text = "Bone Switch",
	Default = false,
	Callback = function(state)
        legit.BoneSwitchEnabled = state
	end,
})

LeftGroupBox:AddToggle("FovToggle", {
	Text = "Fov Circle",
	Default = false,
	Callback = function(state)
        legit.fovEnabled = state
	end,
})
:AddColorPicker("FovColor", {
	Title = "FOV Color",
	Default = Color3.fromRGB(255, 255, 255),
	Transparency = 0,
	Callback = function(color)
		fovCircle.Color = color
	end
})

LeftGroupBox:AddToggle("LineToggle", {
	Text = "Target Line",
	Default = false,
	Callback = function(state)
        lineEnabled = state
	end,
})
:AddColorPicker("LineColor", {
	Default = Color3.new(1, 0, 0),
	Title = "Target Line Color",
	Transparency = 0,
	Callback = function(color)
        ViewLine.Color = color
	end,
})

LeftGroupBox:AddDropdown("TypeDropdown", {
	Values = { "Mouse", "Camera" },
	Default = 1,
	Searchable = true,
	Multi = false,
	Text = "Aim Type",
	Callback = function(value)
        legit.type = value
	end,
})

LeftGroupBox:AddDropdown("HitboxDropdown", {
	Values = { "Head", "UpperTorso", "LowerTorso", "Arms", "Legs" },
	Default = 1,
	Multi = false,
	Text = "Hitboxes",
	Callback = function(value)
        legit.SelectedHitboxes = {value}
	end,
})

LeftGroupBox:AddSlider("FOVSlider", {
	Text = "Fov Radius",
	Default = 100,
	Min = 0,
	Max = 300,
	Rounding = 0,
	Callback = function(value)
        legit.FOVRadius = value
        UpdateFOV()
	end,
})

LeftGroupBox:AddSlider("SmoothnessSlider", {
	Text = "Smoothness",
	Min = 1,
	Max = 100,
	Default = 5,
	Rounding = 0,
	Callback = function(value)
        legit.AimSmoothness = value
	end,
})

local silentAim = loadstring(game:HttpGet("https://raw.githubusercontent.com/YellowGregs/Loadstring/refs/heads/main/Arsenal_Silent-Aim.luau"))()

local LegitSilent = Tabs.legit:AddRightGroupbox("Silent Aim")

LegitSilent:AddToggle("SilentAimToggle", {
	Text = "Silent Aim",
	Default = false,
	Callback = function(state)
        silentAim.Enabled = state
	end,
})

LegitSilent:AddToggle("TeamCheckToggle", {
	Text = "Team Check",
	Default = false,
	Callback = function(state)
        silentAim.TeamCheck = state
	end,
})

LegitSilent:AddToggle("WallCheckToggle", {
	Text = "Vis Check",
	Default = false,
	Callback = function(state)
        silentAim.WallCheck = state
	end,
})

LegitSilent:AddToggle("PredictionToggle", {
	Text = "Prediction",
	Default = false,
	Callback = function(state)
        silentAim.Prediction.Enabled = state
	end,
})

LegitSilent:AddSlider("PredictionAmountSlider", {
    Text = "Prediction Amount",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        silentAim.Prediction.Amount = Value / 1000
    end,
})

LegitSilent:AddToggle("FovToggle", {
	Text = "Fov Circle",
	Default = false,
	Callback = function(state)
		silentAim.FovSettings.Visible = state
	end,
})
:AddColorPicker("FovColorPicker", {
	Default = Color3.new(1, 1, 1),
	Title = "Fov Color",
	Callback = function(color)
		silentAim.FovSettings.Color = color
	end,
})

LegitSilent:AddSlider("FovRadiusSlider", {
    Text = "Fov Radius",
    Default = 100,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)
        silentAim.Fov = Value
    end,
})

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
local extra = Tabs["UI Settings"]:AddRightGroupbox("Extra")
local presets = Tabs["UI Settings"]:AddRightGroupbox("Presets")

MenuGroup:AddToggle("KeybindMenuOpen", {
	Default = Library.KeybindFrame.Visible,
	Text = "Open Keybind Menu",
	Callback = function(value)
		Library.KeybindFrame.Visible = value
	end,
})
MenuGroup:AddToggle("ShowCustomCursor", {
	Text = "Custom Cursor",
	Default = true,
	Callback = function(Value)
		Library.ShowCustomCursor = Value
	end,
})
MenuGroup:AddDropdown("NotificationSide", {
	Values = { "Left", "Right" },
	Default = "Right",

	Text = "Notification Side",

	Callback = function(Value)
		Library:SetNotifySide(Value)
	end,
})
MenuGroup:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",

	Text = "DPI Scale",

	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local DPI = tonumber(Value)

		Library:SetDPIScale(DPI)
	end,
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind")
	:AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind 

local LeftMisc = Tabs.misc:AddLeftGroupbox("Gun Mods")
local LeftMisc2 = Tabs.misc:AddLeftGroupbox("Movement")
local RightMisc = Tabs.misc:AddRightGroupbox("Extra")
local RightMisc2 = Tabs.misc:AddRightGroupbox("Chat")

LeftMisc2:AddToggle("MyToggle", {
    Text = "Bhop",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        Bhop = state
    end,
})

LeftMisc2:AddSlider("MySlider", {
    Text = "Bhop Speed",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        BhopSpeed = value
    end,
})

local movement = {
    --//fly
    flying = false,
    speed = 50,
    moveDirection = Vector3.new(0, 0, 0),
    up = false,
    down = false,
    --//noclip
    noclip = false,
    --//inf jump
    infjump = false,
}

LeftMisc2:AddToggle("MyToggle", {
    Text = "Fly",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        movement.flying = state
    end,
})

LeftMisc2:AddSlider("MySlider", {
    Text = "Fly Speed",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        movement.speed = value
    end,
})

LeftMisc2:AddToggle("MyToggle", {
    Text = "Inf Jump",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        infjump = state
    end,
})

LeftMisc2:AddToggle("MyToggle", {
    Text = "Noclip",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        infjump = state
    end,
})

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.Space then
        movement.up = true
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        movement.down = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Space then
        movement.up = false
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        movement.down = false
    end
end)

RunService.RenderStepped:Connect(function(deltaTime)
    if movement.flying and humanoidRootPart then
        local camera = workspace.CurrentCamera
        local camCFrame = camera.CFrame

        local forward = camCFrame.LookVector
        local right = camCFrame.RightVector

        local move = Vector3.new(0, 0, 0)

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            move = move + forward
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            move = move - forward
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            move = move - right
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            move = move + right
        end

        if move.Magnitude > 0 then
            move = move.Unit * movement.speed
        else
            move = Vector3.new(0, 0, 0)
        end

        local y = 0
        if movement.up then
            y = movement.speed
        elseif movement.down then
            y = -movement.speed
        end

        local newVelocity = Vector3.new(move.X, y, move.Z)
        humanoidRootPart.Velocity = newVelocity
    end
end)

RunService.Stepped:Connect(function()
    if movement.noclip and character then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if movement.infjump and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local flags = {
    "IsChad",
    "VIP",
    "OldVIP",
    "Romin",
    "IsAdmin",
}

local function createFlag(flagName)
    local Player = game.Players.LocalPlayer
    if Player:FindFirstChild(flagName) then return end
    local flag = Instance.new("IntValue")
    flag.Name = flagName
    flag.Parent = Player
end

local function destroyFlag(flagName)
    local Player = game.Players.LocalPlayer
    local existing = Player:FindFirstChild(flagName)
    if existing then existing:Destroy() end
end

for _, flagName in ipairs(flags) do
    RightMisc2:AddToggle(flagName, {
        Text = flagName,
        Tooltip = "",
        Default = false,
        Callback = function(state)
            if state then
                createFlag(flagName)
            else
                destroyFlag(flagName)
            end
        end,
    })
end

local original_stats = { Score = nil, Kills = nil }

RightMisc:AddToggle("MyToggle", {
    Text = "Max Level",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        local stats = LocalPlayer.CareerStatsCache

        if state then
            if not original_stats.Score then
                original_stats.Score = stats.Score.Value
            end
            if not original_stats.Kills then
                original_stats.Kills = stats.Kills.Value
            end

            stats.Score.Value = 1e18
            stats.Kills.Value = 1e14
        else
            if original_stats.Score and original_stats.Kills then
                stats.Score.Value = original_stats.Score
                stats.Kills.Value = original_stats.Kills
            end
        end
    end,
})

local Player = game:GetService("Players").LocalPlayer
local pingValue = Player:FindFirstChild("Ping")

if not pingValue then
    pingValue = Instance.new("NumberValue")
    pingValue.Name = "Ping"
    pingValue.Parent = Player
end

local settingInternally = false
local fakePingEnabled = false
local originalPing = pingValue.Value

function setPing(value)
    settingInternally = true
    pingValue.Value = value
    settingInternally = false
end

local conn
conn = pingValue.Changed:Connect(function(newValue)
    if fakePingEnabled then
        if not settingInternally and newValue ~= 999 then
            setPing(999999999999)
        end
    end
end)

RightMisc:AddToggle("FakePingToggle", {
    Text = "Fake Ping",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        fakePingEnabled = state
        if fakePingEnabled then
            originalPing = pingValue.Value
            setPing(999999999999)
        else
            setPing(originalPing)
        end
    end,
})

local Player = Players.LocalPlayer

local FastClimbEnabled = false
local NoFallDamageEnabled = false
local climbSpeed = 50

function setupFastClimb(character)
    local humanoid = character:WaitForChild("Humanoid")
    local root = character:WaitForChild("HumanoidRootPart")
    local climbing = false
    local heartbeatConnection

    function stopClimbing()
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
    end

    humanoid.StateChanged:Connect(function(_, newState)
        if FastClimbEnabled and newState == Enum.HumanoidStateType.Climbing then
            climbing = true
            stopClimbing()
            heartbeatConnection = RunService.Heartbeat:Connect(function()
                if humanoid:GetState() == Enum.HumanoidStateType.Climbing then
                    local currentVel = root.Velocity
                    root.Velocity = Vector3.new(currentVel.X, climbSpeed, currentVel.Z)
                else
                    stopClimbing()
                end
            end)
        else
            climbing = false
            stopClimbing()
        end
    end)

    humanoid.Died:Connect(stopClimbing)
end

function preventFallDamage(character)
    local humanoid = character:WaitForChild("Humanoid")
    local lastHealth = humanoid.Health

    humanoid.HealthChanged:Connect(function(health)
        if NoFallDamageEnabled and health < lastHealth then
            local state = humanoid:GetState()
            if state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.Landed then
                humanoid.Health = lastHealth
            else
                lastHealth = health
            end
        else
            lastHealth = health
        end
    end)
end

function onCharacter(character)
    setupFastClimb(character)
    preventFallDamage(character)
end

if Player.Character then
    onCharacter(Player.Character)
end

Player.CharacterAdded:Connect(onCharacter)

RightMisc:AddToggle("FastClimbToggle", {
    Text = "Fast Ladder",
    Tooltip = "Climb ladders faster",
    Default = false,
    Callback = function(state)
        FastClimbEnabled = state
    end,
})

RightMisc:AddToggle("NoFallDamageToggle", {
    Text = "No Fall Damage",
    Tooltip = "Prevents fall damage",
    Default = false,
    Callback = function(state)
        NoFallDamageEnabled = state
    end,
})

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local status = localPlayer:WaitForChild("Status")
local originalDevice = status.InputDevice.Value
local DeviceSpoofer = "Gamepad"
local DeviceSpooferEnabled = false

RightMisc:AddToggle("DeviceSpooferToggle", {
    Text = "Enable Device Spoofer",
    Tooltip = "Toggle the device spoofing on/off",
    Default = false,
    Callback = function(state)
        DeviceSpooferEnabled = state
        if DeviceSpooferEnabled then
            status.InputDevice.Value = DeviceSpoofer
        else
            status.InputDevice.Value = originalDevice
        end
    end,
})

local spoofOptions = {"Keyboard", "Mobile", "Gamepad"}

RightMisc:AddDropdown("DeviceSpoofOptions", {
    Values = spoofOptions,
    Text = "Device",
    MultiSelect = false,
    Callback = function(selectedOption)
        DeviceSpoofer = selectedOption
        if DeviceSpooferEnabled then
            status.InputDevice.Value = DeviceSpoofer
        end
    end,
})

RightMisc:AddButton({
    Text = "Redeem All Codes",
    Func = function()
        local codes = {
            "TRGTBOARD", "FLAMINGO", "enforcer", "XONAE",
            "EPRIKA", "GARCELLO", "ROLVE", "POKE",
            "Bandites", "E", "JOHN", "PET", "ANNA",
            "F00LISH", "CBROX"
        }

        for _, code in ipairs(codes) do
            local args = { [1] = code }
            game:GetService("ReplicatedStorage").Redeem:InvokeServer(unpack(args))
            wait(1)
        end
    end,
})

RightMisc:AddButton({
    Text = "Free Badge",
    Func = function()
        game:GetService("ReplicatedStorage").Events.ReplicateGear2:FireServer("Fremzy")
    end,
})

local originalValues = {
    InfiniteAmmo_CurrentCurse = nil,
    InfiniteAmmo_ammocount = nil,
    InfiniteAmmo_ammocount2 = nil,
    FastReload = {},
    FastFireRate = {},
    AlwaysAuto = {},
    NoSpread = {},
    NoRecoil = {},
    EquipTime = {},
    SpreadRecovery = {},
}

LeftMisc:AddToggle("InfiniteAmmoToggle", {
    Text = "Infinite Ammo",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        if ReplicatedStorage:FindFirstChild("wkspc") and ReplicatedStorage.wkspc:FindFirstChild("CurrentCurse") then
            if state then
                if originalValues.InfiniteAmmo_CurrentCurse == nil then
                    originalValues.InfiniteAmmo_CurrentCurse = ReplicatedStorage.wkspc.CurrentCurse.Value
                end
                ReplicatedStorage.wkspc.CurrentCurse.Value = "Infinite Ammo"
            else
                if originalValues.InfiniteAmmo_CurrentCurse then
                    ReplicatedStorage.wkspc.CurrentCurse.Value = originalValues.InfiniteAmmo_CurrentCurse
                    originalValues.InfiniteAmmo_CurrentCurse = nil
                end
            end
        end
        if PlayerGui then
            local gui = PlayerGui:FindFirstChild("GUI")
            if gui and gui:FindFirstChild("Client") and gui.Client:FindFirstChild("Variables") then
                local vars = gui.Client.Variables
                if vars:FindFirstChild("ammocount") then
                    if state then
                        if originalValues.InfiniteAmmo_ammocount == nil then
                            originalValues.InfiniteAmmo_ammocount = vars.ammocount.Value
                        end
                        vars.ammocount.Value = 99
                    else
                        if originalValues.InfiniteAmmo_ammocount then
                            vars.ammocount.Value = originalValues.InfiniteAmmo_ammocount
                            originalValues.InfiniteAmmo_ammocount = nil
                        end
                    end
                end
                if vars:FindFirstChild("ammocount2") then
                    if state then
                        if originalValues.InfiniteAmmo_ammocount2 == nil then
                            originalValues.InfiniteAmmo_ammocount2 = vars.ammocount2.Value
                        end
                        vars.ammocount2.Value = 99
                    else
                        if originalValues.InfiniteAmmo_ammocount2 then
                            vars.ammocount2.Value = originalValues.InfiniteAmmo_ammocount2
                            originalValues.InfiniteAmmo_ammocount2 = nil
                        end
                    end
                end
            end
        end
    end,
})

LeftMisc:AddToggle("FastReloadToggle", {
    Text = "Instant Reload",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, weapon in ipairs(Weapons:GetChildren()) do
            local reloadTime = weapon:FindFirstChild("ReloadTime")
            local eReloadTime = weapon:FindFirstChild("EReloadTime")
            if reloadTime and reloadTime:IsA("NumberValue") then
                if state then
                    if originalValues.FastReload[weapon] == nil then
                        originalValues.FastReload[weapon] = {}
                    end
                    if originalValues.FastReload[weapon].ReloadTime == nil then
                        originalValues.FastReload[weapon].ReloadTime = reloadTime.Value
                    end
                    reloadTime.Value = 0.01
                else
                    if originalValues.FastReload[weapon] and originalValues.FastReload[weapon].ReloadTime then
                        reloadTime.Value = originalValues.FastReload[weapon].ReloadTime
                        originalValues.FastReload[weapon].ReloadTime = nil
                    end
                end
            end
            if eReloadTime and eReloadTime:IsA("NumberValue") then
                if state then
                    if originalValues.FastReload[weapon] == nil then
                        originalValues.FastReload[weapon] = {}
                    end
                    if originalValues.FastReload[weapon].EReloadTime == nil then
                        originalValues.FastReload[weapon].EReloadTime = eReloadTime.Value
                    end
                    eReloadTime.Value = 0.01
                else
                    if originalValues.FastReload[weapon] and originalValues.FastReload[weapon].EReloadTime then
                        eReloadTime.Value = originalValues.FastReload[weapon].EReloadTime
                        originalValues.FastReload[weapon].EReloadTime = nil
                    end
                end
            end
            if not next(originalValues.FastReload[weapon] or {}) then
                originalValues.FastReload[weapon] = nil
            end
        end
    end,
})

LeftMisc:AddToggle("FastFireRateToggle", {
    Text = "Full Auto",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, v in ipairs(Weapons:GetDescendants()) do
            if v:IsA("NumberValue") and (v.Name == "FireRate" or v.Name == "BFireRate") then
                if state then
                    if originalValues.FastFireRate[v] == nil then
                        originalValues.FastFireRate[v] = v.Value
                    end
                    v.Value = 0.02
                else
                    if originalValues.FastFireRate[v] then
                        v.Value = originalValues.FastFireRate[v]
                        originalValues.FastFireRate[v] = nil
                    end
                end
            end
        end
    end,
})

LeftMisc:AddToggle("AlwaysAutoToggle", {
    Text = "Rapid Fire",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        local autoNames = {
            Auto = true, AutoFire = true, Automatic = true, AutoShoot = true, AutoGun = true
        }
        for _, v in ipairs(Weapons:GetDescendants()) do
            if v:IsA("BoolValue") and autoNames[v.Name] then
                if state then
                    if originalValues.AlwaysAuto[v] == nil then
                        originalValues.AlwaysAuto[v] = v.Value
                    end
                    v.Value = true
                else
                    if originalValues.AlwaysAuto[v] ~= nil then
                        v.Value = originalValues.AlwaysAuto[v]
                        originalValues.AlwaysAuto[v] = nil
                    end
                end
            end
        end
    end,
})

LeftMisc:AddToggle("FastEquipToggle", {
    Text = "Fast Equip",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, v in ipairs(game:GetService("ReplicatedStorage").Weapons:GetDescendants()) do
            if v:IsA("NumberValue") and v.Name == "EquipTime" then
                if state then
                    if originalValues.FastEquip[v] == nil then
                        originalValues.FastEquip[v] = v.Value
                    end
                    v.Value = 0.05 
                else
                    if originalValues.FastEquip[v] ~= nil then
                        v.Value = originalValues.FastEquip[v]
                        originalValues.FastEquip[v] = nil
                    end
                end
            end
        end
    end,
})
LeftMisc:AddToggle("NoSpreadRecoveryToggle", {
    Text = "Remove Sway",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, v in ipairs(game:GetService("ReplicatedStorage").Weapons:GetDescendants()) do
            if v:IsA("NumberValue") and v.Name == "SpreadRecovery" then
                if state then
                    if originalValues.NoSpreadRecovery[v] == nil then
                        originalValues.NoSpreadRecovery[v] = v.Value
                    end
                    v.Value = 0 
                else
                    if originalValues.NoSpreadRecovery[v] ~= nil then
                        v.Value = originalValues.NoSpreadRecovery[v]
                        originalValues.NoSpreadRecovery[v] = nil
                    end
                end
            end
        end
    end,
})


LeftMisc:AddToggle("NoSpreadToggle", {
    Text = "Remove Spread",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        local spreadNames = { MaxSpread = true, Spread = true, SpreadControl = true }
        local weapons = game:GetService("ReplicatedStorage").Weapons
        if not originalValues.Spread then originalValues.Spread = {} end

        for _, v in pairs(weapons:GetDescendants()) do
            if v:IsA("NumberValue") and spreadNames[v.Name] then
                if state then
                    if not originalValues.Spread[v] then
                        originalValues.Spread[v] = v.Value
                    end
                    v.Value = 0
                else
                    if originalValues.Spread[v] then
                        v.Value = originalValues.Spread[v]
                        originalValues.Spread[v] = nil
                    else
                        v.Value = 1 
                    end
                end
            end
        end
    end,
})

LeftMisc:AddToggle("NoRecoilToggle", {
    Text = "Remove Recoil",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        local recoilNames = { RecoilControl = true, Recoil = true }
        local weapons = game:GetService("ReplicatedStorage").Weapons
        if not originalValues.Recoil then originalValues.Recoil = {} end

        for _, v in pairs(weapons:GetDescendants()) do
            if v:IsA("NumberValue") and recoilNames[v.Name] then
                if state then
                    if not originalValues.Recoil[v] then
                        originalValues.Recoil[v] = v.Value
                    end
                    v.Value = 0
                else
                    if originalValues.Recoil[v] then
                        v.Value = originalValues.Recoil[v]
                        originalValues.Recoil[v] = nil
                    else
                        v.Value = 1 
                    end
                end
            end
        end
    end,
})

local esp = Tabs.visuals:AddLeftGroupbox("Esp")
local chams1 = Tabs.visuals:AddRightGroupbox("Chams")

local chams = {
    InvisibleChamsEnabled = false,
    invisibleColor = Color3.fromRGB(255, 0, 0),
    VisibleChamsEnabled = false,
    visibleColor = Color3.fromRGB(0, 255, 0),
    fillTransparency = 0.3
}

chams1:AddToggle("VisibleChamsToggle", {
    Text = "Visible Chams",
    Default = false,
    Callback = function(state)
        chams.VisibleChamsEnabled = state
    end,
}):AddColorPicker("VisibleChamsColor", {
    Default = chams.visibleColor,
    Title = "",
    Transparency = 0,
    Callback = function(color)
        chams.visibleColor = color
        for _, h in pairs(highlights) do
            if h.Highlight and chams.VisibleChamsEnabled then
                h.Highlight.FillColor = chams.visibleColor
                h.Highlight.OutlineColor = chams.visibleColor
            end
        end
    end,
})

chams1:AddToggle("InvisibleChamsToggle", {
    Text = "Invisible Chams",
    Default = false,
    Callback = function(state)
        chams.InvisibleChamsEnabled = state
    end,
}):AddColorPicker("InvisibleChamsColor", {
    Default = chams.invisibleColor,
    Title = "",
    Transparency = 0,
    Callback = function(color)
        chams.invisibleColor = color
        for _, h in pairs(highlights) do
            if h.Highlight and chams.InvisibleChamsEnabled then
                h.Highlight.FillColor = chams.invisibleColor
                h.Highlight.OutlineColor = chams.invisibleColor
            end
        end
    end,
})

chams1:AddSlider("NightModeBrightnessSlider", {
    Text = "Transparency",
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        chams.fillTransparency = Value
        for _, h in pairs(highlights) do
            if h.Highlight then
                h.Highlight.FillTransparency = Value
            end
        end
    end,
})

local highlights = {}

function IsOnSameTeam(Player)
    return Player.Team == LocalPlayer.Team
end

function isVisible(character)
    local head = character:FindFirstChild("Head")
    if not head then return false end

    local origin = Camera.CFrame.Position
    local direction = (head.Position - origin)

    local PlayersToIgnore = {LocalPlayer.Character}
    for _, Player in pairs(Players:GetPlayers()) do
        if Player.Character and Player ~= LocalPlayer then
            table.insert(PlayersToIgnore, Player.Character)
        end
    end

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = PlayersToIgnore
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, raycastParams)

    return result and result.Instance and result.Instance:IsDescendantOf(character)
end

function createHighlight(Player)
    if not Player.Character then return nil end
    local highlight = Instance.new("Highlight")
    highlight.Name = "ChamsHighlight"
    highlight.Adornee = Player.Character
    highlight.FillTransparency = chams.fillTransparency or 0.3
    highlight.OutlineTransparency = 1
    highlight.Parent = Player.Character
    return highlight
end

function removeHighlightsForPlayer(Player)
    local h = highlights[Player]
    if h and typeof(h.Highlight) == "Instance" and h.Highlight.Destroy then
        h.Highlight:Destroy()
    end
    highlights[Player] = nil
end

function updateChams(Player)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
        removeHighlightsForPlayer(Player)
        return
    end

    if IsOnSameTeam(Player) then
        removeHighlightsForPlayer(Player)
        return
    end

    if not highlights[Player] or not highlights[Player].Highlight or not highlights[Player].Highlight:IsDescendantOf(game) then
        removeHighlightsForPlayer(Player)
        local newHighlight = createHighlight(Player)
        if newHighlight then
            highlights[Player] = { Highlight = newHighlight }
        else
            return
        end
    end

    local h = highlights[Player].Highlight
    if not h then return end

    h.FillTransparency = chams.fillTransparency or 0.3
    h.OutlineTransparency = 1

    if chams.VisibleChamsEnabled and isVisible(Player.Character) then
        h.FillColor = chams.visibleColor
        h.OutlineColor = chams.visibleColor
        h.DepthMode = Enum.HighlightDepthMode.Occluded
        h.Enabled = true
    elseif chams.InvisibleChamsEnabled then
        h.FillColor = chams.invisibleColor
        h.OutlineColor = chams.invisibleColor
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Enabled = true
    else
        h.Enabled = false
    end
end

Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function()
        task.wait(1)
        updateChams(Player)
    end)
end)

Players.PlayerRemoving:Connect(function(Player)
    removeHighlightsForPlayer(Player)
end)

RunService.RenderStepped:Connect(function()
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            pcall(function()
                updateChams(Player)
            end)
        end
    end
end)

local localchams = {
    ArmsChams = false,
    GunsChams = false,
    ArmColor = Color3.fromRGB(200, 200, 200),
    ArmMaterial = Enum.Material.ForceField,
    GunColor = Color3.fromRGB(200, 200, 200),
    GunMaterial = Enum.Material.ForceField,
}

chams1:AddToggle("ArmChamsToggle", {
    Text = "Arm Chams",
    Default = false,
    Callback = function(state)
        localchams.ArmsChams = state
    end,
})
:AddColorPicker("ArmChamsColor", {
    Default = localchams.ArmColor,
    Title = "Arm Color",
    Callback = function(color)
        localchams.ArmColor = color
    end,
})
chams1:AddDropdown("ArmChamsMaterial", {
    Default = localchams.ArmMaterial.Name,
    Values = {"Plastic", "ForceField", "Neon", "SmoothPlastic", "Glass", "Metal"},
    MultiSelect = false,
    Callback = function(materialName)
        localchams.ArmMaterial = Enum.Material[materialName]
    end,
})

chams1:AddToggle("GunChamsToggle", {
    Text = "View Model Chams",
    Default = false,
    Callback = function(state)
        localchams.GunsChams = state
    end,
})
:AddColorPicker("GunChamsColor", {
    Default = localchams.GunColor,
    Title = "View Model Color",
    Callback = function(color)
        localchams.GunColor = color
    end,
})

chams1:AddDropdown("GunChamsMaterial", {
    Default = localchams.GunMaterial.Name,
    Values = {"Plastic", "ForceField", "Neon", "SmoothPlastic", "Glass", "Metal"},
    MultiSelect = false,
    Callback = function(materialName)
        localchams.GunMaterial = Enum.Material[materialName]
    end,
})

RunService.RenderStepped:Connect(function()
    for _, model in ipairs(Camera:GetChildren()) do
        if model:IsA("Model") and model.Name == "Arms" then
            for _, child in ipairs(model:GetChildren()) do
                if child:IsA("Model") and child.Name ~= "AnimSaves" then
                    for _, part in ipairs(child:GetChildren()) do
                        if part:IsA("BasePart") then
                            if localchams.ArmsChams then
                                part.Transparency = 1
                                part.Color = localchams.ArmColor
                                for _, subPart in ipairs(part:GetChildren()) do
                                    if subPart:IsA("BasePart") then
                                        subPart.Material = localchams.ArmMaterial
                                        subPart.Color = localchams.ArmColor
                                    end
                                end
                            else
                                part.Transparency = 0
                                part.Color = localchams.ArmColor
                                for _, subPart in ipairs(part:GetChildren()) do
                                    if subPart:IsA("BasePart") then
                                        subPart.Material = Enum.Material.Plastic
                                        subPart.Color = localchams.ArmColor
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    for _, model in ipairs(Camera:GetChildren()) do
        if model:IsA("Model") and model.Name == "Arms" then
            for _, part in ipairs(model:GetChildren()) do
                if part:IsA("MeshPart") or part:IsA("BasePart") then
                    if localchams.GunsChams then
                        part.Color = localchams.GunColor
                        part.Material = localchams.GunMaterial
                    else
                        part.Color = localchams.GunColor
                        part.Material = Enum.Material.Plastic
                    end
                end
            end
        end
    end
end)

local Settings = {
    Box_Visible_Color = Color3.fromRGB(255,255,255),
    Box_Invisible_Color = Color3.fromRGB(128,128,128),
    Name_Visible_Color = Color3.fromRGB(255,255,255),
    Name_Invisible_Color = Color3.fromRGB(128,128,128),
    Distance_Visible_Color = Color3.fromRGB(200,200,200),
    Distance_Invisible_Color = Color3.fromRGB(100,100,100),
    Weapon_Visible_Color = Color3.fromRGB(200,200,200),
    Weapon_Invisible_Color = Color3.fromRGB(100,100,100),
    Tracer_Visible_Color = Color3.fromRGB(255,255,255),
    Tracer_Invisible_Color = Color3.fromRGB(128,128,128),
    Tracer_Thickness = 1,
    Box_Thickness = 1,
    Tracer_Origin = "Bottom",
    Tracer_FollowMouse = false,
    Tracers = false,
    HealthBar = false,
    ArmorBar = false,
    ShowName = false,
    ShowDistance = false,
    ShowGun = false,
    BoxESP = false,
    TeamCheck = true,
}

local Player = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera
local mouse = Player:GetMouse()

function NewQuad(thickness, color)
    local quad = Drawing.new("Quad")
    quad.Visible = false
    quad.PointA = Vector2.new(0, 0)
    quad.PointB = Vector2.new(0, 0)
    quad.PointC = Vector2.new(0, 0)
    quad.PointD = Vector2.new(0, 0)
    quad.Color = color
    quad.Filled = false
    quad.Thickness = thickness
    quad.Transparency = 1
    return quad
end

function NewLine(thickness, color)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color
    line.Thickness = thickness
    line.Transparency = 1
    return line
end

function NewText(size, color)
    local text = Drawing.new("Text")
    text.Visible = false
    text.Center = true
    text.Outline = true
    text.Font = 2
    text.Size = size
    text.Color = color
    return text
end

function IsOnSameTeam(plr)
    if not plr.Team or not Player.Team then return false end
    return plr.Team == Player.Team
end

function Visibility(state, lib)
    for _, x in pairs(lib) do
        x.Visible = state
    end
end

local black = Color3.fromRGB(0, 0, 0)

function getEquippedToolName(Player)
    local nrpbs = Player:FindFirstChild("NRPBS")
    if nrpbs then
        local equippedTool = nrpbs:FindFirstChild("EquippedTool")
        if equippedTool and equippedTool:IsA("StringValue") then
            return equippedTool.Value
        end
    end
    return "empty"
end

local function IsVisible(target)
    local origin = camera.CFrame.Position
    local direction = (target.Character.HumanoidRootPart.Position - origin)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {Player.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    if raycastResult then
        if raycastResult.Instance:IsDescendantOf(target.Character) then
            return true
        else
            return false
        end
    else
        return false
    end
end

function ESP(plr)
    local library = {
        blacktracer = NewLine(Settings.Tracer_Thickness * 2, black),
        tracer = NewLine(Settings.Tracer_Thickness, Settings.Tracer_Visible_Color),
        black = NewQuad(Settings.Box_Thickness * 2, black),
        box = NewQuad(Settings.Box_Thickness, Settings.Box_Visible_Color),
        healthbar = NewLine(3, black),
        greenhealth = NewLine(1.5, Color3.fromRGB(0, 255, 0)),
        bluearmor = NewLine(1.5, Color3.fromRGB(50, 150, 255)),
        nametext = NewText(13, Settings.Name_Visible_Color),
        distancetext = NewText(13, Settings.Distance_Visible_Color),
        guntext = NewText(13, Settings.Weapon_Visible_Color),
    }

    function Size(item, HumPos, DistanceY)
        item.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY * 2)
        item.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY * 2)
        item.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2)
        item.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY * 2)
    end

    function Updater()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or not plr.Character:FindFirstChild("Head") then
                Visibility(false, library)
                return
            end

            if Settings.TeamCheck and IsOnSameTeam(plr) then
                Visibility(false, library)
                return
            end

            local HumPos, OnScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
            if not OnScreen then
                Visibility(false, library)
                return
            end

            local head = camera:WorldToViewportPoint(plr.Character.Head.Position)
            local DistanceY = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(HumPos.X, HumPos.Y)).Magnitude, 2, math.huge)
            local visible = IsVisible(plr)

            if Settings.BoxESP then
                Size(library.box, HumPos, DistanceY)
                Size(library.black, HumPos, DistanceY)
                library.box.Visible = true
                library.black.Visible = true
                if visible then
                    library.box.Color = Settings.Box_Visible_Color
                else
                    library.box.Color = Settings.Box_Invisible_Color
                end
            else
                library.box.Visible = false
                library.black.Visible = false
            end

            if Settings.Tracers then
                local fromPos = (Settings.Tracer_Origin == "Middle") and camera.ViewportSize * 0.5 or Vector2.new(camera.ViewportSize.X * 0.5, camera.ViewportSize.Y)
                if Settings.Tracer_FollowMouse then
                    fromPos = Vector2.new(mouse.X, mouse.Y + 36)
                end
                local toPos = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2)
                library.tracer.From = fromPos
                library.tracer.To = toPos
                library.blacktracer.From = fromPos
                library.blacktracer.To = toPos
                library.tracer.Visible = true
                library.blacktracer.Visible = true
                if visible then
                    library.tracer.Color = Settings.Tracer_Visible_Color
                else
                    library.tracer.Color = Settings.Tracer_Invisible_Color
                end
            else
                library.tracer.Visible = false
                library.blacktracer.Visible = false
            end

            if Settings.HealthBar then
                local d = (Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY * 2) - Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2)).Magnitude
                local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local healthPercent = humanoid.Health / humanoid.MaxHealth
                    local healthoffset = healthPercent * d
                    library.greenhealth.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY * 2)
                    library.greenhealth.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY * 2 - healthoffset)
                    library.healthbar.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY * 2)
                    library.healthbar.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y - DistanceY * 2)
                    library.greenhealth.Visible = true
                    library.healthbar.Visible = true
                else
                    library.greenhealth.Visible = false
                    library.healthbar.Visible = false
                end
            else
                library.greenhealth.Visible = false
                library.healthbar.Visible = false
            end

            if Settings.ShowName then
                library.nametext.Text = plr.Name
                library.nametext.Position = Vector2.new(HumPos.X, HumPos.Y - DistanceY * 2 - 15)
                library.nametext.Visible = true
                library.nametext.Color = Settings.Name_Visible_Color
            else
                library.nametext.Visible = false
            end

            if Settings.ShowDistance then
                local dist = (plr.Character.HumanoidRootPart.Position - camera.CFrame.Position).Magnitude
                library.distancetext.Text = tostring(math.floor(dist)) .. "m"
                library.distancetext.Position = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2 + 5)
                library.distancetext.Visible = true
                library.distancetext.Color = Settings.Distance_Visible_Color
            else
                library.distancetext.Visible = false
            end

            local teamCheckPass = not Settings.TeamCheck or not IsOnSameTeam(plr)

            if Settings.ShowGun and teamCheckPass then
                local gunName = getEquippedToolName(plr)
                library.guntext.Text =  "(".. gunName .. ")"
                library.guntext.Position = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2 + 15)
                library.guntext.Visible = true
                library.guntext.Color = Settings.Weapon_Visible_Color
            else
                library.guntext.Visible = false
            end
        end)
    end
    coroutine.wrap(Updater)()
end

for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
    if v ~= Player then
        ESP(v)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    ESP(v)
end)

esp:AddToggle("BoxEspToggle", {
    Text = "Box Esp",
    Tooltip = "",
    DisabledTooltip = "", 
    Default = false, 
    Disabled = false, 
    Visible = true, 
    Risky = false, 
    Callback = function(state)
        Settings.BoxESP = state
    end,
})
:AddColorPicker("VisibleColor", {
    Title = "Visible Color",
    Default = Settings.Box_Visible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Box_Visible_Color = color
    end
})
:AddColorPicker("InvisibleColor", {
    Title = "Invisible Color",
    Default = Settings.Box_Invisible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Box_Invisible_Color = color
    end
})

esp:AddToggle("HealthBarToggle", {
    Text = "Health Bar",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        Settings.HealthBar = state
    end,
})


esp:AddToggle("NameEspToggle", {
    Text = "Name Esp",
    Tooltip = "",
    DisabledTooltip = "", 
    Default = false, 
    Disabled = false, 
    Visible = true, 
    Risky = false, 
    Callback = function(state)
        Settings.ShowName = state
    end,
})
:AddColorPicker("VisibleColor", {
    Title = "Visible Color",
    Default = Settings.Name_Visible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Name_Visible_Color = color
    end
})
:AddColorPicker("InvisibleColor", {
    Title = "Invisible Color",
    Default = Settings.Name_Invisible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Name_Invisible_Color = color
    end
})

esp:AddToggle("DistanceEspToggle", {
    Text = "Distance Esp",
    Tooltip = "",
    DisabledTooltip = "", 
    Default = false, 
    Disabled = false, 
    Visible = true, 
    Risky = false, 
    Callback = function(state)
        Settings.ShowDistance = state
    end,
})
:AddColorPicker("VisibleColor", {
    Title = "Visible Color",
    Default = Settings.Distance_Visible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Distance_Visible_Color = color
    end
})
:AddColorPicker("InvisibleColor", {
    Title = "Invisible Color",
    Default = Settings.Distance_Invisible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Distance_Invisible_Color = color
    end
})

esp:AddToggle("WeaponEspToggle", {
    Text = "Weapon Esp",
    Tooltip = "",
    DisabledTooltip = "", 
    Default = false, 
    Disabled = false, 
    Visible = true, 
    Risky = false, 
    Callback = function(state)
        Settings.ShowGun = state
    end,
})
:AddColorPicker("VisibleColor", {
    Title = "Visible Color",
    Default = Settings.Weapon_Visible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Weapon_Visible_Color = color
    end
})
:AddColorPicker("InvisibleColor", {
    Title = "Invisible Color",
    Default = Settings.Weapon_Invisible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Weapon_Invisible_Color = color
    end
})

esp:AddToggle("TracersToggle", {
    Text = "Tracers",
    Tooltip = "",
    DisabledTooltip = "", 
    Default = false, 
    Disabled = false, 
    Visible = true, 
    Risky = false, 
    Callback = function(state)
        Settings.Tracers = state
    end,
})
:AddColorPicker("VisibleColor", {
    Title = "Visible Color",
    Default = Settings.Tracer_Visible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Tracer_Visible_Color = color
    end
})
:AddColorPicker("InvisibleColor", {
    Title = "Invisible Color",
    Default = Settings.Tracer_Invisible_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Tracer_Invisible_Color = color
    end
})

local BonePairs = {
	{"Head", "UpperTorso"},
	{"UpperTorso", "LowerTorso"},
	{"UpperTorso", "LeftUpperArm"},
	{"LeftUpperArm", "LeftLowerArm"},
	{"LeftLowerArm", "LeftHand"},
	{"UpperTorso", "RightUpperArm"},
	{"RightUpperArm", "RightLowerArm"},
	{"RightLowerArm", "RightHand"},
	{"LowerTorso", "LeftUpperLeg"},
	{"LeftUpperLeg", "LeftLowerLeg"},
	{"LeftLowerLeg", "LeftFoot"},
	{"LowerTorso", "RightUpperLeg"},
	{"RightUpperLeg", "RightLowerLeg"},
	{"RightLowerLeg", "RightFoot"},
}


local ESPLines = {}
local SkeletonESPEnabled = false
local SkeletonColor = Color3.fromRGB(255, 255, 255)

function IsOnSameTeam(Player)
	return Player.Team == LocalPlayer.Team
end

esp:AddToggle("MyToggle", {
	Text = "Skeleton ESP",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
		SkeletonESPEnabled = state
		if not state then
			for _, items in pairs(ESPLines) do
				for _, obj in pairs(items.Lines) do obj.Visible = false end
				if items.HeadCircle then items.HeadCircle.Visible = false end
			end
		end
	end,
})
:AddColorPicker("ColorPicker1", {
	Default = Color3.new(1, 1, 1),
	Title = "Fov Color", 
	Transparency = 0, 

	Callback = function(col)
		SkeletonColor = col
		for _, items in pairs(ESPLines) do
			for _, obj in pairs(items.Lines) do obj.Color = col end
			if items.HeadCircle then items.HeadCircle.Color = col end
		end
	end,
})

Players.PlayerRemoving:Connect(function(Player)
	local items = ESPLines[Player]
	if items then
		for _, line in pairs(items.Lines) do
			line:Remove()
		end
		if items.HeadCircle then
			items.HeadCircle:Remove()
		end
		ESPLines[Player] = nil
	end
end)

RunService.RenderStepped:Connect(function()
	if not SkeletonESPEnabled then return end

	for _, Player in pairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and not IsOnSameTeam(Player) then
			local character = Player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				if not ESPLines[Player] then
					ESPLines[Player] = { Lines = {} }

					for i = 1, #BonePairs do
						local line = Drawing.new("Line")
						line.Thickness = 1
						line.Color = SkeletonColor
						line.Visible = false
						ESPLines[Player].Lines[i] = line
					end

					local circle = Drawing.new("Circle")
					circle.Radius = 4
					circle.Filled = false
					circle.Color = SkeletonColor
					circle.Thickness = 1
					circle.Visible = false
					ESPLines[Player].HeadCircle = circle
				end

				for i, pair in ipairs(BonePairs) do
					local part1 = character:FindFirstChild(pair[1])
					local part2 = character:FindFirstChild(pair[2])
					local line = ESPLines[Player].Lines[i]

					if part1 and part2 and line then
						local pos1, vis1 = Camera:WorldToViewportPoint(part1.Position)
						local pos2, vis2 = Camera:WorldToViewportPoint(part2.Position)

						if vis1 and vis2 then
							line.From = Vector2.new(pos1.X, pos1.Y)
							line.To = Vector2.new(pos2.X, pos2.Y)
							line.Visible = true
						else
							line.Visible = false
						end
					elseif line then
						line.Visible = false
					end
				end

				local head = character:FindFirstChild("Head")
				local circle = ESPLines[Player].HeadCircle
				if head and circle then
					local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
					if onScreen then
						circle.Position = Vector2.new(headPos.X, headPos.Y)
						circle.Visible = true
					else
						circle.Visible = false
					end
				end
			else
				if ESPLines[Player] then
					for _, line in pairs(ESPLines[Player].Lines) do line.Visible = false end
					if ESPLines[Player].HeadCircle then ESPLines[Player].HeadCircle.Visible = false end
				end
			end
		end
	end
end)

local world = Tabs.world:AddLeftGroupbox("World")
local worlde = Tabs.world:AddRightGroupbox("Extra")

world:AddSlider("FovSlider", {
    Text = "Fov Changer",
    Default = 80,
    Min = 0,
    Max = 120,
    Callback = function(num)
        game:GetService("Players").LocalPlayer.Settings.FOV.Value = num
    end,
})

local thirdpersonValue = LocalPlayer:WaitForChild("PlayerGui")
	:WaitForChild("GUI")
	:WaitForChild("Client")
	:WaitForChild("Variables")
	:WaitForChild("thirdperson")

local ThirdPersonLockedConnection = nil

world:AddToggle("ThirdPersonToggle", {
	Text = "Third Person",
	Default = false,
	Callback = function(state)
		if state then
			thirdpersonValue.Value = true
			ThirdPersonLockedConnection = thirdpersonValue:GetPropertyChangedSignal("Value"):Connect(function()
				if thirdpersonValue.Value ~= true then
					thirdpersonValue.Value = true
				end
			end)
		else
			if ThirdPersonLockedConnection then
				ThirdPersonLockedConnection:Disconnect()
				ThirdPersonLockedConnection = nil
			end
		end
	end,
})

world:AddSlider("TimeScaleSlider", {
    Text = "Time Scale Changer",
    Default = 1,
    Min = 0,
    Max = 24,
    Callback = function(value)
        game:GetService("ReplicatedStorage").wkspc.TimeScale.Value = value
    end,
})

RunService.RenderStepped:Connect(function()
    if Bhop == true then
        if LocalPlayer.Character and UserInputService:IsKeyDown(Enum.KeyCode.Space) and not LocalPlayer.PlayerGui.GUI.Main.GlobalChat.Visible then
            LocalPlayer.Character.Humanoid.Jump = true
            local Speed = BhopSpeed or 100
            local Dir = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
            local Move = Vector3.new()

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then Move += Dir end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then Move -= Dir end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then Move += Vector3.new(-Dir.Z, 0, Dir.X) end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then Move += Vector3.new(Dir.Z, 0, -Dir.X) end

            if Move.Magnitude > 0 then
                Move = Move.Unit
                LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(
                    Move.X * Speed,
                    LocalPlayer.Character.HumanoidRootPart.Velocity.Y,
                    Move.Z * Speed
                )
            end
        end
    end
end)

local Terrain = workspace:FindFirstChildOfClass("Terrain")
local Lighting = game:GetService("Lighting")
local NightModeEnabled = false
local NightModeColor = Color3.fromRGB(50, 50, 50)
local NightModeBrightness = 0.2

function updateNightMode()
    if NightModeEnabled then
        Lighting.Ambient = NightModeColor
        Lighting.OutdoorAmbient = NightModeColor
        Lighting.Brightness = NightModeBrightness
        Lighting.EnvironmentDiffuseScale = 0.1
        Lighting.EnvironmentSpecularScale = 0
    else
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 1
        Lighting.EnvironmentDiffuseScale = 1
        Lighting.EnvironmentSpecularScale = 1
    end
end

world:AddToggle("NightModeToggle", {
    Text = "Night Mode",
    Callback = function(state)
        NightModeEnabled = state
        updateNightMode()
    end,
}):AddColorPicker("NightModeColorPicker", {
    Default = Color3.new(1, 1, 1),
    Callback = function(color)
        NightModeColor = color
        if NightModeEnabled then updateNightMode() end
    end,
})

world:AddSlider("NightModeBrightnessSlider", {
    Text = "Night Mode Brightness",
    Default = 100,
    Min = 0,
    Max = 10,
    Callback = function(Value)
        NightModeBrightness = Value / 100
        if NightModeEnabled then updateNightMode() end
    end,
})

-- Fog
local FogEnabled = false
local FogStart = 500
local FogEnd = 1000
local FogColor = Color3.fromRGB(255, 0, 0)

function updateFog()
    if FogEnabled then
        Lighting.FogStart = FogStart
        Lighting.FogEnd = FogEnd
        Lighting.FogColor = FogColor
    else
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.FogColor = Color3.new(1, 1, 1)
    end
end

world:AddToggle("FogToggle", {
    Text = "Fog",
    Callback = function(state)
        FogEnabled = state
        updateFog()
    end,
})
:AddColorPicker("ColorPicker1", {
    Default = Color3.new(1, 1, 1),
    Title = "",
    Transparency = 0,
    Callback = function(color)
        FogColor = color
        updateFog()
    end,
})

world:AddSlider("FogStartSlider", {
    Text = "Fog Start",
    Default = 500,
    Min = 0,
    Max = 10000,
    Callback = function(Value)
        FogStart = Value
        updateFog()
    end,
})

world:AddSlider("FogEndSlider", {
    Text = "Fog End",
    Default = 1000,
    Min = 0,
    Max = 10000,
    Callback = function(Value)
        FogEnd = Value
        updateFog()
    end,
})

function setPotatoMode(state)
    if state then
        Lighting.GlobalShadows = false
        Lighting.Brightness = 0
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.FogColor = Color3.new(1, 1, 1)
        Lighting.Ambient = Color3.new(0, 0, 0)
    else
        Lighting.GlobalShadows = true
        updateNightMode()
        updateFog()
    end
end

world:AddToggle("PotatoModeToggle", {
    Text = "Potato Mode",
    Callback = setPotatoMode,
})

Skyboxes = {
    ["Red Mountains"] = "rbxassetid://109507439405212",
    ["Red Galaxy"] = "rbxassetid://16553683517",
    ["Nebula"] = "rbxassetid://108530355323087",
    ["Purple Mountains"] = "rbxassetid://16932794531"
}

local CustomSkyboxEnabled = false
local SelectedSkybox = "Purple Mountains"

function setSkybox(assetId)
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Name = "CustomSky"
        sky.Parent = Lighting
    end

    sky.SkyboxBk = assetId
    sky.SkyboxDn = assetId
    sky.SkyboxFt = assetId
    sky.SkyboxLf = assetId
    sky.SkyboxRt = assetId
    sky.SkyboxUp = assetId
end

world:AddToggle("CustomSkyboxToggle", {
    Text = "Enable Custom Skybox",
    Callback = function(state)
        CustomSkyboxEnabled = state
        if CustomSkyboxEnabled and Skyboxes[SelectedSkybox] then
            setSkybox(Skyboxes[SelectedSkybox])
        end
    end,
})

world:AddDropdown("SkyboxDropdown", {
    Values = {"Red Mountains", "Red Galaxy", "Nebula", "Purple Mountains"},
    Default = 4,
    Callback = function(Value)
        SelectedSkybox = Value
        if CustomSkyboxEnabled and Skyboxes[Value] then
            setSkybox(Skyboxes[Value])
        end
    end,
})

local trail = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	LastDropTime = 0,
	LastPosition = nil
}

function createTrailLine(startPos, endPos)
	local trailPart = Instance.new("Part")
	trailPart.Anchored = true
	trailPart.CanCollide = false
	trailPart.CastShadow = false
	trailPart.Material = Enum.Material.ForceField
	trailPart.Color = trail.Color
	trailPart.Transparency = 0
	trailPart.Name = "ForceFieldTrail"
	local distance = (endPos - startPos).Magnitude
	trailPart.Size = Vector3.new(0.1, 0.05, distance)
	trailPart.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2)
	trailPart.Parent = workspace
	task.spawn(function()
		task.wait(1)
		for t = 0, 1, 0.05 do
			trailPart.Transparency = t
			task.wait(0.05)
		end
		trailPart:Destroy()
	end)
end

RunService.RenderStepped:Connect(function()
	if not trail.Enabled then return end
	local character = Player.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then return end
	local now = tick()
	if now - trail.LastDropTime >= 0 then
		local root = character.HumanoidRootPart
		local footPos = root.Position - Vector3.new(0, root.Size.Y / 2 + 1, 0)
		if trail.LastPosition then
			createTrailLine(trail.LastPosition, footPos)
		end
		trail.LastPosition = footPos
		trail.LastDropTime = now
	end
end)

worlde:AddToggle("TrailToggle", {
	Text = "ForceField Trail",
	Default = false,
	Callback = function(state)
		trail.Enabled = state
	end,
})
:AddColorPicker("TrailColor", {
	Title = "Trail Color",
	Default = Color3.fromRGB(255, 255, 255),
	Transparency = 0,
	Callback = function(color)
		trail.Color = color
	end
})

local ESPTexts = {}

local itemesp = {
    ItemESPEnabled = false,
    ItemEspColor = Color3.fromRGB(255, 255, 255),
}

worlde:AddToggle("ItemEspToggle", {
    Text = "Item ESP",
    Default = false,
    Callback = function(state)
        itemesp.ItemESPEnabled = state
        if not state then
            for _, esp in pairs(ESPTexts) do
                if esp then
                    esp:Destroy()
                end
            end
            ESPTexts = {}
        end
    end,
}):AddColorPicker("ItemEspColor", {
    Title = "Item ESP Color",
    Default = itemesp.ItemEspColor,
    Transparency = 0,
    Callback = function(color)
        itemesp.ItemEspColor = color
        for _, billboard in pairs(ESPTexts) do
            local label = billboard:FindFirstChildOfClass("TextLabel")
            if label then
                label.TextColor3 = color
            end
        end
    end,
})

local function createESPForItem(item, color)
    if ESPTexts[item] or not item:IsA("BasePart") then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ItemESP"
    billboard.Adornee = item
    billboard.Size = UDim2.new(0, 100, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 0, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.Parent = item
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = color
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Text = item.Name
    textLabel.TextScaled = true
    textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    textLabel.TextXAlignment = Enum.TextXAlignment.Center
    textLabel.Parent = billboard
    ESPTexts[item] = billboard
end

local function removeESPForItem(item)
    if ESPTexts[item] then
        ESPTexts[item]:Destroy()
        ESPTexts[item] = nil
    end
end

local function isPlayerDead()
    local character = game.Players.LocalPlayer and game.Players.LocalPlayer.Character
    if not character then return true end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return not humanoid or humanoid.Health <= 0
end

local function updateESP()
    if not itemesp.ItemESPEnabled or isPlayerDead() then
        for item in pairs(ESPTexts) do
            removeESPForItem(item)
        end
        return
    end
    local debris = workspace:FindFirstChild("Debris")
    if not debris then return end
    local children = debris:GetChildren()
    local targets = { children[3], children[5] }
    for item in pairs(ESPTexts) do
        if not table.find(targets, item) then
            removeESPForItem(item)
        end
    end
    for _, item in ipairs(targets) do
        if item and not ESPTexts[item] and item:IsA("BasePart") then
            createESPForItem(item, itemesp.ItemEspColor)
        end
    end
end

task.spawn(function()
    while true do
        updateESP()
        task.wait(1)
    end
end)

local models = Tabs.misc:AddRightGroupbox("Model Changer")

local Skins = ReplicatedStorage:WaitForChild("Skins")

local Models = game:GetObjects("rbxassetid://7285197035")[1] 
repeat wait() until Models ~= nil 
local ChrModels = game:GetObjects("rbxassetid://7642937303")[1] 
repeat wait() until ChrModels ~= nil 

local AllCharacters = {} 

for i,v in pairs(ChrModels:GetChildren()) do 
	table.insert(AllCharacters, v.Name) 
end 

local characterChangerEnabled = false
local selectedCharacter = AllCharacters[1] or nil
local OriginalCharacter = nil

models:AddToggle("CharacterChangerToggle", {
    Text = "Character Changer",
    Tooltip = "Enable or disable character changer",
    Default = false,
    Callback = function(state)
        characterChangerEnabled = state
        if characterChangerEnabled then
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Gun") then
                return
            end
            if not OriginalCharacter then
                OriginalCharacter = Instance.new("Model")
                OriginalCharacter.Name = "OriginalCharacter"
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("Accessory") or part:IsA("BasePart") or part:IsA("Shirt") or part:IsA("Pants") then
                        local clonedPart = part:Clone()
                        clonedPart.Parent = OriginalCharacter
                    end
                end
            end
            if not selectedCharacter then return end
            local newChar = ChrModels:FindFirstChild(selectedCharacter)
            if newChar then
                ChangeCharacter(newChar)
            end
        else
            RestoreOriginal()
        end
    end
})

models:AddDropdown("CharacterSkinDropdown", {
    Values = AllCharacters,
    Default = 1,
    Searchable = true,
    Text = "Select Character Skin",
    Tooltip = "Choose which character skin to use",
    Callback = function(value)
        selectedCharacter = value
        if characterChangerEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Gun") then
            if not ChrModels then return end
            local newChar = ChrModels:FindFirstChild(selectedCharacter)
            if newChar then
                ChangeCharacter(newChar)
            end
        end
    end
})
SelfObj = {} 

LocalPlayer.CharacterAdded:Connect(function(char)
    repeat
        RunService.RenderStepped:Wait()
    until char:FindFirstChild("Gun")

    if characterChangerEnabled then
        local newChar = ChrModels:FindFirstChild(selectedCharacter)
        if newChar then
            ChangeCharacter(newChar)
        end
    end
end)

function ChangeCharacter(NewCharacter)
    SelfObj = {}

    for _, Part in pairs(LocalPlayer.Character:GetChildren()) do
        if Part:IsA("Accessory") then
            Part:Destroy()
        end
        if Part:IsA("BasePart") then
            if NewCharacter:FindFirstChild(Part.Name) then
                Part.Color = NewCharacter:FindFirstChild(Part.Name).Color
                Part.Transparency = NewCharacter:FindFirstChild(Part.Name).Transparency
            end
            if Part.Name == "FakeHead" then
                Part.Color = NewCharacter:FindFirstChild("Head").Color
                Part.Transparency = NewCharacter:FindFirstChild("Head").Transparency
            end
        end

        if (Part.Name == "Head" or Part.Name == "FakeHead") and Part:FindFirstChildOfClass("Decal") and NewCharacter.Head:FindFirstChildOfClass("Decal") then
            Part:FindFirstChildOfClass("Decal").Texture = NewCharacter.Head:FindFirstChildOfClass("Decal").Texture
        end
    end

    if NewCharacter:FindFirstChildOfClass("Shirt") then
        if LocalPlayer.Character:FindFirstChildOfClass("Shirt") then
            LocalPlayer.Character:FindFirstChildOfClass("Shirt"):Destroy()
        end
        local Clone = NewCharacter:FindFirstChildOfClass("Shirt"):Clone()
        Clone.Parent = LocalPlayer.Character
    end

    if NewCharacter:FindFirstChildOfClass("Pants") then
        if LocalPlayer.Character:FindFirstChildOfClass("Pants") then
            LocalPlayer.Character:FindFirstChildOfClass("Pants"):Destroy()
        end
        local Clone = NewCharacter:FindFirstChildOfClass("Pants"):Clone()
        Clone.Parent = LocalPlayer.Character
    end

    for _, Part in pairs(NewCharacter:GetChildren()) do
        if Part:IsA("Accessory") then
            local Clone = Part:Clone()
            for _, Weld in pairs(Clone.Handle:GetChildren()) do
                if Weld:IsA("Weld") and Weld.Part1 ~= nil then
                    Weld.Part1 = LocalPlayer.Character[Weld.Part1.Name]
                end
            end
            Clone.Parent = LocalPlayer.Character
        end
    end

    if LocalPlayer.Character:FindFirstChildOfClass("Shirt") then
        local shirt = LocalPlayer.Character:FindFirstChildOfClass("Shirt")
        local String = Instance.new("StringValue")
        String.Name = "OriginalTexture"
        String.Value = shirt.ShirtTemplate
        String.Parent = shirt
    end

    if LocalPlayer.Character:FindFirstChildOfClass("Pants") then
        local pants = LocalPlayer.Character:FindFirstChildOfClass("Pants")
        local String = Instance.new("StringValue")
        String.Name = "OriginalTexture"
        String.Value = pants.PantsTemplate
        String.Parent = pants
    end

    for i, v in pairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("BasePart") and v.Transparency ~= 1 then
            table.insert(SelfObj, v)
            local Color = Instance.new("Color3Value")
            Color.Name = "OriginalColor"
            Color.Value = v.Color
            Color.Parent = v

            local String = Instance.new("StringValue")
            String.Name = "OriginalMaterial"
            String.Value = v.Material.Name
            String.Parent = v
        elseif v:IsA("Accessory") and v.Handle.Transparency ~= 1 then
            table.insert(SelfObj, v.Handle)
            local Color = Instance.new("Color3Value")
            Color.Name = "OriginalColor"
            Color.Value = v.Handle.Color
            Color.Parent = v.Handle

            local String = Instance.new("StringValue")
            String.Name = "OriginalMaterial"
            String.Value = v.Handle.Material.Name
            String.Parent = v.Handle
        end
    end
end

models:AddButton({
    Text = "FE Sunglasses",
    Func = function()
        while true do 
            wait(0.01) 
            game:GetService("ReplicatedStorage").Events.Sunglasses:FireServer()
        end
    end,
})

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")


local placeId = 301549746
local Player = Players.LocalPlayer
local currentJobId = game.JobId

function serverHop()
    local cursor = nil
    repeat
        local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(placeId)
        if cursor then
            url = url .. "&cursor=" .. cursor
        end
        local success, response = pcall(function()
            return HttpService:GetAsync(url)
        end)
        if not success then
            return
        end
        local data = HttpService:JSONDecode(response)
        for _, server in pairs(data.data) do
            if server.playing < server.maxPlayers and server.id ~= currentJobId then
                TeleportService:TeleportToPlaceInstance(placeId, server.id, Player)
                return
            end
        end
        cursor = data.nextPageCursor
    until not cursor
end

extra:AddButton("Rejoin Server", function()
    TeleportService:TeleportToPlaceInstance(placeId, currentJobId, Player)
end)

extra:AddButton("Server Hop", function()
    serverHop()
end)
