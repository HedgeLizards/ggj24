extends Node3D



func _physics_process(delta):
	if !%Level.get_child(0).has_method("is_rotating"):
		rotation.y += delta / 10
	InputHandler.rotation = -rotation.y
