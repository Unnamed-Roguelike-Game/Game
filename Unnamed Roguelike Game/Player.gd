extends CharacterBody2D

var max_ability_usage = 5
var max_player_health = 100

var player_speed = 300.0
var player_health = 100

var enemies_in_hitbox = []
var ability_used_count = 0

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * player_speed * delta
	
	if Input.is_action_just_pressed("use_ability"):
		heal_player_hp(10)
		ability_used_count += 1
	
	move_and_collide(velocity)


# Heal player up to no more than their current max HP.
func heal_player_hp(health_to_heal):
	
	if ability_used_count >= max_ability_usage:
		return 
	
	player_health += health_to_heal
	
	if player_health > max_player_health:
		player_health = max_player_health


func player_death():
	if player_health <= 0:
		self.queue_free()


func player_hit():
	player_health -= 10
	player_death()
	modulate.a = 0.5
	modulate.b = 0
	modulate.g = 0
	$Hurt_Timer.start()
	#Psuedo Hurt animation to show when I-Frames start/end
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	var tween3 = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 1.5)
	tween2.tween_property(self, "modulate:b", 1, 1)
	tween3.tween_property(self, "modulate:g", 1, 1)


func _on_hurtbox_body_entered(body):
	if "Enemy" in body.name:
		if enemies_in_hitbox.is_empty():
			enemies_in_hitbox.push_back(body.name)
		if modulate.a == 1:
			player_hit()
		#print(enemies_in_hitbox)


func _on_hurtbox_body_exited(body):
	if "Enemy" in body.name:
		enemies_in_hitbox.pop_back()
		#print(enemies_in_hitbox)


func _on_hurt_timer_timeout():
	modulate.a = 1
	modulate.b = 1
	modulate.g = 1
	if !enemies_in_hitbox.is_empty():
		player_hit()
