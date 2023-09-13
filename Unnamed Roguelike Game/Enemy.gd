extends CharacterBody2D

@onready var player = $"../../Player"
@onready var enemy_sprite = $"AnimatedSprite2D"

var ENEMY_SPEED = 10000.0

func _physics_process(delta):
	
	var direction_of_player = (player.position - self.position).normalized()
	
	velocity.x = direction_of_player.x * ENEMY_SPEED * delta
	velocity.y = direction_of_player.y * ENEMY_SPEED * delta
	
	move_and_slide()
