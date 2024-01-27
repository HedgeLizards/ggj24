extends Node3D

const superbounce: float = 100
var time = 0

func current_level():
	return get_child(0)

func _physics_process(delta):
	time += delta

func extra_bounce():
	if current_level().has_method("is_lobby"):
		return 0
	else:
		print(superbounce + 30 * time)
		return superbounce + 30 * time
