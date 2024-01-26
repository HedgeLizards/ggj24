extends Node3D


@export var player_id: int = 0

func go_to(to: Vector3):
	%Body.global_position = to
	%Body.linear_velocity = Vector3(0, 0, 0)
	%Body.angular_velocity = Vector3(0, 0, 0)
