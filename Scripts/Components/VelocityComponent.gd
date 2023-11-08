class_name VelocityComponent
extends Node

# Exports
@export var max_speed: float = ObjectsGlobals.MAX_SPEED
@export var disable_knoback: bool = true

# Privates
var _velocity: Vector2
var _knockback_force: float
var _knockback_from: Vector2
var _knockback_requested: bool = false


## Accelerate the velocity till the direction if any, otherwise start stoping it.
func accelerate(direction: Vector2) -> void:
	if direction:
		_velocity = direction * max_speed
	else:
		_velocity.x = move_toward(_velocity.x, 0, max_speed)
		_velocity.y = move_toward(_velocity.y, 0, max_speed)


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
		_velocity = _knockback_from.direction_to(body.global_position) * _knockback_force

	body.velocity = _velocity
	body.move_and_slide()
