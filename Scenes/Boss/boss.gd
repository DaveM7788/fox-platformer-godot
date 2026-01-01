extends Node2D

@export var lives := 2
@export var points := 5

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hit_box: Area2D = $Visuals/HitBox
@onready var shooter: Shooter = $Visuals/Shooter
@onready var state_machine: AnimationNodeStateMachinePlayback = \
	$AnimationTree["parameters/playback"]
@onready var visuals: Node2D = $Visuals

var _invincible := false


func _ready() -> void:
	pass


func shoot() -> void:
	shooter.shoot_at_player()


func activate_collisions() -> void:
	hit_box.call_deferred("set_monitoring", true)
	hit_box.call_deferred("set_monitorable", true)


func _on_trigger_area_entered(_area: Area2D) -> void:
	animation_tree["parameters/conditions/on_trigger"] = true


func _on_hit_box_area_entered(_area: Area2D) -> void:
	take_damage()


func take_damage() -> void:
	if _invincible:
		return
	
	set_invincibile(true)
	state_machine.travel("hit")
	tween_hit()
	reduce_lives()


func tween_hit() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(visuals, "position", Vector2.ZERO, 1.8)


func set_invincibile(on: bool) -> void:
	_invincible = on


func reduce_lives() -> void:
	lives -= 1
	if lives <= 0:
		SignalHub.emit_on_scored(points)
		SignalHub.emit_on_boss_killed()
		queue_free()
