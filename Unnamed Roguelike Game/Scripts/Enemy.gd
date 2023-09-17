extends CharacterBody2D

@onready var player: CharacterBody2D = $"../../Player"

const ENEMY_SPEED: float = 100.0

var current_enemy_health: int = 100

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	if current_enemy_health <= 0:
		queue_free()
	
	var direction_of_player: Vector2 = (player.position - self.position).normalized()

	velocity = (direction_of_player * ENEMY_SPEED * delta)

	move_and_collide(velocity)
