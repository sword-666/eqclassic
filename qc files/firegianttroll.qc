// Created by Crowbar 0.71

$modelname "firegiant.mdl"
$cd "."
$cdtexture "."
$scale 2.8


$bodygroup "body"
{
	studio "FireGiantNH"
}

$bodygroup "rock"
{
	blank
	studio "rock"
}

$flags 512


$eyeposition 0 0 0
$origin 0 0 0


$sequence "idle0" {
	"troll_anims\idle0"
	ACT_IDLE 10
	{ event 1004 10 "eqclassic/giantidl.wav" }
	fps 15
	loop
}
$sequence "idle1" {
	"troll_anims\idle1"
	ACT_IDLE 8
	{ event 1004 10 "eqclassic/giantidl.wav" }
	fps 30
	loop
}
$sequence "idle2" {
	"troll_anims\idle2"
	ACT_IDLE 2
	{ event 1004 10 "eqclassic/giantidl.wav" }
	fps 30
	loop
}
$sequence "idle3" {
	"troll_anims\idle3"
	ACT_IDLE 6
	{ event 1004 10 "eqclassic/giantidl.wav" }
	fps 15
	loop
}
$sequence "throw_rock" {
	"troll_anims\throw_rock"
	ACT_RANGE_ATTACK1 1
	{ event 600 10 "rock_pickup" }
	{ event 600 33 "rock_throw" }
	fps 15
	LX
}
$sequence "throw_rock" {
	"troll_anims\throw_rock"
	ACT_RANGE_ATTACK2 1
	{ event 600 10 "rock_pickup" }
	{ event 600 33 "rock_throw" }
	fps 15
	LX
}
$sequence "walk" {
	"troll_anims\walk"
	ACT_WALK 1
	{ event 1004 10 "eqclassic/giantwlk.wav" }
	fps 15
	loop
	LX
}
$sequence "run" {
	"troll_anims\run"
	ACT_RUN 1
	{ event 1004 10 "eqclassic/giantrun.wav" }
	fps 30
	loop
	LX
}
$sequence "down_punch" {
	"troll_anims\hit_down"
	ACT_MELEE_ATTACK1 1
	{ event 1004 20 "eqclassic/giantatt.wav" }
	fps 30
}
$sequence "hit_down" {
	"troll_anims\hit_down"
	ACT_MELEE_ATTACK2 1
	{ event 1004 20 "eqclassic/giantatt.wav" }
	fps 30
}
$sequence "flinch1" {
	"troll_anims\flinch1"
	ACT_SMALL_FLINCH 1
	{ event 1004 10 "eqclassic/gianthit.wav" }
	fps 20
}
$sequence "flinch2" {
	"troll_anims\flinch2"
	ACT_BIG_FLINCH 1
	{ event 1004 10 "eqclassic/gianthit.wav" }
	fps 20
}
$sequence "flinch3" {
	"troll_anims\flinch2"
	ACT_FLINCH_STOMACH 1
	{ event 1004 10 "eqclassic/gianthit.wav" }
	fps 20
}
$sequence "die1" {
	"troll_anims\die_fall"
	ACT_DIESIMPLE 1
	{ event 1004 10 "eqclassic/giantdie.wav" }
	fps 20
}
$sequence "die2" {
	"troll_anims\die_fall"
	ACT_DIE_HEADSHOT 1
	{ event 1004 10 "eqclassic/giantdie.wav" }
	fps 20
}
