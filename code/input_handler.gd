extends Node

signal state_changed
signal player_joined
signal player_left

enum { SELECTING, WAITING, PLAYING }

var rotation: float = 0
var state = PLAYING
var players = [null, null, null, null]

func _ready():
	add_or_remove_player(-2)
	add_or_remove_player(-1)

func _input(event):
	match state:
		SELECTING:
			if event is InputEventKey && event.pressed:
				if event.keycode == KEY_ENTER:
					state = PLAYING
					
					state_changed.emit(state)
				elif event.is_action('join_0'):
					add_or_remove_player(-2)
				elif event.is_action('join_1'):
					add_or_remove_player(-1)
			elif event is InputEventJoypadButton && event.pressed && event.button_index == JOY_BUTTON_A:
				add_or_remove_player(event.device)
		PLAYING:
			if event is InputEventKey && event.pressed && event.keycode == KEY_ESCAPE:
				state = SELECTING
				
				state_changed.emit(state)
			elif event is InputEventJoypadMotion:
				for player in players:
					if player != null && player.device == event.device:
						match event.axis:
							JOY_AXIS_LEFT_X:
								player.vector.x = event.axis_value
							JOY_AXIS_LEFT_Y:
								player.vector.y = event.axis_value
						
						break

func add_or_remove_player(device):
	var first_free_index
	
	for i in players.size():
		if players[i] == null:
			if first_free_index == null:
				first_free_index = i
		elif players[i].device == device:
			players[i] = null
			
			player_left.emit(i)
			
			return
	
	if first_free_index != null:
		players[first_free_index] = { 'device': device }
		
		if device >= 0:
			players[first_free_index].vector = Vector2()
		
		player_joined.emit(first_free_index)

func movement_vector(index):
	if players[index].device >= 0:
		return players[index].vector.limit_length()
	
	var keys = str(players[index].device + 2)
	
	return Input.get_vector('left_' + keys, 'right_' + keys, 'up_' + keys, 'down_' + keys).rotated(rotation)

