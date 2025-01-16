class_name PlayerCamera extends Camera2D

var max_zoom = 4
var min_zoom = 1
var target_zoom = Vector2(1, 1)
var zoom_factor = 1.1
var zoom_speed = 0.5

func _ready():
	LevelManager.level_bounds_changed.connect(update_limits)
	update_limits(LevelManager.current_level_bounds)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		target_zoom *= zoom_factor
	if event.is_action_pressed("zoom_out"):
		target_zoom /= zoom_factor
		
	target_zoom.x = clamp(target_zoom.x, min_zoom, max_zoom)
	target_zoom.y = clamp(target_zoom.y, min_zoom, max_zoom)
	
func _process(_delta: float) -> void:
	zoom = lerp(zoom, target_zoom, zoom_speed)
	
func update_limits(bounds: Array[Vector2]) -> void:
	if bounds == []:
		return
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
