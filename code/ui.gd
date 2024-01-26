extends Control

const PREFIXES = [
	'Agile',
	'Big',
	'Bouncing',
	'Brave',
	'Bumpy',
	'Chunky',
	'Fat',
	'Mr.',
	'Mrs.',
	'Ms.',
	'Purring',
	'Smart',
	'Sneaky',
	'Sumo',
	'The',
	'Zooming',
]

const SUFFIXES = [
	'Beast',
	'Belly',
	'Cat',
	'Cathy',
	'Cutie',
	'Fluffball',
	'Glutton',
	'Kitten',
	'Kitty',
	'Meower',
	'Mittens',
	'Prince',
	'Princess',
	'Puss',
	'Pussy',
	'Roller',
]

func _ready():
	var screen_scale = DisplayServer.screen_get_scale()
	
	for label in [
		$Player1/Name,
		$Player1/Points,
		$Player2/Name,
		$Player2/Points,
		$Player3/Name,
		$Player3/Points,
		$Player4/Name,
		$Player4/Points
	]:
		label.add_theme_font_size_override('font_size',
			label.get_theme_font_size('font_size') * screen_scale
		)

func add_player():
	pass # PREFIXES.pick_random() + ' ' + SUFFIXES.pick_random()

func remove_player():
	pass
