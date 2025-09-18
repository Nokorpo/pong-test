extends GutTest

var main_scene: PackedScene = load("res://main.tscn")

func test_ball_scores():
	# GIVEN
	var game: Node2D = add_child_autofree(main_scene.instantiate())
	var ball: Node2D = game.find_child("Pelota")
	ball.position.x = 1100

	# WHEN
	await wait_frames(1)

	# THEN
	var score: Label = game.find_child("Label")
	assert_eq(score.text, "1", "the score was not updated")

func test_ball_scores_with_event():
	# GIVEN
	var game: Node2D = add_child_autofree(main_scene.instantiate())
	var ball: Node2D = game.find_child("Pelota")
	ball.position = Vector2(1100, 100)

	var goal: Node2D = game.find_child("Porteria2")

	# WHEN
	await wait_for_signal(goal.goal_scored, 1, "waiting for goal scored")

	# THEN
	var score: Label = game.find_child("Label")
	assert_eq(score.text, "1", "the score was not updated")
	assert_almost_eq(ball.position, Vector2(610, 360), Vector2(20, 20), "the ball did not move to the expected position")

func test_ball_scores_with_polling():
	# GIVEN
	var game: Node2D = add_child_autofree(main_scene.instantiate())
	var ball: Node2D = game.find_child("Pelota")
	ball.position = Vector2(1100, 100)

	# WHEN
	var score: Label = game.find_child("Label")
	var check_if_scored: Callable = func():
		return score.text == "1"

	await wait_until(check_if_scored, 1, "waiting for goal scored")

	# THEN
	assert_eq(score.text, "1", "the score was not updated")
	#assert_almost_eq(ball.position, Vector2(610, 360), Vector2(20, 20), "the ball did not move to the expected position")
