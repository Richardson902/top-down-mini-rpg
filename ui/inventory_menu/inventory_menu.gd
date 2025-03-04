extends CanvasLayer

var inv_size : int = 16
var items_load = [
	"res://items/coin/coin.tres",
	"res://items/mushroom/mushroom.tres"
]

func _ready() -> void:
	self.visible = false
	for i in inv_size:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(32, 32))
		%Inv.add_child(slot)
	
	for i in items_load.size():
		var item := InventoryItem.new()
		item.init(load(items_load[i]))
		%Inv.get_child(i).add_child(item)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		self.visible = !self.visible

	
