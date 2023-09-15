extends Label

@onready var player: CharacterBody2D = $"../../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player != null:
		text = "HP: " + str(player.get("current_player_health"))
	else:
		text = "You have died"
