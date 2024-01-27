extends Control

func _ready():
	var screen_scale = DisplayServer.screen_get_scale()
	
	$VBoxContainer.add_theme_constant_override('separation',
		$VBoxContainer.get_theme_constant('separation') * screen_scale
	)
	
	for label in [$VBoxContainer/Play, $VBoxContainer/Quit, $Version]:
		label.add_theme_font_size_override('font_size',
			label.get_theme_font_size('font_size') * screen_scale
		)
	
	for texture in [$Logo, $Audio]:
		texture.scale *= screen_scale
	
	if OS.has_feature('web'):
		$VBoxContainer/Quit.visible = false

func _on_play_pressed():
	get_tree().change_scene_to_packed(preload('res://scenes/main.tscn'))

func _on_quit_pressed():
	get_tree().quit()

func _on_audio_toggled(toggled_on):
	AudioServer.set_bus_mute(0, toggled_on)
