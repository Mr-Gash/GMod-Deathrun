include("shared.lua")

/*---------------------------------------------------------
   Name: ENT:Draw()
---------------------------------------------------------*/
function ENT:Draw()


	self.Entity:DrawModel()
	
	green = Color(45, 175, 45, 255)
	red = Color(230, 45, 45, 255)

 	TargetPos1 = self.Entity:GetPos() + (self.Entity:GetUp() * 9) + (self.Entity:GetRight() * 2.5) + (self.Entity:GetForward() * 1.5)
	TargetPos2 = self.Entity:GetPos() + (self.Entity:GetUp() * 8.1) + (self.Entity:GetRight() * 3.75) + (self.Entity:GetForward() * 1.5)

	FixAngles = self.Entity:GetAngles()
	
	TargetPos = TargetPos2
	ledcolor = red
	FixRotation = Vector(0, 180, 0)

	FixAngles:RotateAroundAxis(FixAngles:Right(), FixRotation.x)
	FixAngles:RotateAroundAxis(FixAngles:Up(), FixRotation.y)
	FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)

	local m, s = self:FormatTime(self.C4CountDown)

	self.Text = string.format("%02d", m) .. ":" .. string.format("%02d", s)
	
	cam.Start3D2D(TargetPos, FixAngles, .07)
		draw.SimpleText(self.Text, "CloseCaption_Normal", 31, -22, ledcolor, 1, 1)
	cam.End3D2D() 
end

/*---------------------------------------------------------
   Name: ENT:FormatTime()
---------------------------------------------------------*/
function ENT:FormatTime(seconds)

	local m = seconds % 604800 % 86400 % 3600 / 60
	local s = seconds % 604800 % 86400 % 3600 % 60

	return math.floor(m), math.floor(s)
end
