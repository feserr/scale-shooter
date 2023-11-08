class_name BulletComponent
extends Area2D

# Signals
signal hit

# Exports
@export var gun_stats: GunStats


func _ready():
	area_entered.connect(_on_area_entered)


## Returns an AttackUpdate with the bullets stats.
func get_attack() -> AttackUpdate:
	var attack := AttackUpdate.new(
		gun_stats.damage_per_bullet,
		gun_stats.knockback_force,
		(owner as Node2D).global_position,
		gun_stats.stun_time
	)
	return attack


## Callback when bullet enters an Area2D.
func _on_area_entered(other_area: Area2D) -> void:
	var hurtbox_component := other_area as HurtboxComponent
	if hurtbox_component:
		hurtbox_component.handle_bullet_collision(self)
		hit.emit()
