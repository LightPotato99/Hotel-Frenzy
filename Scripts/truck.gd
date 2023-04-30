extends Area2D

var is_target = false
var doorManager
var work_times = 0

func _ready():
	doorManager = get_parent().get_parent()
	$AnimationPlayer.play('arrive')
	$TruckArrow.visible = false
	$break.play()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.touching_truck = self
	print_debug(is_target)

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.touching_truck = null
		
func got_delivery():
	work_times += 1
	$TruckArrow.visible = false
	if work_times >= 3:
		Globals.completed_hotels += 1
		change_hotel()
		return
	is_target = false
	doorManager.pick_rooms(work_times + 3)
	
func change_hotel():
	$AnimationPlayer.play('depart')
	$engine.play()
	Globals.timeflow = false
	if Globals.completed_hotels <= 3 or Globals.completed_hotels % 4 == 3:
		Transition.change_scene_to_file("res://Scenes/MainScenes/main"+str((randi() % 5) + 1)+".tscn")
	else:
		Transition.change_scene_to_file("res://Scenes/MainScenes/main"+str((randi() % 7) + 6)+".tscn")

func _on_building_all_set_delivered():
	is_target = true
	$TruckArrow.visible = true

func _on_timer_timeout():
	Globals.timeflow = true
