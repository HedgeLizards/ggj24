extends Area3D


func _physics_process(_delta):
	$Sprite3D.global_rotation.y = get_viewport().get_camera_3d().global_rotation.y


func _on_body_entered(body):
	if body.has_method("grow"):
		body.grow()
		queue_free()
