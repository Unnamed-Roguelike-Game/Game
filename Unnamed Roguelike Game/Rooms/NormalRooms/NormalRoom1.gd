extends Node2D

@onready var enemy_group: Node2D = $"EnemyGroup"

var room_cleared: bool = false

func _physics_process(_delta: float) -> void:
	if enemy_group.get_children().size() == 0:
		room_cleared = true
		print("done")
