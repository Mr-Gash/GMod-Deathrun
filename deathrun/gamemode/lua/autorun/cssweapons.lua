local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add( "bb_ak47", "vgui/hud/bb_ak47", icol  )
	killicon.Add( "bb_aug", "vgui/hud/bb_aug", icol  )
	killicon.Add( "bb_awp", "vgui/hud/bb_awp", icol  )
	killicon.Add( "bb_deagle", "vgui/hud/bb_deagle", icol  )
	killicon.Add( "bb_dualelites", "vgui/hud/bb_dualelites", icol  )
	killicon.Add( "bb_famas", "vgui/hud/bb_famas", icol  )
	killicon.Add( "bb_fiveseven", "vgui/hud/bb_fiveseven", icol  )
	killicon.Add( "bb_g3sg1", "vgui/hud/bb_g3sg1", icol  )
	killicon.Add( "bb_galil", "vgui/hud/bb_galil", icol  )
	killicon.Add( "bb_glock", "vgui/hud/bb_glock", icol  )
	killicon.Add( "bb_m3", "vgui/hud/bb_m3", icol  )
	killicon.Add( "bb_m4a1", "vgui/hud/bb_m4a1", icol  )
	killicon.Add( "bb_m249", "vgui/hud/bb_m249", icol  )
	killicon.Add( "bb_mac10", "vgui/hud/bb_mac10", icol  )
	killicon.Add( "bb_mp5", "vgui/hud/bb_mp5", icol  )
	killicon.Add( "bb_p90", "vgui/hud/bb_p90", icol  )
	killicon.Add( "bb_p228", "vgui/hud/bb_p228", icol  )
	killicon.Add( "bb_scout", "vgui/hud/bb_scout", icol  )
	killicon.Add( "bb_sg550", "vgui/hud/bb_sg550", icol  )
	killicon.Add( "bb_sg552", "vgui/hud/bb_sg552", icol  )
	killicon.Add( "bb_tmp", "vgui/hud/bb_tmp", icol  )
	killicon.Add( "bb_ump45", "vgui/hud/bb_ump45", icol  )
	killicon.Add( "bb_usp", "vgui/hud/bb_usp", icol  )
	killicon.Add( "bb_xm1014", "vgui/hud/bb_xm1014", icol  )
	killicon.Add( "bb_throwncssfrag", "vgui/hud/bb_cssfrag", icol  )
	killicon.Add( "bb_planted_css_c4", "vgui/hud/bb_css_c4", icol  )
	killicon.Add( "bb_css_knife", "vgui/hud/bb_css_knife", icol  )
	
	
	killicon.Add( "bb_ak47_alt", "vgui/hud/bb_ak47_alt", icol  )
	killicon.Add( "bb_aug_alt", "vgui/hud/bb_aug_alt", icol  )
	killicon.Add( "bb_awp_alt", "vgui/hud/bb_awp_alt", icol  )
	killicon.Add( "bb_deagle_alt", "vgui/hud/bb_deagle_alt", icol  )
	killicon.Add( "bb_dualelites_alt", "vgui/hud/bb_dualelites_alt", icol  )
	killicon.Add( "bb_famas_alt", "vgui/hud/bb_famas_alt", icol  )
	killicon.Add( "bb_fiveseven_alt", "vgui/hud/bb_fiveseven_alt", icol  )
	killicon.Add( "bb_g3sg1_alt", "vgui/hud/bb_g3sg1_alt", icol  )
	killicon.Add( "bb_galil_alt", "vgui/hud/bb_galil_alt", icol  )
	killicon.Add( "bb_glock_alt", "vgui/hud/bb_glock_alt", icol  )
	killicon.Add( "bb_m3_alt", "vgui/hud/bb_m3_alt", icol  )
	killicon.Add( "bb_m4a1_alt", "vgui/hud/bb_m4a1_alt", icol  )
	killicon.Add( "bb_m249_alt", "vgui/hud/bb_m249_alt", icol  )
	killicon.Add( "bb_mac10_alt", "vgui/hud/bb_mac10_alt", icol  )
	killicon.Add( "bb_mp5_alt", "vgui/hud/bb_mp5_alt", icol  )
	killicon.Add( "bb_p90_alt", "vgui/hud/bb_p90_alt", icol  )
	killicon.Add( "bb_p228_alt", "vgui/hud/bb_p228_alt", icol  )
	killicon.Add( "bb_scout_alt", "vgui/hud/bb_scout_alt", icol  )
	killicon.Add( "bb_sg550_alt", "vgui/hud/bb_sg550_alt", icol  )
	killicon.Add( "bb_sg552_alt", "vgui/hud/bb_sg552_alt", icol  )
	killicon.Add( "bb_tmp_alt", "vgui/hud/bb_tmp_alt", icol  )
	killicon.Add( "bb_ump45_alt", "vgui/hud/bb_ump45_alt", icol  )
	killicon.Add( "bb_usp_alt", "vgui/hud/bb_usp_alt", icol  )
	killicon.Add( "bb_xm1014_alt", "vgui/hud/bb_xm1014_alt", icol  )
	killicon.Add( "bb_planted_alt_c4", "vgui/hud/bb_css_c4_alt", icol  )
	killicon.Add( "bb_css_knife_alt", "vgui/hud/bb_css_knife_alt", icol  )
	
	killicon.Add( "m9k_css_thrown_knife", "vgui/hud/bb_css_knife", icol  )
	
	language.Add("cssc4", "C4")
	language.Add("m9k_ammo_explosion", "Poor Decision Making Skills")
	
end

game.AddAmmoType( {
	name = "cssc4",
	dmgtype = DMG_BULLET
} )

sound.Add({
	name = 			"Weapon_G3SG1.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/g3sg1/g3sg1-1.wav"
})

sound.Add({
	name = 			"Weapon_Glock.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/glock/glock18-1.wav"
})

sound.Add({
	name = 			"Weapon_Galil.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/galil/galil-1.wav"
})

sound.Add({
	name = 			"Weapon_M249.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/m249/m249-1.wav"
})

sound.Add({
	name = 			"Weapon_XM1014.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/xm1014/xm1014-1.wav"
})

sound.Add({
	name = 			"Weapon_M3.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/m3/m3-1.wav"
})

sound.Add({
	name = 			"Weapon_MAC10.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/mac10/mac10-1.wav"
})

sound.Add({
	name = 			"Weapon_TMP.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/tmp/tmp-1.wav"
})

sound.Add({
	name = 			"Weapon_MP5Navy.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/mp5navy/mp5-1.wav"
})

sound.Add({
	name = 			"Weapon_P228.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/p228/p228-1.wav"
})

sound.Add({
	name = 			"Weapon_P90.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/p90/p90-1.wav"
})

sound.Add({
	name = 			"Weapon_Scout.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/scout/scout_fire-1.wav"
})

sound.Add({
	name = 			"Weapon_SG550.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/sg550/sg550-1.wav"
})

sound.Add({
	name = 			"Weapon_SG552.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/sg552/sg552-1.wav"
})

sound.Add({
	name = 			"Weapon_FiveSeven.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/fiveseven/fiveseven-1.wav"
})

sound.Add({
	name = 			"Weapon_UMP45.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/ump45/ump45-1.wav"
})

sound.Add({
	name = 			"Weapon_USP.2",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/usp/usp1.wav"
})

sound.Add({
	name = 			"Weapon_USP.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/usp/usp_unsil-1.wav"
})

sound.Add({
	name = 			"Weapon_M4A1.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/m4a1/m4a1_unsil-1.wav"
})

sound.Add({
	name = 			"Weapon_M4A1.2",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/m4a1/m4a1-1.wav"
})

sound.Add({
	name = 			"Weapon_ELITE.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/elite/elite-1.wav"
})

sound.Add({
	name = 			"Weapon_FAMAS.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/famas/famas-1.wav"
})

sound.Add({
	name = 			"Weapon_AUG.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/aug/aug-1.wav"
})

sound.Add({
	name = 			"Weapon_AWP.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/awp/awp1.wav"
})

sound.Add({
	name = 			"Weapon_DEagle.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/DEagle/deagle-1.wav"
})

sound.Add({
	name = 			"Weapon_AK47.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/ak47/ak47-1.wav"
})

sound.Add({
	name = 			"Weapon_AK47.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/ak47/ak47-1.wav"
})


//grenades
sound.Add({
	name = 			"2efault.PullPin_grenade",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/grenades/pinpull.mp3"
})

sound.Add({
	name = 			"2eapons/jingle.mp3",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/grenades/jingle.mp3"
})

//C4
sound.Add({
	name = 			"2eapon_c4.switchon",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2pr0d_c4/c4_switchon.mp3"
})

sound.Add({
	name = 			"2eapon_c4.click",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2pr0d_c4/c4_click.mp3"
})

sound.Add({
	name = 			"c4.click",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2pr0d_c4/c4_click.mp3"
})

//M249
sound.Add({
	name = 			"Alt_Weapon_M249.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2m249/m249-1.wav"
})

sound.Add({
	name = 			"2eapon_M249.Boxout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m249/m249_boxout.mp3"
})

sound.Add({
	name = 			"2eapon_M249.Coverup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m249/m249_coverup.mp3"
})

sound.Add({
	name = 			"2eapon_M249.Boxin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m249/m249_boxin.mp3"
})

sound.Add({
	name = 			"2eapon_M249.Chain",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m249/m249_chain.mp3"
})

sound.Add({
	name = 			"2eapon_M249.Coverdown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m249/m249_coverdown.mp3"
})

sound.Add({
	name = 			"2eapon_M249.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m249/m249_draw.mp3"
})

//DEagle
sound.Add({
	name = 			"Alt_Weapon_DEagle.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2deagle/deagle-1.wav"
})

sound.Add({
	name = 			"2eapon_Deagle.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2deagle/clipout.mp3"
})

sound.Add({
	name = 			"2eapon_Deagle.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2deagle/clipin.mp3"
})

sound.Add({
	name = 			"2eapon_Deagle.Slideforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2deagle/1911slideforward.mp3"
})

sound.Add({
	name = 			"2eapon_Deagle.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2deagle/1911slideback.mp3"
})

//Elites
sound.Add({
	name = 			"Alt_Weapon_ELITE.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2elite/elite-1.wav"
})

sound.Add({
	name = 			"2eapon_Elite.elite_reloadstart",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2elite/elite_reloadstart.mp3"
})

sound.Add({
	name = 			"2eapon_Elite.elite_leftclipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2elite/elite_leftclipin.mp3"
})

sound.Add({
	name = 			"2eapon_Elite.elite_rightclipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2elite/elite_rightclipin.mp3"
})

sound.Add({
	name = 			"2eapon_Elite.sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2elite/sliderelease.mp3"
})

sound.Add({
	name = 			"2eapon_Elite.elite_deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2elite/elite_deploy.mp3"
})

//FiveseveN
sound.Add({
	name = 			"Alt_Weapon_FiveSeven.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2fiveseven/fiveseven-1.wav"
})

sound.Add({
	name = 			"2eapon_57.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2fiveseven/clipout.mp3"
})

sound.Add({
	name = 			"2eapon_57.clipin1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2fiveseven/clipin1.mp3"
})

sound.Add({
	name = 			"2eapon_57.clipin2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2fiveseven/clipin2.mp3"
})

sound.Add({
	name = 			"2eapon_57.SlideForward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2fiveseven/slideforward.mp3"
})

sound.Add({
	name = 			"2eapon_57.SlideBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2fiveseven/slideback.mp3"
})

//Glock
sound.Add({
	name = 			"Alt_Weapon_Glock.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2glock/glock18-1.wav"
})

sound.Add({
	name = 			"2lideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2glock/slideback.mp3"
})

sound.Add({
	name = 			"2liderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2glock/sliderelease.mp3"
})

sound.Add({
	name = 			"2agout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2glock/magout.mp3"
})

sound.Add({
	name = 			"2agin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2glock/magin.mp3"
})

//P228
sound.Add({
	name = 			"Alt_Weapon_P228.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2p228/p228-1.wav"
})

sound.Add({
	name = 			"2eapon_p228.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2p228/clipout.mp3"
})

sound.Add({
	name = 			"2eapon_p228.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2p228/clipin.mp3"
})

sound.Add({
	name = 			"2eapon_p228.sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2p228/sliderelease.mp3"
})

sound.Add({
	name = 			"2eapon_p228.slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2p228/slideback.mp3"
})

sound.Add({
	name = 			"2eapon_p228.slideforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2p228/slideforward.mp3"
})

//AK47
sound.Add({
	name = 			"Alt_Weapon_AK47.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2ak47/ak47-1.wav"
})

sound.Add({
	name = 			"2eapon_AK47.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ak47/clipout.mp3"
})

sound.Add({
	name = 			"2eapon_AK47.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ak47/clipin.mp3"
})

sound.Add({
	name = 			"2eapon_AK47.BoltPull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ak47/boltpull.mp3"
})

sound.Add({
	name = 			"2eapon_AK47.BoltBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ak47/boltback.mp3"
})

//AUG
sound.Add({
	name = 			"Alt_Weapon_AUG.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2aug/aug-1.wav"
})

sound.Add({
	name = 			"2eapon_AUG.Forearm",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2aug/aug_forearm.mp3"
})

sound.Add({
	name = 			"2eapon_AUG.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2aug/aug_boltpull.mp3"
})

sound.Add({
	name = 			"2eapon_AUG.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2aug/aug_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_AUG.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2aug/aug_clipin.mp3"
})

sound.Add({
	name = 			"2eapon_AUG.Boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2aug/aug_boltslap.mp3"
})

//FAMAS
sound.Add({
	name = 			"Alt_Weapon_FAMAS.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2famas/famas-1.wav"
})

sound.Add({
	name = 			"2eapon_FAMAS.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2famas/famas_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_FAMAS.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2famas/famas_clipin.mp3"
})

sound.Add({
	name = 			"2eapon_FAMAS.Forearm",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2famas/famas_forearm.mp3"
})

//Galil
sound.Add({
	name = 			"Alt_Weapon_Galil.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2galil/galil-1.wav"
})

sound.Add({
	name = 			"2eapon_Galil.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2galil/magout.mp3"
})

sound.Add({
	name = 			"2eapon_Galil.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2galil/magin.mp3"
})

sound.Add({
	name = 			"2eapon_Galil.cliptap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2galil/tap.mp3"
})

sound.Add({
	name = 			"2eapon_Galil.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2galil/boltpull.mp3"
})

sound.Add({
	name = 			"2eapon_Galil.boltrelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2galil/boltrel.mp3"
})

//M4
sound.Add({
	name = 			"Alt_Weapon_M4A1.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		{"weapons/2m4a1/m4a1_unsil-1.wav",
					"weapons/2m4a1/m4a1_unsil-2.wav"}
})

sound.Add({
	name = 			"Alt_Weapon_M4A1.2",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			{"weapons/2m4a1/m4a1-1.wav",
						"weapons/2m4a1/m4a1-2.wav"}
})

sound.Add({
	name = 			"2eapon_M4A1.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m4a1/m4a1_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_M4A1.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m4a1/newclipin.mp3"
})

sound.Add({
	name = 			"2eapon_M4A1.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m4a1/m4a1_boltpull.mp3"
})

sound.Add({
	name = 			"2eapon_M4A1.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m4a1/safety.mp3"
})

sound.Add({
	name = 			"2eapon_M4A1.Silencer_On",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m4a1/m4a1_silencer_on.mp3"
})

sound.Add({
	name = 			"2eapon_M4A1.Silencer_Off",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m4a1/m4a1_silencer_off.mp3"
})

//Sig 552
sound.Add({
	name = 			"Alt_Weapon_SG552.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2sg552/sg552-1.wav"
})

sound.Add({
	name = 			"2eapon_SG552.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2sg552/sg552_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_SG552.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2sg552/sg552_clipin.mp3"
})

sound.Add({
	name = 			"2eapon_SG552.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2sg552/sg552_boltpull.mp3"
})

sound.Add({
	name = 			"2eapon_SG552.Stockfold",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2sg552/stockfold.mp3"
})

//M3 Super 90
sound.Add({
	name = 			"Alt_Weapon_M3.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2m3/m3-1.wav"
})
sound.Add({
	name = 			"2eapon_M3.Pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m3/m3_pump.mp3"
})

sound.Add({
	name = 			"2eapon_M3.Insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m3/m3_insertshell.mp3"
})

sound.Add({
	name = 			"2eapon_M3.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2m3/cloth.mp3"
})

//XM1014
sound.Add({
	name = 			"Alt_Weapon_XM1014.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			{"weapons/2xm1014/xm1014-1.wav",
						"weapons/2xm1014/xm1014-2.wav"}
})

sound.Add({
	name = 			"2eapon_XM1014.Insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2xm1014/xm_cock.mp3"
})

sound.Add({
	name = 			"2eapon_XM1014.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2xm1014/xm_insert.mp3"
})

sound.Add({
	name = 			"2eapon_XM1014.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2xm1014/xm_deploy.mp3"
})

//MAC 10
sound.Add({
	name = 			"Alt_Weapon_MAC10.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2mac10/mac10-1.wav"
})

sound.Add({
	name = 			"2eapon_MAC10.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2mac10/mac10_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_MAC10.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2mac10/mac10_clipin.mp3"
})

//MP5
sound.Add({
	name = 			"Alt_Weapon_MP5Navy.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2mp5navy/mp5-1.wav"
})

sound.Add({
	name = 			"2eapon_MP5Navy.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2mp5navy/mp5_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_MP5Navy.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2mp5navy/mp5_clipin.mp3"
})

sound.Add({
	name = 			"2eapon_MP5Navy.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2mp5navy/mp5_slideback.mp3"
})

//p90
sound.Add({
	name = 			"Alt_Weapon_P90.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2p90/p90-1.wav"
})

sound.Add({
	name = 			"2eapon_P90.unlock",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2p90/p90_unlock.mp3"
})

sound.Add({
	name = 			"2eapon_P90.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2p90/p90_magout.mp3"
})

sound.Add({
	name = 			"2eapon_P90.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2p90/p90_magin.mp3"
})

sound.Add({
	name = 			"2eapon_P90.cock",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2p90/p90_cock.mp3"
})

//TMP
sound.Add({
	name = 			"Alt_Weapon_TMP.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2tmp/tmp-1.wav"
})

sound.Add({
	name = 			"2eapon_TMP.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2tmp/tmp_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_TMP.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2tmp/tmp_clipin.mp3"
})

sound.Add({
	name = 			"2eapon_TMP.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2tmp/tmp_boltpull.mp3"
})

sound.Add({
	name = 			"2eapon_TMP.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2tmp/cloth.mp3"
})

//UMP45
sound.Add({
	name = 			"Alt_Weapon_UMP45.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2ump45/ump45-1.wav"
})

sound.Add({
	name = 			"2eapon_UMP45.Clipout1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ump45/ump45_clipout1.mp3"
})

sound.Add({
	name = 			"2eapon_UMP45.Clipout2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ump45/ump45_clipout2.mp3"
})

sound.Add({
	name = 			"2eapon_UMP45.Clipin1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ump45/ump45_clipin1.mp3"
})

sound.Add({
	name = 			"2eapon_UMP45.Clipin2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ump45/ump45_clipin2.mp3"
})

sound.Add({
	name = 			"2eapon_UMP45.Boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ump45/ump45_boltslap.mp3"
})

sound.Add({
	name = 			"2eapon_UMP45.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2ump45/ump45_cloth.mp3"
})

//AWP
sound.Add({
	name = 			"Alt_Weapon_AWP.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2awp/awp1.wav"
})

sound.Add({
	name = 			"2eapon_AWP.Bolt",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2awp/awp_bolt.mp3"
})

sound.Add({
	name = 			"2eapon_AWP.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2awp/awp_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_AWP.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2awp/awp_clipin.mp3"
})

//G3SG1
sound.Add({
	name = 			"Alt_Weapon_G3SG1.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2g3sg1/g3sg1-1.wav"
})

sound.Add({
	name = 			"2eapon_PSG_1.Boltpull1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2g3sg1/psg_1_boltpull1.mp3"
})

sound.Add({
	name = 			"2eapon_PSG_1.Boltpull2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2g3sg1/psg_1_boltpull2.mp3"
})

sound.Add({
	name = 			"2eapon_PSG_1.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2g3sg1/psg_1_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_PSG_1.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2g3sg1/psg_1_clipin.mp3"
})

sound.Add({
	name = 			"2eapon_PSG_1.Boltrelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2g3sg1/psg_1_boltrelease.mp3"
})

sound.Add({
	name = 			"2eapon_PSG_1.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2g3sg1/psg_1_draw.mp3"
})

//Scout
sound.Add({
	name = 			"Alt_Weapon_Scout.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2scout/scout_fire-1.wav"
})

sound.Add({
	name = 			"2eapon_scout.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2scout/m24_boltback.mp3"
})

sound.Add({
	name = 			"2eapon_scout.boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2scout/m24_boltforward.mp3"
})

sound.Add({
	name = 			"2eapon_scout.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2scout/m24_magout.mp3"
})

sound.Add({
	name = 			"2eapon_scout.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2scout/m24_magin.mp3"
})

//SG550
sound.Add({
	name = 			"Alt_Weapon_SG550.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2sg550/sg550-1.wav"
})

sound.Add({
	name = 			"2eapon_SG550.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2sg550/sg552_clipout.mp3"
})

sound.Add({
	name = 			"2eapon_SG550.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2sg550/sg552_clipin.mp3"
})

sound.Add({
	name = 			"2eapon_SG550.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2sg550/sg552_boltpull.mp3"
})

//USP
sound.Add({
	name = 			"Alt_Weapon_USP.2",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2usp/usp1.wav"
})

sound.Add({
	name = 			"Alt_Weapon_USP.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/2usp/usp_unsil-1.wav"
})

sound.Add({
	name = 			"2eapon_uspc.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2usp/magout.mp3"
})

sound.Add({
	name = 			"2eapon_uspc.magpouch",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2usp/magpouch.mp3"
})

sound.Add({
	name = 			"2eapon_uspc.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2usp/uspc_clipin.mp3"
})

sound.Add({
	name = 			"2eapon_uspc.sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2usp/sliderelease.mp3"
})

sound.Add({
	name = 			"2eapon_uspc.Safety",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2usp/safety.mp3"
})

sound.Add({
	name = 			"2eapon_USP.AttachSilencer",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2usp/usp_silencer_on.mp3"
})

sound.Add({
	name = 			"2eapon_USP.DetachSilencer",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/2usp/usp_silencer_off.mp3"
})

m9knpw = {}
table.insert(m9knpw, "m9k_davy_crockett_explo")
table.insert(m9knpw, "m9k_gdcwa_matador_90mm")
table.insert(m9knpw, "m9k_gdcwa_rpg_heat")
table.insert(m9knpw, "m9k_improvised_explosive")
table.insert(m9knpw, "m9k_launched_davycrockett")
table.insert(m9knpw, "m9k_launched_ex41")
table.insert(m9knpw, "m9k_launched_m79")
table.insert(m9knpw, "m9k_m202_rocket")
table.insert(m9knpw, "m9k_mad_c4")
table.insert(m9knpw, "m9k_milkor_nade")
table.insert(m9knpw, "m9k_nervegasnade")
table.insert(m9knpw, "m9k_nitro_vapor")
table.insert(m9knpw, "m9k_oribital_cannon")
table.insert(m9knpw, "m9k_poison_parent")
table.insert(m9knpw, "m9k_proxy")
table.insert(m9knpw, "m9k_released_poison")
table.insert(m9knpw, "m9k_sent_nuke_radiation")
table.insert(m9knpw, "m9k_thrown_harpoon")
table.insert(m9knpw, "m9k_thrown_knife")
table.insert(m9knpw, "m9k_thrown_m61")
table.insert(m9knpw, "m9k_thrown_nitrox")
table.insert(m9knpw, "m9k_thrown_spec_knife")
table.insert(m9knpw, "m9k_thrown_sticky_grenade")
table.insert(m9knpw, "bb_dod_bazooka_rocket")
table.insert(m9knpw, "bb_dod_panzershreck_rocket")
table.insert(m9knpw, "bb_garand_riflenade")
table.insert(m9knpw, "bb_k98_riflenade")
table.insert(m9knpw, "bb_planted_dod_tnt")
table.insert(m9knpw, "bb_thrownalliedfrag")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_thrownsmoke_axis")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_planted_alt_c4")
table.insert(m9knpw, "bb_planted_css_c4")
table.insert(m9knpw, "bb_throwncssfrag")
table.insert(m9knpw, "bb_throwncsssmoke")
table.insert(m9knpw, "m9k_ammo_40mm")
table.insert(m9knpw, "m9k_ammo_40mm_single")
table.insert(m9knpw, "m9k_ammo_357")
table.insert(m9knpw, "m9k_ammo_ar2")
table.insert(m9knpw, "m9k_ammo_buckshot")
table.insert(m9knpw, "m9k_ammo_c4")
table.insert(m9knpw, "m9k_ammo_frags")
table.insert(m9knpw, "m9k_ammo_ieds")
table.insert(m9knpw, "m9k_ammo_nervegas")
table.insert(m9knpw, "m9k_ammo_nuke")
table.insert(m9knpw, "m9k_ammo_pistol")
table.insert(m9knpw, "m9k_ammo_proxmines")
table.insert(m9knpw, "m9k_ammo_rockets")
table.insert(m9knpw, "m9k_ammo_smg")
table.insert(m9knpw, "m9k_ammo_sniper_rounds")
table.insert(m9knpw, "m9k_ammo_stickynades")
table.insert(m9knpw, "m9k_ammo_winchester")

function PocketM9KWeapons(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	m9knopocket = false
	
	for k, v in pairs(m9knpw) do
		if v == class then
			m9knopocket = true
			break
		end
	end
	
	if m9knopocket then
		return false
	end
	
end
hook.Add("canPocket", "PocketM9KWeapons", PocketM9KWeapons )

m9kcss_autorun_mounted = true
