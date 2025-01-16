class_name Level extends Node2D

func _ready() -> void:
	self.y_sort_enabled = true # In case I forget to enable it lol
	PlayerManager.set_as_parent(self)
