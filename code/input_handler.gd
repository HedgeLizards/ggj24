extends Node

signal stop_round
signal player_joined

enum { SELECTING, WAITING, PLAYING }

var rotation: float = 0
var players = [null, null, null, null]

var can_add_players = true
var can_move_players = true

func _input(event):
	if event is InputEventKey && event.pressed:
		if event.keycode == KEY_ESCAPE:
			stop_round.emit()
		elif event.is_action('join_0'):
			add_player(-2)
		elif event.is_action('join_1'):
			add_player(-1)
	elif event is InputEventJoypadButton && event.pressed && event.button_index == JOY_BUTTON_A:
		add_player(event.device)
	elif event is InputEventJoypadMotion:
		for player in players:
			if player != null && player.device == event.device:
				match event.axis:
					JOY_AXIS_LEFT_X:
						player.vector.x = event.axis_value
					JOY_AXIS_LEFT_Y:
						player.vector.y = event.axis_value
				
				break

func add_player(device):
	if !can_add_players:
		return
	
	var first_free_index
	
	for i in players.size():
		if players[i] == null:
			if first_free_index == null:
				first_free_index = i
		elif players[i].device == device:
			return
	
	if first_free_index != null:
		players[first_free_index] = { 'device': device }
		
		if device >= 0:
			players[first_free_index].vector = Vector2()
		
		player_joined.emit(first_free_index)

func remove_player(index):
	players[index] = null

func movement_vector(index):
	if !can_move_players || players[index] == null:
		return Vector2.ZERO
	
	if players[index].device >= 0:
		return players[index].vector.limit_length().rotated(rotation)
	
	var keys = str(players[index].device + 2)
	
	return Input.get_vector('left_' + keys, 'right_' + keys, 'up_' + keys, 'down_' + keys).rotated(rotation)
