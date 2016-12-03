AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()

	self.Owner = self.Entity.Owner
	
	if IsMounted("cstrike") then
		self.Entity:SetModel("models/weapons/w_eq_fraggrenade_thrown.mdl")
	else
		self.Entity:SetModel("models/weapons/w_m61_fraggynade_thrown.mdl")
	end
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	phys:SetMass(6.5)
	end

	self.timeleft = CurTime() + 3 -- HOW LONG BEFORE EXPLOSION
	self:Think()
end

 function ENT:Think()
	
	if self.timeleft < CurTime() then
		self:Explosion()	
	end

	self.Entity:NextThink( CurTime() )
	return true
end

function ENT:Explosion()

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("Explosion", effectdata)

	util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 280, 185)
	
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

	self.Entity:EmitSound("ambient/explosions/explode_" .. math.random(1, 4) .. ".wav", self.Pos, 100, 100 )

	self.Entity:Remove()
end

/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
end


/*---------------------------------------------------------
Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
end


/*---------------------------------------------------------
StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end


/*---------------------------------------------------------
EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end


/*---------------------------------------------------------
Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
end
