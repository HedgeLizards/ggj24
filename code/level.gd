extends Node3D

const superbounce: float = 100
var time = 0
var zoomies = 0

const speed: float = 250
const speed_max: float = 25

func reset():
	time = 0
	zoomies = 0

func current_level():
	return get_child(0)

func _physics_process(delta):
	time += delta
	zoomies -= delta

func extra_bounce():
	if current_level().has_method("is_lobby"):
		return 0
	else:
		return superbounce + 30 * time

func accelleration():
	if zoomies > 0:
		return speed * 5
	return speed

func max_speed():
	return speed_max
