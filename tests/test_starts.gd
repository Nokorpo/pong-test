extends GutTest

func test_game_starts():
	# GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())

	# WHEN
	#it is loaded

	# THEN
	var ball: Node2D = game.find_child("Pelota")
	assert_not_null(ball, "la pelota no existe")

func test_pala_exists():
	# GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())

	# WHEN
	#it is loaded

	# THEN
	var paddle: Node2D = game.find_child("Pala")
	assert_not_null(paddle, "la pala no existe")

func test_ball_moves():
	# GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())
	var ball: Node2D = game.find_child("Pelota")
	var initial_position: Vector2 = ball.position

	# WHEN
	await wait_seconds(1)

	# THEN
	assert_gt(ball.position, initial_position, "ball did not move")

func test_ball_scores_wait():
	# GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())
	var ball: Node2D = game.find_child("Pelota")
	ball.position = Vector2(1134.0, 332.0)
	# porteria
	var score: Label = game.find_child("Label")

	# WHEN
	await wait_frames(1)

	# THEN
	assert_eq(score.text, "1", "the goal wasn't scored")
	assert_almost_eq(ball.position, Vector2(576.0, 324.0), Vector2(10, 10), "the ball position wasn't resetted")

func test_ball_scores_direct():
	# GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())
	var ball: Node2D = game.find_child("Pelota")
	var goal: Node2D = game.find_child("Porteria2")
	var score: Label = game.find_child("Label")

	# WHEN
	goal._on_body_entered(ball)

	# THEN
	assert_eq(score.text, "1", "the goal wasn't scored")
	assert_almost_eq(ball.position, Vector2(576.0, 324.0), Vector2(10, 10), "the ball position wasn't resetted")
