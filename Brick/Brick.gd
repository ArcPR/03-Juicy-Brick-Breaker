extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

#func _ready():
#	randomize()
#	position = new_position


var colors = [
	Color8(224,49,49)
	,Color8(255,146,43)
	,Color8(255,212,59)
	,Color8(148,216,45)
	,Color8(34,139,230)
	,Color8(132,94,247)
	,Color8(190,75,219)
	,Color8(134,142,150)
]
var color_index = 0
var color_distance = 0
var color_completed = true
var color_initial_position = Vector2.ZERO
var color_randomizer = Vector2.ZERO

func _ready():
	randomize()
	position.x = new_position.x
	position.y = -100
	if score >= 100: color_index = 0
	elif score >= 90: color_index = 1
	elif score >= 80: color_index = 2
	elif score >= 70: color_index = 3 
	elif score >= 60: color_index=  4
	elif score >= 50: color_index = 5
	elif score >= 40: color_index = 6
	else: color_index = 7
	$ColorRect.color = colors[color_index]
	color_initial_position = $ColorRect.rect_position
	color_randomizer = Vector2(randf()*6-3.0, randf()*6-3.0)



func _physics_process(_delta):
	if dying:
		queue_free()

func hit(_ball):
	die()

func die():
	dying = true
	collision_layer = 0
	$ColorRect.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instance()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
