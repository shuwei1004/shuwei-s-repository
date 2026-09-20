--[[ CONFIGURABLE VARIABLES ]]
local BASE_VANISH_TIME = 3         -- Average time laser is active (visible + dangerous)
local BASE_REAPPEAR_TIME = 3       -- Average time laser is inactive (invisible + safe)
local VANISH_VARIANCE = 1          -- Max +/- random variance for vanish time
local REAPPEAR_VARIANCE = 1        -- Max +/- random variance for reappear time
local DAMAGE_AMOUNT = 0.75         -- Amount of health taken away when touched
--[[ END CONFIG ]]

local laser = script.Parent
local active = true

local function getRandomTime(base, variance)
	return base + math.random() * 2 * variance - variance
end

laser.Touched:Connect(function(hit)
	if active and hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
		hit.Parent.Humanoid.Health = DAMAGE_AMOUNT
	end
end)

local function toggleLaser()
	while true do
		-- Laser active (danger!)
		active = true
		laser.Transparency = 0
		laser.CanCollide = true
		wait(getRandomTime(BASE_VANISH_TIME, VANISH_VARIANCE))

		-- Laser inactive (safe)
		active = false
		laser.Transparency = 1
		laser.CanCollide = false
		wait(getRandomTime(BASE_REAPPEAR_TIME, REAPPEAR_VARIANCE))
	end
end

toggleLaser()