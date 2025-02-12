class_name HealthComponent extends Node2D

signal health_changed(new_health : int)

@export var MAX_HEALTH : int = 10
@export var health_bar : ProgressBar
var health : int


func _ready() -> void:
	health = MAX_HEALTH
	health_bar.max_value = MAX_HEALTH
	health_bar.value = health
	health_changed.connect(_on_health_changed)

func damage(damage : int) -> void:
	health -= damage
	health_changed.emit(health) # Emit updated health value
	
	#if health <= 0:
		#get_parent().queue_free()
		#
func _on_health_changed(new_health : int) -> void:
	health_bar.value = new_health
