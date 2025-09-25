extends GutTest

class TestIntegrationBall extends GutTest:

	# sut = System Under Test
	var sut: PackedScene = load("res://main.tscn")

	func test_ball_exists():
		# GIVEN
		var game: Node2D = add_child_autofree(sut.instantiate())

		# WHEN
		# game starts

		var ball: Node2D = game.find_child("Pelota")
		assert_not_null(ball, "the ball does not exist")

	func test_ball_moves_on_start():
		# GIVEN
		var game: Node2D = add_child_autofree(sut.instantiate())
		var ball: Node2D = game.find_child("Pelota")
		var initial_position: Vector2 = ball.position

		# WHEN
		await wait_seconds(1)

		# THEN
		assert_ne(ball.position, initial_position, "the ball didn't move")
		assert_gt(ball.position, initial_position, "the ball didn't move in the right direction")

	func test_ball_can_score():
		# GIVEN
		var game: Node2D = add_child_autofree(sut.instantiate())
		var ball: Node2D = game.find_child("Pelota")
		ball.position = Vector2(1000, 120)
		var score_label: Label = game.find_child("Label")
		var initial_score := score_label.text

		# WHEN
		var goal = game.find_child("Porteria2")
		watch_signals(goal)
		await wait_for_signal(goal.goal_scored, 1, "waiting for the goal to be scored")

		# THEN
		assert_ne(score_label.text, initial_score, "the score didn't change")
		assert_gt(score_label.text, initial_score, "the score didn't increase")
		assert_signal_emitted(goal.goal_scored)
