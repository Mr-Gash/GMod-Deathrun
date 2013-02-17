local File = nil
local Load = nil

local function LoadWeapons()

	if not File then File = "deathrun/"..game.GetMap()..".txt" end

	if not Load then
		if not file.Exists( File, "DATA" ) then return end
		local read = file.Read( File, "DATA" )

		read = util.JSONToTable(read)

		if not read then
			file.Delete( File )
			ServerLog( "Deleting "..File.." because of some weird as shit error.\n" )
			return
		end
		Load = read
	end

	for k, v in pairs( Load ) do

		local ent = ents.Create( v.ent )
		if not IsValid(ent) then
			MsgN( "Could not create "..v.ent.."! Please fix "..File )
			continue
		end
		ent:SetPos( v.pos )
		ent:SetAngles( v.ang )
		ent:Spawn()

	end

end

hook.Add( "OnRoundSet", "Load Weapons", function( round )

	if round != ROUND_ACTIVE then return end

	LoadWeapons()

end )

concommand.Add( "dr_add_weapon", function( ply, cmd, args )

	if not ply:IsSuperAdmin() then return end
	if not ply:Alive() then return end

	local wep = args[1]

	if not wep then return end

	local ent = ents.Create( wep )
	if not IsValid(ent) then
		ply:PrintMessage( 3, "Invalid entity!" )
		return
	end
	ent:SetPos( ply:GetEyeTrace().HitPos + Vector( 0, 0, 50 ) )
	ent:Spawn()

	if not ply:HasWeapon( "weapon_physgun" ) then
		ply:Give( "weapon_physgun" )
	end

end )

concommand.Add( "dr_save_weapon", function( ply, cmd, args )

	if not ply:IsSuperAdmin() then return end

	local wep = ply:GetEyeTrace().Entity

	if not IsValid(wep) then ply:PrintMessage( 3, "Invalid entity." ) return end
	if not wep:IsWeapon() then ply:PrintMessage( 3, "You may only save weapons." ) return end

	if not File then File = "deathrun/"..game.GetMap()..".txt" end

	local tab = {}

	if file.Exists( File, "DATA" ) then
		tab = file.Read( File, "DATA" )
		tab = util.JSONToTable(tab)

		if not tab then
			file.Delete( File )
			ServerLog( "Deleting "..File.." because of some weird as shit error.\n" )
			ply:PrintMessage( 3, File.." has been deleted because of some weird as shit error." )
			tab = {}
		end
	end

	tab[#tab+1] = { ["ent"] = wep:GetClass(), ["pos"] = wep:GetPos(), ["ang"] = wep:GetAngles() }

	if not file.Exists( "deathrun", "DATA" ) then
		file.CreateDir( "deathrun" )
	end

	file.Write( File, util.TableToJSON(tab) )
	Load = tab

	ply:PrintMessage( 3, "Saved "..wep:GetClass().." to "..File.."!" )

end )