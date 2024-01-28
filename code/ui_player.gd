extends VBoxContainer

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
	'Majestic',
	'Murder',
	'Notorious',
	'Purring',
	'Smart',
	'Sneaky',
	'Sumo',
	'The',
	'Tiny',
	'Zooming',
]

const SUFFIXES = [
	'Beast',
	'Belly',
	'Cat',
	'Cathy',
	'Cutie',
	'Destroyer',
	'Fluffball',
	'Furball',
	'Glutton',
	'Kitten',
	'Kitty',
	'Meower',
	'Mittens',
	'Prince',
	'Princess',
	'Puss',
	'Pussy',
	'Rascal',
	'Roller',
	'Trickster',
]

var cat_name
var dry = true:
	set(value):
		dry = value
		
		queue_redraw()

func _on_visibility_changed():
	if !visible:
		return
	
	cat_name = PREFIXES.pick_random() + ' ' + SUFFIXES.pick_random()
	
	$Name.text = cat_name
	$Score.text = '0'

func _draw():
	if dry:
		return
	
	draw_line(Vector2.ZERO, size, Color.WHITE, 5, true)
	draw_line(Vector2(size.x, 0), Vector2(0, size.y), Color.WHITE, 5, true)
