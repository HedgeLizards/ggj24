extends RigidBody3D

const jump: float = 30

func is_on_floor():
	return %FloorCheck.get_overlapping_bodies().any(func(body): return body is StaticBody3D)


func _integrate_forces(_state):
	var id = get_parent().player_id
	var current_speed := Vector2(linear_velocity.x, linear_velocity.z)
	var movement: Vector2 = InputHandler.movement_vector(id) * $/root/Main/Level.accelleration()
	var max_speed = $/root/Main/Level.max_speed()
	if movement.x < 0 && current_speed.x < -max_speed || movement.x > 0 && current_speed.x > max_speed:
		movement.x = 0
	if movement.y < 0 && current_speed.x < -max_speed || movement.y > 0 && current_speed.y > max_speed:
		movement.y = 0
	if is_on_floor() && InputHandler.jump_pressed(id) && linear_velocity.y < jump:
		linear_velocity.y = jump
		
		# Sound Effect
		
	
	apply_force(Vector3(movement.x, 0, movement.y))


func _on_body_entered(body):
	if body.has_method("is_player"):
		var bounce = $/root/Main/Level.extra_bounce()
		InputHandler.vibrate(get_parent().player_id)
		apply_force(-(body.global_position - global_position).normalized()* bounce * body.linear_velocity.length())
		
		# Sound Effect
		$"../SoundEffects/SND_Player_Player_Bounce".play();
	else:
		# Sound Effect
		$"../SoundEffects/SND_Player_Ground_Bounce".play();

func is_player():
	return true
