class_name CropDisplay
extends Node
#constants

#variables
var hopper setget set_hopper
var silo setget set_silo
#objects onready
onready var hopper_amount = $VBoxContainer/Hopper/Amount
onready var silo_amount = $VBoxContainer/Silo/Amount
#signals

#-------------------------------FUNCTIONS---------------------------------------
func _ready():
	self.hopper = 0
	self.silo = 0

func set_hopper(new_value:int):
	hopper = new_value
	hopper_amount.set_text(str(hopper))

func set_silo(new_value:int):
	silo = new_value
	silo_amount.set_text(str(silo))

#-------------------------------AFFERENT SIGNALS--------------------------------
