/*Enjoy Ur Creation;
Scripts By Dr.Abc.*/

//Script Core
#include "../custom_weapons/baseweapon"

//Your Weapons files path
#include "../custom_weapons/weapon_example_9mm"
#include "../custom_weapons/weapon_example_shotgun"

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "DrAbc" );
	g_Module.ScriptInfo.SetContactInfo( "Dr.Abc@foxmail.com" );
}

void MapInit() //Add Regiters
{
	RegisterExm9mm();
	RegisterExmShotgun();
}
