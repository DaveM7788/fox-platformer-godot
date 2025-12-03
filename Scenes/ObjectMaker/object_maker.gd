extends Node2D

const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER:
		preload("res://Scenes/Bullets/player_bullet.tscn"),
	Constants.ObjectType.BULLET_ENEMY:
		preload("res://Scenes/Bullets/enemy_bullet.tscn"),
}

func _enter_tree() -> void:
	SignalHub.on_create_bullet.connect(on_create_bullet)

func on_create_bullet(
	pos: Vector2, dir: Vector2, speed: float,
	ob_type: Constants.ObjectType
) -> void:
	if !OBJECT_SCENES.has(ob_type):
		return
	var nb: Bullet = OBJECT_SCENES[ob_type].instantiate()
	nb.setup(pos, dir, speed)
	call_deferred("add_child", nb)
