extends Node2D

@export var NormalRoom1: PackedScene
@export var LargeRoom1: PackedScene

@onready var room_group: Node2D = $"Rooms"
@onready var spawn_points: Node2D = $"SpawnPointGroup"

const MAX_ROOMS: int = 3

var current_spawn_point: int = 0
var rooms_generation_done: bool = false

func _process(_delta: float) -> void:
	if !rooms_generation_done and room_group:
		
		for i in range(0, MAX_ROOMS):
			spawn_random_room()
		
		rooms_generation_done = true

func spawn_random_room() -> void:
	var room_choice: float = randf_range(0, 1)
	var room: Node2D
	
	if room_choice > 0.5:
		room = LargeRoom1.instantiate()
		
	else:
		room = NormalRoom1.instantiate()
	
	room.position = (spawn_points.get_child(current_spawn_point)).get("position")
	room_group.add_child(room)
	current_spawn_point += 1
