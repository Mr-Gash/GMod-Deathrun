if SERVER then return end

RTV.Voter = nil
RTV.Maps = {}
RTV.Keys = {}
local menuText = "Map Voting"

surface.CreateFont( "GoodDefault", { font = "Tahoma", size = 13, weight = 500, antialias = false } )
surface.CreateFont( "GoodDefaultBold", { font = "Tahoma", size = 13, weight = 1000, antialias = false } )

function RTV.CreatePanel()

	if (RTV.Voter and RTV.Voter:IsVisible()) then
		RTV.Voter:Remove()
	end

	if not GetGlobalBool( "In_Voting" ) then RTV.Keys = {} return end

	RTV.Voter = vgui.Create( "DFrame" )
	local pn = RTV.Voter -- It gets annoying typing that
	pn:SetSize( 300, 20 + (26*#RTV.Maps) )
	pn:SetPos( 5, ScrH() * 0.4 )
	pn:SetTitle( "" )
	pn:ShowCloseButton(false)
	pn:SetDraggable(false)
	pn.Paint = function( self, w, h )
		surface.SetDrawColor( Color( 45, 55, 65, 200 ) )
		surface.DrawRect( 0, 0, w, 24 )
		surface.SetDrawColor( Color( 35, 45, 55, 220 ) )
		surface.DrawRect( 0, 24, 12, h - 24 )

		surface.SetDrawColor( Color( 40, 40, 40, 235 ) )
		surface.DrawRect( 12, 24, w - 12, h - 24 )

		surface.SetTextColor( Color( 255, 255, 255, 255 ) )
		surface.SetFont( "GoodDefault" )
		local w2, h2 = surface.GetTextSize( menuText )
		surface.SetTextPos( w/2 - w2/2, 5 )
		surface.DrawText( menuText )
	end

	local voted = false

	for k, v in ipairs( RTV.Maps ) do

		local text = vgui.Create( "DLabel", pn )
		text:SetFont( "GoodDefault" )
		text:SetColor( Color( 255, 255, 255, 255 ) )
		text:SetText( tostring(k).."  "..v )
		text:SetPos( 4, (26 * k-1) )
		text:SizeToContents()

		RTV.Keys[k+1] = { text, v == "Extend Current Map" and "EXTEND" or k }

	end

	pn.Think = function( self )

		if not voted and GetGlobalBool( "In_Voting" ) and #RTV.Keys > 0 then

			for k, v in pairs( RTV.Keys ) do

				if input.IsKeyDown( k ) and v[1] then

					voted = true
					v[1]:SetColor( Color( 0, 255, 0, 255 ) )
					RunConsoleCommand( "rtv_vote", v[2] )
					surface.PlaySound( "garrysmod/save_load1.wav" )

				end

			end

		end

	end

end

usermessage.Hook( "RTVoting", function()
	timer.Simple( 1, function()
		RTV.CreatePanel()
	end )
end )

net.Receive( "RTVMaps", function()
	RTV.Maps = net.ReadTable()
end )