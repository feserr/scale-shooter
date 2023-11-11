class_name FreezeComponent
extends Node

# Signals
signal freeze_end

# Exports
@export var time_scale: float = ObjectsGlobals.FREEZE_TIME_SCALE
@export var duration: float = ObjectsGlobals.FREEZE_DURATION


## Freeze the game time by the given scale and for the given duration.
func frame_freeze() -> void:
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration, false, true, true).timeout
	Engine.time_scale = 1.0
	freeze_end.emit()
