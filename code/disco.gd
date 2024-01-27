extends Node3D

func _ready():
	$Disc/Ramp.set_physics_process(false)

func enable():
	$Disc/Ramp.set_physics_process(true)

func is_rotating():
	return 
