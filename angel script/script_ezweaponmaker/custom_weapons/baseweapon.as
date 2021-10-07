/* Don't do any change over here unless you know what are you doing  --Dr.Abc*/
namespace CustomWeapons{
class CBaseWeapon : ScriptBasePlayerWeaponEntity{
  protected string m_WModel = "models/error.mdl";
  protected string m_VModel = "models/error.mdl";
  protected string m_PModel = "models/error.mdl";
  protected string m_SModel = "models/error.mdl";
  protected string m_strDryFireSound = "hl/weapons/357_cock1.wav";
  protected string m_strAnimeName,m_FireSounds,m_strTextName;
  protected int m_iShell,m_iDefaultGive,m_iMaxAmmoAmount,m_iClipMax,m_iClipDrop,m_iSlotAmount,m_iPositionAmount,m_iWeightAmount,m_iDamegeAmount,m_iDamegeAmount2,m_iMaxAmmoAmount2,m_iClipDrop2,m_iDefaultGive2;
  protected float m_DeployTime,m_FireTime,m_ReloadTime;
  protected float m_XPunchMax,m_XPunchMin,m_YPunchMax,m_YPunchMin;
  protected float m_ShellOrgX,m_ShellOrgY,m_ShellOrgZ;
  protected int8  m_ShellDirXMax,m_ShellDirXMin,m_ShellDirYMax,m_ShellDirYMin,m_ShellDirZMax,m_ShellDirZMin;
  protected bool IsShotGun,m_fPlayPumpSound,m_fShotgunReload,m_flShotGunNextReload,IsSecFire,IsSecAmmo;
  protected float m_flPumpTime,m_flNextReload;
  protected float m_PumpTime,m_InsertTime,m_FinishInsertTime;
  protected uint ShotGunPelletCount,ShotGunSubPelletCount;
  protected string PumpSounds,ShotgunFinishSound,ShotgunInsertSound,m_FireSubSounds;
  protected Vector vecShotgunDM = Vector (0,0,0);
  protected int8 m_IDLE,m_FIDGET,m_RELOAD,m_DRAW,m_SHOOT,m_SHOOT2,m_AFTER_RELOAD,m_START_RELOAD,m_INSERT,FireAmount,FireAmount2;
  protected Vector m_iAcc,m_iAcc2;
  protected float m_PumpTime2,m_FireTime2;
  protected Vector vecShotgunDM2 = Vector (0,0,0);
  protected bool bInZoom = false;
  protected bool IsProj,IsSubProj,IsZoomMode;
  protected int m_iZoomSpeed,m_iZoomFOV;
  protected int	m_iSecondaryAmmo;
  protected string pProjname,strSubProjName;
  protected string m_ZoomSound = "hl/weapons/357_cock1.wav";
  protected float ProjOrgX,ProjOrgY,ProjOrgZ,ProjOrgV,SubProjOrgX,SubProjOrgY,SubProjOrgZ,SubProjOrgV;
  protected CBasePlayer@ m_pPlayer = null;
  protected array<string> g_WeaponModel,g_WeaponSound,g_WeaponSprites;
 void Spawn(){Precache();
  g_EntityFuncs.SetModel( self, m_WModel );
  self.m_iDefaultAmmo = m_iDefaultGive;
  self.m_iDefaultSecAmmo = m_iDefaultGive2;
  self.m_iSecondaryAmmoType = 0;
  self.FallInit();}
 void Precache(){
  self.PrecacheCustomModels();
  for (uint i = 0; i < g_WeaponModel.length(); ++i) {
   g_Game.PrecacheModel(g_WeaponModel[i]);}
  for (uint i = 0; i < g_WeaponSound.length(); ++i) {
   g_Game.PrecacheGeneric("sound/" + g_WeaponSound[i]);
   g_SoundSystem.PrecacheSound(g_WeaponSound[i]);}
  for (uint i = 0; i < g_WeaponSprites.length(); ++i) {
   g_Game.PrecacheModel("sprites/" + g_WeaponSprites[i]);
   g_Game.PrecacheGeneric("sprites/" + g_WeaponSprites[i]);}
  g_Game.PrecacheModel( m_WModel );
  g_Game.PrecacheModel( m_VModel );
  g_Game.PrecacheModel( m_PModel );
  m_iShell = g_Game.PrecacheModel( m_SModel );
  g_Game.PrecacheGeneric("sound/" + m_FireSounds);g_SoundSystem.PrecacheSound(m_FireSounds);
  g_Game.PrecacheGeneric("sound/" + m_FireSubSounds);g_SoundSystem.PrecacheSound(m_FireSubSounds);
  g_Game.PrecacheGeneric("sound/" + PumpSounds);g_SoundSystem.PrecacheSound(PumpSounds);
  g_Game.PrecacheGeneric("sound/" + m_strDryFireSound);g_SoundSystem.PrecacheSound(m_strDryFireSound);
  g_Game.PrecacheGeneric("sound/" + ShotgunFinishSound);g_SoundSystem.PrecacheSound(ShotgunFinishSound);
  g_Game.PrecacheGeneric("sound/" + ShotgunInsertSound);g_SoundSystem.PrecacheSound(ShotgunInsertSound);
  g_Game.PrecacheGeneric("sprites/" + m_strTextName);}
 bool GetItemInfo( ItemInfo& out info ){
 info.iMaxAmmo1  = m_iMaxAmmoAmount;
 info.iMaxAmmo2  = m_iMaxAmmoAmount2;
 info.iAmmo1Drop = m_iClipDrop;
 info.iAmmo2Drop = m_iClipDrop2;
 info.iMaxClip 	 = m_iClipMax;
 info.iSlot      = m_iSlotAmount;
 info.iPosition  = m_iPositionAmount;
 info.iFlags 	 = 0;
 info.iWeight 	 = m_iWeightAmount;
 return true;}
 bool AddToPlayer( CBasePlayer@ pPlayer ){
  if( BaseClass.AddToPlayer( pPlayer ) == true ){
  NetworkMessage message( MSG_ONE, NetworkMessages::WeapPickup, pPlayer.edict() );
  message.WriteLong( self.m_iId );
  message.End();
  @m_pPlayer = pPlayer;
  return true;
 }return false;}
 bool PlayEmptySound(){
  if( self.m_bPlayEmptySound ){
    self.m_bPlayEmptySound = false;			
    g_SoundSystem.EmitSoundDyn( m_pPlayer.edict(), CHAN_WEAPON, m_strDryFireSound, 0.8, ATTN_NORM, 0, PITCH_NORM );}	
   return false;}
 bool Deploy(){
   bool bResult;{
   bResult = self.DefaultDeploy( self.GetV_Model( m_VModel ), self.GetP_Model( m_PModel ), m_DRAW, m_strAnimeName );
   float deployTime = m_DeployTime;
   self.m_flTimeWeaponIdle = self.m_flNextPrimaryAttack = self.m_flNextSecondaryAttack = g_Engine.time + deployTime;
   return bResult;}}
 float WeaponTimeBase()
 {return g_Engine.time;}
 void ItemPostFrame(){
  if(IsShotGun){
  if( m_flPumpTime != 0 && m_flPumpTime < g_Engine.time && m_fPlayPumpSound )
  {g_SoundSystem.EmitSoundDyn( m_pPlayer.edict(), CHAN_ITEM, PumpSounds, 1, ATTN_NORM, 0, 95 + Math.RandomLong( 0,0x1f ) );m_fPlayPumpSound = false;
  g_EntityFuncs.EjectBrass( m_pPlayer.GetGunPosition() + g_Engine.v_forward * m_ShellOrgX + g_Engine.v_right * m_ShellOrgY + g_Engine.v_up * m_ShellOrgZ, g_Engine.v_forward * Math.RandomLong(m_ShellDirXMin,m_ShellDirXMax) + g_Engine.v_right * Math.RandomLong(m_ShellDirYMin,m_ShellDirYMax)+ g_Engine.v_up * Math.RandomLong(m_ShellDirZMin,m_ShellDirZMax), m_pPlayer.pev.angles[ 1 ], m_iShell, TE_BOUNCE_SHOTSHELL );}}
  BaseClass.ItemPostFrame();}
 void CreatePelletDecals( const Vector& in vecSrc, const Vector& in vecAiming, const Vector& in vecSpread, const uint uiPelletCount ){
TraceResult tr;float x, y;
 for( uint uiPellet = 0; uiPellet < uiPelletCount; ++uiPellet ){
  g_Utility.GetCircularGaussianSpread( x, y );
  Vector vecDir = vecAiming + x * vecSpread.x * g_Engine.v_right + y * vecSpread.y * g_Engine.v_up;
  Vector vecEnd	= vecSrc + vecDir * 2048;
  g_Utility.TraceLine( vecSrc, vecEnd, dont_ignore_monsters, m_pPlayer.edict(), tr );
  if( tr.flFraction < 1.0 ){
   if( tr.pHit !is null ){
    CBaseEntity@ pHit = g_EntityFuncs.Instance( tr.pHit );
    if( pHit is null || pHit.IsBSPModel() )
     g_WeaponFuncs.DecalGunshot( tr, BULLET_PLAYER_BUCKSHOT );}}}}
 void PrimaryAttack(){
  if( m_pPlayer.pev.waterlevel == WATERLEVEL_HEAD ){
   self.PlayEmptySound( );
   self.m_flNextPrimaryAttack = WeaponTimeBase() + m_FireTime + 0.3;self.m_flNextSecondaryAttack = WeaponTimeBase() + m_FireTime2 + 0.3;
   return;}
  if( self.m_iClip <= 0 ){
   self.PlayEmptySound();
   self.m_flNextPrimaryAttack = WeaponTimeBase() + m_FireTime + 0.3;self.m_flNextSecondaryAttack = WeaponTimeBase() + m_FireTime2 + 0.3;
   return;}
   if( self.m_iClip < FireAmount ){
   self.Reload();return;}
 m_pPlayer.m_iWeaponVolume = NORMAL_GUN_VOLUME;
 m_pPlayer.m_iWeaponFlash = NORMAL_GUN_FLASH;
 self.m_iClip -= FireAmount;
 self.SendWeaponAnim( m_SHOOT );
 g_SoundSystem.EmitSoundDyn( m_pPlayer.edict(), CHAN_WEAPON, m_FireSounds, 1.0, ATTN_NORM, 0, 95 + Math.RandomLong( 0, 10 ) );
 m_pPlayer.SetAnimation( PLAYER_ATTACK1 );
 if(IsProj){
   if(pProjname == "grenade"){
   CBaseEntity@ pProj = g_EntityFuncs.ShootContact(m_pPlayer.pev,  m_pPlayer.GetGunPosition() + g_Engine.v_forward * ProjOrgX + g_Engine.v_up * ProjOrgZ + g_Engine.v_right * ProjOrgY ,g_Engine.v_forward * ProjOrgV);}
   else{
   CBaseEntity@ pProj = g_EntityFuncs.Create( pProjname, m_pPlayer.GetGunPosition() + g_Engine.v_forward * ProjOrgX + g_Engine.v_up * ProjOrgZ + g_Engine.v_right * ProjOrgY,  m_pPlayer.pev.v_angle + m_pPlayer.pev.punchangle, false);
   pProj.pev.velocity = g_Engine.v_forward * ProjOrgV ;
   @pProj.pev.owner = m_pPlayer.pev.pContainingEntity;
   pProj.pev.angles = Math.VecToAngles( pProj.pev.velocity );
   pProj.pev.nextthink = g_Engine.time + 0.1f;}self.m_flNextPrimaryAttack = WeaponTimeBase() + m_FireTime;self.m_flNextSecondaryAttack = WeaponTimeBase() + m_FireTime2 + m_FireTime;return;}
 Vector vecSrc	 = m_pPlayer.GetGunPosition();
 Vector vecAiming = m_pPlayer.GetAutoaimVector( AUTOAIM_5DEGREES );
 int m_iBulletDamage = m_iDamegeAmount + Math.RandomLong( -1, 1 );
 m_pPlayer.FireBullets( IsShotGun?int(ShotGunPelletCount):1, vecSrc, vecAiming, m_iAcc, 8192, BULLET_PLAYER_CUSTOMDAMAGE, 2, m_iBulletDamage );
 if( self.m_iClip == 0 && m_pPlayer.m_rgAmmo( self.m_iPrimaryAmmoType ) <= 0 )
  m_pPlayer.SetSuitUpdate( "!HEV_AMO0", false, 0 );
 if(IsShotGun){
  if( self.m_iClip != 0 ){
   m_flPumpTime = g_Engine.time + m_PumpTime;self.m_flTimeWeaponIdle = g_Engine.time + m_PumpTime;}
  else {self.m_flNextPrimaryAttack = self.m_flTimeWeaponIdle = g_Engine.time + m_FireTime;self.m_flNextSecondaryAttack = WeaponTimeBase() + m_FireTime2 + m_FireTime + + m_PumpTime;}}
 if(IsShotGun)
   m_fShotgunReload = false;m_fPlayPumpSound = true;
 m_pPlayer.pev.punchangle.x = Math.RandomFloat( m_XPunchMax, m_XPunchMin );
 m_pPlayer.pev.punchangle.y = Math.RandomFloat( m_YPunchMax, m_YPunchMin );		
 if( self.m_flNextPrimaryAttack < WeaponTimeBase() )
  self.m_flNextPrimaryAttack = WeaponTimeBase() + m_FireTime;
 self.m_flTimeWeaponIdle = WeaponTimeBase() + Math.RandomFloat( 10, 15 );	
 if(!IsShotGun){
 TraceResult tr;	
 float x, y;	
 g_Utility.GetCircularGaussianSpread( x, y );
 Vector vecDir = vecAiming + x * VECTOR_CONE_6DEGREES.x * g_Engine.v_right + y * VECTOR_CONE_6DEGREES.y * g_Engine.v_up;
 Vector vecEnd	= vecSrc + vecDir * 4096;
   g_Utility.TraceLine( vecSrc, vecEnd, dont_ignore_monsters, m_pPlayer.edict(), tr );
   if( tr.flFraction < 1.0 ){
    if( tr.pHit !is null ){
  CBaseEntity@ pHit = g_EntityFuncs.Instance( tr.pHit );
   if( pHit is null || pHit.IsBSPModel() == true )
    g_WeaponFuncs.DecalGunshot( tr, BULLET_PLAYER_MP5 );}}
  g_EntityFuncs.EjectBrass( m_pPlayer.GetGunPosition() + g_Engine.v_forward * m_ShellOrgX + g_Engine.v_right * m_ShellOrgY + g_Engine.v_up * m_ShellOrgZ, g_Engine.v_forward * Math.RandomLong(m_ShellDirXMin,m_ShellDirXMax) + g_Engine.v_right * Math.RandomLong(m_ShellDirYMin,m_ShellDirYMax)+ g_Engine.v_up * Math.RandomLong(m_ShellDirZMin,m_ShellDirZMax), m_pPlayer.pev.angles[ 1 ], m_iShell, TE_BOUNCE_SHELL );}else{CreatePelletDecals( vecSrc, vecAiming, vecShotgunDM, ShotGunPelletCount );}}
   void SecondaryAttack(){
   if(IsZoomMode){
   if(!bInZoom){bInZoom = true;m_pPlayer.pev.maxspeed = m_iZoomSpeed;ToggleZoom( m_iZoomFOV );m_pPlayer.m_szAnimExtension = "sniperscope";}
   else{bInZoom = false;m_pPlayer.pev.maxspeed = 0;ToggleZoom( 0 );m_pPlayer.m_szAnimExtension = m_strAnimeName;}
   g_SoundSystem.EmitSoundDyn( m_pPlayer.edict(), CHAN_ITEM, m_ZoomSound, 1.0, ATTN_NORM, 0, 95 + Math.RandomLong( 0, 10 ) );
   self.m_flNextSecondaryAttack = WeaponTimeBase() + m_FireTime2;self.m_flNextPrimaryAttack = WeaponTimeBase() + m_FireTime + m_FireTime2;}
   if(IsSecFire && !IsZoomMode){
  if( m_pPlayer.pev.waterlevel == WATERLEVEL_HEAD ){
   self.PlayEmptySound( );
   self.m_flNextSecondaryAttack = WeaponTimeBase() + m_FireTime2 + 0.3;self.m_flNextPrimaryAttack = WeaponTimeBase() + m_FireTime + 0.3;
   return;}
   if(IsSecAmmo){if( m_pPlayer.m_rgAmmo(self.m_iSecondaryAmmoType) <= 0 ){self.PlayEmptySound();return;}
	}else{
  if( self.m_iClip <= 0 ){
   self.PlayEmptySound();
   self.m_flNextSecondaryAttack = WeaponTimeBase() + m_FireTime2 + 0.3;self.m_flNextPrimaryAttack = WeaponTimeBase() + m_FireTime + 0.3;
   return;}
   if( self.m_iClip < FireAmount2 ){
   self.Reload();return;}}
 m_pPlayer.m_iWeaponVolume = NORMAL_GUN_VOLUME;
 m_pPlayer.m_iWeaponFlash = NORMAL_GUN_FLASH;
 if(IsSecAmmo){m_pPlayer.m_rgAmmo( self.m_iSecondaryAmmoType, m_pPlayer.m_rgAmmo( self.m_iSecondaryAmmoType ) - 1 );}
 else{self.m_iClip -= FireAmount2;}
 self.SendWeaponAnim( m_SHOOT2 );
 g_SoundSystem.EmitSoundDyn( m_pPlayer.edict(), CHAN_WEAPON, m_FireSubSounds, 1.0, ATTN_NORM, 0, 95 + Math.RandomLong( 0, 10 ) );
 m_pPlayer.SetAnimation( PLAYER_ATTACK1 );
 if(IsSubProj){
   if(strSubProjName == "grenade"){
    CBaseEntity@ pProj = g_EntityFuncs.ShootContact(m_pPlayer.pev, m_pPlayer.GetGunPosition() + g_Engine.v_forward * SubProjOrgX + g_Engine.v_up * SubProjOrgZ + g_Engine.v_right * SubProjOrgY,g_Engine.v_forward * SubProjOrgV);}
   else{
    CBaseEntity@ pProj = g_EntityFuncs.Create( strSubProjName, m_pPlayer.GetGunPosition() + g_Engine.v_forward * SubProjOrgX + g_Engine.v_up * SubProjOrgZ + g_Engine.v_right * SubProjOrgY,  m_pPlayer.pev.v_angle + m_pPlayer.pev.punchangle, false);
    pProj.pev.velocity = g_Engine.v_forward * SubProjOrgV ;
    @pProj.pev.owner = m_pPlayer.pev.pContainingEntity;
    pProj.pev.angles = Math.VecToAngles( pProj.pev.velocity );
    pProj.pev.nextthink = g_Engine.time + 0.1f;}
	self.m_flNextSecondaryAttack = WeaponTimeBase() + m_FireTime2;self.m_flNextPrimaryAttack = WeaponTimeBase() + m_FireTime + m_FireTime2;return;}
 Vector vecSrc	 = m_pPlayer.GetGunPosition();
 Vector vecAiming = m_pPlayer.GetAutoaimVector( AUTOAIM_5DEGREES );
 int m_iBulletDamage = m_iDamegeAmount2 + Math.RandomLong( -1, 1 );
 m_pPlayer.FireBullets( IsShotGun?int(ShotGunSubPelletCount):1, vecSrc, vecAiming, m_iAcc2, 8192, BULLET_PLAYER_CUSTOMDAMAGE, 2, m_iBulletDamage );
 if( self.m_iClip == 0 && m_pPlayer.m_rgAmmo( self.m_iPrimaryAmmoType ) <= 0 )
  m_pPlayer.SetSuitUpdate( "!HEV_AMO0", false, 0 );
 if(IsShotGun){
  if( self.m_iClip != 0 ){
   m_flPumpTime = g_Engine.time + m_PumpTime2;self.m_flTimeWeaponIdle = g_Engine.time + m_PumpTime2;}
  else {self.m_flNextSecondaryAttack = self.m_flTimeWeaponIdle = g_Engine.time + m_FireTime2;self.m_flNextPrimaryAttack = WeaponTimeBase() + m_FireTime + m_FireTime2 + m_PumpTime2;}}
 if(IsShotGun)
   m_fShotgunReload = false;m_fPlayPumpSound = true;
 m_pPlayer.pev.punchangle.x = Math.RandomFloat( m_XPunchMax, m_XPunchMin );
 m_pPlayer.pev.punchangle.y = Math.RandomFloat( m_YPunchMax, m_YPunchMin );		
 if( self.m_flNextSecondaryAttack < WeaponTimeBase() )
  self.m_flNextSecondaryAttack = WeaponTimeBase() + m_FireTime2;
 self.m_flTimeWeaponIdle = WeaponTimeBase() + Math.RandomFloat( 10, 15 );	
 if(!IsShotGun){
 TraceResult tr;	
 float x, y;	
 g_Utility.GetCircularGaussianSpread( x, y );
 Vector vecDir = vecAiming + x * VECTOR_CONE_6DEGREES.x * g_Engine.v_right + y * VECTOR_CONE_6DEGREES.y * g_Engine.v_up;
 Vector vecEnd	= vecSrc + vecDir * 4096;
   g_Utility.TraceLine( vecSrc, vecEnd, dont_ignore_monsters, m_pPlayer.edict(), tr );
   if( tr.flFraction < 1.0 ){
    if( tr.pHit !is null ){
  CBaseEntity@ pHit = g_EntityFuncs.Instance( tr.pHit );
   if( pHit is null || pHit.IsBSPModel() == true )
    g_WeaponFuncs.DecalGunshot( tr, BULLET_PLAYER_MP5 );}}
  g_EntityFuncs.EjectBrass( m_pPlayer.GetGunPosition() + g_Engine.v_forward * m_ShellOrgX + g_Engine.v_right * m_ShellOrgY + g_Engine.v_up * m_ShellOrgZ, g_Engine.v_forward * Math.RandomLong(m_ShellDirXMin,m_ShellDirXMax) + g_Engine.v_right * Math.RandomLong(m_ShellDirYMin,m_ShellDirYMax)+ g_Engine.v_up * Math.RandomLong(m_ShellDirZMin,m_ShellDirZMax), m_pPlayer.pev.angles[ 1 ], m_iShell, TE_BOUNCE_SHELL );}else{CreatePelletDecals( vecSrc, vecAiming, vecShotgunDM2, ShotGunSubPelletCount );}}}
 void WeaponIdle()
 {self.ResetEmptySound();
  m_pPlayer.GetAutoaimVector( AUTOAIM_5DEGREES );
 if( self.m_flTimeWeaponIdle > WeaponTimeBase() )
  return;
  if( self.m_flTimeWeaponIdle < g_Engine.time && IsShotGun){
   if( self.m_iClip == 0 && !m_fShotgunReload && m_pPlayer.m_rgAmmo( self.m_iPrimaryAmmoType ) != 0 ){self.Reload();}
   else if( m_fShotgunReload ){
    if( self.m_iClip != m_iClipMax && m_pPlayer.m_rgAmmo( self.m_iPrimaryAmmoType ) > 0 ){self.Reload();}
    else{
     self.SendWeaponAnim( m_AFTER_RELOAD, 0, 0 );
     g_SoundSystem.EmitSoundDyn( m_pPlayer.edict(), CHAN_ITEM, ShotgunFinishSound, 1, ATTN_NORM, 0, 95 + Math.RandomLong( 0,0x1f ) );
     m_fShotgunReload = false;
     self.m_flTimeWeaponIdle = g_Engine.time + 1.5;}}}else{
   switch (Math.RandomLong(0,1))
   {case 0: self.SendWeaponAnim( m_IDLE );break;
    case 1: self.SendWeaponAnim( m_FIDGET );break;}
    self.m_flTimeWeaponIdle = g_Engine.time + Math.RandomFloat( 10, 15 );}}
 void Reload()
  {if( m_pPlayer.m_rgAmmo( self.m_iPrimaryAmmoType ) <= 0 || self.m_iClip >= m_iClipMax ){ return;}
   if(bInZoom && IsZoomMode){SecondaryAttack();}
   m_pPlayer.SetAnimation( PLAYER_RELOAD );
   if (IsShotGun) {
   if( !m_fShotgunReload ){
    self.SendWeaponAnim( m_START_RELOAD, 0, 0 );
    m_pPlayer.m_flNextAttack 	=  m_FinishInsertTime;
    self.m_flTimeWeaponIdle			= g_Engine.time  + m_FinishInsertTime;
    self.m_flNextPrimaryAttack 		= g_Engine.time  + m_FinishInsertTime + 0.1;
	self.m_flNextSecondaryAttack	= g_Engine.time	 + m_FinishInsertTime + 0.1;
    m_fShotgunReload = true;return;}
   else if( m_fShotgunReload ){
    if( self.m_flTimeWeaponIdle > g_Engine.time )return;
     if( self.m_iClip == m_iClipMax ){
    m_fShotgunReload = false;return;}
    self.SendWeaponAnim( m_INSERT, 0 );
    m_flNextReload 					= g_Engine.time + m_InsertTime;
    self.m_flNextPrimaryAttack 		= g_Engine.time + m_FinishInsertTime + 0.1;
	self.m_flNextSecondaryAttack	= g_Engine.time + m_FinishInsertTime + 0.1;
    self.m_flTimeWeaponIdle 		= g_Engine.time + m_FinishInsertTime;
    self.m_iClip += 1;
    m_pPlayer.m_rgAmmo( self.m_iPrimaryAmmoType, m_pPlayer.m_rgAmmo( self.m_iPrimaryAmmoType ) - 1 );
    g_SoundSystem.EmitSoundDyn( m_pPlayer.edict(), CHAN_ITEM, ShotgunInsertSound, 1, ATTN_NORM, 0, 85 + Math.RandomLong( 0, 0x1f ) );}}
   else{
   self.DefaultReload( m_iClipMax, m_RELOAD, m_ReloadTime, 0 );}}
  void SetFOV( int fov ){m_pPlayer.pev.fov = m_pPlayer.m_iFOV = fov;}
  void ToggleZoom( int zoomedFOV ){	SetFOV( zoomedFOV );}
  void Holster( int skipLocal = 0 ){if(IsShotGun){m_fShotgunReload = false;}BaseClass.Holster( skipLocal );
	if(bInZoom){bInZoom = false;m_pPlayer.pev.maxspeed = 0;ToggleZoom( 0 );m_pPlayer.m_szAnimExtension = m_strAnimeName;g_SoundSystem.EmitSoundDyn( m_pPlayer.edict(), CHAN_ITEM, "hl/weapons/357_cock1.wav", 1.0, ATTN_NORM, 0, 95 + Math.RandomLong( 0, 10 ) );
}}}}/*The End Dr.Abc*/	