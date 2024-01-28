extends Node3D


@export var player_id: int = 0

var score = 0
var dry = true

const models = [
	preload("res://scenes/cat_models/player1.tscn"),
	preload("res://scenes/cat_models/player2.tscn"),
	preload("res://scenes/cat_models/player3.tscn"),
	preload("res://scenes/cat_models/player4.tscn")
]

func initialize(id):
	player_id = id
	var model = models[id].instantiate()
	%Body.add_child(model)
	InputHandler.vibrate(id)

func go_to(to: Vector3):
	%Body.global_position = to
	%Body.linear_velocity = Vector3(0, 0, 0)
	%Body.angular_velocity = Vector3(0, 0, 0)
	for child in %Body.get_children():
		child.scale = Vector3(1, 1, 1)
	$Base/FloorCheck.position = Vector3(0, -2, 0)
	$Base/FloorCheck.scale = Vector3(1, 1, 1)
	%Body.mass = 3.5
	%Body.player_size = 1
