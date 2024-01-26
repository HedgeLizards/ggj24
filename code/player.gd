extends RigidBody3D

@export var player_id: int = 0
const speed: float = 1000



func _integrate_forces(state):
	var current_speed: float = Vector2(linear_velocity.x, linear_velocity.z).length()
	var movement: Vector2 = PlayerInput.movement_vector(player_id) * speed / (1 + current_speed)
	apply_force(Vector3(movement.x, 0, movement.y))
