extends CharacterBody2D

var player_speed = 500.0

var player_health = 100

func _physics_process(delta):

	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * player_speed

	move_and_slide()
