@tool
class_name ItemPickup extends Node2D

@export var item_data : ItemData : set = _set_item_data
@export var item_scale : float = 0.5

@onready var area_2d: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	area_2d.body_entered.connect(_on_body_entered)

func _on_body_entered(b) -> void:
	if b is Player:
		if item_data:
			if InventoryMenu.add_item(item_data) == true:
				item_picked_up()

func item_picked_up() -> void:
	area_2d.body_entered.disconnect(_on_body_entered)
	audio_player.play()
	visible = false
	await audio_player.finished
	queue_free()

func _update_texture() -> void:
	if item_data and sprite:
		sprite.texture = item_data.texture
		sprite.scale = Vector2(item_scale, item_scale)

func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()
