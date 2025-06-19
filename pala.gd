extends CharacterBody2D

const MOVEMENT_SPEED: float = 10.
@export var player_index: int = 1

func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if Input.is_action_pressed("player%d_down" % player_index):
		position.y += MOVEMENT_SPEED
	elif Input.is_action_pressed("player%d_up" % player_index):
		position.y -= MOVEMENT_SPEED
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)
