class_name PathFindComponent
extends Node2D

# Exports
@export var velocity_component: VelocityComponent

# Private
var _debug_draw: bool = ObjectsGlobals.DEBUG_DRAW
@onready var _interval_timer: Timer = $Timer
@onready var _navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready():
	NavigationServer2D.agent_set_avoidance_enabled(_navigation_agent.get_rid(), true)
	NavigationServer2D.agent_set_avoidance_callback(
		_navigation_agent.get_rid(), Callable(self, "_on_velocity_computed")
	)

#	_navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	set_process(_debug_draw)


func _draw():
	if not _debug_draw:
		return

	if _navigation_agent.is_navigation_finished():
		return

	var current_navigation_path = _navigation_agent.get_current_navigation_path()
	for index in current_navigation_path.size():
		var point = current_navigation_path[index]
		draw_circle(to_local(point), ObjectsGlobals.DEBUG_RADIUS, ObjectsGlobals.DEBUG_COLOR)

		if index > 0:
			var previous_point = current_navigation_path[index - 1]
			draw_line(
				to_local(previous_point),
				to_local(point),
				ObjectsGlobals.DEBUG_COLOR,
				ObjectsGlobals.DEBUG_LINE_WIDTH
			)


func _process(_delta):
	queue_redraw()


## Set the target position without waiting the interval.
func force_set_target_position(target: Vector2) -> void:
	_navigation_agent.set_target_position(target)
	_interval_timer.start(0.5)


## Set the target position, returns true if set, false if not because interval not available
## at the moment.
func set_target_position(target: Vector2) -> bool:
	if not _interval_timer.is_stopped():
		return false

	force_set_target_position(target)
	return true


func _physics_process(_delta):
	if _navigation_agent.is_navigation_finished():
		velocity_component.decelerate()
		return

	var direction = (_navigation_agent.get_next_path_position() - global_position).normalized()
	velocity_component.accelerate_to_direction(direction)
	if _navigation_agent.avoidance_enabled:
		_navigation_agent.set_velocity(velocity_component.velocity)
	else:
		_on_velocity_computed(velocity_component.velocity)


## Callback when the velocity is computed by the navitagion agent.
func _on_velocity_computed(safe_velocity: Vector2):
	var new_direction = safe_velocity.normalized()
	var current_direction = velocity_component.velocity.normalized()
	var halfway = new_direction.lerp(
		current_direction, 1.0 - exp(velocity_component.acceleration_coefficient)
	)
	velocity_component.velocity = halfway * velocity_component.velocity.length()
