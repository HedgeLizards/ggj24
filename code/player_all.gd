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
