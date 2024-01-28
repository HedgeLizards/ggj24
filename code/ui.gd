extends CanvasLayer

const COLORS = [Color8(208, 126, 42), Color8(18, 18, 18), Color8(168, 168, 168), Color.WHITE]

@onready var players = [$Player1, $Player2, $Player3, $Player4]

func _ready():
	var screen_scale = DisplayServer.screen_get_scale()
	
	for label in find_children("", "Label"):
		label.add_theme_font_size_override('font_size',
			label.get_theme_font_size('font_size') * screen_scale
		)
	
	$Notice.add_theme_font_size_override('normal_font_size',
		$Notice.get_theme_font_size('normal_font_size') * screen_scale
	)
	
	InputHandler.player_joined.connect(add_player)

func add_player(index):
	players[index].get_node('Name').add_theme_color_override('font_outline_color', COLORS[index])
	players[index].get_node('Score').add_theme_color_override('font_outline_color', COLORS[index])
	
	players[index].visible = true

func remove_player(index):
	players[index].visible = false

func update_player_dry(index, dry):
	players[index].dry = dry

func update_player_score(index, score):
	var label = players[index].get_node('Score')
	
	label.text = str(score)
	label.pivot_offset = label.size / 2
	
	var tween = create_tween().set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(label, 'scale', Vector2.ONE * 1.5, 0.2)
	tween.tween_property(label, 'scale', Vector2.ONE, 0.2)

func show_notice(notice, seconds = null):
	$Notice.text = notice
	$Notice.modulate.a = 1
	
	if seconds != null:
		$NoticeTimer.start(seconds)
	elif !$NoticeTimer.is_stopped():
		$NoticeTimer.stop()

func hide_notice():
	create_tween().set_trans(Tween.TRANS_SINE).tween_property($Notice, 'modulate:a', 0, 0.2)
