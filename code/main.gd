extends Node3D


enum State { LOBBY, PLAYING }

var state: State = State.LOBBY

var levels = [
	preload("res://scenes/levels/dont_fall.tscn"),
	preload("res://scenes/levels/disco.tscn")
]

func start_game():
	print("starting game")
	state = State.PLAYING
	for child in %Level.get_children():
		%Level.remove_child(child)
		child.queue_free()
	var level = levels.pick_random().instantiate()
	%Level.add_child(level)
	var spawns = level.get_node("Spawns").get_children()
	spawns.shuffle()
	for player in %Players.get_children():
		var spawn: Node = spawns.pop_back()
		player.go_to(spawn.global_position)

func _on_lobby_player_ready(id):
	var ready_players: int = %Lobby.ready_players().size()
	if ready_players > 1 && ready_players == %Players.get_children().size():
		start_game()
		


func _on_in_game_body_exited(body):
	if %InGame.get_overlapping_bodies().size() <= 1:
		start_game()

func _physics_process(delta):
	%CameraBase.rotation.y += delta / 10
	InputHandler.rotation = -%CameraBase.rotation.y
