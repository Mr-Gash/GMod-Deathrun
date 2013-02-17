if SERVER then return end

local PANEL = {}
local PlayerVoicePanels = {}

function PANEL:Init()

	self.LabelName = vgui.Create( "DLabel", self )
	self.LabelName:SetFont( "GModNotify" )
	self.LabelName:Dock( FILL )
	self.LabelName:DockMargin( 8, 0, 0, 0 )
	self.LabelName:SetTextColor( Color( 255, 255, 255, 255 ) )

	self.Avatar = vgui.Create( "AvatarImage", self )
	self.Avatar:Dock( LEFT );
	self.Avatar:SetSize( 32, 32 )

	self.Color = color_transparent

	self:SetSize( 250, 32 + 8 )
	self:DockPadding( 4, 4, 4, 4 )
	self:DockMargin( 2, 2, 2, 2 )
	self:Dock( TOP )

end

function PANEL:Setup( ply )

	self.ply = ply
	self.LabelName:SetText( ply:Nick() )
	self.Avatar:SetPlayer( ply )
	
	self.Color = team.GetColor( ply:Team() )
	
	self:InvalidateLayout()

end

PANEL.lastw = 0
PANEL.lastName = ""

function PANEL:Paint( w, h )

	if ( !IsValid( self.ply ) ) then return end

	local cw = w
	w = self.lastw
	--draw.RoundedBox( 4, 0, 0, w, h, Color( 0, self.ply:VoiceVolume() * 255, 0, 240 ) )
	draw.RoundedBox( 4, 0, 0, w, h, Color( 35, 45, 55, 180 + self.ply:VoiceVolume() * 255 ) )
	draw.RoundedBox( 4, 0, 0, 32 + 4 + 4, h, self.ply:Alive() and team.GetColor( self.ply:Team() ) or team.GetColor(TEAM_SPECTATOR) )

	if self.lastw != cw then
		local nick = self.ply:Nick()

		surface.SetFont( "GModNotify" )
		local w2, h2 = surface.GetTextSize( nick )
		w2 = w2 + 32 + 16
		self:SetSize( w2, h )
		self.lastw = w2

		if self.lastName != nick then
			self.LabelName:SetText( nick )
			self.lastName = nick
		end
	end

end

function PANEL:Think( )

	if ( self.fadeAnim ) then
		self.fadeAnim:Run()
	end

end

function PANEL:FadeOut( anim, delta, data )
	
	if ( anim.Finished ) then
	
		if ( IsValid( PlayerVoicePanels[ self.ply ] ) ) then
			PlayerVoicePanels[ self.ply ]:Remove()
			PlayerVoicePanels[ self.ply ] = nil
			return
		end
		
	return end
			
	self:SetAlpha( 255 - (255 * delta) )

end

derma.DefineControl( "VoiceNotify2", "", PANEL, "DPanel" )



function GM:PlayerStartVoice( ply )

	if ( !IsValid( g_VoicePanelList ) ) then return end
	
	-- There'd be an exta one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice( ply )


	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then
			PlayerVoicePanels[ ply ].fadeAnim:Stop()
			PlayerVoicePanels[ ply ].fadeAnim = nil
		end

		PlayerVoicePanels[ ply ]:SetAlpha( 255 )

		return;

	end

	if ( !IsValid( ply ) ) then return end

	local pnl = g_VoicePanelList:Add( "VoiceNotify2" )
	pnl:Setup( ply )
	
	PlayerVoicePanels[ ply ] = pnl
	
end


local function VoiceClean()

	for k, v in pairs( PlayerVoicePanels ) do
	
		if ( !IsValid( k ) ) then
			GAMEMODE:PlayerEndVoice( k )
		end
	
	end

end

timer.Create( "VoiceClean", 10, 0, VoiceClean )


function GM:PlayerEndVoice( ply )
	
	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then return end

		PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
		PlayerVoicePanels[ ply ].fadeAnim:Start( 0.5 )

	end
	
end


local function CreateVoiceVGUI()

	g_VoicePanelList = vgui.Create( "DPanel" )

	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos( 20, 20 )
	g_VoicePanelList:SetSize( 250, ScrH() - 40 )
	g_VoicePanelList:SetDrawBackground( false )

end

if IsValid( g_VoicePanelList ) then -- caused by autorefresh.
	g_VoicePanelList:Remove()
	CreateVoiceVGUI()
end

hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )