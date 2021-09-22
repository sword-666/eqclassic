// Created by Crowbar 0.71

$modelname "dragon.mdl"
$cd "."
$cdtexture "."
$scale 1.0
$origin -15 -80 195
$eyeposition -15 -80 50
$flags 512
$keepallbones
$body studio "fixed_green_ref"



$sequence "anim_idle_deep" {
	"dragon_green_mini_anims\anim_idle_deep"
	ACT_IDLE 1
	fps 10
	loop
}
$sequence "anim_atk_close1" {
	"dragon_green_mini_anims\anim_atk_close1"
	ACT_MELEE_ATTACK1 1
	{ event 500 0 "frame_slct_next_attack" }
	{ event 500 9 "frame_claw_right" }
	{ event 500 24 "frame_claw_left" }
	fps 20
}
$sequence "anim_breath_far" {
	"dragon_green_mini_anims\anim_breath_far"
	ACT_RANGE_ATTACK1 1
	{ event 500 0 "frame_breath_prep" }
	{ event 500 14 "frame_breath_close_start" }
	{ event 500 59 "frame_breath_close_end" }
	fps 10
}
$sequence "anim_die_close" {
	"dragon_green_mini_anims\anim_die_close"
	ACT_DIESIMPLE 1
	fps 10
}

