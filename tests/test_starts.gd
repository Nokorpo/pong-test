extends GutTest

func test_game_starts():
	# GIVEN
	var game: Node2D = load("res://main.tscn").instantiate()
	add_child(game)

	# WHEN
	#it is loaded

	# THEN
	assert_not_null(game, "the game couldn't be started")
	game.free()

func test_paddle_exists():
	# GIVEN
	var game: Node2D = load("res://main.tscn").instantiate()
	add_child(game)

	# WHEN
	#it is loaded

	# THEN
	var paddle: Node2D = game.find_child("Pala")
	assert_not_null(paddle, "the paddle does not exist")

	game.free()
