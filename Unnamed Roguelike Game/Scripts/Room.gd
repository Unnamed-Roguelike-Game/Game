extends Node2D

class_name Room

@onready var enemy_group: Node2D = $"EnemyGroup"
@onready var player_detector: Area2D = $"PlayerDetector"
@onready var room_spawn_point: Marker2D = $"SpawnPoint"

var room_cleared: bool = false
var item_spawned: bool = false

func check_if_room_cleared() -> void:
	if !room_cleared and enemy_group.get_children().size() == 0:
		room_cleared = true
		print("done")


func spawn_item() -> void:
	if !item_spawned and room_cleared:
		item_spawned = true
		print("item time")
