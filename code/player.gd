extends RigidBody3D

const speed: float = 100
const max_speed: float = 100

func _integrate_forces(_state):
	var current_speed := Vector2(linear_velocity.x, linear_velocity.z)
	var movement: Vector2 = InputHandler.movement_vector($"..".player_id) * speed
	if movement.x < 0 && current_speed.x < -max_speed || movement.x > 0 && current_speed.x > max_speed:
		movement.x = 0
	if movement.y < 0 && current_speed.y < -max_speed || movement.y > 0 && current_speed.y > max_speed:
		movement.y = 0
		
	apply_force(Vector3(movement.x, 0, movement.y))
