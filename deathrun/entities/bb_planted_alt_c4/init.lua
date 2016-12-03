AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	self.Owner = self.Entity.Owner

	if !(IsValid(self.Owner)) then
		self:Remove()
		return
	end
	
	self.Entity:SetModel("models/weapons/2_c4_planted.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)

	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end

	self.Used = false

	self:SetDTInt(0, self.Timer)
	self.ThinkTimer = CurTime() + self:GetDTInt(0)
end

/*---------------------------------------------------------
   Name: ENT:Use()
---------------------------------------------------------*/
function ENT:Use(activator, caller)

end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()

	if self.ThinkTimer < CurTime() then
		self:Explosion()
	end

end

/*---------------------------------------------------------
   Name: ENT:Explosion()
---------------------------------------------------------*/
function ENT:Explosion()

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		effectdata:SetRadius(1000)
		effectdata:SetMagnitude(1000)
	util.Effect("HelicopterMegaBomb", effectdata)
	
	local exploeffect = EffectData()
		exploeffect:SetOrigin(self.Entity:GetPos())
		exploeffect:SetStart(self.Entity:GetPos())
	util.Effect("Explosion", exploeffect, true, true)
	
	local effectdata = EffectData()
	effectdata:SetOrigin(self.Entity:GetPos())			// Where is hits
	effectdata:SetNormal(self:Normalizer())		// Direction of particles
	effectdata:SetEntity(self.Entity)		// Who done it?
	effectdata:SetScale(4)			// Size of explosion
	effectdata:SetRadius(67)		// What texture it hits
	effectdata:SetMagnitude(18)			// Length of explosion trails
	util.Effect( "m9k_gdcw_cinematicboom", effectdata )
	--generic default, you are a god among men
	
	util.BlastDamage(self.Entity, (self:OwnerCheck()), self.Entity:GetPos(), 1000, 800)
	
	local shake = ents.Create("env_shake")
		shake:SetOwner(self.Owner)
		shake:SetPos(self.Entity:GetPos())
		shake:SetKeyValue("amplitude", "2000")	// Power of the shake
		shake:SetKeyValue("radius", "1250")		// Radius of the shake
		shake:SetKeyValue("duration", "2.5")	// Time of shake
		shake:SetKeyValue("frequency", "255")	// How har should the screenshake be
		shake:SetKeyValue("spawnflags", "4")	// Spawnflags(In Air)
		shake:Spawn()
		shake:Activate()
		shake:Fire("StartShake", "", 0)
		shake:Fire("Kill", "", 3)
		
	local push = ents.Create("env_physexplosion")
		push:SetOwner(self.Owner)
		push:SetPos(self.Entity:GetPos())
		push:SetKeyValue("magnitude", 100)
		push:SetKeyValue("radius", 1250)
		push:SetKeyValue("spawnflags", 2+16)
		push:Spawn()
		push:Activate()
		push:Fire("Explode", "", 0)
		push:Fire("Kill", "", .25)
		

	self.Entity:EmitSound(Sound("C4.Explode"))

	self.Entity:Remove()

end

function ENT:OwnerCheck()
	if IsValid(self.Owner) then
		return (self.Owner)
	else
		return (self.Entity)
	end
end

function ENT:Normalizer()

--pain in the ass, aint it? at least it works

	local startpos = self.Entity:GetPos()
	
	local downtrace = {}
	downtrace.start = startpos
	downtrace.endpos = startpos + self.Entity:GetUp()*-5
	downtrace.filter = self.Entity
	tracedown = util.TraceLine(downtrace) 
	
	if (tracedown.Hit) then
		return (tracedown.HitNormal)
	else return (Vector(0,0,1))
	end
	
end
