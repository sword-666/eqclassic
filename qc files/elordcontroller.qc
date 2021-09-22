// Created by Crowbar 0.71

$modelname "ELord.mdl"
$cd "."
$cdtexture "."
$scale 1.0

$bodygroup "studio"
{
	studio "CrossLord"
}

$flags 0

$eyeposition 0 0 -2


$attachment 0 "Bip01 Head" 24 -19 0
$attachment 1 "Bip01 Head" 32 56 0
$attachment 2 "Bip01 L Hand" 8 8 0
$attachment 3 "Bip01 R Hand" 8 8 0

$cbox 0 0 0 0 0 0

$bbox 0 0 0 0 0 0

$hbox 0 "Bip01 Pelvis" -9.12 -5.64 -4.19 5.08 3.94 3.8
$hbox 0 "Bip01 L Arm1" -0.19 -3.51 -2.43 14.35 1.61 4.15
$hbox 0 "Bip01 L Arm2" -0.06 -0.88 -2.36 17.410545 1.94 1.57
$hbox 0 "Bip01 L Hand" 0 -0.939398 -2.07 6.49 2.45 1.22
$hbox 0 "Bip01 R Arm" 0 -1.59 -3.28 7.23 4.05 2.96
$hbox 0 "Bip01 R Arm1" -0.06 -2.99 -4.06 13.649679 1.82 2.03
$hbox 0 "Bip01 R Arm2" -0.04 -1.38 -1.83 17.410549 1.59 2.16
$hbox 0 "Bip01 R Hand" -0.06 -1.07 -1.003485 6.099624 2.22 2.29

$sequence "attack1" {
	"controller_anims\attack1"
	ACT_RANGE_ATTACK1 1
	{ event 5 0 "29" }
	{ event 3 29 "6" }
	fps 15
	loop
}
$sequence "attack2" {
	"controller_anims\attack2"
	ACT_RANGE_ATTACK1 1
	{ event 4 0 "25" }
	{ event 3 25 "20" }
	fps 15
	loop
}
$sequence "throw" {
	"controller_anims\throw"
	ACT_MELEE_ATTACK1 1
	fps 20
}
$sequence "idle2" {
	"controller_anims\idle2"
	ACT_MELEE_ATTACK1 1
	fps 15
	loop
}
$sequence "block" {
	"controller_anims\block"
	ACT_MELEE_ATTACK1 1
	fps 15
}
$sequence "shoot" {
	"controller_anims\shoot"
	ACT_RANGE_ATTACK2 1
	{ event 1 28 }
	{ event 2 56 }
	fps 30
}
$sequence "flinch1" {
	"controller_anims\flinch1"
	ACT_SMALL_FLINCH 1
	fps 20
}
$sequence "flinch2" {
	"controller_anims\flinch2"
	ACT_BIG_FLINCH 1
	fps 20
}
$sequence "fall" {
	"controller_anims\fall"
	fps 15
	loop
}
$sequence "forward" {
	"controller_anims\forward"
	fps 15
	loop
}
$sequence "backward" {
	"controller_anims\backward"
	fps 15
	loop
}
$sequence "up" {
	"controller_anims\up"
	fps 15
	loop
}
$sequence "down" {
	"controller_anims\down"
	fps 15
	loop
}
$sequence "right" {
	"controller_anims\right"
	fps 15
	loop
}
$sequence "left" {
	"controller_anims\left"
	fps 15
	loop
}
$sequence "float" {
	"controller_anims\float"
	ACT_IDLE 1
	fps 15
	loop
}
$sequence "walk" {
	"controller_anims\walk"
	ACT_WALK 1
	fps 15
	loop
}
$sequence "run" {
	"controller_anims\run"
	ACT_RUN 1
	fps 15
	loop
}
$sequence "die1" {
	"controller_anims\die1"
	ACT_DIESIMPLE 1
	fps 20
}
