extends Node2D

signal mana_used(mana_used: int)

const special_tresh = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position = get_global_mouse_position()
	self.global_position = Vector2(mouse_position)
	var mana_left = get_parent().mana
	if mana_left > special_tresh:
		$Special.visible = true


	
func _input(event):
	var mana_left = get_parent().mana
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			if mana_left > 20:
				var minion = $spawner.spawn_character()
				mana_used.emit(5)
				minion.global_position = self.global_position
	if event is InputEventKey:
		if event.as_text_keycode() == "F" && mana_left  > special_tresh:
			var big_minion = $spawner2.spawn_character()
			mana_used.emit(special_tresh)
			$Special.visible = false
			big_minion.global_position = self.global_position
			big_minion.max_health = 300
			big_minion.get_child(0).modulate = Color(0, 1, 0)
			big_minion.current_health = 300
			big_minion.SPEED = 30.0
			big_minion.damage = 80
