extends StaticBody2D

# Instances of the interactable and sprite
@onready var interactable: Area2D = $Interactable
@onready var sprite: Sprite2D = $Sprite2D
@onready var growth_timer: Timer = $GrowthTimer

@export var apple : DropData

var PICKUP_ITEM = preload("res://items/item_pickup/item_pickup.tscn")

# Regions for open and closed frames of the door (yucky tilemap thing, would rather use frame indexes)
var apples = Rect2(Vector2(60, 160), Vector2(36, 48))
var no_apples = Rect2(Vector2(108, 160), Vector2(36, 48))
var has_apples: bool = true

# Assign interaction function to the callable function in Interactable
func _ready() -> void:
	interactable.interact = _on_interact

# The callable calls this function
func _on_interact():
	if has_apples:
		pick_apples()

func update_state() -> void:
	sprite.region_rect = apples if has_apples else no_apples
	
	# if tree has apples, tree is interactable
	interactable.is_interactable = has_apples

func pick_apples() -> void:
	has_apples = false
	update_state()
	drop_apple()

func _on_growth_timer_timeout() -> void:
	has_apples = true
	update_state()
	
func drop_apple() -> void:
	if apple == null:
		return
	
	var amount_to_drop : int = apple.get_drop_count()
	for i in amount_to_drop:
		var drop : ItemPickup = PICKUP_ITEM.instantiate() as ItemPickup
		drop.item_data = apple.item
		get_parent().add_child(drop)
		drop.global_position = PlayerManager.player.global_position
	growth_timer.start()
