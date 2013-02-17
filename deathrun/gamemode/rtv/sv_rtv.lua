RTV.VTab = {}
for i = 1, 9 do
	RTV.VTab["MAP_"..i] = 0
end
--RTV.VTab["MAP_EXTEND"] = 0

RTV.Limit = math.Clamp( RTV.Limit, 2, 8 )

RTV.Maps = {}

RTV.TotalVotes = 0

RTV._ActualWait = CurTime() + RTV.Wait

local get = 0

local files, dirs = file.Find( "maps/*.bsp", "GAME" )

if RTV.UsePrefixes then
	for k, v in RandomPairs( files ) do
		if get >= RTV.Limit then 
			--RTV.Maps[#RTV.Maps+1] = "Extend Current Map"
			break 
		end
		if string.gsub(v, ".bsp", "") == game.GetMap() then continue end
		for _, prefix in pairs( RTV.Prefixes ) do
			prefix = string.lower(prefix)
			if string.sub( string.lower(v), 0, #prefix ) == prefix then
				RTV.Maps[#RTV.Maps+1] = string.gsub( v, ".bsp", "" )
				get = get + 1
			end
		end
	end
end

SetGlobalBool( "In_Voting", false )

util.AddNetworkString( "RTVMaps" )

function RTV.ShouldChange()
	return RTV.TotalVotes >= math.Round(#player.GetAll()*0.66)
end

function RTV.RemoveVote()
	RTV.TotalVotes = math.Clamp( RTV.TotalVotes - 1, 0, math.huge )
end

function RTV.Start()

	SetGlobalBool( "In_Voting", true )

	for k, v in pairs( player.GetAll() ) do
		net.Start( "RTVMaps" )
			net.WriteTable( RTV.Maps )
		net.Send( v )
		umsg.Start( "RTVoting", v )
		umsg.End()
	end
	
	timer.Simple( 30, function()
		RTV.Finish()
	end )

end

function RTV.ChangeMap( map )

	if not map then return end

	Notify( "Changing the map to "..map.." after the current round." )

	hook.Add( "OnRoundSet", "RTV - Change Map", function( r )

		if r != ROUND_PREPARING then return end

		RunConsoleCommand( "gamemode", GAMEMODE.FolderName )
		RunConsoleCommand( "changelevel", map )

	end )

end

concommand.Add( "rtv_vote", function( ply, cmd, args )

	if not (ply and ply:IsValid()) then return end

	if not GetGlobalBool( "In_Voting" ) then
		ply:Notify( "There is no vote in progress, you are a dumbass." )
		return
	end

	if ply.MapVoted then
		ply:Notify( "You have already voted!" )
		return
	end

	local vote = args[1]

	if not vote then
		ply:Notify( "What are you doing?" )
		return
	end

	if not tonumber(vote) then

		--if vote == "EXTEND" then
		--	RTV.VTab["MAP_EXTEND"] = RTV.VTab["MAP_EXTEND"] + 1
		--	ply.MapVoted = true
		--	ply:Notify( "You have voted to extend the map!" )
		--	return
		--end

		ply:Notify( "What are you doing?" )
		return
	end

	vote = math.Clamp( tonumber(vote), 1, #RTV.Maps )

	RTV.VTab["MAP_"..vote] = RTV.VTab["MAP_"..vote] + 1
	ply.MapVoted = true
	ply:Notify( "You have voted for "..RTV.Maps[vote].."!" )

end )

function RTV.Finish()

	SetGlobalBool( "In_Voting", false )
	RTV.TotalVotes = 0

	umsg.Start( "RTVoting" )
	umsg.End()

	for k, v in pairs( player.GetAll() ) do
		v.RTVoted = false
		v.MapVoted = false
	end

	local top = 0
	local winner = nil

	for k,v  in pairs( RTV.VTab ) do

		if v > top then
			top = v
			winner = k
		end

		RTV.VTab[k] = 0

	end

	if top <= 0 then

		Notify( "No one voted! Picking a random map..." )
		RTV.ChangingMaps = true
		RTV.ChangeMap( RTV.Maps[math.random(1, #RTV.Maps)] )

	elseif winner then

		winner = string.gsub( winner, "MAP_", "" )

		winner = math.Clamp( tonumber(winner) or 1, 1, #RTV.Maps )
		Notify( "The winning map is "..RTV.Maps[winner].."!" )
		RTV.ChangingMaps = true
		RTV.ChangeMap( RTV.Maps[winner] )
		
	else

		Notify( "Voting fucked up. RIP" )

	end

end

function RTV.AddVote( ply )

	if RTV.CanVote( ply ) then
		RTV.TotalVotes = RTV.TotalVotes + 1
		ply.RTVoted = true
		MsgN( ply:Nick().." has voted to Rock the Vote." )
		Notify( ply:Nick().." has voted to Rock the Vote. ("..RTV.TotalVotes.."/"..math.Round(#player.GetAll()*0.66)..")" )

		if RTV.ShouldChange() then
			RTV.Start()
		end
	end

end

hook.Add( "PlayerDisconnected", "Remove RTV", function( ply )

	if ply.RTVoted then
		RTV.RemoveVote()
	end

	timer.Simple( 0.1, function()

		if RTV.ShouldChange() then
			RTV.Start()
		end

	end )

end )

function RTV.CanVote( ply )

	if RTV._ActualWait >= CurTime() then
		return false, "You must wait a bit before voting!"
	end

	if GetGlobalBool( "In_Voting" ) then
		return false, "There is currently a vote in progress!"
	end

	if ply.RTVoted then
		return false, "You have already voted to Rock the Vote!"
	end

	if RTV.ChangingMaps then
		return false, "There has already been a vote, the map is going to change!"
	end

	return true

end

function RTV.StartVote( ply )

	local can, err = RTV.CanVote(ply)

	if not can then
		ply:Notify( err )
		return
	end

	RTV.AddVote( ply )

end

concommand.Add( "rtv_start", RTV.StartVote )

hook.Add( "PlayerSay", "RTV Chat Commands", function( ply, text )

	if table.HasValue( RTV.ChatCommands, string.lower(text) ) then
		RTV.StartVote( ply )
		return ""
	end

end )