extends Control

func _ready():
	var screen_scale = DisplayServer.screen_get_scale()
	
	for container in [
		$VBoxContainer,
		$VBoxContainer/HBoxContainer,
		$VBoxContainer/HBoxContainer/Play,
		$VBoxContainer/HBoxContainer/Quit,
	]:
		container.add_theme_constant_override('separation',
			container.get_theme_constant('separation') * screen_scale
		)
	
	for label in [
		$VBoxContainer/Label,
		$VBoxContainer/HBoxContainer/Play/Button,
		$VBoxContainer/HBoxContainer/Quit/Button,
		$Version,
	]:
		label.add_theme_font_size_override('font_size',
			label.get_theme_font_size('font_size') * screen_scale
		)
	
	for texture in [
		$VBoxContainer/Combined,
		$VBoxContainer/HBoxContainer/Play/Left,
		$VBoxContainer/HBoxContainer/Play/Right,
		$VBoxContainer/HBoxContainer/Quit/Left,
		$VBoxContainer/HBoxContainer/Quit/Right,
	]:
		texture.custom_minimum_size *= screen_scale
	
	for texture in [$Logo, $Audio]:
		texture.scale *= screen_scale
	
	if AudioServer.is_bus_mute(0):
		$Audio.set_pressed_no_signal(true)
	
	if OS.has_feature('web'):
		$VBoxContainer/HBoxContainer/Quit.queue_free()

func _on_play_pressed():
	get_tree().change_scene_to_packed(preload('res://scenes/main.tscn'))

func _on_play_mouse_entered():
	$VBoxContainer/HBoxContainer/Play/Left.modulate.a = 1
	$VBoxContainer/HBoxContainer/Play/Right.modulate.a = 1

func _on_play_mouse_exited():
	$VBoxContainer/HBoxContainer/Play/Left.modulate.a = 0
	$VBoxContainer/HBoxContainer/Play/Right.modulate.a = 0

func _on_quit_pressed():
	get_tree().quit()

func _on_quit_mouse_entered():
	$VBoxContainer/HBoxContainer/Quit/Left.modulate.a = 1
	$VBoxContainer/HBoxContainer/Quit/Right.modulate.a = 1

func _on_quit_mouse_exited():
	$VBoxContainer/HBoxContainer/Quit/Left.modulate.a = 0
	$VBoxContainer/HBoxContainer/Quit/Right.modulate.a = 0

func _on_audio_toggled(toggled_on):
	AudioServer.set_bus_mute(0, toggled_on)
