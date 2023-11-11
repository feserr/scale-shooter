class_name VelocityComponent
extends Node

# Exports
@export var max_speed: float = ObjectsGlobals.MAX_SPEED
@export var acceleration_coefficient: float = ObjectsGlobals.ACCELERATION_COEFFICIENT
@export var disable_knoback: bool = true
@export var debug_drag: bool = ObjectsGlobals.DEBUG_DRAW

# Publics
var velocity: Vector2
var velocity_override: Vector2
var speed_multiplier: float = ObjectsGlobals.SPEED_MULTIPLIER
var acceleration_coefficient_multiplier: float = ObjectsGlobals.ACCELERATION_COEFFICIENT_MULTIPLIER

# Lambdas
var speed_percent_modifiers = func() -> float: return _speed_percent_modifiers.values().reduce(
	ArrayUtils.sum, 0
)

var calculated_max_speed = func() -> float: return (
	max_speed * (1.0 + speed_percent_modifiers.call() * speed_multiplier)
)

var speed_percent = func() -> float: return min(
	velocity.length() / calculated_max_speed if calculated_max_speed.call() > 0.0 else 1.0, 1.0
)

# Privates
var _speed_percent_modifiers: Dictionary = {}
var _knockback_force: float
var _knockback_from: Vector2
var _knockback_requested: bool = false


func _ready():
	set_process(false)
	if debug_drag:
		(owner as Node2D).draw.connect(_on_debug_draw)
		set_process(true)


func _process(_delta):
	(owner as Node2D).queue_redraw()


func accelerate_to_velocity(new_velocity: Vector2) -> void:
	velocity = velocity.lerp(
		new_velocity, 1.0 - exp(-acceleration_coefficient * acceleration_coefficient_multiplier)
	)


func accelerate_to_direction(direction: Vector2) -> void:
	accelerate_to_velocity(direction * calculated_max_speed.call())


func get_max_velocity(direction: Vector2) -> Vector2:
	return direction * calculated_max_speed.call()


func maximize_velocity(direction: Vector2) -> void:
	velocity = get_max_velocity(direction)


func decelerate() -> void:
	accelerate_to_velocity(Vector2.ZERO)


func set_max_speed(new_speed: float) -> void:
	max_speed = new_speed


func add_speed_percent_modifier(modifier_name: String, change: float) -> void:
	var current_value = change
	if _speed_percent_modifiers.has(modifier_name):
		current_value += _speed_percent_modifiers.get(modifier_name)
	_speed_percent_modifiers[modifier_name] = current_value


func set_speed_percent_modifier(modifier_name: String, value: float) -> void:
	_speed_percent_modifiers[modifier_name] = value


func get_speed_percent_modifier(modifier_name: String) -> float:
	return (
		_speed_percent_modifiers[modifier_name]
		if _speed_percent_modifiers.has(modifier_name)
		else 0.0
	)


## Accelerate the velocity till the direction if any, otherwise start stoping it.
func accelerate(direction: Vector2) -> void:
	if direction:
		velocity = direction * max_speed
	else:
		decelerate()


## Set a knockback request to be use when move is called.
func knockback_request(attack_update: AttackUpdate) -> void:
	if disable_knoback:
		return

	_knockback_from = attack_update.attack_position
	_knockback_force = attack_update.knockback_force
	_knockback_requested = true


## Move the body using the velocity and knockback if any.
func move(body: CharacterBody2D, _delta: float) -> void:
	if _knockback_requested:
		_knockback_requested = false
		velocity = _knockback_from.direction_to(body.global_position) * _knockback_force

	body.velocity = velocity_override if velocity_override.length() > 0 else velocity
	body.move_and_slide()


## Callback when owner draw itself.
func _on_debug_draw() -> void:
	owner.draw_line(
		Vector2.ZERO,
		velocity / ObjectsGlobals.DRAW_LINE_MOD,
		ObjectsGlobals.DEBUG_COLOR,
		ObjectsGlobals.DEBUG_LINE_WIDTH
	)
