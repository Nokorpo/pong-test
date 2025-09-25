extends GutTest

class TestGame extends GutTest:

	var game: Node2D

	func before_all():
		# GIVEN
		game = load("res://main.tscn").instantiate()
		add_child(game)

	func after_all():
		game.free()

	func test_game_starts():
		# WHEN it is loaded
		# THEN
		assert_not_null(game, "the game couldn't be started")

	func test_paddle_exists():
		# WHEN it is loaded
		# THEN
		var paddle: Node2D = game.find_child("Pala")
		assert_not_null(paddle, "the paddle does not exist")
