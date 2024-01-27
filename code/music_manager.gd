extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mus_lobby_finished():
	if get_parent().state == get_parent().State.STARTING:
		$MUS_Transition_1.play();
	else:
		$MUS_Lobby.play();


func _on_mus_transition_1_finished():
	$MUS_Game_Time_Loop.play();

func _on_mus_game_time_loop_finished():
	if get_parent().state == get_parent().State.LOBBY:
		$MUS_Lobby.play();
	else:
		$MUS_Game_Time_Loop.play();
