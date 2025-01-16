extends Node

var current_level_bounds : Array[Vector2]
signal level_bounds_changed(bounds: Array[Vector2])

func change_level_bounds(bounds: Array[Vector2]) -> void:
	# Sets current bounds to new bounds
	current_level_bounds = bounds
	
	# Emit signal with new bounds
	level_bounds_changed.emit(bounds)
	
