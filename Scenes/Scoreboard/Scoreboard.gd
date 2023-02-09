#class_name 
extends Node
#constants

#variables
var reveal_order = null
var finished = false
#objects onready
onready var timer = $Timer
onready var score_amt = $MarginContainer/VBoxContainer2/VBoxContainer/Score/Amount
#signals
signal revealed
#-------------------------------FUNCTIONS---------------------------------------
func _ready():
	reveal_order = [
	$MarginContainer/VBoxContainer2/VBoxContainer/Score/Name,
	$MarginContainer/VBoxContainer2/VBoxContainer/Score/Amount,
	$MarginContainer/VBoxContainer2/Label
]
	score_amt.set_text(str(Global.wheat))
	reveal()

func reveal():
	timer.start()
	for i in reveal_order:
		i.visible = true
		yield(self, "revealed")
	finished = true
	$CPUParticles2D.visible = true
	$CPUParticles2D2.visible = true
	$MarginContainer/VBoxContainer2/Label2
	timer.stop()
	timer.wait_time = 30
	timer.start()

#-------------------------------AFFERENT SIGNALS--------------------------------
func _on_Timer_timeout():
	if finished:
		get_tree().change_scene("res://Scenes/Tutorial/Tutorial.tscn")
	else:
		emit_signal("revealed")
	
