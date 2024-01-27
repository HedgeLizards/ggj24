extends Node3D

var animation = asin(15.0 / 63)

func _ready():
	set_physics_process(false)

func enable():
	set_physics_process(true)

func _physics_process(delta):
	animation = fmod(animation + delta / 4, TAU)
	
	$Wall.position.z = -24 + sin(animation) * 63
	$Wall2.position.z = 24 + sin(animation) * 63
	
	$Wall3.position.z = -24 - sin(animation) * 63
	$Wall4.position.z = 24 - sin(animation) * 63
