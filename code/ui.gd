extends CanvasLayer

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

@onready var v_box_containers = [$Player1, $Player2, $Player3, $Player4]

func _ready():
	var screen_scale = DisplayServer.screen_get_scale()
	
	for v_box_container in v_box_containers:
		for label in [v_box_container.get_node('Name'), v_box_container.get_node('Score')]:
			label.add_theme_font_size_override('font_size',
				label.get_theme_font_size('font_size') * screen_scale
			)
	
	add_player(0)
	add_player(1)
	
	InputHandler.player_joined.connect(add_player)
	#InputHandler.player_left.connect(remove_player)

func add_player(index):
	v_box_containers[index].get_node('Name').text = PREFIXES.pick_random() + ' ' + SUFFIXES.pick_random()
	v_box_containers[index].get_node('Score').text = '0'
	
	v_box_containers[index].visible = true

func remove_player(index):
	v_box_containers[index].visible = false

func update_player_dry(index, dry):
	pass

func update_player_score(index, score):
	v_box_containers[index].get_node('Score').text = str(score)
