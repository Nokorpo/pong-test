extends GutTest

class TestIntegrationBallGame extends GutTest:
	# sut = System Under Test
	var sut: PackedScene = load("res://main.tscn")

	func test_ball_exists():
		# GIVEN
		var game: Node2D = add_child_autofree(sut.instantiate())

		# WHEN
		# it is loaded

		# THEN
		var ball: Node2D = game.find_child("Pelota")
		assert_not_null(ball)

	func test_ball_moves_on_start():
		# GIVEN
		var game: Node2D = add_child_autofree(sut.instantiate())
		var ball: Node2D = game.find_child("Pelota")
		var initial_position: Vector2 = ball.position

		# WHEN
		await wait_seconds(.5)

		# THEN
		assert_ne(ball.position, initial_position, "the ball did not move")
		assert_gt(ball.position, initial_position, "the ball did not move in the right direction")

	func test_ball_scores_a_goal():
		# GIVEN
		var game: Node2D = add_child_autofree(sut.instantiate())
		var ball: Node2D = game.find_child("Pelota")
		ball.position = Vector2(1100, 130)

		var score_label: Label = game.find_child("Label")
		var initial_score: String = score_label.text

		# WHEN
		var goal = game.find_child("Porteria2")
		await wait_for_signal(goal.goal_scored, 1)

		# THEN
		assert_ne(score_label.text, initial_score, "score did not change")
		assert_gt(score_label.text, initial_score, "score didn't increase")

	func test_ball_scores_a_goal_fast():
		# GIVEN
		var game: Node2D = add_child_autofree(sut.instantiate())
		var ball: Node2D = game.find_child("Pelota")

		var score_label: Label = game.find_child("Label")
		var initial_score: String = score_label.text

		# WHEN
		var goal = game.find_child("Porteria2")
		goal._on_body_entered(ball)

		# THEN
		assert_ne(score_label.text, initial_score, "score did not change")
		assert_gt(score_label.text, initial_score, "score didn't increase")
