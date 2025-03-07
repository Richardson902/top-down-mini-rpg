class_name ItemData extends Resource

enum Type {HEAD, CHEST, LEGS, FEET, WEAPON, ACCESSORY, MAIN}

@export var type : Type
@export var item_name : String
@export var stackable : bool = false
@export var max_stack_size : int = 99
@export var item_damage: int
@export var item_defense: int
@export_multiline var description : String
@export var item_texture : Texture2D

@export_category("Item Use Effects")
@export var effects : Array[ItemEffect]

func use() -> bool:
	if effects.size() == 0:
		return false
	
	for e in effects:
		e.use()
	return true
		
