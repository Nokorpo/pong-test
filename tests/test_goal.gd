extends GutTest


func test_goal_detects_ball():
	#GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())
	var ball: CharacterBody2D = game.find_child("Pelota")
	ball.global_position = Vector2(950,100)
	var goal: Area2D = game.find_child("Porteria2")
	var new_goal: Area2D = partial_double(load("res://porteria.tscn")).instantiate()
	new_goal.score_label = goal.score_label
	new_goal.position = goal.position
	goal.free()
	game.add_child(new_goal)
	
	#WHEN
	await wait_for_signal(new_goal.goal_scored, 2, "Wait till it scores a point")
	
	#THEN
	assert_called(new_goal, "score_goal")

func test_goal_increases_score():
	#GIVEN
	var game: Node2D = add_child_autofree(load("res://main.tscn").instantiate())
	var ball: CharacterBody2D = game.find_child("Pelota")
	var goal: Area2D = game.find_child("Porteria2")
	
	#WHEN
	goal._on_body_entered(ball)
	
	#THEN
	var score: Label = game.find_child("Label")
	assert_eq(score.get_text(), "1")
	
