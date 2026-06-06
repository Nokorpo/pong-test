extends GutTest

class TestPaddleInput extends GutTest:

	var _sender = InputSender.new(Input)

	var game: Node2D

	func before_all():
		var game_scene: PackedScene = load("res://main.tscn")
		game = game_scene.instantiate()
		add_child(game)

	func after_each():
		_sender.release_all()
		_sender.clear()

	func after_all():
		game.free()

	func test_paddle_moves_up():
		# GIVEN
		var paddle: Node2D = game.find_child("Pala")
		var initial_position: Vector2 = paddle.position

		# WHEN
		_sender.action_down("player1_up").hold_for(2)
		await wait_seconds(1)

		# THEN
		assert_lt(paddle.position.y, initial_position.y, "paddle didn't move up")

	func test_paddle_moves_down():
		# GIVEN
		var paddle: Node2D = game.find_child("Pala")
		var initial_position: Vector2 = paddle.position

		# WHEN
		_sender.action_down("player1_down").hold_for(1)
		await _sender.idle

		# THEN
		assert_gt(paddle.position.y, initial_position.y, "paddle didn't move up")


class TestPaddleBallIntegration extends GutTest:
	var pala_scene: PackedScene = load("res://pala.tscn")
	var ball_scene: PackedScene = load("res://pelota.tscn")

	func test_paddle_makes_ball_bounce_sleep():
		# GIVEN
		var paddle: Node2D = add_child_autofree(pala_scene.instantiate())
		paddle.global_position = Vector2(500, 300)
		var ball: Node2D = add_child_autofree(ball_scene.instantiate())

		ball.global_position = paddle.global_position + Vector2(200, -200)
		ball.speed = Vector2(-1, 1) * ball.INITIAL_SPEED

		# WHEN
		await wait_seconds(10)

		# THEN
		assert_almost_eq(ball.velocity, Vector2(1, 1) * ball.INITIAL_SPEED, Vector2(0.1, 0.1), "ball didn't bounce")

	func test_paddle_makes_ball_bounce_signal():
		# GIVEN
		var paddle: Node2D = add_child_autofree(pala_scene.instantiate())
		paddle.global_position = Vector2(500, 300)
		var ball: Node2D = add_child_autofree(ball_scene.instantiate())

		ball.global_position = paddle.global_position + Vector2(200, -200)
		ball.speed = Vector2(-1, 1) * ball.INITIAL_SPEED/2

		# WHEN
		await wait_for_signal(ball.bounce, 2, "waiting for ball to bounce")

		# THEN
		assert_almost_eq(ball.velocity, Vector2(1, 1) * ball.INITIAL_SPEED/2, Vector2(0.1, 0.1), "ball didn't bounce")

	func test_paddle_makes_ball_bounce_polling():
		# GIVEN
		var paddle: Node2D = add_child_autofree(pala_scene.instantiate())
		paddle.global_position = Vector2(500, 300)
		var ball: Node2D = add_child_autofree(ball_scene.instantiate())

		ball.global_position = paddle.global_position + Vector2(200, -200)
		ball.speed = Vector2(-1, 1) * ball.INITIAL_SPEED/2

		# WHEN
		await wait_idle_frames(1)
		var timeout: float = 2000
		var initial_time: float = Time.get_ticks_msec()
		while(ball.velocity.x < 0 \
			and Time.get_ticks_msec() < initial_time + timeout):
				await wait_seconds(0.2, "waiting for ball to bounce")

		# THEN
		assert_almost_eq(ball.velocity, Vector2(1, 1) * ball.INITIAL_SPEED/2, Vector2(0.1, 0.1), "ball didn't bounce")
