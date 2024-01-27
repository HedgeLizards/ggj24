extends RigidBody3D

const speed: float = 100
const max_speed: float = 100
const jump: float = 30

func is_on_floor():
	return %FloorCheck.get_overlapping_bodies().any(func(body): return body is StaticBody3D)


func _integrate_forces(_state):
	var id = $"..".player_id
	var current_speed := Vector2(linear_velocity.x, linear_velocity.z)
	var movement: Vector2 = InputHandler.movement_vector(id) * speed
	if movement.x < 0 && current_speed.x < -max_speed || movement.x > 0 && current_speed.x > max_speed:
		movement.x = 0
	if movement.y < 0 && current_speed.y < -max_speed || movement.y > 0 && current_speed.y > max_speed:
		movement.y = 0
	var dy: float = 0
	if is_on_floor() && InputHandler.jump_pressed(id) && linear_velocity.y < jump:
		linear_velocity.y = jump
	
	apply_force(Vector3(movement.x, 0, movement.y))
