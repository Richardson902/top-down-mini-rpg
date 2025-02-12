class_name HitBox extends Area2D

signal Damaged(damage : int)

# Change damage here based on weapon damage stuff
func take_damage(damage: int) -> void:
	print("Ouchines!: ", damage)
	Damaged.emit(damage)
