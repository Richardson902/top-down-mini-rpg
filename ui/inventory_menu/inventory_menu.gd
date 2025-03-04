extends CanvasLayer

var inv_size : int = 16
var items_load = [
	{
		"path": "res://items/coin/coin.tres",
		"quantity": 10
	},
	{
		"path": "res://items/mushroom/mushroom.tres",
		"quantity": 2
	}
]

func _ready() -> void:
	self.visible = false
	for i in inv_size:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(32, 32))
		%Inv.add_child(slot)
	
	for i in items_load.size():
		var item := InventoryItem.new()
		var item_data = load(items_load[i].path)
		var quantity = items_load[i].quantity if "quantity" in items_load[i] else 1
		item.init(item_data, quantity)
		%Inv.get_child(i).add_child(item)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		self.visible = !self.visible

func add_item(item_data: ItemData, quantity: int = 1) -> bool:
	# First try to stack with existing items if stackable
	if item_data.stackable:
		for i in inv_size:
			var slot = %Inv.get_child(i)
			if slot.get_child_count() > 0:
				var inv_item = slot.get_child(0)
				if inv_item.data == item_data:
					# Found match, update qty
					inv_item.update_quantity(inv_item.quantity + quantity)
					return true
	
	# If not stackable or no existing stack found, find empty slot
	for i in inv_size:
		var slot = %Inv.get_child(i)
		if slot.get_child_count() == 0:
			# Found empty slot, add item
			var item = InventoryItem.new()
			item.init(item_data, quantity)
			slot.add_child(item)
			return true
			
	# Inventory is full
	print("Inventory full, cannot add item:", item_data.name)
	return false
