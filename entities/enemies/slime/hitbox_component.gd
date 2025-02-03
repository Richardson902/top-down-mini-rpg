class_name HitboxComponent extends Area2D

@export var health_component : HealthComponent

#func damage(attack : Attack):
	#if health_component:
		#health_component.damage(attack)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		health_component.health = health_component.health - 2
		health_component.health_bar.value = health_component.health
