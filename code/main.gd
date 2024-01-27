extends Node3D


enum State { LOBBY, PLAYING }

var state: State = State.LOBBY
var dry_players := 0

var Cat = preload("res://scenes/cat.tscn")

var levels = [
	preload("res://scenes/levels/dont_fall.tscn"),
	preload("res://scenes/levels/disco.tscn")
]

func _ready():
	InputHandler.player_joined.connect(_on_player_joined)

func start_game():
	InputHandler.can_add_players = false
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
		player.dry = true
		$UI.update_player_dry(player.player_id, true)
	dry_players = %Players.get_child_count()

func _on_lobby_player_ready(id):
	var ready_players: int = %Lobby.ready_players().size()
	print("ready ", ready_players)
	if ready_players > 1 && ready_players == %Players.get_children().size():
		start_game()

func _on_player_joined(id):
	if state != State.LOBBY:
		return
	print("meow")
	var cat = Cat.instantiate()
	cat.player_id = id
	cat.go_to(Vector3(0, 5, 0))
	%Players.add_child(cat)

func _on_in_game_body_exited(body):
	if state != State.PLAYING:
		return
	body.get_parent().dry = false
	
	$UI.update_player_dry(body.get_parent().player_id, false)
	
	dry_players -= 1
	
	#if dry_players == 0:
		#return
	
	for player in %Players.get_children():
		if player.dry:
			player.score += 1
			
			$UI.update_player_score(player.player_id, player.score)
	
	if dry_players <= 1:
		start_game()

func _physics_process(delta):
	%CameraBase.rotation.y += delta / 10
	InputHandler.rotation = -%CameraBase.rotation.y


func _on_lobby_player_leave(player):
	%Players.remove_child(player)
	InputHandler.remove_player(player.player_id)
	$UI.remove_player(player.player_id)
	player.queue_free()
