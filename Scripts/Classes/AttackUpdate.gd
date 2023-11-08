class_name AttackUpdate
extends RefCounted

var attack_damage: float
var knockback_force: float
var attack_position: Vector2
var stun_time: float


func _init(attack_dmg: float, force: float, attack_pos: Vector2, stun: float):
	self.attack_damage = attack_dmg
	self.knockback_force = force
	self.attack_position = attack_pos
	self.stun_time = stun
