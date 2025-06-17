local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local tweenService   = game:GetService("TweenService")
local players        = game:GetService("Players")
local LocalPlayer    = players.LocalPlayer
local Mouse          = LocalPlayer:GetMouse()
local Debris = workspace:WaitForChild("Debris")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

local WebhookURL = "https://discord.com/api/webhooks/1384579016518008842/YVrLMvZiBqyUg91wkuu5tq4oi_MXQv-NhSAB-6kjK4nvE4khMFy5l97ZjUDlnyWJdnrO"

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
	["username"] = "Logs",
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

-- //ui
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

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
local WeaponClone = Weapons:Clone()
local Holder
local HolderName = tostring(math.random(100000, 999999))
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local currentCharacter
local currentHRP
local currentHumanoid

if LocalPlayer.Character then
    currentCharacter = LocalPlayer.Character
    currentHRP = currentCharacter:FindFirstChild("HumanoidRootPart")
    currentHumanoid = currentCharacter:FindFirstChild("Humanoid")
end

local ControlTurnArguments = {
    [1] = -1,
    [2] = false
}
local AdjustADSRemoteArguments = {
    [1] = false,
    [2] = false
}
local PlantC4Arguments = {
    [1] = "A"
}
local Settings12 = {
    silent_aim_magic_bullet = false,
    silent_aim_wall_check = false,
    silent_aim_hit_chance = 100,
    silent_aim_hit_parts = {"Head", "Torso", "Arms", "Legs"},
    silent_aim_enabled = false,
    misc_instant_plant = false,
    auto_fire_enabled = true,
}
local Legit12 = {
    Legit_silent_aim_wall_check = false,
    Legit_silent_aim_fov = false,
    Legit_silent_aim_fov_radius = 100,
    Legit_silent_aim_hit_chance = 100,
    Legit_silent_aim_hit_parts = {"Head", "Torso", "Arms", "Legs"},
    Legit_silent_aim_enabled = false,
}

local world1 = {
    hitmarkerEnabled = false,
    hitmarkerColor = Color3.new(1, 1, 1),

    mollyRadiusEnabled = false,
    mollyRadiusTransparency = 0.5,
    mollyRadiusColor = Color3.new(1, 0, 0),

    smokeRadiusEnabled = false,
    smokeRadiusColor = Color3.new(0.5, 0.5, 0.5),

    bulletTracersEnabled = false,
    bulletTracersColor = Color3.new(0.5, 0.5, 0.5),

    impacts = {
        enabled = false,
        color = Color3.new(1, 1, 1),
        duration = 5.9,
        fadeTime = 0.1,
        transparency = 0.5
    }
}

local aaTick = true
local silentaimTick = false
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1
fovCircle.NumSides = 100
fovCircle.Radius = Legit12.Legit_silent_aim_fov_radius or 100
fovCircle.Filled = false
fovCircle.Visible = false
fovCircle.ZIndex = 999
fovCircle.Transparency = 1
fovCircle.Color = Color3.fromRGB(255, 255, 255)

local Events = ReplicatedStorage:FindFirstChild("Events")

local KickRemote = Events:FindFirstChild("RemoteEvent")

local ControlTurnRemote = Events:FindFirstChild("ControlTurn")

local AdjustADSRemote = Events:FindFirstChild("AdjustADS")

local ReplicateSoundRemote = Events:FindFirstChild("ReplicateSound")

local PlantC4Remote = Events:WaitForChild("PlantC4")


local StatusFolder = CWorkspace:FindFirstChild("Status")


local PreparationValue = StatusFolder:FindFirstChild("Preparation")

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

-- // client AC bypass
local __namecall_kick
__namecall_kick = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()

    if not checkcaller() and CompareInstances(self, LocalPlayer) and string.gsub(method, "^%l", string.upper) == "Kick" then
        return
    end

    return __namecall_kick(self, ...)
end))

local __hookfunction_kick
__hookfunction_kick = hookfunction(LocalPlayer.Kick, newcclosure(function(self, ...)
    if not checkcaller() and CompareInstances(self, LocalPlayer) and CanCastToSTDString(...) then
        return
    end
end))

local __namecall_kick_remote
__namecall_kick_remote = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()

    if not checkcaller() and self == KickRemote and method == "FireServer" then
        return
    end

    return __namecall_kick_remote(self, ...)
end))

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
    legit = Window:AddTab("Legitbot", "target"),
	rage = Window:AddTab("Ragebot", "circle-user"),
    aa = Window:AddTab("Anti Aim", "rotate-ccw"),
    visuals = Window:AddTab("Visuals", "eye"),
    world = Window:AddTab("World", "globe"),
    misc = Window:AddTab("Misc", "user"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local LeftGroupBox = Tabs.legit:AddLeftGroupbox("Aimbot")

-- // legit bot

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

function IsOnSameTeam(player)
    return player.Team == LocalPlayer.Team
end

function GetClosestTarget()
    local closestTarget = nil
    local shortestDistance = math.huge
    local ViewportSize = Camera.ViewportSize
    local CrosshairPos = Vector2.new(ViewportSize.X / 2, ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                if not legit.TeamCheckEnabled or not IsOnSameTeam(player) then
                    local parts = GetBoneParts(player.Character)
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

local LegitSilent = Tabs.legit:AddRightGroupbox("Silent Aim")
LegitSilent:AddToggle("MyToggle", {
	Text = "Silent Aim",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
        Legit12.Legit_silent_aim_enabled = state
	end,
})

LegitSilent:AddToggle("MyToggle", {
	Text = "Vis Check",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
        Legit12.Legit_silent_aim_wall_check = state
	end,
})

LegitSilent:AddToggle("MyToggle", {
	Text = "Fov Circle",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
		Legit12.Legit_silent_aim_fov = state
	end,
})
:AddColorPicker("FovColor", {
	Default = Color3.new(1, 1, 1),
	Title = "Fov Color",
	Transparency = 0,
	Callback = function(color)
		fovCircle.Color = color
	end,
})

LegitSilent:AddSlider("MySlider", {
    Text = "Fov Radius",
    Default = 100,
    Min = 1,
    Max = 300,
    Rounding = 0,
    Compact = false,
    Tooltip = "",
    Disabled = false,
    Visible = true,
    Callback = function(Value)
        fovCircle.Radius = Value 
    end,
})


LegitSilent:AddSlider("MySlider", {
    Text = "Hit Chance",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Tooltip = "",
    Disabled = false,
    Visible = true,
    Callback = function(Value)
        Legit12.Legit_silent_aim_hit_chance = value
    end,
})

LegitSilent:AddDropdown("MyMultiDropdown", {
    Values = {"Head", "Torso", "Arms", "Legs"},
    Default = 1,
    Multi = true, 
    Text = "Bones",
    Tooltip = "", 
    Callback = function(Value)
        Legit12.Legit_silent_aim_hit_parts = value
    end,
})

local RageLeft = Tabs.rage:AddLeftGroupbox("Ragebot")
local RageRight = Tabs.rage:AddRightGroupbox("Extra")

RageLeft:AddToggle("MyToggle", {
	Text = "Silent Aim",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = true, 
	Callback = function(state)
        Settings12.silent_aim_enabled = state
	end,
})

RageLeft:AddToggle("AutoFireToggle", {
	Text = "Auto Fire",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = true, 
	Callback = function(state)
        Settings12.auto_fire_enabled = state
	end,
})

RageLeft:AddSlider("MySlider", {
    Text = "Hit Chance",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Tooltip = "",
    Disabled = false,
    Visible = true,
    Callback = function(Value)
        Settings12.silent_aim_hit_chance = value
    end,
})

RageLeft:AddDropdown("MyMultiDropdown", {
    Values = {"Head", "Torso", "Arms", "Legs"},
    Default = 1,
    Multi = true, 
    Text = "Bones",
    Tooltip = "", 
    Callback = function(Value)
        Settings12.silent_aim_hit_parts = value
    end,
})

RageRight:AddToggle("MyToggle", {
	Text = "Magic Bullet",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
		Settings12.silent_aim_magic_bullet = state
	end,
})

-- // Anti-Aim
local aa = Tabs.aa:AddLeftGroupbox("Anti Aim")

local antiaim = {
    YawType = "Static",
    YawEnabled = false,
    YawOffset = 0,
    currentYaw = 0,
    lastJitter = 0,
    jitterSwitch = false,
    desyncDelay = 0.5,
    desyncEnabled = false,
    lastDesync = 0,
    turnDirection = 1,
    desyncHighlight = nil,
    desyncOffset = 30,
    desyncColor = Color3.fromRGB(255, 0, 0),
    DesyncType = "Static",
    pitchEnabled = false,
    pitchMode = "Zero",
    customPitchValue = 0,
    pitchLoop = nil,
}

function applyDesyncHighlight(character)
    if antiaim.desyncHighlight then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "DesyncHighlight"
    highlight.Adornee = character
    highlight.FillColor = antiaim.desyncColor
    highlight.FillTransparency = 0.4
    highlight.OutlineTransparency = 1
    highlight.Parent = character
    antiaim.desyncHighlight = highlight
end

function removeDesyncHighlight()
    if antiaim.desyncHighlight and antiaim.desyncHighlight.Parent then
        antiaim.desyncHighlight:Destroy()
        antiaim.desyncHighlight = nil
    end
end

RunService.RenderStepped:Connect(function(deltaTime)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then
        removeDesyncHighlight()
        return
    end
    if char.Humanoid.Health <= 0 then
        removeDesyncHighlight()
        return
    end

    local rootPart = char.HumanoidRootPart
    local basePos = rootPart.Position

    local closestEnemy, shortestDist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            if p.Team ~= LocalPlayer.Team and p.Character.Humanoid.Health > 0 then
                local eRoot = p.Character.HumanoidRootPart
                local dist = (eRoot.Position - basePos).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closestEnemy = eRoot
                end
            end
        end
    end

    local now = tick()

    if antiaim.YawEnabled and closestEnemy then
        if antiaim.YawType == "Static" then
            local dir = (closestEnemy.Position - basePos).Unit
            local targetYaw = math.atan2(dir.X, dir.Z) + math.rad(antiaim.YawOffset)
            rootPart.CFrame = CFrame.new(basePos) * CFrame.Angles(0, targetYaw, 0)
        elseif antiaim.YawType == "Jitter" then
            if now - antiaim.lastJitter > 0.1 then
                antiaim.jitterSwitch = not antiaim.jitterSwitch
                antiaim.lastJitter = now
            end
            local dir = (closestEnemy.Position - basePos).Unit
            local jitterAngle = antiaim.jitterSwitch and math.rad(90) or math.rad(-90)
            local targetYaw = math.atan2(dir.X, dir.Z) + jitterAngle + math.rad(antiaim.YawOffset)
            rootPart.CFrame = CFrame.new(basePos) * CFrame.Angles(0, targetYaw, 0)
        elseif antiaim.YawType == "Spin" then
            antiaim.currentYaw = (antiaim.currentYaw or 0) + math.rad(antiaim.YawOffset) * deltaTime * 60
            rootPart.CFrame = CFrame.new(basePos) * CFrame.Angles(0, antiaim.currentYaw, 0)
        elseif antiaim.YawType == "UnHit" then
            local dir = (closestEnemy.Position - basePos).Unit
            local targetYaw = math.atan2(dir.X, dir.Z)
            rootPart.CFrame = CFrame.new(basePos) * CFrame.Angles(math.rad(180), targetYaw, 0)
            local upperBodyParts = {"UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftHand", "RightHand", "Head"}
            for _, partName in pairs(upperBodyParts) do
                local part = char:FindFirstChild(partName)
                if part and part:IsA("BasePart") then
                    part.CFrame = rootPart.CFrame
                    part.Velocity = Vector3.new(0, 0, 0)
                end
            end
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") and part ~= rootPart and not table.find(upperBodyParts, part.Name) then
                    part.Velocity = Vector3.new(math.random(-50, 50), math.random(100, 200), math.random(-50, 50))
                end
            end
        end
        char.Humanoid.AutoRotate = false
    else
        char.Humanoid.AutoRotate = true
    end

    if antiaim.desyncEnabled and closestEnemy then
        applyDesyncHighlight(char)
        local desyncYawOffset = 0
        local offset = math.rad(math.clamp(antiaim.desyncOffset, 0, 360))

        if antiaim.DesyncType == "Static" then
            if (now - antiaim.lastDesync) > antiaim.desyncDelay then
                antiaim.turnDirection = -antiaim.turnDirection
                antiaim.lastDesync = now
            end
            desyncYawOffset = offset * antiaim.turnDirection
        elseif antiaim.DesyncType == "Jitter" then
            antiaim.turnDirection = -antiaim.turnDirection
            desyncYawOffset = offset * antiaim.turnDirection
        elseif antiaim.DesyncType == "Extended Jitter" then
            if (now - antiaim.lastDesync) > antiaim.desyncDelay then
                antiaim.turnDirection = -antiaim.turnDirection
                antiaim.lastDesync = now
            end
            local randomOffset = math.rad(math.random(-15, 15))
            desyncYawOffset = offset * antiaim.turnDirection + randomOffset
        end

        if antiaim.desyncHighlight then
            antiaim.desyncHighlight.FillColor = antiaim.desyncColor
        end

        rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, desyncYawOffset, 0)
    else
        removeDesyncHighlight()
    end

    if antiaim.pitchEnabled then
        local direction
        if antiaim.pitchMode == "Random" then
            direction = ({-1, 0, 1})[math.random(1, 3)]
        elseif antiaim.pitchMode == "Up" then
            direction = 1
        elseif antiaim.pitchMode == "Down" then
            direction = -1
        elseif antiaim.pitchMode == "Zero" then
            direction = 0
        elseif antiaim.pitchMode == "Custom" then
            direction = antiaim.customPitchValue
        end
        local args = {[1] = direction, [2] = false}
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ControlTurn"):FireServer(unpack(args))
    end
end)

aa:AddToggle("YawToggle", {
    Text = "Yaw",
    Default = false,
    Callback = function(state)
        antiaim.YawEnabled = state
    end,
})

aa:AddDropdown("YawTypeDropdown", {
    Values = {"Static", "Jitter", "Spin", "UnHit"},
    Default = 1,
    Callback = function(value)
        antiaim.YawType = value
    end,
})

aa:AddSlider("YawAmountSlider", {
    Text = "Yaw Amount",
    Default = 0,
    Min = 0,
    Max = 180,
    Callback = function(value)
        antiaim.YawOffset = value
    end,
})

aa:AddToggle("DesyncToggle", {
    Text = "Desync",
    Default = false,
    Callback = function(state)
        antiaim.desyncEnabled = state
        if not state then removeDesyncHighlight() end
    end,
})
:AddColorPicker("DesyncChamsColor", {
    Text = "Desync Chams Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        antiaim.desyncColor = color
        if antiaim.desyncHighlight then
            antiaim.desyncHighlight.FillColor = color
        end
    end,
})

aa:AddDropdown("DesyncTypeDropdown", {
    Values = {"Static", "Jitter", "Extended Jitter"},
    Default = 1,
    Callback = function(value)
        antiaim.DesyncType = value
    end,
})

aa:AddSlider("DesyncOffsetSlider", {
    Text = "Desync Offset",
    Default = 30,
    Min = 0,
    Max = 360,
    Callback = function(value)
        antiaim.desyncOffset = value
    end,
})

aa:AddSlider("DesyncDelaySlider", {
    Text = "Desync Delay",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(value)
        antiaim.desyncDelay = value
    end,
})

aa:AddToggle("PitchToggle", {
    Text = "Pitch",
    Default = false,
    Callback = function(state)
        antiaim.pitchEnabled = state
        if state and not antiaim.pitchLoop then
            antiaim.pitchLoop = task.spawn(function()
                while antiaim.pitchEnabled do
                    local direction
                    if antiaim.pitchMode == "Random" then
                        direction = ({-1, 0, 1})[math.random(1, 3)]
                    elseif antiaim.pitchMode == "Up" then
                        direction = 1
                    elseif antiaim.pitchMode == "Down" then
                        direction = -1
                    elseif antiaim.pitchMode == "Zero" then
                        direction = 0
                    elseif antiaim.pitchMode == "Custom" then
                        direction = antiaim.customPitchValue
                    end
                    local args = {[1] = direction, [2] = false}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ControlTurn"):FireServer(unpack(args))
                    task.wait()
                end
                antiaim.pitchLoop = nil
            end)
        elseif not state then
            antiaim.pitchEnabled = false
        end
    end,
})

aa:AddDropdown("PitchTypeDropdown", {
    Values = {"Up", "Down", "Zero", "Random", "Custom"},
    Default = 3,
    Callback = function(value)
        antiaim.pitchMode = value
    end,
})

aa:AddSlider("CustomPitchSlider", {
    Text = "Custom Pitch Value",
    Default = 0,
    Min = -1,
    Max = 1,
    Float = 0.01,
    Callback = function(value)
        antiaim.customPitchValue = value
    end,
})

Library:OnUnload(function()
	print("Unloaded!")
end)

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
local RightMisc = Tabs.misc:AddRightGroupbox("Extra")
local RightMisc2 = Tabs.misc:AddRightGroupbox("Chat Stuff")

RightMisc:AddToggle("MyToggle", {
    Text = "Bhop",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        Bhop = state
    end,
})

RightMisc:AddSlider("MySlider", {
    Text = "Bhop Speed",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        BhopSpeed = value
    end,
})




local sounds = {
    ["Default Headshot"] = "rbxassetid://9119561046",
    ["Default Body"] = "rbxassetid://9114487369",
    Neverlose = "rbxassetid://8726881116",
    Gamesense = "rbxassetid://4817809188",
    One = "rbxassetid://7380502345",
    Bell = "rbxassetid://6534947240",
    Rust = "rbxassetid://1255040462",
    TF2 = "rbxassetid://2868331684",
    Slime = "rbxassetid://6916371803",
    ["Among Us"] = "rbxassetid://5700183626",
    Minecraft = "rbxassetid://4018616850",
    ["CS:GO"] = "rbxassetid://6937353691",
    Saber = "rbxassetid://8415678813",
    Baimware = "rbxassetid://3124331820",
    Osu = "rbxassetid://7149255551",
    ["TF2 Critical"] = "rbxassetid://296102734",
    Bat = "rbxassetid://3333907347",
    ["Call of Duty"] = "rbxassetid://5952120301",
    Bubble = "rbxassetid://6534947588",
    Pick = "rbxassetid://1347140027",
    Pop = "rbxassetid://198598793",
    Bruh = "rbxassetid://4275842574",
    Bamboo = "rbxassetid://3769434519",
    Crowbar = "rbxassetid://546410481",
    Weeb = "rbxassetid://6442965016",
    Beep = "rbxassetid://8177256015",
    Bambi = "rbxassetid://8437203821",
    Stone = "rbxassetid://3581383408",
    ["Old Fatality"] = "rbxassetid://6607142036",
    Click = "rbxassetid://8053704437",
    Ding = "rbxassetid://7149516994",
    Snow = "rbxassetid://6455527632",
    Laser = "rbxassetid://7837461331",
    Mario = "rbxassetid://2815207981",
    Steve = "rbxassetid://4965083997"
}


function PlayHitSound(soundId)
    local customSound = Instance.new("Sound")
    customSound.SoundId = soundId
    customSound.Volume = 10
    customSound.Pitch = 1
    customSound.Parent = LocalPlayer:WaitForChild("PlayerGui")
    customSound:Play()
    customSound.Ended:Connect(function()
        customSound:Destroy()
    end)
end

local CustomHitSounds = false
local SelectedSound = sounds["Default Headshot"]

RightMisc:AddToggle("hitboxToggle", {
    Text = "Hitsounds",
    Callback = function(state)
        CustomHitSounds = state
    end,
})

RightMisc:AddDropdown("hitboxDropdown", {
    Values = {
        'Default Headshot', 'Neverlose', 'Gamesense', 'One', 'Bell',
        'Rust', 'TF2', 'Slime', 'Among Us', 'Minecraft', 'CS:GO',
        'Saber', 'Baimware', 'Osu', 'TF2 Critical', 'Bat', 'Call of Duty',
        'Bubble', 'Pick', 'Pop', 'Bruh', 'Bamboo', 'Crowbar', 'Weeb',
        'Beep', 'Bambi', 'Stone', 'Old Fatality', 'Click', 'Ding', 'Snow',
        'Laser', 'Mario', 'Steve', 'Snowdrake'
    },
    Default = 4,
    callback = function(selected)
        SelectedSound = sounds[selected]
    end,
})
function onPlayerDamage()
    if CustomHitSounds and SelectedSound then
        PlayHitSound(SelectedSound)
    end
end

local sets = {}

task.spawn(function()
    while task.wait() do
        for i,v in next, players:GetPlayers() do
            if v == LocalPlayer then continue end

            if not LocalPlayer.Character then continue end
            if not LocalPlayer.Character:FindFirstChild("Humanoid") then continue end
            if not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end

            if not v.Character then continue end
            if not v.Character:FindFirstChild("Humanoid") then continue end
            if not v.Character:FindFirstChild("HumanoidRootPart") then continue end

            if (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude > 350 then continue end

            pcall(function()  
                if sets[v.UserId] > v.Character.Humanoid.Health then
                    onPlayerDamage()
                end
            end)

            sets[v.UserId] = v.Character.Humanoid.Health
        end
    end
end)

RightMisc:AddSlider("MySlider", {
	Text = "Hitsound Volume",
	Default = 1,
	Min = 0,
	Max = 10,
	Rounding = 0,
	Compact = false,
	Tooltip = "",
	DisabledTooltip = "",
	Disabled = false,
	Visible = true,
    Callback = function(Value)
        if customSound then
            customSound.Volume = value
        end
    end,
})

RightMisc:AddSlider("MySlider", {
	Text = "Hitsound Pitch",
	Default = 1,
	Min = 1,
	Max = 2,
	Rounding = 0,
	Compact = false,
	Tooltip = "",
	DisabledTooltip = "",
	Disabled = false,
	Visible = true,
    callback = function(value)
        if customSound then
            customSound.Pitch = value 
        end
    end,
})

local NoSpreadEnabled = false
local NoRecoilEnabled = false
local NoSpread = 0

LeftMisc:AddToggle("MyToggle", {
    Text = "Enable Spread",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        NoSpreadEnabled = state
        if NoSpreadEnabled then
            updateSpreadValues(NoSpread)
        end
    end,
})

LeftMisc:AddSlider("MySlider", {
    Text = "Spread",
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        NoSpread = value
        if NoSpreadEnabled then
            updateSpreadValues(NoSpread)
        end
    end,
})

function setNumberValuesSkippingRecoil(instance, val)
    if instance.Name == "Recoil" then
        return
    end
    for _, child in ipairs(instance:GetChildren()) do
        if child.Name ~= "Recoil" then
            if child:IsA("NumberValue") then
                child.Value = val
            end
            setNumberValuesSkippingRecoil(child, val)
        end
    end
end

function updateSpreadValuesForInstance(instance, spreadValue)
    if instance.Name == "Recoil" then
        return
    end
    for _, child in ipairs(instance:GetChildren()) do
        if child.Name == "Spread" then
            setNumberValuesSkippingRecoil(child, spreadValue / 10)
        elseif child.Name ~= "Recoil" then
            updateSpreadValuesForInstance(child, spreadValue)
        end
    end
end

function updateSpreadValues(spreadValue)
    local weaponsFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Weapons")
    if weaponsFolder then
        for _, weapon in ipairs(weaponsFolder:GetChildren()) do
            updateSpreadValuesForInstance(weapon, spreadValue)
        end
    end
end

LeftMisc:AddToggle("MyToggle", {
    Text = "Enable Recoil",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        NoRecoilEnabled = state
        Recoil = 0
    end,
})

LeftMisc:AddSlider("MySlider", {
    Text = "Recoil",
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        if NoRecoilEnabled then
            Recoil = value
            if Weapons then
                for _, Weapon in ipairs(Weapons:GetChildren()) do
                    local Spread = Weapon:FindFirstChild("Spread")
                    if Spread then
                        local RecoilInstance = Spread:FindFirstChild("Recoil")
                        if RecoilInstance and RecoilInstance:IsA("NumberValue") then
                            RecoilInstance.Value = value
                            for _, child in ipairs(RecoilInstance:GetChildren()) do
                                if child:IsA("NumberValue") then
                                    child.Value = value
                                end
                            end
                        end
                    end
                end
            end
        end
    end,
})

RightMisc:AddToggle("MyToggle", {
	Text = "Instant Plant",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = true, 
	Callback = function(state)
		Settings12.misc_instant_plant = state
	end,
})

local player = game:GetService("Players").LocalPlayer
local pingValue = player:FindFirstChild("Ping")

if not pingValue then
    pingValue = Instance.new("NumberValue")
    pingValue.Name = "Ping"
    pingValue.Parent = player
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

local hitLogsEnabled = false
local shownLogs = {}
local previousDamage = {}

local green = "#00FF00"
local white = "#FFFFFF"

RightMisc:AddToggle("HitLogsToggle", {
    Text = "Hit Logs",
    Tooltip = "Toggle damage logs notifications and console output",
    Default = false,
    Callback = function(state)
        hitLogsEnabled = state
        if not state then
            shownLogs = {}
            previousDamage = {}
        end
    end
})

function getHitLocation(damage)
    if damage <= 10 then return "feet"
    elseif damage <= 25 then return "legs"
    elseif damage <= 40 then return "stomach"
    elseif (damage > 40 and damage <= 56) or damage == 57 then return "torso"
    elseif damage >= 58 and damage <= 1000 then return "head"
    else return "unknown"
    end
end

function getEquippedToolName(character)
    local eq = character:FindFirstChild("EquippedTool")
    if eq then
        if eq:IsA("StringValue") then
            return eq.Value
        elseif eq:IsA("Tool") then
            return eq.Name
        elseif eq:FindFirstChildOfClass("Tool") then
            return eq:FindFirstChildOfClass("Tool").Name
        end
    end
    return "empty"
end

task.spawn(function()
    while true do
        if hitLogsEnabled then
            local damageLogs = LocalPlayer:FindFirstChild("DamageLogs")
            if damageLogs then
                for _, playerFolder in ipairs(damageLogs:GetChildren()) do
                    local dmgValue = playerFolder:FindFirstChild("DMG")
                    if dmgValue and dmgValue:IsA("NumberValue") then
                        local name = playerFolder.Name
                        local current = dmgValue.Value
                        local prev = previousDamage[name] or 0
                        local difference = current - prev

                        if difference > 0 then
                            previousDamage[name] = current

                            local player = Players:FindFirstChild(name)
                            local remainingHP = "N/A"
                            if player and player.Character then
                                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    remainingHP = math.max(0, math.floor(humanoid.Health))
                                end
                            end

                            local hitLocation = getHitLocation(difference)
                            local equippedToolName = getEquippedToolName(LocalPlayer.Character)

                            local notifyMsg = "<font color='" .. lightPurple .. "'>Hit </font><font color='" .. white .. "'>" .. name .. "</font><font color='" .. white .. "'> for </font><font color='" .. lightPurple .. "'>" .. difference .. "</font><font color='" .. white .. "'> in the </font><font color='" .. lightPurple .. "'>" .. hitLocation .. "</font><font color='" .. white .. "'> with </font><font color='" .. lightPurple .. "'>" .. equippedToolName .. "</font><font color='" .. white .. "'> | Remaining HP: </font><font color='" .. lightPurple .. "'>" .. remainingHP .. "</font>"
                            Library:Notify(notifyMsg, 4)

                            print(string.format("Hit %s for %d in the %s | Remaining HP: %s", name, difference, hitLocation, remainingHP))
                        end
                    end
                end
            end
        else
            shownLogs = {}
            previousDamage = {}
        end
        task.wait(0.5)
    end
end)

local killSayEnabled = false

local messages = {
    Default = "iri.yaw OT", "1 Tapped By iri.yaw",
    Kiwi = "iri.yaw OT", "1 Tapped By iri.yaw"
}

RightMisc2:AddToggle("KillSayToggle", {
	Text = "Kill Say",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = true, 
	Callback = function(state)
        killSayEnabled = state
	end,
})

LocalPlayer.Status.Kills:GetPropertyChangedSignal("Value"):Connect(function()
	if not killSayEnabled then return end

	local kills = LocalPlayer.Status.Kills.Value
	if kills == 0 then return end

	local msg = (LocalPlayer.DisplayName == "iri.yaw" or LocalPlayer.Name == "iri.yaw") and messages.Kiwi or messages.Default

	ReplicatedStorage:WaitForChild("Events"):WaitForChild("PlayerChatted"):FireServer(msg, false)
end)

local noFilterEnabled = false

RightMisc2:AddToggle("NoFilterToggle", {
	Text = "No Chat Filter",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
        noFilterEnabled = state
	end,
})

if method == "InvokeServer" then 
	if self.Name == "Moolah" then 
		return 
	elseif self.Name == "Hugh" then 
		return 
	elseif self.Name == "Filter" and noFilterEnabled then 
		return args[1] 
	end 
end


local player = Players.LocalPlayer

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

if player.Character then
    onCharacter(player.Character)
end

player.CharacterAdded:Connect(onCharacter)

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




local originalName = LocalPlayer.Name
local newName = "iri.yaw"

RightMisc:AddToggle("MyToggle", {
    Text = "Name spoof",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        if state then
            LocalPlayer.Name = newName
        else
            LocalPlayer.Name = originalName
        end
    end,
})

local running = false

local forcedTeleportPosition = Vector3.new(99999, 99999, 99999)
local postJoinAction = "Auto Kill"

function moveSpawnPoints()
    function moveFolder(folder)
        for _, spawn in pairs(folder:GetChildren()) do
            if spawn:IsA("Part") or spawn:IsA("BasePart") then
                spawn.Position = Vector3.new(99999, 99999, 99999)
            end
        end
    end
    local map = workspace:FindFirstChild("Map")
    if map then
        local tSpawns = map:FindFirstChild("TSpawns")
        local ctSpawns = map:FindFirstChild("CTSpawns")
        local spawnPoints = map:FindFirstChild("SpawnPoints")
        local allSpawns = map:FindFirstChild("AllSpawns")
        if tSpawns then moveFolder(tSpawns) end
        if ctSpawns then moveFolder(ctSpawns) end
        if spawnPoints then moveFolder(spawnPoints) end
        if allSpawns then moveFolder(allSpawns) end
    end
end

function forceKill()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            humanoid.Health = 0
        end
    end
end

function forceTeleport()
    local character = LocalPlayer.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(forcedTeleportPosition)
            hrp.Anchored = true
        end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
        end
    end
end

function postJoinDo()
    if postJoinAction == "Auto Kill" then
        wait(7)
        forceKill()
    elseif postJoinAction == "Teleport" then
        forceTeleport()
    end
end

function joinTeam(teamName)
    ReplicatedStorage:WaitForChild("Events"):WaitForChild("JoinTeam"):FireServer(teamName)
    wait(1)
    postJoinDo()
end

function autoJoinLoop()
    while running do
        moveSpawnPoints()
        local tWins = workspace.Status.TWins.Value
        local ctWins = workspace.Status.CTWins.Value
        local currentTeam = tostring(LocalPlayer.Team.Name)
        if (tWins > ctWins and currentTeam == "T") or (ctWins > tWins and currentTeam == "CT") then
            wait(5)
        else
            if tWins > ctWins then
                joinTeam("T")
            elseif ctWins > tWins then
                joinTeam("CT")
            else
                joinTeam("CT")
            end
            wait(2)
        end
    end
end

RightMisc:AddToggle("AutoJoinWinningTeam", {
    Text = "Auto Farm Case Points",
    Tooltip = "Auto Joins Winning team (if possible)",
    Default = false,
    Callback = function(state)
        running = state
        if state then
            spawn(autoJoinLoop)
        end
    end,
})

RightMisc:AddDropdown("PostJoinAction", {
    Values = {"Auto Kill", "Teleport"},
    Default = 1,
    Text = "Auto Farm Method",
    Tooltip = "Auto Kill Recommended (kills you)",
    Callback = function(value)
        postJoinAction = value
    end,
})

local running = false

RightMisc:AddToggle("AntiSpectate", {
    Text = "Anti Spectate",
    Tooltip = "Prevents spectators from seeing your camera",
    Default = false,
    Callback = function(state)
        running = state
    end,
})

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if not checkcaller() and running then
        if method == "Kick" then
            return nil
        elseif method == "FireServer" and tostring(self) == "ReplicateCamera" then
            args[1] = CFrame.new()
            return oldNamecall(self, unpack(args))
        end
    end

    return oldNamecall(self, ...)
end)

local BulletsPerShotEnabled = false
local BulletsPerShotValue = 2

LeftMisc:AddToggle("MyToggle", {
    Text = "Enable Bullets Per Shot",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        BulletsPerShotEnabled = state
    end,
})

LeftMisc:AddSlider("MySlider", {
    Text = "Bullets Per Shot",
    Default = 2,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        if BulletsPerShotEnabled then
            BulletsPerShotValue = value
            for _, Weapon in ipairs(Weapons:GetChildren()) do
                local Bullets = Weapon:FindFirstChild("Bullets")
                if Bullets and Bullets:IsA("NumberValue") then
                    Bullets.Value = BulletsPerShotValue
                end
            end
        end
    end,
})

local originalValues = {
    RapidFire = {},
    InstantEquip = {},
    NoFireRate = {},
    NoReloadTime = {},
    InfiniteAmmo = {},
    ArmorPenetration = {},
    WallBang = {},
    InfiniteRange = {},
}

LeftMisc:AddToggle("MyToggle", {
    Text = "Rapid Fire",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local Auto = Weapon:FindFirstChild("Auto")
            if Auto and Auto:IsA("BoolValue") then
                if state then
                    if originalValues.RapidFire[Weapon] == nil then
                        originalValues.RapidFire[Weapon] = Auto.Value
                    end
                    Auto.Value = true
                else
                    if originalValues.RapidFire[Weapon] ~= nil then
                        Auto.Value = originalValues.RapidFire[Weapon]
                    end
                end
            end
        end
        if not state then originalValues.RapidFire = {} end
    end,
})

LeftMisc:AddToggle("MyToggle", {
    Text = "Instant Equip",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local Equip = Weapon:FindFirstChild("EquipTime")
            if Equip and Equip:IsA("NumberValue") then
                if state then
                    if originalValues.InstantEquip[Weapon] == nil then
                        originalValues.InstantEquip[Weapon] = Equip.Value
                    end
                    Equip.Value = 0.01
                else
                    if originalValues.InstantEquip[Weapon] ~= nil then
                        Equip.Value = originalValues.InstantEquip[Weapon]
                    end
                end
            end
        end
        if not state then originalValues.InstantEquip = {} end
    end,
})

LeftMisc:AddToggle("MyToggle", {
    Text = "No Fire Rate",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local fireRate = Weapon:FindFirstChild("FireRate")
            if fireRate and fireRate:IsA("NumberValue") then
                if state then
                    if originalValues.NoFireRate[Weapon] == nil then
                        originalValues.NoFireRate[Weapon] = fireRate.Value
                    end
                    fireRate.Value = 0
                else
                    if originalValues.NoFireRate[Weapon] ~= nil then
                        fireRate.Value = originalValues.NoFireRate[Weapon]
                    end
                end
            end
        end
        if not state then originalValues.NoFireRate = {} end
    end,
})

LeftMisc:AddToggle("MyToggle", {
    Text = "Infinite Ammo",
    Tooltip = "",
    Default = false,
    Callback = function(value)
        if value then
            for _, weapon in next, Weapons:GetChildren() do
                pcall(function()
                    if weapon:FindFirstChild("Ammo") and weapon:FindFirstChild("StoredAmmo") then
                        weapon.Ammo.Value = 99999
                        weapon.StoredAmmo.Value = 99999
                    end
                end)
            end
        else
            for _, curr in next, Weapons:GetChildren() do
                for _, original in next, WeaponClone:GetChildren() do
                    if curr.Name == original.Name then
                        pcall(function()
                            if curr:FindFirstChild("Ammo") and curr:FindFirstChild("StoredAmmo") and
                               original:FindFirstChild("Ammo") and original:FindFirstChild("StoredAmmo") then
                                curr.Ammo.Value = original.Ammo.Value
                                curr.StoredAmmo.Value = original.StoredAmmo.Value
                            end
                        end)
                    end
                end
            end
        end
    end
})
LeftMisc:AddToggle("MyToggle", {
    Text = "No Reload Time",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local reloadTime = Weapon:FindFirstChild("ReloadTime")
            if reloadTime and reloadTime:IsA("NumberValue") then
                if state then
                    if originalValues.NoReloadTime[Weapon] == nil then
                        originalValues.NoReloadTime[Weapon] = reloadTime.Value
                    end
                    reloadTime.Value = 0.05
                else
                    if originalValues.NoReloadTime[Weapon] ~= nil then
                        reloadTime.Value = originalValues.NoReloadTime[Weapon]
                    end
                end
            end
        end
        if not state then originalValues.NoReloadTime = {} end
    end,
})

LeftMisc:AddToggle("MyToggle", {
    Text = "Armor Penetration",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local ArmorPen = Weapon:FindFirstChild("ArmorPenetration")
            if ArmorPen and ArmorPen:IsA("NumberValue") then
                if state then
                    if originalValues.ArmorPenetration[Weapon] == nil then
                        originalValues.ArmorPenetration[Weapon] = ArmorPen.Value
                    end
                    ArmorPen.Value = 999999
                else
                    if originalValues.ArmorPenetration[Weapon] ~= nil then
                        ArmorPen.Value = originalValues.ArmorPenetration[Weapon]
                    end
                end
            end
        end
        if not state then originalValues.ArmorPenetration = {} end
    end,
})

LeftMisc:AddToggle("MyToggle", {
    Text = "Infinite Range",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local Range = Weapon:FindFirstChild("Range")
            if Range then
                if state then
                    if originalValues.InfiniteRange[Weapon] == nil then
                        originalValues.InfiniteRange[Weapon] = Range.Value
                    end
                    Range.Value = 9999999999
                else
                    if originalValues.InfiniteRange[Weapon] ~= nil then
                        Range.Value = originalValues.InfiniteRange[Weapon]
                    end
                end
            end
        end
        if not state then originalValues.InfiniteRange = {} end
    end,
})

LeftMisc:AddToggle("MyToggle", {
    Text = "Wall Bang",
    Tooltip = "",
    Default = false,
    Callback = function(state)
        for _, Weapon in ipairs(Weapons:GetChildren()) do
            local Pen = Weapon:FindFirstChild("Penetration")
            if Pen then
                if state then
                    if originalValues.WallBang[Weapon] == nil then
                        originalValues.WallBang[Weapon] = Pen.Value
                    end
                    Pen.Value = 999999999999
                else
                    if originalValues.WallBang[Weapon] ~= nil then
                        Pen.Value = originalValues.WallBang[Weapon]
                    end
                end
            end
        end
        if not state then originalValues.WallBang = {} end
    end,
})

RightMisc:AddToggle("MyToggle", {
	Text = "Unlock All",
	Tooltip = "Unlocks all skins",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function()
local Client = getsenv(game.Players.LocalPlayer.PlayerGui.Client)
 
local allSkins = {
{'M249_Aggressor'},
{'M249_Wolf'},
{'M249_P2020'},
{'M249_Spooky'},
{'M249_Lantern'},
{'M249_Halloween Treats'},
{'AWP_Grepkin'},
{'AWP_Instinct'},
{'AWP_Nerf'},
{'AWP_JTF2'},
{'AWP_Difference'},
{'AWP_Weeb'},
{'AWP_Pink Vision'},
{'AWP_Desert Camo'},
{'AWP_BloxersClub'},
{'AWP_Lunar'},
{'AWP_Scapter'},
{'AWP_Coffin Biter'},
{'AWP_Pear Tree'},
{'AWP_Northern Lights'},
{'AWP_Racer'},
{'AWP_Forever'},
{'AWP_Blastech'},
{'AWP_Abaddon'},
{'AWP_Retroactive'},
{'AWP_Pinkie'},
{'AWP_Autumness'},
{'AWP_Venomus'},
{'AWP_Hika'},
{'AWP_Silence'},
{'AWP_Kumanjayi'},
{'AWP_Dragon'},
{'AWP_Illusion'},
{'AWP_Regina'},
{'AWP_Quicktime'},
{'AWP_Toxic Nitro'},
{'AWP_Darkness'},
{'AWP_Oriental'},
{'AWP_Grim'},
{'AWP_Bloodborne'},
{'Sickle_Mummy'},
{'Sickle_Splattered'},
{'Sickle_Psychadelic'},
{'Sickle_Reaper'},
{'Sickle_Hallows'},
{'Sickle_Hieroglyphs'},
{'Sickle_Static'},
{'Sickle_Crimson'},
{'P2000_Comet'},
{'P2000_Golden Age'},
{'P2000_Apathy'},
{'P2000_Candycorn'},
{'P2000_Lunar'},
{'P2000_Ruby'},
{'P2000_Camo Dipped'},
{'P2000_Dark Beast'},
{'P2000_Pinkie'},
{'P2000_Silence'},
{'Flip Knife_Stock'},
{'Negev_Winterfell'},
{'Negev_Default'},
{'Negev_Quazar'},
{'Negev_Midnightbones'},
{'Negev_Wetland'},
{'Negev_Striped'},
{'Tec9_Gift Wrapped'},
{'Tec9_Ironline'},
{'Tec9_Skintech'},
{'Tec9_Stocking Stuffer'},
{'Tec9_Samurai'},
{'Tec9_Phol'},
{'Tec9_Charger'},
{'Tec9_Performer'},
{'Tec9_Seasoned'},
{'SawedOff_Spooky'},
{'SawedOff_Colorboom'},
{'SawedOff_Casino'},
{'SawedOff_Opal'},
{'SawedOff_Executioner'},
{'SawedOff_Sullys Blacklight'},
{'AUG_Phoenix'},
{'AUG_Dream Hound'},
{'AUG_Enlisted'},
{'AUG_Homestead'},
{'AUG_Sunsthetic'},
{'AUG_NightHawk'},
{'AUG_Maker'},
{'AUG_Graffiti'},
{'AUG_Chilly Night'},
{'AUG_Mystique'},
{'AUG_Soldier'},
{'AUG_Equalizer'},
{'Huntsman Knife_Stock'},
{'Huntsman Knife_Bloodwidow'},
{'Huntsman Knife_Crippled Fade'},
{'Huntsman Knife_Frozen Dream'},
{'Huntsman Knife_Geo Blade'},
{'Huntsman Knife_Hallows'},
{'Huntsman Knife_Marbleized'},
{'Huntsman Knife_Naval'},
{'Huntsman Knife_Ruby'},
{'Huntsman Knife_Splattered'},
{'Huntsman Knife_Wetland'},
{'Huntsman Knife_Monster'},
{'Huntsman Knife_Cozy'},
{'Huntsman Knife_Cosmos'},
{'Huntsman Knife_Digital'},
{'Huntsman Knife_Tropical'},
{'Huntsman Knife_Crimson Tiger'},
{'Huntsman Knife_Worn'},
{'Huntsman Knife_Egg Shell'},
{'Huntsman Knife_Twitch'},
{'Huntsman Knife_Honor Fade'},
{'Huntsman Knife_Consumed'},
{'Huntsman Knife_Goo'},
{'Huntsman Knife_Wrapped'},
{'Huntsman Knife_Aurora'},
{'Huntsman Knife_Ciro'},
{'Huntsman Knife_Drop-Out'},
{'Huntsman Knife_Spirit'},
{'Huntsman Knife_Spookiness'},
{'FiveSeven_Stigma'},
{'FiveSeven_Summer'},
{'FiveSeven_Gifted'},
{'FiveSeven_Midnight Ride'},
{'FiveSeven_Fluid'},
{'FiveSeven_Sub Zero'},
{'FiveSeven_Autumn Fade'},
{'FiveSeven_Mr. Anatomy'},
{'FiveSeven_Danjo'},
{'FiveSeven_Accelerator'},
{'Falchion Classic_Late Night'},
{'DesertEagle_Glittery'},
{'DesertEagle_Grim'},
{'DesertEagle_Weeb'},
{'DesertEagle_Krystallos'},
{'DesertEagle_Honor-bound'},
{'DesertEagle_TC'},
{'DesertEagle_Xmas'},
{'DesertEagle_Scapter'},
{'DesertEagle_Cool Blue'},
{'DesertEagle_Survivor'},
{'DesertEagle_Ababa'},
{'DesertEagle_Heat'},
{'DesertEagle_ROLVe'},
{'DesertEagle_Independence'},
{'DesertEagle_Racer'},
{'DesertEagle_Pumpkin Buster'},
{'DesertEagle_Skin Committee'},
{'DesertEagle_DropX'},
{'DesertEagle_Crystal'},
{'DesertEagle_Blue Fur'},
{'DesertEagle_Cold Truth'},
{'DesertEagle_BloxersClub'},
{'DesertEagle_Guapo'},
{'DesertEagle_Regal Eclipse'},
{'G3SG1_Foliage'},
{'G3SG1_Hex'},
{'G3SG1_Amethyst'},
{'G3SG1_Autumn'},
{'G3SG1_Mahogany'},
{'G3SG1_Holly Bound'},
{'Karambit_Stock'},
{'Karambit_Bloodwidow'},
{'Karambit_Crippled Fade'},
{'Karambit_Frozen Dream'},
{'Karambit_Gold'},
{'Karambit_Hallows'},
{'Karambit_Jade Dream'},
{'Karambit_Marbleized'},
{'Karambit_Naval'},
{'Karambit_Ruby'},
{'Karambit_Splattered'},
{'Karambit_Twitch'},
{'Karambit_Wetland'},
{'Karambit_Scapter'},
{'Karambit_Lantern'},
{'Karambit_Glossed'},
{'Karambit_Cosmos'},
{'Karambit_Digital'},
{'Karambit_Topaz'},
{'Karambit_Crimson Tiger'},
{'Karambit_Egg Shell'},
{'Karambit_Worn'},
{'Karambit_Tropical'},
{'Karambit_Neonic'},
{'Karambit_Liberty Camo'},
{'Karambit_Ghost'},
{'Karambit_Consumed'},
{'Karambit_Goo'},
{'Karambit_Death Wish'},
{'Karambit_Pizza'},
{'Karambit_Festive'},
{'Karambit_Quicktime'},
{'Karambit_Racer'},
{'Karambit_Jester'},
{'Karambit_Ciro'},
{'Karambit_Drop-Out'},
{'Karambit_Peppermint'},
{'Karambit_Cob Web'},
{'USP_Skull'},
{'USP_Yellowbelly'},
{'USP_Crimson'},
{'USP_Jade Dream'},
{'USP_Racing'},
{'USP_Frostbite'},
{'USP_Nighttown'},
{'USP_Paradise'},
{'USP_Dizzy'},
{'USP_Kraken'},
{'USP_Worlds Away'},
{'USP_Unseen'},
{'USP_Holiday'},
{'USP_Survivor'},
{'USP_BloxersClub'},
{'USP_Blossom'},
{'MAC10_Pimpin'},
{'MAC10_Wetland'},
{'MAC10_Turbo'},
{'MAC10_Golden Rings'},
{'MAC10_Skeleboney'},
{'MAC10_Artists Intent'},
{'MAC10_Toxic'},
{'MAC10_Blaze'},
{'MAC10_Scythe'},
{'MAC10_Devil'},
{'MAC10_Energy'},
{'Glock_Desert Camo'},
{'Glock_Day Dreamer'},
{'Glock_Wetland'},
{'Glock_Anubis'},
{'Glock_Midnight Tiger'},
{'Glock_Scapter'},
{'Glock_Gravestomper'},
{'Glock_Tarnish'},
{'Glock_Rush'},
{'Glock_Angler'},
{'Glock_Spacedust'},
{'Glock_Money Maker'},
{'Glock_RSL'},
{'Glock_White Sauce'},
{'Glock_Biotrip'},
{'Glock_Underwater'},
{'Glock_Hallows'},
{'Glock_BloxersClub'},
{'Fingerless Glove_Kimura'},
{'Fingerless Glove_Spookiness'},
{'Fingerless Glove_Patch'},
{'Fingerless Glove_Digital'},
{'Fingerless Glove_Scapter'},
{'Fingerless Glove_Crystal'},
{'MP7_Sunshot'},
{'MP7_Calaxian'},
{'MP7_Goo'},
{'MP7_Holiday'},
{'MP7_Silent Ops'},
{'MP7_Industrial'},
{'MP7_Reindeer'},
{'MP7_Cogged'},
{'MP7_Trauma'},
{'AK47_Hallows'},
{'AK47_Ace'},
{'AK47_Code Orange'},
{'AK47_Clown'},
{'AK47_Variant Camo'},
{'AK47_Eve'},
{'AK47_VAV'},
{'AK47_Quantum'},
{'AK47_Hypersonic'},
{'AK47_Mean Green'},
{'AK47_Bloodboom'},
{'AK47_Scapter'},
{'AK47_Skin Committee'},
{'AK47_Patch'},
{'AK47_Outlaws'},
{'AK47_Gifted'},
{'AK47_Ugly Sweater'},
{'AK47_Secret Santa'},
{'AK47_Precision'},
{'AK47_Outrunner'},
{'AK47_Godess'},
{'AK47_Maker'},
{'AK47_Ghost'},
{'AK47_Glo'},
{'AK47_Survivor'},
{'AK47_Shooting Star'},
{'AK47_Halo'},
{'AK47_Inversion'},
{'AK47_Plated'},
{'AK47_Quicktime'},
{'AK47_Yltude'},
{'AK47_Trinity'},
{'AK47_Toxic Nitro'},
{'AK47_Scythe'},
{'AK47_Neonline'},
{'AK47_Galaxy Corpse'},
{'AK47_Weeb'},
{'AK47_Super Weeb'},
{'AK47_BloxersClub'},
{'AK47_Jester'},
{'Galil_Hardware'},
{'Galil_Hardware 2'},
{'Galil_Toxicity'},
{'Galil_Frosted'},
{'Galil_Worn'},
{'Galil_Vortex'},
{'Butterfly Knife_Stock'},
{'Butterfly Knife_Bloodwidow'},
{'Butterfly Knife_Crippled Fade'},
{'Butterfly Knife_Frozen Dream'},
{'Butterfly Knife_Hallows'},
{'Butterfly Knife_Jade Dream'},
{'Butterfly Knife_Marbleized'},
{'Butterfly Knife_Naval'},
{'Butterfly Knife_Ruby'},
{'Butterfly Knife_Splattered'},
{'Butterfly Knife_Twitch'},
{'Butterfly Knife_Wetland'},
{'Butterfly Knife_White Boss'},
{'Butterfly Knife_Scapter'},
{'Butterfly Knife_Reaper'},
{'Butterfly Knife_Icicle'},
{'Butterfly Knife_Cosmos'},
{'Butterfly Knife_Digital'},
{'Butterfly Knife_Topaz'},
{'Butterfly Knife_Tropical'},
{'Butterfly Knife_Crimson Tiger'},
{'Butterfly Knife_Egg Shell'},
{'Butterfly Knife_Worn'},
{'Butterfly Knife_Neonic'},
{'Butterfly Knife_Freedom'},
{'Butterfly Knife_Consumed'},
{'Butterfly Knife_Goo'},
{'Butterfly Knife_Inversion'},
{'Butterfly Knife_Wrapped'},
{'Butterfly Knife_Aurora'},
{'Butterfly Knife_Argus'},
{'Butterfly Knife_Snowfall'},
{'Butterfly Knife_Spooky'},
{'Strapped Glove_Cob Web'},
{'Strapped Glove_Kringle'},
{'Strapped Glove_Molten'},
{'Strapped Glove_Wisk'},
{'Strapped Glove_Grim'},
{'Strapped Glove_Racer'},
{'Strapped Glove_Drop-Out'},
{'Strapped Glove_BloxersClub'},
{'Sports Glove_Pumpkin'},
{'Sports Glove_CottonTail'},
{'Sports Glove_RSL'},
{'Sports Glove_Skulls'},
{'Sports Glove_Weeb'},
{'Sports Glove_Royal'},
{'Sports Glove_Majesty'},
{'Sports Glove_Hallows'},
{'Sports Glove_Hazard'},
{'Sports Glove_Calamity'},
{'Sports Glove_Twitch'},
{'Sports Glove_Dead Prey'},
{'MAG7_Molten'},
{'MAG7_Striped'},
{'MAG7_Frosty'},
{'MAG7_Outbreak'},
{'MAG7_Bombshell'},
{'MAG7_C4UTION'},
{'Handwraps_Mummy'},
{'Handwraps_Toxic Nitro'},
{'Handwraps_Green Hex'},
{'Handwraps_Purple Hex'},
{'Handwraps_Orange Hex'},
{'Handwraps_Spector Hex'},
{'Handwraps_Phantom Hex'},
{'Handwraps_Microbes'},
{'Handwraps_Wetland'},
{'Handwraps_Guts'},
{'Handwraps_Wraps'},
{'Handwraps_MMA'},
{'Handwraps_Ghoul Hex'},
{'XM_Red'},
{'XM_Spectrum'},
{'XM_Artic'},
{'XM_Atomic'},
{'XM_Campfire'},
{'XM_Predator'},
{'XM_MK11'},
{'XM_Endless Night'},
{'UMP_Militia Camo'},
{'UMP_Magma'},
{'UMP_Redline'},
{'UMP_Death Grip'},
{'UMP_Molten'},
{'UMP_Gum Drop'},
{'UMP_Orbit'},
{'Crowbar_Stock'},
{'M4A1_Toucan'},
{'M4A1_Animatic'},
{'M4A1_Desert Camo'},
{'M4A1_Wastelander'},
{'M4A1_BloxersClub'},
{'M4A1_Tecnician'},
{'M4A1_Impulse'},
{'M4A1_Burning'},
{'M4A1_Lunar'},
{'M4A1_Necropolis'},
{'M4A1_Jester'},
{'M4A1_Nightmare'},
{'M4A1_Heavens Gate'},
{'Scout_Xmas'},
{'Scout_Coffin Biter'},
{'Scout_Railgun'},
{'Scout_Hellborn'},
{'Scout_Hot Cocoa'},
{'Scout_Theory'},
{'Scout_Pulse'},
{'Scout_Monstruo'},
{'Scout_Flowing Mists'},
{'Scout_Neon Regulation'},
{'Scout_Posh'},
{'Scout_Darkness'},
{'Scout_Lunar'},
{'CZ_Lightning'},
{'CZ_Orange Web'},
{'CZ_Festive'},
{'CZ_Spectre'},
{'CZ_Designed'},
{'CZ_Holidays'},
{'CZ_Hallow'},
{'Falchion Knife_Stock'},
{'Falchion Knife_Bloodwidow'},
{'Falchion Knife_Chosen'},
{'Falchion Knife_Crippled Fade'},
{'Falchion Knife_Frozen Dream'},
{'Falchion Knife_Hallows'},
{'Falchion Knife_Marbleized'},
{'Falchion Knife_Naval'},
{'Falchion Knife_Ruby'},
{'Falchion Knife_Splattered'},
{'Falchion Knife_Wetland'},
{'Falchion Knife_Zombie'},
{'Falchion Knife_Coal'},
{'Falchion Knife_Late Night'},
{'Falchion Knife_Cosmos'},
{'Falchion Knife_Digital'},
{'Falchion Knife_Topaz'},
{'Falchion Knife_Tropical'},
{'Falchion Knife_Crimson Tiger'},
{'Falchion Knife_Egg Shell'},
{'Falchion Knife_Worn'},
{'Falchion Knife_Neonic'},
{'Falchion Knife_Consumed'},
{'Falchion Knife_Freedom'},
{'Falchion Knife_Goo'},
{'Falchion Knife_Inversion'},
{'Falchion Knife_Wrapped'},
{'Falchion Knife_Festive'},
{'Falchion Knife_Racer'},
{'Falchion Knife_Toxic Nitro'},
{'Falchion Knife_Pumpkin'},
{'Falchion Knife_Cocoa'},
{'Falchion Knife_Kimura'},
{'Falchion Knife_Twilight'},
{'M4A4_Devil'},
{'M4A4_Pinkvision'},
{'M4A4_Desert Camo'},
{'M4A4_BOT[S]'},
{'M4A4_Precision'},
{'M4A4_Candyskull'},
{'M4A4_Scapter'},
{'M4A4_Toy Soldier'},
{'M4A4_Endline'},
{'M4A4_Pondside'},
{'M4A4_Ice Cap'},
{'M4A4_Pinkie'},
{'M4A4_Racer'},
{'M4A4_Stardust'},
{'M4A4_King'},
{'M4A4_Flashy Ride'},
{'M4A4_RayTrack'},
{'M4A4_Mistletoe'},
{'M4A4_Delinquent'},
{'M4A4_Quicktime'},
{'M4A4_Jester'},
{'M4A4_Darkness'},
{'MP9_Velvita'},
{'MP9_Blueroyal'},
{'MP9_Decked Halls'},
{'MP9_Cookie Man'},
{'MP9_Wilderness'},
{'MP9_Vaporwave'},
{'MP9_Cob Web'},
{'MP9_SnowTime'},
{'MP9_Control'},
{'P90_Skulls'},
{'P90_Redcopy'},
{'P90_Demon Within'},
{'P90_P-Chan'},
{'P90_Krampus'},
{'P90_Pine'},
{'P90_Elegant'},
{'P90_Northern Lights'},
{'P90_Argus'},
{'P90_Curse'},
{'SG_Yltude'},
{'SG_Knighthood'},
{'SG_Variant Camo'},
{'SG_Magma'},
{'SG_DropX'},
{'SG_Dummy'},
{'SG_Kitty Cat'},
{'SG_Drop-Out'},
{'SG_Control'},
{'SG_NR8'},
{'Gut Knife_Bloodwidow'},
{'Gut Knife_Crippled Fade'},
{'Gut Knife_Frozen Dream'},
{'Gut Knife_Geo Blade'},
{'Gut Knife_Present'},
{'Gut Knife_Marbleized'},
{'Gut Knife_Naval'},
{'Gut Knife_Ruby'},
{'Gut Knife_Rusty'},
{'Gut Knife_Splattered'},
{'Gut Knife_Wetland'},
{'Gut Knife_Lurker'},
{'Gut Knife_Hallows'},
{'Gut Knife_Cosmos'},
{'Gut Knife_Digital'},
{'Gut Knife_Topaz'},
{'Gut Knife_Tropical'},
{'Gut Knife_Crimson Tiger'},
{'Gut Knife_Egg Shell'},
{'Gut Knife_Worn'},
{'Gut Knife_Neonic'},
{'Gut Knife_Banner'},
{'Gut Knife_Consumed'},
{'Gut Knife_Goo'},
{'Gut Knife_Wrapped'},
{'Gut Knife_Holly'},
{'Gut Knife_Cob Web'},
{'R8_Violet'},
{'R8_Hunter'},
{'R8_Spades'},
{'R8_Exquisite'},
{'R8_TG'},
{'P250_BloxersClub'},
{'P250_Green Web'},
{'P250_TC250'},
{'P250_Amber'},
{'P250_Frosted'},
{'P250_Solstice'},
{'P250_Equinox'},
{'P250_Goldish'},
{'P250_Shark'},
{'P250_Midnight'},
{'P250_Bomber'},
{'Nova_Terraformer'},
{'Nova_Tiger'},
{'Nova_Black Ice'},
{'Nova_Sharkesh'},
{'Nova_Paradise'},
{'Nova_Starry Night'},
{'Nova_Cookie'},
{'Nova_Tricked'},
{'Nova_Defective'},
{'Nova_Oath'},
{'Bearded Axe_Beast'},
{'Bearded Axe_Splattered'},
{'Cleaver_Spider'},
{'Cleaver_Splattered'},
{'Cleaver_ImageLabel'},
{'Bayonet_Stock'},
{'Bayonet_Frozen Dream'},
{'Bayonet_Geo Blade'},
{'Bayonet_Hallows'},
{'Bayonet_Intertwine'},
{'Bayonet_Marbleized'},
{'Bayonet_Naval'},
{'Bayonet_Sapphire'},
{'Bayonet_Splattered'},
{'Bayonet_Twitch'},
{'Bayonet_Wetland'},
{'Bayonet_Easy-Bake'},
{'Bayonet_Crow'},
{'Bayonet_UFO'},
{'Bayonet_Silent Night'},
{'Bayonet_Ciro'},
{'Bayonet_Digital'},
{'Bayonet_Topaz'},
{'Bayonet_Tropical'},
{'Bayonet_Crimson Tiger'},
{'Bayonet_Egg Shell'},
{'Bayonet_Worn'},
{'Bayonet_Neonic'},
{'Bayonet_RSL'},
{'Bayonet_Consumed'},
{'Bayonet_Banner'},
{'Bayonet_Goo'},
{'Bayonet_Ghastly'},
{'Bayonet_Candy Cane'},
{'Bayonet_Mariposa'},
{'Bayonet_Aequalis'},
{'Bayonet_Festive'},
{'Bayonet_Wrapped'},
{'Bayonet_Delinquent'},
{'Bayonet_Racer'},
{'Bayonet_Decor'},
{'Bayonet_Kimura'},
{'Bayonet_Haunted'},
{'Bayonet_BloxersClub'},
{'Bayonet_Cosmos'},
{'Famas_Abstract'},
{'Famas_Haunted Forest'},
{'Famas_Goliath'},
{'Famas_Redux'},
{'Famas_Toxic Rain'},
{'Famas_Centipede'},
{'Famas_Medic'},
{'Famas_Cogged'},
{'Famas_KugaX'},
{'Famas_Shocker'},
{'Famas_MK11'},
{'Famas_Imprisioned'},
{'Famas_Blossom'},
{'Bizon_Festive'},
{'Bizon_Shattered'},
{'Bizon_Oblivion'},
{'Bizon_Sergeant'},
{'Bizon_Saint Nick'},
{'Bizon_Autumic'},
}
 
local isUnlocked
 
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
 
local isUnlocked
 
mt.__namecall = newcclosure(function(self, ...)
   local args = {...}
   if getnamecallmethod() == "InvokeServer" and tostring(self) == "Hugh" then
       return
   end
   if getnamecallmethod() == "FireServer" then
       if args[1] == LocalPlayer.UserId then
           return
       end
       if string.len(tostring(self)) == 38 then
           if not isUnlocked then
               isUnlocked = true
               for i,v in pairs(allSkins) do
                   local doSkip
                   for i2,v2 in pairs(args[1]) do
                       if v[1] == v2[1] then
                           doSkip = true
                       end
                   end
                   if not doSkip then
                       table.insert(args[1], v)
                   end
               end
           end
           return
       end
       if tostring(self) == "DataEvent" and args[1][4] then
           local currentSkin = string.split(args[1][4][1], "_")[2]
           if args[1][2] == "Both" then
               LocalPlayer["SkinFolder"]["CTFolder"][args[1][3]].Value = currentSkin
               LocalPlayer["SkinFolder"]["TFolder"][args[1][3]].Value = currentSkin
           else
               LocalPlayer["SkinFolder"][args[1][2] .. "Folder"][args[1][3]].Value = currentSkin
           end
       end
   end
   return oldNamecall(self, ...)
end)
   
setreadonly(mt, true)
 
Client.CurrentInventory = allSkins
 
local TClone, CTClone = LocalPlayer.SkinFolder.TFolder:Clone(), game.Players.LocalPlayer.SkinFolder.CTFolder:Clone()
LocalPlayer.SkinFolder.TFolder:Destroy()
LocalPlayer.SkinFolder.CTFolder:Destroy()
TClone.Parent = LocalPlayer.SkinFolder
CTClone.Parent = LocalPlayer.SkinFolder
end
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
    end,
})

chams1:AddSlider("NightModeBrightnessSlider", {
    Text = "Transparency",
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Callback = function(Value)
        chams.fillTransparency = Value
    end,
})

local highlights = {}

function IsOnSameTeam(player)
    return player.Team == LocalPlayer.Team
end

function isVisible(character)
    local head = character:FindFirstChild("Head")
    if not head then return false end

    local origin = Camera.CFrame.Position
    local direction = (head.Position - origin)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, raycastParams)

    return result and result.Instance and result.Instance:IsDescendantOf(character)
end

function createHighlight(player)
    if not player.Character then return nil end
    local highlight = Instance.new("Highlight")
    highlight.Name = "ChamsHighlight"
    highlight.Adornee = player.Character
    highlight.FillTransparency = chams.fillTransparency or 0.3
    highlight.OutlineTransparency = 1
    highlight.Parent = player.Character
    return highlight
end

function removeHighlightsForPlayer(player)
    local h = highlights[player]
    if h and typeof(h.Highlight) == "Instance" and h.Highlight.Destroy then
        h.Highlight:Destroy()
    end
    highlights[player] = nil
end

function updateChams(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        removeHighlightsForPlayer(player)
        return
    end

    if IsOnSameTeam(player) then
        removeHighlightsForPlayer(player)
        return
    end

    if not highlights[player] or not highlights[player].Highlight or not highlights[player].Highlight:IsDescendantOf(game) then
        removeHighlightsForPlayer(player)
        local newHighlight = createHighlight(player)
        if newHighlight then
            highlights[player] = { Highlight = newHighlight }
        else
            return
        end
    end

    local h = highlights[player].Highlight
    if not h then return end

    h.FillTransparency = chams.fillTransparency or 0.3
    h.OutlineTransparency = 1

    if chams.VisibleChamsEnabled and isVisible(player.Character) then
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

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        updateChams(player)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeHighlightsForPlayer(player)
end)

RunService.RenderStepped:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            pcall(function()
                updateChams(player)
            end)
        end
    end
end)

chams1:AddToggle("MyToggle", {
	Text = "Arm Chams",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
        ArmsChams = state
	end,
})

chams1:AddToggle("MyToggle", {
	Text = "View Model Chams",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
        GunsChams = state
	end,
})
:AddColorPicker("ColorPicker1", {
	Default = Color3.new(1, 1, 1),
	Title = "", 
	Transparency = 0, 

	Callback = function(color)
        ChamsColor = color
	end,
})


local Settings = {
    Box_Color = Color3.fromRGB(255, 255, 255),
    Tracer_Color = Color3.fromRGB(255, 255, 255),
    Name_Color = Color3.fromRGB(255, 255, 255),
    Distance_Color = Color3.fromRGB(255, 255, 255),
    Gun_Color = Color3.fromRGB(255, 255, 255),
    
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
    ShowPing = false,     
    ShowC4 = false,      
    BoxESP = false,
    TeamCheck = true,
    ShowMoney = false
}


local player = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

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
    if not plr.Team or not player.Team then return false end
    return plr.Team == player.Team
end

function Visibility(state, lib)
    for _, x in pairs(lib) do
        x.Visible = state
    end
end

local black = Color3.fromRGB(0, 0, 0)

function getEquippedToolName(character)
    local eq = character:FindFirstChild("EquippedTool")
    if eq then
        if eq:IsA("StringValue") then
            return eq.Value
        elseif eq:IsA("Tool") then
            return eq.Name
        elseif eq:FindFirstChildOfClass("Tool") then
            return eq:FindFirstChildOfClass("Tool").Name
        end
    end
    return "empty"
end

function ESP(plr)
    local library = {
        blacktracer = NewLine(Settings.Tracer_Thickness * 2, black),
        tracer = NewLine(Settings.Tracer_Thickness, Settings.Tracer_Color),
        black = NewQuad(Settings.Box_Thickness * 2, black),
        box = NewQuad(Settings.Box_Thickness, Settings.Box_Color),
        healthbar = NewLine(3, black),
        greenhealth = NewLine(1.5, black),
        armorbar = NewLine(3, black),
        bluearmor = NewLine(1.5, Color3.fromRGB(50, 150, 255)),
        nametext = NewText(13, Color3.fromRGB(255, 255, 255)),
        distancetext = NewText(13, Color3.fromRGB(200, 200, 200)),
        guntext = NewText(13, Color3.fromRGB(200, 200, 200)),
        cashtxt = NewText(10, Color3.fromRGB(173, 255, 47)),
        pingtext = NewText(10, Color3.fromRGB(255, 255, 255)),
        c4text = NewText(10, Color3.fromRGB(255, 0, 0))
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

            if Settings.BoxESP then
                Size(library.box, HumPos, DistanceY)
                Size(library.black, HumPos, DistanceY)
                library.box.Visible = true
                library.black.Visible = true
                library.box.Color = Settings.Box_Color
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
                library.tracer.Color = Settings.Tracer_Color
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
                    local green = Color3.fromRGB(0, 255, 0)
                    local red = Color3.fromRGB(255, 0, 0)
                    library.greenhealth.Color = red:lerp(green, healthPercent)
                    library.greenhealth.Visible = true
                    library.healthbar.Visible = true
                end
            else
                library.greenhealth.Visible = false
                library.healthbar.Visible = false
            end

            if Settings.ArmorBar then
                local d = (Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY * 2) - Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2)).Magnitude
                local kevlarValue = plr:FindFirstChild("Kevlar") and plr.Kevlar.Value or 0
                kevlarValue = math.clamp(kevlarValue, 0, 100)
                local armoroffset = (kevlarValue / 100) * d
                library.armorbar.From = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2 + 4)
                library.armorbar.To = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY * 2 + 4)
                library.bluearmor.From = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY * 2 + 4)
                library.bluearmor.To = Vector2.new(HumPos.X - DistanceY + armoroffset, HumPos.Y + DistanceY * 2 + 4)
                library.armorbar.Visible = true
                library.bluearmor.Visible = true
            else
                library.armorbar.Visible = false
                library.bluearmor.Visible = false
            end

            if Settings.ShowName then
                library.nametext.Text = plr.Name
                library.nametext.Position = Vector2.new(HumPos.X, HumPos.Y - DistanceY * 2 - 15)
                library.nametext.Visible = true
                library.nametext.Color = Settings.Name_Color
            else
                library.nametext.Visible = false
            end

            if Settings.ShowDistance then
                local dist = (plr.Character.HumanoidRootPart.Position - camera.CFrame.Position).Magnitude
                library.distancetext.Text = tostring(math.floor(dist)) .. "m"
                library.distancetext.Position = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2 + 15)
                library.distancetext.Visible = true
                library.distancetext.Color = Settings.Distance_Color
            else
                library.distancetext.Visible = false
            end

            local teamCheckPass = not Settings.TeamCheck or not IsOnSameTeam(plr)

            if Settings.ShowGun and teamCheckPass then
                local gunName = getEquippedToolName(plr.Character)
                library.guntext.Text = "[" .. gunName .. "]"
                library.guntext.Position = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2 + 25)
                library.guntext.Visible = true
                library.guntext.Color = Settings.Gun_Color
            else
                library.guntext.Visible = false
            end

           if Settings.ShowMoney and teamCheckPass then
            local moneyValue = plr:FindFirstChild("Money") or (plr:FindFirstChild("leaderstats") and plr.leaderstats:FindFirstChild("Money"))
            if moneyValue and type(moneyValue.Value) == "number" then
                library.cashtxt.Text = "$" .. tostring(moneyValue.Value)
                library.cashtxt.Position = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2 + 30)
                library.cashtxt.Visible = true
            else
                library.cashtxt.Visible = false
            end
        else
            library.cashtxt.Visible = false
        end


            if Settings.ShowPing and teamCheckPass then
                local ping = plr:FindFirstChild("Ping") and plr.Ping.Value or 0
                library.pingtext.Text = "Ping: " .. tostring(ping)
                library.pingtext.Position = Vector2.new(HumPos.X + DistanceY + 6, HumPos.Y - DistanceY * 2 + 18)
                library.pingtext.Visible = true
            else
                library.pingtext.Visible = false
            end

            if Settings.ShowC4 and teamCheckPass then
                local hasC4 = plr:FindFirstChild("HasC4") and plr.HasC4.Value or false
                if hasC4 then
                    library.c4text.Text = "[C4]"
                    library.c4text.Position = Vector2.new(HumPos.X + DistanceY + 6, HumPos.Y - DistanceY * 2 + 34)
                    library.c4text.Visible = true
                else
                    library.c4text.Visible = false
                end
            else
                library.c4text.Visible = false
            end
        end)
    end

    coroutine.wrap(Updater)()
end

for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
    if v ~= player then
        ESP(v)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    ESP(v)
end)

esp:AddToggle("MyToggle", {
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
:AddColorPicker("BoxColor", {
    Title = "Box Color",
    Default = Settings.Box_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Box_Color = color
    end
})

esp:AddToggle("MyToggle", {
	Text = "Health Esp",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
		Settings.HealthBar = state
	end,
})
esp:AddToggle("MyToggle", {
	Text = "Armor Esp",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
		Settings.ArmorBar = state
	end,
})
esp:AddToggle("MyToggle", {
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
:AddColorPicker("NameColor", {
    Title = "Name Color",
    Default = Settings.Name_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Name_Color = color
    end
})
esp:AddToggle("MyToggle", {
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
:AddColorPicker("DistanceColor", {
    Title = "Distance Color",
    Default = Settings.Distance_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Distance_Color = color
    end
})
esp:AddToggle("MyToggle", {
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
:AddColorPicker("GunColor", {
    Title = "Gun Color",
    Default = Settings.Gun_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Gun_Color = color
    end
})
esp:AddToggle("MyToggle", {
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
:AddColorPicker("TracerColor", {
    Title = "Tracer Color",
    Default = Settings.Tracer_Color,
    Transparency = 0,
    Callback = function(color)
        Settings.Tracer_Color = color
    end
})

esp:AddToggle("MoneyToggle", {
	Text = "Money",
	Tooltip = "",
	DisabledTooltip = "",
	Default = false,
	Disabled = false,
	Visible = true,
	Risky = false,
	Callback = function(state)
		Settings.ShowMoney = state
	end,
})

esp:AddToggle("PingToggle", {
	Text = "Ping",
	Tooltip = "",
	DisabledTooltip = "",
	Default = false,
	Disabled = false,
	Visible = true,
	Risky = false,
	Callback = function(state)
		Settings.ShowPing = state
	end,
})

esp:AddToggle("C4Toggle", {
	Text = "C4 Carrier",
	Tooltip = "",
	DisabledTooltip = "",
	Default = false,
	Disabled = false,
	Visible = true,
	Risky = false,
	Callback = function(state)
	    Settings.ShowC4 = state
	end,
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

function IsOnSameTeam(player)
	return player.Team == LocalPlayer.Team
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

Players.PlayerRemoving:Connect(function(player)
	local items = ESPLines[player]
	if items then
		for _, line in pairs(items.Lines) do
			line:Remove()
		end
		if items.HeadCircle then
			items.HeadCircle:Remove()
		end
		ESPLines[player] = nil
	end
end)

RunService.RenderStepped:Connect(function()
	if not SkeletonESPEnabled then return end

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and not IsOnSameTeam(player) then
			local character = player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				if not ESPLines[player] then
					ESPLines[player] = { Lines = {} }

					for i = 1, #BonePairs do
						local line = Drawing.new("Line")
						line.Thickness = 1
						line.Color = SkeletonColor
						line.Visible = false
						ESPLines[player].Lines[i] = line
					end

					local circle = Drawing.new("Circle")
					circle.Radius = 4
					circle.Filled = false
					circle.Color = SkeletonColor
					circle.Thickness = 1
					circle.Visible = false
					ESPLines[player].HeadCircle = circle
				end

				for i, pair in ipairs(BonePairs) do
					local part1 = character:FindFirstChild(pair[1])
					local part2 = character:FindFirstChild(pair[2])
					local line = ESPLines[player].Lines[i]

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
				local circle = ESPLines[player].HeadCircle
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
				if ESPLines[player] then
					for _, line in pairs(ESPLines[player].Lines) do line.Visible = false end
					if ESPLines[player].HeadCircle then ESPLines[player].HeadCircle.Visible = false end
				end
			end
		end
	end
end)

local world = Tabs.world:AddLeftGroupbox("World")
local worlde = Tabs.world:AddRightGroupbox("Extra")

world:AddToggle("MyToggle", {
	Text = "Third Person",
	Tooltip = "",
	DisabledTooltip = "", 
	Default = false, 
	Disabled = false, 
	Visible = true, 
	Risky = false, 
	Callback = function(state)
        ThirdPerson = state
	end,
})

world:AddSlider("NightModeBrightnessSlider", {
    Text = "Third Person Distance",
    Default = 10,
    Min = 0,
    Max = 100,
    Callback = function(Value)
        ThirdPersonDistance = value
    end,
})

world:AddSlider("FovSlider", {
    Text = "Fov Changer",
    Default = 80,
    Min = 0,
    Max = 120,
    Callback = function(Value)
        FieldOfView = Value
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

local RayIgnore = workspace.Ray_Ignore

worlde:AddToggle("HitmarkerToggle", {
    Text = "Hitmarker",
    Default = false,
    Callback = function(state)
        world1.hitmarkerEnabled = state
    end,
})
:AddColorPicker("HitmarkerColor", {
    Text = "Hitmarker Color",
    Default = hitmarkerColor,
    Callback = function(color)
        world1.hitmarkerColor = color
    end,
})

worlde:AddToggle("MollyRadiusToggle", {
    Text = "Molly Radius",
    Default = false,
    Callback = function(state)
        world1.mollyRadiusEnabled = state
    end,
})
:AddColorPicker("MollyRadiusColor", {
    Text = "Molly Radius Color",
    Default = mollyRadiusColor,
    Callback = function(color)
        world1.mollyRadiusColor = color
    end,
})
worlde:AddToggle("SmokeRadiusToggle", {
    Text = "Smoke Radius",
    Default = false,
    Callback = function(state)
        world1.smokeRadiusEnabled = state
    end,
})
:AddColorPicker("SmokeRadiusColor", {
    Text = "Smoke Radius Color",
    Default = smokeRadiusColor,
    Callback = function(color)
        world1.smokeRadiusColor = color
    end,
})

worlde:AddToggle("BulletTracersToggle", {
    Text = "Bullet Tracers",
    Default = false,
    Callback = function(state)
        world1.bulletTracersEnabled = state
    end,
})
:AddColorPicker("BulletTracersColor", {
    Text = "Bullet Tracers Color",
    Default = Color3.new(1, 1, 1),
    Callback = function(color)
        world1.bulletTracersColor = color
    end,
})

worlde:AddToggle("BulletTracersToggle", {
    Text = "Bullet Impacts",
    Default = false,
    Callback = function(state)
        world1.impacts.enabled = state
    end,
})
:AddColorPicker("BulletTracersColor", {
    Text = "1",
    Default = Color3.new(1, 1, 1),
    Callback = function(color)
        world1.impacts.color = newColor
    end,
})

local tracerDebounce = false

function createTracer(to, from, color)
    color = color or world1.bulletTracersColor

    if not tracerDebounce then
        tracerDebounce = true
        spawn(function()
            wait()
            tracerDebounce = false
        end)

        to -= (from.Position - to).Unit * 100

        local part1 = Instance.new("Part")
        local part2 = Instance.new("Part")
        local beam = Instance.new("Beam")
        local beam2 = Instance.new("Beam")
        local attachment1 = Instance.new("Attachment")
        local attachment2 = Instance.new("Attachment")

        part1.Transparency = 1
        part1.Position = to
        part1.CanCollide = false
        part1.Anchored = true
        part1.Parent = workspace.Debris
        attachment1.Parent = part1

        part2.Transparency = 1
        part2.Position = from.Position
        part2.CanCollide = false
        part2.Anchored = true
        part2.Parent = workspace.Debris
        attachment2.Parent = part2

        beam.FaceCamera = true
        beam.Color = ColorSequence.new(color)
        beam.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1 - 0.5),
            NumberSequenceKeypoint.new(1, 1 - 0.5)
        }
        beam.Width0 = 0.055
        beam.Width1 = 0.055
        beam.LightEmission = 1
        beam.LightInfluence = 0
        beam.Attachment0 = attachment1
        beam.Attachment1 = attachment2
        beam.Parent = part1

        beam2.FaceCamera = true
        beam2.Color = ColorSequence.new(Color3.new(1, 1, 1))
        beam2.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1 - 0.75),
            NumberSequenceKeypoint.new(1, 1 - 0.75)
        }
        beam2.Width0 = 0.025
        beam2.Width1 = 0.025
        beam2.LightEmission = 1
        beam2.LightInfluence = 0
        beam2.Attachment0 = attachment1
        beam2.Attachment1 = attachment2
        beam2.Parent = part1

        spawn(function()
            wait(2)
            for i = 0.5, 0, -0.025 do
                wait()
                beam.Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1 - i),
                    NumberSequenceKeypoint.new(1, 1 - i)
                }
                beam2.Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0.75 - i),
                    NumberSequenceKeypoint.new(1, 0.75 - i)
                }
            end
            for i = 0.25, 0, -0.025 do
                wait()
                beam2.Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1 - i),
                    NumberSequenceKeypoint.new(1, 1 - i)
                }
            end
            beam:Destroy()
            beam2:Destroy()
        end)
    end
end

if world1.bulletTracersEnabled and LocalPlayer.Character and camera:FindFirstChild("Arms") then
    local from = camera.Arms:FindFirstChild("Flash")
    if from then
        createTracer(decodePos(args[2]), from, world1.bulletTracersColor)
    end
end

if world1.impacts.enabled then
    coroutine.wrap(function()
        local hit = Instance.new("Part")
        hit.Transparency = 1
        hit.Anchored = true
        hit.CanCollide = false
        hit.Size = Vector3.new(0.3, 0.3, 0.3)
        hit.Position = args[2]

        local selection = Instance.new("SelectionBox")
        selection.LineThickness = 0
        selection.SurfaceTransparency = world1.impacts.transparency
        selection.Color3 = world1.impacts.color
        selection.SurfaceColor3 = world1.impacts.color
        selection.Adornee = hit
        selection.Parent = hit

        hit.Parent = workspace.Debris
        wait(world1.impacts.duration)
        library:Tween(selection, TweenInfo.new(world1.impacts.fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            SurfaceTransparency = 1
        })
        hit:Destroy()
    end)()
end

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local GUI = PlayerGui:WaitForChild("GUI")
local Crosshairs = GUI:WaitForChild("Crosshairs")
local Crosshair = Crosshairs:WaitForChild("Crosshair")

local crosshairLength = 10
local crosshairEnabled = false
local borderEnabled = false

function UpdateCrosshair()
	local length = crosshairLength

	if crosshairEnabled then
		Crosshair.LeftFrame.Size = UDim2.new(0, length, 0, 2)
		Crosshair.RightFrame.Size = UDim2.new(0, length, 0, 2)
		Crosshair.TopFrame.Size = UDim2.new(0, 2, 0, length)
		Crosshair.BottomFrame.Size = UDim2.new(0, 2, 0, length)

		for _, frame in pairs(Crosshair:GetChildren()) do
			if string.find(frame.Name, "Frame") then
				frame.BorderColor3 = Color3.new(0, 0, 0)
				frame.BorderSizePixel = borderEnabled and 1 or 0
			end
		end
	else
		Crosshair.LeftFrame.Size = UDim2.new(0, 10, 0, 2)
		Crosshair.RightFrame.Size = UDim2.new(0, 10, 0, 2)
		Crosshair.TopFrame.Size = UDim2.new(0, 2, 0, 10)
		Crosshair.BottomFrame.Size = UDim2.new(0, 2, 0, 10)

		for _, frame in pairs(Crosshair:GetChildren()) do
			if string.find(frame.Name, "Frame") then
				frame.BorderSizePixel = 0
			end
		end
	end
end

worlde:AddToggle("CrosshairToggle", {
    Text = "Crosshair Editor",
    Default = false,
    Callback = function(state)
        crosshairEnabled = state
        UpdateCrosshair()
    end,
})

worlde:AddSlider("CrosshairLength", {
    Text = "Crosshair Length",
    Default = 10,
    Min = 0,
    Max = 15,
    Rounding = 0,
    Callback = function(value)
        crosshairLength = value
        UpdateCrosshair()
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
	local character = player.Character
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

LocalPlayer.Additionals.TotalDamage:GetPropertyChangedSignal("Value"):Connect(function(current)
    if current == 0 then return end
    coroutine.wrap(function()
        if world1.hitmarkerEnabled then
            local Line = Drawing.new("Line")
            local Line2 = Drawing.new("Line")
            local Line3 = Drawing.new("Line")
            local Line4 = Drawing.new("Line")
            local x, y = Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2
            Line.From = Vector2.new(x + 4, y + 4)
            Line.To = Vector2.new(x + 10, y + 10)
            Line.Color = world1.hitmarkerColor
            Line.Visible = true
            Line2.From = Vector2.new(x + 4, y - 4)
            Line2.To = Vector2.new(x + 10, y - 10)
            Line2.Color = world1.hitmarkerColor
            Line2.Visible = true
            Line3.From = Vector2.new(x - 4, y - 4)
            Line3.To = Vector2.new(x - 10, y - 10)
            Line3.Color = world1.hitmarkerColor
            Line3.Visible = true
            Line4.From = Vector2.new(x - 4, y + 4)
            Line4.To = Vector2.new(x - 10, y + 10)
            Line4.Color = world1.hitmarkerColor
            Line4.Visible = true
            Line.Transparency = 1
            Line2.Transparency = 1
            Line3.Transparency = 1
            Line4.Transparency = 1
            Line.Thickness = 1
            Line2.Thickness = 1
            Line3.Thickness = 1
            Line4.Thickness = 1
            wait(0.3)
            for i = 1, 0, -0.1 do
                wait()
                Line.Transparency = i
                Line2.Transparency = i
                Line3.Transparency = i
                Line4.Transparency = i
            end
            Line:Remove()
            Line2:Remove()
            Line3:Remove()
            Line4:Remove()
        end
    end)()
end)

local ESPTexts = {}

local itemesp = {
    ItemESPEnabled = false,
    ItemEspColor = Color3.fromRGB(255, 255, 255),
}

worlde:AddToggle("WeaponEspToggle", {
    Text = "Item ESP",
    Default = false,
    Callback = function(state)
        itemesp.ItemESPEnabled = state
        if not state then
            for weapon in pairs(ESPTexts) do
                if ESPTexts[weapon] then
                    ESPTexts[weapon]:Destroy()
                    ESPTexts[weapon] = nil
                end
            end
        end
    end,
})
:AddColorPicker("WeaponEspColor", {
    Title = "Item ESP Color",
    Default = itemesp.ItemEspColor,
    Transparency = 0,
    Callback = function(color)
        itemesp.ItemEspColor = color
        for weapon, billboard in pairs(ESPTexts) do
            local label = billboard:FindFirstChildOfClass("TextLabel")
            if label then
                label.TextColor3 = color
            end
        end
    end,
})

function createESPForWeapon(weapon, color)
    if ESPTexts[weapon] or not weapon:IsA("BasePart") then return end
    if not Weapons:FindFirstChild(weapon.Name) then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPText"
    billboard.Adornee = weapon
    billboard.Size = UDim2.new(0, 100, 0, 10)
    billboard.StudsOffset = Vector3.new(0, 0, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.Parent = weapon

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = color
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Text = weapon.Name
    textLabel.TextScaled = true
    textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    textLabel.TextXAlignment = Enum.TextXAlignment.Center
    textLabel.Parent = billboard

    ESPTexts[weapon] = billboard
end

function removeESPForWeapon(weapon)
    if ESPTexts[weapon] then
        ESPTexts[weapon]:Destroy()
        ESPTexts[weapon] = nil
    end
end

function isPlayerDead()
    local character = LocalPlayer and LocalPlayer.Character
    if not character then return true end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return not humanoid or humanoid.Health <= 0
end

function updateESP()
    if not itemesp.ItemESPEnabled or isPlayerDead() then
        for weapon in pairs(ESPTexts) do
            removeESPForWeapon(weapon)
        end
        return
    end

    for weapon in pairs(ESPTexts) do
        if not weapon:IsDescendantOf(workspace) or not Debris:FindFirstChild(weapon.Name) then
            removeESPForWeapon(weapon)
        end
    end

    for _, weapon in pairs(Debris:GetChildren()) do
        if weapon:IsA("BasePart") and Weapons:FindFirstChild(weapon.Name) then
            if not ESPTexts[weapon] then
                createESPForWeapon(weapon, itemesp.ItemEspColor)
            end
        end
    end
end

spawn(function()
    while true do
        updateESP()
        task.wait(1)
    end
end)

if RayIgnore then
    RayIgnore.ChildAdded:Connect(function(obj)
        if obj.Name == "Fires" then
            obj.ChildAdded:Connect(function(fire)
                if world1.mollyRadiusEnabled then
                    fire.Transparency = mollyRadiusTransparency or fire.Transparency
                    fire.Color = world1.mollyRadiusColor or fire.Color
                end
            end)
        elseif obj.Name == "Smokes" then
            obj.ChildAdded:Connect(function(smoke)
                RunService.RenderStepped:Wait()
                local emitter = smoke:FindFirstChildWhichIsA("ParticleEmitter")
                if emitter then
                    local originalRate = Instance.new("NumberValue")
                    originalRate.Name = "OriginalRate"
                    originalRate.Value = emitter.Rate
                    originalRate.Parent = smoke
                end
                smoke.Material = Enum.Material.ForceField
                if world1.smokeRadiusEnabled then
                    smoke.Transparency = 0
                    smoke.Color = world1.smokeRadiusColor or smoke.Color
                end
            end)
        end
    end)
end

local ArmColor = ArmColor or Color3.fromRGB(200, 200, 200)

RunService.RenderStepped:Connect(function()
    if GunsChams == true then
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("MeshPart") or AnotherStuff:IsA("BasePart") then
                        AnotherStuff.Color = ChamsColor or Color3.fromRGB(200,200,200)
                        AnotherStuff.Material = Enum.Material.ForceField
                    end
                end
            end
        end
    else
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("MeshPart") or AnotherStuff:IsA("BasePart") then
                        AnotherStuff.Color = ChamsColor or Color3.fromRGB(200,200,200)
                        AnotherStuff.Material = Enum.Material.Plastic
                    end
                end
            end
        end            
    end
    task.wait()
end)

RunService.RenderStepped:Connect(function()
    if ArmsChams == true then
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("Model") and AnotherStuff.Name ~= "AnimSaves" then
                        for _, Arm in ipairs(AnotherStuff:GetChildren()) do
                            if Arm:IsA("BasePart") then
                                Arm.Transparency = 1
                                Arm.Color = ArmColor 
                                for _, StuffInArm in ipairs(Arm:GetChildren()) do
                                    if StuffInArm:IsA("BasePart") then
                                        StuffInArm.Material = Enum.Material.ForceField
                                        StuffInArm.Color = ArmColor or Color3.fromRGB(200, 200, 200)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("Model") and AnotherStuff.Name ~= "AnimSaves" then
                        for _, Arm in ipairs(AnotherStuff:GetChildren()) do
                            if Arm:IsA("BasePart") then
                                Arm.Transparency = 0
                                Arm.Color = ArmColor 
                                for _, StuffInArm in ipairs(Arm:GetChildren()) do
                                    if StuffInArm:IsA("BasePart") then
                                        StuffInArm.Material = Enum.Material.Plastic
                                        StuffInArm.Color = ArmColor or Color3.fromRGB(200, 200, 200)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    task.wait()
end)


        RunService.RenderStepped:Connect(function()
    if ThirdPerson == true then
        if LocalPlayer.CameraMinZoomDistance ~= ThirdPersonDistance or 10 then
            LocalPlayer.CameraMinZoomDistance = ThirdPersonDistance or 10
            LocalPlayer.CameraMaxZoomDistance = ThirdPersonDistance or 10
            workspace.ThirdPerson.Value = true
        end
    else
        if LocalPlayer.Character ~= nil then
            LocalPlayer.CameraMinZoomDistance = 0
            LocalPlayer.CameraMaxZoomDistance = 0
            workspace.ThirdPerson.Value = false
        end
    end
    task.wait()
end)

RunService.RenderStepped:Connect(function()
    Camera.FieldOfView = FieldOfView or 80
    task.wait()
end)

local models = Tabs.misc:AddLeftGroupbox("Model Changer")

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

local TeleportService = game:GetService("TeleportService")


local placeId = 301549746
local player = Players.LocalPlayer
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
                TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
                return
            end
        end
        cursor = data.nextPageCursor
    until not cursor
end

local outlineColor = Color3.fromRGB(230, 190, 230)
local specWidth, specMinHeight = 200, 20
local watermarkWidth, watermarkHeight = 255, 20

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "CustomUI"

function createOutlinedFrame(position, size)
	local container = Instance.new("Frame")
	container.Position = position
	container.Size = size
	container.BackgroundTransparency = 1
	container.Parent = ScreenGui

	local outlineThickness = 2

	local outlineTop = Instance.new("Frame")
	outlineTop.BackgroundColor3 = outlineColor
	outlineTop.BorderSizePixel = 0
	outlineTop.Size = UDim2.new(1, 0, 0, outlineThickness)
	outlineTop.Position = UDim2.new(0, 0, 0, 0)
	outlineTop.Parent = container

	local outlineBottom = Instance.new("Frame")
	outlineBottom.BackgroundColor3 = outlineColor
	outlineBottom.BorderSizePixel = 0
	outlineBottom.Size = UDim2.new(1, 0, 0, outlineThickness)
	outlineBottom.Position = UDim2.new(0, 0, 1, -outlineThickness)
	outlineBottom.Parent = container

	local outlineLeft = Instance.new("Frame")
	outlineLeft.BackgroundColor3 = outlineColor
	outlineLeft.BorderSizePixel = 0
	outlineLeft.Size = UDim2.new(0, outlineThickness, 1, 0)
	outlineLeft.Position = UDim2.new(0, 0, 0, 0)
	outlineLeft.Parent = container

	local outlineRight = Instance.new("Frame")
	outlineRight.BackgroundColor3 = outlineColor
	outlineRight.BorderSizePixel = 0
	outlineRight.Size = UDim2.new(0, outlineThickness, 1, 0)
	outlineRight.Position = UDim2.new(1, -outlineThickness, 0, 0)
	outlineRight.Parent = container

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(1, 0, 1, 0)
	mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	mainFrame.BackgroundTransparency = 0.3
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = container

	return container, mainFrame
end

local specContainer, specFrame = createOutlinedFrame(UDim2.new(1, -210, 0, 40), UDim2.new(0, specWidth, 0, specMinHeight))
local watermarkContainer, watermarkFrame = createOutlinedFrame(UDim2.new(1, -270, 0, 10), UDim2.new(0, watermarkWidth, 0, watermarkHeight))

local specTitle = Instance.new("TextLabel")
specTitle.Size = UDim2.new(1, 0, 0, 20)
specTitle.BackgroundTransparency = 1
specTitle.TextColor3 = Color3.new(1, 1, 1)
specTitle.Font = Enum.Font.SourceSansBold
specTitle.TextSize = 16
specTitle.Text = "Spectators:"
specTitle.Parent = specFrame

local specList = Instance.new("TextLabel")
specList.Size = UDim2.new(1, -10, 1, -20)
specList.Position = UDim2.new(0, 5, 0, 20)
specList.BackgroundTransparency = 1
specList.TextColor3 = Color3.new(1, 1, 1)
specList.Font = Enum.Font.SourceSans
specList.TextSize = 14
specList.TextXAlignment = Enum.TextXAlignment.Left
specList.TextYAlignment = Enum.TextYAlignment.Top
specList.TextWrapped = false
specList.Parent = specFrame

local watermark = Instance.new("TextLabel")
watermark.Size = UDim2.new(1, 0, 1, 0)
watermark.Position = UDim2.new(0, 0, 0, 0)
watermark.BackgroundTransparency = 1
watermark.TextColor3 = Color3.new(1, 1, 1)
watermark.Font = Enum.Font.SourceSansBold
watermark.TextSize = 14
watermark.TextXAlignment = Enum.TextXAlignment.Left
watermark.Parent = watermarkFrame

function GetSpectators()
	local currentSpectators = ""
	local cameraPos = Camera.CFrame.Position
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local success, character = pcall(function() return player.Character end)
			if success and not character then
				local cameraCFValue = player:FindFirstChild("CameraCF")
				if cameraCFValue and cameraCFValue:IsA("CFrameValue") then
					local dist = (cameraCFValue.Value.Position - cameraPos).Magnitude
					if dist < 10 then
						if currentSpectators == "" then
							currentSpectators = player.Name
						else
							currentSpectators = currentSpectators .. "\n" .. player.Name
						end
					end
				end
			end
		end
	end
	return currentSpectators
end

function updateSpecSize(text)
	local lines = 0
	for _ in text:gmatch("[^\n]+") do
		lines = lines + 1
	end
	local height = 20 + (lines * 18)
	specContainer.Size = UDim2.new(0, specWidth, 0, height)
end

local startTime = tick()
local lastUpdate = tick()
local frames = 0
local fps = 0

RunService.RenderStepped:Connect(function()
	frames = frames + 1
	local now = tick()
	if now - lastUpdate >= 1 then
		fps = frames
		frames = 0
		lastUpdate = now
	end

	local elapsed = math.floor(now - startTime)
	local hours = math.floor(elapsed / 3600)
	local minutes = math.floor((elapsed % 3600) / 60)
	local seconds = elapsed % 60
	local timeFormatted = string.format("%02d:%02d:%02d", hours, minutes, seconds)
	local ping = math.random(30, 80)

	watermark.Text = string.format("iri.yaw | Ping: %dms | FPS: %d | Time: %s", ping, fps, timeFormatted)
end)

spawn(function()
	while true do
		local specs = GetSpectators()
		specList.Text = specs
		updateSpecSize(specs)
		wait(1)
	end
end)

extra:AddToggle("WatermarkToggle", {
	Text = "Watermark",
	Default = true,
	Callback = function(state)
		watermarkContainer.Visible = state
	end,
})

extra:AddToggle("SpecListToggle", {
	Text = "Spectator List",
	Default = true,
	Callback = function(state)
		specContainer.Visible = state
	end,
})

extra:AddButton("Rejoin Server", function()
    TeleportService:TeleportToPlaceInstance(placeId, currentJobId, player)
end)

extra:AddButton("Server Hop", function()
    serverHop()
end)

presets:AddButton("Legit", function()
    chams.VisibleChamsEnabled = true
    chams.visibleColor = Color3.fromRGB(205, 107, 189)
    
    Legit12.Legit_silent_aim_wall_check = true
    Legit12.Legit_silent_aim_fov = true
    Legit12.Legit_silent_aim_fov_radius = 30
    Legit12.Legit_silent_aim_hit_chance = 75
    Legit12.Legit_silent_aim_hit_parts = {"Head", "Torso"}
    Legit12.Legit_silent_aim_enabled = true

    crosshairEnabled = true
    crosshairLength = 3
end)

presets:AddButton("Semi Rage", function()
    InvisibleChamsEnabled = true
    invisibleColor = Color3.fromRGB(45, 45, 45)
    
    chams.VisibleChamsEnabled = true
    chams.visibleColor = Color3.fromRGB(205, 107, 189)
    
    crosshairEnabled = true
    crosshairLength = 3
    
    Legit12.Legit_silent_aim_wall_check = true
    Legit12.Legit_silent_aim_fov = true
    Legit12.Legit_silent_aim_fov_radius = 75
    Legit12.Legit_silent_aim_hit_chance = 100
    Legit12.Legit_silent_aim_hit_parts = {"Head", "Torso"}
    Legit12.Legit_silent_aim_enabled = true
    
    hitmarkerEnabled = true
    hitmarkerColor = Color3.new(205, 107, 189)
    
    FieldOfView = 100
    
    NightModeEnabled = true
    NightModeColor = Color3.fromRGB(57, 57, 57)
    
    hitLogsEnabled = true
    NoFallDamageEnabled = true
    
    Settings.HealthBar = true
    Settings.ArmorBar = true
end)

-- // Magic-bullet
task.spawn(function()
    while task.wait(.5) do
        if Settings12.silent_aim_magic_bullet then
            local rayIgnore = CWorkspace:FindFirstChild("Ray_Ignore")
            if not rayIgnore then continue end
            local rayGeometry = rayIgnore:FindFirstChild("Geometry")
            if rayGeometry then
                if #rayGeometry:GetChildren() <= 0 then
                    rayGeometry:Destroy()
                end
                continue
            end
            local map = CWorkspace:FindFirstChild("Map")
            if not map then continue end
            local mapGeometry = map:FindFirstChild("Geometry")
            if not mapGeometry then continue end
            mapGeometry.Parent = rayIgnore
            mapGeometry.Name = "Geometry"
            local newGeometry = Instance.new("Folder")
            newGeometry.Name = "Geometry"
            newGeometry.Parent = map
        else
            local rayIgnore = CWorkspace:FindFirstChild("Ray_Ignore")
            if not rayIgnore then continue end
            local rayGeometry = rayIgnore:FindFirstChild("Geometry")
            if not rayGeometry then continue end
            local map = CWorkspace:FindFirstChild("Map")
            if not map then continue end
            local mapGeometry = map:FindFirstChild("Geometry")
            if mapGeometry then
                mapGeometry:Destroy()
            end
            rayGeometry.Parent = map
            rayGeometry.Name = "Geometry"
        end
    end
end)

local closest
function getPositionOnScreen(vector)
    local vec3, onScreen = Camera:WorldToScreenPoint(vector)
    return Vector2.new(vec3.X, vec3.Y), onScreen
end

function validateArguments(arguments, rayMethod)
    local matches = 0
    if #arguments < rayMethod.ArgCountRequired then return false end
    for pos, argument in next, arguments do
        if typeof(argument) == rayMethod.Args[pos] then
            matches = matches + 1
        end
    end
    return matches >= rayMethod.ArgCountRequired
end

function getDirection(origin, position)
    return (position - origin).Unit * 1000
end

function getClosestPlayer()
    local closest = nil
    local closestDistance = nil
    for _, player in next, Players:GetPlayers() do
        if player == LocalPlayer or player.Team == LocalPlayer.Team then continue end
        local character = player.Character
        if not character then continue end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        if not hrp or not humanoid or humanoid.Health <= 0 then continue end
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then continue end
        local dist = (myRoot.Position - hrp.Position).Magnitude
        if not closestDistance or dist < closestDistance then
            closest = player
            closestDistance = dist
        end
    end
    return closest
end

function calculateChance(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new():NextNumber(0, 1) * 100) / 100
    return chance <= Percentage / 100
end

function calculateChance(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
    return chance <= Percentage / 100
end

task.spawn(function()
    while task.wait() do
        nevm = getClosestPlayer()
        if nevm and nevm.Character then
            local sector = Settings12.silent_aim_hit_parts[math.random(#Settings12.silent_aim_hit_parts)]
            if sector == "Head" then
                closest = nevm.Character:FindFirstChild("Head")
            elseif sector == "Torso" then
                local toros = {"UpperTorso", "LowerTorso"}
                closest = nevm.Character:FindFirstChild(toros[math.random(#toros)])
            elseif sector == "Arms" then
                local arms = {"LeftHand", "LeftLowerArm", "LeftUpperArm", "RightHand", "RightLowerArm", "RightUpperArm"}
                closest = nevm.Character:FindFirstChild(arms[math.random(#arms)])
            elseif sector == "Legs" then
                local legs = {"LeftFoot", "LeftLowerLeg", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "RightUpperLeg"}
                closest = nevm.Character:FindFirstChild(legs[math.random(#legs)])  
            end
            if closest then 
                AdjustADSRemote:FireServer(unpack(AdjustADSRemoteArguments))
            end
        else
            closest = nil
        end
    end
end)

local blockedTools = {
    ["Decoy Grenade"] = true,
    ["DefuseKit"] = true,
    ["HE Grenade"] = true,
    ["Smoke Grenade"] = true,
    ["C4"] = true,
}

UserInputService.InputBegan:Connect(function(input, gpe)
    if eq and blockedTools[eq.Name] then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        silentaimTick = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if eq and blockedTools[eq.Name] then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        silentaimTick = false
    end
end)

local __c4_sound_event
__c4_sound_event = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local arguments = {...}
    local method = getnamecallmethod()
    if not checkcaller() and self == ReplicateSoundRemote and method == "FireServer" then
        if arguments[1].Name == "Planting" and Settings12.misc_instant_plant then
            PlantC4Arguments[1] = "A"
            PlantC4Remote:FireServer(unpack(PlantC4Arguments))
            PlantC4Arguments[1] = "B"
            PlantC4Remote:FireServer(unpack(PlantC4Arguments))
        end
        return __c4_sound_event(self, ...)
    end
    return __c4_sound_event(self, ...)
end))

local __namecall_silent
__namecall_silent = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local arguments = {...}
    local self = arguments[1]
    if self == workspace and not checkcaller() and silentaimTick and Settings12.silent_aim_hit_chance then
        local canHit = calculateChance(Settings12.silent_aim_hit_chance)
        if validateArguments(arguments, {ArgCountRequired = 3, Args = {"Instance", "Ray", "table", "boolean", "boolean"}}) and canHit then
            local ray = arguments[2]
            if closest then
                local origin = ray.Origin
                local direction = getDirection(origin, closest.Position)
                arguments[2] = Ray.new(origin, direction)
                return __namecall_silent(unpack(arguments))
            end
        end
    end
    return __namecall_silent(...)
end))

LocalPlayer.CharacterAdded:Connect(function(newChar)
    task.wait(0.125)
    currentCharacter = newChar
    currentHRP = newChar:WaitForChild("HumanoidRootPart")
    currentHumanoid = newChar:WaitForChild("Humanoid")
    currentHumanoid.AutoRotate = false
end)

task.spawn(function()
    while task.wait() do
        if not Settings12.silent_aim_enabled then
            closest = nil
            continue
        end
        local target = getClosestPlayer()
        if not (target and target.Character) then
            closest = nil
            continue
        end
        local partName = Settings12.silent_aim_hit_parts[math.random(#Settings12.silent_aim_hit_parts)]
        local part
        if partName == "Head" then
            part = target.Character:FindFirstChild("Head")
        elseif partName == "Torso" then
            part = target.Character:FindFirstChild(math.random() > 0.5 and "UpperTorso" or "LowerTorso")
        elseif partName == "Arms" then
            local list = {"LeftHand", "LeftLowerArm", "LeftUpperArm", "RightHand", "RightLowerArm", "RightUpperArm"}
            part = target.Character:FindFirstChild(list[math.random(#list)])
        elseif partName == "Legs" then
            local list = {"LeftFoot", "LeftLowerLeg", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "RightUpperLeg"}
            part = target.Character:FindFirstChild(list[math.random(#list)])
        end
        if not part then closest = nil continue end

        local canSee = true
        if Settings12.silent_aim_wall_check then
            local origin = Camera.CFrame.Position
            local dir = (part.Position - origin).Unit * 1000
            local ray = Ray.new(origin, dir)
            local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character}, false, true)
            canSee = not hit or hit:IsDescendantOf(target.Character)
        end

        if not canSee and Settings12.silent_aim_magic_bullet then
            canSee = true
        end

        if canSee then
            closest = part
            if Settings12.silent_aim_magic_bullet and eq and not blockedTools[eq.Name] then
                mouse1press()
                task.wait(0.05)
                mouse1release()
            elseif Settings12.auto_fire_enabled and eq and not blockedTools[eq.Name] then
                mouse1press()
                task.wait(0.1)
                mouse1release()
            end
            AdjustADSRemote:FireServer(unpack(AdjustADSRemoteArguments))
        else
            closest = nil
        end
    end
end)

-- // Legit-bot
local closest
local findPartOnRayWithIgnoreList = {
    ArgCountRequired = 3,
    Args = {
        "Instance", "Ray", "table", "boolean", "boolean"
    }
}

function getPositionOnScreen(vector)
    local vec3, onScreen = Camera:WorldToScreenPoint(vector)
    return Vector2.new(vec3.X, vec3.Y), onScreen
end

function validateArguments(arguments, rayMethod)
    local matches = 0

    if #arguments < rayMethod.ArgCountRequired then
        return false
    end

    for pos, argument in next, arguments do
        if typeof(argument) == rayMethod.Args[pos] then
            matches = matches + 1
        end
    end

    return matches >= rayMethod.ArgCountRequired
end

function getDirection(origin, position)
    return (position - origin).Unit * 1000
end

function isPlayerVisible(player)
    local PlayerCharacter = player.Character
    local LocalPlayerCharacter = LocalPlayer.Character

    if not (PlayerCharacter or LocalPlayerCharacter) then return 1 end

    local PlayerRoot = PlayerCharacter:FindFirstChild("HumanoidRootPart")

    if not PlayerRoot then return 1 end

    local CastPoints = {PlayerRoot.Position}
    local IgnoreList = {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #Camera:GetPartsObscuringTarget(CastPoints, IgnoreList)

    return ObscuringObjects
end

function getClosestPlayer()
    local closest = nil
    local distanceToMouse = nil

    for _, player in next, Players:GetPlayers() do
        if player == LocalPlayer then continue end
        if player.Team == LocalPlayer.Team then continue end

        local character = player.Character
        if not character then continue end

        if Legit12.Legit_silent_aim_wall_check and isPlayerVisible(player) > 0 then continue end

        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoidRootPart or not humanoid or (humanoid and humanoid.Health <= 0) then continue end

        local screenPosition, onScreen = getPositionOnScreen(humanoidRootPart.Position)
        if not onScreen then continue end

        local mouseLocation = UserInputService:GetMouseLocation()
        local distance = (mouseLocation - screenPosition).Magnitude

        if Legit12.Legit_silent_aim_fov and typeof(Legit12.Legit_silent_aim_fov_radius) == "number" then
            if distance <= Legit12.Legit_silent_aim_fov_radius then
                if not distanceToMouse or distance < distanceToMouse then
                    closest = player
                    distanceToMouse = distance
                end
            end
        else
            if not distanceToMouse or distance < distanceToMouse then
                closest = player
                distanceToMouse = distance
            end
        end
    end

    return closest
end

function calculateChance(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
    return chance <= Percentage / 100
end

task.spawn(function()
    while task.wait() do
        nevm = getClosestPlayer()

        if nevm and nevm.Character then
            local sector = Legit12.Legit_silent_aim_hit_parts[math.random(#Legit12.Legit_silent_aim_hit_parts)]

            if sector == "Head" then
                closest = nevm.Character:FindFirstChild("Head")
            elseif sector == "Torso" then
                local toros = {"UpperTorso", "LowerTorso"}
                closest = nevm.Character:FindFirstChild(toros[math.random(#toros)])
            elseif sector == "Arms" then
                local arms = {"LeftHand", "LeftLowerArm", "LeftUpperArm", "RightHand", "RightLowerArm", "RightUpperArm"}
                closest = nevm.Character:FindFirstChild(arms[math.random(#arms)])
            elseif sector == "Legs" then
                local legs = {"LeftFoot", "LeftLowerLeg", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "RightUpperLeg"}
                closest = nevm.Character:FindFirstChild(legs[math.random(#legs)])  
            end

            if closest then 
                AdjustADSRemote:FireServer(unpack(AdjustADSRemoteArguments))
            end
        else
            closest = nil
        end
    end
end)

local blockedTools = {
    ["Decoy Grenade"] = true,
    ["DefuseKit"] = true,
    ["HE Grenade"] = true,
    ["Smoke Grenade"] = true,
    ["C4"] = true,
}

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if eq and blockedTools[eq.Name] then return end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        silentaimTick = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if eq and blockedTools[eq.Name] then return end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        silentaimTick = false
    end
end)


local __namecall_silent
__namecall_silent = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local arguments = {...}
    local self = arguments[1]

    if self == workspace and not checkcaller() and silentaimTick and Legit12.Legit_silent_aim_hit_chance then
        local canHit = calculateChance(Legit12.Legit_silent_aim_hit_chance)

        if validateArguments(arguments, findPartOnRayWithIgnoreList) and canHit then
            local A_Ray = arguments[2]

            if closest then
                local origin = A_Ray.Origin
                local direction = getDirection(origin, closest.Position)
                arguments[2] = Ray.new(origin, direction)
                return __namecall_silent(unpack(arguments))
            end
            return __namecall_silent(...)
        end
    end

    return __namecall_silent(...)
end))  

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    task.wait(0.125)
    currentCharacter = newCharacter
    currentHRP = newCharacter:WaitForChild("HumanoidRootPart")
    currentHumanoid = newCharacter:WaitForChild("Humanoid")
    currentHumanoid.AutoRotate = false
end)

RunService.Heartbeat:Connect(function()
    if not (currentCharacter and currentHRP) then
        return
    end

    local closestPlayer = getClosestPlayer()
    if not (closestPlayer 
        and closestPlayer.Character 
        and closestPlayer.Character:FindFirstChild("HumanoidRootPart")
        and not PreparationValue.Value) then
        return
    end
end)

RunService.RenderStepped:Connect(function()
	if Legit12.Legit_silent_aim_fov then
		local mousePos = UserInputService:GetMouseLocation()
		fovCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
		fovCircle.Visible = true
	else
		fovCircle.Visible = false
	end
end)
