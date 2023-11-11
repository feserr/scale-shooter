extends Node2D

# Export
@export var speed: float = 200.0

# Private
var _direction: Vector2 = Vector2.ZERO
var _debug_draw: bool = ObjectsGlobals.DEBUG_DRAW
@onready var _bullet_component: BulletComponent = $BulletComponent


func _ready():
	$Notifier.screen_exited.connect(_on_notifier_screen_exited)
	_bullet_component.hit.connect(_on_collision)


func _process(delta):
	var velocity: Vector2 = _direction * speed * delta
	global_position += velocity

	if _debug_draw:
		queue_redraw()


func _draw():
	var velocity: Vector2 = _direction * speed
	self.draw_line(
		Vector2.ZERO,
		velocity / ObjectsGlobals.DRAW_LINE_MOD,
		ObjectsGlobals.DEBUG_COLOR,
		ObjectsGlobals.DEBUG_LINE_WIDTH
	)


## Set the direction.
func set_direction(direction: Vector2) -> void:
	_direction = direction


## Callback when it collides.
func _on_collision() -> void:
	queue_free()


## Callback when going out of the screen.
func _on_notifier_screen_exited():
	queue_free()
