extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("../../Player") != null:
		text = "HP: " + str(get_node("../../Player").get("player_health"))
	else:
		text = "You have died"
