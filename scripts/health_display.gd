extends Node2D

var bar_green = preload("res://assets/health_good.png")
var bar_orange = preload("res://assets/health_medium.png")
var bar_red = preload("res://assets/health_bad.png")

@onready var healthbar = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	# hide()
	if get_parent() and get_parent().get("max_health"):
		healthbar.max_value = get_parent().max_health # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0

func update_healthbar(value):
	healthbar.texture_progress = bar_green
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_orange
	if value < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	if value < healthbar.max_value:
		show()
	healthbar.value = value
