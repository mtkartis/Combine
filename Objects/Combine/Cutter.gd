class_name Cutter
extends Area2D


signal harvest
#-------------------------------------------------------------------------------
func _process(_delta):
	var collisions = get_overlapping_areas()
	if !collisions.empty():
		for i in collisions:
			if i is Crop:
				if i.standing:
					emit_signal("harvest", i)
