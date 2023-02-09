#class_name 
extends Node
#constants
enum {OFF, ON}
#variables
var time = 0.25
var state = OFF
#objects onready
onready var image = $Image
onready var timer =$Timer

#signals

#-------------------------------FUNCTIONS---------------------------------------
func _process(_delta):
	match state:
		OFF:
			timer.stop()
			image.visible = false
		ON:
			if timer.is_stopped():
				timer.start()
				timer.wait_time = time
#-------------------------------AFFERENT SIGNALS--------------------------------


func _on_Timer_timeout():
	image.visible = !image.visible
	state = OFF
