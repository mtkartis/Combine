#class_name 
extends ColorRect
#constants
enum {TRANS, DARK}
#variables
var status = TRANS setget fade
#objects onready

#signals
signal faded
#-------------------------------FUNCTIONS---------------------------------------
func _process(_delta):
	match status:
		DARK:
			if color.a <= 1:
				color.a += 0.01
			else:
				emit_signal("faded")
		TRANS:
			if color.a > 0:
				color.a -= 0.01
			else:
				emit_signal("faded")

func fade(new_state:int):
	status = new_state

#-------------------------------AFFERENT SIGNALS--------------------------------
func _on_Clock_done():
	self.status = DARK
	yield(self, "faded")
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Scoreboard/Scoreboard.tscn")
