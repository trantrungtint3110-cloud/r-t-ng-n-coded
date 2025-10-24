local ScreenGui = Instance.new("ScreenGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = game.CoreGui

local BlackCover = Instance.new("Frame")
BlackCover.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlackCover.BorderSizePixel = 0
BlackCover.Size = UDim2.new(1, 0, 1, 0)
BlackCover.Position = UDim2.new(0, 0, 0, 0)
BlackCover.ZIndex = 999999
BlackCover.Parent = ScreenGui

local MainText = Instance.new("TextLabel")
MainText.Text = "có làm thì mới có ăn"
MainText.TextColor3 = Color3.fromRGB(255, 255, 255)
MainText.BackgroundTransparency = 1
MainText.Font = Enum.Font.GothamBold
MainText.TextScaled = true
MainText.AnchorPoint = Vector2.new(0.5, 0.5)
MainText.Position = UDim2.new(0.5, 0, 0.45, 0)
MainText.Size = UDim2.new(0.9, 0, 0.2, 0)
MainText.ZIndex = 1000000
MainText.Parent = BlackCover

local SubText = Instance.new("TextLabel")
SubText.Text = "-By Hong_Ty-"
SubText.TextColor3 = Color3.fromRGB(255, 255, 255)
SubText.BackgroundTransparency = 1
SubText.Font = Enum.Font.Gotham
SubText.TextScaled = true
SubText.AnchorPoint = Vector2.new(0.5, 0.5)
SubText.Position = UDim2.new(0.5, 0, 0.57, 0)
SubText.Size = UDim2.new(0.4, 0, 0.1, 0)
SubText.ZIndex = 1000000
SubText.Parent = BlackCover

task.spawn(function()
	while true do
		for i = 0, 0.5, 0.05 do
			MainText.TextTransparency = i
			SubText.TextTransparency = i
			local colorValue = 255 - (i * 255 * 2)
			BlackCover.BackgroundColor3 = Color3.fromRGB(colorValue, colorValue, colorValue)
			wait(0.05)
		end
		for i = 0.5, 0, -0.05 do
			MainText.TextTransparency = i
			SubText.TextTransparency = i
			local colorValue = 255 - (i * 255 * 2)
			BlackCover.BackgroundColor3 = Color3.fromRGB(colorValue, colorValue, colorValue)
			wait(0.05)
		end
	end
end)
