extends Node

@export var bullet_scene: PackedScene

@onready var player_ = $Player as CharacterBody2D


func _ready():
	pass


func _process(_delta):
	pass


func _on_bullet_timer_timeout():
	if not player_:
		return

	# Create a new instance of the bullet scene.
	var bullet := bullet_scene.instantiate()

	# Choose a random location on Path2D.
	var bullet_spawn_location = $BulletPath/BulletSpawnLocation
	bullet_spawn_location.progress_ratio = randf()

	# Set the bullet's position to a random location.
	bullet.position = bullet_spawn_location.position

	# Set the bullet's direction perpendicular to the path direction.
	var direction = bullet.position.direction_to(player_.position).normalized()

	# Add some randomness to the direction.
	# direction += Vector2(randf_range(-PI / 4, PI / 4), randf_range(-PI / 4, PI / 4))

	bullet.set_direction(direction)

	# Spawn the bullet by adding it to the Main scene.
	add_child(bullet)
