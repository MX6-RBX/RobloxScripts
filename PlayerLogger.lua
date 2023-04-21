local FileName = "PlayerLog.txt"
local HTTP = game:GetService("HttpService")

local Player = game.Players.LocalPlayer
local Count = 0
local PlayerData = {}
if isfile(FileName) then
	PlayerData =  HTTP:JSONDecode(readfile(FileName)) 
	Count = #PlayerData
end

local function SaveFile()
	local Json = HTTP:JSONEncode(PlayerData)
	writefile(FileName,Json)
end

function GetPlayerImage(Object)
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420
	local content, isReady = game.Players:GetUserThumbnailAsync(Object, thumbType, thumbSize)
	return content
end

function UnixTime(sec)
	local year = 1970 + math.floor(sec/31557600)
	local day = math.floor((sec/86400)%365.25) + 1
	local month
	local months = {
		{31, 31},
		{(year%4 == 0 and 29 or 28)},
		{31},
		{30},
		{31},
		{30},
		{31},
		{31},
		{30},
		{31},
		{30},
		{31}
	}
	for x = 1, 11 do
		months[x + 1][2] = months[x][2] + months[x + 1][1]
		if not month and months[x + 1][2] >= day then
			month = x + 1
		end
	end
	if not month then
		month = 1
	end
	local m = months[month]
	local day = (day+m[1]-m[2])
	local second = math.floor((sec%60))
	local minute = math.floor((sec/60)%60)
	local hour = math.floor((sec/3600)%24)
	if hour >0 and hour <10 then
		hour = "0"..hour
	elseif hour<= 0 then
		hour = "00"
	end

	if day >0 and day <10 then
		day = "0"..day
	elseif day<= 0 then
		day = "00"
	end
	if month >0 and month <10 then
		month = "0"..month
	elseif month<= 0 then
		month = "00"
	end
	if second >0 and second <10 then
		second = "0"..second
	elseif second<= 0 then
		second = "00"
	end
	if minute >0 and minute <10 then
		minute = "0"..minute
	elseif minute<= 0 then
		minute = "00"
	end
	local Converted = day.."/"..month.."/"..year.." - "..hour..":"..minute..":"..second
	return Converted 
end


local PlayerLog = Instance.new("ScreenGui")
local ListFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Top = Instance.new("TextLabel")
local PlayerList = Instance.new("ScrollingFrame")
local Template = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")
local UICorner_2 = Instance.new("UICorner")
local UICorner_3 = Instance.new("UICorner")
local Display = Instance.new("TextLabel")
local User = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")
local InfoFrame = Instance.new("Frame")
local PlayerImage = Instance.new("ImageLabel")
local UICorner_4 = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local DisplayName = Instance.new("TextLabel")
local UserName = Instance.new("TextLabel")
local UserId = Instance.new("TextLabel")
local AccountAge = Instance.new("TextLabel")
local LastSeen = Instance.new("TextLabel")
local LastGame = Instance.new("TextLabel")
local UICorner_5 = Instance.new("UICorner")
local Notifications = Instance.new("ScrollingFrame")
local UIListLayout_2 = Instance.new("UIListLayout")
local Notification = Instance.new("Frame")
local Top_2 = Instance.new("TextLabel")
local NotiInfoText = Instance.new("TextLabel")
local UICorner_6 = Instance.new("UICorner")

--Properties:

PlayerLog.Name = "PlayerLog"
PlayerLog.Parent = (game:GetService("CoreGui") or gethui())

ListFrame.Name = "ListFrame"
ListFrame.Parent = PlayerLog
ListFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ListFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
ListFrame.Size = UDim2.new(0, 200, 0, 450)
ListFrame.ZIndex = 2

UICorner.Parent = ListFrame

Top.Name = "Top"
Top.Parent = ListFrame
Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Top.BackgroundTransparency = 1.000
Top.Size = UDim2.new(1, 0, 0, 30)
Top.ZIndex = 2
Top.Font = Enum.Font.ArialBold
Top.Text = "Player Log"
Top.TextColor3 = Color3.fromRGB(255, 255, 255)
Top.TextScaled = true
Top.TextSize = 14.000
Top.TextWrapped = true

PlayerList.Name = "PlayerList"
PlayerList.Parent = ListFrame
PlayerList.Active = true
PlayerList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerList.BackgroundTransparency = 1.000
PlayerList.BorderSizePixel = 0
PlayerList.Position = UDim2.new(0, 0, 0, 30)
PlayerList.Size = UDim2.new(1, 0, 1, -30)
PlayerList.ZIndex = 2
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.ScrollBarThickness = 6
PlayerList.AutomaticCanvasSize = Enum.AutomaticSize.Y


Template.Name = "Template"
Template.Parent = PlayerList
Template.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Template.Size = UDim2.new(1, 0, 0, 40)
Template.Visible = false
Template.ZIndex = 2
Template.Font = Enum.Font.SourceSans
Template.Text = ""
Template.TextColor3 = Color3.fromRGB(0, 0, 0)
Template.TextSize = 14.000
Template.TextTransparency = 1.000

ImageLabel.Parent = Template
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Size = UDim2.new(0, 40, 0, 40)
ImageLabel.ZIndex = 2
ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

UICorner_2.Parent = ImageLabel

UICorner_3.Parent = Template

Display.Name = "Display"
Display.Parent = Template
Display.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Display.BackgroundTransparency = 1.000
Display.Position = UDim2.new(0, 40, 0, 0)
Display.Size = UDim2.new(1, -40, 0.5, 0)
Display.ZIndex = 2
Display.Font = Enum.Font.SourceSansBold
Display.TextColor3 = Color3.fromRGB(255, 255, 255)
Display.TextScaled = true
Display.TextSize = 14.000
Display.TextWrapped = true

User.Name = "User"
User.Parent = Template
User.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
User.BackgroundTransparency = 1.000
User.Position = UDim2.new(0, 40, 0, 20)
User.Size = UDim2.new(1, -40, 0.5, 0)
User.ZIndex = 2
User.Font = Enum.Font.SourceSansBold
User.TextColor3 = Color3.fromRGB(255, 255, 255)
User.TextScaled = true
User.TextSize = 14.000
User.TextWrapped = true

UIListLayout.Parent = PlayerList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

UIPadding.Parent = PlayerList
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingLeft = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 3)
UIPadding.PaddingTop = UDim.new(0, 3)

InfoFrame.Name = "InfoFrame"
InfoFrame.Parent = ListFrame
InfoFrame.Active = true
InfoFrame.AnchorPoint = Vector2.new(0, 0.5)
InfoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
InfoFrame.Position = UDim2.new(1, 10, 0.5, 0)
InfoFrame.Size = UDim2.new(0, 250, 0, 380)
InfoFrame.Visible = false

PlayerImage.Name = "PlayerImage"
PlayerImage.Parent = InfoFrame
PlayerImage.AnchorPoint = Vector2.new(0.5, 0)
PlayerImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerImage.Position = UDim2.new(0.5, 0, 0, 10)
PlayerImage.Size = UDim2.new(0, 120, 0, 120)
PlayerImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

UICorner_4.Parent = PlayerImage

UIStroke.Color = Color3.fromRGB(136, 136, 136)
UIStroke.Thickness = 4.000
UIStroke.Parent = PlayerImage

DisplayName.Name = "DisplayName"
DisplayName.Parent = InfoFrame
DisplayName.AnchorPoint = Vector2.new(0.5, 0)
DisplayName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DisplayName.BackgroundTransparency = 1.000
DisplayName.Position = UDim2.new(0.5, 0, 0, 140)
DisplayName.Size = UDim2.new(1, -20, 0, 30)
DisplayName.Font = Enum.Font.SourceSansBold
DisplayName.Text = "Roblox"
DisplayName.TextColor3 = Color3.fromRGB(255, 255, 255)
DisplayName.TextScaled = true
DisplayName.TextSize = 14.000
DisplayName.TextWrapped = true

UserName.Name = "UserName"
UserName.Parent = InfoFrame
UserName.AnchorPoint = Vector2.new(0.5, 0)
UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UserName.BackgroundTransparency = 1.000
UserName.Position = UDim2.new(0.5, 0, 0, 180)
UserName.Size = UDim2.new(1, -20, 0, 30)
UserName.Font = Enum.Font.SourceSansBold
UserName.Text = "Roblox"
UserName.TextColor3 = Color3.fromRGB(255, 255, 255)
UserName.TextScaled = true
UserName.TextSize = 14.000
UserName.TextWrapped = true

UserId.Name = "UserId"
UserId.Parent = InfoFrame
UserId.AnchorPoint = Vector2.new(0.5, 0)
UserId.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UserId.BackgroundTransparency = 1.000
UserId.Position = UDim2.new(0.5, 0, 0, 220)
UserId.Size = UDim2.new(1, -20, 0, 30)
UserId.Font = Enum.Font.SourceSansBold
UserId.Text = "1"
UserId.TextColor3 = Color3.fromRGB(255, 255, 255)
UserId.TextScaled = true
UserId.TextSize = 14.000
UserId.TextWrapped = true

AccountAge.Name = "AccountAge"
AccountAge.Parent = InfoFrame
AccountAge.AnchorPoint = Vector2.new(0.5, 0)
AccountAge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AccountAge.BackgroundTransparency = 1.000
AccountAge.Position = UDim2.new(0.5, 0, 0, 260)
AccountAge.Size = UDim2.new(1, -20, 0, 30)
AccountAge.Font = Enum.Font.SourceSansBold
AccountAge.Text = "1234 days"
AccountAge.TextColor3 = Color3.fromRGB(255, 255, 255)
AccountAge.TextScaled = true
AccountAge.TextSize = 14.000
AccountAge.TextWrapped = true

LastSeen.Name = "LastSeen"
LastSeen.Parent = InfoFrame
LastSeen.AnchorPoint = Vector2.new(0.5, 0)
LastSeen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LastSeen.BackgroundTransparency = 1.000
LastSeen.Position = UDim2.new(0.5, 0, 0, 300)
LastSeen.Size = UDim2.new(1, -20, 0, 30)
LastSeen.Font = Enum.Font.SourceSansBold
LastSeen.Text = "12/12/12 18:13"
LastSeen.TextColor3 = Color3.fromRGB(255, 255, 255)
LastSeen.TextScaled = true
LastSeen.TextSize = 14.000
LastSeen.TextWrapped = true

LastGame.Name = "LastGame"
LastGame.Parent = InfoFrame
LastGame.AnchorPoint = Vector2.new(0.5, 0)
LastGame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LastGame.BackgroundTransparency = 1.000
LastGame.Position = UDim2.new(0.5, 0, 0, 340)
LastGame.Size = UDim2.new(1, -20, 0, 30)
LastGame.Font = Enum.Font.SourceSansBold
LastGame.Text = "Blox burg"
LastGame.TextColor3 = Color3.fromRGB(255, 255, 255)
LastGame.TextScaled = true
LastGame.TextSize = 14.000
LastGame.TextWrapped = true

UICorner_5.Parent = InfoFrame

Notifications.Name = "Notifications"
Notifications.Parent = ListFrame
Notifications.Active = true
Notifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Notifications.BackgroundTransparency = 1.000
Notifications.BorderSizePixel = 0
Notifications.Position = UDim2.new(0.5, 0, 1, 10)
Notifications.Size = UDim2.new(0, 270, 1, -30)
Notifications.ZIndex = 2
Notifications.CanvasSize = UDim2.new(0, 0, 0, 0)
Notifications.ScrollBarThickness = 6
Notifications.AnchorPoint = Vector2.new(0.5,0)

UIListLayout_2.Parent = Notifications
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_2.Padding = UDim.new(0, 5)


Notification.Name = "Notification"
Notification.Parent = ListFrame
Notification.Active = true
Notification.AnchorPoint = Vector2.new(0.5, 0)
Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Notification.BorderSizePixel = 0
Notification.ClipsDescendants = true
Notification.Position = UDim2.new(0.5, 0, 1, 10)
Notification.Size = UDim2.new(0, 0, 0, 60)

Top_2.Name = "Top"
Top_2.Parent = Notification
Top_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Top_2.BackgroundTransparency = 1.000
Top_2.Size = UDim2.new(1, 0, 0.300000012, 0)
Top_2.Font = Enum.Font.SourceSansBold
Top_2.Text = "Player seen before"
Top_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Top_2.TextScaled = true
Top_2.TextSize = 14.000
Top_2.TextWrapped = true

NotiInfoText.Name = "NotiInfoText"
NotiInfoText.Parent = Notification
NotiInfoText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotiInfoText.BackgroundTransparency = 1.000
NotiInfoText.Position = UDim2.new(0, 0, 0.400000006, 0)
NotiInfoText.Size = UDim2.new(1, 0, 0.5, 0)
NotiInfoText.Font = Enum.Font.SourceSansBold
NotiInfoText.Text = "OnlyTwentyCharacters"
NotiInfoText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotiInfoText.TextScaled = true
NotiInfoText.TextSize = 14.000
NotiInfoText.TextWrapped = true

UICorner_6.Parent = Notification

local TrueUserId = Instance.new("IntValue")
TrueUserId.Name = "RealUserId"
TrueUserId.Parent = Template

local function Notify(Info)
	local NotiClone = Notification:Clone()
	NotiClone.Parent = Notifications
	wait(0.1)
	local Tween = game:GetService("TweenService"):Create(NotiClone,TweenInfo.new(.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{Size = UDim2.new(0,250,0,60)})
	NotiClone.NotiInfoText.Text = Info
	Tween:Play()
	wait(5)
	local Tween2 = game:GetService("TweenService"):Create(NotiClone,TweenInfo.new(.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{Size = UDim2.new(0,0,0,60)})
	Tween2:Play()
end

local function ShowInfo(LoadId)
	local LoadData = PlayerData[tostring(LoadId)]
	if LoadData then
		UserId.Text ="UserId: ".. LoadData.UserId
		DisplayName.Text ="@".. LoadData.DisplayName
		UserName.Text = LoadData.UserName
		AccountAge.Text = "Account Age(Days):"..LoadData.AccountAge
		LastSeen.Text = "Last Seen: "..UnixTime(LoadData.LastSeen)
		PlayerImage.Image = GetPlayerImage(LoadData.UserId)
		LastGame.Text ="Game: ".. game:GetService("MarketplaceService"):GetProductInfo(tonumber(LoadData.GameSeen)).Name
		InfoFrame.Visible = true
	end
end

TrueUserId.Value = 0

local function CrateButton(v)
	if PlayerList:FindFirstChild(v.UserId) == nil then
		local Temp = Template:Clone()
		Temp.Name = v.UserId
		Temp.Display.Text = v.DisplayName
		Temp.User.Text = v.UserName
		Temp.ImageLabel.Image = GetPlayerImage(v.UserId)
		Temp.Parent = PlayerList
		Temp.Visible = true
		Temp.LayoutOrder = v.LastSeen
		Temp.MouseButton1Click:Connect(function()
			ShowInfo(v.UserId)
		end)
		Count = Count + 1
		Top.Text = "Player Log "..Count
	end
end

if PlayerData and typeof(PlayerData) == "table" then 
	for i,v in pairs(PlayerData) do
		spawn(function()
			CrateButton(v)
		end)
	end
end

local function AddPlayer(Player)
	if PlayerData[tostring(Player.UserId)] == nil then 
		local Data = {
			UserName = Player.Name,
			DisplayName = Player.DisplayName,
			UserId  = Player.UserId,
			AccountAge = Player.AccountAge,
			LastSeen = os.time(),
			GameSeen = game.PlaceId
		}
		PlayerData[tostring(Player.UserId)] = Data
		SaveFile()
		CrateButton(PlayerData[tostring(Player.UserId)])
	else
		print("Found???")
	end
end

game.Players.ChildAdded:Connect(function(Player)
	AddPlayer(Player)
end)

for i,v in pairs(game.Players:GetChildren()) do
	spawn(function()
		if PlayerData[tostring(v.UserId)] then 
			PlayerData[tostring(v.UserId)].LastSeen = os.time()
			PlayerData[tostring(v.UserId)].GameSeen = game.PlaceId
			Notify(v.Name)
		else
			AddPlayer(v)
		end
	end)
end

