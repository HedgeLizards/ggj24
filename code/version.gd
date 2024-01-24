extends Label

const version_file = "res://version.txt"

func _ready():
	text = FileAccess.get_file_as_string(version_file)
	modulate.a = 0.5
