extends Node2D

# Export
@export var speed: float = 200.0

# Private
var _direction: Vector2 = Vector2.ZERO
@onready var _bullet_component: BulletComponent = $BulletComponent


func _ready():
	$Notifier.screen_exited.connect(_on_notifier_screen_exited)
	_bullet_component.hit.connect(_on_collision)


func _process(delta):
	var velocity: Vector2 = _direction * speed * delta
	global_position += velocity


## Set the direction.
func set_direction(direction: Vector2) -> void:
	_direction = direction


## Callback when it collides.
func _on_collision() -> void:
	queue_free()


## Callback when going out of the screen.
func _on_notifier_screen_exited():
	queue_free()
