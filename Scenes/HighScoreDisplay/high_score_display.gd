extends VBoxContainer

class_name HighScoreDisplayItem

var _high_score: HighScore = null

@onready var score_label: Label = $ScoreLabel
@onready var date_label: Label = $DateLabel


func _ready() -> void:
	if _high_score == null:
		queue_free()
	else:
		score_label.text = "%05d" % _high_score.score
		date_label.text = _high_score.date_scored


func setup(high_score: HighScore) -> void:
	_high_score = high_score
