extends Area2D

var is_target = false
var doorManager

func _ready():
	doorManager = get_parent().get_parent()
	doorManager.doors.append(self)
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
	doorManager.one_delivered(self)
	$AnimationPlayer.play("open")
