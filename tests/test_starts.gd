extends GutTest

var game: Node2D

func before_each():
	# GIVEN
	game = load("res://main.tscn").instantiate()
	add_child(game)

func after_each():
	game.free()

func test_game_starts():
	# WHEN it is loaded
	# THEN
	assert_not_null(game, "game could not be loaded")

func test_ball_exists():
	# WHEN it is loaded
	# THEN
	var ball: Node2D = game.find_child("Pelota")
	assert_not_null(ball, "ball does not exist")
