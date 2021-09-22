// Created by Crowbar 0.71

// Stored modelname (without quotes): "BETlava.mdl"
$modelname "LavaBeetle.mdl"
$cd "."
$cdtexture "."
$cliptotextures
$scale 1.0

$bodygroup "studio"
{
	studio "beetlespider"
}
$bodygroup "heads"
{
	studio "BETLAVA"
}

$flags 0

$eyeposition 0 0 20


$cbox 0 0 0 0 0 0

$bbox -12 -12 0 12 12 24

$hbox 0 "Bip01" -7.53 -8.24 -6.65 8.89 7.61 6.24
$hbox 0 "Bone05" -0.23 -1.02 -0.64 17.040001 0.66 0.64
$hbox 0 "Bone09" -0.17 -1 -0.41 17.530001 0.81 1
$hbox 0 "Bone13" -0.4 -1.01 -0.83 18.879999 0.73 0.77
$hbox 0 "Bone01" -0.28 -0.77 -1.37 19.52 0.65 0.67
$hbox 0 "Bone30" -16.940001 -0.6 -0.59 0.23 1.02 0.73
$hbox 0 "Bone31" -17.549999 -0.84 -0.9 0.23 1.03 0.47
$hbox 0 "Bone32" -19.309999 -0.59 -0.67 0.27 0.9 1.27
$hbox 0 "Bone28" -18.75 -0.69 -0.64 0.45 1.04 0.87

$sequence "idle1" {
	"LavaBeetle_anims\idle1"
	ACT_IDLE 15
	fps 20
	loop
}
$sequence "idle2" {
	"LavaBeetle_anims\idle2"
	ACT_IDLE 1
	fps 20
}
$sequence "idle3" {
	"LavaBeetle_anims\idle3"
	ACT_IDLE 1
	fps 20
}
$sequence "walk" {
	"LavaBeetle_anims\walk"
	ACT_WALK 1
	fps 60
	loop
	LX
}
$sequence "run" {
	"LavaBeetle_anims\run"
	ACT_RUN 1
	fps 60
	loop
	LX
}
$sequence "angry" {
	"LavaBeetle_anims\angry"
	fps 30
	loop
}
$sequence "flinch" {
	"LavaBeetle_anims\flinch"
	ACT_SMALL_FLINCH 1
	fps 30
}
$sequence "dieback" {
	"LavaBeetle_anims\dieback"
	ACT_DIESIMPLE 1
	fps 30
}
$sequence "180_left" {
	"LavaBeetle_anims\180_left"
	ACT_TURN_LEFT 1
	fps 15
	loop
}
$sequence "180_right" {
	"LavaBeetle_anims\180_right"
	ACT_TURN_RIGHT 1
	fps 15
	loop
}
$sequence "jump" {
	"LavaBeetle_anims\jump"
	ACT_RANGE_ATTACK1 2
	{ event 2 7 }
	fps 40
}
$sequence "yaw_adjustment" {
	"LavaBeetle_anims\yaw_adjustment"
	ACT_MELEE_ATTACK2 1
	fps 30
	loop
}
