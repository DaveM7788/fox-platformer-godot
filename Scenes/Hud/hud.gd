extends Control

var score: int = 0
var hearts: Array
var can_continue := false

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var hb_hearts: HBoxContainer = $MarginContainer/HBHearts
@onready var color_rect: ColorRect = $ColorRect
@onready var v_box_game_over: VBoxContainer = $ColorRect/VBoxGameOver
@onready var v_box_level_complete: VBoxContainer = $ColorRect/VBoxLevelComplete
@onready var complete_timer: Timer = $CompleteTimer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		GameManager.load_main()
	if can_continue && event.is_action_pressed("shoot"):
		GameManager.load_main()


func _ready() -> void:
	score = GameManager.cached_score
	hearts = hb_hearts.get_children()
	on_scored(0)


func _enter_tree() -> void:
	SignalHub.on_scored.connect(on_scored)
	SignalHub.on_player_hit.connect(emit_on_player_hit)
	SignalHub.on_level_complete.connect(on_level_complete)


func _exit_tree() -> void:
	GameManager.try_add_new_score(score)


func on_scored(points: int) -> void:
	score += points
	score_label.text = "%05d" % score


func emit_on_player_hit(lives: int, shake: bool) -> void:
	for i in range(hearts.size()):
		hearts[i].visible = lives > i
	if lives <= 0:
		on_level_complete(false)


func on_level_complete(complete: bool) -> void:
	color_rect.show()
	if complete:
		v_box_level_complete.show()
	else:
		v_box_game_over.show()
	get_tree().paused = true
	complete_timer.start()


func _on_complete_timer_timeout() -> void:
	can_continue = true
