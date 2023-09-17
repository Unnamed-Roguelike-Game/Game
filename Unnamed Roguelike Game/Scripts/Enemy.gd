extends CharacterBody2D

@onready var player: CharacterBody2D = $"../../../Player"
@onready var navigation_agent: NavigationAgent2D = $"NavigationAgent2D"

const ENEMY_SPEED: float = 200.0

var current_enemy_health: int = 100

func _ready() -> void:
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	set_movement_target(player.position)

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	if current_enemy_health <= 0:
		queue_free()
	
	if navigation_agent.is_navigation_finished():
		return
	
	set_movement_target(player.position)
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized()

	velocity = (new_velocity * ENEMY_SPEED * delta)

	move_and_collide(velocity)


func set_movement_target(target_point: Vector2):
	navigation_agent.target_position = target_point
