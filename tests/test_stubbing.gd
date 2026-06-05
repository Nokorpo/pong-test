extends GutTest

var main_scene: PackedScene = load("res://main.tscn")

func test_score_signal_is_emitted():
	# GIVEN
	var game: Node2D = add_child_autofree(main_scene.instantiate())
	var goal: Node2D = game.find_child("Porteria2")
	watch_signals(goal)

	# WHEN
	goal._on_body_entered(Node2D.new())

	# THEN
	assert_signal_emitted(goal.goal_scored)

func test_ball_is_resetted():
	# GIVEN
	var game: Node2D = add_child_autofree(main_scene.instantiate())
	var goal: Node2D = game.find_child("Porteria2")

	# Double the original ball script, and stub the "reset" method
	var DoubledPelota = double(load("res://pelota.gd"))
	stub(DoubledPelota, "reset").to_do_nothing()
	# Create a new instance and use it to run the test
	var doubled_ball = DoubledPelota.new()

	# WHEN
	goal._on_body_entered(doubled_ball)

	# THEN
	# The "reset" method is called at least once
	assert_called(doubled_ball, "reset")
