extends Node2D

@export var StartRoom: PackedScene
@export var NormalRoom: PackedScene

@onready var room_group: Node2D = $"Rooms"
@onready var spawn_points: Node2D = $"SpawnPointGroup"

const MAX_ROOMS: int = 4
const DISTANCE_BETWEEN_ROOMS: float = 1000.0

var current_spawn_point: int = 0
var current_room_index: int = 0
var rooms_generation_done: bool = false


func _ready() -> void:
	create_room_spawn_points()


func _process(_delta: float) -> void:
	if !rooms_generation_done and room_group:
		
		for i in range(0, MAX_ROOMS):
			spawn_random_room()
		
		rooms_generation_done = true


func create_room_spawn_points() -> void:
	for i in range(MAX_ROOMS):
		var marker: Marker2D = Marker2D.new()
		marker.position = Vector2(i * DISTANCE_BETWEEN_ROOMS - 270, -200) 
		spawn_points.add_child(marker)


func spawn_random_room() -> void:
	var room: Node2D
	
	if current_spawn_point == 0:
		room = StartRoom.instantiate()
	
	else:
		room = NormalRoom.instantiate()

	room.position = (spawn_points.get_child(current_spawn_point)).get("position")
	room_group.add_child(room)
	current_spawn_point += 1
