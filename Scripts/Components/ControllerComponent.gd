class_name ControllerComponent
extends Node

# Exports
@export var velocity_component: VelocityComponent
@export var active: bool = true

@export_group("Input keys")
@export var negative_x: String = "key_left"
@export var positive_x: String = "key_right"
@export var negative_y: String = "key_up"
@export var positive_y: String = "key_down"


## Scan the input for direction and accelerate the VelocityComponent with it.
func scan_input() -> void:
	if velocity_component == null or not active:
		return

	velocity_component.accelerate_to_direction(
		Input.get_vector(negative_x, positive_x, negative_y, positive_y)
	)


## Deactivate the input for the given time.
func deactivate_for(time: float) -> void:
	active = false
	get_tree().create_timer(time, false).timeout.connect(func(): active = true)
