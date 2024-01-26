extends RigidBody3D

const speed = 100

func _integrate_forces(state):
	var movement = Input.get_vector("left", "right", "up", "down") * speed
	apply_force(Vector3(movement.x, 0, movement.y))
