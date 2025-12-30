extends Node2D


func _unhandled_input(event: InputEvent) -> void:
	pass


func _ready() -> void:
	get_tree().paused = false
