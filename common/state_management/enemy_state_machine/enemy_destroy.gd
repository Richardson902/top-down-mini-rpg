class_name EnemyStateDestroy extends EnemyState

const PICKUP = preload("res://items/item_pickup/item_pickup.tscn")

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("Item Drops")
@export var drops : Array[DropData]

var dropped_item = preload("res://items/coin/coin.tres")

var _damage_position : Vector2
var _direction : Vector2

# On initialization
func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	pass

# On enter
func enter() -> void:
	enemy.invulnerable = true
	
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.setDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	
	PlayerManager.reward_xp(enemy.xp_reward)
	disable_hurt_box()
	drop_items()
	pass

# On exit
func exit() -> void:
	pass

# During process of this state
func process(_delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

func physics(_delta : float) -> EnemyState:
	return null;

# On damage, set state to stun state
func _on_enemy_destroyed(hurtbox : HurtBox) -> void:
	_damage_position = hurtbox.global_position
	state_machine.change_state(self)

func _on_animation_finished(_a : String) -> void:
	if enemy.can_respawn == true:
		enemy.respawn_timer.start()
		await enemy.respawn_timer.timeout
	enemy.queue_free()

func disable_hurt_box() -> void:
	var hurt_box : HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.moinitoring = false

func drop_items() -> void:
	if drops.size() == 0:
		return
	
	for i in drops.size():
		if drops[i] == null || drops[i].item == null:
			continue
		var amount_to_drop : int = drops[i].get_drop_count()
		for j in amount_to_drop:
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			enemy.get_parent().call_deferred("add_child", drop)
			drop.global_position = enemy.global_position
			drop.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
	
	
