/*===========================================================================
Animation(Consistent with the order of the model files,You can name yourself.
===========================================================================*/
enum ExamplePistolAnimation
{
	ExamplePistol_IDLE1 = 0,
	ExamplePistol_IDLE2,
	ExamplePistol_GRENADE,
	ExamplePistol_RELOAD1,
	ExamplePistol_DRAW,
	ExamplePistol_SHOOT,
	ExamplePistol_SHOOT2,
	ExamplePistol_SHOOT3,
};
//===========================================================================
//								Data
//===========================================================================
class weapon_hlmp5 : CustomWeapons::CBaseWeapon
{
	weapon_hlmp5()
	{
		m_IDLE 				= ExamplePistol_IDLE1;															//Idle Animation name
		m_FIDGET 			= ExamplePistol_IDLE2;															//Idle Animation name 2
		m_RELOAD 			= ExamplePistol_RELOAD1;														//Reload Animation name
		m_DRAW 				= ExamplePistol_DRAW;															//Draw Animation name
		m_SHOOT 			= ExamplePistol_SHOOT;															//Shoot Animation name
		m_SHOOT2			= ExamplePistol_SHOOT3;															//Shoot Animation name 2
		m_START_RELOAD		= 0;																			//Start Reload Animation name (shotgun)
		m_INSERT			= 0;																			//Insert Reload Animation name (shotgun)
		m_AFTER_RELOAD		= 0;																			//Finish Reload Animation name (shotgun)
		
		m_VModel 			= "models/hlclassic/v_9mmAR.mdl";												//V_model name
		m_PModel 			= "models/hlclassic/p_9mmAR.mdl";												//P_model name
		m_WModel 			= "models/hlclassic/w_9mmAR.mdl";												//W_model name
		m_SModel 			= "models/hlclassic/shell.mdl";													//shell model name
		
		m_strDryFireSound 	= "hl/weapons/357_cock1.wav";													//dry fire sound name
		m_FireSounds 		= "weapons/hks_hl1.wav";														//fire sound name
		
		m_strTextName 		= "hl_weapons/weapon_hlmp5.txt";												//sprite txt file name
		
		m_strAnimeName 		= "mp5";																		//Third Person Action
		
		m_iDefaultGive 		= 60;																			//Default Give ammo
		m_iDefaultGive2		= 5;																			//Default Give ammo 2
		m_iMaxAmmoAmount 	= 800;																			//Max ammo
		m_iMaxAmmoAmount2	= 15;																			//Max ammo 2
		m_iClipMax 			= 30;																			//Max clip
		m_iClipDrop			= 30;																			//Drop clip
		m_iClipDrop2		= 1;																			//Drop clip 2
		
		IsSecFire			= true;																			//Can we secconary fire ?

		IsSecAmmo			= true;																			//Can we use ammo 2 ?
		
		IsZoomMode			= false;																		//Can we make zoom ?
		m_iZoomSpeed		= 150;																			//Zoom moving speed
		m_iZoomFOV			= 40;																			//Zoom FOV
		m_ZoomSound			= "hl/weapons/357_cock1.wav";													//Zoom sound
		
		IsProj				= false;																		//Is Primary Firing Projectile ?
		pProjname			= "";																			//Projectile type e.p :"bolts" or "item_battery"
		ProjOrgX			= 0;																			//Projectile origin , forward
		ProjOrgY			= 0;																			//Projectile origin , right
		ProjOrgZ			= 0;																			//Projectile origin , up
		ProjOrgV			= 0;																			//Projectile speed
		
		IsSubProj			= true;																			//Is secconary Firing Projectile ?
		strSubProjName		= "grenade";																	//Projectile type e.p :"bolts" or "item_battery"
		SubProjOrgX			= 5;																			//Projectile origin , forward
		SubProjOrgY			= 3;																			//Projectile origin , right
		SubProjOrgZ			= 2;																			//Projectile origin , up
		SubProjOrgV			= 1000;																			//Projectile speed
		
		m_iSlotAmount 		= 2;																			//Slot
		m_iPositionAmount 	= 15;																			//Position
		m_iWeightAmount 	= 7;																			//Weight
		m_iDamegeAmount 	= 14;																			//Damege
		FireAmount			= 1;																			//Primary Bullets consumed pre firing
		FireAmount2			= 1;																			//Secconary Bullets consumed pre firing
		m_DeployTime 		= 0.24;																			//Deploying time
		m_FireTime 			= 0.1;																			//Firing interval 
		m_ReloadTime 		= 2.6;																			//Reloading time
		
		m_XPunchMax 		= -10;																			//Max Recoil , Y
		m_XPunchMin 		= -5;																			//Min Recoil , Y
		m_YPunchMax 		= 0;																			//Max Recoil , X
		m_YPunchMin 		= 0;																			//Min Recoil , X
		
		m_iAcc 				= VECTOR_CONE_1DEGREES;															//Primary Firing Accurancy
		m_iAcc2				= VECTOR_CONE_4DEGREES;															//Secconary Firing Accurancy
		
		m_iDamegeAmount2	= 11;																			//Secconary Firing Damege
		m_FireTime2			= 0.95;																			//Secconary Firing interval 
		m_FireSubSounds		= "weapons/hks_hl2.wav";														//Secconary Firing sound
		
		m_ShellOrgX 		= 17;																			//Shell origin , forward
		m_ShellOrgY 		= 7;																			//Shell origin , right
		m_ShellOrgZ 		= -8;																			//Shell origin , up
		
		m_ShellDirXMax 		= -25;																			//Max Shell speed , forward
		m_ShellDirXMin 		= 25;																			//Min Shell speed , forward
		m_ShellDirYMax 		= 60;																			//Max Shell speed , right
		m_ShellDirYMin		= 80;																			//Min Shell speed , right
		m_ShellDirZMax		= 15;																			//Max Shell speed , up
		m_ShellDirZMin		= 25;																			//Min Shell speed , up
		
		IsShotGun			= false;																		//Is it a shotgun ?
		m_PumpTime			= 0 ;																			//Pump time
		m_InsertTime		= 0 ;																			//Insert shell time
		m_FinishInsertTime	= 0 ;																			//Finish reload time
		ShotGunPelletCount  = 0 ;																			//Pellet Amount
		vecShotgunDM		= Vector (0,0,0);																//Pellet spread
		
		PumpSounds			= "";																			//Pump sound
		ShotgunFinishSound	= "";																			//Finish sound
		ShotgunInsertSound	= "";																			//Insert sound
		
		m_PumpTime2			= 0 ;																			//Secconary Pump sound
		ShotGunSubPelletCount= 0 ;																			//Secconary Pellet Amount
		vecShotgunDM2 		= Vector (0,0,0);																//Secconary Pellet spread

		g_WeaponModel 		= {};																			//Other used Models except V P W and shell 
		
		g_WeaponSound 		= {	"hl/items/clipinsert1.wav",
								"hl/items/cliprelease1.wav",
								"hl/items/guncock1.wav"};													//Other used Sounds except Firing, Dry firing, Pump ,Finish Reload ,Insert
		g_WeaponSprites 	= {	"640hud1.spr",
								"640hud4.spr",
								"640hud7.spr",
								"crosshairs.spr"};															//Uesed sprites
	}
}
/*===========================================================================
								Register
===========================================================================*/
void RegisterExm9mm()
//You Have to rename the Regiter.
{
	g_CustomEntityFuncs.RegisterCustomEntity( "weapon_hlmp5", "weapon_hlmp5" );
	g_ItemRegistry.RegisterWeapon( "weapon_hlmp5", "hl_weapons", "9mm", "ARgrenades" ,"ammo_9mmclip" , "ammo_ARgrenades");
	//"Weapon name"，"folder containing txt file name"，"Primary ammo type"，"Secconary ammo type"，"Primary ammo entity"，"Secconary ammo entity"
}