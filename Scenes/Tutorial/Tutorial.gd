#class_name 
extends Node
#constants

#variables
var tutorial_array = []
var tutorial_index = 0
#objects onready
onready var intro = $Intro
onready var wheat = $Wheat
onready var squish = $Squish
onready var silo = $Silo
onready var deposit = $Deposit
onready var wrap = $Wrap
onready var left = $Controls/Left
onready var right = $Controls/Right
#signals

#-------------------------------FUNCTIONS---------------------------------------
func _ready():
	tutorial_array = [
	$Intro, 
	$Wheat, 
	$Squish, 
	$Silo, 
	$Deposit, 
	$Wrap
]

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("LEFT"):
			advance(false)
		if Input.is_action_just_pressed("RIGHT"):
			advance(true)

func advance(dir:bool):
	match dir:
		false:
			#left
			if tutorial_index != 0:
				tutorial_index -= 1
		true:
			#right
			if tutorial_index < 5:
				tutorial_index += 1
			elif tutorial_index == 5:
				get_tree().change_scene("res://Scenes/Field/Field.tscn")

	for i in tutorial_array:
		i.visible = false
	tutorial_array[tutorial_index].visible = true
	if tutorial_index != 0:
		left.visible = true
	else:
		left.visible = false
	
#-------------------------------AFFERENT SIGNALS--------------------------------
