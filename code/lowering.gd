extends StaticBody3D

func _physics_process(delta: float) -> void:
	position.y -= delta * 1
