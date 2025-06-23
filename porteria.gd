extends Area2D

@export var score_label: Label
var score: int = 0

signal goal_scored

func _ready() -> void:
	score_label.text = str(score)

func _on_body_entered(body: Node2D) -> void:
	body.reset()
	score_goal()

func score_goal() -> void:
	score += 1
	score_label.text = str(score)
	emit_signal("goal_scored")
