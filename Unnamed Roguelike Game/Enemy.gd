extends CharacterBody2D

@onready var player: CharacterBody2D = $"../../Player"

const ENEMY_SPEED: float = 100.0

func _physics_process(delta: float) -> void:
	if player != null:
		var direction_of_player: Vector2 = (player.position - self.position).normalized()
	
		velocity = (direction_of_player * ENEMY_SPEED * delta)
	
		move_and_collide(velocity)
