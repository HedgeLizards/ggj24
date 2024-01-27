extends Control

func _ready():
	var screen_scale = DisplayServer.screen_get_scale()
	
	for container in [$VBoxContainer, $VBoxContainer/Play, $VBoxContainer/Quit]:
		container.add_theme_constant_override('separation',
			container.get_theme_constant('separation') * screen_scale
		)
	
	for label in [
		$VBoxContainer/Play/Left,
		$VBoxContainer/Play/Button,
		$VBoxContainer/Play/Right,
		$VBoxContainer/Quit/Left,
		$VBoxContainer/Quit/Button,
		$VBoxContainer/Quit/Right,
		$Version
	]:
		label.add_theme_font_size_override('font_size',
			label.get_theme_font_size('font_size') * screen_scale
		)
	
	for texture in [$Logo, $Audio]:
		texture.scale *= screen_scale
	
	if AudioServer.is_bus_mute(0):
		$Audio.set_pressed_no_signal(true)
	
	if OS.has_feature('web'):
		$VBoxContainer/Quit.queue_free()

func _on_play_pressed():
	get_tree().change_scene_to_packed(preload('res://scenes/main.tscn'))

func _on_play_mouse_entered():
	$VBoxContainer/Play/Left.modulate.a = 1
	$VBoxContainer/Play/Right.modulate.a = 1

func _on_play_mouse_exited():
	$VBoxContainer/Play/Left.modulate.a = 0
	$VBoxContainer/Play/Right.modulate.a = 0

func _on_quit_pressed():
	get_tree().quit()

func _on_quit_mouse_entered():
	$VBoxContainer/Quit/Left.modulate.a = 1
	$VBoxContainer/Quit/Right.modulate.a = 1

func _on_quit_mouse_exited():
	$VBoxContainer/Quit/Left.modulate.a = 0
	$VBoxContainer/Quit/Right.modulate.a = 0

func _on_audio_toggled(toggled_on):
	AudioServer.set_bus_mute(0, toggled_on)
