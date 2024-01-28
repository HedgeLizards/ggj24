extends Node

func _on_mus_lobby_finished():
	if get_parent().state == get_parent().State.STARTING or get_parent().state == get_parent().State.PLAYING:
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
