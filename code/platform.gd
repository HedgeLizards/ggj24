extends Node3D

var animation = asin(1)

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	animation = fmod(animation + delta / 1.2, TAU)
	
	$platformsdown.position.y = 1+ sin(animation) * 10
	$platformsup.position.y = 1+ sin(animation) * -10
