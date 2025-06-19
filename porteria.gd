extends Area2D

@export var score_label: Label
var score: int = 0

func _ready() -> void:
	score_label.text = str(score)

func _on_body_entered(body: Node2D) -> void:
	score += 1
	score_label.text = str(score)
	body.reset()
