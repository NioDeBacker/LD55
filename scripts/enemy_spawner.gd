extends Node2D

var count = 0
var rng = RandomNumberGenerator.new()

func _ready():
	Global.enemy_hit.connect(_on_Enemy_Hit) # Replace with function body.

func _on_Enemy_Hit():
	if count > 0:
		count -= 1
		
func _on_timer_timeout():
	# only spawn chance when score lower than
	var number = rng.randf_range(0.0, 100 - Global.score)

	if count <= Global.score && number < 50.0:
		var enemy = $spawner.spawn_character()
		if Global.score > 50:
			enemy.max_health += Global.score
			enemy.current_health += Global.score
			enemy.damage += 10
		count += 1
	 # Replace with function body.
