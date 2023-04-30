extends Control

var timespeed = 0

func _ready():
	$ScoreLabel.text = "Score: " + str(Globals.score)
	if Globals.completed_hotels % 4 == 0 && Globals.completed_hotels != 0:
		MainMusic.faster()
		$AnimationPlayer.play("faster")

func _on_character_body_2d_got_score():
	Globals.score += 1
	$ScoreLabel.text = "Score: " + str(Globals.score)

func _process(delta):
	if Globals.timeflow == true:
		if Globals.completed_hotels < 20:
			timespeed = int(float(Globals.completed_hotels) / 4) * 0.2 + 1
		else:
			timespeed = int(float(Globals.completed_hotels) / 4) * 0.1 + 1.5
		Globals.timeleft -= delta * timespeed
		$Tick.pitch_scale = timespeed
	$Clock/TimeLabel.text = str(snapped(Globals.timeleft, 0.01))
	
	if Globals.timeleft < 0:
		MainMusic.stop()
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
		
	if Globals.timeleft < 4:
		$Clock/TimeLabel.modulate = Color.RED
		if $Tick.playing == false:
			$Tick.play()
	else:
		$Clock/TimeLabel.modulate = Color.WHITE
		$Tick.stop()

func _on_building_all_set_delivered():
	Globals.timeleft += 15
	
	if Globals.timeleft > 30:
		Globals.timeleft = 30

func _on_building_made_list(txt):
	$Note/ListLabel.text = txt
