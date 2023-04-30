extends CharacterBody2D

var speed = 30
var mouse_position = null
var target_ypos = 0

var movable = false
var distX
var distY
var touching_ev = null

var touching_door = null
var door_empty_delay = 0
signal got_score

var touching_truck = null
var curLoad = 3
var succession = 0

var delayL = 0
var delayR = 0

var box_stack0 = preload("res://Graphics/BoxStack0.png")
var box_stack1 = preload("res://Graphics/BoxStack1.png")
var box_stack2 = preload("res://Graphics/BoxStack2.png")
var box_stack3 = preload("res://Graphics/BoxStack3.png")
var box_stack4 = preload("res://Graphics/BoxStack4.png")
var box_stack5 = preload("res://Graphics/BoxStack5.png")

func _ready():
	change_load(curLoad)

func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	distX = mouse_position.x - global_position.x
	distY = target_ypos - global_position.y
	
	if movable:
		velocity = Vector2(distX * speed, distY * speed)
		move_and_slide()
	
	$Sprites.scale = Vector2(int(distX > 0) * 2 - 1, 1)
	$Sprites/Head.rotation = abs(velocity.x * 0.001)
	$Sprites/Boxstack.rotation = abs(velocity.x * 0.0005)
	
	if Input.is_action_just_pressed("Lclick"):
		delayL = 0.1
		
	if Input.is_action_just_pressed("Rclick"):
		delayR = 0.1
	
	if delayL > 0: delayL -= delta
	
	if delayR > 0: delayR -= delta

	if touching_ev != null:
		if delayL > 0 && touching_ev.elev < touching_ev.elev_max:
			target_ypos -= 60 * touching_ev.jump
			touching_ev.elev += 1 * touching_ev.jump
			delayL = 0
			$ev.play()
		if delayR > 0 && touching_ev.elev > touching_ev.elev_min:
			target_ypos += 60 * touching_ev.jump
			touching_ev.elev -= 1 * touching_ev.jump
			delayR = 0
			$ev.play()
		
	if delayL > 0 && touching_door != null:
		if touching_door.is_target == true:
			touching_door.got_delivery()
			touching_door = null
			curLoad -= 1
			change_load(curLoad)
			got_score.emit()
			$whoosh.play()
		delayL = 0
		
	if delayL > 0 && touching_truck != null:
		if touching_truck.is_target == true:
			touching_truck.got_delivery()
			touching_truck = null
			if succession < 2:
				succession += 1
				curLoad += 3 + succession
				change_load(curLoad)
			else:
				movable = false
				$Sprites.visible = false
		delayL = 0
		
	if door_empty_delay >= 0 && door_empty_delay < 1:
		door_empty_delay -= delta
	elif door_empty_delay < 0:
		touching_door = null

func change_load(load_num):
	if load_num == 0:
		$Sprites/Boxstack.set_texture(box_stack0)
	elif load_num == 1:
		$Sprites/Boxstack.set_texture(box_stack1)
	elif load_num == 2:
		$Sprites/Boxstack.set_texture(box_stack2)
	elif load_num == 3:
		$Sprites/Boxstack.set_texture(box_stack3)
	elif load_num == 4:
		$Sprites/Boxstack.set_texture(box_stack4)
	elif load_num == 5:
		$Sprites/Boxstack.set_texture(box_stack5)

func _on_timer_timeout():
	movable = true
