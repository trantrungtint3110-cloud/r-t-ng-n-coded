local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.Parent = guiParent

local label = Instance.new("TextLabel")
label.Parent = sg
label.AnchorPoint = Vector2.new(0.5,0.5)
label.BackgroundTransparency = 1
label.Text = "DVD"
label.TextScaled = false
label.Font = Enum.Font.GothamBold
label.TextStrokeTransparency = 0.4
label.Size = UDim2.new(0,200,0,80)
label.Position = UDim2.new(0.5,0,0.5,0)
label.TextColor3 = Color3.fromHSV(0,0.85,0.85)
label.TextSize = 48
label.ZIndex = 2

local particles = {}
local function spawnFireworks(px,py)
	local count = 60
	for i=1,count do
		local f = Instance.new("Frame")
		f.Size = UDim2.new(0,6 + math.random()*6,0,6 + math.random()*6)
		f.AnchorPoint = Vector2.new(0.5,0.5)
		f.Position = UDim2.new(0,px,0,py)
		f.BackgroundColor3 = Color3.fromHSV(math.random(),0.85,0.85)
		f.BorderSizePixel = 0
		f.ZIndex = 1
		local uc = Instance.new("UICorner", f)
		uc.CornerRadius = UDim.new(1,0)
		f.Parent = sg
		local angle = math.random()*math.pi*2
		local speed = 2 + math.random()*6
		table.insert(particles, {obj=f,x=px,y=py,vx=math.cos(angle)*speed,vy=math.sin(angle)*speed,age=0,life=40 + math.random()*40})
	end
end

local s = Instance.new("Sound")
s.SoundId = "rbxassetid://SOUND_ID"
s.Volume = 1
s.Parent = SoundService

local vw = workspace.CurrentCamera.ViewportSize
local w = vw.X
local h = vw.Y

local fontScale = math.floor(math.min(w,h) * 0.12)
label.TextSize = fontScale
label.Size = UDim2.new(0,fontScale*3,0,fontScale)

local tw = function()
	local abs = label.AbsoluteSize
	return abs.X, abs.Y
end

local x = math.random()*(w-200)+100
local y = math.random()*(h-200)+100
local vx = (math.random()*2 + 2) * (math.random() < 0.5 and -1 or 1)
local vy = (math.random()*2 + 2) * (math.random() < 0.5 and -1 or 1)

local hueIndex = 0
local hues = {0/360,30/360,60/360,120/360,180/360,240/360,270/360}
local hueTimer = 0
local hueDelay = 10

RunService.RenderStepped:Connect(function(dt)
	vw = workspace.CurrentCamera.ViewportSize
	w = vw.X
	h = vw.Y
	label.TextSize = math.floor(math.min(w,h) * 0.12)
	label.Size = UDim2.new(0,label.TextSize*3,0,label.TextSize)

	hueTimer = hueTimer + 1
	if hueTimer >= hueDelay then
		hueTimer = 0
		hueIndex = (hueIndex % #hues) + 1
	end
	local hue = hues[hueIndex]
	label.TextColor3 = Color3.fromHSV(hue,0.85,0.85)

	local speedFactor = math.clamp(dt/(1/60),0.5,3)
	x = x + vx * speedFactor
	y = y + vy * speedFactor

	local twx,twy = tw()
	local halfW = twx/2
	local halfH = twy/2

	local atLeft = x - halfW <= 0
	local atRight = x + halfW >= w
	local atTop = y - halfH <= 0
	local atBottom = y + halfH >= h

	local corner = (atLeft and atTop) or (atLeft and atBottom) or (atRight and atTop) or (atRight and atBottom)

	if corner then
		if math.random() < 0.05 then
			if atLeft then x = halfW else x = w - halfW end
			if atTop then y = halfH else y = h - halfH end
			vx = -vx
			vy = -vy
			spawnFireworks(x,y)
			pcall(function() s:Play() end)
		else
			if math.random() < 0.5 then
				vx = -vx
				if atLeft then x = halfW + 2 else x = w - halfW - 2 end
			else
				vy = -vy
				if atTop then y = halfH + 2 else y = h - halfH - 2 end
			end
		end
	else
		if atLeft then x = halfW; vx = -vx end
		if atRight then x = w - halfW; vx = -vx end
		if atTop then y = halfH; vy = -vy end
		if atBottom then y = h - halfH; vy = -vy end
	end

	label.Position = UDim2.new(0, x, 0, y)

	for i = #particles,1,-1 do
		local p = particles[i]
		p.age = p.age + 1
		p.vy = p.vy + 0.12
		p.vx = p.vx * 0.99
		p.vy = p.vy * 0.99
		p.x = p.x + p.vx
		p.y = p.y + p.vy
		if p.obj and p.obj.Parent then
			p.obj.Position = UDim2.new(0, p.x, 0, p.y)
			local a = 1 - p.age / p.life
			p.obj.BackgroundTransparency = 1 - a
		end
		if p.age > p.life then
			if p.obj then p.obj:Destroy() end
			table.remove(particles, i)
		end
	end
end)
