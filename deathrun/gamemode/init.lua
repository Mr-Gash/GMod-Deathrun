CreateConVar( "dr_roundtime_seconds", "360" )

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "cl_voice.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_frames.lua" )
AddCSLuaFile( "menutext.lua" )

AddCSLuaFile( "rtv/config.lua" )
AddCSLuaFile( "rtv/cl_rtv.lua" )

include( "shared.lua" )
include( "sv_round.lua" )
include( "sv_weps.lua" )

include( "rtv/config.lua" )
include( "rtv/sv_rtv.lua" )

-- include( "cl_init.lua" ) 
-- Used to be required for autorefresh, guess it isn't anymore.

local highlight = CreateConVar( "dr_highlight_admins", "1", FCVAR_ARCHIVE )
local rounds = CreateConVar( "dr_total_rounds", "10", FCVAR_ARCHIVE )
local suicide = CreateConVar( "dr_allow_death_suicide", "0", FCVAR_ARCHIVE )
local bhop = CreateConVar( "dr_allow_autojump", "1", FCVAR_ARCHIVE )
local uammo = CreateConVar( "dr_unlimited_ammo", "1", FCVAR_ARCHIVE )
local pickup = CreateConVar( "dr_allow_death_pickup", "0", FCVAR_ARCHIVE )
local falldamage = CreateConVar( "dr_realistic_fall_damage", "1", FCVAR_ARCHIVE )
local push = CreateConVar( "dr_push_collide", "0", FCVAR_ARCHIVE )

util.AddNetworkString( "Deathrun_Func" )
local meta = FindMetaTable( "Player" )
gameevent.Listen("player_connect")
gameevent.Listen("player_disconnect")

local rModels = {}
for i = 1, 8 do
	rModels[#rModels+1] = "models/player/group01/male_0"..i..".mdl"
end

function GM:PlayerSpawn( ply )

	ply._HasPressedKey = false

	if ply:Team() == TEAM_SPECTATOR then
		ply:Spectate(OBS_MODE_ROAMING)
		return
	end

	self.BaseClass:PlayerSpawn( ply )

	ply:SetHealth(ply:GetMaxHealth())
	ply:StripWeapons()
	ply:StripAmmo()
	ply:SetWalkSpeed(260)
	ply:SetRunSpeed(300)
	ply:AllowFlashlight(true)
	ply:SetArmor(0)
	
	ply:SetupHands()

	ply:SetJumpPower(190)

	local col = team.GetColor( ply:Team() )

	ply:SetPlayerColor( Vector( col.r/255, col.g/255, col.b/255 ) )

	local spawns = ents.FindByClass( ply:Team() == TEAM_RUNNER and "info_player_counterterrorist" or "info_player_terrorist" )

	if #spawns > 0 then
		local pos = table.Random( spawns ):GetPos()
		ply:SetPos( pos )

		timer.Simple( 1, function()
			if (IsValid(ply) and ply:Alive() and pos) then
				ply:SetPos( pos )
			end
		end )
	end

	ply:SetNoCollideWithTeammates( true )
	ply:SetAvoidPlayers( push:GetInt() == 1 and true or false )

	local mdl = hook.Call( "ChangePlayerModel", GAMEMODE, ply ) or false
	
	ply:SetModel( mdl or table.Random( rModels ) )

end

function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

function GM:NotifyAll( str )
	--PrintMessage( HUD_PRINTCENTER, str )
	--PrintMessage( HUD_PRINTCONSOLE, "Deathrun: "..str )
	self:Deathrun_Func( nil, "Notify", str )
end

function meta:Notify( str )
	GAMEMODE:Deathrun_Func( self, "Notify", str )
end

function Notify( str )
	return GAMEMODE:NotifyAll( str )
end

function GM:Deathrun_Func( ply, str, ... )

	if not (str) then MsgN( "Invalid Deathrun_Func" ) return end

	net.Start( "Deathrun_Func" )
		net.WriteString( str )
		net.WriteTable( {...} )
	if IsValid(ply) then net.Send( ply ) else net.Broadcast() end

end

local WMeta = FindMetaTable( "Weapon" )
local oldTake = WMeta.TakePrimaryAmmo

function WMeta:TakePrimaryAmmo( num )
	if uammo:GetInt() == 1 then return end
	return oldTake( self, num )
end

function meta:AltDropWeapon( wep )

	local class = wep:GetClass()
	local ammo = wep.Clip1 and wep:Clip1() or 0

	if self:HasWeapon( class ) then

		self:StripWeapon( class )

		local ent = ents.Create( class )
		if not IsValid(ent) then return end

		ent:SetPos( self:GetPos() + Vector( 0, 0, 50 ) )
		ent:SetAngles( self:GetAngles() )

		ent.JCanPickup = { player = self, time = CurTime() + 2 }

		ent:Spawn()

		if ent.SetClip1 then
			ent:SetClip1( ammo )
		end

		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			phys:SetVelocity( self:GetVelocity() + self:GetAimVector()*300 )
		end

		self:SelectWeapon( "weapon_crowbar" )

	end

end

local callbacks = {}
local callbackv = {}
local function ConVarCallback( name, func ) -- cvars.AddChangeCallback doesn't seem to want to work; no idea why. 
	callbacks[name] = func
end

function GM:ConVarThink()
	for k, v in pairs( callbacks ) do
		local s = GetConVarString( k )
		if not callbackv[k] then
			callbackv[k] = s
			continue
		else
			local ov = callbackv[k]
			if ov != s then
				v( k, ov, s )
				callbackv[k] = s
			end
		end
	end
end

local random = math.random

function GM:Tick()

	for k, v in pairs( player.GetAll() ) do

		if v:Alive() and v:WaterLevel() >= 3 then

			if not v._DrownTime then
				v._DrownTime = RealTime() + 10
				continue
			elseif v._DrownTime <= RealTime() then

				local dmg = DamageInfo()
				dmg:SetDamageType(DMG_DROWN)
				dmg:SetDamage( 15 )
				dmg:SetAttacker(game.GetWorld())
				dmg:SetInflictor(game.GetWorld())
				dmg:SetDamageForce( Vector( random(-5,5), random(-2,3), random(-10,9) ) )

				v:TakeDamageInfo(dmg)
				v._DrownTime = RealTime() + 3

			end

		else
			v._DrownTime = nil
		end

	end

end

function GM:EntityTakeDamage( vict, dmginfo )

	local atk  = dmginfo:GetAttacker()

	if IsValid(atk) and atk:IsPlayer() and vict:IsPlayer() and vict:Team() == atk:Team() then
		dmginfo:ScaleDamage(0)
	end

end

function GM:CanPlayerSuicide( ply )

	if not ply:Alive() then return false end
	if ply:Team() == TEAM_DEATH and suicide:GetInt() == 0 then return false end
	if self:GetRound() == ROUND_PREPARING then return false end

	return self.BaseClass:CanPlayerSuicide( ply )
end

function GM:PlayerCanPickupWeapon( ply, wep )

	if not ply:Alive() then return false end

	local Active = ply:GetActiveWeapon()

	if IsValid(Active) then
		Active = Active:GetClass()
		if Active == "weapon_physgun" then return false end
		if Active == "weapon_placer" then return false end
	end


	if ply:HasWeapon( wep:GetClass() ) then return false end
	if ply:Team() == TEAM_DEATH then
		if wep:GetClass() != "weapon_crowbar" and pickup:GetInt() == 0 then
			return false
		end
	end

	local pickup = wep.JCanPickup

	if pickup and pickup.player and pickup.player == ply then
		if pickup.time and pickup.time >= CurTime() then
			return false
		else
			wep.JCanPickup = nil
		end
	elseif pickup then
		wep.JCanPickup = nil
	end

	if wep.Primary and wep.Primary.Ammo and wep.Primary.Ammo != "none" then
		ply:GiveAmmo( 1000000, wep.Primary.Ammo, true )
	end

	return true

end

function GM:PlayerCanHearPlayersVoice( listen, talker )
	return true
end

concommand.Add( "_dr_req_drop", function( ply )

	if not ply:Alive() then return end

	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) then return end
	if wep:GetClass() == "weapon_crowbar" then return end

	ply:AltDropWeapon( wep )

end )

function GM:ShowHelp( ply )

	self:Deathrun_Func( ply, "F1" )

end

local connecting = {}

hook.Add( "player_connect", "Add Connecting Players", function(d)

	connecting[d.networkid] = d.name
	GAMEMODE:Deathrun_Func( nil, "Connecting_Player", d.name, d.networkid )

end )

hook.Add( "player_disconnect", "Remove Connecting Player", function( d )

	connecting[d.networkid] = nil
	GAMEMODE:Deathrun_Func( nil, "Remove_CPlayer", d.networkid )

end )

hook.Add( "PlayerInitialSpawn", "Remove Connecting Player", function( ply )
	
	local id = ply:SteamID()
	connecting[id] = nil
	GAMEMODE:Deathrun_Func( nil, "Remove_CPlayer", id )

	timer.Simple( 0.5, function()
		if not IsValid(ply) then return end
		GAMEMODE:Deathrun_Func( ply, "All_Connecting", connecting )
	end )

end )

function GM:PlayerLoadout( ply )

	ply:Give("weapon_crowbar")

end

function GM:GetFallDamage( ply, speed )

	if falldamage:GetInt() == 1 then
		return speed/8
	end

	return 10

end

local function AlivePlayers()

	local pool = {}

	for k, v in pairs( player.GetAll() ) do
		if not v:Alive() then continue end
		pool[#pool+1] = v
	end

	return pool

end

function GM:DoPlayerDeath( ply, attacker, cinfo )

	self.BaseClass:DoPlayerDeath( ply, attacker, cinfo )

	local num = 0
	local last = nil

	for k, v in pairs( player.GetAll() ) do
		if ply == v then continue end
		local ob = v:GetObserverTarget()
		if IsValid(ob) and ob == ply then
			v:Spectate(OBS_MODE_ROAMING)
			v:SpectateEntity(nil)
			v:SetPos(ply:EyePos())
		end

		if v:Team() == ply:Team() and v:Alive() then
			num = num + 1
			if not v._HasPressedKey then last = v end
		end
	end

	if num == 1 and IsValid(last) and self:GetRoundTime() < ( GetConVarNumber("dr_roundtime_seconds") - 20 ) then
		local t = last:Team()
		timer.Simple( 1, function()
			if not IsValid(last) then return end
			if not last:Alive() then return end
			if last:Team() != t then return end
			last:Kill()
			PrintMessage( 3, last:Nick().." has been killed for being AFK as the last member of the "..team.GetName(t).." team." )
		end )
	end

	ply._unspec_deathrag = CurTime() + 2

end

local function NextPlayer( ply )

	local plys = AlivePlayers()

	if #plys < 1 then return nil end
	if not IsValid(ply) then return plys[1] end

	local old, new

	for k, v in pairs( plys ) do

		if old == ply then
			new = v
		end

		old = v

	end

	if not IsValid(new) then
		return plys[1]
	end

	return new

end

local function PrevPlayer( ply )

	local plys = AlivePlayers()

	if #plys < 1 then return nil end
	if not IsValid(ply) then return plys[1] end

	local old

	for k, v in pairs( plys ) do

		if v == ply then
			return old or plys[#plys]
		end

		old = v

	end

	if not IsValid(old) then
		return plys[#plys]
	end

	return old
end

local SpecFuncs = {
	
	[IN_ATTACK] = function( ply )

		local targ = PrevPlayer( ply:GetObserverTarget() )

		if IsValid(targ) then
			ply:Spectate( ply._smode or OBS_MODE_CHASE )
			ply:SpectateEntity( targ )
		end

	end,

	[IN_ATTACK2] = function( ply )

		local targ = NextPlayer( ply:GetObserverTarget() )

		if IsValid(targ) then
			ply:Spectate( ply._smode or OBS_MODE_CHASE )
			ply:SpectateEntity( targ )
		end

	end,

	[IN_RELOAD] = function( ply )

		local targ = ply:GetObserverTarget()
		if not IsValid(targ) or not targ:IsPlayer() then return end

		if not ply._smode or ply._smode == OBS_MODE_CHASE then
			ply._smode = OBS_MODE_IN_EYE
		elseif ply._smode == OBS_MODE_IN_EYE then
			ply._smode = OBS_MODE_CHASE
		end

		ply:Spectate( ply._smode )

	end,

	[IN_JUMP] = function( ply )

		if ply:GetMoveType() != MOVETYPE_NOCLIP then
			ply:SetMoveType(MOVETYPE_NOCLIP)
		end

	end,

	[IN_DUCK] = function( ply )

		local pos = ply:GetPos()
		local targ = ply:GetObserverTarget()

		if IsValid(targ) and targ:IsPlayer() then
			pos = targ:EyePos()
		end

		ply:Spectate(OBS_MODE_ROAMING)
		ply:SpectateEntity(nil)

		ply:SetPos(pos)

	end

}

-- beware, unoptimized code

util.AddNetworkString( "_KeyPress" )
util.AddNetworkString( "_KeyRelease" )

local WantKeys = {}
WantKeys[IN_JUMP] = true
WantKeys[IN_MOVELEFT] = true
WantKeys[IN_MOVERIGHT] = true
WantKeys[IN_DUCK] = true
WantKeys[IN_BACK] = true
WantKeys[IN_FORWARD] = true

local function GetSpectating( ply ) 

	local tab = {}

	for k, v in pairs( player.GetAll() ) do
		if v:GetObserverTarget() == ply then
			tab[#tab+1] = v
		end
	end

	return tab

end

function GM:LogPress( ply, key )

	if not WantKeys[key] then return end

	local spec = GetSpectating( ply )
	if #spec < 1 then return end

	net.Start( "_KeyPress" )
		net.WriteEntity( ply )
		net.WriteInt( key, 16 )
	net.Send( spec )

end

function GM:KeyRelease( ply, key )

	if not WantKeys[key] then return end

	local spec = GetSpectating( ply )
	if #spec < 1 then return end

	net.Start( "_KeyRelease" )
		net.WriteEntity( ply )
		net.WriteInt( key, 16 )
	net.Send( spec )

end

-- I used BKU's keypress code as reference, credit to him.

function GM:KeyPress( ply, key )

	if not IsValid(ply) then return end

	if not ply._HasPressedKey then
		ply._HasPressedKey = true
	end

	if ply:Alive() then 
		self:LogPress( ply, key )
		return 
	end

	if SpecFuncs[key] then
		local ob = ply:GetObserverTarget()
		if not ply._unspec_deathrag then
			return SpecFuncs[key](ply)
		end

		if ply._unspec_deathrag >= CurTime() then return end

		ply._unspec_deathrag = nil
		ply:Spectate( OBS_MODE_ROAMING )
		ply:SpectateEntity(nil)
	end

end

function GM:PlayerDeathThink( ply )
	return false
end

function GM:Think()
	self.BaseClass:Think()
	self:RoundThink()
	self:ConVarThink()
end

function GM:PlayerSay( ply, text )

	local text2 = string.lower(text)
	if text2 == "timeleft" then
		ply:PrintMessage(3, tostring(GetGlobalInt("dr_rounds_left")).." rounds before the map changes.")
		return ""
	end

	return self.BaseClass:PlayerSay(ply, text)

end

ConVarCallback( "dr_highlight_admins", function( cvar, old, new )
	SetGlobalInt( "dr_highlight_admins", tonumber(new or 1) or 1 )
end )

ConVarCallback( "dr_allow_autojump", function( cvar, old, new )
	SetGlobalInt( "dr_allow_autojump", tonumber(new or 1) or 1 )
end )

function GM:Initialize()
	RunConsoleCommand("sv_sticktoground", "0")

	SetGlobalInt( "dr_highlight_admins", highlight:GetInt() )
	SetGlobalInt( "dr_rounds_left", rounds:GetInt() )
	SetGlobalInt( "dr_allow_autojump", bhop:GetInt() )
end

function GM:PlayerInitialSpawn( ply )

	if self:GetRound() == ROUND_PREPARING then
		ply:SetTeam(TEAM_RUNNER)
		ply:Spawn()
	else
		ply:SetTeam(TEAM_SPECTATOR)
		ply:Spectate(OBS_MODE_ROAMING)
	end
	
end

function GM:AllowPlayerPickup( ply, ent )
	return false
end
