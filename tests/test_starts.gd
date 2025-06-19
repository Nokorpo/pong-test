extends GutTest

func test_game_starts():
	# GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())

	# WHEN
	#it is loaded

	# THEN
	var ball: Node2D = game.find_child("Pelota")
	assert_not_null(ball, "la pelota no existe")
