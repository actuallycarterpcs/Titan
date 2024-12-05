local Titan = Instance.new("ScreenGui")
local TransformButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local UIScale = Instance.new("UIScale")

local Watermark = Instance.new("TextLabel")
local Watermark_2 = Instance.new("TextLabel")
local Watermark_3 = Instance.new("TextLabel")

Titan.Name = "Titan"
Titan.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Titan.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

UIScale.Parent = Titan
UIScale.Scale = 1

TransformButton.Name = "TransformButton"
TransformButton.Parent = Titan
TransformButton.BackgroundColor3 = Color3.new(1, 1, 1)
TransformButton.BorderColor3 = Color3.new(0, 0, 0)
TransformButton.BorderSizePixel = 0
TransformButton.AnchorPoint = Vector2.new(0, 0.5)
TransformButton.Position = UDim2.new(0, 10, 0.5, 0)
TransformButton.Size = UDim2.new(0, 150, 0, 36)
TransformButton.Image = "rbxassetid://18467291142"

UICorner.Parent = TransformButton

Watermark.Name = "Watermark"
Watermark.Parent = TransformButton
Watermark.BackgroundColor3 = Color3.new(1, 1, 1)
Watermark.BackgroundTransparency = 1
Watermark.Size = UDim2.new(1, 0, 1, 0)
Watermark.Font = Enum.Font.SourceSans
Watermark.Text = "T"
Watermark.TextColor3 = Color3.new(1, 0, 0)
Watermark.TextScaled = true
Watermark.TextSize = 14
Watermark.TextWrapped = true

Watermark_2.Name = "Watermark_2"
Watermark_2.Parent = Watermark
Watermark_2.BackgroundColor3 = Color3.new(1, 1, 1)
Watermark_2.BackgroundTransparency = 1
Watermark_2.Size = UDim2.new(1, 0, 0.5, 0)
Watermark_2.Position = UDim2.new(0, 0, 0.25, 0)
Watermark_2.Font = Enum.Font.SourceSans
Watermark_2.Text = "itan"
Watermark_2.TextColor3 = Color3.new(1, 1, 1)
Watermark_2.TextScaled = true
Watermark_2.TextSize = 14
Watermark_2.TextWrapped = true

Watermark_3.Name = "Watermark_3"
Watermark_3.Parent = Watermark
Watermark_3.BackgroundColor3 = Color3.new(1, 1, 1)
Watermark_3.BackgroundTransparency = 1
Watermark_3.Size = UDim2.new(1, 0, 0.25, 0)
Watermark_3.Position = UDim2.new(0, 0, 0.75, 0)
Watermark_3.Font = Enum.Font.SourceSans
Watermark_3.Text = "Transform"
Watermark_3.TextColor3 = Color3.new(1, 1, 1)
Watermark_3.TextScaled = true
Watermark_3.TextSize = 14
Watermark_3.TextWrapped = true

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		UIScale.Scale = math.clamp(1 / (workspace.CurrentCamera.ViewportSize.Y / 1080), 0.5, 1.5)
	end
end)

TransformButton.MouseButton1Click:Connect(function()
	local player = game:GetService("Players").LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local scaleMultiplier = 4
	local growthSpeed = 0.6

	if humanoidRootPart and humanoid then
		local originalWalkSpeed = humanoid.WalkSpeed
		local originalJumpPower = humanoid.JumpPower

		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 0

		local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator")
		local transformAnimation = Instance.new("Animation")
		transformAnimation.AnimationId = "rbxassetid://84658785560842"
		local animationTrack = animator:LoadAnimation(transformAnimation)
		animationTrack:Play()

		local torsoParts = {}
		if humanoid.RigType == Enum.HumanoidRigType.R6 then
			table.insert(torsoParts, character:FindFirstChild("Torso"))
		elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
			table.insert(torsoParts, character:FindFirstChild("UpperTorso"))
			table.insert(torsoParts, character:FindFirstChild("LowerTorso"))
		end

		local particleEmitters = {}

		for i = 1, 4 do
			local particleEmitter = Instance.new("ParticleEmitter")
			particleEmitter.Texture = "rbxassetid://867619398"
			particleEmitter.Lifetime = NumberRange.new(0.25)
			particleEmitter.Rate = 40
			particleEmitter.Size = NumberSequence.new(40)
			particleEmitter.ZOffset = 1.75
			particleEmitter.LightEmission = 1
			particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255))
			particleEmitter.EmissionDirection = Enum.NormalId.Top
			particleEmitter.Parent = humanoidRootPart
			table.insert(particleEmitters, particleEmitter)
		end

		for i = 1, 10 do
			local particleEmitter = Instance.new("ParticleEmitter")
			particleEmitter.Texture = "rbxassetid://278520320"
			particleEmitter.Lifetime = NumberRange.new(0.1)
			particleEmitter.Rate = 300
			particleEmitter.Rotation = NumberRange.new(-360, 360)
			particleEmitter.RotSpeed = NumberRange.new(30, 30)
			particleEmitter.Speed = NumberRange.new(8)
			particleEmitter.SpreadAngle = Vector2.new(200, 200)
			particleEmitter.EmissionDirection = Enum.NormalId.Top
			particleEmitter.Size = NumberSequence.new(40)
			particleEmitter.ZOffset = 1
			particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255))
			particleEmitter.Parent = humanoidRootPart
			table.insert(particleEmitters, particleEmitter)
		end

		task.wait(1)

		local currentScale = 1
		while currentScale < scaleMultiplier do
			local step = math.min(growthSpeed, scaleMultiplier - currentScale)
			currentScale = currentScale + step

			local particleSize = currentScale * 6
			for _, emitter in ipairs(particleEmitters) do
				emitter.Size = NumberSequence.new(particleSize)
			end

			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
					part.Size = part.Size * (1 + step)
					part.Position = humanoidRootPart.Position + (part.Position - humanoidRootPart.Position) * (1 + step)
				end
			end

			for _, accessory in ipairs(character:GetChildren()) do
				if accessory:IsA("Accessory") and accessory:FindFirstChild("Handle") then
					local handle = accessory.Handle
					handle.Size = handle.Size * (1 + step)

					for _, attachment in ipairs(handle:GetChildren()) do
						if attachment:IsA("Attachment") then
							attachment.Position = attachment.Position * (1 + step)
						end
					end

					handle.CFrame = humanoidRootPart.CFrame * humanoidRootPart.CFrame:ToObjectSpace(handle.CFrame)
				end
			end

			if humanoid then
				humanoid.HipHeight = humanoid.HipHeight * (1 + step)
			end

			humanoidRootPart.Size = humanoidRootPart.Size * (1 + step)

			task.wait(0)
		end

		task.wait(0.5)
		for _, emitter in ipairs(particleEmitters) do
			emitter.Enabled = false
			emitter:Destroy()
		end

		animationTrack:Stop()

		humanoid.WalkSpeed = originalWalkSpeed
		humanoid.JumpPower = originalJumpPower
	end
end)
