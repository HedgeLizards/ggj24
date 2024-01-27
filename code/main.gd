extends Node3D


enum State { LOBBY, STARTING, PLAYING }

var state: State = State.LOBBY
var countdown

var Cat = preload("res://scenes/cat.tscn")
var Lobby = preload("res://scenes/levels/lobby.tscn")

var levels = [
	preload("res://scenes/levels/dont_fall.tscn"),
	preload("res://scenes/levels/disco.tscn")
]

func _ready():
	InputHandler.player_joined.connect(_on_player_joined)
	InputHandler.stop_round.connect(_stop_round)
	start_lobby()

func open_level(level):
	for child in %Level.get_children():
		%Level.remove_child(child)
		child.queue_free()
	%Level.add_child(level)
	%Level.time = 0
	var spawns = level.get_node("Spawns").get_children()
	spawns.shuffle()
	for player in %Players.get_children():
		var spawn: Node = spawns.pop_back()
		player.go_to(spawn.global_position)
		player.dry = true
		$UI.update_player_dry(player.player_id, true)

func start_game():
	InputHandler.can_add_players = false
	InputHandler.can_move_players = false
	state = State.STARTING
	var level = levels.pick_random().instantiate()
	open_level(level)
	countdown = 3
	_on_start_timer_timeout()

func _on_lobby_player_ready(_id):
	var ready_players: int = $Level/Lobby.ready_players().size()
	if ready_players > 1 && ready_players == %Players.get_child_count():
		start_game.call_deferred()

func _on_player_joined(id):
	if state != State.LOBBY:
		return
	var cat = Cat.instantiate()
	cat.player_id = id
	%Players.add_child(cat)
	#$Level/Lobby/Spawns.get_children().pick_random()
	cat.go_to($Level/Lobby/Spawns.get_children().pick_random().position)
	update_join_notice()

func _on_in_game_body_exited(body):
	if state == State.LOBBY:
		return
	
	body.get_parent().dry = false
	
	$UI.update_player_dry(body.get_parent().player_id, false)
	
	var dry_players = []
	
	for player in %Players.get_children():
		if player.dry:
			player.score += 1
			
			$UI.update_player_score(player.player_id, player.score)
			
			dry_players.push_back(player)
	
	if dry_players.size() == 1:
		$UI.show_notice('%s WINS' % $UI.players[dry_players[0].player_id].get_node('Name').text, 2.5)
		
		$EndTimer.start()



func _on_lobby_player_leave(player):
	%Players.remove_child(player)
	InputHandler.remove_player(player.player_id)
	$UI.remove_player(player.player_id)
	player.queue_free()
	update_join_notice()
	_on_lobby_player_ready.call_deferred(null)

func start_lobby():
	InputHandler.can_add_players = true
	InputHandler.can_move_players = true
	var lobby = Lobby.instantiate()
	open_level(lobby)
	lobby.player_leave.connect(_on_lobby_player_leave)
	lobby.player_ready.connect(_on_lobby_player_ready)
	update_join_notice()

func _stop_round():
	if state == State.LOBBY:
		for player in %Players.get_children():
			_on_lobby_player_leave(player)
		InputHandler.can_add_players = false
		InputHandler.can_move_players = false
		get_tree().change_scene_to_file('res://scenes/start.tscn')
	else:
		state = State.LOBBY
		$StartTimer.stop()
		$EndTimer.stop()
		var connected_devices = Input.get_connected_joypads()
		for player in %Players.get_children():
			var input_player = InputHandler.players[player.player_id]
			if input_player != null && input_player.device >= 0 && !connected_devices.has(input_player.device):
				_on_lobby_player_leave(player)
		start_lobby.call_deferred()

func _on_start_timer_timeout():
	if countdown > 0:
		$UI.show_notice(str(countdown), 0.5)
		countdown -= 1
		$StartTimer.start()
	else:
		InputHandler.can_move_players = true
		state = State.PLAYING
		$UI.show_notice("LET'S ROLL", 0.5)
		if $Level.get_child(0).has_method('enable'):
			$Level.get_child(0).enable()

func _on_end_timer_timeout():
	start_game()

func update_join_notice():
	var player_slots_available = 4
	var player_right_available = true
	var player_left_available = true
	
	for player in InputHandler.players:
		if player != null:
			player_slots_available -= 1
			
			match player.device:
				-1:
					player_right_available = false
				-2:
					player_left_available = false
	
	if player_slots_available == 0:
		$UI.hide_notice()
		
		return
	
	var notice = 'Press'
	
	if player_right_available:
		notice += ' Enter'
	
	if player_right_available && player_left_available:
		notice += ','
	
	if player_left_available:
		notice += ' Space'
		
	if player_left_available || player_right_available:
		notice += ' or'
	
	notice += ' [color=#0e7a0d]A[/color] to join'
	
	$UI.show_notice(notice)
