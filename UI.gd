extends Node

# Import the necessary modules
# For quitting the game
func _on_quit_pressed():
	get_tree().quit()  # This function quits the game

# For transitioning to the main scene
func _on_play_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
