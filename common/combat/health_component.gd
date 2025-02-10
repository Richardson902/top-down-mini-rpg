class_name HealthComponent extends Node2D

@export var MAX_HEALTH : float = 10.0
@export var health_bar : ProgressBar
var health : float


func _ready() -> void:
	health = MAX_HEALTH
	health_bar.max_value = MAX_HEALTH
	health_bar.value = health

#func damage(attack : Attack) -> void:
	#health -= attach.attack_damage
	#
	#if health <= 0:
		#get_parent().queue_free()
func _process(_delta: float) -> void:
	if health <= 0:
		get_parent().queue_free()
