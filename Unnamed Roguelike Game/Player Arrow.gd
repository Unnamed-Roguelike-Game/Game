extends Area2D

var speed = 500

func _physics_process(delta):
	position += transform.y * speed * delta


func _on_body_entered(body):
	if !(body.is_in_group("Player")):
		queue_free()
