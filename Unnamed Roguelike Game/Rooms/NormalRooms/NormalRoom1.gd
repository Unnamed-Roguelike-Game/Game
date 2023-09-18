extends Room

func _physics_process(_delta: float) -> void:
	check_if_room_cleared()
	spawn_item()
