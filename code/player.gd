extends RigidBody3D

const jump: float = 42
var last_velocity := Vector3.ZERO
var player_size: int = 0

func is_on_floor():
	return %FloorCheck.get_overlapping_bodies().any(func(body): return body is StaticBody3D)

func _physics_process(delta):
	var accel = linear_velocity.distance_to(last_velocity) / delta
	if accel > 600:
		# Bounce Sound Effect
		$"../SoundEffects/SND_Player_Ground_Bounce".play();
	last_velocity = linear_velocity

func _integrate_forces(_state):
	var id = get_parent().player_id
	var max_speed = $/root/Main/Level.max_speed()
	var current_speed: Vector2 = Vector2(linear_velocity.x, linear_velocity.z) / max_speed
	if current_speed.length() > 1:
		current_speed = current_speed.normalized()
	var movement: Vector2 = InputHandler.movement_vector(id)
	movement *= movement.distance_to(current_speed) * $/root/Main/Level.accelleration() * (1+player_size / 3)
	#if movement.x < 0 && current_speed.x < -max_speed || movement.x > 0 && current_speed.x > max_speed:
		#movement.x = 0
	#if movement.y < 0 && current_speed.x < -max_speed || movement.y > 0 && current_speed.y > max_speed:
		#movement.y = 0
	if is_on_floor() && InputHandler.jump_pressed(id) && linear_velocity.y < jump:
		linear_velocity.y = jump
		
		# Jump Sound Effect
		
	
	apply_force(Vector3(movement.x, 0, movement.y))


func _on_body_entered(body):
	if body.has_method("is_player"):
		var bounce = $/root/Main/Level.extra_bounce()
		InputHandler.vibrate(get_parent().player_id)
		apply_force(-(body.global_position - global_position).normalized()* bounce * body.linear_velocity.length())
		
		# Bounce Sound Effect
		$"../SoundEffects/SND_Player_Player_Bounce".play();
	

func is_player():
	return true

func grow():
	for child in get_children():
		child.scale *= 1.5
	%FloorCheck.position.y *= 1.5
	mass += 1
	
