extends Area2D

var projectile_speed: float = 500.0

func _physics_process(delta) -> void:
	position += transform.y * projectile_speed * delta
	

func _on_body_entered(body) -> void:
	if !(body.is_in_group("Player")):
		queue_free()
