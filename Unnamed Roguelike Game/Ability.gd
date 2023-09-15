extends Label

@onready var player = $"../../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player != null:
		text = "Ability Usage Left: " + calculate_ability_usages_left()


func calculate_ability_usages_left():
	return str(player.max_ability_usage - player.ability_used_count)
