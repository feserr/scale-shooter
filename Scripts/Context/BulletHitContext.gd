class_name BulletHitContext
extends HitContext

var bullet_component: BulletComponent


func _init(bullet_comp: BulletComponent, atck_update: AttackUpdate):
	self.bullet_component = bullet_comp
	self.attack_update = atck_update
