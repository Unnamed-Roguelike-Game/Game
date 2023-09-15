extends CharacterBody2D

@export var Arrow: PackedScene
@export var player_speed: float = 300.0

@onready var arrow_direction: Marker2D = $"Projectile Spawn"
@onready var hurt_timer: Timer = $"Hurt_Timer"
@onready var animated_sprite_2d: AnimatedSprite2D = $"AnimatedSprite2D"

var enemies_in_hitbox: Array = []

var max_player_health: int = 100
var current_player_health: int = 100

var max_ability_usage: int = 5
var ability_used_count: int = 0

func _physics_process(delta: float) -> void:

	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
	
	velocity = input_direction * player_speed * delta
	
	handle_animations(input_direction)
	handle_damage()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

	if Input.is_action_just_pressed("use_ability"):
		use_heal_ability(10)
	
	move_and_collide(velocity)


func handle_animations(input_direction: Vector2) -> void:
	pass


func handle_damage() -> void:
	if enemies_in_hitbox.is_empty():
		return
	
	if !hurt_timer.is_stopped():
		return
	
	player_hit()
	hurt_timer.start(1)


func use_heal_ability(health_to_heal: int) -> void:
	if ability_used_count >= max_ability_usage:
		return 
	
	else:
		heal_player_hp(health_to_heal)
		ability_used_count += 1


# Heal player up to no more than their current max HP
func heal_player_hp(health_to_heal: int) -> void:
	current_player_health = min(current_player_health + health_to_heal, max_player_health)


func shoot() -> void:
	var arrow: Node2D = Arrow.instantiate()
	arrow_direction.look_at(get_global_mouse_position())
	owner.add_child(arrow)
	arrow.transform = arrow_direction.global_transform


func player_hit() -> void:
	current_player_health -= 10
	
	if current_player_health <= 0:
		self.queue_free()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name:
		enemies_in_hitbox.push_back(body.name)


func _on_hurtbox_body_exited(body: Node2D) -> void:
	if "Enemy" in body.name:
		enemies_in_hitbox.pop_back()
