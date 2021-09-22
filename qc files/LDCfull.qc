// Created by Crowbar 0.71

$modelname "LavaDuctCrawler.mdl"
$cd "."
$cdtexture "."
$cliptotextures
$scale 2.0

$bodygroup "studio"
{
	studio "FatLDC"
}

$flags 0

$eyeposition 0 0 20


$cbox 0 0 0 0 0 0

$bbox -12 -12 0 12 12 24

$hbox 0 "Bip01" -7.53 -8.24 -6.65 8.89 7.61 6.24

$sequence "idle1" {
	"LDCfull_anims\idle1"
	ACT_IDLE 15
	fps 20
	loop
}
$sequence "idle2" {
	"LDCfull_anims\idle2"
	ACT_IDLE 1
	fps 20
}
$sequence "idle3" {
	"LDCfull_anims\idle3"
	ACT_IDLE 1
	fps 20
}
$sequence "walk" {
	"LDCfull_anims\walk"
	ACT_WALK 1
	fps 60
	loop
	LX
}
$sequence "run" {
	"LDCfull_anims\run"
	ACT_RUN 1
	fps 60
	loop
	LX
}
$sequence "angry" {
	"LDCfull_anims\angry"
	fps 30
	loop
}
$sequence "flinch" {
	"LDCfull_anims\flinch"
	ACT_SMALL_FLINCH 1
	fps 30
}
$sequence "dieback" {
	"LDCfull_anims\dieback"
	ACT_DIESIMPLE 1
	fps 30
}
$sequence "180_left" {
	"LDCfull_anims\180_left"
	ACT_TURN_LEFT 1
	fps 15
	loop
}
$sequence "180_right" {
	"LDCfull_anims\180_right"
	ACT_TURN_RIGHT 1
	fps 15
	loop
}
$sequence "jump" {
	"LDCfull_anims\jump"
	ACT_RANGE_ATTACK1 2
	{ event 2 7 }
	fps 40
}
$sequence "yaw_adjustment" {
	"LDCfull_anims\yaw_adjustment"
	ACT_MELEE_ATTACK2 1
	fps 30
	loop
}
