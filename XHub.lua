local XHub = Instance.new("ScreenGui")
local Icon = Instance.new("ImageLabel")
local Menu = Instance.new("Frame")
local Drag = Instance.new("UIDragDetector")
local Noclip = Instance.new("TextButton")
local Corner = Instance.new("UICorner")
local TPTool = Instance.new("TextButton")
local Spin = Instance.new("TextButton")
local Float = Instance.new("TextButton")
local Fly = Instance.new("TextButton")
local NoclipFly = Instance.new("TextButton")
local HandUp = Instance.new("TextButton")
local BreakCharacter = Instance.new("TextButton")
local UnselectablePlayer = Instance.new("TextButton")
local Dance = Instance.new("TextButton")
local Explosion = Instance.new("TextButton")
local Btools = Instance.new("TextButton")

XHub.Parent = game.Players.LocalPlayer.PlayerGui

Menu.BackgroundColor3 = Color3.new(0.14902, 0.14902, 0.14902)
Menu.Position = UDim2.new(0.157, 0, 0.17, 0)
Menu.Size = UDim2.new(0.705, 0, 0.62, 0)
Menu.Visible = true
Menu.Parent = XHub
Icon.Size = UDim2.new(0.104, 0, 0.163, 0)
Icon.Position = UDim2.new(0, 0, 0, 0)
Icon.Image = "rbxassetid://77146612"
Icon.BackgroundTransparency = 1
Icon.Parent = Menu
Drag.Parent = Menu

Noclip.Parent = Menu
Noclip.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
Noclip.Position = UDim2.new(0.04, 0, 0.208, 0)
Noclip.Size = UDim2.new(0.215, 0, 0.1, 0)
Noclip.TextColor3 = Color3.new(1, 1, 1)
Noclip.TextSize = 14
Noclip.Text = "Noclip"

Corner.Parent = Noclip

Noclip.MouseButton1Down:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()

	_G.noclip = not _G.noclip
	print(_G.noclip)

	if not character:FindFirstChild("LowerTorso") then
		while _G.noclip do
			game:GetService("RunService").Stepped:wait()
			character.Head.CanCollide = false
			character.Torso.CanCollide = false
		end
	else
		if _G.InitNC ~= true then     
			_G.NCFunc = function(part)      
				local pos = character.LowerTorso.Position.Y  
				if _G.noclip then             
					if part.Position.Y > pos then                 
						part.CanCollide = false             
					end        
				end    
			end      
			_G.InitNC = true 
		end 

		character.Humanoid.Touched:connect(_G.NCFunc) 
	end
end)

TPTool.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
TPTool.Position = UDim2.new(0.279, 0, 0.208, 0)
TPTool.Size = UDim2.new(0.215, 0, 0.1, 0)
TPTool.Text = "TPTool"
TPTool.TextColor3 = Color3.new(1, 1, 1)
TPTool.TextSize = 14
TPTool.Parent = Menu

local Clone = Corner:Clone()

Clone.Parent = TPTool

TPTool.MouseButton1Down:Connect(function()
	local player = game.Players.LocalPlayer
	local Tele = Instance.new("Tool", player.Backpack)
	Tele.RequiresHandle = false
	Tele.Name = "TPTool"
	Tele.ToolTip = "Teleport Tool"

	Tele.Equipped:Connect(function(Mouse)
		Mouse.Button1Down:Connect(function()
			if Mouse.Target then
				player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.x, Mouse.Hit.y + 5, Mouse.Hit.z)
			end
		end)
	end)
end)

Spin.Position = UDim2.new(0.515, 0, 0.208, 0)
Spin.Size = UDim2.new(0.215, 0, 0.1, 0)
Spin.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
Spin.TextSize = 14
Spin.TextColor3 = Color3.new(1, 1, 1)
Spin.Text = "Spin"
Spin.Parent = Menu

local Clone2 = Corner:Clone()

Clone2.Parent = Spin

Spin.MouseButton1Down:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()

	local bodyGyro = Instance.new("BodyGyro", character.HumanoidRootPart)
	bodyGyro.D = 10
	bodyGyro.P = 3000
	bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

	local bodyPosition = Instance.new("BodyPosition", character.HumanoidRootPart)
	bodyPosition.D = 10
	bodyPosition.P = 1000
	bodyPosition.MaxForce = Vector3.new(0, math.huge, 0)
	bodyPosition.Position = character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)

	character.Humanoid.PlatformStand = true

	game:GetService("RunService").RenderStepped:Connect(function()
		if bodyGyro.Parent then
			bodyGyro.CFrame = bodyGyro.CFrame * CFrame.Angles(0, math.rad(50), 0)
		end
	end)
end)

Float.TextSize = 14
Float.TextColor3 = Color3.new(1, 1, 1)
Float.Text = "Float"
Float.Position = UDim2.new(0.754, 0, 0.208, 0)
Float.Size = UDim2.new(0.215, 0, 0.1, 0)
Float.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
Float.Parent = Menu

local Clone3 = Corner:Clone()

Clone3.Parent = Float

Float.MouseButton1Down:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	local bodyPosition = Instance.new("BodyPosition", character.HumanoidRootPart)
	bodyPosition.D = 10
	bodyPosition.P = 1000
	bodyPosition.MaxForce = Vector3.new(0, math.huge, 0)
	bodyPosition.Position = character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)

	humanoid.PlatformStand = false

	local flyUp = false
	local flyDown = false
	local increaseSpeedUp = false
	local increaseSpeedDown = false

	game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.Space and not gameProcessedEvent then
			flyUp = true
			increaseSpeedUp = true
		elseif input.KeyCode == Enum.KeyCode.D and not gameProcessedEvent then
			flyDown = true
			increaseSpeedDown = true
		end
	end)

	game:GetService("UserInputService").InputEnded:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.Space then
			flyUp = false
			increaseSpeedUp = false
		elseif input.KeyCode == Enum.KeyCode.D then
			flyDown = false
			increaseSpeedDown = false
		end
	end)

	game:GetService("RunService").RenderStepped:Connect(function()
		if flyUp then
			local flySpeed = increaseSpeedUp and 50 or 5
			bodyPosition.Position = character.HumanoidRootPart.Position + Vector3.new(0, flySpeed * game:GetService("RunService").RenderStepped:Wait(), 0)
		elseif flyDown then
			local flySpeed = increaseSpeedDown and -50 or -5
			bodyPosition.Position = character.HumanoidRootPart.Position + Vector3.new(0, flySpeed * game:GetService("RunService").RenderStepped:Wait(), 0)
		end
	end)
end)

Fly.TextSize = 14
Fly.TextColor3 = Color3.new(1, 1, 1)
Fly.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
Fly.Text = "Fly"
Fly.Size = UDim2.new(0.215, 0, 0.1, 0)
Fly.Position = UDim2.new(0.04, 0, 0.35, 0)
Fly.Parent = Menu

local Clone4 = Corner:Clone()

Clone4.Parent = Fly

Fly.MouseButton1Down:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	local bodyGyro = Instance.new("BodyGyro", character.HumanoidRootPart)
	bodyGyro.D = 10
	bodyGyro.P = 3000
	bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

	local bodyVelocity = Instance.new("BodyVelocity", character.HumanoidRootPart)
	bodyVelocity.Velocity = Vector3.new(0, 0, 0)
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

	humanoid.PlatformStand = true

	local userInputService = game:GetService("UserInputService")
	local runService = game:GetService("RunService")
	local camera = game.Workspace.CurrentCamera

	local direction = Vector3.new(0, 0, 0)
	local speed = 50

	userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if not gameProcessedEvent then
			if input.KeyCode == Enum.KeyCode.W then
				direction = direction + Vector3.new(0, 0, 1)
			elseif input.KeyCode == Enum.KeyCode.S then
				direction = direction + Vector3.new(0, 0, -1)
			elseif input.KeyCode == Enum.KeyCode.A then
				direction = direction + Vector3.new(-1, 0, 0)
			elseif input.KeyCode == Enum.KeyCode.D then
				direction = direction + Vector3.new(1, 0, 0)
			elseif input.KeyCode == Enum.KeyCode.Space then
				direction = direction + Vector3.new(0, 1, 0)
			elseif input.KeyCode == Enum.KeyCode.LeftControl then
				direction = direction + Vector3.new(0, -1, 0)
			end
		end
	end)

	userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if not gameProcessedEvent then
			if input.KeyCode == Enum.KeyCode.W then
				direction = direction - Vector3.new(0, 0, 1)
			elseif input.KeyCode == Enum.KeyCode.S then
				direction = direction - Vector3.new(0, 0, -1)
			elseif input.KeyCode == Enum.KeyCode.A then
				direction = direction - Vector3.new(-1, 0, 0)
			elseif input.KeyCode == Enum.KeyCode.D then
				direction = direction - Vector3.new(1, 0, 0)
			elseif input.KeyCode == Enum.KeyCode.Space then
				direction = direction - Vector3.new(0, 1, 0)
			elseif input.KeyCode == Enum.KeyCode.LeftControl then
				direction = direction - Vector3.new(0, -1, 0)
			end
		end
	end)

	runService.RenderStepped:Connect(function()
		local camLookVector = camera.CFrame.LookVector
		local camRightVector = camera.CFrame.RightVector
		local camUpVector = camera.CFrame.UpVector
		bodyGyro.CFrame = CFrame.new(bodyGyro.CFrame.Position, bodyGyro.CFrame.Position + camLookVector)
		bodyVelocity.Velocity = (camLookVector * direction.Z + camRightVector * direction.X + camUpVector * direction.Y) * speed
	end)
end)

NoclipFly.Text = "Noclip (Fly)"
NoclipFly.TextSize = 14
NoclipFly.Size = UDim2.new(0.215, 0, 0.1, 0)
NoclipFly.Position = UDim2.new(0.277, 0, 0.35, 0)
NoclipFly.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
NoclipFly.Parent =  Menu
NoclipFly.TextColor3 = Color3.new(1, 1, 1)

local Clone5 = Corner:Clone()

Clone5.Parent = NoclipFly

NoclipFly.MouseButton1Down:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	local bodyGyro = Instance.new("BodyGyro", character.HumanoidRootPart)
	bodyGyro.D = 10
	bodyGyro.P = 3000
	bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

	local bodyVelocity = Instance.new("BodyVelocity", character.HumanoidRootPart)
	bodyVelocity.Velocity = Vector3.new(0, 0, 0)
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

	humanoid.PlatformStand = true

	local userInputService = game:GetService("UserInputService")
	local runService = game:GetService("RunService")
	local camera = game.Workspace.CurrentCamera

	local direction = Vector3.new(0, 0, 0)
	local speed = 50

	local originalCollisions = {}

	local function storeOriginalCollisions()
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				originalCollisions[part] = part.CanCollide
			end
		end

		for _, part in pairs(game.Workspace:GetDescendants()) do
			if part:IsA("BasePart") then
				originalCollisions[part] = part.CanCollide
			end
		end
	end

	local function restoreOriginalCollisions()
		for part, originalCollision in pairs(originalCollisions) do
			if part and part.Parent then
				part.CanCollide = originalCollision
			end
		end
	end

	local function activateNoclip()
		storeOriginalCollisions()

		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end

		for _, part in pairs(game.Workspace:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end

	local function deactivateNoclip()
		restoreOriginalCollisions()

		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end

		for _, part in pairs(game.Workspace:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end

	activateNoclip()

	humanoid.Died:Connect(function()
		restoreOriginalCollisions()
	end)

	player.CharacterAdded:Connect(function(newCharacter)
		character = newCharacter
		originalCollisions = {}
		storeOriginalCollisions()
		activateNoclip()
	end)

	userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if not gameProcessedEvent then
			if input.KeyCode == Enum.KeyCode.W then
				direction = direction + Vector3.new(0, 0, 1)
			elseif input.KeyCode == Enum.KeyCode.S then
				direction = direction + Vector3.new(0, 0, -1)
			elseif input.KeyCode == Enum.KeyCode.A then
				direction = direction + Vector3.new(-1, 0, 0)
			elseif input.KeyCode == Enum.KeyCode.D then
				direction = direction + Vector3.new(1, 0, 0)
			elseif input.KeyCode == Enum.KeyCode.Space then
				direction = direction + Vector3.new(0, 1, 0)
			elseif input.KeyCode == Enum.KeyCode.LeftControl then
				direction = direction + Vector3.new(0, -1, 0)
			end
		end
	end)

	userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if not gameProcessedEvent then
			if input.KeyCode == Enum.KeyCode.W then
				direction = direction - Vector3.new(0, 0, 1)
			elseif input.KeyCode == Enum.KeyCode.S then
				direction = direction - Vector3.new(0, 0, -1)
			elseif input.KeyCode == Enum.KeyCode.A then
				direction = direction - Vector3.new(-1, 0, 0)
			elseif input.KeyCode == Enum.KeyCode.D then
				direction = direction - Vector3.new(1, 0, 0)
			elseif input.KeyCode == Enum.KeyCode.Space then
				direction = direction - Vector3.new(0, 1, 0)
			elseif input.KeyCode == Enum.KeyCode.LeftControl then
				direction = direction - Vector3.new(0, -1, 0)
			end
		end
	end)

	runService.RenderStepped:Connect(function()
		local camLookVector = camera.CFrame.LookVector
		local camRightVector = camera.CFrame.RightVector
		local camUpVector = camera.CFrame.UpVector
		bodyGyro.CFrame = CFrame.new(bodyGyro.CFrame.Position, bodyGyro.CFrame.Position + camLookVector)
		bodyVelocity.Velocity = (camLookVector * direction.Z + camRightVector * direction.X + camUpVector * direction.Y) * speed
	end)
end)

HandUp.TextSize = 14
HandUp.TextColor3 = Color3.new(1, 1, 1)
HandUp.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
HandUp.Text = "Hand Up!"
HandUp.Position = UDim2.new(0.514, 0, 0.35, 0)
HandUp.Size = UDim2.new(0.215, 0, 0.1, 0)
HandUp.Parent = Menu

local Clone6 = Corner:Clone()

Clone6.Parent = HandUp

HandUp.MouseButton1Down:Connect(function()
	local button = script.Parent
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	local function raiseHands()
		local rightArm = character:FindFirstChild("RightUpperArm")
		local leftArm = character:FindFirstChild("LeftUpperArm")
		local rightMotor = rightArm and rightArm:FindFirstChildOfClass("Motor6D")
		local leftMotor = leftArm and leftArm:FindFirstChildOfClass("Motor6D")

		if rightArm and leftArm and rightMotor and leftMotor then
			rightMotor.C0 = rightMotor.C0 * CFrame.Angles(math.rad(180), 0, 0)
			leftMotor.C0 = leftMotor.C0 * CFrame.Angles(math.rad(180), 0, 0)
		end
	end
	raiseHands()
end)

BreakCharacter.TextColor3 = Color3.new(1, 1, 1)
BreakCharacter.TextSize = 14
BreakCharacter.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
BreakCharacter.Position = UDim2.new(0.751, 0, 0.35, 0)
BreakCharacter.Size = UDim2.new(0.215, 0, 0.1, 0)
BreakCharacter.Text = "Break Character"
BreakCharacter.Parent = Menu

local Clone7 = Corner:Clone()

Clone7.Parent = BreakCharacter

BreakCharacter.MouseButton1Down:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local torso = character:WaitForChild("UpperTorso")
	local head = character:WaitForChild("Head")
	local leftArm = character:WaitForChild("LeftUpperArm")
	local rightArm = character:WaitForChild("RightUpperArm")
	local leftLeg = character:WaitForChild("LeftUpperLeg")
	local rightLeg = character:WaitForChild("RightUpperLeg")

	local torsoAngle = 0
	local armAngle = 0
	local legAngle = 0
	local headAngle = 0
	local speed = 0.05
	local frame = 0

	local function animate()
		torsoAngle = math.sin(frame * speed) * math.pi / 4
		armAngle = math.cos(frame * speed) * math.pi / 6
		legAngle = math.sin(frame * speed * 0.8) * math.pi / 8
		headAngle = math.cos(frame * speed * 0.5) * math.pi / 12

		torso.CFrame = torso.CFrame * CFrame.Angles(torsoAngle, 0, 0)
		leftArm.CFrame = leftArm.CFrame * CFrame.Angles(armAngle, 0, 0)
		rightArm.CFrame = rightArm.CFrame * CFrame.Angles(-armAngle, 0, 0)
		leftLeg.CFrame = leftLeg.CFrame * CFrame.Angles(legAngle, 0, 0)
		rightLeg.CFrame = rightLeg.CFrame * CFrame.Angles(-legAngle, 0, 0)
		head.CFrame = head.CFrame * CFrame.Angles(headAngle, 0, 0)

		frame = frame + 1
		if frame >= 754 then
			frame = 0
		end
	end

	local function checkCollision()
		local hit = false
		local characterPosition = character.HumanoidRootPart.Position
		local characterRadius = 5

		for _, part in pairs(workspace:GetChildren()) do
			if part:IsA("Part") and part ~= character then
				local distance = (part.Position - characterPosition).magnitude
				if distance < characterRadius + part.Size.Magnitude / 2 then
					hit = true
					break
				end
			end
		end

		if hit then
			print("Collision detected!")
		end
	end
	
	while true do
		animate()
		checkCollision()
		wait(1/30)
	end
end)

UnselectablePlayer.Text = "Unselectable Player"
UnselectablePlayer.TextSize = 14
UnselectablePlayer.TextColor3 = Color3.new(1, 1, 1)
UnselectablePlayer.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
UnselectablePlayer.Position = UDim2.new(0.04, 0, 0.505, 0)
UnselectablePlayer.Size = UDim2.new(0.215, 0, 0.1, 0)
UnselectablePlayer.Parent = Menu

local Clone8 = Corner:Clone()

Clone8.Parent = UnselectablePlayer

UnselectablePlayer.MouseButton1Down:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()

	local essentialParts = {
		"Humanoid",
		"Head",
		"HumanoidRootPart",
		"UpperTorso",
		"LowerTorso",
		"LeftUpperArm",
		"RightUpperArm",
		"LeftLowerArm",
		"RightLowerArm",
		"LeftHand",
		"RightHand",
		"LeftUpperLeg",
		"RightUpperLeg",
		"LeftLowerLeg",
		"RightLowerLeg",
		"LeftFoot",
		"RightFoot",
		"Animate",
		"StarterCharacterScripts",
		"StarterPlayerScripts",
	}

	local function removeNonEssentialParts()
		for _, part in pairs(character:GetChildren()) do
			if not table.find(essentialParts, part.Name) then
				if part:IsA("BasePart") then
					part:Destroy()
				elseif part:IsA("Script") or part:IsA("LocalScript") or part:IsA("ModuleScript") then
					part:Destroy()
				end
			end
		end
	end
	
	removeNonEssentialParts()
end)

Dance.TextSize = 14
Dance.Text = "Dance"
Dance.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
Dance.TextColor3 = Color3.new(1, 1, 1)
Dance.Position = UDim2.new(0.278, 0, 0.505, 0)
Dance.Size = UDim2.new(0.215, 0, 0.1, 0)
Dance.Parent = Menu

local Clone9 = Corner:Clone()

Clone9.Parent = Dance

Dance.MouseButton1Down:Connect(function()
	local button = script.Parent
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local tweenService = game:GetService("TweenService")

	local function createTween(part, goal, duration, repeatCount)
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, repeatCount, true)
		local tween = tweenService:Create(part, tweenInfo, goal)
		return tween
	end

	local function startDance()
		local rightArm = character:FindFirstChild("RightUpperArm")
		local leftArm = character:FindFirstChild("LeftUpperArm")
		local rightLeg = character:FindFirstChild("RightUpperLeg")
		local leftLeg = character:FindFirstChild("LeftUpperLeg")
		local torso = character:FindFirstChild("UpperTorso")
		local head = character:FindFirstChild("Head")

		local rightArmMotor = rightArm and rightArm:FindFirstChildOfClass("Motor6D")
		local leftArmMotor = leftArm and leftArm:FindFirstChildOfClass("Motor6D")
		local rightLegMotor = rightLeg and rightLeg:FindFirstChildOfClass("Motor6D")
		local leftLegMotor = leftLeg and leftLeg:FindFirstChildOfClass("Motor6D")
		local torsoMotor = torso and torso:FindFirstChildOfClass("Motor6D")
		local headMotor = head and head:FindFirstChildOfClass("Motor6D")

		if rightArmMotor and leftArmMotor and rightLegMotor and leftLegMotor and torsoMotor and headMotor then
			local rightArmTween = createTween(rightArmMotor, {C0 = rightArmMotor.C0 * CFrame.Angles(math.rad(45), 0, 0)}, 1, -1)
			local leftArmTween = createTween(leftArmMotor, {C0 = leftArmMotor.C0 * CFrame.Angles(math.rad(-45), 0, 0)}, 1, -1)
			local rightLegTween = createTween(rightLegMotor, {C0 = rightLegMotor.C0 * CFrame.Angles(math.rad(-45), 0, 0)}, 1, -1)
			local leftLegTween = createTween(leftLegMotor, {C0 = leftLegMotor.C0 * CFrame.Angles(math.rad(45), 0, 0)}, 1, -1)
			local torsoTween = createTween(torsoMotor, {C0 = torsoMotor.C0 * CFrame.Angles(0, 0, math.rad(45))}, 1, -1)
			local headTween = createTween(headMotor, {C0 = headMotor.C0 * CFrame.Angles(math.rad(30), 0, 0)}, 1, -1)

			rightArmTween:Play()
			leftArmTween:Play()
			rightLegTween:Play()
			leftLegTween:Play()
			torsoTween:Play()
			headTween:Play()

			rightArmTween.Completed:Connect(function()
				createTween(rightArmMotor, {C0 = rightArmMotor.C0 * CFrame.Angles(math.rad(-45), 0, 0)}, 1, -1):Play()
			end)
			leftArmTween.Completed:Connect(function()
				createTween(leftArmMotor, {C0 = leftArmMotor.C0 * CFrame.Angles(math.rad(45), 0, 0)}, 1, -1):Play()
			end)
			rightLegTween.Completed:Connect(function()
				createTween(rightLegMotor, {C0 = rightLegMotor.C0 * CFrame.Angles(math.rad(45), 0, 0)}, 1, -1):Play()
			end)
			leftLegTween.Completed:Connect(function()
				createTween(leftLegMotor, {C0 = leftLegMotor.C0 * CFrame.Angles(math.rad(-45), 0, 0)}, 1, -1):Play()
			end)
			torsoTween.Completed:Connect(function()
				createTween(torsoMotor, {C0 = torsoMotor.C0 * CFrame.Angles(0, 0, math.rad(-45))}, 1, -1):Play()
			end)
			headTween.Completed:Connect(function()
				createTween(headMotor, {C0 = headMotor.C0 * CFrame.Angles(math.rad(-30), 0, 0)}, 1, -1):Play()
			end)
		end
	end
	
	startDance()
	
end)

Explosion.Text = "Explosion"
Explosion.TextSize = 14
Explosion.TextColor3 = Color3.new(1, 1, 1)
Explosion.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
Explosion.Position = UDim2.new(0.514, 0, 0.505, 0)
Explosion.Size = UDim2.new(0.215, 0, 0.1, 0)
Explosion.Parent = Menu

local Clone10 = Corner:Clone()

Clone10.Parent = Explosion

Explosion.MouseButton1Down:Connect(function()
	local Players = game:GetService("Players")
	local Button = script.Parent

	local function addExplosion(player)
		local character = player.Character
		if character then
			local explosion = Instance.new("Explosion")
			explosion.BlastPressure = 100000000
			explosion.BlastRadius = 50
			explosion.Position = character.HumanoidRootPart.Position
			explosion.Parent = character
			explosion.ExplosionType = Enum.ExplosionType.NoCraters
			explosion.DestroyJointRadiusPercent = 1
		end
	end
	
	local player = Players.LocalPlayer
	if player then
		addExplosion(player)
	end
	
end)

Btools.Text = "Btools"
Btools.TextSize = 14
Btools.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
Btools.TextColor3 =  Color3.new(1, 1, 1)
Btools.Position = UDim2.new(0.753, 0, 0.505, 0)
Btools.Size = UDim2.new(0.215, 0, 0.1, 0)
Btools.Parent = Menu

local Clone11 = Corner:Clone()

Clone11.Parent = Btools

Btools.MouseButton1Down:Connect(function()
	local Players = game:GetService("Players")

	local function createHopperBin(binName, binType, parent)
		local hopperBin = Instance.new("HopperBin")
		hopperBin.Name = binName
		hopperBin.BinType = binType
		hopperBin.Parent = parent
		return hopperBin
	end

	local function addItemToBackpack(player)
		local Backpack = player:WaitForChild("Backpack")

		createHopperBin("Hammer", Enum.BinType.Hammer, Backpack)
		createHopperBin("Clone Tool", Enum.BinType.Clone, Backpack)
	end

	local player = Players.LocalPlayer
	if player then
		addItemToBackpack(player)
	end

end)