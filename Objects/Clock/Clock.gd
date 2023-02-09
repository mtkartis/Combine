class_name Clock
extends Node
#constants

#variables
export(float) var clock_time setget set_clock

#objects onready
onready var timer = $Timer
onready var display = $Text
#signals
signal done
#-------------------------------FUNCTIONS---------------------------------------
func _process(_delta):
	var gross_seconds = timer.time_left
	var net_time = gross_seconds/60
	var net_minutes = floor(net_time)
	var net_seconds = (net_time - net_minutes) * 60
	
	display.set_text(str(net_minutes) + ":" + str(stepify(net_seconds, 1)))

func set_clock(value:float):
	self.timer.wait_time = value

func start_clock():
	timer.start()
	
#-------------------------------AFFERENT SIGNALS--------------------------------
func _on_Timer_timeout():
	get_tree().paused = true
	emit_signal("done")
