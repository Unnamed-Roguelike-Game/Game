extends Label

@onready var player: CharacterBody2D = $"../../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if player != null:
		text = "HP: " + str(player.get("player_health"))
	else:
		text = "You have died"
