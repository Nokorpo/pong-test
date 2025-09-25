extends GutTest

class TestPaddle extends GutTest:

	var sut: PackedScene = load("res://pala.tscn")
	var _sender = GutInputSender.new(Input)

	func after_each():
		_sender.release_all()
		_sender.clear()

	func test_paddle_can_move():
		# GIVEN
		var paddle: Node2D = add_child_autofree(sut.instantiate())
		var initial_position := paddle.position

		# WHEN
		_sender.action_down("player1_down").wait(1)
		await _sender.idle

		# THEN
		assert_ne(paddle.position, initial_position, "the paddle did not move")
		assert_gt(paddle.position, initial_position, "the paddle did not move in the right direction")

	func test_paddle_can_move2():
		# GIVEN
		var paddle: Node2D = add_child_autofree(sut.instantiate())
		var initial_position := paddle.position

		# WHEN
		_sender.action_down("player1_down").wait(1)
		await _sender.idle

		# THEN
		assert_ne(paddle.position, initial_position, "the paddle did not move")
		assert_gt(paddle.position, initial_position, "the paddle did not move in the right direction")
