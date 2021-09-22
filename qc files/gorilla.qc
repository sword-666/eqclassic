// Created by Crowbar 0.71

$modelname "gorilla.mdl"
$cd "."
$cdtexture "."
$cliptotextures
$scale 1.0

$bodygroup "studio"
{
	studio "gorilla_new"
}

$flags 0

$eyeposition 0 0 26

$texrendermode "teeth.bmp" masked

$cbox 0 0 0 0 0 0

$bbox 0 0 0 0 0 0

$hbox 3 "Bip01 Pelvis" -12 -4 -4 12 8 4
$hbox 6 "Bip01 L Leg" -4 -4 0 4 4 16
$hbox 6 "Bip01 L Leg1" -4 -4 0 4 4 16
$hbox 6 "Bip01 L Foot" 0 -4 -2 -12 8 2
$hbox 7 "Bip01 R Leg" -4 -4 0 4 4 16
$hbox 7 "Bip01 R Leg1" -4 -4 0 4 4 16
$hbox 7 "Bip01 R Foot" 0 -8 -2 -12 4 2
$hbox 3 "Bip01 Spine1" -12 -2 -12 12 10 4
$hbox 2 "Bip01 Spine2" -14 -12 -8 14 2 8
$hbox 2 "Bip01 Spine3" -16 -2 -8 16 12 8
$hbox 1 "Bip01 Head" -8 -4 -6 6 8 8
$hbox 4 "Bip01 L Arm1" -4 -4 -4 4 4 24
$hbox 4 "Bip01 L Arm2" -4 -4 0 4 4 24
$hbox 4 "Bip01 L Hand" -4 -4 0 4 4 8
$hbox 5 "Bip01 R Arm1" -4 -4 -4 4 4 24
$hbox 5 "Bip01 R Arm2" -4 -4 0 4 4 24
$hbox 5 "Bip01 R Hand" -4 -4 0 4 4 8

$controller 0 "Bip01 Head" XR -30 30
$controller Mouth "Bone05" XR 0 30

$sequence "idle1" {
	"gorilla_anims\idle1"
	ACT_IDLE 1
	fps 30
	loop
}
$sequence "beatchest" {
	"gorilla_anims\beatchest"
	ACT_VICTORY_DANCE 1
	{ event 1004 20 "gorilla/beatchest.wav" }
	fps 30
}
$sequence "walk" {
	"gorilla_anims\walk"
	ACT_WALK 1
	{ event 1004 3 "common/npc_step1.wav" }
	{ event 1004 18 "common/npc_step3.wav" }
	fps 30
	loop
	LX
}
$sequence "run" {
	"gorilla_anims\run"
	ACT_RUN 1
	{ event 5 0 }
	fps 30
	loop
	LX
}
$sequence "jump" {
	"gorilla_anims\jump"
	ACT_RANGE_ATTACK1 1
	{ event 2 0 }
	fps 30
}
$sequence "punch" {
	"gorilla_anims\punch"
	ACT_MELEE_ATTACK1 1
	{ event 1004 20 "zombie/claw_miss1.wav" }
	{ event 3 22 }
	{ event 1004 32 "zombie/claw_miss2.wav" }
	{ event 4 34 }
	fps 30
}
$sequence "smackdown" {
	"gorilla_anims\smackdown"
	ACT_MELEE_ATTACK2 1
	{ event 1008 0 "gorilla/attack2.wav" }
	{ event 6 24 }
	fps 30
}
$sequence "eat" {
	"gorilla_anims\eat"
	ACT_EAT 1
	fps 30
	loop
}
$sequence "smell" {
	"gorilla_anims\smell"
	ACT_DETECT_SCENT 1
	fps 30
}
$sequence "dieforward" {
	"gorilla_anims\dieforward"
	ACT_DIEFORWARD 1
	fps 30
}
$sequence "diebackward" {
	"gorilla_anims\diebackward"
	ACT_DIEBACKWARD 1
	fps 30
}
$sequence "diesimple" {
	"gorilla_anims\diesimple"
	ACT_DIESIMPLE 1
	fps 30
}
$sequence "180_left" {
	"gorilla_anims\180_left"
	ACT_TURN_LEFT 1
	fps 10
}
$sequence "180_right" {
	"gorilla_anims\180_right"
	ACT_TURN_RIGHT 1
	fps 10
}
$sequence "smflinch" {
	"gorilla_anims\smflinch"
	ACT_SMALL_FLINCH 1
	fps 30
}
