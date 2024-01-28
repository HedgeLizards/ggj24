extends Node3D

var animation = 0
var back = false

func _ready():
	set_physics_process(false)

func _on_button_body_entered(_body):
	set_physics_process(true)

func _physics_process(delta):
	animation = min(max(animation + (-delta if back else delta) / 4, 0), 1)
	
	$FloatingIsland/Button.position.y = 1.5 - (animation * 2 if animation < 0.5 else (1 - animation) * 2) * 0.99
	$Wall.position.x = -150 + sin(animation * PI / 2) * 300
	
	if animation == 0 || animation == 1:
		back = !back
		
		set_physics_process(false)
