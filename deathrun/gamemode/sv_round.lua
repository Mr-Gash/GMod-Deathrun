ROUND_WAITING = 0
ROUND_PREPARING = 1
ROUND_ACTIVE = 2
ROUND_ENDING = 3

SetGlobalInt( "Deathrun_RoundPhase", ROUND_WAITING )
SetGlobalInt( "Deathrun_RoundTime", 0 )

function GM:SetRoundTime( time )
	return SetGlobalInt( "Deathrun_RoundTime", CurTime() + (tonumber(time or 5) or 5) )
end

CreateConVar( "dr_death_rate", 0.25, FCVAR_ARCHIVE )
CreateConVar( "dr_death_max", 6, FCVAR_ARCHIVE )

function GM:DoWeNeedDeath()

	local rate = math.Clamp( GetConVarNumber( "dr_death_rate" ), 0.1, 0.9 )
	local plys = #player.GetAll()
	local md = math.max( GetConVarNumber("dr_death_max"), 2 )

	local num = #team.GetPlayers(TEAM_DEATH)
	local need = math.floor(math.Clamp( plys * rate, 1, md ))
	if num >= need then return false end
	return true
end

function GM:SortPlayers( freezePlayers )

	local pool = {}
	for k, v in pairs( player.GetAll() ) do
		if v:Team() == TEAM_DEATH then pool[#pool+1] = v end
		v:SetTeam(TEAM_SPECTATOR)
	end

	local pool2 = {}
	for k, v in RandomPairs( player.GetAll() ) do
		local need = self:DoWeNeedDeath()
		local stop = false
		if need then
			if not table.HasValue(pool, v) then
				v:SetTeam(TEAM_DEATH)
			else
				pool2[#pool2+1] = v
				stop = true
			end
		else
			v:SetTeam(TEAM_RUNNER)
		end
		if not stop then v:Spawn() end
	end

	if #pool2 > 0 then
		for k, v in RandomPairs( pool2 ) do
			if not IsValid(v) then continue end
			local need = self:DoWeNeedDeath()
			if need then
				v:SetTeam(TEAM_DEATH)
				v:PrintMessage( HUD_PRINTCONSOLE, "Sorry! We need more deaths." )
			else
				v:SetTeam(TEAM_RUNNER)
			end
			v:Spawn()
		end
	end

	if freezePlayers then
		for k, v in pairs( player.GetAll() ) do
			v:Freeze(true)
		end
	end

end

local RTVoted = false
local ShowRounds = CreateConVar( "dr_notify_rounds_left", "1", FCVAR_ARCHIVE )

GM.RoundFunctions = {
	
	[ROUND_WAITING] = function( gm )

		gm:NotifyAll( "Not enough players!" )
		gm:SetRoundTime( 0 )

	end,

	[ROUND_PREPARING] = function( gm )

		game.CleanUpMap()

		gm:SetRoundTime( 5 )
		gm:SortPlayers( true )

		local rounds = math.max(GetGlobalInt( "dr_rounds_left", 1 ), 0)
		if rounds > 0 and ShowRounds:GetInt() == 1 then
			gm:NotifyAll( "The map will change in "..rounds.." rounds." )
		end

	end,

	[ROUND_ACTIVE] = function( gm )

		gm:SetRoundTime( GetConVarNumber( "dr_roundtime_seconds" ) or 300 )
		for k, v in pairs( player.GetAll() ) do
			v:Freeze(false)
			gm:PlayerLoadout( v )
		end

		gm:NotifyAll( "The round has started!" )

	end,

	[ROUND_ENDING] = function( gm, winner )

		gm:SetRoundTime( 5 )

		gm:NotifyAll( winner == 123 and "Time is up!" or team.GetName(winner).."s have won!" )

		local rounds = math.max(GetGlobalInt( "dr_rounds_left", 1 ) - 1, 0)
		SetGlobalInt( "dr_rounds_left", rounds )

		if rounds <= 1 and not RTVoted then
			RTV.Start()
			RTVoted = true
		end

	end,

}

function GM:SetRound( round, ... )

	if not self.RoundFunctions[round] then return end

	local args = {...}

	SetGlobalInt( "Deathrun_RoundPhase", round )
	self.RoundFunctions[round]( self, unpack(args) )

	hook.Call( "OnRoundSet", self, round, unpack(args) )

end

function GetRoundState()
	return GetGlobalInt( "Deathrun_RoundPhase" )
end

local function GetAlivePlayersFromTeam( t )

	local pool = {}
	for k, v in pairs( team.GetPlayers(t) ) do
		if v:Alive() then
			pool[#pool+1] = v
		end
	end

	return pool

end

local HasDoneCheck = false

GM.ThinkRoundFunctions = {

	[ROUND_WAITING] = function( gm )

		if #player.GetAll() < 2 then return end

		gm:SetRound( ROUND_PREPARING )

	end,

	[ROUND_PREPARING] = function( gm )

		if gm:GetRoundTime() <= 0 then
			gm:SetRound( ROUND_ACTIVE )
		end

	end,

	[ROUND_ACTIVE] = function( gm )

		local time = gm:GetRoundTime()

		if time <= 0 then
			gm:SetRound( ROUND_ENDING, 123 )
			return
		elseif not HasDoneCheck and time <= GetConVarNumber( "dr_roundtime_seconds" )*0.5 then
			HasDoneCheck = true
			for k, v in pairs( player.GetAll() ) do
				if v:Alive() and not v._HasPressedKey then
					v._HasPressedKey = true
					v:Kill()
					PrintMessage( HUD_PRINTTALK, "Automatically killed "..v:Nick().." for being AFK." )
				end
			end
		end

		local numa = #GetAlivePlayersFromTeam( TEAM_RUNNER )
		local numb = #GetAlivePlayersFromTeam( TEAM_DEATH )

		if numa == 0 then
			gm:SetRound( ROUND_ENDING, TEAM_DEATH )
		elseif numb == 0 then
			gm:SetRound( ROUND_ENDING, TEAM_RUNNER )
		end		

	end,

	[ROUND_ENDING] = function( gm )

		if gm:GetRoundTime() <= 0 then
			gm:SetRound( ROUND_PREPARING )
			return
		end

	end,

}

function GM:RoundThink()
	local cur = self:GetRound()

	if cur != ROUND_WAITING then
		if #player.GetAll() < 2 then
			self:SetRound(ROUND_WAITING)
			return
		end
	end

	if self.ThinkRoundFunctions[cur] then
		self.ThinkRoundFunctions[cur]( self )
	end
end