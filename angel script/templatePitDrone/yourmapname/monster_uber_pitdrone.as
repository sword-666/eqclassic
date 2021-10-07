//==============================================================//
// Author: Created by dexter, fixed and ported by 
//		   Rafael "Maestro Fénix" Bravo. 	
//
// Purpose: Implements a NPC based off the original
//			monster_pit_drone, which deals poison dmg.
//
//==============================================================//

#include "../ai/checktracehullattack"

class monster_uber_pitdrone_spike : ScriptBaseEntity
{	
	Vector waterSpeed;
	
	
	void Spawn()
	{
		Precache();
		
		pev.solid = SOLID_SLIDEBOX;
		
		pev.movetype = MOVETYPE_FLY;

		g_EntityFuncs.SetModel( self, "models/pit_drone_spike.mdl");
	}

	void Precache()
	{
		g_Game.PrecacheModel( "models/pit_drone_spike.mdl" ); 
	}
	
	void Touch ( CBaseEntity@ pOther )
	{
		//ToDo: find a better way to check this
		if ( ( pOther.TakeDamage ( pev, pev, 0, DMG_GENERIC ) ) != 1 )
		{
			//If the entity doesn't take damage
			if ( g_EngineFuncs.PointContents( pev.origin ) == CONTENTS_WATER )
			{
				//Go slower while in water
				pev.velocity = waterSpeed; 
			}
			else 
			{
				pev.solid = SOLID_NOT;
				
				pev.movetype = MOVETYPE_FLY;
				
				pev.velocity = Vector( 0, 0, 0 );

				g_Utility.Sparks( pev.origin );

				g_SoundSystem.EmitSoundDyn( self.edict(), CHAN_VOICE, "pitdrone/pit_drone_eat.wav", 1, ATTN_NORM, 0, PITCH_NORM);
				
				//Delete the nailed spike after a time for avoid having too many entities at the map
				g_Scheduler.SetTimeout( @this, "RemoveSpike", 6.0);
			}
		}
		else 
		{
			// If it does take damage, deal damage to whatever it is
			pOther.TakeDamage ( pev, pev, 20, DMG_POISON );
			
			g_EntityFuncs.Remove( self ); 
		}
	}
	
	void RemoveSpike()
	{
		g_EntityFuncs.Remove( self );
	}
}


//=========================
//--Monster's Anim Events--
//=========================
const int PDRONE_RELOAD = 7;
const int PDRONE_FIRE_SPIKE = 1;
const int PDRONE_MELEE_RIGHT = 4;
const int PDRONE_MELEE_BOTH = 6;
//=========================
//--Monster's Extra Defs---
//=========================
//-Body Groups
const int BODYGROUP_BODY = 0;
const int BODYGROUP_SPIKES = 1;
//-Spike Groups
const int BODY_NO_SPIKES = 0;
const int BODY_SIX_SPIKES = 1;
const int BODY_FIVE_SPIKES = 2;
const int BODY_FOUR_SPIKES = 3;
const int BODY_THREE_SPIKES = 4;
const int BODY_TWO_SPIKES = 5;
const int BODY_ONE_SPIKES = 6;

class monster_uber_pitdrone : ScriptBaseMonsterEntity
{
	int iSpikes;

	void Spawn()
	{
		//Precache the model and other components
		Precache( ); 

		g_EntityFuncs.SetModel( self, "models/pit_drone.mdl" );
		
		//Let's make his size human. If you're smart enough (or have lots of patience) you can replace the VEC_ stuff with "Vector( x, y, z)"
		g_EntityFuncs.SetSize( pev, VEC_HUMAN_HULL_MIN, VEC_HUMAN_HULL_MAX ); 

		//This actually tells the engine for it to be Solid
		pev.solid = SOLID_SLIDEBOX; 
		
		//Tells the engine that it moves walking
		pev.movetype = MOVETYPE_STEP; 
		
		//Set it to have green blood (The blood's actually yellow, though)
		self.m_bloodColor = BLOOD_COLOR_GREEN;
		
		pev.health = 100;
		
		//Eyes' offset
		pev.view_ofs = Vector ( 0, 0, 20 );
		
		//How far he can see.
		self.m_flFieldOfView = 0.5; 
		
		//Afet he spawns, make him sit there like an idiot, doing nothing.
		self.m_MonsterState = MONSTERSTATE_NONE; 
		
		//Set to have all the spikes on load
		self.SetBodygroup( BODYGROUP_SPIKES, 1 );
		
		iSpikes = 6;
		
		//Show this name at the player HUD
		g_EntityFuncs.DispatchKeyValue( self.edict(), "displayname", "Uber Pit Drone" );
		
		//Start the monster AI
		self.MonsterInit(); 
	}

	void Precache()
	{

		g_Game.PrecacheModel( "models/pit_drone_spike.mdl" );
		g_Game.PrecacheModel( "models/pit_drone.mdl" );

		g_SoundSystem.PrecacheSound( "pitdrone/pit_drone_melee_attack1.wav" );
		g_SoundSystem.PrecacheSound( "pitdrone/pit_drone_melee_attack2.wav" );
		g_SoundSystem.PrecacheSound( "pitdrone/pit_drone_attack_spike1.wav" );
		g_SoundSystem.PrecacheSound( "pitdrone/pit_drone_eat.wav" );
		g_SoundSystem.PrecacheSound( "pitdrone/pit_drone_die1.wav" );
		g_SoundSystem.PrecacheSound( "pitdrone/pit_drone_die2.wav" );
		g_SoundSystem.PrecacheSound( "pitdrone/pit_drone_die3.wav" );
		g_SoundSystem.PrecacheSound( "pitdrone/pit_drone_hunt3.wav" ); 
	}

	int	Classify ( void )
	{
		return	CLASS_ALIEN_MONSTER; 
	}

	void SetYawSpeed( void )
	{
		pev.yaw_speed = 90; 
	}

	void HandleAnimEvent( MonsterEvent@ pEvent )
	{
		switch ( pEvent.event ) 
		{
			case PDRONE_RELOAD:
			{
				iSpikes = 6;
				self.SetBodygroup( BODYGROUP_SPIKES, 1 );
			}
			break;
			case PDRONE_FIRE_SPIKE:
			{
				// Define the vectors - an offset and a direction
				Vector vecspikeOffset;
				Vector vecspikeDir;

				// This stores self.angles into 3 vectors, v_forward, v_up, and v_right, so we can use them in offsets.
				Math.MakeVectors( pev.angles );

				// Move the origin to a relative offset
				vecspikeOffset = ( g_Engine.v_forward * 22 + g_Engine.v_up * 40 );

				// Now make the origin absolute, by adding the monster's origin
				vecspikeOffset = ( pev.origin + vecspikeOffset );

				CBaseEntity@ ent = self.m_hEnemy;
				
				if ( ent is null )
				{
					break;
				}

				// Setting the Direction, by taking the enemy's origin and view offset (so we hit him in his head, not his feet) and the spike offset, and then normalizing it, so 1 is the maximum.
				vecspikeDir = ( ( ent.pev.origin + ent.pev.view_ofs ) - vecspikeOffset ).Normalize();

				// Randomizing the Direction up a bit, so he's not a perfect shot.
				vecspikeDir.x += Math.RandomFloat( -0.01, 0.01 );
				vecspikeDir.y += Math.RandomFloat( -0.01, 0.01 );
				vecspikeDir.z += Math.RandomFloat( -0.01, 0.01 );

				// Create the spike, place it and turn it.
				CBaseEntity@ pSpike = g_EntityFuncs.Create( "monster_uber_pitdrone_spike", vecspikeOffset, pev.angles, false, null );
				
				// Actually setting the velocity. This is why we normalized it, so we can have different speeds.
				pSpike.pev.velocity = vecspikeDir * 900;
				
				// Same for water velocity
				//pSpike.waterSpeed = vecspikeDir * 300;

				// Remember the pitdrone, so we can say who killed the enemy
				@pSpike.pev.owner = self.edict();

				// No friction FTW
				pSpike.pev.friction = 0;

				// Set the angles to correspond to the velocity
				pSpike.pev.angles = Math.VecToAngles( pSpike.pev.velocity );

				// Take a spike out
				iSpikes--;

				// Set the body to match the spikes.
				if ( iSpikes == 0 ) 
				{
					self.SetBodygroup( BODYGROUP_SPIKES, 0 );
				}
				else 
				{
					self.SetBodygroup( BODYGROUP_SPIKES, self.GetBodygroup( BODYGROUP_SPIKES )+1 );
				}
			}
			break;
			case PDRONE_MELEE_RIGHT:
			{
				// Only gonna comment on this one, cuz the rest are basically the same.
				// This gets the enemy and attacks at the same time.
				// The parameters after CheckTraceHullAttack are distance, amount of damage, and type
				CBaseEntity@ pHurt = CheckTraceHullAttack( self, 85, 20, DMG_POISON );

				if ( pHurt !is null )
				{
					pHurt.pev.punchangle.y = Math.RandomLong ( -15, 15 );
					pHurt.pev.punchangle.x = 8;
					pHurt.pev.velocity = pHurt.pev.velocity + g_Engine.v_up * -100;
				}
			}
			break;
			case PDRONE_MELEE_BOTH:
			{
				CBaseEntity@ pHurt = CheckTraceHullAttack( self, 85, 30, DMG_POISON );

				if ( pHurt !is null )
				{
					pHurt.pev.punchangle.x = 15;
					pHurt.pev.velocity = pHurt.pev.velocity + g_Engine.v_up * -100;
				}
			}
			break;
			default:
				BaseClass.HandleAnimEvent( pEvent );
				break; 
		}
	}
	
	Schedule@ GetSchedule( void )
	{
		// Call another switch class, to check the monster's attitude
		switch	( self.m_MonsterState )
		{
			// Manly monster needs to fight
			case MONSTERSTATE_COMBAT:
			{
				if ( self.HasConditions( bits_COND_ENEMY_DEAD ) )
				{
					// The enemy is dead - call base class, all code to handle dead enemies is centralized there.
					return BaseClass.GetSchedule();
				}

				// Can I attack melee style?
				if ( self.HasConditions( bits_COND_CAN_MELEE_ATTACK1 ) )
				{
					// Randomize my melee attacks, so it's a bit different
					switch ( Math.RandomLong ( 0, 1 ) ) 
					{
						case 0:
						return BaseClass.GetScheduleOfType ( SCHED_MELEE_ATTACK1 );
					
						case 1:
						return BaseClass.GetScheduleOfType ( SCHED_MELEE_ATTACK2 );
					}
				}

				//I can range attack! HELLZ YEAH!	
				if ( self.HasConditions( bits_COND_CAN_RANGE_ATTACK1 ) )
				{
					//TOO CLOSE! USE MELEE.
					CBaseEntity@ ent = self.m_hEnemy;
					
					if ( ent is null )
					{
						return BaseClass.GetSchedule();
					}
					
					if ( ( pev.origin - ent.pev.origin ).Length() <= 256 )
					{
						return BaseClass.GetScheduleOfType ( SCHED_CHASE_ENEMY );
					}
					
					if ( ( pev.origin - ent.pev.origin ).Length() <= 512 )
					{
						//Do I have spikes?
						if ( pev.body != BODY_NO_SPIKES ) {
						
							// Yes. Fire!
							return BaseClass.GetScheduleOfType ( SCHED_RANGE_ATTACK1 );
						}
						else 
						{
							// No.
							if ( ( pev.origin - ent.pev.origin ).Length() <= 312 ) 
							{
								// I'm close, I can go and attack.
								if ( self.HasConditions( bits_COND_CAN_MELEE_ATTACK1 ) ) 
								{
									switch ( Math.RandomLong ( 0, 1 ) )
									{
										case 0:
										return BaseClass.GetScheduleOfType ( SCHED_MELEE_ATTACK1 );
									
										case 1:
										return BaseClass.GetScheduleOfType ( SCHED_MELEE_ATTACK2 );
									}
								}
								
								// Lemme get a bit closer, so I can attack
								else 
								{	
									return BaseClass.GetScheduleOfType ( SCHED_CHASE_ENEMY );
								}
							}
							
							// He's too far to melee. I'll just reload
							else 
							{
								return BaseClass.GetScheduleOfType ( SCHED_RELOAD );
							}
						}
					}
					
					// Too far to either fire the spikes or melee, so lemme just get closer, so I'm more accurate.
					else 
					{
						return BaseClass.GetScheduleOfType ( SCHED_CHASE_ENEMY );
					}
				}
				
				// If I can do nothing, just chase after him
				return BaseClass.GetScheduleOfType ( SCHED_CHASE_ENEMY );
			}
		}
		
		// The base probably knows what to do
		return BaseClass.GetSchedule();
	}
}

string GetUberPitDroneName()
{
	return "monster_uber_pitdrone";
}

void RegisterUberPitDrone()
{
	g_CustomEntityFuncs.RegisterCustomEntity( "monster_uber_pitdrone", GetUberPitDroneName() );
}

string GetUberPitDroneSpikeName()
{
	return "monster_uber_pitdrone_spike";
}

void RegisterUberPitDroneSpike()
{
	g_CustomEntityFuncs.RegisterCustomEntity( "monster_uber_pitdrone_spike", GetUberPitDroneSpikeName() );
}