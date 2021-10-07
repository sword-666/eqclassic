/*===========================================================================
Animation(Consistent with the order of the model files,You can name yourself.
===========================================================================*/
enum ShotgunAnimation
{
	SHOTGUN_IDLE = 0,
	SHOTGUN_FIRE,
	SHOTGUN_FIRE2,
	SHOTGUN_RELOAD,
	SHOTGUN_PUMP,
	SHOTGUN_START_RELOAD,
	SHOTGUN_DRAW,
	SHOTGUN_HOLSTER,
	SHOTGUN_IDLE4,
	SHOTGUN_IDLE_DEEP
};
//===========================================================================
//								Data
//===========================================================================
class weapon_hlshotgun : CustomWeapons::CBaseWeapon
{
	weapon_hlshotgun()
	{
		m_IDLE 				= SHOTGUN_IDLE;																	//Idle Animation name
		m_FIDGET 			= SHOTGUN_IDLE_DEEP;															//Idle Animation name 2
		m_RELOAD 			= 0;																			//Reload Animation name
		m_DRAW 				= SHOTGUN_DRAW;																	//Draw Animation name
		m_SHOOT 			= SHOTGUN_FIRE;																	//Shoot Animation name
		m_SHOOT2			= SHOTGUN_FIRE2;																//Shoot Animation name 2
		m_START_RELOAD		= SHOTGUN_START_RELOAD;															//Start Reload Animation name (shotgun)
		m_INSERT			= SHOTGUN_RELOAD;																//Insert Reload Animation name (shotgun)
		m_AFTER_RELOAD		= SHOTGUN_PUMP;																	//Finish Reload Animation name (shotgun)
		
		m_VModel 			= "models/hlclassic/v_shotgun.mdl";									 			//V_model name
		m_PModel 			= "models/hlclassic/p_shotgun.mdl";												//P_model name
		m_WModel 			= "models/hlclassic/w_shotgun.mdl";												//W_model name
		m_SModel 			= "models/hlclassic/shotgunshell.mdl";											//shell model name
		
		m_strDryFireSound 	= "hl/weapons/357_cock1.wav";													//dry fire sound name
		m_FireSounds 		= "hlclassic/weapons/sbarrel1.wav";												//fire sound name
		
		m_strTextName 		= "hl_weapons/weapon_hlshotgun.txt";											//sprite txt file name
		
		m_strAnimeName 		= "shotgun";																	//Third Person Action
		
		m_iDefaultGive 		= 60;																			//Default Give ammo										
		m_iMaxAmmoAmount 	= 125;																			//Max ammo
		m_iClipMax 			= 8;																			//Max clip
		m_iClipDrop			= 8;																			//Drop clip
		
		m_iSlotAmount 		= 2;																			//Slot
		m_iPositionAmount 	= 16;																			//Position
		m_iWeightAmount 	= 7;																			//Weight
		m_iDamegeAmount 	= 14;																			//Damege
		FireAmount			= 1;																			//Primary Bullets consumed pre firing
		FireAmount2			= 2;																			//Secconary Bullets consumed pre firing
		m_DeployTime 		= 0.24;																			//Deploying time
		m_FireTime 			= 0.85;																			//Firing interval 
		
		m_XPunchMax 		= -8;																			//Max Recoil , Y
		m_XPunchMin 		= -5;																			//Min Recoil , Y
		m_YPunchMax 		= 0;																			//Max Recoil , X
		m_YPunchMin 		= 0;																			//Min Recoil , X
		
		m_iAcc 				= VECTOR_CONE_1DEGREES;															//Primary Firing Accurancy
		m_iAcc2				= VECTOR_CONE_4DEGREES;															//Secconary Firing Accurancy
		
		IsSecFire			= true;																			//Can we secconary fire ?
		m_iDamegeAmount2	= 11;																			//Secconary Firing Damege
		
		m_FireTime2			= 1.5;																			//Secconary Firing interval 
		m_FireSubSounds		= "hlclassic/weapons/dbarrel1.wav";												//Secconary Firing sound
		
		m_ShellOrgX 		= 17;																			//Shell origin , forward
		m_ShellOrgY 		= 7;																			//Shell origin , right
		m_ShellOrgZ 		= -8;																			//Shell origin , up
		
		m_ShellDirXMax 		= -25;																			//Max Shell speed , forward
		m_ShellDirXMin 		= 25;																			//Min Shell speed , forward
		m_ShellDirYMax 		= 60;																			//Max Shell speed , right
		m_ShellDirYMin		= 80;																			//Min Shell speed , right
		m_ShellDirZMax		= 15;																			//Max Shell speed , up
		m_ShellDirZMin		= 25;																			//Min Shell speed , up
		
		IsShotGun			= true;																			//Is it a shotgun ?
		m_PumpTime			= 0.6 ;																			//Pump time
		m_InsertTime		= 0.1 ;																			//Insert shell time
		m_FinishInsertTime	= 0.5 ;																			//Finish reload time
		ShotGunPelletCount  = 4 ;																			//Pellet Amount
		vecShotgunDM		= Vector ( 0.08716, 0.04362, 0.00  );											//Pellet spread
		
		PumpSounds			= "hlclassic/weapons/scock1.wav";												//Pump sound
		ShotgunFinishSound	= "hlclassic/weapons/scock1.wav";												//Finish sound
		ShotgunInsertSound	= "hlclassic/weapons/reload3.wav";												//Insert sound
		
		m_PumpTime2			= 1 ;																			//Secconary Pump sound
		ShotGunSubPelletCount= 8 ;																			//Secconary Pellet Amount
		vecShotgunDM2 = Vector ( 0.17365, 0.04362, 0.00 );													//Secconary Pellet spread

		g_WeaponModel 		= {};																			//Other used Models except V P W and shell 
		
		g_WeaponSound 		= {	"items/9mmclip1.wav"};														//Other used Sounds except Firing, Dry firing, Pump ,Finish Reload ,Insert
		g_WeaponSprites 	= {	"640hud1.spr",
								"640hud4.spr",
								"640hud7.spr",
								"crosshairs.spr"};															//Uesed sprites
	}
}
/*===========================================================================
								Register
===========================================================================*/
void RegisterExmShotgun()
{
	g_CustomEntityFuncs.RegisterCustomEntity( "weapon_hlshotgun", "weapon_hlshotgun" );
	g_ItemRegistry.RegisterWeapon( "weapon_hlshotgun", "hl_weapons", "buckshot", "" ,"ammo_buckshot" , "");
//"Weapon name"，"folder containing txt file name"，"Primary ammo type"，"Secconary ammo type"，"Primary ammo entity"，"Secconary ammo entity"
}