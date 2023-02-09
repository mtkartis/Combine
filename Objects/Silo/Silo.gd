class_name Silo
extends StaticBody2D

var hopper = Hopper.new()

func _ready():
	hopper.fill = Vector2(0, 1000)
