extends Node2D

class_name Room

@onready var enemy_group: Node2D = $"EnemyGroup"

var room_active: bool = false
var room_cleared: bool = false
var item_spawned: bool = false

func check_if_room_cleared() -> void:
	if !room_cleared and enemy_group.get_children().size() == 0:
		room_cleared = true
		print("done")


func spawn_item() -> void:
	if room_cleared and !item_spawned:
		item_spawned = true
		print("item time")
