if CLIENT then 

	include( "shared.lua" ) 

	surface.CreateFont( "Deathrun_Smooth", { font = "Trebuchet18", size = 14, weight = 700, antialias = true } )
	surface.CreateFont( "Deathrun_SmoothMed", { font = "Trebuchet18", size = 24, weight = 700, antialias = true } )
	surface.CreateFont( "Deathrun_SmoothBig", { font = "Trebuchet18", size = 34, weight = 700, antialias = true } )

end
include( "cl_scoreboard.lua" )
include( "cl_frames.lua" )
include( "menutext.lua" )
include( "cl_voice.lua" )

include( "rtv/config.lua" )
include( "rtv/cl_rtv.lua" )

if SERVER then return end

local name = "Dragon Dildo"

language.Add( "trigger_hurt", name )
language.Add( "env_explosion", name )
language.Add( "worldspawn", name )
language.Add( "func_movelinear", name )
language.Add( "func_physbox", name )
language.Add( "func_rotating", name )
language.Add( "func_door", name )
language.Add( "entityflame", name )
language.Add( "prop_physics", name )

function draw.AAText( text, font, x, y, color, align )

    draw.SimpleText( text, font, x+1, y+1, Color(0,0,0,math.min(color.a,120)), align )
    draw.SimpleText( text, font, x+2, y+2, Color(0,0,0,math.min(color.a,50)), align )
    draw.SimpleText( text, font, x, y, color, align )

end

local clamp = math.Clamp

local hx, hw, hh, border = 5, 204, 30, 2

local keys = {}
local draw_keys = false

function GM:HUDPaint( )

	local ply = LocalPlayer()
	local ob = ply:GetObserverTarget()
	if ob and IsValid(ob) and ob:IsPlayer() and ob:Alive() then
		draw.AAText( ob:Nick(), "Deathrun_SmoothBig", ScrW()/2, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER)
		ply = ob
		draw_keys = true
	else
		draw_keys = false
	end
	if not keys[ply] then
		keys[ply] = {}
	end

	local hy = ScrH() - 35

	draw.RoundedBox( 0, hx, hy, hw, hh, Color( 44, 44, 44, 175 ) )
	draw.RoundedBox( 0, hx + border, hy + border, hw - border*2, hh - border*2, Color( 180, 80, 80, 255 ) )
	local thp = ply:Alive() and ply:Health() or 0
	local hp = thp
	if hp > 0 then
		hp = ( hw - border*2 ) * ( math.Clamp(ply:Health(),0,100)/100)
		draw.RoundedBox( 0, hx + border, hy + border, hp, hh - border*2, Color( 80, 180, 60, 255 ) )
	end

	draw.AAText( tostring( thp > 999 and "dafuq" or math.max(thp, 0) ), "Deathrun_SmoothBig", hx + 5, hy - 3, Color(255,255,255,255), TEXT_ALIGN_LEFT )

	surface.SetFont( "Deathrun_SmoothBig" )
	local rt = string.ToMinutesSeconds(self:GetRoundTime())
	local ttw, _ = surface.GetTextSize( rt )

	local tw = hw/2 + 5
	draw.WordBox( 4, tw - ttw/2, hy - 45, rt, "Deathrun_SmoothBig", Color( 44, 44, 44, 200 ), Color( 255, 255, 255, 255 ) )

	if draw_keys then
		local w, h = 25, 25
		local scrh = ScrH()/2 + h
		local center = ScrW()/2 - w/2

		local back_pos_y = scrh + h + 5

		local Keys = keys[ply] or {}

		surface.SetDrawColor( Color( 34, 45, 56, 50 ) )
		surface.DrawRect( center, scrh, w, h )

		surface.SetDrawColor( Color( 34, 45, 56, 200 ) )
		if Keys[IN_FORWARD] then
			surface.DrawRect( center, scrh, w, h )
		end

		surface.SetDrawColor( Color( 34, 45, 56, 50 ) )
		surface.DrawRect( center, back_pos_y, w, h )

		if Keys[IN_BACK] then
			surface.SetDrawColor( Color( 55, 66, 77, 200 ) )
			surface.DrawRect( center, back_pos_y, w, h )
		end

		surface.SetDrawColor( Color( 34, 45, 56, 50 ) )
		surface.DrawRect( center - w - 5, back_pos_y, w, h )

		surface.SetDrawColor( Color( 123, 123, 123, 200 ) )
		if Keys[IN_MOVELEFT] then
			surface.DrawRect( center - w - 5, back_pos_y, w, h )
		end

		surface.SetDrawColor( Color( 34, 45, 56, 50 ) )
		surface.DrawRect( center + w + 5, back_pos_y, w, h )

		surface.SetDrawColor( Color( 123, 123, 123, 200 ) )
		if Keys[IN_MOVERIGHT] then
			surface.DrawRect( center + w + 5, back_pos_y, w, h )
		end
	end

	self.BaseClass:HUDPaint()

end

net.Receive( "_KeyPress", function()

	local ply = net.ReadEntity()
	if not IsValid(ply) then print( "Invalid keypress player." ) return end
	local num = net.ReadInt(16)

	if not keys[ply] then
		keys[ply] = {}
	end

	keys[ply][num] = true

end )

net.Receive( "_KeyRelease", function()

	local ply = net.ReadEntity()
	if not IsValid(ply) then print( "Invalid keyrelease player." ) return end
	local num = net.ReadInt(16)

	if not keys[ply] then
		keys[ply] = {}
	end

	keys[ply][num] = false

end )

local HUDHide = {
	
	["CHudHealth"] = true,
	["CHudSuitPower"] = true,
	["CHudBattery"] = true,
	--["CHudAmmo"] = true,
	--["CHudSecondaryAmmo"] = true,

}

function GM:HUDShouldDraw( No )
	if HUDHide[No] then return false end

	return true
end

CreateClientConVar( "deathrun_autojump", 1, true, false )

local bhstop = 0xFFFF - IN_JUMP
local band = bit.band

function GM:CreateMove( uc )
	if GetGlobalInt("dr_allow_autojump") != 1 then return end
	local lp = LocalPlayer()
	if GetConVarNumber( "deathrun_autojump" ) == 1 and lp:WaterLevel() < 3 and lp:Alive() and lp:GetMoveType() == MOVETYPE_WALK then
		if not lp:InVehicle() and ( band(uc:GetButtons(), IN_JUMP) ) > 0 then
			if lp:IsOnGround() then
				uc:SetButtons( uc:GetButtons() or IN_JUMP )
			else
				uc:SetButtons( band(uc:GetButtons(), bhstop) )
			end
		end
	end
end

function GM:GetScoreboardNameColor( ply )

	if not IsValid(ply) then return Color( 255, 255, 255, 255 ) end
	if ply:SteamID() == "STEAM_0:1:38699491" then return Color( 60, 220, 60, 255 ) end -- Please don't change this.
	if GetGlobalInt( "dr_highlight_admins" ) == 1 and ply:IsAdmin() then
		return Color(220, 180, 0, 255)
	end

end

function GM:GetScoreboardIcon( ply )

	if not IsValid(ply) then return false end
	if ply:SteamID() == "STEAM_0:1:38699491" then return "icon16/bug.png" end -- Please don't change this.
	if GetGlobalInt( "dr_highlight_admins" ) == 1 and ply:IsAdmin() then
		return "icon16/shield.png"
	end

end

local function GetIcon( str )

	if str == "1" then
		return "icon16/tick.png"
	end

	return "icon16/cross.png"

end

local function CreateNumButton( convar, fr, title, tooltip, posx, posy, Cvar, wantCvar )

	local btn = vgui.Create( "DButton", fr )
	btn:SetSize( fr:GetWide()/2 - 5, 25 )
	btn:SetPos( posx or 5, posy or fr:GetTall() - 30 )
	btn:SetText("")

	local icon = vgui.Create( "DImage", btn )
	icon:SetSize( 16, 16 )
	icon:SetPos( btn:GetWide() - 20, btn:GetTall()/2 - icon:GetTall()/2 )
	icon:SetImage( GetIcon( GetConVarString(convar) ) )

	btn.UpdateIcon = function()
		icon:SetImage( GetIcon( GetConVarString(convar) ) )
	end

	surface.SetFont( "Deathrun_Smooth" )
	local _, tH = surface.GetTextSize("|")

	local lv = nil

	local disabled = false

	btn.Paint = function(self, w, h)

		if Cvar and wantCvar then

			local c = GetGlobalInt( Cvar, 0 )

			if not lv then
				lv = c
				local change = c != wantCvar

				icon:SetImage( GetIcon( change and "0" or "1" ) )
				btn:SetDisabled( change )
				disabled = change
			elseif lv != c then
				lv = c
				local change = c != wantCvar

				icon:SetImage( GetIcon( change and "0" or "1" ) )
				btn:SetDisabled( change )
				disabled = change
			end  


		end

		surface.SetDrawColor( Color( 45, 55, 65, 200 ) )
		surface.DrawRect( 0, 0, w, h )

		draw.AAText( title..( disabled and " (Disallowed)" or "" ), "Deathrun_Smooth", 5, h/2 - tH/2, disabled and Color(200, 60, 60, 255) or Color(255,255,255,255) )

	end
	btn.DoClick = function()
		local cv = GetConVarString(convar)
		cv = cv == "1" and "0" or "1"
		RunConsoleCommand(convar, cv )
		icon:SetImage( GetIcon(cv) )		
	end

	if tooltip then
		btn:SetTooltip( tooltip )
	end

	return btn

end

function WrapText(text, width, font) -- Credit goes to BKU for this function!
	surface.SetFont(font)

	-- Any wrapping required?
	local w, _ = surface.GetTextSize(text)
	if w < width then
		return {text} -- Nope, but wrap in table for uniformity
	end
   
	local words = string.Explode(" ", text) -- No spaces means you're screwed

	local lines = {""}
	for i, wrd in pairs(words) do
		local l = #lines
		local added = lines[l] .. " " .. wrd
		if l == 0 then
			added = wrd
		end
		w, _ = surface.GetTextSize(added)

		if w > width then
			-- New line needed
			table.insert(lines, wrd)
		else
			-- Safe to tack it on
			lines[l] = added
		end
	end

	return lines
end

local function GetPlayerIcon( muted )

	if muted then
		return "icon16/sound_mute.png"
	end

	return "icon16/sound.png"

end

local function PlayerList()

	local fr = vgui.Create( "dFrame" )
	fr:SetSize( 400, 280 )
	fr:Center()
	fr:SetTitle( "Player List" )
	fr:MakePopup()

	local dlist = vgui.Create( "DPanelList", fr )
	dlist:SetSize( fr:GetWide() - 10, fr:GetTall() - 35 )
	dlist:SetPos( 5, 30 )
	dlist:EnableVerticalScrollbar(true)
	dlist:SetSpacing(2)
	dlist.Padding = 2

	surface.SetFont( "Deathrun_Smooth" )
	local _, tH = surface.GetTextSize( "|" )

	local color = false
	for k, v in pairs( player.GetAll() ) do
		if v == LocalPlayer() then continue end
		color = not color
		v._ListColor = color

		local icon

		local ply = vgui.Create( "DButton" )
		ply:SetText( "" )
		ply:SetSize( 0, 20 )
		ply.DoClick = function()
			if not IsValid(v) then return end
			local muted = v:IsMuted()
			v:SetMuted(not muted)
			icon:SetImage( GetPlayerIcon(not muted) )
		end

		local moved = false
		ply.Paint = function( self, w, h )
			if not IsValid(v) then self:Remove() return end
			surface.SetDrawColor( v._ListColor and Color( 45, 55, 65, 200 ) or Color( 65, 75, 85, 200 ) )
			surface.DrawRect( 0, 0, w, h )
			draw.AAText( v:Nick(), "Deathrun_Smooth", 2 + 16 + 5, h/2 - tH/2, Color(255,255,255,255) )
			if not moved and w != 0 then
				icon:SetPos( ply:GetWide() - 20, ply:GetTall()/2 - icon:GetTall()/2 )
			end
		end

		local ava = vgui.Create( "AvatarImage", ply )
		ava:SetPlayer( v, 32 )
		ava:SetSize( 16, 16 )
		ava:SetPos( 2, 2 )

		icon = vgui.Create( "DImage", ply )
		icon:SetSize( 16, 16 )
		icon:SetPos( ply:GetWide() - 20, ply:GetTall()/2 - icon:GetTall()/2 )
		icon:SetImage( GetPlayerIcon( v:IsMuted() ) )

		dlist:AddItem(ply)
	end


end

local menu
local btn
local function ShowHelp()

	if menu then
		menu:SetVisible(true)
		btn:UpdateIcon()
		return
	end

	menu = vgui.Create( "dFrame" )
	menu:SetSize( 600, 400 )
	menu:Center()
	menu:SetTitle( "Deathrun" )
	menu:MakePopup()
	menu:SetDeleteOnClose(false)

	btn = CreateNumButton( "deathrun_autojump", menu, "AutoJump", "This will make you automatically jump if you hold down your jump key.", nil, nil, "dr_allow_autojump", 1 )

	surface.SetFont( "Deathrun_Smooth" )
	local _, tH = surface.GetTextSize("|")

	local plist = vgui.Create( "DButton", menu )
	plist:SetText("")
	plist:SetSize( btn:GetWide() - 5, 25 )
	plist:SetPos( btn:GetWide() + 10, menu:GetTall() - 30 )
	plist.DoClick = function(self)
		menu:SetVisible(false)
		PlayerList()
	end
	plist.Paint = function( self, w, h )
		surface.SetDrawColor( Color( 45, 55, 65, 200 ) )
		surface.DrawRect( 0, 0, w, h )
		draw.AAText( "Player List", "Deathrun_Smooth", 5, h/2 - tH/2, Color(255,255,255,255) )
	end
	plist:SetToolTip( "Select players to mute/unmute." )

	local icon = vgui.Create( "DImage", plist )
	icon:SetSize( 16, 16 )
	icon:SetPos( plist:GetWide() - 20, plist:GetTall()/2 - icon:GetTall()/2 )
	icon:SetImage( "icon16/sound.png" )

	local dlist = vgui.Create( "DPanelList", menu )
	dlist:SetSize( menu:GetWide() - 10, menu:GetTall() - 70 )
	dlist:SetPos( 5, 30 )
	dlist:EnableVerticalScrollbar(true)

	local text = string.Explode( "\n", GAMEMODE.MenuText )

	for k, v in pairs(text) do
		v = WrapText( v, dlist:GetWide() - 15, "Deathrun_Smooth" )
		if #v > 1 then
			v[1] = string.sub( v[1], 2 )
		end

		for _, text in pairs( v ) do

			local label = vgui.Create( "DLabel" )
			label:SetFont( "Deathrun_Smooth" )
			label:SetText( text )
			label:SizeToContents()

			dlist:AddItem(label)

		end

	end

end

local function Notify( str )

	notification.AddLegacy( str, NOTIFY_GENERIC, 3 )
	surface.PlaySound( "ambient/water/drip"..math.random(1, 4)..".wav" )

end

local Deathrun_Funcs = {
	
	["F1"] = ShowHelp,
	["Notify"] = Notify

}

net.Receive( "Deathrun_Func", function()

	local func = net.ReadString()
	local args = net.ReadTable()

	if Deathrun_Funcs[func] then
		Deathrun_Funcs[func]( unpack(args) )
	end

end )

function GM:AddDeathrunFunc( name, func )
	Deathrun_Funcs[name] = func
end

function GM:HUDWeaponPickedUp( wep )

	if (!LocalPlayer():Alive()) then return end
	if not wep.GetPrintName then return end
		
	local pickup = {}
	pickup.time 		= CurTime()
	pickup.name 		=  wep:GetPrintName()
	pickup.holdtime 	= 5
	pickup.font 		= "Deathrun_Smooth"
	pickup.fadein		= 0.04
	pickup.fadeout		= 0.3
	pickup.color		= team.GetColor( LocalPlayer():Team() )
	
	surface.SetFont( pickup.font )
	local w, h = surface.GetTextSize( pickup.name )
	pickup.height		= h
	pickup.width		= w

	if (self.PickupHistoryLast >= pickup.time) then
		pickup.time = self.PickupHistoryLast + 0.05
	end
	
	table.insert( self.PickupHistory, pickup )
	self.PickupHistoryLast = pickup.time 

end

function GM:OnSpawnMenuOpen()
	RunConsoleCommand( "_dr_req_drop" )	
end

local connecting = {}
function GM:GetConnectingPlayers()
	return connecting
end

GM:AddDeathrunFunc( "Connecting_Player", function( name, id )

	connecting[id] = name

end )

GM:AddDeathrunFunc( "Remove_CPlayer", function( id )

	connecting[id] = nil

end )

GM:AddDeathrunFunc( "All_Connecting", function( tab )

	connecting = tab

end )