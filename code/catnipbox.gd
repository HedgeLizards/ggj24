extends RigidBody3D


var particles = preload("res://scenes/catnip_particles.tscn")
var last_velocity = Vector3(0, 0, 0)

func _physics_process(delta):
	if linear_velocity.distance_to(last_velocity) / delta > 1000:
		destroy()
	last_velocity = linear_velocity


func destroy():
	var p = particles.instantiate()
	get_parent().add_child(p)
	p.global_position = global_position
	p.emitting = true
	$/root/Main/UI.show_notice("ZOOMIES!", 2)
	$/root/Main/Level.zoomies = 30
	queue_free()
