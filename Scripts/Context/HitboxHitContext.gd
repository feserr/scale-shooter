class_name HitboxHitContext
extends HitContext

var hitbox_component: HitboxComponent


func _init(hitbox_comp: HitboxComponent, atck_update: AttackUpdate):
	self.hitbox_component = hitbox_comp
	self.attack_update = atck_update
