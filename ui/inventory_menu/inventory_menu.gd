extends CanvasLayer

signal shown
signal hidden

var is_open : bool = false

@onready var item_description: Label = $Control/ItemDescription

func _ready() -> void:
	close_inventory()

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("Inventory"):
		if is_open == false:
			open_inventory()
		else:
			close_inventory()
		get_viewport().set_input_as_handled()

func open_inventory() -> void:
	visible = true
	is_open = true
	shown.emit()

func close_inventory() -> void:
	visible = false
	is_open = false
	hidden.emit()

func update_item_description(new_text : String) -> void:
	item_description.text = new_text
	
