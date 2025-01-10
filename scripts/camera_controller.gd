extends Camera2D

var max_zoom = 4
var min_zoom = 1
var zoom_amount = 0.2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		zoom.x += zoom_amount
		zoom.y += zoom_amount
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)
	if event.is_action_pressed("zoom_out"):
		zoom.x -= zoom_amount
		zoom.y -= zoom_amount
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)
