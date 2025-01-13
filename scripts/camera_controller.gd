extends Camera2D

var max_zoom = 4
var min_zoom = 1
var target_zoom = Vector2(1, 1)
var zoom_factor = 1.1
var zoom_speed = 0.5

		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		target_zoom *= zoom_factor
	if event.is_action_pressed("zoom_out"):
		target_zoom /= zoom_factor
		
	target_zoom.x = clamp(target_zoom.x, min_zoom, max_zoom)
	target_zoom.y = clamp(target_zoom.y, min_zoom, max_zoom)
	
func _process(delta: float) -> void:
	zoom = lerp(zoom, target_zoom, zoom_speed)
