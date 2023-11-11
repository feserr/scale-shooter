extends CharacterBody2D

@export var player: CharacterBody2D
@export var path_find_component: PathFindComponent
@export var velocity_component: VelocityComponent


func _ready():
	pass


func _physics_process(_delta):
	state_normal()


func state_normal():
	if not player:
		return

	var target = player.global_position
	path_find_component.set_target_position(target)
	velocity_component.move(self, 0)
