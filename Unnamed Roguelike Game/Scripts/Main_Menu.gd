extends Control


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game.tscn")


func _on_stats_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/Stats_Menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
