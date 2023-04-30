extends Node2D

var doors = []
var selected_doors = []
var selected_num = 0

signal all_set_delivered
signal made_list(txt)

func _on_timer_timeout():
	pick_rooms(3)

func pick_rooms(i):
	while true:
		if i <= 0:
			make_list(selected_doors)
			selected_num = selected_doors.size()
			break
		var randvalue = randi() % doors.size()
		if doors[randvalue].is_target == false:
			doors[randvalue].is_target = true
			selected_doors.append(doors[randvalue])
			i -= 1
		
func make_list(doors_inlist):
	var namelist = []
	for i in range(doors_inlist.size()):
		namelist.append(doors_inlist[i].name)
	print_debug(namelist)
	made_list.emit(' '.join(namelist))
		
func one_delivered(door):
	selected_num -= 1
	selected_doors.erase(door)
	make_list(selected_doors)
	
	if selected_num <= 0:
		all_delivered()
		
func all_delivered():
	all_set_delivered.emit()
