class_name InventorySlot extends PanelContainer

@export var type : ItemData.Type


func init(t: ItemData.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms

func _can_drop_data(_at_position: Vector2, data: Variant):
	if data is InventoryItem:
		if type == ItemData.Type.MAIN:
			if get_child_count() == 0:
				return true
			else:
				if type == data.get_parent().type:
					return true
					
				return get_child(0).data.type == data.data.type
		else:
			return data.data.type == type
	return false

func _drop_data(_at_position: Vector2, data: Variant):
	if get_child_count() > 0:
		var item := get_child(0)
		PlayerManager.player.attack -= item.data.item_damage
		print("Just removed damage from weapon", PlayerManager.player.attack)
		print("New damage: ", PlayerManager.player.attack)
		if item == data:
			return
		item.reparent(data.get_parent())
	if type != ItemData.Type.MAIN:
		print("Adding damage to attack", data.data.item_damage)
		PlayerManager.player.attack += data.data.item_damage
		print("New damage: ", PlayerManager.player.attack)
	else:
		print("removing damage fro, attack", data.data.item_damage)
		PlayerManager.player.attack -= data.data.item_damage
		print("New damage: ", PlayerManager.player.attack)
	data.reparent(self)
