extends GutTest

var main_scene: PackedScene = load("res://main.tscn")

func test_game_starts():
	# GIVEN
	var game: Node2D = add_child_autofree(main_scene.instantiate())

	# WHEN
	#it is loaded

	# THEN
	assert_not_null(game, "el juego no se ha podido crear")

func test_pala_exists():
	# GIVEN
	var game: Node2D = add_child_autofree(main_scene.instantiate())

	# WHEN
	#it is loaded

	# THEN
	var paddle: Node2D = game.find_child("Pala")
	assert_not_null(paddle, "la pala no existe")

func test_ball_moves():
	# GIVEN
	var game: Node2D = add_child_autofree(main_scene.instantiate())
	var ball: Node2D = game.find_child("Pelota")
	var initial_position: Vector2 = ball.position

	# WHEN
	await wait_seconds(1)

	# THEN
	assert_not_null(ball)
	assert_ne(ball.position, initial_position, "the ball did not move")
	assert_gt(ball.position, initial_position, "the ball did not move")
	assert_almost_eq(ball.position, Vector2(840, 620), Vector2(20, 20), "the ball did not move to the expected position")

func test_ball_scores():
	# GIVEN
	var game: Node2D = add_child_autofree(main_scene.instantiate())
	var ball: Node2D = game.find_child("Pelota")
	ball.position = Vector2(1100, 150)

	# WHEN
	await wait_frames(4)

	# THEN
	var score: Label = game.find_child("Label")
	assert_eq(score.text, "1", "the score was not updated")
