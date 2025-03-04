class_name InventoryItem extends TextureRect

@export var data : ItemData
var quantity : int = 1
var quantity_label : Label

func init(d: ItemData, qty: int = 1) -> void:
	data = d
	quantity = qty

func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	if data:
		texture = data.texture
		tooltip_text = "%s\n%s" % [data.name, data.description]
		
		if data.type == ItemData.Type.MAIN and data.stackable and quantity > 1:
			quantity_label = Label.new()
			quantity_label.text = str(quantity)
			quantity_label.position = Vector2(size.x - 12, size.y -12)
			quantity_label.size_flags_horizontal = Control.SIZE_SHRINK_END
			quantity_label.size_flags_vertical = Control.SIZE_SHRINK_END
			add_child(quantity_label)

func _get_drag_data(at_position : Vector2):
	set_drag_preview(make_drag_preview(at_position))
	return self

func make_drag_preview(at_position: Vector2):
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
