class_name HitboxComponent
extends Area2D

@export var attack_damage: float = ObjectsGlobals.ATTACK_DAMAGE
@export var knockback_force: float = ObjectsGlobals.KNOBACK_FORCE
@export var stun_time: float = ObjectsGlobals.STUN_TIME


## Returns the AttackUpdate.
func get_attack() -> AttackUpdate:
	var attack := AttackUpdate.new(
		attack_damage, knockback_force, (owner as Node2D).global_position, stun_time
	)
	return attack
