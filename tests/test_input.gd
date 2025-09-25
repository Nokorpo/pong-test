extends GutTest

class TestPaddle extends GutTest:

	# sut = System Under Test
	var sut: PackedScene = load("res://pala.tscn")
	var _sender = InputSender.new(Input)

	func after_each():
		_sender.release_all()
		_sender.clear()

	func test_paddle_can_be_moved():
		# GIVEN
		var paddle: Node2D = add_child_autofree(sut.instantiate())
		var initial_position: Vector2 = paddle.position

		# WHEN
		_sender.action_down("player1_down").wait(1)
		await(_sender.idle)

		# THEN
		assert_ne(paddle.position, initial_position)
		assert_gt(paddle.position, initial_position)
