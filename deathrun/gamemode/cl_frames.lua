if SERVER then return end

local PANEL = {}

function PANEL:Init()
end

function PANEL:Paint( w, h )

	surface.SetDrawColor( Color( 44, 44, 44, 200 ) )
	surface.DrawRect( 0, 0, w, h )

	surface.SetDrawColor( Color( 99, 99, 99, 235 ) )
	surface.DrawRect( 0, 0, w, 25 )

end

vgui.Register( "dFrame", PANEL, "DFrame" )