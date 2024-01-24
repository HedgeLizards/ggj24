extends CharacterBody2D

const speed = 100

func _process(delta):
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	move_and_slide()
