extends Node2D

@export var perimeter_radius: float = 6


## Move the weapon around the owner and pointing to the cursor.
func move_weapon():
	var owner_position = (owner as CharacterBody2D).global_position
	var mouse_position = get_global_mouse_position()
	var distance = owner_position.distance_to(mouse_position)

	var weapon_position = mouse_position
	if distance > perimeter_radius:
		var mouse_direction = (mouse_position - owner_position).normalized()
		weapon_position = owner_position + (mouse_direction * perimeter_radius)

	global_position = weapon_position
	look_at(mouse_position)


## Change the z index depending the cursor position.
func weapon_visibility():
	var mouse_position = get_global_mouse_position()

	if mouse_position.y < global_position.y:
		z_index = 0
		$Sprite.z_index = 0
	else:
		z_index = 10
		$Sprite.z_index = 10


func _process(_delta):
	move_weapon()
	weapon_visibility()
