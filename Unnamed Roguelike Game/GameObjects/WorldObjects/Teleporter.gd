extends AnimatedSprite2D

@onready var game: Node2D = self.get_parent().get_parent().get_parent()
@onready var room: Node2D = self.get_parent()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if game.current_room_index == 0 or (body.name == "Player" and room.room_cleared):
		
		game.current_room_index += 1
		
		if game.current_room_index >= game.MAX_ROOMS:
			print("u did it")
			return
		
		var target_room = room.get_parent().get_children()[game.current_room_index]
		var target_room_spawn_point = target_room.get_node("SpawnPoint")
		
		# Need to add offset Vector2 of (-250, -150) to ensure player spawns in center of room.
		const room_offset: Vector2 = Vector2(-250, -150)
		body.global_position = target_room_spawn_point.global_position + room_offset
		
