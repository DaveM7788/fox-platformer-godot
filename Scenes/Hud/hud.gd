extends Control

var score: int = 0

@onready var score_label: Label = $MarginContainer/ScoreLabel

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		GameManager.load_main()

func _enter_tree() -> void:
	SignalHub.on_scored.connect(on_scored)


func on_scored(points: int) -> void:
	score += points
	score_label.text = "%05d" % score
