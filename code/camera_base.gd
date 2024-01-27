extends Node3D



func _physics_process(delta):
	if !%Level.current_level().has_method("is_rotating"):
		rotation.y += delta / 10
	InputHandler.rotation = -rotation.y
