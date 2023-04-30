extends Node2D

var tips = ["You don't have to deliver those packages in particular order. Find the best route!",
			"You're too slow! Go faster next time.",
			"Delivery is a tough job, isn't it?",
			"I hope someone made lots of spaghetti!",
			"It's better to save time by not doing backtracking.",
			"This game is my first LDJam entry, hope you enjoyed :)"]

func _ready():
	$ResultUI/ScoreLabel.text = "Score: " + str(Globals.score)
	$ResultUI/HotelLabel.text = "Hotels: " + str(Globals.completed_hotels)
	if Globals.score > Globals.best_score:
		Globals.best_score = Globals.score
		
	$ResultUI/BestScoreLabel.text = "Best Score: " + str(Globals.best_score)
	
	if Globals.played_before == false:
		$ResultUI/Tiptext.text = tips[0]
	else:
		$ResultUI/Tiptext.text = tips[randi() % tips.size()]
	MainMusic.reset_pitch()

func _on_button_pressed():
	Transition.change_scene_to_file("res://Scenes/MainScenes/main1.tscn")
	Globals.timeleft = 30
	Globals.timeflow = false
	Globals.score = 0
	Globals.completed_hotels = 0
	Globals.played_before = true
