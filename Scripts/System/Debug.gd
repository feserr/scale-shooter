extends Node

@onready var info = $Info as HBoxContainer


func _input(event):
	if event.is_action_pressed("key_debug"):
		info.visible = !info.visible

	if event.is_action_pressed("key_reset"):
		get_tree().reload_current_scene()

	if event.is_action_pressed("key_exit"):
		get_tree().quit()
