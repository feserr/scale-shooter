extends CharacterBody2D

# Exported
@export var speed: float = 100.0

# Private vars
var _screen_size = Vector2.ZERO
@onready var _sprite = $Sprite
@onready var _health_component: HealthComponent = $HealthComponent
@onready var _hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var _velocity_component: VelocityComponent = $VelocityComponent
@onready var _controller_component: ControllerComponent = $ControllerComponent


func _ready():
	_health_component.no_health.connect(_on_no_health)
	_hurtbox_component.hit_by_bullet.connect(_on_hit_by_bullet)
	_hurtbox_component.hit_by_hitbox.connect(_on_hit_by_hitbox)

	_screen_size = get_viewport_rect().size


func _physics_process(delta):
	if _controller_component:
		_controller_component.scan_input()

	if _velocity_component:
		_velocity_component.move(self, delta)


func _process(_delta):
	if velocity.length() > 0:
		_sprite.animation = "walk"
		velocity = velocity.normalized() * speed
		_sprite.flip_h = velocity.x < 0
	else:
		_sprite.animation = "idle"


# Signal callbacks

## Callback when body enters the hit area.
func _on_hit_area_body_entered(body):
	if body.is_in_group("bullet"):
		body.on_collision()


## Callback when health is 0 or below.
func _on_no_health() -> void:
	queue_free()


## Callback when a bullet hits the player.
func _on_hit_by_bullet(hit_context: BulletHitContext) -> void:
	_health_component.damage(hit_context.attack_update.attack_damage)

	if _velocity_component:
		_velocity_component.knockback_request(hit_context.attack_update)

	if _controller_component:
		_controller_component.deactivate_for(hit_context.attack_update.stun_time)


## Callback when hit by a hitbox.
func _on_hit_by_hitbox(hit_context: HitboxHitContext) -> void:
	if _velocity_component:
		_velocity_component.knockback_request(hit_context.attack_update)

	if _controller_component:
		_controller_component.deactivate_for(hit_context.attack_update.stun_time)
