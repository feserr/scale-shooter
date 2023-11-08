class_name HurtboxComponent
extends Area2D

# Signals
signal hit_by_bullet(bullet_hit_context)
signal hit_by_hitbox(box_hit_context)

# Exports
@export var bullet_impact_scene: PackedScene
@export var detect_only: bool = false

@export_group("Components")
@export var health_component: HealthComponent
@export var status_receiver_component: StatusReceiverComponent


func _ready():
	area_entered.connect(on_area_entered)


## Handles the bullet collision.
func handle_bullet_collision(bullet: BulletComponent) -> void:
	var attack_update: AttackUpdate = bullet.get_attack()
	if not detect_only:
		attack_update = deal_damage_with_transform(attack_update)

	# TODO: create impact scene or send signal to manager to create impact scene

	hit_by_bullet.emit(BulletHitContext.new(bullet, attack_update))


## Apply the damage to the StatusReceiver component.
func deal_damage_with_transform(damage: AttackUpdate) -> AttackUpdate:
	assert(status_receiver_component)
	var final_damage = status_receiver_component.apply_attack_transformation(damage)
	return final_damage


## Callback when colliding with an Area2D.
func on_area_entered(other_area: Area2D) -> void:
	var hitbox_component := other_area as HitboxComponent
	if hitbox_component:
		var attack_update := hitbox_component.get_attack() as AttackUpdate
		if not detect_only:
			attack_update = deal_damage_with_transform(hitbox_component.damage)

		hit_by_hitbox.emit(HitboxHitContext.new(hitbox_component, attack_update))
