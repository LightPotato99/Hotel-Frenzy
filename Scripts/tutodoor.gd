extends Area2D

var is_target = true

func _ready():
	$DoorLabel.text = self.name

func _on_body_entered(body):
	if body.is_in_group("player") && is_target == true:
		body.touching_door = self
		body.door_empty_delay = 2

func _on_body_exited(body):
	if body.is_in_group("player") && is_target == true:
		body.door_empty_delay = 0.1
		
func got_delivery():
	is_target = false
	$AnimationPlayer.play("open")
	$Timer.start()

func _process(delta):
	if is_target == false:
		$AudioStreamPlayer2D.volume_db -= delta * 5

func _on_timer_timeout():
	Transition.change_scene_to_file("res://Scenes/MainScenes/main1.tscn")
