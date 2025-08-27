extends GutTest

func test_game_starts():
	# GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())

	# WHEN
	#it is loaded

	# THEN
	var ball: Node2D = game.find_child("Pelota")
	assert_not_null(ball, "la pelota no existe")

func test_pala_exists():
	# GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())

	# WHEN
	#it is loaded

	# THEN
	var pala: Node2D = game.find_child("Pala")
	assert_not_null(pala, "la pala no existe")


func test_pala2_exists():
	# GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())

	# WHEN
	#it is loaded

	# THEN
	var pala2: Node2D = game.find_child("Pala2")
	assert_not_null(pala2, "la pala2 no existe")
