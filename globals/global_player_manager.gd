extends Node

const PLAYER = preload("res://player/player.tscn")

var player: Player
var player_spawned : bool = false

func _ready() -> void:
	add_player_instance()

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	
func set_player_position(_new_pos: Vector2) -> void:
	player.global_position = _new_pos
	
# Hack to fix y sorting
func set_as_parent( _parent : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_parent.add_child(player)
	
func unparent_player(_parent : Node2D) -> void:
	_parent.remove_child(player)
