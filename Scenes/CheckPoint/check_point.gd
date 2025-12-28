extends Area2D


var boss_killed := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_boss_killed.connect(on_boss_killed)


func on_boss_killed() -> void:
	boss_killed = true


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open":
		print("open anim finished so set monitoring to on")
		# note - boss.gd used   hit_box.set_deferred("set_monitoring") instead
		set_deferred("monitoring", true)


func _on_area_entered(_area: Area2D) -> void:
	print("Check point level completed!")
