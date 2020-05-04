DeriveGamemode( "base" )

GM.Name 	= "Deathrun"
GM.Author 	= "Mr. Gash"
GM.Email 	= ""
GM.Website 	= "nonerdsjustgeeks.com"

function GM:CreateTeams()
	TEAM_DEATH = 2
	team.SetUp( TEAM_DEATH, "Death", Color( 180, 60, 60, 255 ), false )
	team.SetSpawnPoint( TEAM_DEATH, "info_player_terrorist" )

	TEAM_RUNNER = 3
	team.SetUp( TEAM_RUNNER, "Runner", Color( 60, 60, 180, 255 ), false )
	team.SetSpawnPoint( TEAM_RUNNER, "info_player_counterterrorist" )

	team.SetUp( TEAM_SPECTATOR, "Spectator", Color( 125, 125, 125, 255 ), true )
end

local meta = FindMetaTable( "Player" )

function GM:PhysgunPickup( ply, ent )
	if ply:IsSuperAdmin() then return true end
	if IsValid(ent) then return true end
	if ent:IsWeapon() then return true end
	return false
end

function GM:PlayerNoClip( ply, on )
	if not ply:IsAdmin() then return false end

	if SERVER then
		PrintMessage( HUD_PRINTCONSOLE, "Admin '"..ply:Nick().."' has "..(on and "enabled" or "disabled").." noclip." )
	end
	return true
end

function GM:PlayerUse( ply )
	if not ply:Alive() then return false end

	return true
end

function GM:GetRound()
	return GetGlobalInt( "Deathrun_RoundPhase" )
end

function GM:GetRoundTime()
	return math.Round(math.max( GetGlobalInt( "Deathrun_RoundTime" ) - CurTime(), 0 ))
end

meta.OldAlive = meta.OldAlive or meta.Alive

function meta:Alive()
	if self:Team() == TEAM_SPECTATOR then return false end

	return self:OldAlive()
end

-- Thanks BlackAwps!
function string.FormattedTime( seconds, Format )
	if not seconds then seconds = 0 end
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds / 60) % 60)
	local millisecs = ( seconds - math.floor( seconds ) ) * 100
	seconds = seconds % 60
    
	if Format then
		return string.format( Format, minutes, seconds, millisecs )
	else
		return { h=hours, m=minutes, s=seconds, ms=millisecs }
	end
end

-- Credit: AzuiSleet
-- maybe.
-- It's old, I don't remember who made it. 90% sure it was AzuiSleet.
function GM:Move(pl, movedata)
	if pl:IsOnGround() or !pl:Alive() or pl:WaterLevel() > 0 then return end
	
	local aim = movedata:GetMoveAngles()
	local forward, right = aim:Forward(), aim:Right()
	local fmove = movedata:GetForwardSpeed()
	local smove = movedata:GetSideSpeed()
	
	forward.z, right.z = 0,0
	forward:Normalize()
	right:Normalize()

	local wishvel = forward * fmove + right * smove
	wishvel.z = 0

	local wishspeed = wishvel:Length()

	if(wishspeed > movedata:GetMaxSpeed()) then
		wishvel = wishvel * (movedata:GetMaxSpeed()/wishspeed)
		wishspeed = movedata:GetMaxSpeed()
	end

	local wishspd = wishspeed
	wishspd = math.Clamp(wishspd, 0, 30)

	local wishdir = wishvel:GetNormal()
	local current = movedata:GetVelocity():Dot(wishdir)

	local addspeed = wishspd - current

	if(addspeed <= 0) then return end

	local accelspeed = (120) * wishspeed * FrameTime()

	if(accelspeed > addspeed) then
		accelspeed = addspeed
	end

	local vel = movedata:GetVelocity()
	vel = vel + (wishdir * accelspeed)
	movedata:SetVelocity(vel)

	return false
end
