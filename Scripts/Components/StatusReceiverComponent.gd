class_name StatusReceiverComponent
extends Node

@export var attack_damage_mod: float = 1.0
@export var knockback_force_mod: float = 1.0
@export var stun_time_mod: float = 1.0


## Returns the AttackUpdate scaled with the component values.
func apply_attack_transformation(attack_update: AttackUpdate) -> AttackUpdate:
	assert(attack_update)

	attack_update.attack_damage *= attack_damage_mod
	attack_update.knockback_force *= knockback_force_mod
	attack_update.stun_time *= stun_time_mod

	return attack_update
