extends Node3D


signal player_ready

func ready_players():
	return %ReadyArea.get_overlapping_bodies().map(func(body): return body.get_parent())

func _on_ready_area_body_entered(body):
	player_ready.emit(body.get_parent().player_id)
