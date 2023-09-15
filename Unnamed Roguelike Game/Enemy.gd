extends CharacterBody2D

@onready var player = $"../../Player"
@onready var enemy_sprite = $"AnimatedSprite2D"

const ENEMY_SPEED = 100.0

func _physics_process(delta):
	if player != null:
		var direction_of_player = (player.position - self.position).normalized()
	
		velocity = (direction_of_player * ENEMY_SPEED * delta)
	
		move_and_collide(velocity)
