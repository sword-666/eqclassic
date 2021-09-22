// Created by Crowbar 0.71

$modelname "SonicBat.mdl"
$cd "."
$cdtexture "."
$cliptotextures
$scale 3.0

$bodygroup "studio"
{
	studio "Bat_ref"
}

$flags 0

$cbox 0 0 0 0 0 0

$bbox 0 0 0 0 0 0


$sequence "IdleHang" {
	"Bat_anims\IdleHang"
	ACT_IDLE 1
	{ event 1004 10 "eqclassic/bat_idl1.wav" }
	fps 12
}
$sequence "IdleFlyNormal" {
	"Bat_anims\IdleFlyNormal"
	ACT_HOVER 1
	{ event 1004 10 "eqclassic/bat_fly.wav" }
	fps 20
	loop
	LX
}
$sequence "IdleFlyFace" {
	"Bat_anims\IdleFlyFace"
	ACT_FLY 1
	{ event 1004 10 "eqclassic/bat_fly.wav" }
	fps 20
	loop
}
$sequence "Bite" {
	"Bat_anims\Bite"
	ACT_RANGE_ATTACK1 1
	{ event 1004 10 "eqclassic/bat_att.wav" }
	fps 20
}
$sequence "Die" {
	"Bat_anims\Die"
	ACT_DIESIMPLE 1
	{ event 1004 10 "eqclassic/bat_die.wav" }
	fps 35
	origin 0 0 -3
}
