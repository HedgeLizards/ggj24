extends Node

var players = [null, null, null, null]

# func _input(event):
	#if event is InputEventJoypadButton && event.pressed:
		#if event.button_index == JOY_BUTTON_A:
			#print(event.device)
	#elif event is InputEventJoypadMotion:
		#print(event.axis, ': ', event.axis_value)

func movement_vector(id):
	return Input.get_vector(
		'left_' + str(id),
		'right_' + str(id),
		'up_' + str(id),
		'down_' + str(id)
	)
