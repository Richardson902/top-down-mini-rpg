class_name InventoryItem extends TextureRect

@export var data : ItemData
@export var texture_scale : float = 0.5
var quantity : int = 1
var quantity_label : Label

func init(d: ItemData, qty: int = 1) -> void:
	data = d
	quantity = qty

func _ready() -> void:
	if data:
		expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		custom_minimum_size = get_parent().custom_minimum_size * texture_scale
		size_flags_horizontal = SIZE_SHRINK_CENTER
		size_flags_vertical = SIZE_SHRINK_CENTER
		texture = data.item_texture
		tooltip_text = "%s\n%s" % [data.item_name, data.description]
		update_quantity_display()

func update_quantity_display() -> void:
	# Only show quantities for stackable items with quantity > 1
	if data and data.stackable and quantity > 1:
		if not quantity_label:
			# Create label if doesnt exist
			quantity_label = Label.new()
			quantity_label.size_flags_horizontal = Control.SIZE_SHRINK_END
			quantity_label.size_flags_vertical = Control.SIZE_SHRINK_END
			add_child(quantity_label)
		
		# Update label text
		quantity_label.text = str(quantity)
	elif quantity_label:
		# Remove label if quantity is 1 or item is not stackable
		quantity_label.queue_free()
		quantity_label = null

func update_quantity(qty: int) -> void:
	quantity = qty
	update_quantity_display()
	tooltip_text = "%s\n%s" % [data.item_name, data.description]

func _get_drag_data(at_position : Vector2) -> Variant:
	set_drag_preview(make_drag_preview(at_position))
	return self

func make_drag_preview(at_position: Vector2) -> Control:
	var t := TextureRect.new()
	t.texture = texture
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size
	t.modulate.a = 0.5
	t.position = Vector2(-at_position)
	
	if data and data.stackable and quantity > 1:
		var qlabel = Label.new()
		qlabel.text = str(quantity)
		qlabel.position = Vector2(t.size.x - 12, t.size.y - 12)
		t.add_child(qlabel)
		
	var c := Control.new()
	c.add_child(t)
	
	return c

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		# Handle right click
		if data and data.effects.size() > 0:
			# Use the item
			if data.use():
				# If the item was used, decrease quantity or remove
				if data.stackable and quantity > 1:
					update_quantity(quantity -1)
				else:
					# Remove the item from inventory by freeing it
					queue_free()
				
				#Prevent event from propagating
				get_viewport().set_input_as_handled()
