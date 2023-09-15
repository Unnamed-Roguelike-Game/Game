extends CharacterBody2D

@export var Arrow: PackedScene
@export var player_speed: float = 300.0

@onready var arrow_direction: Marker2D = $"Projectile Spawn"
@onready var hurt_timer: Timer = $"Hurt_Timer"

var enemies_in_hitbox: Array = []

var max_player_health: int = 100
var current_player_health: int = 100

var max_ability_usage: int = 5
var ability_used_count: int = 0

func _physics_process(delta) -> void:

	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
	
	velocity = input_direction * player_speed * delta
	

	if Input.is_action_just_pressed("shoot"):
		shoot()

	if Input.is_action_just_pressed("use_ability"):
		use_heal_ability(10)
	
	move_and_collide(velocity)


func use_heal_ability(health_to_heal) -> void:
	if ability_used_count >= max_ability_usage:
		return 
	
	else:
		heal_player_hp(health_to_heal)
		ability_used_count += 1


# Heal player up to no more than their current max HP.
func heal_player_hp(health_to_heal) -> void:
	current_player_health += health_to_heal
	
	if current_player_health > max_player_health:
		current_player_health = max_player_health

func player_death():
	if current_player_health <= 0:
		self.queue_free()


func shoot() -> void:
	var arrow: Node2D = Arrow.instantiate()
	arrow_direction.look_at(get_global_mouse_position())
	owner.add_child(arrow)
	arrow.transform = arrow_direction.global_transform


func player_hit() -> void:
	current_player_health -= 10
	player_death()
	modulate.a = 0.5
	modulate.b = 0
	modulate.g = 0
	hurt_timer.start()
	#Psuedo Hurt animation to show when I-Frames start/end
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	var tween3 = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 1.5)
	tween2.tween_property(self, "modulate:b", 1, 1)
	tween3.tween_property(self, "modulate:g", 1, 1)


func _on_hurtbox_body_entered(body) -> void:
	if "Enemy" in body.name:
		if enemies_in_hitbox.is_empty():
			enemies_in_hitbox.push_back(body.name)
		if modulate.a == 1:
			player_hit()


func _on_hurtbox_body_exited(body) -> void:
	if "Enemy" in body.name:
		enemies_in_hitbox.pop_back()


func _on_hurt_timer_timeout() -> void:
	modulate.a = 1
	modulate.b = 1
	modulate.g = 1
	if !enemies_in_hitbox.is_empty():
		player_hit()
