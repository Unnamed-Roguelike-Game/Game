extends Room

func _physics_process(_delta: float) -> void:
	check_if_room_cleared()
	spawn_item()


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		for enemy in enemy_group.get_children():
			enemy.player_is_in_room = true
