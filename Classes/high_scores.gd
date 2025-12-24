extends Resource

class_name HighScores

const MAX_SCORES: int = 10

@export var scores: Array[HighScore] = []

func _init() -> void:
	sort_scores()

func sort_scores() -> void:
	scores.sort_custom(func(a, b): return a.score > b.score)

func get_scores_list():
	return scores

func add_new_score(score: int) -> void:
	var new_score = HighScore.new(score, FoxyUtils.formatted_dt())
	scores.append(new_score)
	sort_scores()
	if scores.size() > MAX_SCORES:
		scores.resize(MAX_SCORES)
