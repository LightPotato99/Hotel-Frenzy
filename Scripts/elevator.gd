extends Area2D

@export var elev_min = 1
@export var elev_max = 5
@export var start_elev = 1
@export var jump = 1
var elev = 1

func _ready():
	elev = start_elev

func _process(delta):
	var distY = Vector2(global_position.x, elev * -60 + 60)
	global_position = lerp(global_position, distY, delta * 30)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.touching_ev = self

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.touching_ev = null
