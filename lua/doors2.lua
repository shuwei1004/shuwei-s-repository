local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
getgenv().SecureMode = true

local Window = Rayfield:CreateWindow({
	Name = "Doors - 外挂脚本",
	LoadingTitle = "Doors - 外挂脚本",
	LoadingSubtitle = "此脚本为英翻中脚本",
})
local Tab = Window:CreateTab("主要界面")
local Section = Tab:CreateSection("Doors 主要界面")
local Label = Tab:CreateLabel("感谢使用此整合脚本!")
local TabUtil = Window:CreateTab("實用界面")
local SectionUtil = TabUtil:CreateSection("Doors 實用界面")
local LabelUtil = TabUtil:CreateLabel("感谢使用此整合脚本!")

local Button = Tab:CreateButton({
	Name = "OminousVibes hub (新版本推薦)",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/OminousVibes-Exploit/Scripts/main/doors/loadstring.lua"))()

	end,
})
local Button = Tab:CreateButton({
	Name = "Vynixius Hub (最推薦)",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Doors/Script.lua"))()
	end,
})
local Button = Tab:CreateButton({
	Name = "Infinite Yield Hub (新加入!)",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end,
})
local Button = Tab:CreateButton({
	Name = "Ominoux Hub",
	Callback = function()
loadstring(game:HttpGet(('https://pastebin.com/raw/9QPGnLx6'),true))()

	end,
})
local Button = Tab:CreateButton({
	Name = "Neverlose Hub",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaQLeak/neverlose.xyz/main/Doors.lua"))()
	end,
})
local Button = Tab:CreateButton({
	Name = "Darkrai Hub (安卓專用)",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Darkrai-X/main/Games/Doors"))()
	end,
})
local Button = Tab:CreateButton({
	Name = "Crimson Hub (需要代码)",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/toosiwhip/statue/main/crimsonhub-statue.lua"))()
	end,
})
local Button = TabUtil:CreateButton({
	Name = "获得十字架",
	Callback = function()
		local Item = game:GetObjects("rbxassetid://11583101826")[1]
Item.Parent = game.Players.LocalPlayer.Backpack

	end,
})
local Button = TabUtil:CreateButton({
	Name = "實體生成腳本 (會關閉其他腳本!)",
	Callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/plamen6789/DoorsEntitySummonerGUI/main/EntityGUI'))()
	end,
})