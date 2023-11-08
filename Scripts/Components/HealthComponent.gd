class_name HealthComponent
extends Node

# Signals
signal health_change(health_update)
signal no_health

# Exports
@export var max_health: float = ObjectsGlobals.MAX_HEALTH

# Lambdas
var has_health = func() -> bool: return _current_health > 0

var to_percentage = func() -> float: return (
	_current_health / max_health if _current_health > 0 else 0.0
)

var is_damaged = func() -> bool: return _current_health < max_health

# Private
var _has_no_health: bool = false
var _current_health: float = max_health:
	set(value):
		var previous_health = _current_health
		_current_health = clampf(value, 0, _current_health)

		var health_update := HealthUpdate.new(
			previous_health,
			_current_health,
			max_health,
			to_percentage.call(),
			previous_health <= _current_health
		)
		health_change.emit(health_update)

		if not has_health.call() and not _has_no_health:
			_has_no_health = true
			no_health.emit()
	get:
		return _current_health


## Decrease the current health by the given value.
func damage(value: float) -> void:
	_current_health -= value


## Increase the current health by the given value.
func heal(value: float) -> void:
	_current_health += value


## Initialize the current health with the maximun one.
func init_health() -> void:
	_current_health = max_health


## Scale the current and max health.
func apply_scaling_interval(curve: Curve, progress: float) -> void:
	var current_value = curve.sample(progress)
	max_health *= current_value
	_current_health = max_health


## Call deferred the scaling interval function.
func apply_scaling(curve: Curve, progress: float) -> void:
	call_deferred("apply_scaling_interval", curve, progress)
