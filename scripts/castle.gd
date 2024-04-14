extends StaticBody2D
signal game_over()

const max_health = 1000
var current_health = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func deal_damage(damage):
	# print("hier")
	current_health -= damage
	$HealthDisplay.update_healthbar(current_health)
	if current_health < 0:
		game_over.emit()
		queue_free()
