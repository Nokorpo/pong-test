extends CharacterBody2D

const INITIAL_SPEED: float = 250.
var speed: Vector2 = Vector2.ZERO

func _ready() -> void:
	speed = Vector2(1,1) * INITIAL_SPEED

func _process(_delta: float) -> void:
	velocity = speed
	var collision := move_and_slide()
	if collision:
		speed.x *= -1
	if not get_viewport_rect().has_point(global_position):
		speed.y *= -1

func reset() -> void:
	global_position = get_viewport_rect().get_center()
