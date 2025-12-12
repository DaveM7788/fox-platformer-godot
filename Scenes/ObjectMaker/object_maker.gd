extends Node2D

const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER:
		preload("res://Scenes/Bullets/player_bullet.tscn"),
	Constants.ObjectType.BULLET_ENEMY:
		preload("res://Scenes/Bullets/enemy_bullet.tscn"),
	Constants.ObjectType.EXPLOSION:
		preload("res://Scenes/Explosion/explosion.tscn"),
}

func _enter_tree() -> void:
	SignalHub.on_create_bullet.connect(on_create_bullet)
	SignalHub.on_create_object.connect(on_create_object)

func on_create_bullet(
	pos: Vector2, dir: Vector2, speed: float,
	ob_type: Constants.ObjectType
) -> void:
	if !OBJECT_SCENES.has(ob_type):
		return
	var nb: Bullet = OBJECT_SCENES[ob_type].instantiate()
	nb.setup(pos, dir, speed)
	call_deferred("add_child", nb)


func on_create_object(
	pos: Vector2,
	ob_type: Constants.ObjectType
) -> void:
	if !OBJECT_SCENES.has(ob_type):
		return
	var new_obj_m: Node2D = OBJECT_SCENES[ob_type].instantiate()
	new_obj_m.position = pos
	call_deferred("add_child", new_obj_m)
