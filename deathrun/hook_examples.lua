-- Be sure to read the readme.txt file first!
-- This would go in garrysmod/lua/autorun/, to get it to both run on the server and client.

if SERVER then
	AddCSLuaFile() -- Send the file to the client.

	hook.Add( "OnRoundSet", "Round Set Example", function( round, winner )

		if round == ROUND_WAITING then
			print( "We're waiting for the game to start!" )
		elseif round == ROUND_PREPARING then
			print( "The round is preparing!" )
		elseif round == ROUND_ACTIVE then
			print( "Let's play!" )
		elseif round == ROUND_ENDING then
			print( "The winner is "..winner.."!" ) -- If the winner is the timelimit, it will be the number 123.
			if winner != 123 then
				print( team.GetName(winner).." is awesome!" )
			end
		end

	end )

	hook.Add( "ChangePlayerModel", "Overwrite Player Model Example", function( ply )

		if ply:IsUserGroup( "vip" ) then -- If the player is in the "vip" group
			return "models/player/leet.mdl" -- Set their model to the CS:S leet model.
		end

	end )

	return -- Stop the server from going any further.
end
-- Because we stopped the server from going any further, anything past this is clientside!

hook.Add( "GetScoreboardNameColor", "Name Color Example", function( ply )

	if ply:IsUserGroup( "vip" ) then -- If the player is in the "vip" group
		return Color( 255, 0, 0, 255 ) -- give the player a red name.
	end

end )

hook.Add( "GetScoreboardIcon", "Icon Example", function( ply )

	if ply:IsUserGroup( "vip" ) then -- If the player is in the "vip" group
		return "icon16/heart.png" -- give the player a heart icon! You can find 16x16 silkicons inside garrysmod/materials/icon16/
	end

end )