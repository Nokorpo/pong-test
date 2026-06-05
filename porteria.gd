extends Area2D

signal goal_scored(current_score: int)

@export var score_label: Label
var score: int = 0

func _ready() -> void:
	if score_label:
		score_label.text = str(score)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("reset"):
		body.reset()
	score += 1
	score_label.set_text(str(score))
	goal_scored.emit(score)
