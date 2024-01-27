extends Node3D

var spawn_at

func _ready():
	global_position = spawn_at
	
	$GPUParticles3D.emitting = true

func _on_gpu_particles_3d_finished():
	queue_free()
