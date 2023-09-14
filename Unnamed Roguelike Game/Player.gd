extends CharacterBody2D

var player_speed = 300.0

@onready var player_health = 100

var enemies_in_hitbox = []

func _physics_process(delta):

	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * player_speed * delta
	
	move_and_collide(velocity)


func _on_area_2d_body_entered(body):
	if "Enemy" in body.name:
		player_health -= 10
		enemies_in_hitbox.push_back(body.name)
		if player_health == 0:
			self.queue_free()
		#print(enemies_in_hitbox)


func _on_area_2d_body_exited(body):
	if "Enemy" in body.name:
		enemies_in_hitbox.pop_back()
		#print(enemies_in_hitbox)
