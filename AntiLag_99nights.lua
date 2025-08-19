-- ✅ Anti-Lag Full Script by Ninech007 for 99 Nights in the Forest

local player = game:GetService("Players").LocalPlayer
local lighting = game:GetService("Lighting")
local runService = game:GetService("RunService")

-- 📦 ปรับวัสดุเป็น Plastic, ปิดเงา, ลบเอฟเฟกต์ต่าง ๆ
local function optimize(obj)
	for _, v in ipairs(obj:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.Plastic
			v.Reflectance = 0
			v.CastShadow = false
		elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("SurfaceAppearance") then
			v:Destroy()
		elseif v:IsA("Sound") then
			v.Volume = 0
			v:Stop()
		end
	end
end

optimize(workspace)

workspace.DescendantAdded:Connect(function(obj)
	task.defer(function() optimize(obj) end)
end)

-- 🎒 ลดแลค Tool
local function optimizeTool(tool)
	for _, v in ipairs(tool:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Sound") or v:IsA("Fire") or v:IsA("Smoke") then
			v:Destroy()
		elseif v:IsA("BasePart") then
			v.Material = Enum.Material.Plastic
			v.CastShadow = false
		end
	end
end

player.Backpack.ChildAdded:Connect(function(tool)
	if tool:IsA("Tool") then
		task.wait(0.1)
		optimizeTool(tool)
	end
end)

-- 💡 ลบหน้าจอขาวเวลาใกล้แคมป์ไฟ
lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
	lighting.FogEnd = 1e6
	lighting.FogStart = 999999
	lighting.FogColor = Color3.new(1, 1, 1)
end)

-- 🔄 รีเฟรชสคริปต์ทุก 15 วิ
task.spawn(function()
	while true do
		wait(15)
		optimize(workspace)
		optimizeTool(player.Character or {})
	end
end)

-- 🚀 Preload Map & Object
pcall(function() game:GetService("ContentProvider"):PreloadAsync({workspace}) end)

-- 🖥️ เปิด UI Game ป้องกันหาย
pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)

print("[✅] Ninech007 AntiLag Loaded!")
